---
title: Dynamic Processor compatibility mode
description: Describes how to use dynamic processor compatibility mode to move a live virtual machine or move a saved virtual machine on Windows Server and Azure Local.
ms.topic: how-to
author: meaghanlewis
ms.author: mosagie
ms.date: 07/03/2024
ms.subservice: core-os
zone_pivot_groups: windows-os
---

# Dynamic processor compatibility mode

:::zone pivot="windows-server"
> 

::: zone-end

:::zone pivot="azure-local"

[!INCLUDE [applies-to](~/../_azurestack/azure-local//includes/hci-applies-to-22h2.md)]

::: zone-end

The dynamic processor compatibility mode is updated to take advantage of new processor capabilities in a clustered environment. Processor compatibility works by determining the supported processor features for each individual node in the cluster and calculating the common denominator across all processors. Virtual machines (VMs) are configured to use the maximum number of features available across all servers in the cluster. This improves performance compared to the previous version of processor compatibility that defaulted to a minimal, fixed set of processor capabilities.

## When to use processor compatibility mode

Processor compatibility mode allows you to move a live VM (live migrating) or move a VM that is saved between nodes with different process capability sets. However, even when processor compatibility is enabled, you can't move VMs between hosts with different processor manufacturers. For example, you can't move running VMs or saved state VMs from a host with Intel processors to a host with AMD processors. If you must move a VM in this manner, shut down the VM first, then restart it on the new host.

> [!IMPORTANT]
> Only Hyper-V VMs with the latest configuration version (10.0) benefit from the dynamic configuration. VMs with older versions don't benefit from the dynamic configuration and won't continue to use [fixed processor capabilities](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn859550(v=ws.11)) from the previous version.

:::zone pivot="azure-local"

We recommend enabling processor compatibility mode for VMs running on Azure Local. This provides the highest level of capabilities, and when it's time to migrate to new hardware, moving the VMs doesn't require downtime.

:::zone-end

> [!NOTE]
> You don't need to use processor compatibility mode if you plan to stop and restart the VMs. Any time a VM is restarted, the guest operating system enumerates the processor compatibilities that are available on the new host computer.

## Why processor compatibility mode is needed

Processor manufacturers often introduce optimizations and capabilities in their processors. These capabilities often improve performance or security by using specialized hardware for a particular task. For example, many media applications use processor capabilities to speed up vector calculations. These features are rarely required for applications to run; they boost performance.

The capability set that's available on a processor varies depending on its make, model, and age. Operating systems and application software typically enumerate the system’s processor capability set when they're first launched. Software doesn't expect the available processor capabilities to change during their lifetime, which never happens when running on a physical computer, because processor capabilities are static unless the processor upgrades.

However, VM mobility features allow a running VM to be migrated to a new virtualization host. If software in the VM detects and starts using a particular processor capability, and then the VM is moved to a new virtualization host without that capability, the software will likely fail. This could result in the application or VM crashing.

To avoid failures, Hyper-V performs “preflight” checks whenever a VM live migration or save/restore operation is initiated. These checks compare the set of processor features that are available to the VM on the source host against the set of features that are available on the target host. If these feature sets don't match, the migration or restore operation is canceled.

## What's new in processor compatibility mode

In the past, all new processor instructions sets were hidden, meaning that the guest operating system and application software couldn't use processor instruction set enhancements to help applications and VMs stay performant.

To overcome this limitation, processor compatibility mode now provides enhanced, dynamic capabilities on processors capable of second-level address translation (SLAT). This new functionality calculates the common denominator of the CPU features supported by the nodes in the cluster and updates the existing processor compatibility mode on a VM to use this dynamically calculated feature set instead of the old hard-coded feature set.

The new processor compatibility mode ensures that the set of processor features available to VMs across virtualization hosts match by presenting a common capability set across all servers in the cluster. Each VM receives the maximum number of processor instruction sets that are present across all servers in the cluster. This process occurs automatically and is always enabled and replicated across the cluster, so there's no command to enable or disable the process.

## Using processor compatibility mode

There are important concepts to understand when using processor compatibility mode in Hyper-V:

  - Running VMs can only be migrated between virtualization hosts that use processors from the same manufacturer.

  - You must shut down the VM before you can enable or disable processor compatibility mode.

  - Processor compatibility mode isn't needed for VM moves that involve a stop and restart of the VM.

  - Anytime a VM is restarted, the guest operating system enumerates the processor features that are available on the new host computer.

:::zone pivot="windows-server"

   > [!NOTE]
   > In Windows Server, Microsoft recommends turning on processor compatibility mode only before VM migration scenarios, and then turning it off when the migration is complete.

:::zone-end

## Migrating running VMs between clusters

Assuming that all servers in each cluster are running the same hardware, it's possible to live migrate running VMs between clusters. There are three common scenarios.

- **Live migrating a VM from a cluster with new processors to a cluster with the same processors.** The VM capabilities are transferred to the destination cluster. This scenario doesn't require processor compatibility mode to be enabled; however, leaving it enabled won't cause any problems.

- **Live migrating a VM from a cluster with older processors to a cluster with newer processors.** The VM capabilities are transferred to the destination cluster. In this scenario, if the VM is restarted, it receives the latest calculated capability of the destination cluster.

- **Live migrating a VM from a cluster with newer processors to a cluster with older processors.** You'll need to set the VM processor to use the `MinimumFeatureSet` for the `CompatibilityForMigrationMode` parameter in PowerShell, or select **Compatible across other hosts with the same CPU manufacturer** in Windows Admin Center under **Virtual machines > Settings > Processors**. This setting assigns the VM to the minimum processor capabilities offered on the server. Once the compatibility is moved to **Compatible across the cluster (Recommended)** and the VM is restarted, it receives the latest calculated capability of the destination cluster.

## Ramifications of using processor compatibility mode

It's difficult to quantify the overall performance effects of processor compatibility mode. The performance loss is primarily dependent on the workload running in the VM. Some workloads may be unaffected, while others show a noticeable difference. Software that heavily relies on hardware optimizations (such as encryption, compression, or intensive floating-point calculations) is impacted the most.

Applications that encrypt or decrypt a large amount of data benefit from this processor feature, so turning it off by enabling processor compatibility mode impacts the performance of these specific operations.

If you're concerned about the performance impact of processor compatibility mode, it's best to compare VM workload performance with processor compatibility mode enabled and with it disabled.

## Configure a VM to use processor compatibility mode

:::zone pivot="azure-local"

This section explains how to configure a VM to use processor compatibility mode. It's possible to run VMs with and without compatibility mode in the same cluster.

> [!IMPORTANT]
> You must shut down the VM before you can enable or disable processor compatibility mode.

### Enable processor compatibility mode using Windows Admin Center

To enable processor compatibility mode using Windows Admin Center:

1. Connect to your cluster, and then in the **Tools** pane, select **Virtual machines**.

1. Under **Inventory**, select the VM on which you want to enable processor compatibility mode, expand the **Power** menu, then select **Shut down**.

1. Select **Settings**, then **Processors**, and check the box for **Processor compatibility**.

:::image type="content" source="media/dynamic-processor-compatibility-mode/processor-compatibility.png" alt-text="Screenshot of the checkbox to enable processor compatibility." lightbox="media/dynamic-processor-compatibility-mode/processor-compatibility.png":::

1. If you want to set the VM's CPU features to the maximum level supported by all servers in a cluster, select **Compatible across the cluster (Recommended)**. This maximizes VM performance while preserving the ability to move the running VM to other servers in the cluster. We recommend enabling this for all VMs running on Azure Local 21H2 clusters. If disabled, the VM must be restarted to move to a host with a different level of supported CPU instructions, common with different generations of CPUs.

   Alternatively, if you want to set the VM's CPU features to minimum to ensure that you can move the running VM to other Hyper-V hosts outside the cluster as long as they have the same CPU manufacturer, select **Compatible across other hosts with the same CPU manufacturer**.

1. Select **Save processor settings** and restart the VM.

:::zone-end

:::zone pivot="windows-server"

This section explains how to configure a VM to use processor compatibility mode using either Hyper-V manager or PowerShell. It's possible to run VMs with and without compatibility mode in the same cluster.

> [!IMPORTANT]
> You must shut down the VM before you can enable or disable processor compatibility mode.

### Enable processor compatibility mode using Hyper-V Manager

To enable processor compatibility mode for a VM using Hyper-V Manager:

1. Shut down the VM.  

1. Select **Start**, point to **Administrative Tools**, and then select **Hyper-V Manager**.

1.  Select the server running Hyper-V and the desired VM.

1.  If the VM is running, you must shut down the VM to enable the processor compatibility mode setting.

1.  In the Action pane, select **Settings**, and then select **Processor**.

1.  Expand **Processor**, and select **Compatibility**.

1.  Select **Migrate to a physical computer with a different processor**, and then select **OK**.

1. Restart the VM.

### Disable processor compatibility mode using Hyper-V Manager

To disable processor compatibility mode for a VM using Hyper-V Manager:

1. Shut down the VM.  

1. Select **Start**, point to **Administrative Tools**, and then select **Hyper-V Manager**.

1.  Select the server running Hyper-V and the desired VM.

1.  If the VM is running, you must shut down the VM to disable the processor compatibility mode setting.

1.  In the Action pane, select **Settings**, and then select **Processor**.

1.  Expand **Processor**, and select **Compatibility**.

1.  De-select the **Migrate to a physical computer with a different processor** checkbox, and then select **OK**.

1. Restart the VM.

:::zone-end

### Enable processor compatibility mode using PowerShell

To enable processor compatibility mode, run the following cmdlet:

```PowerShell
get-vm -name <name of VM> -ComputerName <target cluster or host> | Set-VMProcessor -CompatibilityForMigrationEnabled $true 
```

We recommend setting the VM's CPU features to the maximum level supported by all servers in the cluster. This maximizes VM performance while preserving the ability to move the running VM to other servers in the cluster. 

To enable the VM to use the cluster node common features, run the following cmdlet:

```PowerShell
get-vm -name <name of VM> -ComputerName <target cluster or host> | Set-VMProcessor -CompatibilityForMigrationEnabled $true -CompatibilityForMigrationMode CommonClusterFeatureSet
```

Alternatively, you can set the VM's CPU features to minimum, ensuring that you can move the running VM to other Hyper-V hosts outside the cluster if they have the same CPU manufacturer.

To enable the VM to use the default minimum features to migrate across clusters, run the following cmdlet:

```PowerShell
get-vm -name <name of VM> -ComputerName <target cluster or host> | Set-VMProcessor -CompatibilityForMigrationEnabled $true -CompatibilityForMigrationMode MinimumFeatureSet
```

### Disable processor compatibility mode using PowerShell

To disable processor compatibility mode for a VM using PowerShell, shut down the VM and run the `Set-VMProcessor` cmdlet, setting `CompatibilityForMigrationEnabled` to **$false**:

```PowerShell
get-vm -name <name of VM> -ComputerName <target cluster or host> | Set-VMProcessor -CompatibilityForMigrationEnabled $false
```

Then restart the VM.
