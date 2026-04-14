---
title: Troubleshoot the VM Conversion Extension in Windows Admin Center (Preview)
description: Resolve VMware to Hyper-V migration problems using the VM Conversion Extension. Diagnose and fix errors, stuck migrations, and network configuration problems.
#customer intent: As a virtualization administrator, I want to troubleshoot VM conversion problems in Windows Admin Center so that I can successfully migrate VMware virtual machines to Hyper-V.
ms.date: 01/06/2026
ms.topic: troubleshooting
author: pmiddha
ms.author: pmiddha
ms.reviewer: shsathee,pmiddha
---

# Troubleshoot the VM Conversion extension in Windows Admin Center (Preview)

> [!IMPORTANT]
> The VM Conversion extension is currently in PREVIEW.
> This document provides information about a prerelease product that might change substantially before its release. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> As a preview extension, the VM Conversion extension is governed by the [Windows Admin Center prerelease extension software license terms](/legal/windows-server/windows-admin-center/windows-pre-release-extension-eula).
> Microsoft isn't obligated under this agreement to provide any support services for the software. Problems, questions, and feedback not covered in this documentation can be filed [here](https://github.com/MicrosoftDocs/Windows-Admin-Center-Ideas-and-Feedback).

Migrating virtual machines from VMware to Hyper-V can sometimes run into unexpected problems. This article helps you diagnose and resolve common problems you might encounter when using the VM Conversion Extension in Windows Admin Center, including stuck migrations, synchronization failures, static IP configuration problems, and Change ID errors.

Use this guide if your migration isn't completing as expected or you're seeing error messages during synchronization or conversion. Each section describes the symptoms, explains the cause, and walks you through the steps to fix the problem.

