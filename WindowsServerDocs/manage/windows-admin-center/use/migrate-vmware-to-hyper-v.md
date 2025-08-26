---
title: Migrate VMware Virtual Machines to Hyper-V in Windows Admin Center (Preview)
description: Learn how to migrate VMware virtual machines to Hyper-V using the Windows Admin Center VM Conversion extension. Discover step-by-step instructions and benefits.
author: meaghanlewis
ms.topic: how-to
ms.date: 08/13/2025
ms.author: mosagie
---
# Migrate VMware virtual machines to Hyper-V in Windows Admin Center (Preview)

> [!IMPORTANT]
> The VM Conversion extension is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

You can use Windows Admin Center to migrate VMware virtual machines from vCenter to Hyper-V with the **VM Conversion extension**. This lightweight tool enables online replication with minimal downtime for both Windows and Linux virtual machines. The conversion tool is easy and fast to set up, at no cost to customers.

In this article, you learn how to install and configure the extension, follow the synchronization and migration workflow, and find answers to common questions.

## Feature overview

The **VM Conversion extension** provides the following key features:

- **Bulk migration**: Supports a batch of 10 virtual machines migration at-a-time. This enables admins to group virtual machines based on:

  - **Application dependency** – virtual machines that are part of the same application stack or service.
  - **Cluster dependency** – virtual machines that need to be distributed on nodes within same cluster.
  - **Business boundaries** – virtual machines servicing different business within a company. For example, test machines and preproduction machines.
  - **Rack dependency** – virtual machines running on hosts on a rack.

- **Cluster-aware migration**: Supports migration virtual machines from eSXI hosts to Windows Server Failover clusters.

- **Static IP configurations**: Persists the static IP configurations of virtual machines from source to destination Hyper-V hosts. This reduces post-migration tasks and enables seamless network continuity.

- **Secure Boot and UEFI template configuration**: Provides enhanced security and compliance.
  - Integrated osType across the migration flow for accurate secure boot and UEFI setup.
  - Secure boot settings are dynamically configured based on OS, either Windows or Linux.
  - Added error handling for unsupported OS types.

- **Localization support**: Improves user experience using this tool in different languages.

- **Multiple vCenter connections**: Users can add multiple vCenter endpoints in order to switch between vCenters.

- **Multi-disk support**: Ensures all attached virtual disks are migrated and synchronized for virtual machines running complex workloads.​

- **Prechecks**: Catches failures early in replication, and migration phases.

- **Cleanup**: Removes VMware Tools from Windows VMs post-migration.

:::image type="content" source="media/migrate-vmware-to-hyper-v/supported-scenario-topology.png" alt-text="Diagram showing the supported scenario topology for VM migration from VMware vCenter to Hyper-V through Windows Admin Center.":::

## Prerequisites

Before you begin, review the prerequisites and ensure your environment meets the requirements.

### Windows Admin Center Gateway prerequisites

- Install PowerCLI.
  - Install using the PowerShell command: `Install-Module -Name VMware.PowerCLI`

