---
ms.assetid: c9844427-27cf-4d76-b5bb-e06368b092f7
title: Failover Clustering  
ms.prod: windows-server-threshold
layout: LandingPage  
ms.topic: landing-page
ms.manager: dongill
author: JasonGerend
ms.author: jgerend  
ms.technology: storage-failover-clustering
ms.date: 06/06/2019
ms.localizationpriority: high
---
# Failover Clustering in Windows Server

> Applies to: Windows Server 2019, Windows Server 2016

A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles (formerly called clustered applications and services). The clustered servers (called nodes) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service (a process known as failover). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node.

Failover clusters also provide Cluster Shared Volume (CSV) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.

Failover Clustering has many practical applications, including:

* Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper-V virtual machines
* Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper-V

| **Understand**                                                               |  **Planning**                          |  **Deployment**       |
| -------------                                                                |  --------------                        | --------------------- |
| [What's new in Failover Clustering](whats-new-in-failover-clustering.md)    | [Planning Failover Clustering Hardware Requirements and Storage Options](clustering-requirements.md)  | [Creating a Failover Cluster](create-failover-cluster.md) |
| [Scale-Out File Server for application data](sofs-overview.md)               | [Use Cluster Shared Volumes (CSVs)](failover-cluster-csvs.md) | [Deploy a two-node file server](../storage/storage-spaces/storage-spaces-direct-in-vm.md) |
|  [Cluster and pool quorum](../storage/storage-spaces/understand-quorum.md)   |  [Using guest virtual machine clusters with Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-in-vm.md)       | [Prestage cluster computer objects in Active Directory Domain Services](prestage-cluster-adds.md) |
| [Fault domain awareness](fault-domains.md)                                 |                                 | [Configuring cluster accounts in Active Directory](configure-ad-accounts.md) |
| [Simplified SMB Multichannel and multi-NIC cluster networks](smb-multichannel.md) |                       | [Manage the quorum and witnesses](manage-cluster-quorum.md) |
| [VM load balancing](vm-load-balancing-overview.md)                         |                             | [Deploy a cloud witness](deploy-cloud-witness.md) |
| [Cluster sets](../storage/storage-spaces/cluster-sets.md)                  |                             |[Deploy a file share witness](file-share-witness.md) |
| [Cluster affinity](cluster-affinity.md)                                     |                            | [Cluster operating system rolling upgrades](cluster-operating-system-rolling-upgrade.md) |
|                                                                             |                            | [Upgrading a failover cluster on the same hardware](upgrade-option-same-hardware.md) |
|                                                                            |                             | [Deploy an Active Directory Detached Cluster](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265970\(v%3dws.11\))

|**Manage**  |  **Tools and settings**  |  **Community resources**       |
| ------------- |  -------------- | --------------------- |
| [Cluster-Aware Updating](cluster-aware-updating.md)    |   [Failover Clustering PowerShell Cmdlets](https://docs.microsoft.com/powershell/module/failoverclusters/?view=win10-ps)      |  [High Availability (Clustering) Forum](https://go.microsoft.com/fwlink/p/?LinkId=230641)       |
|  [Health Service](health-service-overview.md)   |   [Cluster Aware Updating PowerShell Cmdlets](https://docs.microsoft.com/powershell/module/clusterawareupdating/?view=win10-ps)      | [Failover Clustering and Network Load Balancing Team Blog](http://blogs.msdn.com/b/clustering/)        |
|  [Cluster-domain migration](cluster-domain-migration.md)   |         |         |
|  [Troubleshooting using Windows Error Reporting](troubleshooting-using-wer-reports.md)   |         |         |
