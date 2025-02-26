---
title: Cluster OS Rolling Upgrade
description: Learn about the Cluster OS Rolling Upgrade process
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 2/25/2025
---

# Cluster OS Rolling Upgrade

You can upgrade the operating system of a Windows Server failover cluster without stopping workloads by upgrading one node at a time in a rolling upgrade. This article describes the stages of the rolling upgrade process, limitations, and frequently asked questions (FAQs).

This article applies to clusters running Hyper-V virtual machines or Scale-out File Server (SOFS) workloads, but doesn't apply to clusters using virtual hard disks (.vhdx files) as shared storage.

If you're using System Center Virtual Machine Manager (SCVMM), instead see [Perform a rolling upgrade of a Hyper-V host cluster to Windows Server 2016 in VMM](/system-center/vmm/hyper-v-rolling-upgrade?view=sc-vmm-1807&preserve-view=true) for guidance on upgrading clusters.

## Overview

A rolling upgrade of a Windows Server failover cluster provides the following benefits:

- Upgrade a cluster running Hyper-V virtual machines or Scale-out File Server (SOFS) workloads to a newer version of Windows Server without downtime.
- No new hardware is required (though you can temporarily add cluster nodes to small clusters improve availability during the upgrade).
- The upgrade process is reversible until the final step, when all cluster nodes are running the newer version of Windows Server and the `Update-ClusterFunctionalLevel` PowerShell cmdlet is run.
- The cluster can support patching and maintenance operations while running in the mixed-OS mode.
- It supports automation via PowerShell and WMI.

At a high level, a rolling upgrade consists of these steps:

1. Transfer workloads off of the first node, and then evict the node from the cluster.
2. On the evicted node, perform a clean installation of the newer version of Windows Server.
3. Add the evicted node back to the cluster, which now running in mixed-OS version mode, and set up the workloads and data on the node.
4. Repeat steps 2 through 4 for every other node in the cluster.
5. Update the cluster functional level to the new version of Windows Server.

## Requirements

Complete the following requirements before you begin the upgrade:

- You need a server running the same version of Windows Server as your upgraded nodes, or newer, to act as a management system when adding the upgraded nodes back to the cluster.
- Start with a Failover Cluster running Windows Server 2012 R2 or newer.
- You can upgrade only to the next newer version of OS, for example from Windows Server 2022 to Windows Server 2025.

    To upgrade across multiple versions, such as from Windows Server 2016 to Windows Server 2025, run the upgrade sequentially (first to Windows Server 2019, then to Windows Server 2022, and finally to Windows Server 2025), or migrate to a new cluster.
- Verify that the Hyper-V nodes have CPUs that support Second-Level Addressing Table (SLAT) using one of the following methods:
  - Review the [Are you SLAT Compatible? WP8 SDK Tip 01](/archive/blogs/devfish/are-you-slat-compatible-wp8-sdk-tip-01) article that describes two methods to check if a CPU supports SLATs
  - Download the [Coreinfo v3.31](/sysinternals/downloads/coreinfo) tool to determine if a CPU supports SLAT.

## Limitations

- The rolling upgrade involves reformatting each node and performing a clean installation of the newer version of Windows Server. We don't recommend performing *In-place* or *upgrade* installations.
- We recommend moving through the cluster upgrade process quickly (within four weeks) because some cluster features aren't optimized for mixed-OS mode.
  - When managing a mixed-OS mode cluster, always perform the management tasks from a node running the newer version of Windows Server. Older versions of Windows Server often can't use UI or management tools to manage newer versions.
  - Avoid creating or resizing storage on newer Windows Server nodes while the cluster is running in mixed-OS mode because of possible incompatibilities on failover from a newer Windows Server node to an older Windows Server node.

## Perform a rolling cluster upgrade

The following sections take you through the steps to perform a rolling cluster upgrade:

1. Prepare the cluster for the operating system upgrade
2. Transfer workloads off of the first node, and then evict the node from the cluster.
3. Reformat the system drive and install the newer version of Windows Server on the evicted node.
4. Add the evicted node back to the cluster, which now running in mixed-OS version mode, and set up the workloads and data on the node.
5. Repeat steps 2 through 4 for every other node in the cluster.
6. Update the cluster functional level to the new version of Windows Server.
7. Resume normal cluster operations and turn on new functionality

![Illustration showing the workflow for upgrading a cluster](media/Cluster-Operating-System-Rolling-Upgrade/Clustering_RollingUpgrade_Workflow.png)
**Figure 6: Cluster OS Rolling Upgrade workflow**

### Step 1: Prepare the cluster for the upgrade

