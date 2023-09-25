---
title: Configure Cluster-wide Live Migration SMB Bandwidth control in Windows Server
description: Learn how to configure cluster-wide Live Migration SMB bandwidth control in Windows Server and Azure Stack HCI.
author: robinharwood
ms.author: wscontent
ms.topic: how-to
ms.date: 09/25/2023
---

> Applies to:  Windows Server 2022, Azure Stack HCI, version 21H2 and later versions of both

# Configure cluster-wide Live Migration SMB bandwidth control

Cluster-wider parameters enable you to reserve network bandwidth for SMB between failover cluster
nodes. With automatic configuration of the SMB bandwidth limits for live migration, administrations
no longer need to analyze and configuring these limits on individual cluster nodes. This article
shows you how to configure cluster-wide Live Migration SMB Bandwidth control in Windows Server and
Azure Stack HCI.

When you configure Hyper-V to use SMB for Live Migration, having the SMB bandwidth limits configured
is critical to the reliability and availability of the system. If live migration over SMB consumes
too much bandwidth, storage and cluster network traffic could be delayed or dropped affecting the
system and hosted services.

## Prerequisites

Before you can configure SMB bandwidth control for Live Migration, you must have the following
prerequisites.

- A failover cluster running Windows Server or Azure Stack HCI. To learn more creating a failover
  cluster, see [Create a failover cluster](create-failover-cluster.md) for Windows Server and
  [Create an Azure Stack HCI cluster](/azure-stack/hci/deploy/create-cluster?tabs=use-network-atc-to-deploy-and-manage-networking-recommended).

- Each cluster node must have the Hyper-V Server role installed and configured. For more
  information, see
  [Install the Hyper-V role on Windows Server](../virtualization/hyper-v/get-started/Install-the-Hyper-V-role-on-Windows-Server.md)
  for more information on how to get stared.

- Each cluster node must have the
  [FS-SMBBW](/powershell/module/smbshare/set-smbbandwidthlimit?view=windowsserver2022-ps) Windows
  Feature installed.

- Each cluster node must have the 2022-09 Cumulative Update for Microsoft server operating system
  version 21H2 for x64-based installed. For more information, see
