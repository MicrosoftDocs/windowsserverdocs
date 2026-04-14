---
title: Control Live Migration SMB Bandwidth Control Cluster-wide in Windows Server and Azure Local
description: Learn how to configure cluster-wide SMB bandwidth limits for Live Migration in Windows Server and Azure Local to optimize network performance and reliability.
#customer intent: As a Hyper-V administrator, I want to calculate the SMB bandwidth limit factor so that I can allocate network resources effectively.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 10/23/2025
---

# Control Live Migration SMB Bandwidth control cluster-wide

Cluster-wide parameters enable you to reserve network bandwidth for SMB between failover cluster
nodes. With automatic configuration of the SMB bandwidth limits for live migration, administrators
no longer need to analyze and configure these limits on individual cluster nodes. This article
shows you how to configure cluster-wide Live Migration SMB Bandwidth control in Windows Server and
Azure Local.

When you configure Hyper-V to use SMB for Live Migration, configuring the SMB bandwidth limits
is critical to the reliability and availability of the system. If live migration over SMB consumes
too much bandwidth, storage and cluster network traffic could be delayed or dropped, affecting the
system and hosted services.

> [!TIP]
> If you're using Azure Local, use Network ATC for all your host networking requirements, including
> SMB Bandwidth management, live migrations, and much more. To learn more about using Network ATC to
> manage SMB bandwidth limits, see
> [Manage Network ATC](../networking/network-atc/manage-network-atc.md).

## Prerequisites

Before you can configure SMB bandwidth control for Live Migration, you must have the following
prerequisites.

- A failover cluster running Windows Server or Azure Local. To learn more about creating a
  failover cluster, see [Create a failover cluster](create-failover-cluster.md) for Windows Server
  and
  [Create an Azure Local cluster](/previous-versions/azure/azure-local/deploy/create-cluster?tabs=use-network-atc-to-deploy-and-manage-networking-recommended).

- Each cluster node must have the Hyper-V Server role installed and has Live Migration configured.
  For more information, see
  [Install the Hyper-V role on Windows Server](../virtualization/hyper-v/get-started/Install-the-Hyper-V-role-on-Windows-Server.md)
  on how to get started.

- Each cluster node must have the
  [FS-SMBBW](/powershell/module/smbshare/set-smbbandwidthlimit) Windows
  Feature installed.

  > [!IMPORTANT]
  > After you install the SMB Bandwidth Limit feature on a cluster node, SMB bandwidth is limited to
  > the default of 25% of the nodes total bandwidth.

- Each cluster node must have 2022-09 Cumulative Update for Microsoft server operating system
  version 21H2 or later installed. For more information, see
