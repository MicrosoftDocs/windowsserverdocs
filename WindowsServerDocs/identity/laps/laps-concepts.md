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

This article provides information about the basic design and security concepts that Windows LAPS is based on.

## Architecture diagram

:::image type="content" source="../laps/media/laps-concepts/laps-concepts-architecture-diagram.PNG" alt-text="Diagram of Windows LAPS architecture showing the managed device, Azure Active Directory, and Windows Server Active Directory.":::

The above picture has many moving parts - let's break it down piece by piece.

IT admin: this entity represents collectively the various IT admin roles that may be involved in a Windows LAPS deployment. The IT admin roles are involved with policy configuration, expiration or retrieval of stored passwords, and interacting with managed devices.

Managed device: this entity is the Azure Active Directory-joined or Windows Server Active Directory-joined device on which we want to manage a local administrator account. The feature is composed of a few key binaries: laps.dll (core logic), lapscsp.dll (Configuration Service Provider logic), and lapspsh.dll (PowerShell cmdlet logic). Windows LAPS may also be configured using Group Policy and will respond to GPO change notifications. The managed device may also be a Windows Server Active Directory domain controller, which can be configured to back up DSRM account passwords.

Windows Server Active Directory: this entity is your on-premises Windows Server Active Directory deployment.

Azure Active Directory: this entity is Azure Active Directory running in the cloud.

Microsoft Endpoint Manager: this entity is the preferred Microsoft device policy management solution, also running in the cloud.

## Basic Windows LAPS scenario flow

The IT admin must first configure the Windows LAPS policy as desired. The preferred policy configuration option is [Microsoft Endpoint Manager](/mem/endpoint-manager-overview) for Azure Active Directory-joined devices or hybrid Azure Active Directory-joined devices that are enrolled with Microsoft Endpoint Manager, or Group Policy for Windows Server Active Directory-joined devices.

After the managed device has been configured with a policy that enables Windows LAPS, the device will start to manage the configured local account's password. Whenever the password has expired, the device will generate a random new password that is compliant with the current policy's length and complexity settings, and validated against the local device's password complexity policy. Once the password is validated, the device stores it in the configured directory (either Windows Server Active Directory or Azure Active Directory). An associated password expiration time (based on the current policy's password age setting) is also computed and stored in the directory. The device will rotate this password automatically once the password expiration time has been reached.

Once the password has been stored in the directory (again, either in Azure Active Directory
 or Windows Server Active Directory), it may then be accessed by an authorized IT admin. Passwords stored in Azure Active Directory are secured via a role based access control model. Passwords stored in Windows Server Active Directory are secured via ACLs, and optionally also via password encryption.

The password may also be rotated prior to the normally expected expiration time. Earlier-than-scheduled password rotations can be accomplished via various ways:

* Manual admin intervention on the managed device itself (for example, using the `Reset-LapsPassword` cmdlet).
* Invoking the ResetPassword Execute action in the [Windows LAPS CSP](/windows/client-management/mdm/laps-csp).
* Modification of the password expiration time in the directory (applies to Windows Server Active Directory only).
* Automatic rotation after the managed account is used to authenticate to the managed device.

## Background policy processing cycle

Windows LAPS uses a background task that wakes up every hour to process the currently active policy. Note, this task isn't implemented using Windows Task Scheduler. Whenever the background task runs, it executes the following basic flow:

:::image type="content" source="../laps/media/laps-concepts/laps-concepts-processing-cycle.png" alt-text="Flowchart describing the Windows LAPS background processing cycle.":::

The obvious key difference between the Azure Active Directory and Windows Server Active Directory flows is related to how the password expiration time is checked. In both scenarios, the password expiration time is stored side-by-side with the latest password in the directory. In the Azure Active Directory scenario, the managed device doesn't perform polling of Azure Active Directory instead, the current password expiration time is maintained locally on the device. In the Windows Server Active Directory scenario, the managed device will regularly poll the directory to query the password expiration time and will act once it has expired.