For problems or questions not covered in this documentation, you can submit feedback in our [Windows Admin Center Ideas & Feedback repository](https://github.com/MicrosoftDocs/Windows-Admin-Center-Ideas-and-Feedback).

## Problem 1: VM resync or remigrate required, or migration stuck at a certain percentage (session timeout)

**Symptom:**

- You want to resync or remigrate a VM.
- Migration is stuck at a certain percentage due to a session timeout.

**Resolution:**

1. Delete the relevant entries from the following files on the Windows Admin Center gateway machine:

   - `C:\Program Files\Windows Admin Center\Service\migrationStatus.json`
   - `C:\Program Files\Windows Admin Center\Service\syncStatus.json`

1. If the VM already exists in **Hyper-V Manager**, delete it before starting the migration again.

---

## Problem 2: Cancel VM synchronization or migration in progress

**Symptom:**

- You want to cancel a synchronization or migration while it's in progress.

**Resolution:**
The extension doesn't support cancellation directly. As a workaround:

1. Stop the **Windows Admin Center service**.

1. Restart the service. This action releases all running threads.

1. Delete the relevant entries from the following files to ensure the status doesn't continue to show as "In Progress":

   - `C:\Program Files\Windows Admin Center\Service\migrationStatus.json`
   - `C:\Program Files\Windows Admin Center\Service\syncStatus.json`

---

## Problem 3: Migration precheck fails with error

**Error message:**

> *"Failed to retrieve the list of VMs from the destination server. Please ensure the destination server is reachable and retry the operation."*

**Resolution:**

- Make sure the same destination server doesn't have any **failed virtual machines**.

---

## Problem 4: Static IP configuration isn't preserved without guest credentials

**Scenario:**

When you provide guest operating system credentials, the VM Conversion tool can automatically migrate static IP settings for Windows virtual machines.

If you don't provide guest credentials, the tool can't automatically migrate static IP settings.

**Symptom:**

After migration, the virtual machine:

- Gets a DHCP-assigned IP address, or
- Doesn't keep its original static IP configuration

**Cause:**

Automatic static IP migration needs access to the guest operating system to read and reapply network settings.

If you don't provide guest credentials because of security or compliance requirements, the VM Conversion tool can't capture static IP configuration during migration.

**Resolution: Manual static IP migration (guest credentials not required)**

Use the following workflow to preserve static IP configuration without providing guest credentials.

> [!IMPORTANT]  
> Complete these steps **after synchronization and before starting migration**.  
> Running the script after migration doesn't preserve the static IP configuration.

1. Download the [**Static IP migration package (.zip)**](https://aka.ms/hci-migrate-static-ip-download).  
   The package includes scripts for **Windows and Linux** virtual machines.

1. After synchronization finishes, copy the package to a location inside the **source guest virtual machine** and extract the contents.

1. Open **PowerShell as Administrator** inside the guest virtual machine.

1. Go to the extracted folder.

1. Run the following command to capture the static IP configuration:

   ```powershell
   .\Prepare-MigratedVM.ps1 -StaticIPMigration -Verbose
   ```

---

## Problem 5: Synchronization fails due to an invalid Change ID

**Error Message:**

> The generated Change ID is invalid. Please verify the Change ID and try again.

**When This Problem Occurs:**

This problem occurs during **synchronization** when the VM Conversion extension can't retrieve or validate the **Change ID** for one or more virtual disks on the source VMware virtual machine.

The VM Conversion extension relies on **VMware Changed Block Tracking (CBT)** to identify incremental disk changes. If the Change ID is missing, stale, or invalid, synchronization can't continue.

**Possible Causes:**

This problem can occur for one or more of the following reasons:

- Changed Block Tracking (CBT) is disabled or not fully enabled on the source virtual machine.
- Snapshot-related problems, including:
  - Orphaned or stale snapshots
  - Snapshot chain corruption
- Unsupported disk configurations, such as:
  - Independent disks (persistent or non-persistent)
  - Physical mode RDMs
- Recent virtual machine operations, including:
  - Storage vMotion
  - Virtual disk resize
  - Virtual machine restore from backup
- CBT metadata corruption caused by host crashes or unexpected power events.

**What to Check:**

Before retrying synchronization, verify the following checks:

1. Ensure CBT is enabled on the source virtual machine:
   - `ctkEnabled` is set to `true` at the virtual machine level.
   - `ctkEnabled` is set to `true` for each virtual disk.
1. Verify that no active snapshots exist:
   - Remove or consolidate snapshots if necessary.
1. Validate disk configuration:
   - Ensure disks aren't configured as **Independent**.
   - Verify RDMs use **Virtual Compatibility Mode**, if applicable.
1. Review recent virtual machine operations:
   - Check for recent storage migrations, disk changes, or restore operations.

**How to Fix the Problem:**

If synchronization fails due to an invalid Change ID, regenerate CBT metadata on the source VMware virtual machine using one of the following methods.

### Option 1: Regenerate CBT using PowerCLI

You can also reset CBT programmatically using **VMware PowerCLI**. This method is useful for automation scenarios or environments where GUI access is limited.

#### Prerequisites

- VMware PowerCLI installed
- Network access to the vCenter Server
- Sufficient permissions to reconfigure virtual machines

#### PowerCLI script

```powershell
Connect-VIServer -Server "<vCenterServer>" -User "<Username>" -Password "<Password>" -Force

$vm = Get-VM "<VMName>" | Get-View
$vmConfigSpec = New-Object VMware.Vim.VirtualMachineConfigSpec

# Disable CBT
$vmConfigSpec.changeTrackingEnabled = $false
$vm.ReconfigVM($vmConfigSpec)

# Re-enable CBT
$vmConfigSpec.changeTrackingEnabled = $true
$vm.ReconfigVM($vmConfigSpec)

Disconnect-VIServer -Server "<vCenterServer>" -Force -Confirm:$false
```

### Option 2: Regenerate CBT using the vSphere Client (GUI)

1. Disable **Changed Block Tracking (CBT)** on the source virtual machine.
1. Power off the virtual machine.
1. Re-enable **Changed Block Tracking (CBT)**.
1. Power on the virtual machine.
1. Wait for the system to generate a new Change ID.
1. Retry the synchronization operation.

> [!NOTE]  
> To regenerate valid CBT metadata, you must power cycle the virtual machine.

**Learn More**

For more information about CBT limitations and troubleshooting guidance, see the following Broadcom documentation:

- [Troubleshooting Changed Block Tracking (CBT) – Broadcom Knowledge Base](https://knowledge.broadcom.com/external/article/320557/changed-block-tracking-cbt-on-virtual-ma.html)
- [Troubleshooting Changed Block Tracking (CBT) – VDDK Programming Guide](https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere-sdks-tools/8-0/virtual-disk-development-kit-programming-guide/error-codes-and-open-source/troubleshooting-changed-block-tracking-cbt.html)

**Best Practice**

Validate CBT health on the source virtual machine before starting synchronization, especially after snapshot operations or virtual machine configuration changes.

## Related content

- [Overview of VMware to Hyper-V migration](vm-conversion-extension-overview.md)
- [Migrate VMware VMs to Hyper-V in Windows Admin Center](migrate-virtual-machines-vm-conversion-extension.md)
- [What's new in VM Conversion Extension](whats-new-vm-conversion-extension.md)
- [VMware to Hyper-V migration FAQ](vm-conversion-extension-faq.yml)