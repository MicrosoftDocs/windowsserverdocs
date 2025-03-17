---
title: Upgrade the OS of a Windows Server cluster by performing a rolling upgrade
description: You can upgrade the operating system of a Windows Server failover cluster without stopping workloads by upgrading one node at a time in a rolling upgrade. This article describes the stages of the rolling upgrade process, limitations, and frequently asked questions (FAQs).
ms.topic: how-to
author: jasongerend
ms.author: jgerend
ms.date: 3/14/2025
---

# Upgrade the OS of a Windows Server cluster by performing a rolling upgrade

You can upgrade the operating system of a Windows Server failover cluster without stopping workloads by upgrading one node at a time in a rolling upgrade. This article describes the stages of the rolling upgrade process, limitations, and frequently asked questions (FAQs).

This article applies to clusters running Hyper-V virtual machines or Scale-out File Server (SOFS) workloads, but doesn't apply to clusters using virtual hard disks (.vhdx files) as shared storage.

If you're using System Center Virtual Machine Manager (SCVMM), instead see [Perform a rolling upgrade of a Hyper-V host cluster to Windows Server 2016 in VMM](/system-center/vmm/hyper-v-rolling-upgrade?view=sc-vmm-1807&preserve-view=true) for guidance on upgrading clusters.

## Overview

A rolling upgrade of a Windows Server failover cluster provides the following benefits:

- Upgrade a cluster running Hyper-V virtual machines or Scale-out File Server (SOFS) workloads to a newer version of Windows Server without downtime.
- No new hardware is required, though you might choose to temporarily add cluster nodes to small clusters to improve availability during the upgrade.
- The cluster can support patching and maintenance operations during the upgrade, when there are a mix of OS versions in the cluster.
- The upgrade process is reversible until the final step, when all cluster nodes are running the newer version of Windows Server and you update the cluster functional level by using.
- It supports automation via PowerShell and WMI.

At a high level, a rolling upgrade consists of these steps:

1. Transfer workloads off of the first node, and then evict the node from the cluster.
2. On the evicted node, install the newer version of Windows Server via an [upgrade](../get-started/perform-in-place-upgrade.md) or [clean install](../get-started/install-windows-server.md).
3. Add the evicted node back to the cluster, which is now running on two OS versions in mixed-OS version mode. Also set up the workloads and data on the upgraded node if you performed a clean install.
4. Repeat steps 2 through 4 for every other node in the cluster.
5. Update the cluster functional level to the new version of Windows Server and update VM and storage pool versions.

For a detailed diagram of the rolling upgrade process, see the following illustration: [Cluster upgrading workflow](media/Cluster-Operating-System-Rolling-Upgrade/Clustering_RollingUpgrade_Workflow.png).

## Requirements

Complete the following requirements before you begin the upgrade:

- Start with a Failover Cluster running Windows Server 2012 R2 or newer.
- Verify that the Hyper-V nodes have CPUs that support Second-Level Addressing Table (SLAT) using one of the following methods:
  - Review the [Are you SLAT Compatible? WP8 SDK Tip 01](/archive/blogs/devfish/are-you-slat-compatible-wp8-sdk-tip-01) article that describes two methods to check if a CPU supports SLATs
  - Download the [Coreinfo v3.31](/sysinternals/downloads/coreinfo) tool to determine if a CPU supports SLAT.

## Limitations

- We recommend moving through the cluster upgrade process quickly (within four weeks) because some cluster features aren't optimized for mixed-OS mode.
  - When managing a mixed-OS mode cluster, always perform the management tasks from a node running the newer version of Windows Server. Older versions of Windows Server often can't use UI or management tools to manage newer versions.
  - Avoid creating or resizing storage on newer Windows Server nodes while the cluster is running a mix of OS versions because of possible incompatibilities when failing over from a newer to an older Windows Server node.
- You can upgrade only to the next newer version of OS, for example from Windows Server 2022 to Windows Server 2025.
<br>To upgrade across multiple versions, such as from Windows Server 2016 to Windows Server 2025, run the upgrade sequentially (first to Windows Server 2019, then to Windows Server 2022, and finally to Windows Server 2025), or migrate to a new cluster.
- If you have VMs with a VM configuration version older than 8.0 (corresponding to Windows Server 2016 or Windows 10 version 1607), you might need to upgrade the VM configuration version to run the VMs on the upgraded cluster, regardless of how you upgrade. This can happen if you have older VMs running on Windows Server 2019 and upgrade to Windows Server 2022.
<br>For example, if your VMs use version 5.0 (Windows Server 2012 R2 and Windows 8.1), and you upgrade the cluster to Windows Server 2025 or Windows Server 2022, you must upgrade the VM configuration version to 8.0 (corresponding to Windows Server 2016 and Windows 10 Anniversary Update) or later. For more info, see [Migrate and upgrade virtual machines](../virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md).