Windows LAPS does respond to Group Policy change notifications - so one manual way to kick off the policy processing cycle is by forcing a Group Policy refresh, for example:

```text
gpupdate.exe /target:computer /force
```

A better (more scoped) way to kick off the policy processing cycle is by running the `Initiate-LapsPolicyProcessing` cmdlet.

> [!TIP]
> Legacy LAPS was built as a Group Policy Client Side Extension (CSE). GPO CSEs are loaded and invoked every time there's a Group Policy refresh cycle, therefore the frequency of the legacy LAPS  polling cycle is the same as the frequency of the GP refresh cycle. Windows LAPS is not built as a CSE, so its polling cycle is hardcoded (once per hour) and is unaffected by the Group Policy refresh cycle.

## Azure Active Directory concepts

When backing up passwords to Azure Active Directory, managed local account passwords are stored on the Azure Active Directory device object. Windows LAPS authenticates to Azure Active Directory using the device identity of the managed device. Data stored in Azure Active Directory is highly secure, but for extra protection the password is further encrypted prior to being persisted. This extra encryption layer is removed before the password is returned to authorized clients.

By default retrieval of the clear-text password is limited to members of the Global Administrator, Cloud Device Administrator, and Intune Administrator roles.

## Windows Server Active Directory concepts

### Windows Server Active Directory password security

When backing up passwords to Windows Server Active Directory, managed local account passwords are stored on the computer object. These passwords are secured using two mechanisms. The first line of security is the Windows Server Active Directory access control lists (ACLs) that are configured on the computer object's containing Organizational Unit (OU), and then inherited onto the computer object itself. You can specify who can read the various password attributes using the `Set-LapsADReadPasswordPermission` cmdlet. (Similarly, you can specify who can read and set the password expiration time attribute using the `Set-LapsADResetPasswordPermission` cmdlet.)

The second line of password security uses the Windows Server Active Directory password encryption feature. Windows Server Active Directory password encryption does require that your domain is running at Windows Server 2016 Domain Functional Level (DFL) or later. Once enabled, the password is first encrypted so that only a specific security principal (a group or user) is able to decrypt it. The encryption of the password occurs on the managed device itself prior to sending the password to the directory.

> [!IMPORTANT]
> Microsoft highly recommends that you enable password encryption when storing your Windows LAPS passwords in Windows Server Active Directory.

> [!IMPORTANT]
> Microsoft does not support retrieval of previously decrypted LAPS passwords in a domain which has been configured below Windows Server 2016 Domain Functional Level (DFL). The operation may or may not succeed depending if domain controllers older than Windows Server 2016 have been promoted into the domain.

Consider the following diagram when designing your password retrieval security model:

:::image type="content" source="../laps/media/laps-concepts/laps-concepts-password-security-layers.png" alt-text="Diagram showing the Windows LAPS password security layers.":::

This diagram illustrates the suggested Windows Server Active Directory password security layers and how you should think about their relationship to each other.

The outermost circle is composed of those security principals that have been granted permission to read or set the password expiration time attribute on computer objects in the directory. This ability is a sensitive permission but is considered non-destructive (an attacker who acquires this permission can force managed devices to rotate their managed devices more frequently).

The middle circle is composed of those security principals that have been granted permission to read or set the password attribute(s) on computer objects in the directory. This ability is a sensitive permission and should be carefully monitored. The most secure approach is to reserve this level of permission for Domain Admins.

The inner circle is only applicable when password encryption is enabled. It's composed of those groups (or users) that have been granted decryption permissions for the encrypted password attribute(s) on computer objects in the directory. As with the middle circle, this ability is a sensitive permission and should be carefully monitored. The most secure approach is to reserve this level of permission for Domain Admins.

> [!IMPORTANT]
> Consider customizing the above security layers differently depending on the sensitivity of the machines being managed. For example, it may be acceptable for front line IT worker devices to be accessible by help-desk administrators, but you will likely want to set tighter boundaries for corporate executive laptops.

### Windows Server Active Directory password encryption details

