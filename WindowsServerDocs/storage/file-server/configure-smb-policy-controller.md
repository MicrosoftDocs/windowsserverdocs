---
title: Configure SMB Policy Controller (preview)
description: SMB Policy Controller (preview) lets you configure, verify, troubleshoot, and remove server-wide and share-level SMB intents in Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 11/11/2026
ai-usage: ai-assisted
#customer intent: As a file-server administrator, I want to configure and manage SMB Policy Controller so that server-wide and share settings remain aligned with my intended outcomes.
---

# Configure and manage SMB Policy Controller (preview) in Windows Server

SMB Policy Controller (preview) stores the Server Message Block (SMB) settings you want for a device or an existing file share and corrects managed settings when they drift. Use it when you need server-wide and share-level configuration to stay aligned with a defined security or performance outcome.

In this article, you use Windows PowerShell to manage server-wide and share-level SMB intents through their lifecycle while verifying that the effective configuration matches your intended outcome.

> [!IMPORTANT]
> SMB Policy Controller is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- Windows Server Insider Preview build 29707 or later.
- An elevated Windows PowerShell session on the device. For instructions, see [Start Windows PowerShell with administrative privileges](/powershell/scripting/windows-powershell/starting-windows-powershell#run-with-administrative-privileges).
- Administrative access to the affected device. A server intent manages the local SMB server configuration, SMB client configuration, managed SMB registry settings, and alternative-port configuration.
- An existing SMB share for the share-intent procedures. SMB Policy Controller (preview) doesn't create the share, its folder, or its permissions.
- Representative clients and user identities for access testing.
- A change plan that identifies affected servers, shares, clients, and other configuration tools that can change the same SMB settings.
- A record of the effective SMB settings before you create an intent. Use this record when you verify that removal returned the managed settings to their pre-intent values.

## Install SMB Policy Controller (preview)

On a device that runs Windows Server Insider Preview build 29707 or later, install the SMB Policy Controller (preview) Feature on Demand and verify that it's ready before you configure an intent.

1. Open Windows PowerShell as an administrator.

1. Enable the SMB Policy Controller Feature on Demand (`PolicyController`) by calling `dism.exe` directly.

   ```powershell
   dism.exe /Online /Enable-Feature /FeatureName:PolicyController
   ```

   Use `dism.exe` directly because the DISM PowerShell cmdlets don't enable the SMB Policy Controller Feature on Demand from PowerShell 7.

1. If DISM requests a restart, restart the device.

1. If you restarted the device, reopen Windows PowerShell as an administrator.

1. Verify the module, its commands, and the service.

   ```powershell
   Import-Module PolicyController -ErrorAction Stop
   Get-Command -Module PolicyController
   Get-Service -Name PolicyController
   ```

   Confirm that the module imports, the command list displays the module's commands, and the `PolicyController` service status is `Running`. If installation verification fails, don't continue to intent configuration.

## Choose an intent scope

Choose a server-wide intent to manage host-wide SMB server, SMB client, managed SMB registry settings, and alternative-port configuration. Choose a share-level intent to manage one named, existing SMB share. The scopes are separate. When both intents exist, verify their combined effective settings.

For details about scope interactions and other tools that manage the same settings, see [Server and share intent](smb-policy-controller.md#server-and-share-intent).

## Choose a profile and workload selector

Choose the **Security** profile when strengthening SMB protection is the priority. Choose the **Performance** profile when workload performance is the priority and you accept its security and availability tradeoffs. For a share intent, also choose the **User data** workload selector for shares that people and teams use interactively or the **Application data** workload selector for shares that applications use for data. Make these choices before you create the intent. For profile effects, tradeoffs, and workload selector guidance, see [SMB Policy Controller (preview) profiles and workload selectors](smb-policy-controller.md#profiles-and-workload-selectors). For override behavior and limitations, see [SMB Policy Controller profile-derived overrides](smb-policy-controller.md#profile-derived-overrides).

For a new intent, use an override object when a supported setting must differ from its profile value. For an existing intent, retrieve the current intent, edit only the required properties, and submit the edited object with `Set-Intent -Override`. This pattern retains settings that you don't intend to change.

## Configure an intent

Select the tab for the intent scope that you want to configure.

# [Server-wide intent](#tab/server-wide-intent)

A server-wide intent manages host-wide SMB server, SMB client, managed SMB registry settings, and alternative-port configuration. Apply it together with one or more share intents when you need both scopes. To configure a server-wide intent, use the following steps.

1. Check for an existing server-wide intent.

   ```powershell
   Get-Intent -System
   ```

   If an intent exists, don't add another one. Use the update procedure instead. If the command reports a read or persistence error, resolve the error before continuing.

1. Review the current effective SMB configuration and confirm that you chose the **Security** profile when SMB protection is the priority or the **Performance** profile when workload performance is the priority and you accept its security and availability tradeoffs. For detailed guidance, see [SMB Policy Controller (preview) profiles and workload selectors](smb-policy-controller.md#profiles-and-workload-selectors).

   ```powershell
   Get-SmbServerConfiguration
   Get-SmbClientConfiguration
   ```

1. Create the server-wide Security intent.

   ```powershell
   Add-Intent -Security
   ```

   To create a Performance intent instead, use `Add-Intent -Performance`. Don't run both commands.

   When `Add-Intent` completes, SMB Policy Controller (preview) stores the desired intent and started an application attempt. To confirm the effective settings and client access, [verify the intent](#verify-an-intent).

1. Immediately complete the [verification procedure](#verify-an-intent).

# [Share-level intent](#tab/share-level-intent)

A share intent manages one named existing share. It doesn't create the share. Server and share scopes are separate, so verify their combined effective settings when both intents exist. Before you create the intent, choose the **Security** profile when SMB protection is the priority or the **Performance** profile when workload performance is the priority and you accept its tradeoffs. Also choose the **User data** workload selector for interactive shares or the **Application data** workload selector for application data. For details, see [SMB Policy Controller (preview) profiles and workload selectors](smb-policy-controller.md#profiles-and-workload-selectors). Specify both choices so that the share intent doesn't depend on a server-wide default. To configure a share-level intent, use the following steps.

1. Confirm the share name, path, and scope.

   ```powershell
   Get-SmbShare -Name 'Documents' -ErrorAction Stop |
       Format-List Name, ScopeName, Path, Description, FolderEnumerationMode,
           CachingMode, LeasingMode, CaTimeout, CompressData, ConcurrentUserLimit,
           ContinuouslyAvailable, DirectoryHandleLeasing, DisableClientMetadataCaching,
           EncryptData, IsolatedTransport
   ```

   Replace `Documents` with the exact share name. The documented intent cmdlets accept `ShareName` but don't provide a scope or path selector. If duplicate share names exist in different scopes, don't use the share-intent procedures in this article because they can't target one of those shares unambiguously.

1. Check for an existing intent for the share.

   ```powershell
   Get-Intent -ShareName 'Documents'
   ```

   If an intent exists, use the update procedure instead. Resolve any read or persistence error before treating the result as no intent.

1. Create a Security-profile intent for a user-data share.

   ```powershell
   Add-Intent -Security -ShareName 'Documents' -UserData
   ```

   Use `-ApplicationData` for an application-data share. Use `-Performance` instead of `-Security` when the Performance profile's tradeoffs meet the workload requirements. This command creates only a share intent; it doesn't create a server intent.

   When `Add-Intent` completes, SMB Policy Controller (preview) stores the desired share intent and attempts to apply it. The share intent retains the selected profile and settings if the server intent changes. To confirm the effective settings and client access, [verify the intent](#verify-an-intent).

1. Immediately complete the [verification procedure](#verify-an-intent).

---

## Add a customized intent

In SMB Policy Controller (preview), select the tab for the intent scope that you want to customize.

# [Server-wide intent](#tab/server-wide-intent)

For a new server-wide intent, use an override object when a supported setting must differ from the selected built-in profile. The following procedure creates a Security-profile server configuration, requires SMB server signing, and applies the customized object:

1. Create and customize the override object.

   ```powershell
   $override = New-IntentOverride -Security
   $override.SmbServerConfiguration.RequireSecuritySignature = $true
   ```

1. Add the customized server-wide intent.

   ```powershell
   Add-Intent -Override $override
   ```

   Don't combine `-Override` with `-Security` or `-Performance` on `Add-Intent`. The override object already contains the profile choice.

1. Immediately complete the [verification procedure](#verify-an-intent).

# [Share-level intent](#tab/share-level-intent)

For a new share intent, use an override object when a supported setting must differ from the selected built-in profile. This procedure customizes one share intent; it doesn't create a named, reusable profile. The following procedure creates a Security-profile user-data configuration, requires encryption, and applies the customized object to the existing share:

1. Create and customize the override object.

   ```powershell
   $override = New-IntentOverride -Security -UserData
   $override.SmbShareConfiguration.EncryptData = $true
   ```

1. Add the customized share intent.

   ```powershell
   Add-Intent -ShareName 'Documents' -Override $override
   ```

   Don't combine `-Override` with `-Security`, `-Performance`, `-UserData`, or `-ApplicationData` on `Add-Intent`. The override object already contains those choices.

   When `Add-Intent` completes, SMB Policy Controller (preview) stores the customized intent and starts an application attempt. To confirm the effective settings and client access, [verify the intent](#verify-an-intent).

1. Immediately complete the [verification procedure](#verify-an-intent).

---

## Update an intent

Use the get, edit, and set pattern to retain settings that you don't intend to change. A new override object uses a profile rather than cloning the existing intent or current live configuration. Select the tab for the intent scope that you want to update.

# [Server-wide intent](#tab/server-wide-intent)

1. Read the current server-wide intent.

   ```powershell
   $intent = Get-Intent -System
   if ($null -eq $intent) {
       throw "The server didn't return a readable server-wide intent."
   }
   $intent
   ```

1. Review the complete object and then change only the required property. This example requires SMB server signing.

   ```powershell
   $intent.SmbServerConfiguration.RequireSecuritySignature = $true
   ```

1. Submit the edited object.

   ```powershell
   Set-Intent -Override $intent
   ```

   When `Set-Intent` completes, SMB Policy Controller (preview) stores the updated intent and starts an application attempt. To confirm the effective settings and client access, [verify the intent](#verify-an-intent).

1. Complete the [verification procedure](#verify-an-intent).

# [Share-level intent](#tab/share-level-intent)

To change selected retained settings, retrieve the existing share intent, edit only the required properties, and submit the edited intent with `Set-Intent`.

1. Read the current share intent.

   ```powershell
   $intent = Get-Intent -ShareName 'Documents'
   if ($null -eq $intent) {
       throw "The cmdlet didn't return a readable share intent."
   }
   $intent
   ```

1. Review the complete object and change only the required property. This example requires encryption for the share.

   ```powershell
   $intent.SmbShareConfiguration.EncryptData = $true
   ```

1. Submit the edited object.

   ```powershell
   Set-Intent -ShareName 'Documents' -Override $intent
   ```

   When `Set-Intent` completes, SMB Policy Controller (preview) stores the updated share intent and starts an application attempt. To confirm the effective settings and client access, [verify the intent](#verify-an-intent).

1. Complete the [verification procedure](#verify-an-intent).

---

These examples update selected settings within an existing intent type. They don't establish a profile migration procedure or a procedure for changing between user-data and application-data intent types.

## Verify an intent

Use three customer-facing evidence layers: the stored intent, the effective or observed configuration, and representative client success. Check each layer because a saved intent alone doesn't prove that the settings are effective or that clients can use the share. The installed Windows build can present different status details, so don't depend on specific field labels.

1. Read the applicable stored intent to confirm the saved scope, profile, and settings.

   ```powershell
   Get-Intent -System
   Get-Intent -ShareName 'Documents'
   ```

   Run only the command for the scope you're verifying. Inspect the complete returned object and any available status information. Don't interpret a command error as proof that no intent exists.

1. Read the effective or observed server and client configuration for a server-wide intent. This evidence shows whether the relevant host-wide settings match the stored intent.

   ```powershell
   Get-SmbServerConfiguration
   Get-SmbClientConfiguration
   ```

1. Read the effective or observed share configuration for a share intent. This evidence shows whether the relevant share settings match the stored intent.

   ```powershell
   Get-SmbShare -Name 'Documents' -ErrorAction Stop |
       Format-List Name, ScopeName, Path, Description, FolderEnumerationMode,
           CachingMode, LeasingMode, CaTimeout, CompressData, ConcurrentUserLimit,
           ContinuouslyAvailable, DirectoryHandleLeasing, DisableClientMetadataCaching,
           EncryptData, IsolatedTransport
   ```

1. Compare every relevant managed setting with the stored intent and your approved change plan. Check each affected configuration group instead of relying on one summary result.

1. For a server-wide intent, test representative outbound SMB client operations from the managed device against remote shares that it normally uses. If the managed device hosts shares, also test representative clients' inbound access. For a share intent, test the share from representative clients. Use representative user identities and workload operations, and verify the expected read, write, and denied-access cases that apply.

1. Record the results and the observation time. Recheck after Group Policy, scripts, clustering operations, or other configuration tools change the same settings.

## Retry intent application

The system limits application retries. Retry only after you identify and correct the cause of the failure. Don't automate repeated retries or depend on an assumed retry schedule, attempt count, or counter-reset behavior.

1. Confirm that the intent is active and that no operation is removing it.

   ```powershell
   Get-Intent -System
   Get-Intent -ShareName 'Documents'
   ```

   Run the command for the affected scope.

1. Correct the underlying problem reported by SMB Policy Controller.

   - Retry a server-wide intent.

     ```powershell
     Set-Intent -Retry
     ```

     For a share intent, run:

     ```powershell
     Set-Intent -ShareName 'Documents' -Retry
     ```

1. Complete the [verification procedure](#verify-an-intent).

`Set-Intent -Retry` reapplies an active intent. It isn't a profile change, a rollback, or a retry of an incomplete removal. Don't place it in an uncontrolled loop.

## Collect diagnostics

Collect stored-intent, effective-state, service, and client evidence from the same time period. This information helps you distinguish controller problems from general SMB connectivity problems.

1. Record the service and module state.

   ```powershell
   Get-Service -Name PolicyController
   Get-Module -ListAvailable -Name PolicyController
   Get-Command -Module PolicyController
   ```

1. Capture the applicable intent object and any errors without changing it.

   ```powershell
   Get-Intent -System
   Get-Intent -ShareName 'Documents'
   ```

1. Capture the effective SMB settings.

   ```powershell
   Get-SmbServerConfiguration
   Get-SmbClientConfiguration
   Get-SmbShare -Name 'Documents' -ErrorAction Stop |
       Format-List Name, ScopeName, Path, Description, FolderEnumerationMode,
           CachingMode, LeasingMode, CaTimeout, CompressData, ConcurrentUserLimit,
           ContinuouslyAvailable, DirectoryHandleLeasing, DisableClientMetadataCaching,
           EncryptData, IsolatedTransport
   ```

1. Record the server time, affected share identity, client identity, operation, and error message. Include any observation time that the intent reports.

1. Review the SMB client and server event logs for the same period. For log locations and general connectivity checks, see [Troubleshoot SMB](Troubleshoot/troubleshooting-smb.md).

1. If your support process requires controller-specific tracing, first inspect the tracing help that the installed module supplies.

   ```powershell
   Get-Help Set-IntentTracing -Full
   ```

   Follow only the trace procedure, output location, and data-handling requirements in the help for the installed PolicyController module. This article doesn't assume a trace path, provider, file size, or remote-tracing behavior.

## Remove an intent and return to previous settings

Select the tab for the intent scope that you want to remove.

# [Server-wide intent](#tab/server-wide-intent)

When removal succeeds, SMB Policy Controller (preview) returns managed host settings to the values that it captured before it first applied the intent, not to Security or Performance profile defaults. Removing a server-wide intent affects the managed SMB server, SMB client, registry, and alternative-port configuration. Account for every server and share target that broad removal selects before continuing.

1. Record the server-wide intent and all relevant effective server settings.

   ```powershell
   Get-Intent -System
   Get-SmbServerConfiguration
   Get-SmbClientConfiguration
   ```

1. Use your change plan and intent records to account for every persisted or incomplete share-intent lifetime that broad removal can select. For every affected share that still exists, record its stored intent and relevant effective managed settings. Replace `Documents` with the share name, and repeat these commands for every affected existing share. If you can't account for every target and its baseline, don't use broad removal.

   ```powershell
   Get-Intent -ShareName 'Documents'
   Get-SmbShare -Name 'Documents' -ErrorAction Stop |
       Format-List Name, ScopeName, Path, Description, FolderEnumerationMode,
           CachingMode, LeasingMode, CaTimeout, CompressData, ConcurrentUserLimit,
           ContinuouslyAvailable, DirectoryHandleLeasing, DisableClientMetadataCaching,
           EncryptData, IsolatedTransport
   ```

1. Review the installed module help and your change plan before you use broad removal.

   ```powershell
   Get-Help Remove-Intent -Full
   ```

1. Start the server-wide removal.

   > [!WARNING]
   > Running `Remove-Intent` without parameters is equivalent to `Remove-Intent -System`. It selects the server intent and all persisted or incomplete share-intent lifetimes, and it doesn't prompt for confirmation. The operation can partially complete or fail. In a cluster, resource ownership or offline participating nodes can delay completion or cause it to fail. You must specify `-ShareName` for share-only removal.

   ```powershell
   Remove-Intent -System
   ```

   During successful processing, SMB Policy Controller returns the managed settings that it captured to their pre-intent values before it finishes removing each intent that the operation selected.

1. Verify that the removal completed for every target that the operation selected and that SMB Policy Controller returned the managed settings to their pre-intent values. Check the effective configuration instead of assuming that command submission means that the operation completed.

1. Compare effective settings with the pre-intent records for each affected target, and test representative client access.

1. If removal doesn't complete, preserve the evidence and correct the reported cause.

1. After you correct the reported cause, run `Remove-Intent -System` to retry any incomplete removals. Don't use `Set-Intent -Retry`, which retries application of an active intent, and don't manually delete controller recovery records.

The removal operation doesn't delete shares or data, and it isn't a backup restore. SMB Policy Controller returns the managed settings that it captured to their pre-intent values.

# [Share-level intent](#tab/share-level-intent)

When removal succeeds, SMB Policy Controller (preview) returns the managed share settings to the values that it captured before it first applied the intent, not to Security or Performance profile defaults. Removing a share intent can affect live client access, so use an explicit scope and verify the effective settings and client operations afterward.

1. Record the stored intent, effective share settings, share name, scope, and path.

   ```powershell
   Get-Intent -ShareName 'Documents'
   Get-SmbShare -Name 'Documents' -ErrorAction Stop |
       Format-List Name, ScopeName, Path, Description, FolderEnumerationMode,
           CachingMode, LeasingMode, CaTimeout, CompressData, ConcurrentUserLimit,
           ContinuouslyAvailable, DirectoryHandleLeasing, DisableClientMetadataCaching,
           EncryptData, IsolatedTransport
   ```

1. Remove the named share intent.

   ```powershell
   Remove-Intent -ShareName 'Documents'
   ```

1. Verify that removal completed and returned the managed settings to their pre-intent values. Don't treat command submission alone as proof of success.

1. Compare the effective managed share settings with the pre-intent record, and test representative client access.

1. If removal doesn't complete, preserve the evidence and correct the reported cause.

1. After you correct the reported cause, run the same `Remove-Intent -ShareName 'Documents'` command to retry the incomplete removal. Don't use `Set-Intent -Retry`, which retries application of an active intent rather than removal.

The removal operation doesn't delete the share or its files, and it isn't a backup restore. It returns the managed settings to the values that SMB Policy Controller captured before it applied the intent.

---

## Troubleshoot common problems

Use the following guidance after collecting diagnostics. Don't delete controller recovery records or apply undocumented repair commands.

| Problem | Recommended action |
|---|---|
| Add reports that an intent already exists | Read the existing intent, then use the get, edit, and set pattern. Don't remove it only to make Add succeed. |
| The system can't find the share | Confirm its exact name, path, and scope with `Get-SmbShare`. SMB Policy Controller (preview) doesn't create the share. |
| Stored intent and effective settings differ | Check reported application errors, service health, setting applicability, ownership, and other configuration writers. Inspect every managed group because application might be partial. |
| Drift returns after correction | Check for Group Policy, scripts, management tools, or administrators that write the same settings. Coordinate writers instead of repeatedly forcing changes. |
| Client access fails although settings appear compliant | Troubleshoot authentication, authorization, networking, name resolution, dialect negotiation, and the client workload separately. A compliance observation isn't a client-access test. |
| Retry doesn't resolve the problem | Stop retrying, preserve the evidence, and investigate the underlying error. |
| Removal doesn't complete | Preserve the evidence, correct the reported cause, and retry the same `Remove-Intent` command. |

## Related content

- [SMB Policy Controller (preview)](smb-policy-controller.md)
- [SMB security hardening](smb-security-hardening.md)
- [SMB over QUIC](smb-over-quic.md)
- [Troubleshoot SMB](Troubleshoot/troubleshooting-smb.md)
