---
title: Partition and assign GPUs to a virtual machine in Hyper-V
description: Learn how to partition and share a GPU with multiple virtual machines on Windows Server.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.subservice: core-os
ms.date: 01/09/2025
#customer intent: As a customer, I want to learn how to partition and assign GPUs to a virtual machine in Hyper-V so that I can use the GPU resources efficiently.
---

# Partition and assign GPUs to a virtual machine

This article describes how to configure graphics processing unit (GPU) partitions and assign a partition to a virtual machine (VM). It provides instructions on how to configure GPU partition count, assign GPU partitions, and unassign GPU partitions via Windows Admin Center and PowerShell.

To provision the GPU partitioning feature, you need to complete the following steps:

- [Complete all the prerequisites](#prerequisites).
- [Verify GPU driver installation](#verify-gpu-driver-installation).
- [Configure partition count](#configure-gpu-partition-count).
- [Assign GPU partition to a VM](#assign-gpu-partition-to-a-vm).
- [If necessary, unassign a GPU partition from a VM](#unassign-a-partition-from-a-vm).

## Prerequisites

There are several requirements and things to consider before you begin to use the GPU partitioning feature:

### Prerequisites for the host server

- You must have Windows Server 2025 installed on the host server. If clustering is required when live migrating a virtual machine host, Windows Server 2025 Datacenter must be installed.

- The Hyper-V role installed and configured on your server. See [Install the Hyper-V role on Windows Server](get-started/Install-the-Hyper-V-role-on-Windows-Server.md) to found out how to get stared.

- Install the physical GPU device of the same make, model, and size on every server of the cluster. Refer to your OEM-provided documentation when installing the GPU device on your physical servers in the cluster.

- Install the GPU drivers on every server of the cluster by following instructions from your GPU IHVs. For NVIDIA GPU drivers, see the [NVIDIA vGPU documentation](https://docs.nvidia.com/vgpu/17.0/grid-vgpu-release-notes-microsoft-azure-stack-hci/index.html).

- Ensure that the virtualization support and SR-IOV are enabled in the BIOS of each server in the cluster. Reach out to your system vendor if you're unable to identify the correct setting in your BIOS.

- Cluster hosts need to have Input/Output Memory Management Unit (IOMMU) DMA bit tracking capable processors. For example, processors supporting Intel VT-D or AMD-Vi.

> [!NOTE]
> When live migrating a virtual machine with a GPU partition assigned, Hyper-V live migration will automatically fall back to using TCP/IP with compression. This has the potential effect of increasing the CPU utilization of a host. In addition, live migrations could take longer than with virtual machines without GPU partitions attached.

### Prerequisites for the VMs

- Deploy a VM using a guest operating system from the [Supported guest operating systems](gpu-partitioning.md#supported-guest-operating-systems) list.

- Install the GPU drivers on the VM by following instructions from your GPU IHVs. For NVIDIA GPU drivers, see the [NVIDIA vGPU documentation](https://docs.nvidia.com/vgpu/17.0/grid-vgpu-release-notes-microsoft-azure-stack-hci/index.html).

### Prerequisites for Windows Admin Center

If you're using Windows Admin Center to provision GPU partitioning, you must install the latest version of [Windows Admin Center](/windows-server/manage/windows-admin-center/deploy/install) with the **GPUs** extension, version 2.8.0 or later. For instructions on how to install the **GPUs** extensions in Windows Admin Center, see [Installing an extension](/windows-server/manage/windows-admin-center/configure/using-extensions#installing-an-extension).

After you install the extension, it appears under the **Installed extensions** tab as shown in the following screenshot. Make sure the version of the **GPUs** extension is 2.8.0 or later.

:::image type="content" source="./media/partition-assign-vm-gpu/gpu-extension.png" alt-text="Screenshot of the Installed extensions tab in Windows Admin Center to verify the GPUs extension is installed." lightbox="./media/partition-assign-vm-gpu/gpu-extension.png" :::

### Prerequisites for PowerShell

If you're using PowerShell to provision GPU partitioning, you must run all PowerShell commands as the Administrator user.

For detailed information on how to use PowerShell commands for GPU partitioning, see the [Add-VMGpuPartitionAdapter](/powershell/module/hyper-v/add-vmgpupartitionadapter), [Get-VMGpuPartitionAdapter](/powershell/module/hyper-v/get-vmgpupartitionadapter), and [Remove-VMGpuPartitionAdapter](/powershell/module/hyper-v/remove-vmgpupartitionadapter) reference documentation.

## Verify GPU driver installation

After you complete all the [prerequisites](#prerequisites), you must verify if the GPU driver is installed and partitionable.

## [Windows Admin Center](#tab/windows-admin-center)

Follow these steps to verify if the GPU driver is installed and partitionable using Windows Admin Center:

1. Launch Windows Admin Center and make sure the **GPUs** extension is already installed.

1. Select **Cluster Manager** from the top dropdown menu and connect to your cluster.

1. From the **Settings** menu, select **Extensions** > **GPUs**.

   The **GPUs** tab on the **GPU** page displays inventory of all the servers and the physical GPUs that are installed on each server.

1. Check the **Assigned status** column for each GPU for all the servers. The **Assigned status** column can have one of these statuses:

    - **Ready for DDA assignment**. Indicates that the GPU is available for DDA assignment. You can't use it for GPU partitioning.

    - **Partitioned**. Indicates that the GPU is partitionable.

    - **Paravirtualization**. Indicates that the GPU has the partitioned driver capability installed but SR-IOV on the server isn't enabled.

    - **Not assignable**. Indicates that the GPU isn't assignable because it's an older PCI-style device or switch port.

        :::image type="content" source="./media/partition-assign-vm-gpu/gpu-tab.png" alt-text="Screenshot of the GPUs tab showing the inventory of the servers and their installed GPU devices." lightbox="./media/partition-assign-vm-gpu/gpu-tab.png" :::

1. Proceed further in the GPU partitioning workflow only if the **Assigned status** column shows **Partitioned** for the GPUs in all the servers in your cluster.

## [PowerShell](#tab/powershell)

Follow these steps to verify if the GPU driver is installed and partitionable using PowerShell:

1. Connect to a server in your cluster using Remote Desktop Protocol (RDP) and run the following PowerShell command to verify if the GPU device is installed:

    ```powershell
    Get-PnpDevice -FriendlyName "<device-friendly-name>"
    ```

    For example, to list the NVIDIA A2 GPU devices, enter the following command:

    ```powershell
    Get-PnpDevice -FriendlyName "NVIDIA A2"
    ```

    Here's a sample output:

    ```powershell
    Status    Class    FriendlyName
    ------    -----    ------------
    OK        Display  NVIDIA A2
    ```

    For NVIDIA GPU devices, you can also run the NVIDIA System Management Interface, `nvidia-smi` to list the GPUs on the host server.

    If the driver is installed, you see an output similar to the following sample:

    ```powershell
    nvidia-smi
    ```

    Here's a sample output:

    ```output
    Wed Nov 30 15:22:36 2022
    +-----------------------------------------------------------------------------+
    | NVIDIA-SMI 527.27       Driver Version: 527.27       CUDA Version: N/A      |
    |-------------------------------+----------------------+----------------------+
    | GPU  Name            TCC/WDDM | Bus-Id        Disp.A | Volatile Uncorr. ECC |
    | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
    |                               |                      |               MIG M. |
    |===============================+======================+======================|
    |   0  NVIDIA A2          WDDM  | 00000000:65:00.0 Off |                    0 |
    |  0%   24C    P8     5W /  60W |  15192MiB / 15356MiB |      0%      Default |
    |                               |                      |                  N/A |
    +-------------------------------+----------------------+----------------------+
    |   1  NVIDIA A2          WDDM  | 00000000:66:00.0 Off |                    0 |
    |  0%   24C    P8     5W /  60W |  15192MiB / 15356MiB |      0%      Default |
    |                               |                      |                  N/A |
    +-------------------------------+----------------------+----------------------+

    +-----------------------------------------------------------------------------+
    | Processes:                                                                  |
    |  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
    |        ID   ID                                                   Usage      |
    |=============================================================================|
    |  No running processes found                                                 |
    +-----------------------------------------------------------------------------+
    ```

1. Run the following command to verify that the host server has the required GPU adapters installed by listing the GPUs that support GPU partitioning.

    ```powershell
    Get-VMHostPartitionableGpu | FL Name,ValidPartitionCounts
    ```

    Note down the **Name** and **ValidPartitionCounts** values from the output of the `Get-VMHostPartitionableGpu` command. You use them later to configure partition count.

    Here's a sample output of the `Get-VMHostPartitionableGpu` command, which shows that two partitionable GPU drivers are installed on this server. The configured partition count for the first GPU is 16 and for the second GPU is 4.

    ```powershell
    PS C:\Users> Get-VMHostPartitionableGPU


    Name                    : \\?\PCI#VEN_10DE&DEV_25B6&SUBSYS_157E10DE&REV_A1#4&18416dc3&0&0000#{064092b3-625e-43bf-9eb5-dc845897dd59}
    ValidPartitionCounts    : {16, 8, 4, 2...}

    Name                    : \\?\PCI#VEN_10DE&DEV_25B6&SUBSYS_157E10DE&REV_A1#4&5906f5e&0&0010#{064092b3-625e-43bf-9eb5-dc845897dd59}
    ValidPartitionCounts    : {16, 8, 4, 2...}
    ```

---

## Configure GPU partition count

Each partitionable GPU comes with a set of valid partition counts that's predefined by its OEM. You can't define the number of partitions a GPU can have. However, you can configure the partition count to any of the valid count from within the supported set.

## [Windows Admin Center](#tab/windows-admin-center)

Follow these steps to configure partition count via Windows Admin Center:

1. Select the **GPU partitions** tab to configure partition counts. You can also assign partition to VMs and unassign partitions from VMs using this tab.

    > [!NOTE]
    > If there are no partitionable GPUs available in your cluster or the correct GPU partitioning driver isn't installed, the GPU partitions tab displays the following message:
    >
    >
    > *No partitionable GPUs have been found. Please check that you have a GPU with the correct GPU-P driver to proceed.*

1. Select a GPU or a GPU partition to display its details in the bottom section of the page, under **Selected item details**. For example, if you select a GPU, it displays the GPU name, GPU ID, available encoder and decoder, available VRAM, valid partition count, and the current partition count. If you select a GPU partition, it displays the partition ID, VM ID, instance path, partition VRAM, partition encode, and partition decode.

   :::image type="content" source="./media/partition-assign-vm-gpu/gpu-partitions-tab.png" alt-text="Screenshot of the GPU partitions tab showing the inventory of the servers and their installed GPU devices. The bottom section on the page displays the details of the selected resource." lightbox="./media/partition-assign-vm-gpu/gpu-partitions-tab.png" :::

1. Select **Configure partition count**.

   The **Configure partition count on GPUs** page is displayed. For each server, it displays the GPU devices installed on them.

1. Select a set of homogeneous GPUs. A set of homogeneous GPUs is the one that has GPUs of the same size, manufacturer, model number, and number of partitions. By default, Windows Admin Center automatically selects a set of homogenous GPUs if it detects one, as shown in the following screenshot:

   :::image type="content" source="./media/partition-assign-vm-gpu/configure-partition-count.png" alt-text="Screenshot of the Configure partition count on GPUs showing the inventory of GPUs to configure the partition count." lightbox="./media/partition-assign-vm-gpu/configure-partition-count.png" :::

    You might see a warning or an error depending on what selections you make:

    - **Warning.** If you deselect one or more GPUs from the homogeneous set of GPUs, Windows Admin Center gives you a warning, but doesn't stop you from proceeding further. Warning text indicates that you're not selecting all the GPUs and it might result in different partition count, which isn't recommended.

        :::image type="content" source="./media/partition-assign-vm-gpu/warning-partial-selection-homogenous-set.png" alt-text="Screenshot showing a warning when all the GPUs within a homogeneous set aren't selected." lightbox="./media/partition-assign-vm-gpu/warning-partial-selection-homogenous-set.png" :::

    - **Warning.** If not all the GPUs across all the servers have the same configuration, Windows Admin Center gives a warning. You must manually select the GPUs with the same configuration to proceed further.

        :::image type="content" source="./media/partition-assign-vm-gpu/warning-different-configuration.png" alt-text="Screenshot showing a warning when you have GPUs with different configurations." lightbox="./media/partition-assign-vm-gpu/warning-different-configuration.png" :::

    - **Error.** If you select GPUs with different configurations, Windows Admin Center gives you an error, and doesn't let you proceed.

        :::image type="content" source="./media/partition-assign-vm-gpu/error-different-configuration.png" alt-text="Screenshot showing an error when you select GPUs with different configurations." lightbox="./media/partition-assign-vm-gpu/error-different-configuration.png" :::

    - **Error.** If you select a GPU partition that is already assigned to a VM, Windows Admin Center gives you an error, and doesn't let you proceed. You must first unassign the partition from the VM before proceeding further. See [Unassign a partition from a VM](#unassign-a-partition-from-a-vm).

        :::image type="content" source="./media/partition-assign-vm-gpu/error-assigned-partition-selection.png" alt-text="Screenshot showing an error when you select a partition that is already assigned to a VM." lightbox="./media/partition-assign-vm-gpu/error-assigned-partition-selection.png" :::

1. After you select a homogeneous set of GPUs, select the partition count from the **Number of Partitions** dropdown list. This list automatically populates the partition counts configured by your GPU manufacturer. The counts displayed in the list can vary depending on the type of GPU you selected.

    As soon as you select a different partition count, a tooltip appears below the dropdown list, which dynamically displays the size of VRAM that each partition gets. For example, if the total VRAM is 16 GB for 16 partitions in the GPU, changing the partition count from 16 to 8 assigns each partition with 1.85 GB of VRAM.

    :::image type="content" source="./media/partition-assign-vm-gpu/tooltip-about-vram.png" alt-text="Screenshot showing the tooltip that appears when you select a different partition count." lightbox="./media/partition-assign-vm-gpu/tooltip-about-vram.png" :::

1. Select **Configure partition count**.

   After the partition count is configured, Windows Admin Center notifies you that the partition count is successfully configured and displays the **GPU partitions** tab again. You can see the new partition count for the GPU partition under the **Partition count** column.

## [PowerShell](#tab/powershell)

Follow these steps to configure GPU partition count in PowerShell:

> [!NOTE]
> When using PowerShell, you must manually ensure the GPU configuration is homogenous across all the servers in your cluster.

1. Refer to the **Name** and **ValidPartitionCounts** values you noted earlier when you ran the `Get-VMHostPartitionableGpu` command. See the PowerShell tab in the [Verify GPU driver installation](#verify-gpu-driver-installation) previous section.

1. Connect to the server whose GPU partition count you want to configure.

1. Run the following command to configure the partition count. Replace `GPU-name` with the **Name** value and `partition-count` with one of the supported counts from the **ValidPartitionCounts** value:

    ```powershell
    Set-VMHostPartitionableGpu -Name "<GPU-name>" -PartitionCount <partition-count>
    ```

    For example, the following command configures the partition count to 4:

    ```powershell
    PS C:\Users> Set-VMHostPartitionableGpu -Name "\\?\PCI#VEN_10DE&DEV_25B6&SUBSYS_157E10DE&REV_A1#4&18416dc3&0&0000#{064092b3-625e-43bf-9eb5-dc845897dd59}" -PartitionCount 4
    ```

    You can run the `Get-VMHostPartitionableGpu | FL Name,ValidPartitionCounts,PartitionCount` again to verify if the partition count is set to 4.

    Here's a sample output:

    ```powershell
    PS C:\Users> Get-VMHostPartitionableGpu | FL Name,ValidPartitionCounts,PartitionCount

    Name                    : \\?\PCI#VEN_10DE&DEV_25B6&SUBSYS_157E10DE&REV_A1#4&18416dc3&0&0000#{064092b3-625e-43bf-9eb5-dc845897dd59}
    ValidPartitionCounts    : {16, 8, 4, 2...}
    PartitionCount          : 4

    Name                    : \\?\PCI#VEN_10DE&DEV_25B6&SUBSYS_157E10DE&REV_A1#4&5906f5e&0&0010#{064092b3-625e-43bf-9eb5-dc845897dd59}
    ValidPartitionCounts    : {16, 8, 4, 2...}
    PartitionCount          : 4
    ```

1. To keep the configuration homogeneous, repeat the partition count configuration steps on each server in your cluster.

---

## Assign GPU partition to a VM

Save your workloads before assigning partition to the VM.

> [!NOTE]
> Currently, you can assign only a single GPU partition to a VM. Both the VM and the GPU partition need to be on the same host machine. We recommend that you plan ahead and determine the GPU partition size based on your workload performance requirements.

## [Windows Admin Center](#tab/windows-admin-center)

You must save your workloads before assigning partitions. If your VM is currently turned on or running, Windows Admin Center automatically turns it off, assigns the partition, and then automatically turns it on.

1. On the **GPU partitions** tab, select **+ Assign partition**.

    :::image type="content" source="./media/partition-assign-vm-gpu/assign-partition.png" alt-text="Screenshot showing the GPU partitions tab with the Assign partition option highlighted." lightbox="./media/partition-assign-vm-gpu/assign-partition.png" :::

    The **Assign GPU partition to VM** page is displayed.

1. From **Choose the server** list, select the server where the VM resides. This list displays all the servers in your cluster.

1. Search for and select the VM to assign the GPU partition to. The list automatically populates the VMs that reside on the server that you selected in step 2.

    - If a GPU partition is already assigned to a VM, that VM appears as grayed out.

    - Select all the VMs at once by selecting the **Select All** checkbox.

1. Select the available VRAM options. The value in this field must match the size of the partition count that you configured.

1. (Optional, but recommended) Select the **Configure offline action for force shutdown** checkbox if you want your VM to be highly available and fail over if its host server goes down.

1. Select **Assign partition**. This assigns partition of the selected VRAM size to the selected VM on the selected host server.

    :::image type="content" source="./media/partition-assign-vm-gpu/assign-gpu-partition.png" alt-text="Screenshot showing the Assign GPU partition to VM page." lightbox="./media/partition-assign-vm-gpu/assign-gpu-partition.png" :::

    After the partition is assigned, Windows Admin Center notifies you that the partition is successfully assigned and displays the **GPU partitions** tab again. On the **GPU partitions** tab, the VM appears on the GPU partition row under the server it's installed on.

## [PowerShell](#tab/powershell)

Follow these steps to assign GPU partition to a VM using PowerShell:

1. Connect to the server hosting the VM to which you want to assign a GPU partition.

1. Run the following command to configure the cluster VM resource’s default offline action as `force-shutdown` rather than `save`.

    ```powershell
    Get-ClusterResource -name vmname | Set-ClusterParameter -Name "OfflineAction" -Value 3
    ```

    > [!NOTE]
    > If a failure occurs, you need to shutdown the VM, drain the server, and manually fail over the VM to another server.

1. To assign the partition, run the following command.

    ```powershell
    Add-VMGpuPartitionAdapter -VMName $VMName
    ```

1. To verify if the partition is assigned, run the following command.

    ```powershell
    Get-VMGpuPartitionAdapter -VMName $VMName | FL InstancePath,PartitionId,PartitionVfLuid
    ```

    For example, run the following commands to first assign a partition to the **mytestgpu-vm1** VM and then verify the assignment:

    ```powershell
    $VMname = "mytestgpu-vm1"
    Add-VMGpuPartitionAdapter -VMName $VMName
    Get-VMGpuPartitionAdapter -VMName $VMName | FL InstancePath,PartitionId,PartitionVfLuid
    ```

    Here's a sample output:

    ```powershell
    InstancePath            : \\?\PCI#VEN_10DE&DEV_25B6&SUBSYS_157E10DE&REV_A1#4&18416dc3&0&0000#{064092b3-625e-43bf-9eb5-dc845897dd59}
    PartitionId             : 0
    PartitionVfLuid         : 10-973909323
    ```

1. Start the VM using PowerShell or Windows Admin Center to resolve the partitions.

    The next step is to start the VM using PowerShell or Windows Admin Center. Once the VM is up and running, it shows a GPU in Device Manager.

---

## Unassign a partition from a VM

You can unassign a GPU partition from the VM if you no longer need it to run your workloads. Unassigning the partition frees up the GPU partition resource, which you can reassign to another VM later.

You must save your workloads before unassigning partitions.

## [Windows Admin Center](#tab/windows-admin-center)

If your VM is currently turned on or running, Windows Admin Center automatically turns it off first, unassigns the partition, then automatically turns it on.

Follow these steps to unassign a partition from a VM:

1. On the **GPU partitions** tab, select the GPU partition that you want to unassign.

1. Select **- Unassign partition**.

    :::image type="content" source="./media/partition-assign-vm-gpu/unassign-partition.png" alt-text="Screenshot showing the GPU partitions tab with the Unassign partition option highlighted." lightbox="./media/partition-assign-vm-gpu/unassign-partition.png" :::

    The **Unassign GPU partition from VM** page is displayed.

1. From **Choose the server** list, select the server that has the GPU partition that you want to unassign.

1. From **Choose virtual machine to unassign partition from** list, search, or select the VM to unassign the partition from.

1. Select **Unassign partition**.

    :::image type="content" source="./media/partition-assign-vm-gpu/unassign-gpu-partition.png" alt-text="Screenshot showing the Unassign GPU partition from VM page." lightbox="./media/partition-assign-vm-gpu/unassign-gpu-partition.png" :::

    After the partition is unassigned, Windows Admin Center notifies you that the partition is successfully unassigned and displays the **GPU partitions** tab again. On the **GPU partitions** tab, the VM from which the partition is unassigned no longer shows on the GPU partition row.

## [PowerShell](#tab/powershell)

Follow these steps to unassign a GPU partition from a VM using PowerShell:

1. Connect to the server hosting the VM from which you want to unassign the GPU partition.

1. Run the following command to configure the cluster VM resource’s default offline action as `force-shutdown` rather than `save`.

    ```powershell
    Get-ClusterResource -name vmname | Set-ClusterParameter -Name "OfflineAction" -Value 3
    ```

    > [!NOTE]
    > If a failure occurs, you need to shutdown the VM, drain the server, and manually fail over the VM to another server.
1. Run the following command to remove the partition:

    ```powershell
    Remove-VMGpuPartitionAdapter -VMName $VMname
    ```

1. Run the following command to confirm the partition is removed. If the partition is removed, this command doesn't return anything.

    ```powershell
    Get-VMGpuPartitionAdapter -VMName $VMName
    ```

---


