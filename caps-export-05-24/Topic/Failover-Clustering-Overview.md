---
title: Failover Clustering Overview
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a9d9ac62-f6d5-4c93-9738-d95fbf7a9b84
---
# Failover Clustering Overview
This topic provides an overview of the Failover Clustering feature. Failover clusters provide high availability and scalability to many server workloads. These include server applications such as Microsoft Exchange Server, Hyper\-V, Microsoft SQL Server, and file servers. The server applications can run on physical servers or virtual machines. This topic describes the Failover Clustering feature and provides links to additional guidance about creating, configuring, and managing failover clusters that can scale to 64 physical nodes and to 8,000 virtual machines.  
  
## <a name="BKMK_OVER"></a>Feature description  
A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles. The clustered servers \(called nodes\) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service \(a process known as failover\). In addition, the clustered roles are proactively monitored to verify that they are working correctly. If they are not working, they are restarted or moved to another node. Failover clusters also provide Cluster Shared Volumes \(CSV\) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.  
  
Failover clusters are managed by using the Failover Cluster Manager snap\-in and the Failover Clustering [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets. File shares on file server clusters can additionally be managed by using the tools in File and Storage Services.  
  
## <a name="BKMK_APP"></a>Practical applications  
  
-   Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper\-V virtual machines  
  
-   Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper\-V  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
New and changed functionality in Failover Clustering supports increased scalability, easier management, faster failover, and more flexible architectures for failover clusters.  
  
For information about what is new, see [What's New in Failover Clustering in Windows Server 2012 R2](http://technet.microsoft.com/library/dn265972.aspx) and [What's New in Failover Clustering in Windows Server 2012](http://technet.microsoft.com/library/hh831414.aspx).  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
A failover cluster solution must meet the following hardware requirements:  
  
-   Hardware components in the failover cluster solution must meet the qualifications for the Certified for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] logo.  
  
-   Storage must be attached to the nodes in the cluster, if the solution is using shared storage.  
  
-   Device controllers or appropriate adapters for the storage can be Serial Attached SCSI \(SAS\), Fibre Channel, Fibre Channel over Ethernet \(FcoE\), or iSCSI.  
  
-   The complete cluster configuration \(servers, network, and storage\) must pass all tests in the Validate a Configuration Wizard.  
  
> [!NOTE]  
> In the network infrastructure that connects your cluster nodes, avoid having single points of failure.  
  
For more information about hardware compatibility, see the [Windows Server Catalog](http://go.microsoft.com/fwlink/p/?linkid=139145).  
  
For more information about the correct configuration of the servers, network, and storage for a failover cluster, see the following topics:  
  
-   [Failover Clustering Hardware Requirements and Storage Options](http://technet.microsoft.com/library/jj612869.aspx)  
  
-   [Validating Hardware for a Failover Cluster](http://technet.microsoft.com/library/jj134244.aspx)  
  
## <a name="BKMK_SOFT"></a>Software requirements  
You must follow the hardware manufacturers' recommendations for firmware updates and software updates. Usually, this means that the latest firmware and software updates have been applied. Occasionally, a manufacturer might recommend specific updates other than the latest updates.  
  
## <a name="BKMK_LINKS"></a>See also  
For more information about the Failover Clustering feature, see the following topics:  
  
-   [Failover Clustering node in the TechNet Library](http://technet.microsoft.com/library/hh831579.aspx)  
  
-   [High Availability \(Clustering\) Forum](http://go.microsoft.com/fwlink/p/?LinkId=230641)  
  
-   [Failover Clustering and Network Load Balancing Team Blog](http://blogs.msdn.com/b/clustering/)  
  
-   [Failover Clustering Cmdlets in Windows PowerShell](http://go.microsoft.com/fwlink/p/?LinkId=233200)  
  
