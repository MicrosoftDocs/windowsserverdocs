---
title: Use GPUs with clustered VMs on Hyper-V
description: Learn how to use GPUs with clustered virtual machines (VMs) to provide GPU acceleration to workloads in the clustered VMs on Windows Server and Azure Stack HCI.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 05/17/2024
zone_pivot_groups: windows-os
#customer intent: As a virtualization administrator, I want to use GPUs with clustered VMs to provide GPU acceleration to workloads in the clustered VMs on Windows Server or Azure Stack HCI.
---

# Use GPUs with clustered VMs

:::zone pivot="windows-server"
>Applies to: Windows Server 2025 (preview)

> [!IMPORTANT]
> GPU with clustered VMs in Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
::: zone-end

:::zone pivot="azure-stack-hci"

[!INCLUDE [applies-to](~/../_azurestack/azure-stack/includes/hci-applies-to-23h2-22h2.md)]

[!INCLUDE [hci-arc-vm](~/../_azurestack/azure-stack/includes/hci-arc-vm.md)]

::: zone-end

You can include GPUs in your clusters to provide GPU acceleration to workloads running in clustered VMs. GPU acceleration is provided via Discrete Device Assignment (DDA), which allows you to dedicate one or more physical GPUs to a VM. Clustered VMs can take advantage of GPU acceleration, and clustering capabilities such as high availability via failover. Live migrating VMs isn't currently supported, but VMs can be automatically restarted and placed where GPU resources are available in the event of a failure.

In this article learn how to use graphics processing units (GPUs) with clustered virtual machines (VMs) to provide GPU acceleration to workloads in the clustered VMs. The article guides you through preparing the cluster, assigning a GPU to a cluster VM, and failing over that VM using Windows Admin Center and PowerShell.

## Prerequisites

There are several requirements and things to consider before you begin to use GPUs with clustered VMs:

:::zone pivot="azure-stack-hci"

- You need an Azure Stack HCI cluster running Azure Stack HCI, version 21H2 or later.

::: zone-end

:::zone pivot="windows-server"

- You need an Windows Server Failover cluster running Windows Server 2025 or later.

::: zone-end

- You’ll also need GPUs that are physically installed in every server of the cluster.

- Review and follow the instructions from your GPU manufacturer to install the necessary drivers and software on each server in the cluster.

- Create a VM to assign the GPU to. Prepare that VM for DDA by setting its cache behavior, stop action, and memory-mapped I/O (MMIO) properties according to the instructions in [Deploy graphics devices using Discrete Device Assignment](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda).

:::zone pivot="azure-stack-hci"

>[!NOTE]
> The Azure Stack HCI Catalog does not yet indicate GPU compatibility or certification information.

::: zone-end

## Prepare the cluster

After you've completed all the [prerequisites](#prerequisites), you must prepare the cluster to use GPUs with clustered VMs. This involves creating a resource pool that contains the GPUs that are available for assignment to VMs. The cluster uses this pool to determine VM placement for any started or moved VMs that are assigned to the GPU resource pool.

### [Windows Admin Center](#tab/windows-admin-center)

Follow these steps to prepare the cluster to use GPUs with clustered VMs using Windows Admin Center.

To prepare the cluster and assign a VM to a GPU resource pool:

1. Launch Windows Admin Center and make sure the **GPUs** extension is already installed.

1. Select **Cluster Manager** from the top dropdown menu and connect to your cluster.

1. From the **Settings** menu, select **Extensions** > **GPUs**.

1. On the **Tools** menu, under **Extensions**, select **GPUs** to open the tool.

   :::image type="content" source="media/use-gpu-with-clustered-vm/gpu-extension.png" alt-text="Screenshot of the GPU tool in Windows Admin Center" lightbox="media/use-gpu-with-clustered-vm/gpu-extension.png":::

