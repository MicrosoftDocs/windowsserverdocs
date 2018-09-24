---
ms.assetid: c9844427-27cf-4d76-b5bb-e06368b092f7
title: Failover Clustering  
ms.prod: windows-server-threshold  
ms.topic: article
ms.manager: dongill
author: JasonGerend
ms.author: jgerend  
ms.technology: storage-failover-clustering
ms.date: 09/25/2018
ms.localizationpriority: high
---
# Failover Clustering in Windows Server

> Applies To: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

<img src="../media/landing-icons/cluster.png" style='float:left; padding:.5em;' alt="Icon indicating a group of computers"> Failover clustering - a Windows Server feature that enables you to group multiple servers together into a fault-tolerant cluster - provides new and improved features for software-defined datacenter customers and many other workloads running clusters on physical hardware or in virtual machines.

A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles (formerly called clustered applications and services). The clustered servers (called nodes) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service (a process known as failover). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node.

Failover clusters also provide Cluster Shared Volume (CSV) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.

Failover Clustering has many practical applications, including:
* Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper-V virtual machines
* Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper-V

For details on what's new, see [What's new in Failover Clustering](whats-new-in-failover-clustering.md).

## Understand

* [Scale-Out File Server for application data](sofs-overview.md)
* [Cluster and pool quorum](../storage/storage-spaces/understand-quorum.md)
* [Fault domain awareness](fault-domains.md)
* [Simplified SMB Multichannel and multi-NIC cluster networks](smb-multichannel.md)
* [VM load balancing](vm-load-balancing-overview.md)
* [Cluster sets](../storage/storage-spaces/cluster-sets.md)

## Planning

* [Failover Clustering Hardware Requirements and Storage Options](clustering-requirements.md)
* [Use Cluster Shared Volumes (CSVs)](failover-cluster-csvs.md)
* [Using guest virtual machine clusters with Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-in-vm.md)

## Deployment

* [Creating a Failover Cluster](create-failover-cluster.md)
* [Prestage Cluster Computer Objects in Active Directory Domain Services](prestage-cluster-adds.md)
* [Deploy a Cloud Witness for a Failover Cluster](deploy-cloud-witness.md)
* [Cluster operating system rolling upgrades](cluster-operating-system-rolling-upgrade.md)
* [Deploy an Active Directory-Detached Cluster](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265970\(v%3dws.11\))

## Manage

* [Cluster-Aware Updating](cluster-aware-updating.md)
* [Health Service](health-service-overview.md)
* [Configure and Manage the Quorum in a Failover Cluster](manage-cluster-quorum.md)
* [Troubleshooting using Windows Error Reporting](troubleshooting-using-wer-reports.md)

## Tools and settings

* [Failover Clustering PowerShell Cmdlets](https://go.microsoft.com/fwlink/p/?LinkId=233200)
* [Cluster Aware Updating PowerShell Cmdlets](https://docs.microsoft.com/powershell/module/clusterawareupdating/?view=win10-ps)

## Community resources

* [High Availability (Clustering) Forum](https://go.microsoft.com/fwlink/p/?LinkId=230641)
* [Failover Clustering and Network Load Balancing Team Blog](http://blogs.msdn.com/b/clustering/)

