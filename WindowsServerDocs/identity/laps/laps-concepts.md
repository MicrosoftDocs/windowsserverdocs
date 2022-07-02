---
ms.assetid: d6eedab8-541e-4ff9-bea9-46e1dc794f5d
title: Local Administrator Password Solution Concepts
description: Local Administrator Password Solution Concepts
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Concepts

## Concepts

This article provides information about the basic design and security concepts that Windows LAPS is based on.

### Architecture diagram

:::image type="content" source="../laps/laps-concepts-architecture-diagram.PNG" alt-text="Windows LAPS Architecture Diagram":::

The above picture has many moving parts - let's break it down piece by piece.

<ins>IT admin</ins>: this entity represents collectively the various IT admin roles that may be involved in a Windows LAPS deployment. The IT admin roles are involved with policy configuration, expiration or retrieval of stored passwords, and interacting with managed devices.

<ins>Managed device:</ins> this entity is the Azure AD-joined or AD-joined device on which we want to manage a local administrator account. The feature is composed of a few key binaries: laps.dll (core logic), lapscsp.dll (Configuration Service Provider logic), and lapspsh.dll (PowerShell cmdlet logic). Windows LAPS may also be configured using Group Policy and will respond to GPO change notifications. The managed device may also be an AD domain controller.

<ins>Active Directory:</ins> this entity is your on-premises Active Directory deployment.

<ins>Azure Active Directory</ins>: this entity is Azure AD running in the cloud.

<ins>Microsoft Endpoint Manager</ins>: this entity is the preferred Microsoft device policy management solution, also running in the cloud.

### Basic Windows LAPS use case flow

The IT admin must first configure the Windows LAPS policy as desired. The preferred policy configuration option is [Microsoft Endpoint Manager](https://docs.microsoft.com/mem/endpoint-manager-overview) for Azure AD-joined devices, or Group Policy for AD-joined devices.

After the managed device has been configured with a policy that enables Windows LAPS, the device will start to manage the configured local account's password. Whenever the password has expired, the device will generate a random new password that is compliant with the current policy's length and complexity settings, and validated against the local device's password complexity policy. Once the password is validated, the device stores it in the configured directory (either AD or Azure AD). An associated password expiration time (based on the current policy's password age setting) is also computed and stored in the directory. The device will rotate this password automatically once the password expiration time has been reached.

Once the password has been stored in the directory (again, either AD or Azure AD), it may then be accessed by an authorized IT admin. Passwords stored in Active Directory are secured via Active Directory ACLs, and optionally also password encryption. Passwords stored in Azure AD are secured via a role based access control model.

The password may also be rotated prior to the normally expected expiration time. Earlier-than-scheduled password rotations can be accomplished via various ways:

* Manual admin intervention on the managed device itself (for example, using the `Reset-LapsPassword` cmdlet).
* Invoking the ResetPassword Execute action in the [LAPS CSP](https://docs.microsoft.com/windows/client-management/mdm/laps-csp).
* Modification of the password expiration time in the directory (applies to Active Directory only).
* Automatic rotation after the managed account is used to authenticate to the managed device.

### Background policy processing cycle

Windows LAPS uses a background task that wakes up every hour to process the currently active policy. Note, this task isn't implemented using Windows Task Scheduler. Whenever the background task runs, it executes the following basic flow:

:::image type="content" source="../laps/laps-concepts-processing-cycle.png" alt-text="Windows LAPS Background Processing Cycle":::

The obvious key difference between the AD and Azure AD flows is related to how the password expiration time is checked. In both scenarios, the password expiration time is stored side-by-side with the latest password in the directory. In the AD scenario, the managed device will regularly poll AD to query the password expiration time and will act once it has expired. In the AD scenario, the managed device doesn't perform polling of Azure AD; instead, the current password expiration time is maintained locally on the device.

Windows LAPS does respond to Group Policy change notifications - so one manual way to kick off the policy processing cycle is by forcing a Group Policy refresh, for example:

```text
gpupdate.exe /target:computer /force
```

A better (more scoped) way to kick off the policy processing cycle is by running the `Initiate-LapsPolicyProcessing` cmdlet.

> [!TIP]
> Legacy LAPS was built as a Group Policy Client Side Extension (CSE). GPO CSEs are loaded and invoked every time there's a GP refresh cycle, so the frequency of the legacy LAPS AD polling cycle was the same as the frequency of the GP refresh cycle. Windows LAPS is not built as a CSE, so its AD polling cycle is hardcoded (once per hour) and is unaffected by the GP refresh cycle.

### Azure AD password security

When backing up passwords to Azure AD, managed local account passwords are stored on the Azure AD device object. For extra protection, the password is encrypted prior to being persisted. Windows LAPS authenticates to Azure AD using the Azure AD device identity of the managed device.

By default retrieval of the clear-text password is limited to members of the Global Admins, Device Admins, and Intune Admins roles.

### Active Directory password security

When backing up passwords to Active Directory, managed local account passwords are stored on the computer object. These passwords are secured using two mechanisms. The first line of security is the Active Directory access control lists (ACLs) that are configured on the computer object's containing Organizational Unit (OU), and then inherited onto the computer object itself. You can specify who can read the various password attributes using the `Set-LapsADReadPasswordPermission` cmdlet. (Similarly, you can specify who can read and set the password expiration time attribute using the `Set-LapsADResetPasswordPermission` cmdlet.)

The second line of password security uses the AD password encryption feature. AD password encryption does require that your Active Directory domain is running at Windows Server 2016 Domain Functional Level (DFL) or later. Once enabled, the password is first encrypted so that only a specified group (or user) is able to decrypt it. This encryption process happens on the managed device itself prior to sending the password to Active Directory.

> [!IMPORTANT]
> Microsoft highly recommends that you enable password encryption when storing your Windows LAPS passwords in Active Directory.

Consider the following diagram when designing your password retrieval security model:

:::image type="content" source="../laps/laps-concepts-password-security_layers.png" alt-text="Windows LAPS AD Password Security Layers":::

This diagram illustrates the suggested AD password security layers and how you should think about their relationship to each other.

The outermost layer is composed of those groups (or users) that have been granted permission to read or set the password expiration time attribute on computer objects in AD. This ability is a sensitive permission but is considered non-destructive (an attacker who acquires this permission can force managed devices to rotate their managed devices more frequently).

The middle layer is composed of those groups (or users) that have been granted permission to read or set the password attribute(s) on computer objects in AD. This ability is a sensitive permission and should be carefully monitored. The most secure approach is to reserve this level of permission for Domain Admins.

The inner layer is only applicable when AD password encryption is enabled. It's composed of those groups (or users) that have been granted decryption permissions for the encrypted password attribute(s) on computer objects in AD. Like with the middle layer, this ability is a sensitive permission and should be carefully monitored. The most secure approach is to reserve this level of permission for Domain Admins.

Finally, consider customizing the above layers differently depending on the sensitivity of the machines being managed. For example, it may be acceptable for front line IT worker devices to be accessible by help-desk administrators, but you may want to set tighter boundaries for corporate executive laptops.

### Next steps

Now that you're aware of the basic concepts that Windows LAPS is designed around, get started by checking out the [scenario guides](..\laps\laps-scenarios.md).

## Related articles

[LAPS Scenario guides](..\laps\laps-scenarios.md)

[Legacy LAPS](https://www.microsoft.com/download/details.aspx?id=46899).