1. On tool's main page, select the **GPU pools** tab, and then select **Create GPU pool**.

   :::image type="content" source="media/use-gpu-with-clustered-vm/create-gpu-pool.png" alt-text="Screenshot of the Create GPU pools page in Windows Admin Center" lightbox="media/use-gpu-with-clustered-vm/create-gpu-pool.png":::

1. On the **New GPU pool** page, specify the following and then select **Save**:
   1. **Server** name
   1. **GPU pool** name
   1. **GPUs** that you want to add to the pool

   :::image type="content" source="media/use-gpu-with-clustered-vm/new-gpu-pool.png" alt-text="Screenshot of the New GPU pool page in Windows Admin Center to specify servers, pool name, and GPUs" lightbox="media/use-gpu-with-clustered-vm/new-gpu-pool.png":::

   After the process completes, you'll receive a success prompt that shows the name of the new GPU pool and the host server.

### [PowerShell](#tab/powershell)

Follow these steps to prepare the cluster to use GPUs with clustered VMs using PowerShell.

Prepare the GPUs in each server by installing security mitigation drivers on each server, disabling the GPUs, and dismounting them from the host according to the instructions in [Deploy graphics devices using Discrete Device Assignment](/windows-server/virtualization/hyper-v/deploy/deploying-graphics-devices-using-dda). Depending on your hardware vendor, you may also need to configure any GPU licensing requirements.

1. Create a new empty resource pool on each server that will contain the clustered GPU resources. Make sure to provide the same pool name on each server.

    In PowerShell, run the following cmdlet as an administrator:

   ```PowerShell
    New-VMResourcePool -ResourcePoolType PciExpress -Name "GpuChildPool"
   ```

1. Add the dismounted GPUs from each server to the resource pool that you created in the previous step.

    In PowerShell, run the following cmdlets:

   ```PowerShell
    $gpu = Get-VMHostAssignableDevice
   ```

   ```PowerShell
    Add-VMHostAssignableDevice -HostAssignableDevice $gpu -ResourcePoolName "GpuChildPool"
   ```

You now have a cluster-wide resource pool (named `GpuChildPool`) that is populated with assignable GPUs. The cluster will use this pool to determine VM placement for any started or moved VMs that are assigned to the GPU resource pool.

---

## Assign a VM to a GPU resource pool

Now that you've prepared the cluster to use GPUs with clustered VMs, you can assign a VM to a GPU resource pool. You can assign one or more VMs to a clustered GPU resource pool, and remove a VM from a clustered GPU resource pool.

### [Windows Admin Center](#tab/windows-admin-center)

Follow these steps to assign an existing VM to a GPU resource pool using Windows Admin Center.

1. On the **Assign VM to GPU pool** page, specify the following and then select **Assign**:
   1. **Server** name
   1. **GPU pool** name
   1. **Virtual machine** that you want to assign the GPU to from the GPU pool.

   You can also define advanced setting values for memory-mapped IO (MMIO) spaces to determine resource requirements for a single GPU.

   :::image type="content" source="media/use-gpu-with-clustered-vm/assign-vm-to-gpu-pool.png" alt-text="Screenshot of the Assign VM to GPU pool page in Windows Admin Center where you assign a VM to a GPU from the GPU pool" lightbox="media/use-gpu-with-clustered-vm/assign-vm-to-gpu-pool.png":::

   After the process completes, you'll receive a confirmation prompt that shows you successfully assigned the GPU from the GPU resource pool to the VM, which displays under **Assigned VMs**.

   :::image type="content" source="media/use-gpu-with-clustered-vm/gpu-assigned-to-vm-confirmed.png" alt-text="Screenshot of success prompt showing GPU assigned to a VM and the VM displaying under Assigned VMs" lightbox="media/use-gpu-with-clustered-vm/gpu-assigned-to-vm-confirmed.png":::

To unassign a VM from a GPU resource pool:

1. On the **GPU pools** tab, select the GPU that you want to unassign, and then select **Unassign VM**.