The Windows LAPS password encryption feature is based on [CNG DPAPI](/windows/win32/seccng/cng-dpapi). CNG DPAPI supports multiple encryption modes, but Windows LAPS only supports encrypting passwords against a single Windows Server Active Directory security principal (user or group). The underlying encryption is based on AES256.

The ADPasswordEncryptionPrincipal policy setting can be used to specify a specific security principal for encrypting the password. If ADPasswordEncryptionPrincipal isn't specified, Windows LAPS will encrypt the password against the Domain Admins group of the managed device's domain. Prior to encrypting a password, the managed device will always verify that the specified user or group is resolvable.

> [!TIP]
> Windows LAPS only supports encrypting passwords against a single security principal. CNG DPAPI does support encryption against multiple security principals, but this mode is not supported by Windows LAPS because it causes size bloat of the encrypted password buffers. If you need to grant decryption permissions to multiple security principals, one workaround is to create a wrapper group that has all of those security principals as members.

> [!TIP]
> The security principal authorized to decrypt the password cannot be changed once a password is encrypted.

### Windows Server Active Directory encrypted password history

Windows LAPS supports a password history feature for Windows Server Active Directory domain-joined clients and domain controllers. Password history is only supported when password encryption has been enabled. Password history isn't supported when storing clear-text passwords in Windows Server Active Directory.

When encrypted password history is enabled and it's time to rotate the password, the managed device will first read the current version of the encrypted password from Active Directory. The current password is then added to the password history, deleting older versions in the history as needed to comply with the configured max-history limitation.

> [!TIP]
> In order for the password history feature to work, the managed device must be granted SELF permission to read the current version of the encrypted password from Active Directory. This requirement is handled automatically for you when you run the `Set-LapsADComputerSelfPermission` cmdlet.

> [!IMPORTANT]
> Microsoft recommends that managed devices are never granted permission to decrypt encrypted passwords (whether their own or any other device's encrypted passwords).

### Windows Server Active Directory DSRM password support

Windows LAPS supports backing up the Directory Services Repair Mode (DSRM) account password on Windows Server domain controllers. DSRM account passwords can only be backed up to Windows Server Active Directory (backing up DSRM passwords to Azure Active Directory isn't supported), and also requires that password encryption is enabled. Otherwise this feature works almost identically to how encrypted password support works for Windows Server Active Directory-joined clients.

> [!IMPORTANT]
> When DSRM password backup is enabled, the current DSRM password for any domain controller is retrievable as long at least one domain controller in that domain is accessible.
>
> However, consider a catastrophic situation where all of the domain controllers in a given domain are down. None of the DSRM passwords will be available. For this reason, Microsoft recommends using Windows LAPS DSRM support as only the first component of a larger domain backup and recovery strategy. It is strongly recommended that the DSRM passwords be regularly extracted from the directory, and then backed up to a secure store outside of Windows Server Active Directory. Such an external store backup strategy is  outside of the scope of Windows LAPS.

## Password reset after authentication

Windows LAPS supports automatically rotating the password after detecting that the local administrator account was used for authentication. This feature is intended to bound the amount of time that the clear-text password is usable. A grace period can be configured to give the person time to complete the intended actions.

## Account password tampering protection

Once Windows LAPS has been configured to manage a local administrator account's password, that account will be protected against accidental and/or careless tampering. This protection also extends to the DSRM account when it's being managed by Windows LAPS on a Windows Server Active Directory domain controller.

## Disabled during safe-mode

Windows LAPS is disabled (no passwords will be backed up) whenever Windows is booted into safe mode, DSRM mode, or any other non-default boot mode.

## Next steps

Now that you're aware of the basic concepts that Windows LAPS is designed around, get started by checking out the [scenario guides](..\laps\laps-scenarios.md).

## See also

[Windows LAPS Scenario guides](../laps/laps-scenarios.md)

[Legacy LAPS](https://www.microsoft.com/download/details.aspx?id=46899).

[CNG DPAPI](/windows/win32/seccng/cng-dpapi)

[Microsoft Endpoint Manager](/mem/endpoint-manager-overview)
