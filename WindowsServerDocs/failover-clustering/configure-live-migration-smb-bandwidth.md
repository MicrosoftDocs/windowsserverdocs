---
title: Configure Cluster-wide Live Migration SMB Bandwidth control in Windows Server
description: #Required; Keep the description within 100- and 165-characters including spaces.
author: #Required; your GitHub user alias, with correct capitalization
ms.author: #Required; microsoft alias of author
ms.service: #Required; use the name-string related to slug in ms.product/ms.service
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: #Required; mm/dd/yyyy format

#CustomerIntent: As a < type of user >, I want < what? > so that < why? >.
---

> Applies to:  Windows Server 2022, Azure Stack HCI, version 21H2 and later versions of both

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.

This template provides the basic structure of a How-to article pattern. See the
[instructions - How-to](../level4/article-how-to-guide.md) in the pattern library.

You can provide feedback about this template at: https://aka.ms/patterns-feedback

How-to is a procedure-based article pattern that show the user how to complete a task in their own environment. A task is a work activity that has a definite beginning and ending, is observable, consist of two or more definite steps, and leads to a product, service, or decision.

-->

<!-- 1. H1 -----------------------------------------------------------------------------

Required: Use a "<verb> * <noun>" format for your H1. Pick an H1 that clearly conveys the task the user will complete.

For example: "Migrate data from regular tables to ledger tables" or "Create a new Azure SQL Database".

* Include only a single H1 in the article.
* Don't start with a gerund.
* Don't include "Tutorial" in the H1.

-->

# Configure cluster-wide Live Migration SMB bandwidth control

Cluster-wider parameters enable you to reserve network bandwidth for SMB between failover cluster
nodes. With automatic configuration of the SMB bandwidth limits for live migration, administrations
no longer need to analyze and configuring these on individual cluster nodes. This article shows you
how to configure cluster-wide Live Migration SMB Bandwidth control in Windows Server and Azure Stack
HCI.

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

- Each cluster node must have the Hyper-V Server role installed and configured. See
  [Install the Hyper-V role on Windows Server](../virtualization/hyper-v/get-started/Install-the-Hyper-V-role-on-Windows-Server.md)
  for more information on how to get stared.

- Each cluster node must have the
  [FS-SMBBW](/powershell/module/smbshare/set-smbbandwidthlimit?view=windowsserver2022-ps) Windows
  Feature installed.

- An account that is a member of the Administrators group, or equivalent.

TODO: Move to following sections.

- Review the live migration performance options using the article
  [Virtual Machine Live Migration Overview](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831435(v=ws.11)).

- Review
  [Network recommendations for a Hyper-V cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn550728(v=ws.11)#live-migration-traffic).

## Calculate bandwidth limit

Before you can configure a bandwidth limit for SMB, you must calculate the total bandwidth to be
reserved for SMB traffic across all physical network adapters used by the cluster. The bandwidth
limit uses a percentage of the total bandwidth available to the cluster, even when Live Migration is
configured to use a specific cluster network.

You should consider how much bandwidth is available to the cluster and how much bandwidth is needed
for other cluster traffic as well other traffic using the same cluster network enabled for Live
Migration.

TODO: this was from copilot
The bandwidth limit is calculated as a percentage of the total bandwidth available to the cluster. The default value is 25% of the total bandwidth. For example, if the total bandwidth is 10 Gbps, the default bandwidth limit is 2.5 Gbps.

The calculation of total bandwidth is the total of the bandwidth of all the physical NICs that are being used by the cluster. Not all NICs will be used for SMB interconnect between the nodes.  

Example.  Each node has 4x 10Gb NICs, 2 are RDMA- capable and used for inter-node connection and 2 are used for connection out to the world.  The total bandwidth is 40Gb and the default live migration reservation would then be 10Gb (25%).  Therefore, if live migration is using SMB through the interconnect, it will be limited to 10Gb.  However, SMB would be going between the nodes through the 2 RDMA capable NICs, which together have a total of 20Gb of bandwidth.  Therefore, it may use up to 50% of the available bandwidth of the 2 RDMA capable physical NICs.

## Configure Live Migration performance options

## Configure Live Migration network selection

The easiest way to select which networks can be used for LM and ordering them in priority is through Failover Cluster Manager.  It’s a cluster wide configuration.  Connect to the cluster, and in the left navigation pane go to the server, right click on “Networks” and select “Live Migration Settings…”.  This will open a dialog (see below) that allows for un-checking networks in which LM shouldn’t use, and is in a priority list.  
By default, the network the cluster will use for cluster communications and CSV and Storage Spaces Direct will be on the bottom of the list.  This is to help keep LM network traffic off of the same network the cluster is using to communicate between the nodes. See: [Configuring Network Prioritization on a Failover Cluster](https://techcommunity.microsoft.com/t5/failover-clustering/configuring-network-prioritization-on-a-failover-cluster/ba-p/371683#:~:text=up%20to%20clients.-,This%20can%20be%20configured%20by%20right%2Dclicking%20on%20the%20network,to%20connect%20through%20this%20network%E2%80%9D).

The PowerShell for this is not simple Example PowerShell in Administrator Console:

```powershell
Get-ClusterResourceType "Virtual Machine" | Get-ClusterParameter MigrationExcludeNetworks,MigrationNetworkOrder
```

```output
Object          Name                     Value                                                                     Type
------          ----                     -----                                                                     ----
Virtual Machine MigrationExcludeNetworks                                                                           String
Virtual Machine MigrationNetworkOrder    d3e9604b-7930-4fe4-946d-fd9148e5d561;4c4f44b1-833f-4b01-a963-692b6872a1a6 String
```

Note: The value of each of these parameters may be empty, which means the system default is applied.  If value field has data, it’s a comma separated string of the GUIDs that represent a cluster network. Here is an example of getting the cluster network name and ID:
Get-ClusterNetwork | FT Name,ID
Name              Id
----              --
Cluster Network 1 d3e9604b-7930-4fe4-946d-fd9148e5d561
Cluster Network 2 4c4f44b1-833f-4b01-a963-692b6872a1a6

If the node is configured to use TCP/IP or Compression, it is strongly recommended to keep the cluster network with the lowest metric at the bottom of the order.  This will help ensure live migration network traffic doesn’t starve the cluster components (cluster communications, CSV, and Storage Spaces Direct) of bandwidth. 
On a cluster with RDMA enabled network connections between the nodes, it may be desirable to leverage that by selecting SMB as the live migration performance option for all the nodes.  With this selected LM and cluster traffic will be sharing the same set of network connections and this is where it’s important to limit the bandwidth for LM, so it doesn’t starve the cluster components of network bandwidth. Historically this bandwidth limit for LM had to be calculated by a system administrator and each node individually configured.

## Configure cluster-wide SMB bandwidth limits
With the installation of the September 2022 Windows Update package or later, these new cluster parameters will be added to the system and the system default values set.  Any new node added to the cluster will automatically have the cluster wide values applied, keeping the system consistent.

The cluster-wide bandwidth limits will only be applied if the cluster nodes are on physical hardware;, they will not be in effect if the nodes are running inside of virtual machines.  

## Next step

TODO: Add your next step link(s)

> [!div class="nextstepaction"]
> [Write concepts](article-concept.md)

<!-- OR -->

## Related content

TODO: Add your next step link(s)

- [Write concepts](article-concept.md)

<!--
Remove all the comments in this template before you sign-off or merge to the main branch.
-->