1. On the **Unassign VM from GPU pool** page, in the **Virtual machines** list box, specify the name of the VM, and then select **Unassign**.

   :::image type="content" source="media/use-gpu-with-clustered-vm/unassign-vm-from-gpu-pool.png" alt-text="Screenshot of Unassign VM from GPU pool page showing VM to be unassigned" lightbox="media/use-gpu-with-clustered-vm/unassign-vm-from-gpu-pool.png":::

   After the process completes, you'll receive a success prompt that the VM has been unassigned from the GPU pool, and under **Assignment status** the GPU shows **Available (Not assigned)**.

### [PowerShell](#tab/powershell)

Follow these steps to assign an existing VM to a GPU resource pool using PowerShell.

1. Configure the cluster VM resource’s default offline action as `force-shutdown` rather than `save`.

    In PowerShell, run the following cmdlet:

   ```PowerShell
    Get-ClusterResource -name vmname | Set-ClusterParameter -Name "OfflineAction" -Value 3
   ```

1. Assign the resource pool that you created earlier to the VM. This declares to the cluster that the VM requires an assigned device from the `GpuChildPool` pool when it's either started or moved.

    In PowerShell, run the following cmdlet:

   ```PowerShell
    $vm | Add-VMAssignableDevice -ResourcePoolName "GpuChildPool"
   ```

   >[!NOTE]
   > If you want to add more than one GPU to the VM, first verify that the resource pool has more than one assignable GPU available, and then run the previous command again.

If you start the VM now, the cluster ensures that it is placed on a server with available GPU resources from this cluster-wide pool. The cluster also assigns the GPU to the VM through DDA, which allows the GPU to be accessed from workloads inside the VM.

   >[!NOTE]
   > You also need to install drivers from your GPU manufacturer inside the VM so that apps in the VM can take advantage of the GPU assigned to them.

You can also remove an assigned GPU from a VM. To do so, in PowerShell, run the following cmdlet:

   ```PowerShell
    Get-VMAssignableDevice -VMName $vm | Where-Object { $_.ResourcePoolName -eq "GpuChildPool" } | Remove-VMAssignableDevice
   ```

---

## Fail over a VM with an assigned GPU

:::zone pivot="windows-server"
To test the cluster’s ability to keep your GPU workload available, perform a drain operation on the server where the VM is running with an assigned GPU. To drain the server, follow the instructions in [Failover cluster maintenance procedures](/azure-stack/hci/manage/maintain-servers?toc=/windows-server/administration/toc.json&bc=/windows-server/breadcrumbs/toc.json). The cluster will restart the VM on another server in the cluster, as long as another server has sufficient available GPU resources in the pool that you created.
:::zone-end

:::zone pivot="azure-stack-hci"
To test the cluster’s ability to keep your GPU workload available, perform a drain operation on the server where the VM is running with an assigned GPU. To drain the server, follow the instructions in [Failover cluster maintenance procedures](/azure-stack/hci/manage/maintain-servers). The cluster will restart the VM on another server in the cluster, as long as another server has sufficient available GPU resources in the pool that you created.
:::zone-end

## Related content

:::zone pivot="windows-server"

For more information on using GPUs with your clustered VMs, see:

- [Manage VMs with Windows Admin Center](/azure-stack/hci/manage/vm?toc=/windows-server/administration/toc.json&bc=/windows-server/breadcrumbs/toc.json)
- [Plan for deploying devices by using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md)

:::zone-end

:::zone pivot="azure-stack-hci"

For more information on using GPUs with your VMs and GPU partitioning, see:

- [Manage VMs with Windows Admin Center](/azure-stack/hci/manage/vm)
- [Plan for deploying devices by using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md?pivots=azure-stack-hci&toc=/azure-stack/hci/toc.json&bc=/azure-stack/breadcrumb/toc.json)

:::zone-end
