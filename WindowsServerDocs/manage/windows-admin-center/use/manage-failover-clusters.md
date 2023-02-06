---
title: Manage Failover Clusters with Windows Admin Center
description: Manage Failover Clusters with Windows Admin Center
ms.topic: article
author: PatAltimore
ms.author: patricka
ms.date: 02/28/2022
---
# Manage Failover Clusters with Windows Admin Center

>Applies to: Windows Admin Center, Windows Admin Center Preview

> [!Tip]
> New to Windows Admin Center?
> [Download or learn more about Windows Admin Center](../overview.md).

## Managing failover clusters
[Failover clustering](../../../failover-clustering/failover-clustering-overview.md) is a Windows Server feature that enables you to group multiple servers together into a fault-tolerant cluster to increase availability and scalability of applications and services such as Scale-Out File Server, Hyper-V and Microsoft SQL Server.

While you can manage failover cluster nodes as individual servers by adding them with [Server Manager](manage-servers.md) in Windows Admin Center, you can also add them as Failover clusters to view and manage cluster resources, storage, network, nodes, roles, virtual machines and virtual switches.

![Failover cluster Overview screen](../media/manage-failover-clusters/fcm-overview.png)

## Adding a failover cluster to Windows Admin Center
To add a cluster to Windows Admin Center:

1. Click **+ Add** under All Connections.
2. Choose to add **Server clusters**.
3. Type the name of the cluster and, if prompted, the credentials to use.
4. You will have the option to add the cluster nodes as individual server connections in Windows Admin Center.
5. Click **Add** to finish.

The cluster will be added to your connection list on the Overview page. Click it to connect to the cluster.

> [!NOTE]
> You can also manage hyper-converged clustered by adding the cluster as a [Hyper-Converged Cluster connection](manage-hyper-converged.md) in Windows Admin Center.

## Tools

The following tools are available for failover cluster connections:

| Tool | Description |
| ---- | ----------- |
| Overview | View failover cluster details and manage cluster resources |
| Disks | View cluster shared disks and volumes |
| Networks | View networks in the cluster |
| Nodes | View and manage cluster nodes |
| Roles | Manage cluster roles or create an empty role |
| Updates | Manage Cluster-Aware Updates (requires [CredSSP](../understand/faq.yml#does-windows-admin-center-use-credssp-)) |
| [Virtual Machines](manage-virtual-machines.md) | View and manage virtual machines |
| Virtual Switches | View and manage virtual switches |
