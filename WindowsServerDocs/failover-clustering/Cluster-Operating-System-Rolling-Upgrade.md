---
title: Upgrade the OS of a Windows Server failover cluster by performing a cluster OS rolling upgrade
description: Manually upgrade the operating system of a Windows Server failover cluster without stopping workloads by upgrading one node at a time in a rolling OS upgrade. This article describes the stages of the rolling upgrade process, limitations, and frequently asked questions (FAQs).
# customer intent: As an IT professional, I want to learn how to upgrade the OS of a Windows Server failover cluster by manually performing a cluster OS rolling upgrade.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 3/19/2025
ms.custom: sfi-image-nochange
---

# Upgrade a Windows Server failover cluster with a cluster OS rolling upgrade

This article describes how to manually install a feature update on a Windows Server failover cluster without stopping workloads. The process upgrades one node at a time in a rolling upgrade and is often called a Rolling OS Cluster Upgrade.

**You can upgrade the cluster one OS version at a time**, such as from Windows Server 2022 to Windows Server 2025. To upgrade across multiple OS versions, such as from Windows Server 2016 to Windows Server 2025, perform the steps in this article for each version.

This article applies to clusters running Hyper-V virtual machines or Scale-out File Server (SOFS) workloads upgrading one OS version, but doesn't apply to clusters using virtual hard disks (.vhdx files) as shared storage. If you're using System Center Virtual Machine Manager (VMM), instead see [Perform a rolling upgrade of a Hyper-V host cluster in VMM](/system-center/vmm/hyper-v-rolling-upgrade?view=sc-vmm-1807&preserve-view=true). Azure Local customers should use the updating process described in [About Azure Local upgrades](/azure/azure-local/upgrade/about-upgrades-23h2), though you can use this article if none of the Azure Local updating methods work for you.

## Overview

A rolling upgrade of a cluster to the next newer version of Windows Server provides the following benefits:

- Upgrade a cluster running Hyper-V virtual machines or Scale-out File Server (SOFS) workloads to the next newer version of Windows Server without downtime.
- No new hardware is required, though you might choose to temporarily add cluster nodes to small clusters to improve availability during the upgrade.
- The cluster can support patching and maintenance operations during the upgrade, when there are a mix of OS versions in the cluster.
- The upgrade process is reversible until the final step, when all cluster nodes are running the newer version of Windows Server and you update the cluster functional level.
- It supports automation via PowerShell and WMI.

At a high level, a rolling upgrade consists of these steps:

1. Prepare the cluster for the OS feature update.

1. Transfer workloads off of the first node.

1. Perform the Windows Server feature update via an [upgrade](../get-started/perform-in-place-upgrade.md) or [clean install](../get-started/install-windows-server.md).

1. Repeat steps 2 through 3 for every other node in the cluster.

1. Update the cluster functional level and storage pools to the new version of Windows Server.

1. Resume normal operation and update VM configuration versions to turn on new functionality.

For a detailed diagram of the rolling upgrade process, see Figure 1.

:::image type="content" source="media/Cluster-Operating-System-Rolling-Upgrade/Clustering_RollingUpgrade_Workflow.png" alt-text="Screenshot of diagram showing the details of the rolling upgrade process." lightbox="media/Cluster-Operating-System-Rolling-Upgrade/Clustering_RollingUpgrade_Workflow.png":::
**Figure 1: Diagram of the rolling upgrade process**

## Requirements and limitations

Complete the following requirements before you begin the upgrade:

- Start with a Failover Cluster running Windows Server 2012 R2 or newer.
- Verify that the Hyper-V nodes have CPUs that support Second-Level Addressing Table (SLAT) using one of the following methods:
  - Review the [Are you SLAT Compatible? WP8 SDK Tip 01](/archive/blogs/devfish/are-you-slat-compatible-wp8-sdk-tip-01) article that describes two methods to check if a CPU supports SLATs
  - Download the [Coreinfo v3.31](/sysinternals/downloads/coreinfo) tool to determine if a CPU supports SLAT.

