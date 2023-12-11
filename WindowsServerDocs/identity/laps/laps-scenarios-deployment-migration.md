---
title: Get started with Windows LAPS deployment and migration scenarios
description: Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) deployment and migration scenarios.
author: jay98014
ms.author: jsimmons
ms.date: 05/15/2023
ms.topic: conceptual
---

# Get started with Windows LAPS during deployment and migration scenarios

There are many possible methods of deploying Windows LAPS, or migrating from legacy LAPS to Windows LAPS. This article outlines the basic scenarios along with tips and tricks to be aware of.

When you're migrating existing hybrid-joined devices from legacy LAPS to Windows LAPS, it is your choice whether to continue storing the passwords in Active Directory or to switch to storing the passwords in Microsoft Entra ID.

## Directory preparation

Most of the content in this guide isn't directory specific. There are however some preparatory steps required to enable your directory (either Active Directory or Microsoft Entra ID) to support Windows LAPS devices. These steps should be followed first before proceeding to implement any of the other scenarios described in this article.

### Preparing Windows Server Active Directory

The following steps should be followed before configuring your Active Directory-joined or hybrid-joined devices to back up a managed account's passwords to Active Directory.

1. Extend your AD schema to support Windows LAPS. See [Update the Windows Server Active Directory schema](laps-scenarios-windows-server-active-directory.md#update-the-windows-server-active-directory-schema).
1. If you're using a GPO Central Store, manually copy the Windows LAPS Group Policy template files to the central store. See [GPO Central Store](laps-management-policy-settings.md#group-policy-object-central-store).
1. Assign device self-write permissions. See [Grant the managed device permission to update its password](laps-scenarios-windows-server-active-directory.md#grant-the-managed-device-permission-to-update-its-password).
1. Analyze, determine, and configure the appropriate AD permissions for password expiration and password retrieval. See [Windows Server Active Directory passwords](laps-concepts.md#windows-server-active-directory-passwords).
1. Analyze and determine the appropriate authorized groups for decrypting passwords. See [Windows Server Active Directory passwords](laps-concepts.md#windows-server-active-directory-passwords).
1. Create a new Windows LAPS policy that targets the managed device(s) with the appropriate settings as determined in the previous steps.

> [!TIP]
> If you are planning to only backup passwords to Microsoft Entra ID, you do not need to perform any of these steps, including extending the AD schema.

<a name='preparing-azure-active-directory'></a>

### Preparing Microsoft Entra ID

The following steps should be followed before configuring your Microsoft Entra joined or hybrid-joined devices to back up a managed account's passwords to Microsoft Entra ID.

1. Review the membership of the built-in Microsoft Entra roles that have by-default access to Windows LAPS passwords stored in Microsoft Entra ID. By default these roles are highly privileged so there should be no surprises in this step.
1. Enable your Microsoft Entra tenant to support Windows LAPS password backup. See [Enabling Windows LAPS with Microsoft Entra ID](/azure/active-directory/devices/howto-manage-local-admin-passwords#enabling-windows-laps-with-azure-ad).

## New OS install scenario with a Windows LAPS policy

Windows LAPS is built into the Windows operating system. It's a Windows baseline security feature and can't be uninstalled. It's important therefore to be aware of the effect that a Windows LAPS policy may have during a new OS install.

The primary factor to be aware of is that Windows LAPS is always "on". As soon as a Windows LAPS policy is applied to the device, Windows LAPS immediately begins to enforce the policy. This behavior can cause disruptions if at some point your OS deployment workflow involves domain-joining a device into an OU with an enabled Windows LAPS policy. If the Windows LAPS policy targets the same local account that the deployment workflow is logged in with, the resultant immediate modification of the local account password will likely break the workflow (for example after a reboot during automatic sign-in).

The first technique to mitigate this issue is to use a clean "staging" Organizational Unit (OU). A staging OU is considered a temporary home for the device's account that applies a bare minimum set of required policies, and shouldn't apply a Windows LAPS policy. Only at the conclusion of the OS deployment workflow is the device's account is moved to its final destination OU. Microsoft recommends the use of a clean staging OU as a generic best practice.

A second technique is to configure the Windows LAPS policy to target a different account than the one used by the OS deployment workflow. As a best practice any local accounts that are unneeded at the end of the OS deployment workflow should be deleted.

## New OS install scenario with a legacy LAPS policy

This scenario has the same basic concerns as [New OS install scenario with a Windows LAPS policy](laps-scenarios-deployment-migration.md#new-os-install-scenario-with-a-windows-laps-policy), but has some special issues related to Windows LAPS' support for legacy LAPS emulation mode.

Again, the primary factor to be aware of is that Windows LAPS is always "on". As soon as a legacy LAPS policy is applied to the device - and assuming all [legacy LAPS emulation mode](laps-scenarios-legacy.md) criteria are met - Windows LAPS immediately begins to enforce the policy. This behavior can cause disruptions if at some point your OS deployment workflow involves domain-joining a device into an OU with an enabled legacy LAPS policy. If the legacy LAPS policy targets the same local account that the deployment workflow is logged in with, the resultant immediate modification of the local account password will likely break the workflow (for example after a reboot during automatic sign-in).

The first technique to mitigate this issue is to use a clean "staging" Organizational Unit (OU). A staging OU is considered a temporary home for the device's account that applies a bare minimum set of required policies, and shouldn't apply a legacy LAPS policy. Only at the conclusion of the OS deployment workflow is the device's account is moved to its final destination OU. Microsoft recommends the use of a clean staging OU as a generic best practice.

A second technique is to configure the legacy LAPS policy to target a different account than the one used by the OS deployment workflow. As a best practice any local accounts that are unneeded at the end of the OS deployment workflow should be deleted.

A third technique is to [Disable legacy LAPS emulation mode](laps-scenarios-legacy.md#disabling-legacy-microsoft-laps-emulation-mode) at the beginning of the OS deployment workflow, and enable it (if needed) at the end of the OS deployment workflow.

## Coexistence (side-by-side) scenario with legacy LAPS

It's possible to use both Windows LAPS and legacy LAPS in a side-by-side scenario. For the side-by-side scenario to be successful, both policies MUST target different local accounts. Your long term goal however should be to migrate away from legacy LAPS to Windows LAPS.

## Migration scenarios from legacy LAPS to Windows LAPS on existing devices

Microsoft recommends migrating from legacy LAPS to Windows LAPS. This section describes procedures for accomplishing that migration on existing devices.

There are two basic approaches that can be used. The first approach is an immediate transition, while the second approach uses a period of side-by-side coexistence followed by a final transition.

### Immediate transition approach

You can immediately migrate from legacy LAPS to Windows LAPS on existing devices using the following steps:

1. Disable\remove the legacy LAPS policy
1. Create and apply a Windows LAPS policy
1. Monitor the managed device to confirm a successful transition
1. Remove the legacy LAPS software

The first two steps should be performed simultaneously (or as nearly so as possible).

The easiest approach when configuring the Windows LAPS policy is to target the same account that was previously targeted in the legacy LAPS policy. If you choose to target a different account, then it's your responsibility to create the new account prior to applying the Windows LAPS policy. The first account should be removed if no longer needed.

The Windows LAPS policy may also be configured with features (backup to Microsoft Entra ID, or enable AD password encryption) that weren't available in the legacy LAPS software.

When a Windows LAPS policy is first applied, the managed device performs an immediate rotation of the local account password. You should [monitor](laps-scenarios-deployment-migration.md#monitoring-a-successful-transition) the managed device to ensure the transition has completed successfully.

Once the transition has completed, the final step should be to [remove the legacy LAPS software from the managed device](laps-scenarios-deployment-migration.md#removing-the-legacy-laps-software-from-a-managed-device).

### Transient side-by-side coexistence approach

You may want to implement a more gradual migration procedure from legacy LAPS to Windows LAPS. The basic steps to perform this transition on existing devices are as follows:

1. Configure the managed device with a second local account
1. Create and apply a Windows LAPS policy
1. Monitor the managed device to confirm a successful application of the Windows LAPS policy
1. Disable\remove the legacy LAPS policy
1. Remove the legacy LAPS software
1. Remove the extra account

With this approach, it's necessary to create a second local account since it's not supported to have both a Windows LAPS policy and legacy LAPS policy targeting the same account.

After confirming that Windows LAPS is working properly, you may leave the managed device in this state for as long as needed before performing the rest of the migration steps.

## Monitoring a successful transition

There are multiple approaches to monitoring for a successful outcome once you have transitioned a managed device to a Windows LAPS policy:

- You can monitor the managed device's [Windows LAPS event log channel](laps-management-event-log.md) for successful password update events (for either Microsoft Entra ID or AD). A centralized event log collection solution may help here.
- When storing passwords in Active Directory, you can look for the appearance of a new\updated msLAPS-PasswordExpirationTime attribute on the managed device's AD computer object. The [`Get-LapsADPassword`](/powershell/module/laps/get-lapsadpassword) PowerShell cmdlet can be used to automate this analysis.
- When storing passwords in Microsoft Entra ID, you can check the Microsoft Entra ID or Intune management portals to verify that the device has updated its password. The [`Get-LapsAADPassword`](/powershell/module/laps/get-lapsaadpassword) PowerShell cmdlet can be used to automate this analysis.

## Removing the legacy LAPS software from a managed device

The specific steps required to remove the legacy LAPS software from the managed device depend on how that software was initially installed.

### If you installed legacy LAPS using the MSI installer package

In this situation, you can manually uninstall the legacy LAPS software from the control panel for ad-hoc management scenarios.

Alternatively you can also automate this process with a silent MSI uninstall command run on the managed device:

```text
C:\>msiexec.exe /q /uninstall {97E2CA7B-B657-4FF7-A6DB-30ECC73E1E28}
```

### If you installed legacy LAPS by manually copying and registering the legacy LAPS CSE dll

In this situation, you need to manually unregister and then delete the legacy LAPS CSE dll:

```text
regsvr32.exe /s /u AdmPwd.dll
delete AdmPwd.dll
```

If necessary the location where the legacy LAPS CSE binary was copied can be queried from the registry, for example:

```text
C:\>reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D-087DE603E3EA}" /v DllName

HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\GPExtensions\{D76B9641-3288-4f75-942D-087DE603E3EA}
    DllName    REG_EXPAND_SZ    C:\windows\system32\AdmPwd.dll
```

## See also

- [Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)
- [Windows LAPS Troubleshooting Guidance](/troubleshoot/windows-server/windows-security/windows-laps-troubleshooting-guidance)

## Next steps

- [Configure Windows LAPS policy settings](laps-management-policy-settings.md)