[KB5017381](https://support.microsoft.com/help/5017381) for Windows Server 2022 and
[KB5017382](https://support.microsoft.com/help/5017382) for Azure Stack HCI OS, version 21H2.

- An account that is a member of the Administrators group, or equivalent.

## Calculate bandwidth limit

Before you can configure a bandwidth limit for SMB, you must calculate the total bandwidth to be
reserved for SMB traffic across all physical network adapters used by the cluster. The bandwidth
limit uses a percentage of the total bandwidth available to the cluster, even when Live Migration is
configured to use a specific cluster network.

The default SMB bandwidth limit factor is 2500 (25%) of the total bandwidth available to the cluster
node.

You should consider how much bandwidth is available to the cluster and how much bandwidth is needed
for other cluster traffic, and other traffic using the same cluster network enabled for Live
Migration.

To calculate the bandwidth limit factor, follow the steps.

1. Sum the connection speed of all network adapters in one of your clusters nodes to calculate the
   total bandwidth for a node.

   > [!IMPORTANT]
   > Cluster nodes should have the same number of network adapters across all nodes in the cluster.
   > The connected network adapters should also be connected at the same speeds as the other nodes
   > in the cluster. If the cluster nodes are consistent, the bandwidth limit is calculated
   > differently on those nodes.

1. Determine how much bandwidth you wish to reserve.

1. Calculate your SMB bandwidth limit factor using the following formula.

   :::image type="content" source="media/configure-live-migration-smb-bandwidth/smb-bandwidth-limit-factor-equation.png" alt-text="Diagram that shows the equation: (SMB bandwidth limit / total bandwidth) * 10000 = SMB bandwidth limit factor." lightbox="media/configure-live-migration-smb-bandwidth/smb-bandwidth-limit-factor-equation.png":::

If you already know the percentage of bandwidth you wish to reserve, times this value by 100.

The following example uses the formula to calculate the bandwidth limit for a cluster with four
nodes. Each node has four 10GB network adapters, with two cluster networks with two adapters each.
Only one cluster network has Live Migration enabled. The two network adapters used for Live
Migration are also used for other cluster traffic and Live Migration shouldn't consume more than
10GB or 50% of the cluster network.

The bandwidth limit is calculated as a percentage of the total bandwidth available to the cluster.
The total bandwidth is 40GB and the SMB Live Migration reservation needs to be 10GB. Therefore, the
SMB bandwidth limit factor is 2500, or 25%, as shown in the following example.

:::image type="content" source="media/configure-live-migration-smb-bandwidth/smb-bandwidth-limit-factor-equation-example.png" alt-text="Diagram that shows an example calculation reserving 10 GB of 40 GB total bandwidth, giving a limit factor of 2500 (25%)." lightbox="media/configure-live-migration-smb-bandwidth/smb-bandwidth-limit-factor-equation-example.png":::

## Configure Live Migration performance options

When you use Hyper-V in a cluster, configure the cluster nodes consistently. To use the SMB
bandwidth limit, configure the cluster nodes to use SMB for Live Migration. For more information
about Live Migration performance options, see
[Virtual Machine Live Migration Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831435(v=ws.11)).

To configure the Live Migration performance options, select the relevant method and follow the
steps.

#### [GUI](#tab/gui)

Here's how to set the SMB performance option using the user interface.

1. Open Hyper-V Manager.

1. In the left navigation pane, select the cluster node.

1. In the right pane, select **Hyper-V Settings**.

1. In the left navigation pane, expand **Live Migrations**, then select **Advanced Features**.

1. In the right pane, select the **SMB** performance option.

1. Select **OK** to save the changes.

Repeat these steps for each cluster node.

#### [PowerShell](#tab/powershell)

Here's how to set the SMB performance option using PowerShell.

1. Sign in to the cluster node.

1. Open a PowerShell prompt as an administrator.

1. Get all cluster nodes by running the following command.

   ```powershell
   $ClusterNodes = (Get-ClusterNode).name
   ```

1. Run the following command to set the performance option to SMB.

   ```powershell
   Set-VMHost -ComputerName $ClusterNodes -VirtualMachineMigrationPerformanceOption SMB
   ```

---

## Configure Live Migration network selection

_Optional:_ When configuring SMB bandwidth limits for Live Migration, you might also want to configure
which cluster networks can be used for Live Migration settings.

The default Live Migration settings set the cluster network used for cluster communications, CSV,
and Storage Spaces Direct at the lowest preference. The default setting keeps Live
Migration network traffic away from the same network the cluster uses to communicate between
nodes. For more information about network prioritization and traffic isolation in a cluster, see the
following articles.

- [Configuring Network Prioritization on a Failover Cluster](https://techcommunity.microsoft.com/t5/failover-clustering/configuring-network-prioritization-on-a-failover-cluster/ba-p/371683).

- [Network recommendations for a Hyper-V cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn550728(v=ws.11)#isolate-traffic-on-the-live-migration-network).

To configure the Live Migration network selection, select the relevant method and follow the steps.

#### [GUI](#tab/gui)

Here's how to set the Live Migration network selection using the user interface.

1. Open Failover Cluster Manager.

1. In the left navigation pane, expand the cluster.

1. Right-click **Networks**, then select **Live Migration Settings**.

1. In the **Live Migration Settings** dialog, select the cluster networks to use for Live
   Migration by checking or unchecking the required networks.

1. Select **OK** to save the changes.

#### [PowerShell](#tab/powershell)

Here's how to set the Live Migration network selection using PowerShell.

1. Sign in to the cluster node.

1. Open a PowerShell prompt as an administrator.

1. Get the Virtual Machine cluster resource type and store it in a variable called `$VMResourceType`.

   ```powershell
   $VMResourceType = Get-ClusterResourceType -name "Virtual Machine"
   ```

1. Get the cluster network object for the network you want to exclude from Live Migration and store
   it in a variable called `$ExcludedNetwork`.

   ```powershell
   $ExcludedNetwork = Get-ClusterNetwork -Name "Cluster Network 1"
   ```

1. Set the Live Migration network selection using the following command.

   ```powershell
   $VMResourceType | Set-ClusterParameter -Name MigrationExcludeNetworks -Value $ExcludedNetwork.Id
   ```

---

## Configure cluster-wide SMB bandwidth limits

Set the cluster-wide SMB bandwidth limits by using the `SetSMBBandwidthLimit` and
`SetSMBBandwidthLimitFactor` cluster parameters. When you add a new node to the cluster, it automatically uses
the cluster-wide values.

To apply the cluster-wide SMB bandwidth limits, follow the steps using PowerShell.

> [!IMPORTANT]
> The cluster-wide bandwidth limits apply only if the cluster nodes run on physical
> hardware. They don't take effect if the nodes run inside of virtual  
> machines.

1. Sign in to one of the cluster nodes.

1. Open a PowerShell prompt as an administrator.

1. To check the current values of the `SetSMBBandwidthLimit` and `SetSMBBandwidthLimitFactor`
   cluster parameters, use the following command.

   ```powershell
   Get-Cluster | FL SetSMBBandwidthLimit,SetSMBBandwidthLimitFactor
   ```

1. Set the SMB bandwidth limit factor with the following command using the value you calculated in
   the [Calculate bandwidth limit](#calculate-bandwidth-limit) section. For example, the following
   command sets the SMB bandwidth limit factor to 3000 (30%).

   ```powershell
   Get-Cluster | %($_.SMBBandwidthLimitFactor=3000)
   ```

1. To enable or disable the cluster-wide SMB bandwidth limits, use the following
   relevant command.

   ```powershell
   # Disabled the SMB bandwidth limit
   Get-Cluster | %($_.SMBBandwidthLimit=0)
   
   # Enable the SMB bandwidth limit (default setting)
   Get-Cluster | %($_.SMBBandwidthLimit=1)
   ```

## Next steps

Now you've configured cluster-wide Live Migration SMB bandwidth control here are some resources to
learn more.

- [Network recommendations for a Hyper-V cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn550728(v=ws.11)#isolate-traffic-on-the-live-migration-network).
- [Failover Clustering Microsoft Tech Community](https://techcommunity.microsoft.com/t5/failover-clustering/bg-p/FailoverClustering).