Here are some limitations to be aware of:

- We recommend moving through the cluster upgrade process within four weeks because some cluster features aren't optimized for clusters that run two different OS versions.
  - When managing a mixed-OS mode cluster, always perform the management tasks from a node running the newer version of Windows Server. Older versions of Windows Server often can't use UI or management tools to manage newer versions.
  - Avoid creating or resizing storage on newer Windows Server nodes while the cluster is running a mix of OS versions. Doing so can lead to possible incompatibilities when failing over from a newer to an older Windows Server node.
- You can upgrade only to the next newer version of OS, for example from Windows Server 2022 to Windows Server 2025.
<br>To upgrade across multiple versions, such as from Windows Server 2016 to Windows Server 2025, run the upgrade sequentially (first to Windows Server 2019, then to Windows Server 2022, and finally to Windows Server 2025), or migrate to a new cluster.
- You must upgrade the configuration version of older VMs before they can run on a Windows Server 2022 or newer cluster, regardless of how you upgrade. VM configuration versions older than 8.0 (corresponding to Windows Server 2016), can't run on Windows Server 2022.
<br>For example, if your VMs were created on a Windows Server 2012 R2 system and use VM configuration version 5.0, and you upgrade the cluster to Windows Server 2022, you must upgrade the VM configuration version to 8.0 or newer. For more info, see [Migrate and upgrade virtual machines](../virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md).

## Step 1: Prepare the cluster for the upgrade

Before you start upgrading nodes, verify that the cluster is healthy and ready for the upgrade:

1. Check that the cluster has sufficient capacity to maintain appropriate uptime service level agreements with one node removed.
    - Does the cluster have enough storage, CPU, and networking resources to run the required workloads when one node is removed from the cluster?
    - Are there enough nodes in the cluster to maintain the required fault tolerance with one node offline? You might want to temporarily add a node to a two node cluster to maintain fault tolerance during the upgrade.

1. For Hyper-V workloads, check that all Windows Server Hyper-V hosts have CPU support for Second-Level Address Table (SLAT). Only SLAT-capable machines can use the Hyper-V role in Windows Server 2016 and newer.

1. Install the latest software updates on all nodes of the cluster.

1. Check that any workload backups are complete, and consider backing up the cluster database with a System State backup.

1. Check that all cluster nodes are up using the [Get-ClusterNode](/powershell/module/failoverclusters/Get-ClusterNode) cmdlet.

    ```powershell
    Get-ClusterNode
    ```

    Here's an example of output:

    ```output
    Name        ID    State
    ----        --    -----
    Node1       1     Up
    Node2       2     Up
    Node3       3     Up
    ```

1. Stop any updating tools that are running on the cluster. For example, if you're using Cluster Aware Updating, use the following steps:

    1. Verify if Cluster Aware Updating (CAU) is currently performing a run by using the **Cluster-Aware Updating** UI, or the [Get-CauRun](/powershell/module/clusterawareupdating/Get-CauRun) cmdlet.

        ```powershell
        Get-CauRun
        ```

        Here's an example of output on the cluster named "Cluster01":

        ```output
        RunNotInProgress
        WARNING: No Updating Run is currently in progress on cluster Cluster01.
        ```

    1. Stop Cluster Aware Updating by using the [Disable-CauClusterRole](/powershell/module/clusterawareupdating/Disable-CauClusterRole) cmdlet to prevent any nodes from being paused and drained automatically during the upgrade.

        ```powershell
        Disable-CauClusterRole
        ```

        Here's an example of output:

        ```output
        Are you sure?
        Do you want to disable the Cluster-Aware Updating clustered role on cluster "Cluster01"?
        [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
        ```

## Step 2: Transfer workloads off a node

Perform the following steps on one node in the cluster (you repeat this process one at a time for every node in the cluster):