## Perform a rolling cluster upgrade

The following sections take you through the steps to perform a rolling cluster upgrade:

1. Prepare the cluster for the operating system upgrade
2. Transfer workloads off of a node, and then evict the node from the cluster.
3. Install the newer version of Windows Server on the evicted node.
4. Add the evicted node back to the cluster, which is now running in mixed-OS version mode. If you performed a clean install, set up workloads on the node.
5. Repeat steps 2 through 4 for every other node in the cluster.
6. Update the cluster functional level to the new version of Windows Server.
7. Resume normal cluster operations and turn on new functionality.

### Step 1: Prepare the cluster for the upgrade

Before you start evicting and upgrading nodes it's important to verify that the cluster is healthy and ready for the upgrade:

1. Check that the cluster has sufficient capacity to maintain appropriate uptime assurances (SLAs) with one node removed.
    - Does the cluster have enough storage, CPU, and networking resources to run the required workloads when one node is removed from the cluster?
    - Are there enough nodes in the cluster to maintain the required fault tolerance with one node evicted? This is typically an issue for two-node clusters, where you might want to temporarily add a node to the cluster to maintain fault tolerance during the upgrade.
2. For Hyper-V workloads, check that all Windows Server Hyper-V hosts have CPU support for Second-Level Address Table (SLAT). Only SLAT-capable machines can use the Hyper-V role in Windows Server 2016 and newer.
3. If you're using Hyper-V with virtual switches that are bound to an LBFO team and are upgrading to Windows Server 2022 or newer, remove the team before starting the upgrade. After the upgrade you can bind the network adapters to a virtual switch that uses the newer SET switch technology. <br><br>LBFO teams are no longer supported in Windows Server 2022 and newer. For more information on removed features, see [Features removed or no longer developed in Windows Server](../get-started/removed-deprecated-features-windows-server.md).
1. Install the latest software updates on all nodes of the cluster.
1. Check that any workload backups have completed, and consider backing-up the cluster database with a System State backup.
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

6. Stop any updating tools that are running on the cluster. For example, if you're using Cluster Aware Updating:

    1. Verify if Cluster Aware Updating (CAU) is currently performing a run by using the **Cluster-Aware Updating** UI, or the [Get-CauRun](/powershell/module/clusterawareupdating/Get-CauRun) cmdlet.

        ```powershell
        Get-CauRun
        ```

        Here's an example of output on the cluster named "Cluster01":

        ```output
        RunNotInProgress
        WARNING: No Updating Run is currently in progress on cluster Cluster01.
        ```

    2. Stop Cluster Aware Updating by using the [Disable-CauClusterRole](/powershell/module/clusterawareupdating/Disable-CauClusterRole) cmdlet to prevent any nodes from being paused and drained automatically during the upgrade.

        ```powershell
        Disable-CauClusterRole
        ```

        Here's an example of output:

        ```output
        Are you sure?
        Do you want to disable the Cluster-Aware Updating clustered role on cluster "Cluster01"?
        [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
        ```

### Step 2: Transfer workloads and evict the node to upgrade