Before you start evicting and upgrading nodes it's important to verify that the cluster is healthy and ready for the upgrade:

1. Check that the cluster has sufficient capacity to maintain appropriate uptime assurances (SLAs) with one node removed.
    - Does the cluster have enough storage, CPU, and networking resources to run the required workloads when one node is removed from the cluster?
    - Are there enough nodes in the cluster to maintain the required fault tolerance with one node evicted? This is typically an issue for two-node clusters, where you might want to temporarily add a node to the cluster to maintain fault tolerance during the upgrade.
2. For Hyper-V workloads, check that all Windows Server Hyper-V hosts have CPU support for Second-Level Address Table (SLAT). Only SLAT-capable machines can use the Hyper-V role in Windows Server 2016 and newer.
3. Check that any workload backups have completed, and consider backing-up the cluster. Stop backup operations while adding nodes to the cluster.
4. Check that all cluster nodes are online /running/up using the [Get-ClusterNode](/powershell/module/failoverclusters/Get-ClusterNode) cmdlet.

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

5. Verify if Cluster Aware Updating (CAU) is currently performing a run by using the **Cluster-Aware Updating** UI, or the [Get-CauRun](/powershell/module/clusterawareupdating/Get-CauRun) cmdlet.

    ```powershell
    Get-CauRun
    ```

    Here's an example of output on the cluster named "Cluster01":

    ```output
    RunNotInProgress
    WARNING: No Updating Run is currently in progress on cluster Cluster01.
    ```

6. Stop Cluster Aware Updating by using the [Disable-CauClusterRole](/powershell/module/clusterawareupdating/Disable-CauClusterRole) cmdlet to prevent any nodes from being paused and drained automatically during the upgrade.

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

1. Using Cluster Manager (optionally in Windows Admin Center), select the appropriate node and then use the **Pause | Drain** menu option to drain the node (see Figure 10) or use the [Suspend-ClusterNode](/powershell/module/failoverclusters/Suspend-ClusterNode) cmdlet (see Figure 11).

    ![Screencap showing how to drain roles with the Cluster Manager UI](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_FCM_DrainRoles.png)
    **Figure 10: Draining roles from a node using Failover Cluster Manager**

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

### Step 3: Format the system drive and install the new version of Windows Server

1. Format the system drive and perform a clean install of Windows Server on the node using the **Custom: Install Windows only (advanced)** installation (see Figure 13) option in Setup. We do not recommend performing an upgrade installation.

    ![Screencap of the Windows Server 2016 installation wizard showing the custom install option selected](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_InstallOption.png)
    **Figure 13: Available installation options for Windows Server 2016**

2. Join the node to the appropriate Active Directory Domain Services domain.
3. Add the appropriate users to the local Administrators group.
4. Using Windows Admin Center, Server Manager, or the [Install-WindowsFeature](/powershell/module/servermanager/Install-WindowsFeature) PowerShell cmdlet, install any server roles and features that you need, such as Hyper-V, Failover Clustering, and NetworkATC (available on Windows Server 2025).

    ```PowerShell
    Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "NetworkATC" -IncludeAllSubFeature -IncludeManagementTools
    ```

5. Check network and storage connectivity settings using Failover Cluster Manager.
6. If Windows Firewall is used, check that the Firewall settings are correct for the cluster. For example, Cluster Aware Updating might require Firewall configuration.
7. For Hyper-V workloads, create virtual switches that exactly match the virtual switches used on the rest of the cluster nodes. You can use Windows Admin Center, Hyper-V Manager, or the [Get-VMSwitch](/powershell/module/hyper-v/Get-VMswitch) and [Add-VMSwitch](/powershell/module/hyper-v/Add-VMswitch) PowerShell cmdlets.

    ![Screencap showing the location of the Hyper-V Virtual Switch Manager dialog](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_VMSwitch.png)
    **Figure 14: Virtual Switch Manager**

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
        VM1       node1  Online
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
In the following example, Available Storage isn't being used, instead a CSV is used and Available Storage displays an **Offline** status.

    ```PowerShell
    Get-ClusterGroup
    ```

    Here's an example of the output:

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