1. To drain the node in Windows Admin Center, navigate to **Cluster Manager** > **Servers**, select the node, and then select **Pause**. To use Failover Cluster Manager, select the node and then select **Pause** > **Drain**, as shown in Figure 2. Or use the [Suspend-ClusterNode](/powershell/module/failoverclusters/Suspend-ClusterNode) cmdlet with the `-Drain` parameter, as shown here.

    :::image type="content" source="media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_FCM_DrainRoles.png" alt-text="Screenshot of Failover Cluster Manager showing the Drain roles action on a node." lightbox="media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_FCM_DrainRoles.png":::
    **Figure 2: Draining roles from a node using Failover Cluster Manager**

    ```PowerShell
    Suspend-ClusterNode -Name Node1 -Drain
    ```

    Here's an example of the output showing that the cluster node is now paused:

    ```output
    Name           ID    State
    ----           --    -----
    Node1          1     Paused
    ```

1. If you're using Hyper-V with virtual switches that are bound to an LBFO team and are performing an in-place upgrade to Windows Server 2022 or newer, remove the team before starting the upgrade. After the upgrade, you can bind the network adapters to a virtual switch that uses the newer SET switch technology. <br><br>LBFO teams are no longer supported with Hyper-V in Windows Server 2022 and newer. For more information on removed features, see [Features removed or no longer developed in Windows Server](../get-started/removed-deprecated-features-windows-server.md).

1. This step is optional, depending on whether you're performing an in-place upgrade or clean OS installation. If you're going to perform a clean OS installation on the node, first remove (evict) the paused node from the cluster by using Windows Admin Center, Failover Cluster Manager, or the [Remove-ClusterNode](/powershell/module/failoverclusters/Remove-ClusterNode) cmdlet.

    ```PowerShell
    Remove-ClusterNode -Name Node1
    ```

    Here's an example of the output:

    ```output
    Are you sure you want to evict node Node1?
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
    ```

## Step 3: Install the new version of Windows Server

1. Perform an [upgrade](../get-started/perform-in-place-upgrade.md) or [clean install](../get-started/install-windows-server.md) of the newer version of Windows Server on the node.

1. If you upgraded to Windows Server 2022 or newer and removed an LBFO team before upgrading, create a new Hyper-V virtual switch that uses the newer Switch Embedded Teaming (SET) technology to bind to multiple network adapters. You can use Windows Admin Center, Hyper-V Manager, or the [New-VMSwitch](/powershell/module/hyper-v/New-VMSwitch) PowerShell cmdlet.

