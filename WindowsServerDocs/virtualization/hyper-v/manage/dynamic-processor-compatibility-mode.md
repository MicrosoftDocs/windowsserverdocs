---
title: Dynamic Processor compatibility mode
description: Describes how to use dynamic processor compatibility mode to move a live virtual machine or move a saved virtual machine on Windows Server and Azure Stack HCI.
ms.topic: how-to
author: meaghanlewis
ms.author: mosagie
ms.date: 10/06/2021
zone_pivot_groups: windows-os
---

# Dynamic processor compatibility mode

:::zone pivot="windows-server"
> Applies to: Windows Server 2025

::: zone-end

:::zone pivot="azure-stack-hci"

[!INCLUDE [applies-to](~/../_azurestack/azure-stack/includes/hci-applies-to-23h2-22h2.md)]

::: zone-end

The dynamic processor compatibility mode has been updated to take advantage of new processor capabilities in a clustered environment. Processor compatibility works by determining the supported processor features for each individual node in the cluster and calculating the common denominator across all processors. Virtual machines (VMs) are configured to use the maximum number of features available across all servers in the cluster. This improves performance compared to the previous version of processor compatibility that defaulted to a minimal, fixed set of processor capabilities.

## When to use processor compatibility mode

Processor compatibility mode allow you to move a live VM (live migrating) or move a VM that is saved between nodes with different process capability sets. However, even when processor compatibility is enabled, you can't move VMs between hosts with different processor manufacturers. For example, you can't move running VMs or saved state VMs from a host with Intel processors to a host with AMD processors. If you must move a VM in this manner, shut the VM down first, then restart it on the new host.

    > [!IMPORTANT]
    > Only Hyper-V VMs with the latest configuration version (10.0) benefit from the dynamic configuration. VMs with older versions won't benefit from the dynamic configuration and will continue to use fixed processor capabilities from the previous version.

:::zone pivot="azure-stack-hci"

We recommend enabling processor compatibility mode for VMs running on Azure Stack HCI. This provides the highest level of capabilities, and when it's time to migrate to new hardware, moving the VMs won't require downtime.

   > [!NOTE]
   > You don't need to use processor compatibility mode if you plan to stop and restart the VMs. Any time a VM is restarted, the guest operating system will enumerate the processor compatibilities that are available on the new host computer.

:::zone-end

## Why processor compatibility mode is needed

Processor manufacturers often introduce optimizations and capabilities in their processors. These capabilities often improve performance or security by using specialized hardware for a particular task. For example, many media applications use processor capabilities to speed up vector calculations. These features are rarely required for applications to run; they simply boost performance.

The capability set that's available on a processor varies depending on its make, model, and age. Operating systems and application software typically enumerate the system’s processor capability set when they are first launched. Software does not expect the available processor capabilities to change during their lifetime, and of course, this could never happen when running on a physical computer because processor capabilities are static unless the processor is upgraded.

However, VM mobility features allow a running VM to be migrated to a new virtualization host. If software in the VM has detected and started using a particular processor capability, and the VM gets moved to a new virtualization host that lacks that capability, the software is likely to fail. This could result in the application or VM crashing.

To avoid failures, Hyper-V performs “pre-flight” checks whenever a VM live migration or save/restore operation is initiated. These checks compare the set of processor features that are available to the VM on the source host against the set of features that are available on the target host. If these feature sets don't match, the migration or restore operation is canceled.

## What's new in processor compatibility mode

In the past, all new processor instructions sets were hidden, meaning that the guest operating system and application software could not take advantage of new processor instruction set enhancements to help applications and VMs stay performant.

To overcome this limitation, processor compatibility mode has been updated to provide enhanced, dynamic capabilities on processors capable of second-level address translation (SLAT). This new functionality calculates the common denominator of the CPU features supported by the nodes in the cluster and updates the existing processor compatibility mode on a VM to use this dynamically calculated feature set instead of the old hard-coded feature set.

:::zone pivot="azure-stack-hci"

In Azure Stack HCI environments, the new processor compatibility mode ensures that the set of processor features available to VMs across virtualization hosts match by presenting a common capability set across all servers in the cluster. Each VM receives the maximum number of processor instruction sets that are present across all servers in the cluster. This process occurs automatically and is always enabled and replicated across the cluster, so there's no command to enable or disable the process.

:::zone-end

## Migrating running VMs between clusters

:::zone pivot="azure-stack-hci"

Assuming that all servers in each cluster are running the same hardware, which is a requirement for Azure Stack HCI, it's possible to live migrate running VMs between clusters. There are three common scenarios.

:::zone-end

- **Live migrating a VM from a cluster with new processors to a cluster with the same processors.** The VM capabilities will be transferred to the destination cluster. This scenario doesn't require processor compatibility mode to be enabled; however, leaving it enabled will not cause any problems.

- **Live migrating a VM from a cluster with older processors to a cluster with newer processors.** The VM capabilities will be transferred to the destination cluster. In this scenario, if the VM is restarted, it will receive the latest calculated capability of the destination cluster.

- **Live migrating a VM from a cluster with newer processors to a cluster with older processors.** You'll need to set the VM processor to use the `MinimumFeatureSet` for the `CompatibilityForMigrationMode` parameter in PowerShell, or select **Compatible across other hosts with the same CPU manufacturer** in Windows Admin Center under **Virtual machines > Settings > Processors**. This will assign the VM to the minimum processor capabilities offered on the server. Once the compatibility is moved to **Compatible across the cluster (Recommended)** and the VM is restarted, it will receive the latest calculated capability of the destination cluster.

## Configure a VM to use processor compatibility mode

This section explains how to configure a VM to use processor compatibility mode by using either Windows Admin Center or PowerShell. It's possible to run VMs with and without compatibility mode in the same cluster.

   > [!IMPORTANT]
   > You must shut down the VM before you can enable or disable processor compatibility mode.

## Enable processor compatibility mode using Windows Admin Center

To enable processor compatibility mode using Windows Admin Center:

1. Connect to your cluster, and then in the **Tools** pane, select **Virtual machines**.
2. Under **Inventory**, select the VM on which you want to enable processor compatibility mode, expand the **Power** menu, then select **Shut down**.
3. Select **Settings**, then **Processors**, and check the box for **Processor compatibility**.

   :::image type="content" source="media/dynamic-processor-compatibility-mode/processor-compatibility.png" alt-text="Check the box to enable processor compatibility" lightbox="media/processor-compatibility-mode/processor-compatibility.png":::

4. If you want to set the VM's CPU features to the maximum level supported by all servers in a cluster, select **Compatible across the cluster (Recommended)**. This maximizes VM performance while preserving the ability to move the running VM to other servers in the cluster. We recommend enabling this for all VMs running on Azure Stack HCI 21H2 clusters; if disabled, the VM must be restarted to move to a host with a different level of supported CPU instructions, common with different generations of CPUs. 

   Alternatively, if you want to set the VM's CPU features to minimum to ensure that you can move the running VM to other Hyper-V hosts outside the cluster as long as they have the same CPU manufacturer, select **Compatible across other hosts with the same CPU manufacturer**.

   > [!NOTE]
   > Like dynamic processor compatibility mode, **Compatible across the cluster** is exclusive to Azure Stack HCI 21H2 and is not supported for any other operating systems.

5. Select **Save processor settings** and restart the VM.

## Enable processor compatibility mode using PowerShell

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

## Next steps

For more information, see also:

- [Manage VMs with Windows Admin Center](vm.md)
- [Manage VMs with PowerShell](vm-powershell.md)