4. Run the [Update-ClusterFunctionalLevel](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet - no errors should be returned (see Figure 19).

    ```powershell
    Update-ClusterFunctionalLevel
    ```

    Here's an example of the output:

    ```output
    Updating the Functional level for cluster robindh-TP4D.
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

To resume normal cluster operations and turn on new functionality, perform the following steps:

1. Start Cluster Aware Updating by using the Cluster Aware Updating tool or the [Enable-CauClusterRole](/powershell/module/clusterawareupdating/Enable-CauClusterRole) cmdlet.

    ```PowerShell
    Enable-CauClusterRole
    ```

    Here's an example of the output:

    ```output
    Are you sure?
    Do you want to enable the Cluster-Aware Updating Clustered role on Cluster "cluster01"?
    [Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
    ```

2. Resume backup operations using the backup tool of your choice.
3. To turn on new functionality available for VMs, upgrade the configuration version for each VM. For a list of new Hyper-V capabilities, see [Migrate and upgrade virtual machines](../virtualization/hyper-v/deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md#what-happens-if-i-dont-upgrade-the-virtual-machine-configuration-version)

    1. On each node in the cluster, use the [Get-VMHostSupportedVersion](/powershell/module/hyper-v/Get-VMHostSupportedVersion) cmdlet to view the Hyper-V VM configuration versions that are supported by the host. Each node should have the same supported versions at this point.

        ```PowerShell
        Get-VMHostSupportedVersion -ComputerName node1
        ```

        Here's an example of the output:

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
        Microsoft Windows Server 2022                         10.0    True
        ```

    3. On each Hyper-V host node in the cluster, Hyper-V VM configuration versions can be upgraded by scheduling a brief maintenance window with users, backing up, turning off virtual machines, and running the [`Update-VMVersion`](/powershell/module/hyper-v/Update-VMVersion) cmdlet (see Figure 22). This will update the virtual machine version, and enable new Hyper-V features, eliminating the need for future Hyper-V Integration Component (IC) updates. This cmdlet can be run from the Hyper-V node that is hosting the VM, or the `-ComputerName` parameter can be used to update the VM Version remotely. In this example, here we upgrade the configuration version of VM1 from 5.0 to 7.0 to take advantage of many new Hyper-V features associated with this VM configuration version such as Production Checkpoints (Application Consistent backups), and binary VM configuration file.

       ![Screencap showing the Update-VMVersion cmdlet in action](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_StopVM.png)
       **Figure 22: Upgrading a VM version using the Update-VMVersion PowerShell cmdlet**

6. Storage pools can be upgraded using the [Update-StoragePool](/powershell/module/storage/Update-StoragePool) PowerShell cmdlet - this is an online operation.

Although we're targeting Private Cloud scenarios, specifically Hyper-V and Scale-out File Server clusters, which can be upgraded without downtime, the Cluster OS Rolling Upgrade process can be used for any cluster role.


## Cluster transition states during Cluster OS Rolling Upgrade

This section describes the transition states of a rolling cluster upgrade, which involves moving a workload from a node running an older version of Windows Server to a node running a newer version of Windows Server. The process is fully reversible until the `Update-ClusterFunctionalLevel` PowerShell cmdlet is run on the cluster.

In order to keep the cluster workloads running during the Cluster OS Rolling Upgrade process, moving a cluster workload from a node running an older version of Windows Server to a node running a newer version of Windows Server works by using a compatibility mode. This compatibility mode makes the nodes running the newer version of Windows Server appear as if they're running the same older version of Windows Server. For example, when upgrading a Windows Server 2016 cluster to Windows Server 2019, Windows Server 2019 nodes operate in a Windows Server 2016 compatibility mode as a temporary measure. A new conceptual cluster mode, called *mixed-OS mode*, allows nodes of different versions to exist in the same cluster (see Figure 1).

![Illustration showing the three stages of a Cluster OS Rolling Upgrade: all nodes Windows Server 2012 R2, mixed-OS mode, and all nodes Windows Server 2016](media/Cluster-Operating-System-Rolling-Upgrade/Clustering_RollingUpgrade_Overview.png)
**Figure 1: Cluster OS state transitions**

A Windows Server cluster enters mixed-OS mode when a node running a newer version of Windows Server is added to the cluster. The process is fully reversible at this point - newer Windows Server nodes can be removed from the cluster and nodes running the existing version of Windows Server can be added to the cluster in this mode. The process isn't reversible once the `Update-ClusterFunctionalLevel` PowerShell cmdlet is run on the cluster. In order for this cmdlet to succeed, all nodes must be running the newer version of Windows Server, and all nodes must be online.

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

## Transition states of a four-node cluster while performing Rolling OS Upgrade

This section illustrates and describes the four different stages of a cluster with shared storage whose nodes are upgraded from Windows Server 2012 R2 to Windows Server 2016. The process is the same for later versions of Window Server.

"Stage 1" is the initial state - we start with a Windows Server 2012 R2 cluster.

![Illustration showing the initial state: all nodes Windows Server 2012 R2](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_Stage1.png)
**Figure 2: Initial State: Windows Server 2012 R2 Failover Cluster (Stage 1)**

In "Stage 2", two nodes have been paused, drained, evicted, reformatted, and installed with Windows Server 2016.

![Illustration showing the cluster in mixed-OS mode: out of the example 4-node cluster, two nodes are running Windows Server 2016, and two nodes are running Windows Server 2012 R2](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_Stage2.png)
**Figure 3: Intermediate State: Mixed-OS mode: Windows Server 2012 R2 and Windows Server 2016 Failover cluster (Stage 2)**

At "Stage 3", all of the nodes in the cluster have been upgraded to Windows Server 2016, and the cluster is ready to be upgraded with `Update-ClusterFunctionalLevel` PowerShell cmdlet.

> [!NOTE]
> At this stage, the process can be fully reversed, and  Windows Server 2012 R2  nodes can be added to this cluster.

![Illustration showing that the cluster has been fully upgraded to Windows Server 2016, and is ready for the `Update-ClusterFunctionalLevel` cmdlet to bring the cluster functional level up to Windows Server 2016](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_Stage3.png)
**Figure 4: Intermediate State: All nodes upgraded to Windows Server 2016, ready for Update-ClusterFunctionalLevel (Stage 3)**

After the `Update-ClusterFunctionalLevel` cmdlet is run, the cluster enters "Stage 4", where new Windows Server 2016 cluster features can be used.

![Illustration showing that the cluster rolling OS upgrade has been successfully completed; all nodes have been upgraded to Windows Server 2016, and the cluster is running at the Windows Server 2016 cluster functional level](media/Cluster-Operating-System-Rolling-Upgrade/Cluster_RollingUpgrade_Stage4.png)
**Figure 5: Final State: Windows Server 2016 Failover Cluster (Stage 4)**

## Frequently asked questions

**How long can the failover cluster run in mixed-OS mode?**
    We encourage customers to complete the upgrade within four weeks. We have successfully upgraded Hyper-V and Scale-out File Server clusters with zero downtime in less than four hours total.

**Will you port this feature back to Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008?**
    We don't have any plans to port this feature back to previous versions. The Cluster OS Rolling Upgrade is envisioned as the solution for upgrading Windows Server clusters.

**Do the nodes running the older Windows Server version need to have all the software updates installed before starting the Cluster OS Rolling Upgrade process?**
    Yes, before starting the Cluster OS Rolling Upgrade process, verify that all cluster nodes are updated with the latest software updates.

**Can I run the [`Update-ClusterFunctionalLevel`](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet while nodes are Off or Paused?**
    No. All cluster nodes must be on and in active membership for the [`Update-ClusterFunctionalLevel`](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) cmdlet to work.

**Does the Cluster OS Rolling Upgrade work for any cluster workload? Does it work for SQL Server?**
    Yes, the Cluster OS Rolling Upgrade works for any cluster workload. However, it's only zero-downtime for Hyper-V and Scale-out File Server clusters. Most other workloads incur some downtime (typically a couple of minutes) when they failover, and failover is required at least once during the Cluster OS Rolling Upgrade process.

**Can I automate this process using PowerShell?**
    Yes, we have designed the Cluster OS Rolling Upgrade to be automated using PowerShell.

**For a large cluster that has extra failover capacity, can I upgrade multiple nodes simultaneously?**
    Yes. When one node is removed from the cluster to upgrade the OS, the cluster has one less node for failover, hence has a reduced failover capacity. For large clusters with enough workload and failover capacity, multiple nodes can be upgraded simultaneously. You can temporarily add cluster nodes to the cluster to provide improved workload and failover capacity during the Cluster OS Rolling Upgrade process.

**What if I discover an issue in my cluster after [`Update-ClusterFunctionalLevel`](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel) has been run successfully?**
    If you have backed-up the cluster database with a System State backup before running [`Update-ClusterFunctionalLevel`](/powershell/module/failoverclusters/Update-ClusterFunctionalLevel), you should be able to perform an Authoritative restore on a node running the previous version of Windows Server and restore the original cluster database and configuration.

**Can I use in-place upgrade for each node instead of using clean-OS install by reformatting the system drive?**
    Yes, carefully read all warning messages displayed during in-place upgrade of a cluster node.

**If I am using Hyper-V replication for a Hyper-V VM on my Hyper-V cluster, will replication remain intact during and after the Cluster OS Rolling Upgrade process?**
    Yes, Hyper-V replica remains intact during and after the Cluster OS Rolling Upgrade process.

**Can I use System Center Virtual Machine Manager (SCVMM) to automate the Cluster OS Rolling Upgrade process?**
    Yes, you can automate the Cluster OS Rolling Upgrade process using VMM in System Center.
