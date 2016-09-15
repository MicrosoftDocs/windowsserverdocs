---
title: Failover Clustering  
ms.prod: windows-server-threshold  
ms.topic: article  
author: KumudD
ms.author: kumud  
ms.technology: storage-failover-clustering
ms.date: 09/15/2016
---
# Failover Clustering

>Applies To: Windows Server 2016

Failover clusters provide high availability and scalability to many server workloads. These include server applications such as Microsoft Exchange Server, Hyper-V, Microsoft SQL Server, and file servers. The server applications can run on physical servers or virtual machines. This topic describes the Failover Clustering feature and provides links to additional guidance about creating, configuring, and managing failover clusters that can scale to 64 physical nodes and to 8,000 virtual machines.

## <a id="what-is-failover-clustering"></a>What is Failover Clustering?
A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles (formerly called clustered applications and services). The clustered servers (called nodes) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service (a process known as failover). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node. Failover clusters also provide Cluster Shared Volume (CSV) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.

This has many practical applications, including:
* Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper-V virtual machines
* Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper-V

## Learn more about Failover Clustering
### Windows Server 2016-specific content
* **[Cluster Operating System Rolling Upgrade](Cluster-Operating-System-Rolling-Upgrade.md)**  
  Cluster Operating System Rolling Upgrade is a new feature in Windows Server 2016 that enables an administrator to upgrade the operating system of the cluster nodes from  Windows Server 2012 R2  to Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. Using this feature, the downtime penalties against Service Level Agreements (SLA) can be avoided.
* **[Deploy a Cloud Witness for a Failover Cluster](deploy-cloud-witness.md)**
* **[Simplified SMB Multichannel and Multi-NIC Cluster Networks](smb-multichannel.md)**
* **[Health Service](health-service-overview.md)**  
  Health Service is a new feature in Windows Server 2016 that which significantly improves the day-to-day monitoring, operations, and maintenance experience of Storage Spaces Direct.
* **[Fault Domains](fault-domains.md)**  
  Fault Domains is a new feature in Windows Server 2016. This topic provides an overview of fault domains and describes how to configure them.


### General Failover Clustering Content
| Content Type | References |
|--------------|------------|
| Planning | <ul><li>[Failover Clustering Hardware Requirements and Storage Options](https://technet.microsoft.com/library/jj612869.aspx)</li><li>[Validate Hardware for Failover Clustering](https://technet.microsoft.com/library/jj134244.aspx)</li><li>[Network Recommendations for a Hyper-V Cluster](https://technet.microsoft.com/library/dn550728.aspx)</li></ul> |
| Deployment | <ul><li>[Installing the Failover Clustering Feature and Tools](http://go.microsoft.com/fwlink/p/?LinkId=253342)</li><li>[Validate Hardware for a Failover Cluster](https://technet.microsoft.com/library/jj134244.aspx)</li><li>[Prestage Cluster Computer Objects in Active Directory Domain Services](https://technet.microsoft.com/library/dn466519.aspx)</li><li>[Creating a Failover Cluster](http://blogs.msdn.com/b/clustering/archive/2012/05/01/10299698.aspx)</li><li>[Deploy Hyper-V over SMB](https://technet.microsoft.com/library/jj134187)</li><li>[Deploy a Scale-Out File Server](https://technet.microsoft.com/library/hh831359)</li><li>[iSCSI Target Block Storage, How To](https://technet.microsoft.com/library/hh848268)</li><li>[Deploy an Active Directory Detached Cluster](https://technet.microsoft.com/library/jj556313.aspx)</li><li>[Using Guest Clustering for High Availability](https://technet.microsoft.com/library/jj863389.aspx)</li><li>[Deploy a Guest Cluster using a Shared Virtual Hard Disk](https://technet.microsoft.com/library/dn265980.aspx)</li><li>[Building Your Cloud Infrastructure: Scenario Overview](https://technet.microsoft.com/library/hh831441.aspx)</li></ul> |
| Operations | <ul><li>[Configure and Manage the Quorum in a Failover Cluster](https://technet.microsoft.com/library/jj612870.aspx)</li><li>[Use Cluster Shared Volumes in a Failover Cluster](https://technet.microsoft.com/library/jj612868.aspx)</li><li>[Cluster-Aware Updating Overview](https://technet.microsoft.com/library/hh831694.aspx)</li></ul> |
| Tools and Settings | <ul><li>[Failover Clustering PowerShell Cmdlets](http://go.microsoft.com/fwlink/p/?LinkId=233200)</li></ul> |
| Community Resources | <ul><li>[High Availability (Clustering) Forum](http://go.microsoft.com/fwlink/p/?LinkId=230641)</li><li>[Failover Clustering and Network Load Balancing Team Blog](http://blogs.msdn.com/b/clustering/)</li></ul> |
| Related Technologies | <ul><li>[Hyper-V Overview](https://technet.microsoft.com/library/hh831531.aspx)</li><li>[Storage Overview](../storage/storage-overview.md)</li><li>[Storage Spaces Overview](https://technet.microsoft.com/library/hh831739.aspx)</li><li>[Scale-Out File Server for Application Data Overview](https://technet.microsoft.com/library/hh831349.aspx)</li><li>[Network Load Balancing Overview](https://technet.microsoft.com/library/hh831698.aspx)</li><li>[Microsoft SQL Server](https://www.microsoft.com/sqlserver/default.aspx)</li><li>[Microsoft Server and Cloud Platform](https://www.microsoft.com/server-cloud/)</li><li>[System Center Virtual Machine Manager](https://technet.microsoft.com/systemcenter/vmm/default.aspx)</li></ul> 