Perform the following steps on one node in the cluster (you'll repeat this process one at a time for every node in the cluster):

1. Using Cluster Manager (optionally in Windows Admin Center), select the appropriate node and then use the **Pause | Drain** menu option to drain the node (see Figure 10) or use the [Suspend-ClusterNode](/powershell/module/failoverclusters/Suspend-ClusterNode) cmdlet (see Figure 1).

    ![Screencap showing how to drain roles with the Cluster Manager UI](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_FCM_DrainRoles.png)
    **Figure 1: Draining roles from a node using Failover Cluster Manager**

    ```PowerShell
    Suspend-ClusterNode -Name Node1
    ```

    Here's an example of the output showing that the cluster node is now paused:

    ```output
    Name           ID    State
    ----           --    -----
    Node1          1     Paused
    ```

2. Evict the paused node from the cluster by using Cluster Manager or the [Remove-ClusterNode](/powershell/module/failoverclusters/Remove-ClusterNode) cmdlet.

    ```PowerShell
    Remove-ClusterNode -Name Node1
    ```

    Here's an example of the output:

    ```output
    Are you sure you want to evict node Node1?
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
    ```

### Step 3: Install the new version of Windows Server

1. Perform an [upgrade](../get-started/perform-in-place-upgrade.md) or [clean install](../get-started/install-windows-server.md) of the newer version of Windows Server on the node.
2. If you performed an upgrade and removed an LBFO team prior to the upgrade, create a new Hyper-V virtual switch using the newer Switch Embedded Teaming (SET) technology. You can use Windows Admin Center, Hyper-V Manager, or the [New-VMSwitch](/powershell/module/hyper-v/New-VMSwitch) PowerShell cmdlet.
3. If you performed a clean install, get the node ready to rejoin the cluster:
    1. Join the node to the appropriate Active Directory Domain Services domain. Make sure to use the same computer name if the cluster uses Storage Spaces Direct.
    2. Add the appropriate users to the local Administrators group.
    3. Install any server roles and features that you need, such as Hyper-V, Failover Clustering, and NetworkATC (available on Windows Server 2025). You can use Windows Admin Center, Server Manager, or the [Install-WindowsFeature](/powershell/module/servermanager/Install-WindowsFeature) PowerShell cmdlet, as shown in the following example:

        ```PowerShell
        Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "NetworkATC" -IncludeAllSubFeature -IncludeManagementTools
        ```

    4. Check network and storage connectivity settings.
    5. If Windows Firewall is used, check that the Firewall settings are correct for the cluster. For example, Cluster Aware Updating might require Firewall configuration.
    6. For Hyper-V workloads, create virtual switches that exactly match the virtual switches used on the rest of the cluster nodes. You can use Windows Admin Center, Hyper-V Manager, or the [Get-VMSwitch](/powershell/module/hyper-v/Get-VMswitch) and [Add-VMSwitch](/powershell/module/hyper-v/Add-VMswitch) PowerShell cmdlets.

### Step 4: Add the node back to the cluster

1. Connect to the upgraded node and then use Failover Cluster Manager or the [Add-ClusterNode](/powershell/module/failoverclusters/Add-ClusterNode) cmdlet (see Figure 16) to add the upgraded node back to the cluster.

    ```powershell
    Add-ClusterNode
    ```

    Here's an example of the output:

    ```output
    Waiting for notification that node clusternode1 is a fully functional member of the cluster.
    ```

    > [!NOTE]
    > When the first upgraded node joins the cluster, the cluster enters "Mixed-OS" mode, and the cluster core resources are moved to the newer node. A "Mixed-OS" mode cluster is a fully functional cluster where the new nodes run in a compatibility mode with the old nodes. "Mixed-OS" mode is a transitory mode for the cluster and you should update all nodes of the cluster within four weeks.

2. After the node is successfully added to the cluster, you can (optionally) move some of the cluster workloads to the newly added node to rebalance the workload across the cluster as follows:

    - To move running virtual machines without downtime, use **Live Migration** in Failover Cluster Manager or the [Move-ClusterVirtualMachineRole](/powershell/module/failoverclusters/Move-ClusterVirtualMachineRole) cmdlet.

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

### Step 5: Repeat steps 2 through 4 for every other node in the cluster

The upgrade process is fully reversible until you update the cluster functional level in the next step. If you need to abandon the upgrade, you can add nodes running the original version of Windows Server and evict any nodes running the newer version of the OS until you upgrade the cluster functional level.

### Step 6: Update the cluster functional level

Updating the cluster functional level makes it possible to use new features. It also improves some cluster operations, such as draining workloads from a node, which can lead to a node becoming isolated for a short period of time if performed on a mixed-OS cluster.

When every node has the newer OS version installed and is added back to the cluster or permanently evicted, complete the following steps to update the cluster functional level:

> [!IMPORTANT]
>
> After you update the cluster functional level, you cannot go back to an earlier functional level and you cannot add nodes running earlier versions of Windows Server to the cluster.

1. Check that all cluster roles are running on the cluster as expected. You can use Failover Cluster Manager or the [Get-ClusterGroup](/powershell/module/failoverclusters/Get-ClusterGroup) cmdlet.

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

2. Check that all cluster nodes are online and running using the [Get-ClusterNode](/powershell/module/failoverclusters/Get-ClusterNode) cmdlet.

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

3. View the cluster functional level by using the [Get-Cluster](/powershell/module/failoverclusters/get-cluster) cmdlet:

    ```PowerShell
    Get-Cluster | Select ClusterFunctionalLevel
    ```

    Here's an example of output:

    ```output
    ClusterFunctionalLevel
    -----------------------
    8
    ```

4. Run the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet - no errors should be returned.

    ```powershell
    Update-ClusterFunctionalLevel
    ```

    Here's an example of the output:

    ```output
    Updating the Functional level for cluster cluster01.
    Warning: You cannot undo this operation. Do you want to continue?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
    ```

5. Confirm that the cluster functional level was updated by using the [Get-Cluster](/powershell/module/failoverclusters/get-cluster) cmdlet:

    ```PowerShell
    Get-Cluster | Select ClusterFunctionalLevel
    ```

    Here's an example of the output:

    ```output
    ClusterFunctionalLevel
    -----------------------
    9
    ```

### Step 7: Resume normal cluster operations and turn on new functionality

To resume normal cluster operations and turn on new functionality, including in storage pools, perform the following steps:

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

2. Resume any backup operations that you stopped for the upgrade.
3. To turn on new functionality available for VMs, upgrade the configuration version for each VM. For a list of new Hyper-V capabilities, see [Migrate and upgrade virtual machines](../virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md#what-happens-if-i-dont-upgrade-the-virtual-machine-configuration-version).

    1. View the VM versions that are supported by each node in the cluster by using the [Get-VMHostSupportedVersion](/powershell/module/hyper-v/Get-VMHostSupportedVersion) cmdlet. Each node should have the same supported versions at this point.

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

    2. View the VMs on each node in the cluster by using the [Get-VM](/powershell/module/hyper-v/Get-VM) cmdlet.

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

    3. During a scheduled maintenance window when you can take the VMs offline, back up and upgrade all VMs on each node by using the [Update-VMVersion](/powershell/module/hyper-v/Update-VMVersion) cmdlet. The below example updates all VMs on one node; you must repeat this for each node in the cluster.

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

4. If you're using storage pools, update them using the [Update-StoragePool](/powershell/module/storage/Update-StoragePool) PowerShell cmdlet - this is an online operation so you don't need to take anything offline.

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

## Frequently asked questions

**How long can the failover cluster run in mixed-OS mode?**
    We encourage customers to complete the upgrade within four weeks. We have successfully upgraded Hyper-V and Scale-out File Server clusters with zero downtime in less than four hours total.

**Can I run the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet while nodes are Off or Paused?**
    No. All cluster nodes must be on and in active membership for the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet to work.

**Does the Cluster OS Rolling Upgrade work for any cluster workload? Does it work for SQL Server?**
    Yes, the Cluster OS Rolling Upgrade works for any cluster workload. However, it's only zero-downtime for Hyper-V and Scale-out File Server clusters. Most other workloads incur some downtime (typically a couple of minutes) when they failover, and failover is required at least once during the Cluster OS Rolling Upgrade process.

**Can I automate this process using PowerShell?**
    Yes, we have designed the Cluster OS Rolling Upgrade to be automated using PowerShell.

**For a large cluster that has extra failover capacity, can I upgrade multiple nodes simultaneously?**
    Yes. When one node is removed from the cluster to upgrade the OS, the cluster has one less node for failover, hence has a reduced failover capacity. For large clusters with enough workload and failover capacity, multiple nodes can be upgraded simultaneously.

**What if I discover an issue in my cluster after [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) has been run successfully?**
    If you have backed-up the cluster database with a System State backup before running [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel), you should be able to perform an Authoritative restore on a node running the previous version of Windows Server and restore the original cluster database and configuration.

**Can I use in-place upgrade for each node instead of using clean-OS install by reformatting the system drive?**
    Yes. In the past we recommended performing a clean OS install on each node, but you can perform an in-place upgrade of a cluster node if you carefully read and resolve all warning messages displayed during the in-place upgrade.

**If I am using Hyper-V replication for a Hyper-V VM on my Hyper-V cluster, will replication remain intact during and after the Cluster OS Rolling Upgrade process?**
    Yes, Hyper-V replica remains intact during and after the Cluster OS Rolling Upgrade process.

**Can I use System Center Virtual Machine Manager (SCVMM) to automate the Cluster OS Rolling Upgrade process?**
    Yes, you can automate the Cluster OS Rolling Upgrade process using VMM in System Center.