- Install:
  - [Microsoft Visual C++ Redistributable](/cpp/windows/latest-supported-vc-redist)
  - [Visual C++ Redistributable Packages for Visual Studio 2013](https://www.microsoft.com/download/details.aspx?id=40784)

- Download [VMware Virtual Disk Development Kit (VDDK) version 8.0.3](https://developer.broadcom.com/sdks/vmware-virtual-disk-development-kit-vddk/latest/). Extract the contents, and copy to the directory: *C:\Program Files\WindowsAdminCenter\Service\VDDK*.

- Ensure that the Hyper-V role is installed. This is typically already enabled.

- [Use Windows Admin Center Gateway V2](https://aka.ms/downloadWAC) – version `2410` build number `2.4.12.10`

### vCenter or ESXi host prerequisites

None.

### Windows Server host prerequisites

None.

### Supported vCenter versions

- The extension supports VMware VCenter version 6.x or 7.x.
- To connect to vCenter from the extension, keep the following vCenter information at hand:
  - Fully Qualified Domain Name (FQDN)
  - Username
  - Password

### Supported guest operating systems

The following operating systems can use the VM Conversion extension:

Windows operating systems:

- Windows Server 2025, 2022, 2022 Azure Edition, 2019, 2016, 2012 R2
- Windows 10

Debian-based operating systems:

- Ubuntu Linux
- Ubuntu 20.04, 24.04
- Debian 11, 12

RHEL-based operating systems:

- Alma Linux
- CentOS
- Red Hat Linux 9.0

For Linux guests, Hyper-V drivers must be installed before initiating migration. The Hyper-V drivers are essential to ensure successful post-migration boot.

## Install the VM Conversion (Preview) extension in Windows Admin Center

Complete the following steps to install the **VM Conversion** extension.

1. Open Windows Admin Center.

1. Select the **Settings** button in the top-right. In the left pane, select **Extensions**.

1. The Available Extensions tab lists the extensions on the feed that are available for installation.

1. Search for **VM Conversion (Preview)** in **Available extensions** and select **Install.**

    :::image type="content" source="media/migrate-vmware-to-hyper-v/vm-conversion-available-extensions.png" alt-text="Screenshot of the VM Conversion (Preview) extension in the list of all Available extensions." lightbox="media/migrate-vmware-to-hyper-v/vm-conversion-available-extensions.png":::

1. Once installed, ensure VM Conversion extension is visible in the Windows Admin Center under: **Extensions** > **VM Conversion (Preview)**.

## Connect to vCenter

When you first visit the extension, you need to connect your vSphere client endpoint.

1. Select **Connect to vCenter**.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/connect-to-v-center.png" alt-text="Screenshot of the connect to vCenter option." lightbox="media/migrate-vmware-to-hyper-v/connect-to-v-center.png":::

1. Enter the vCenter FQDN, vCenter username, and vCenter password.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/configure-vmware-settings.png" alt-text="Screenshot showing how to configure VMware settings." lightbox="media/migrate-vmware-to-hyper-v/configure-vmware-settings.png":::

## Synchronize virtual machines using the VM Conversion (Preview) extension

### Synchronization prechecks

A set of prechecks are run before the synchronization begins. Confirm you have all the following steps complete before continuing on with the steps to synchronize virtual machines:

1. No active snapshots exist on the virtual machine.

1. VMware PowerCLI is installed on the Windows Admin Center Gateway machine.

1. Microsoft Visual C++ Redistributable packages (versions 2013 and latest) are installed on the Windows Admin Center Gateway machine.

1. VDDK package is present at: `C:\Program Files\WindowsAdminCenter\Service\VDDK` on the Windows Admin Center Gateway machine.

1. Target disk path for synchronization is valid.

1. Destination Hyper-V host has sufficient memory and disk space.

1. Change Block Tracking (CBT) is supported on the VM.

### Synchronize virtual machines

Complete the following steps to synchronize VMware virtual machines in Windows Admin Center.

1. Connect to the Hyper-V server in Windows Admin Center that you want the VM to be migrated.

1. Go to the VM Conversion extension in the left panel under **Extensions** > **VM Conversion (Preview)**.

1. In the virtual machine list, select up to 10 virtual machines to synchronize.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/bulk-vm-selection-for-synchronization.png" alt-text="Screenshot of the synchronize tab." lightbox="media/migrate-vmware-to-hyper-v/bulk-vm-selection-for-synchronization.png":::

1. In the Synchronize VM window, enter in the **Path to store data**. Select **Synchronize**.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/synchronize-vm-path-selection.png" alt-text="Screenshot of the dialog to enter the path to store data and confirm the synchronization can start." lightbox="media/migrate-vmware-to-hyper-v/synchronize-vm-path-selection.png":::

1. You see notifications appear with the progress for: running prechecks, preparing the environment, creating a snapshot, and finalizing synchronization. Confirm that the VHDX file is created in the folder path specified.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/synchronization-in-progress.png" alt-text="Screenshot of the notifications that appear while the synchronization is in progress." lightbox="media/migrate-vmware-to-hyper-v/synchronization-in-progress.png":::

1. Wait for the sync to complete.

## Migrate virtual machines using the VM Conversion (Preview) extension

### Migration prechecks

A set of prechecks are run before the migration begins. Confirm you have all the following steps complete before continuing on with the steps to migrate virtual machines:

1. Destination Hyper-V host has sufficient vCPU availability.

1. No existing virtual machine with the same name on the destination Hyper-V host.

1. Hyper-V role is enabled on the target Hyper-V host.

1. Synchronized `.vhdx` file exists.

1. No active snapshots on the virtual machine.

### Migrate virtual machines

Complete the following steps to migrate VMware virtual machines to Hyper-V in Windows Admin Center.

1. Go to the **Migrate** tab, and select the VM to migrate. Select **Migrate**.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/vm-selection-for-migration.png" alt-text="Screenshot of the migrate tab and virtual machines selected to migrate." lightbox="media/migrate-vmware-to-hyper-v/vm-selection-for-migration.png":::

1. In the Migrate VM window, select **Proceed** to start the migration.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/confirm-migration.png" alt-text="Screenshot of the dialog confirming that the migration can start." lightbox="media/migrate-vmware-to-hyper-v/confirm-migration.png":::

    During the migration, the following steps are performed: run migration prechecks, ensure sufficient disk space, perform delta replication, power off source VM, execute final delta sync, and import VM into Hyper-V.

1. Wait for virtual machine migration to complete.

    :::image type="content" source="media/migrate-vmware-to-hyper-v/migration-in-progress.png" alt-text="Screenshot of the progress of virtual machine migration." lightbox="media/migrate-vmware-to-hyper-v/migration-in-progress.png":::

1. The migrated virtual machine can be managed using the Hyper-V Manager, or in Windows Admin Center.

    > [!NOTE]
    > Migration requires the user to stay signed in with an active browser session. If the session is closed or times out, the
    > migration may pause or stop progressing.

## View logs

### Browser console logs

1. Open your browser settings, and navigate to **More Tools** > **Developer Tools**.
1. Check the **Console** tab.
1. Look for any error or warning messages and share them as needed.

### Event viewer logs

1. On the Windows Admin Center server, open **Event Viewer**.
1. Expand **Applications and Services Logs** in the left pane.
1. Select **WindowsAdminCenter**.
1. Filter and review logs for **Errors**, **Warnings**, and **Informational** messages relevant to the VM Conversion extension.

### VM conversion logs

1. Connect to the Windows Admin Center server.
1. Find the file located at `C:\ProgramFiles\WindowsAdminCenter\Service\VMConversion_log.txt`.

## Frequently asked questions

- Does the tool support both Static and DHCP IP addresses?

    Yes, both DHCP and Static IP addresses are supported.

    Static IP is supported using scripts. When a static IP is detected, the VM credentials are collected to run the script and capture the IP address details. It's persisted on the target Hyper-V host post cutover phase.

- How does the tool handle VM boot types?

    The tool automatically detects the source VM’s boot type. **BIOS boot** creates a Generation 1 VM on Hyper-V. **UEFI boot** creates a Generation 2 VM on Hyper-V.

- Why are migrated VM disks showing as Dynamic instead of Static (Fixed)?

    The VM Conversion tool currently migrates disks as **dynamically expanding (thin provisioned)** VHDX files, which means only the used portion of the disk is copied—not the full allocated size.

    During migration, a VM with a **provisioned size of 500 GB** but **actual usage of 250 GB** results in a 250 GB dynamic VHDX on the destination. While this is space-efficient, it might cause storage management issues later.

    After migration, customers should convert the VHDX to a fixed size to reflect the full provisioned storage using the PowerShell command:

    ```powershell
    Convert-VHD -Path "C:\VMs\MyDisk.vhdx" -DestinationPath "C:\VMs\MyDisk_Fixed.vhdx" -VHDType Fixed
    ```
- Is VMware to Azure Local migration supported?

    No, the tool doesn't support migration to Azure Local. Use [Azure Migrate to migrate virtual machines to Azure Local](/azure/azure-local/migrate/migration-azure-migrate-vmware-overview).

- Does the tool support virtual machines running on a virtual storage area network (vSAN)?

    No, the tool doesn't support virtual machines running on vSAN?

- Is this tool available in Windows Admin Center in the Azure portal?

    No, the conversion tool is only available in Windows Admin Center on-premises.
  
- How is memory configured during virtual machine migration?

    During migration, memory is configured as static, even if the source virtual machine is set to use dynamic memory. This is a design choice to ensure migration stability and compatibility between VMware and Hyper-V memory management.

    To re-enable dynamic memory of change RAM parameters after migration:

    1. Open **Windows Admin Center**.
    1. Navigate to the **Virtual machines** extension.
    1. Power off the migrated virtual machine.
    1. Select **Settings**.
    1. Update the required memory parameters: Startup memory, Enable dynamic memory, Minimum memory, Maximum memory, and Memory buffer.
    1. Save changes and **power on** the virtual machine.

- What are the current limitations of this migration tool?

  - The Resync option provides the capability to do data synchronization between initial replication and delta replication. The Resync option isn't supported.

  - VMware Tools aren't automatically uninstalled post-migration—remove them manually if needed.

  - Hyper-V drivers must be installed on Linux machines before starting migration. Download and install [Linux Integration Services v4.3](https://www.microsoft.com/download/details.aspx?id=55106) for Hyper-V and Azure.​

  - During virtual machine conversion, the BIOS GUID on the destination virtual machine won't match the source virtual machine unless it's manually updated. This might affect virtual machine identity synchronization, or licensing checks that rely on consistent BIOS-level identifiers. BIOS-level identifiers must be updated in virtual machine identity synchronization, and migration.

    <details>
    <summary>Expand this section and use the script provided to update the BIOS GUID on the migrated Hyper-V virtual machine.</summary>

    To update the BIOS GUID for a Hyper-V virtual machine:

    1. Extract the following script into a file named `Update-VMBiosInfo.ps1`.
    1. Open PowerShell as Administrator.
    1. Run the script with the required parameters: `.\Update-VMBiosInfo.ps1 -VMName "VM Name" -BiosGuid "New BIOS GUID"`

    ```powershell
    <#
    .SYNOPSIS
    Updates the BIOS GUID of a specified Hyper-V virtual machine.
    
    .DESCRIPTION
    This script stops a specified Hyper-V virtual machine, updates its BIOS GUID using CIM (Common Information Model), and WMIv2 (root\virtualization\v2), and then restarts the VM. It handles both synchronous and asynchronous operations triggered by the Hyper-V Management Service.
    
    It's particularly useful in scenarios such as VM identity synchronization, VM migration, or reconfiguration where BIOS-level identifiers are required to be updated.
    
    .PARAMETER VMName
    The name of the Hyper-V virtual machine whose BIOS GUID is to be updated.
    
    .PARAMETER BiosGuid
    The new BIOS GUID to assign to the virtual machine. The script automatically formats the GUID with braces if not provided.
    
    .EXAMPLE
    .\Update-VMBiosInfo.ps1 -VMName "Contoso" -BiosGuid "{423A2700-F96D-561B-B421-C3088111A97B}"
    
    This command updates the BIOS GUID of the virtual machine named "Contoso" to the specified GUID.
    
    .NOTES
    Author: MICROSOFT Corporation
    Version: 1.0
    Date: 2025-08-07
    Requirements:
    - Run with administrator privileges
    - Requires Hyper-V and access to the root\virtualization\v2 namespace
    - Tested on Windows Server 2019/2022 and Windows 10/11 with Hyper-V enabled
    
    .RETURNS
    Outputs success messages and job details. Throws descriptive errors in case of failure.
    
    .LINK
    https://learn.microsoft.com/windows-server/virtualization/hyper-v/
    
    #>
    
    param (
        [Parameter(Mandatory = $true)]
        [string]$VMName,
    
        [Parameter(Mandatory = $true)]
        [string]$BiosGuid
    )
    
    # Helper function to serialize
    function ConvertTo-CimEmbeddedString {
        [CmdletBinding()]
        param(
            [Parameter(ValueFromPipeline)]
            [Microsoft.Management.Infrastructure.CimInstance]$CimInstance
        )
    
        if ($null -eq $CimInstance) {
            return ""
        }
    
        $cimSerializer = [Microsoft.Management.Infrastructure.Serialization.CimSerializer]::Create()
        $serializedObj = $cimSerializer.Serialize($CimInstance, [Microsoft.Management.Infrastructure.Serialization.InstanceSerializationOptions]::None)
    
        return [System.Text.Encoding]::Unicode.GetString($serializedObj)
    }
    
    # Stop VM
    Write-Output "Stopping VM '$VMName'..."
    Stop-VM -Name $VMName -Force
    
    # Retrieve the VM's system settings data using its name
    $vmSettingsData = Get-CimInstance -Namespace "root\virtualization\v2" -Query "select * from Msvm_VirtualSystemSettingData where ElementName = '$VMName'" -ErrorAction Stop
    
    # Ensure BIOS GUID has { } format
    if (-not ($BiosGuid.StartsWith("{") -and $BiosGuid.EndsWith("}"))) {
        $BiosGuid = "{$BiosGuid}"
    }
    # Set the BIOS GUID
    $vmSettingsData.BIOSGUID = $BiosGuid
    
    # Get the Virtual System Management Service object
    $vmms = Get-CimInstance -Namespace root\virtualization\v2 -Class Msvm_VirtualSystemManagementService -ErrorAction Stop
    
    # Apply the updated system settings using ModifySystemSettings
    $result = $vmms | Invoke-CimMethod -Name "ModifySystemSettings" -Arguments @{
        "SystemSettings" = ($vmSettingsData | ConvertTo-CimEmbeddedString)
    } -ErrorAction Stop
    
    # Check the return value to determine if the operation succeeded
    if ($result.ReturnValue -eq 0) {
        # Success: operation completed synchronously
        Write-Host "BIOS GUID successfully updated for VM: $VMName (synchronous)"
    }
    elseif ($result.ReturnValue -eq 4096) {
    
        # 4096 indicates the method started an asynchronous job
        $jobPath = $result.Job
        Write-Host "BIOS GUID update started asynchronously for VM: $VMName (job path: $jobPath)"
        # Get the job object using its path
        $job = Microsoft.PowerShell.Management\Get-CimInstance -CimInstance $jobPath
    
        # Poll the job state until it is no longer Running (4) or Starting (3)
        while ($job.JobState -eq 3 -or $job.JobState -eq 4) {
            Start-Sleep -Seconds 1
            $job = Microsoft.PowerShell.Management\Get-CimInstance -CimInstance $jobPath
        }
    
        # If job completes successfully
        if ($job.JobState -eq 7) {
            Write-Host "BIOS GUID updated successfully for VM: $VMName (asynchronous job completed)"
        }
        else {
            # Job failed or did not complete properly
            throw "Async job failed. JobState: $($job.JobState), ErrorDescription: $($job.ErrorDescription)"
        }
    }
    else {
        # Any other return value indicates a failure
        throw "ModifySystemSettings failed with ReturnValue: $($result.ReturnValue)"
    }
    
    Write-Output "BIOS GUID successfully updated for VM: $VMName"
    # Start the VM again
    Write-Output "Starting VM '$VMName'..."
    Start-VM -Name $VMName
    ```

    >[!NOTE]
    >This process updates only the BIOS GUID. The BIOS Serial Number isn't updated because VMware and Hyper-V use different formats:
    >- VMware BIOS Serial Number: UUID format (8-4-4-4-12) → 503a4411-be04-bd40-98ac-ffa42335cc22
    >- Hyper-V BIOS Serial Number: Custom format (4-4-4-4-4-4-2) → 3123-9812-5797-4305-8770-5953-62
    >If licensing in your environment depends on a combination of BIOS GUID and BIOS Serial Number, the source, and destination values won't match, even if the BIOS GUID is manually updated.
    </details>

## Troubleshooting guide

### Issue 1: VM resync/remigrate required, or migration stuck at a certain percentage (session timeout)

**Symptom:**

- User wants to resync or remigrate a VM.
- Migration is stuck at a certain percentage due to a session timeout.

**Resolution:**

1. Delete the relevant entries from the following files on the Windows Admin Center gateway machine:

   ```
   C:\Program Files\Windows Admin Center\Service\migrationStatus.json
   C:\Program Files\Windows Admin Center\Service\syncStatus.json
   ```
1. If the VM already exists in **Hyper-V Manager**, delete it before reinitiating the migration.

---

### Issue 2: Cancel VM synchronization or migration in progress

**Symptom:**

- User wants to cancel a synchronization or migration while it is in progress.

**Resolution:**
Cancellation isn't supported directly in the extension. As a workaround:

1. Stop the **Windows Admin Center service**.
2. Restart the service. This will release all running threads.
3. Delete the relevant entries from the following files to ensure status does not continue to show as "In Progress":

   ```
   C:\Program Files\Windows Admin Center\Service\migrationStatus.json
   C:\Program Files\Windows Admin Center\Service\syncStatus.json
   ```

---

### Issue 3: Migration pre-check fails with error

**Error message:**

> *"Failed to retrieve the list of VMs from the destination server. Please ensure the destination server is reachable and retry the operation."*

**Resolution:**

- Ensure there are no **failed virtual machines** present on the same destination server.

---

### Issue 4: Static IP migration failure for Windows VMs

**Symptom:**

* Static IP configuration does not migrate successfully for a Windows VM.

**Resolution:**

1. Download the [**static IP migration package (.zip)**](https://aka.ms/hci-migrate-static-ip-download), which contains scripts for both Windows and Linux VMs.
2. Extract the package to a specified path inside the guest VM **after synchronization and before migration**.
3. Open a PowerShell window as Administrator.
4. Navigate to the extracted path.
5. Run the following command:

   ```powershell
   .\Prepare-MigratedVM.ps1 -StaticIPMigration -Verbose
   ```