[KB5017381](https://support.microsoft.com/help/5017381) for Windows Server 2022 and
[KB5017382](https://support.microsoft.com/help/5017382) for Azure Stack HCI, version 21H2.

- An account that is a member of the Administrators group, or equivalent.

## Calculate bandwidth limit

Before you can configure a bandwidth limit for SMB, you must calculate the total bandwidth to be
reserved for SMB traffic across all physical network adapters used by the cluster. The bandwidth
limit uses a percentage of the total bandwidth available to the cluster, even when Live Migration is
configured to use a specific cluster network.

You should consider how much bandwidth is available to the cluster and how much bandwidth is needed
for other cluster traffic, as well other traffic using the same cluster network enabled for Live
Migration.

To calculate the bandwidth limit, use the following formula.

$SMB Bandwidth Limit = Number of NICs \times NIC bandwidth \times $($SMB Bandwidth Limit Factor
\over 10000$)

TODO: insert calculation formula

To calculate the SMB bandwidth limit factor, the following formula is used.

TOD: insert SMB bandwidth limit factor formula

The following example uses the formula to calculate the bandwidth limit for a cluster with four
nodes. Each node has four 10GB network adapters, with two cluster networks with two adapters each.
Only one cluster network has Live Migration enabled. The two network adapters used for Live
Migration are also used for other cluster traffic, Live Migration shouldn't consume more than 50%
of the available bandwidth.

TODO: insert example

The bandwidth limit is calculated as a percentage of the total bandwidth available to the cluster.
The total bandwidth is 40GB and the default SMB Bandwidth Limit Factor is 2500, or 25%. Therefore,
the default SMB Live Migration reservation would then be 10GB (25%). Meaning that the default
SMB bandwidth limit is 10GB, or 50% of the Live Migration network bandwidth.

Therefore, if live migration is using SMB through the interconnect, it's limited to 10GB. However,
SMB would be going between the nodes through the two NICs, which together have a total of 20GB of
bandwidth. Therefore, it may use up to 50% of the available bandwidth of the two physical NICs.

## Configure Live Migration performance options

When you're using Hyper-V in a cluster, the cluster nodes should be configured consistently. To use the SMB
bandwidth limit, the cluster nodes must be configured to use SMB for Live Migration. To learn more
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

1. Sign into the cluster node.

1. Open an elevated PowerShell prompt as an administrator.

1. Run the following command to set the performance option to SMB.

   ```powershell
   Set-VMHost -VirtualMachineMigrationPerformanceOption SMB
   ```

Repeat these steps for each cluster node. Alternatively, configure multiple cluster nodes using the
following command in an elevated PowerShell prompt as an administrator.

```powershell
Set-VMHost -ComputerName Server1,Server2 -VirtualMachineMigrationPerformanceOption SMB
```

---

## Configure Live Migration network selection

When configuring SMB bandwidth limits for Live Migration, you may also want to configure which
cluster networks can be used for Live Migration settings.

The default Live Migration settings set the cluster network used for cluster communications,
CSV, and Storage Spaces Direct at the lowest preference. The default setting is designed to keep
Live Migration network traffic away from the same network the cluster is using to communicate
between the nodes. To learn more about network prioritization and traffic isolation in a cluster, see the following articles.

- [Configuring Network Prioritization on a Failover Cluster](https://techcommunity.microsoft.com/t5/failover-clustering/configuring-network-prioritization-on-a-failover-cluster/ba-p/371683).

- [Network recommendations for a Hyper-V cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn550728(v=ws.11)#isolate-traffic-on-the-live-migration-network).

To configure the Live Migration network selection, select the relevant method and follow the steps.

#### [GUI](#tab/gui)

Here's how to set the Live Migration network selection using the user interface.

1. Open Failover Cluster Manager.

1. In the left navigation pane, expand the cluster.

1. Right-click **Networks**, then select **Live Migration Settings**.

1. In the **Live Migration Settings** dialog, select the cluster networks to be used for Live
   Migration by checking or unchecking the required networks.

1. Select **OK** to save the changes.

#### [PowerShell](#tab/powershell)

Here's how to set the Live Migration network selection using PowerShell.

1. Sign into the cluster node.

1. Open an elevated PowerShell prompt as an administrator.

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

You can set the cluster-wide SMB bandwidth limits using the `SetSMBBandwidthLimit` and
`SetSMBBandwidthLimitFactor` cluster parameters. Any new node added to the cluster automatically has
the cluster wide values applied.

To apply the cluster-wide SMB bandwidth limits, follow the steps using PowerShell.

> [!IMPORTANT]
> The cluster-wide bandwidth limits will only be applied if the cluster nodes are on physical
> hardware, they will not be in effect if the nodes are running inside of virtual  
> machines.

1. Sign into one of the cluster nodes.

1. Open an elevated PowerShell prompt as an administrator.

1. To verify the current values of the `SetSMBBandwidthLimit` and `SetSMBBandwidthLimitFactor`
   cluster parameters, use the following command.

   ```powershell
   Get-Cluster | FL SetSMBBandwidthLimit,SetSMBBandwidthLimitFactor
   ```

1. Using the value you calculated in the [Calculate bandwidth limit](#calculate-bandwidth-limit)
   section, set the SMB bandwidth limit factor using the following command. For example, the
   following command sets the SMB bandwidth limit factor to 3000 (30%).

   ```powershell
   Get-Cluster | %($_.SMBBandwidthLimitFactor=3000)
   ```

If you want to enable or disabled the cluster-wide SMB bandwidth limits, use the following relevant
command.

```powershell
# Disabled the SMB bandwidth limit
Get-Cluster | %($_.SMBBandwidthLimit=0)

# Enable the SMB bandwidth limit
Get-Cluster | %($_.SMBBandwidthLimit=1)
```

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)