1. If you performed a clean install, get the node ready to rejoin the cluster:

    1. Join the node to the appropriate Active Directory Domain Services domain. Make sure to use the same computer name if the cluster uses Storage Spaces Direct.

    1. Add the appropriate users to the local Administrators group.

    1. Install any server roles and features that you need, such as Hyper-V, Failover Clustering, and NetworkATC (available on Windows Server 2025). You can use Windows Admin Center, Server Manager, or the [Install-WindowsFeature](/powershell/module/servermanager/Install-WindowsFeature) PowerShell cmdlet, as shown in the following example:

        ```PowerShell
        Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "NetworkATC" -IncludeAllSubFeature -IncludeManagementTools
        ```

    1. Check network and storage connectivity settings.

    1. If Windows Firewall is used, check that the Firewall settings are correct for the cluster. For example, Cluster Aware Updating might require Firewall configuration.

    1. For Hyper-V workloads, create virtual switches that match the rest of the cluster nodes (except for LBFO configuration if you're replacing network adapter teams). You can use Windows Admin Center, Hyper-V Manager, or the [Get-VMSwitch](/powershell/module/hyper-v/Get-VMswitch) and [Add-VMSwitch](/powershell/module/hyper-v/Add-VMswitch) PowerShell cmdlets.

    1. If you performed a clean OS installation on the node, connect to the upgraded node and then use Windows Admin Center, Failover Cluster Manager, or the [Add-ClusterNode](/powershell/module/failoverclusters/Add-ClusterNode) cmdlet to add the upgraded node back to the cluster. If you performed an in-place upgrade, you don't need to do this step because the node is still part of the cluster.

        ```powershell
        Add-ClusterNode -Name clusternode1
        ```

        Here's an example of the output:

        ```output
        Waiting for notification that node clusternode1 is a fully functional member of the cluster.
        ```

        > [!NOTE]
        > When the first upgraded node joins the cluster, the cluster enters "Mixed-OS" mode, and the cluster core resources are moved to the newer node. A "Mixed-OS" mode cluster is a fully functional cluster where the new nodes run in a compatibility mode with the old nodes. "Mixed-OS" mode is a transitory mode for the cluster and you should update all nodes of the cluster within four weeks.

    1. If you performed an in-place upgrade, resume the node by using Windows Admin Center, Failover Cluster Manager, or the [Resume-ClusterNode](/powershell/module/failoverclusters/Resume-ClusterNode) cmdlet.

        ```PowerShell
        Resume-ClusterNode -Name clusternode1 -Failback Immediate
        ```

        Here's an example of the output showing that the cluster node is now up:

        ```output
        Name         State Type
        ----         ----- ----
        clusternode1 Up    Node
        ```

    1. Optionally rebalance the cluster by moving workloads to the newly added node.

    - To move running virtual machines without downtime, use **Live Migration** in Windows Admin Center, Failover Cluster Manager, or the [Move-ClusterVirtualMachineRole](/powershell/module/failoverclusters/Move-ClusterVirtualMachineRole) cmdlet.

        ```PowerShell
        Move-ClusterVirtualMachineRole -Name VM1 -Node node1
        ```

        Here's an example of the output:

        ```output
        Name      OwnerNode     State
        ----      ---------     -----
        VM1       node1         Online
        ```

    - To move other cluster workloads, use the **Move** command in Failover Cluster Manager or the [Move-ClusterGroup](/powershell/module/failoverclusters/Move-ClusterGroup) cmdlet.

## Step 4: Repeat steps 2 through 4 for every other node in the cluster

The upgrade process is fully reversible until you update the cluster functional level in the next step. To abandon the upgrade, add nodes that run the original version of Windows Server and then remove any nodes that run the newer version of the OS.

## Step 5: Update the cluster functional level and storage pool version

Updating the cluster functional level and storage pool version makes it possible to use new features. It also improves some cluster operations, such as draining workloads from a node, which can lead to a node becoming isolated for a short period of time if performed on a mixed-OS cluster.

When every node has the newer OS version installed and is added back to the cluster or permanently removed, complete the following steps to update the cluster functional level and storage pool version.

> [!IMPORTANT]
>
> After you update the cluster functional level and storage pool version, you can't go back to an earlier functional level or storage pool version and you can't add nodes running earlier versions of Windows Server to the cluster.

1. Check that all cluster roles are running on the cluster as expected. You can use Windows Admin Center, Failover Cluster Manager, or the [Get-ClusterGroup](/powershell/module/failoverclusters/Get-ClusterGroup) cmdlet:

    ```PowerShell
    Get-ClusterGroup
    ```

    Here's an example of the output showing four VMs and the cluster group online:

    ```output
    Name                OwnerNode      State
    ----                ---------      -----
    Available Storage   node2          Offline
    VM1                 node2          Online
    VM2                 node1          Online
    VM3                 node1          Online
    VM4                 node3          Online
    Cluster Group       node1          Online
    ```

    The Available Storage group isn't used and is offline because this cluster uses Cluster Shared Volumes (CSVs) for storage. Available Storage would be online if the cluster used disks assigned to it from LUNS on a SAN, but we recommend using CSVs instead.

1. Check that all cluster nodes are online and running by using Windows Admin Center, Failover Cluster Manager, or the [Get-ClusterNode](/powershell/module/failoverclusters/Get-ClusterNode) cmdlet.

    ```powershell
    Get-ClusterNode
    ```

    Here's an example of output:

    ```output
    Name        ID    State
    ----        --    -----
    node1       1     Up
    node2       2     Up
    node3       3     Up
    ```

1. View the cluster functional level in Windows Admin Center by navigating to **Cluster Manager** > **Settings** > **Cluster** > **Properties**. Or use the [Get-Cluster](/powershell/module/failoverclusters/get-cluster) cmdlet:

    ```PowerShell
    Get-Cluster | Select ClusterFunctionalLevel
    ```

    Here's an example of output:

    ```output
    ClusterFunctionalLevel
    -----------------------
    10
    ```

1. Select the new functional level in Windows Admin Center or run the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet - no errors should be returned.

    ```powershell
    Update-ClusterFunctionalLevel
    ```

    Here's an example of the output:

    ```output
    Updating the Functional level for cluster cluster01.
    Warning: You cannot undo this operation. Do you want to continue?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
    ```

1. Confirm that the cluster functional level was updated by using the [Get-Cluster](/powershell/module/failoverclusters/get-cluster) cmdlet:

    ```PowerShell
    Get-Cluster | Select ClusterFunctionalLevel
    ```

    Here's an example of the output:

    ```output
    ClusterFunctionalLevel
    -----------------------
    11
    ```

1. If you're using storage pools, you can update them without downtime by using Windows Admin Center > **Cluster Manager** > **Settings** > **Storage Spaces and Pools** > **Storage pool version**. Or use the [Update-StoragePool](/powershell/module/storage/Update-StoragePool) PowerShell cmdlet.

## Step 6: Resume normal cluster operations and turn on new functionality

To resume normal cluster operations and turn on new functionality, perform the following steps:

1. If you stopped updating tools, start them again. For example, to start Cluster Aware Updating, you can use the Cluster Aware Updating tool or the [Enable-CauClusterRole](/powershell/module/clusterawareupdating/Enable-CauClusterRole) cmdlet.

    ```PowerShell
    Enable-CauClusterRole
    ```

    Here's an example of the output:

    ```output
    Are you sure?
    Do you want to enable the Cluster-Aware Updating Clustered role on Cluster "cluster01"?
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
    ```

1. Resume any backup operations that you stopped for the upgrade.

1. To turn on new functionality available for VMs, upgrade the configuration version for each VM. For a list of new Hyper-V capabilities, see [Migrate and upgrade virtual machines](../virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md#what-happens-if-i-dont-upgrade-the-virtual-machine-configuration-version).

    1. View the VM versions each node supports by using the [Get-VMHostSupportedVersion](/powershell/module/hyper-v/Get-VMHostSupportedVersion) cmdlet. Each node should have the same supported versions at this point.

        ```PowerShell
        Get-VMHostSupportedVersion -ComputerName node1
        ```

        Here's an example of the output, showing the VM version numbers and the corresponding operating system name:

        ```output
        Name                                                  Version IsDefault
        ----                                                  ------- ---------
        Microsoft Windows 10 Anniversary Update/Server 2016   8.0     False
        Microsoft Windows 10 Creators Update                  8.1     False
        Microsoft Windows 10 Fall Creators Update/Server 1709 8.2     False
        Microsoft Windows 10 April 2018 Update/Server 1803    8.3     False
        Microsoft Windows 10 October 2018 Update/Server 2019  9.0     False
        Microsoft Windows 10 May 2019 Update/Server 1903      9.1     False
        Microsoft Windows 10 May 2020 Update/Server 2004      9.2     False
        Microsoft Windows 10 (Manganese)                      9.3     False
        Microsoft Windows Server 2022                         10.0    False
        Microsoft Host OS (Cobalt+)                           10.5    False
        Microsoft Windows 11 (22H2)                           11.0    False
        Microsoft Windows 11 (Copper)                         11.1    False
        Microsoft Windows 11 (Zinc)                           11.2    False
        Microsoft Windows Server 2025                         12.0    True
        ```

    1. View the VMs on each node in the cluster by using the [Get-VM](/powershell/module/hyper-v/Get-VM) cmdlet.

        ```PowerShell
        Get-VM -ComputerName node1
        ```

        Here's an example of the output:

        ```output
        Name    State   CPUUsage(%) MemoryAssigned(M) Uptime              Status             Version
        ----    -----   ----------- ----------------- ------              ------             -------
        VM1     Running 0           12288             2.20:28:49.6670000  Operating normally 8.0
        VM2     Running 0           4096              14.23:13:12.7370000 Operating normally 8.0
        VM3     Running 0           1216              2.20:09:38.9450000  Operating normally 8.0
        ```

    1. During a scheduled maintenance window when you can take the VMs offline, back up and upgrade all older VMs on each node. <br>To do so in Windows Admin Center, navigate to **Cluster Manager** > **Virtual machines**, select a VM, and then select **Manage** > **Upgrade configuration version**. <br>Or use the [Update-VMVersion](/powershell/module/hyper-v/Update-VMVersion) cmdlet as shown in this example that updates all VMs on one node to the most recent version.

        ```powershell
        Update-VMVersion -ComputerName node1 -Name * -WhatIf
        ```

        Here's an example of the output:

        ```output
        Confirm
        Are you sure you want to perform this action?
        Performing a configuration version update of "dc1" will prevent it from being migrated to or imported on previous
        versions of Windows. This operation is not reversible.

        [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
        ```

## Cluster transition states during Cluster OS Rolling Upgrade

The cluster public property *ClusterFunctionalLevel* property indicates the state of the cluster on Windows Server 2016 and later cluster nodes. This property can be queried using the PowerShell cmdlet from a cluster node that belongs to a failover cluster:

```PowerShell
Get-Cluster | Select ClusterFunctionalLevel
```

The following table shows the values and each corresponding functional level:

| Value | Functional level |
|--|--|
| 8 | Windows Server 2012 R2 |
| 9 | Windows Server 2016 |
| 10 | Windows Server 2019 |
| 11 | Windows Server 2022 |
| 12 | Windows Server 2025 |

## Frequently asked questions

- **How long can the failover cluster run in mixed-OS mode?**
    <br>We encourage customers to complete the upgrade within four weeks. Hyper-V and Scale-out File Server clusters can be upgraded with no downtime in less than four hours total.
- **Can I run the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet while nodes are Off or Paused?**
    <br>No. All cluster nodes must be on and in active membership for the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet to work.
- **Does the Cluster OS Rolling Upgrade work for any cluster workload? Does it work for SQL Server?**
    <br>Yes, the Cluster OS Rolling Upgrade works for any cluster workload. However, it's only zero-downtime for Hyper-V and Scale-out File Server clusters. Most other workloads incur some downtime (typically a couple of minutes) when they failover, and failover is required at least once during the Cluster OS Rolling Upgrade process.
- **Can I automate this process using PowerShell?**
    <br>Yes.
- **For a large cluster that has extra failover capacity, can I upgrade multiple nodes simultaneously?**
    <br>Yes. When one node is removed from the cluster to upgrade the OS, the cluster has one less node for failover, hence has a reduced failover capacity. For large clusters with enough workload and failover capacity, multiple nodes can be upgraded simultaneously.
- **What if I discover an issue in my cluster after [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) has been run successfully?**
    <br>If you have backed-up the cluster database with a System State backup before running [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel), you should be able to perform an Authoritative restore on a node running the previous version of Windows Server and restore the original cluster database and configuration.
- **Can I use in-place upgrade for each node instead of using clean-OS install by reformatting the system drive?**
    <br>Yes. In the past, we recommended that you perform a clean OS install on each node. However, you can now perform an in-place upgrade of a cluster node if you carefully read and resolve any warning messages.
- **If I am using Hyper-V replication for a Hyper-V VM on my Hyper-V cluster, will replication remain intact during and after the Cluster OS Rolling Upgrade process?**
    <br>Yes, Hyper-V replica remains intact during and after the Cluster OS Rolling Upgrade process.
- **Can I use System Center Virtual Machine Manager (VMM) to automate the Cluster OS Rolling Upgrade process?**
    Yes, you can automate the Cluster OS Rolling Upgrade process using VMM in System Center.