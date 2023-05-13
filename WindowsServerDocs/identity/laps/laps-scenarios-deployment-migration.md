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

The Windows LAPS policy may also be configured with features (backup to Azure AD, or enable AD password encryption) that weren't available in the legacy LAPS software.

When a Windows LAPS policy is first applied, the managed device performs an immediate rotation of the local account password. You should [monitor](laps-scenarios-deployment-migration.md#monitoring-a-successful-transition) the managed device to ensure the transition has completed successfully.

Once the transition has completed, the final step should be to [remove the legacy LAPS software from the managed device](laps-scenarios-deployment-migration.md#removing-the-legacy-laps-software-from-a-managed-device).

### Transient side-by-side coexistence approach

You may want to implement a more gradual migration procedure from legacy LAPS to Windows LAPS. The basic steps to perform this transition on existing devices are as follows:

1. Configure the managed device with a second local account
1. Create and apply a Windows LAPS policy
1. Monitor the managed device to confirm a successful application of the Windows LAPS policy
1. Disable\remove the legacy LAPS policy
1. Remove the legacy LAPS software

With this approach, it's necessary to create a second local account since it's not supported to have both a Windows LAPS policy and legacy LAPS policy targeting the same account.
The easiest approach when configuring the Windows LAPS policy is to target the same account that was previously targeted in the legacy LAPS policy. If you choose to target a different account, then it's your responsibility to remove the first account as needed.

## Monitoring a successful transition

There are multiple approaches to monitoring for a successful outcome once you have transitioned a managed device to a Windows LAPS policy:

- If you have deployed a centralized event log collection solution, you can monitor the managed device's [Windows LAPS event log channel](laps-management-event-log.md) for successful password update events
- When storing passwords in Active Directory, you can look for the appearance of a new\updated msLAPS-PasswordExpirationTime attribute on the managed device's AD computer object.
- When storing passwords in Azure Active Directory, you can check the Azure AD or Intune management portals to verify that the device has updated its password.

## Removing the legacy LAPS software from a managed device

The specific steps required to remove the legacy LAPS software from the managed device depend on how that software was initially installed.

1. If you installed legacy LAPS using the MSI installer package:

You can manually uninstall the legacy LAPS software from the control panel.

You can automate this process with a silent MSI uninstall command:

```text
C:\>msiexec.exe /q /uninstall {97E2CA7B-B657-4FF7-A6DB-30ECC73E1E28}
```

2. If you installed legacy LAPS by manually copying and registering the legacy LAPS CSE binary

In this situation you need to manually unregister and then delete the legacy LAPS CSE binary:

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
