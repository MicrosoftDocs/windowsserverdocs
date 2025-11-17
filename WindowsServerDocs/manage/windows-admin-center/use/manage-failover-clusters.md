---
title: Manage Failover Clusters with Windows Admin Center
description: Learn how to manage failover clusters by using Windows Admin Center.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 02/28/2022
---

# Manage failover clusters by using Windows Admin Center

> [!Tip]
> New to Windows Admin Center?
> [Download or learn more about Windows Admin Center](../overview.md).

[Failover Clustering](../../../failover-clustering/failover-clustering-overview.md) is a Windows Server feature that enables you to group multiple servers together into a fault-tolerant cluster. The purpose is to increase availability and scalability of applications and services such as Scale-Out File Server, Hyper-V, and Microsoft SQL Server.

You can manage failover cluster nodes as individual servers by using [Server Manager](manage-servers.md) to add them in Windows Admin Center. But you can also add them as failover clusters to view and manage cluster resources, storage, networks, nodes, roles, virtual machines, and virtual switches.

![Screenshot of the list of cluster resources in Windows Admin Center.](../media/manage-failover-clusters/fcm-overview.png)

## Add a failover cluster to Windows Admin Center

1. Under **All Connections**, select **+ Add**.

2. Select **Server clusters** as the connection type.

3. Enter the name of the cluster. If you're prompted, enter the credentials to use.

4. Choose whether to add the cluster nodes as individual server connections in Windows Admin Center.

5. Select **Add** to finish.

The cluster is added to your list of connections on the **Overview** page. Select it to connect to the cluster.

> [!NOTE]
> You can also manage hyper-converged clusters by adding the cluster as a [hyper-converged cluster connection](manage-hyper-converged.md) in Windows Admin Center.

## Tools

The following areas of Windows Admin Center represent tools that are available for failover cluster connections:

| Area | Description |
| ---- | ----------- |
| **Overview** | View failover cluster details and manage cluster resources. |
| **Disks** | View cluster shared disks and volumes. |
| **Networks** | View networks in the cluster. |
| **Nodes** | View and manage cluster nodes. |
| **Roles** | Manage cluster roles or create an empty role. |
| **Updates** | Manage Cluster-Aware Updating (requires [CredSSP](../understand/faq.yml#does-windows-admin-center-use-credssp-)). |
| **Virtual Machines** | View and manage [virtual machines](manage-virtual-machines.md). |
| **Virtual Switches** | View and manage virtual switches. |
