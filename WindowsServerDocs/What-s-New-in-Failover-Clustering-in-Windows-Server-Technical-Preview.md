---
title: What&#39;s New in Failover Clustering in Windows Server Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 52f5ef26-971f-4269-b373-169dd0100688
author: kumudd
---
# What&#39;s New in Failover Clustering in Windows Server Technical Preview
This topic explains the new and changed functionality in Failover Clustering in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)].  
  
-   [Cluster Operating System Rolling Upgrade](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_RollingUpgrade)  
  
-   [Storage Replica](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_SR)  
  
-   [Cloud Witness](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_CloudWitness)  
  
-   [Virtual Machine Resiliency](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_VMs)  
  
-   [Diagnostic Improvements](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_Diagnostics)  
  
-   [Site-aware Failover Clusters](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_SiteAware)  
  
-   [Workgroup and Multi-domain Clusters](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_multidomainclusters)  
  
-   [Virtual Machine Node Fairness](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_VMNodeFairness)  
  
-   [Virtual Machine Start Order](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_VMStartOrder)  
-   [Simplified SMB Multichannel and Multi-NIC Cluster Networks](What-s-New-in-Failover-Clustering-in-Windows-Server-Technical-Preview.md#BKMK_SMBMultiChannel)  
  
## <a name="BKMK_RollingUpgrade"></a>Cluster Operating System Rolling Upgrade  
A new feature in Failover Clustering, Cluster Operating System Rolling Upgrade, enables an administrator to upgrade the operating system of the cluster nodes from [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] to [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] without stopping the Hyper\-V or the Scale\-Out File Server workloads. Using this feature, the downtime penalties against Service Level Agreements \(SLA\) can be avoided.  
  
**What value does this change add?**  
  
Upgrading a Hyper\-V or Scale\-Out File Server cluster from Windows Server 2012 R2 to [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] no longer requires downtime. The cluster will continue to function at a Windows Server 2012 R2 level until all of the nodes in the cluster are running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. The cluster functional level is upgraded to [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] by using the Windows PowerShell cmdlt `Update-ClusterFunctionalLevel`.  
  
> [!WARNING]  
> -   After you update the cluster functional level, you cannot go back to a [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] cluster functional level.  
> -   Until the `Update-ClusterFunctionalLevel` cmdlet is run, the process is reversible, and Windows Server 2012 R2 nodes can be added and [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] nodes can be removed.  
  
**What works differently?**  
  
A Hyper\-V or Scale\-Out File Server failover cluster can now easily be upgraded without any downtime or need to build a new cluster with nodes that are running the [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] operating system. Migrating clusters to Windows Server 2012 R2 involved taking the existing cluster offline and reinstalling the new operating system for each nodes, and then bringing the cluster back online. The old process was cumbersome and required downtime. However, in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], the cluster does not need to go offline at any point.  
  
The cluster operating systems for the upgrade in phases are as follows for each node in a cluster:  
  
-   The node is paused and drained of all virtual machines that are running on it.  
  
-   The virtual machines \(or other cluster workload\) are migrated to another node in the cluster.The virtual machines are migrated to another node in the cluster.  
  
-   The existing operating system is removed and a clean installation of the [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] operating system on the node is performed.  
  
-   The node running the [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] operating system is added back to the cluster.  
  
-   At this point, the cluster is said to be running in mixed mode, because the cluster nodes are running either [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)].  
  
-   The cluster functional level stays at [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]. At this functional level, new features in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] that affect compatibility with previous versions of the operating system will be unavailable.  
  
-   Eventually, all nodes are upgraded to [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)].  
  
-   Cluster functional level is then changed to [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] using the Windows PowerShell cmdlet `Update-ClusterFunctionalLevel`. At this point, you can take advantage of the [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] features.  
  
For more information, see [Cluster Operating System Rolling Upgrade](Cluster-Operating-System-Rolling-Upgrade.md).  
  
## <a name="BKMK_SR"></a>Storage Replica  
Storage Replica \(SR\) is a new feature that enables storage\-agnostic, block\-level, synchronous replication between servers or clusters for disaster recovery, as well as stretching of a failover cluster between sites. Synchronous replication enables mirroring of data in physical sites with crash\-consistent volumes to ensure zero data loss at the file\-system level. Asynchronous replication allows site extension beyond metropolitan ranges with the possibility of data loss.  
  
**What value does this change add?**  
  
Storage Replication enables you to do the following:  
  
-   Provide a single vendor disaster recovery solution for planned and unplanned outages of mission critical workloads.  
  
-   Use SMB3 transport with proven reliability, scalability, and performance.  
  
-   Stretch Windows failover clusters to metropolitan distances.  
  
-   Use Microsoft software end to end for storage and clustering, such as Hyper\-V, Storage Replica, Storage Spaces, Cluster, Scale\-Out File Server, SMB3, Deduplication, and ReFS\/NTFS.  
  
-   Help reduce cost and complexity as follows:  
  
    -   Is hardware agnostic, with no requirement for a specific storage configuration like DAS or SAN.  
  
    -   Allows commodity storage and networking technologies.  
  
    -   Features ease of graphical management for individual nodes and clusters through Failover Cluster Manager.  
  
    -   Includes comprehensive, large\-scale scripting options through Windows PowerShell.  
  
-   Help reduce downtime, and increase reliability and productivity intrinsic to Windows.  
  
-   Provide supportability, performance metrics, and diagnostic capabilities.  
  
For more information, see the [Storage Replica in Windows Server 2016 Technical Preview](Storage-Replica-in-Windows-Server-2016-Technical-Preview.md).  
  
**What works differently?**  
  
This capability is new in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)].  
  
## <a name="BKMK_CloudWitness"></a>Cloud Witness  
Cloud Witness is a new type of Failover Cluster quorum witness in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] that leverages Microsoft Azure as the arbitration point. The Cloud Witness, like any other quorum witness, gets a vote and can participate in the  quorum calculations. You can configure cloud witness as a quorum witness using the Configure a Cluster Quorum Wizard.  
  
**What value does this change add?**  
  
Using Cloud Witness as a Failover Cluster quorum witness provides the following advantages:  
  
-   Leverages Microsoft Azure and eliminates the need for a third separate datacenter.  
  
-   Uses the standard publically available Microsoft Azure Blob Storage which eliminates the extra maintenance overhead of VMs hosted in a public cloud.  
  
-   Same Microsoft Azure Storage Account can be used for multiple clusters \(one blob file per cluster; cluster unique id used as blob file name\).  
  
-   Provides a very low on\-going cost to the Storage Account \(very small data written per blob file, blob file updated only once when cluster nodes’ state changes\).  
  
For more information, see 	[Introducing Cloud Witness in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2014/11/14/10572766.aspx).  
  
**What works differently?**  
  
This capability is new in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)].  
  
## <a name="BKMK_VMs"></a>Virtual Machine Resiliency  
**Compute Resiliency**[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] includes increased virtual machines compute resiliency to help reduce intra\-cluster communication issues in your compute cluster as follows: .  
  
-   **Resiliency options  available for virtual machines:**  You can now configure virtual machine resiliency options that define behavior of the virtual machines during transient failures:  
  
    -   **Resiliency Level:** Helps you define how the transient failures are handled.  
  
    -   **Resiliency Period:**  Helps you define how long all the virtual machines are allowed to run isolated.  
  
-   **Quarantine of unhealthy nodes:** Unhealthy nodes are quarantined and are no longer allowed to join the cluster. This prevents flapping nodes from negatively effecting other nodes and the overall cluster.  
  
For more information virtual machine compute resiliency workflow and node quarantine settings that control how your node is placed in isolation or quarantine, see [Virtual Machine Compute Resiliency in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/06/03/10619308.aspx)  
  
**Storage Resiliency** In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], virtual machines are more resilient to transient storage failures. The improved virtual machine resiliency helps preserve tenant virtual machine session states in the event of a storage disruption. This is achieved by intelligent and quick virtual machine response to storage infrastructure issues.  
  
When a virtual machine disconnects from its underlying storage, it pauses and waits for storage to recover. While paused, the virtual machine retains the context of applications that are running in it. When the virtual machine’s connection to its storage is restored, the virtual machine returns to its running state. As a result, the tenant machine’s session state is retained on recovery.  
  
In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], virtual machine storage resiliency is aware and optimized for guest clusters too.  
  
## <a name="BKMK_Diagnostics"></a>Diagnostic Improvements in Failover Clustering  
To help diagnose issues with failover clusters, [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] includes the following:  
  
-   Several enhancements to cluster log files \(such as Time Zone Information and DiagnosticVerbose log\) that makes is easier to troubleshoot failover clustering issues. For more information, see  [Windows Server 2016 Failover Cluster Troubleshooting Enhancements - Cluster Log](http://blogs.msdn.com/b/clustering/archive/2015/05/15/10614930.aspx).  
  
-   A new  a dump type of **Active memory dump**, which filters out most memory pages allocated to virtual machines, and therefore makes the memory.dmp much smaller and easier to save or copy.  For more information, see [Windows Server 2016 Failover Cluster Troubleshooting Enhancements - Active Dump](http://blogs.msdn.com/b/clustering/archive/2015/05/18/10615526.aspx).  
  
## <a name="BKMK_SiteAware"></a>Site\-aware Failover Clusters  
[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] includes site\- aware failover clusters that enable group nodes in stretched clusters based on their physical location \(site\). Cluster site\-awareness enhances key operations during the cluster lifecycle such as failover behavior, placement policies, heartbeat between the nodes, and quorum behavior. For more information, see [Site-aware Failover Clusters in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/08/19/10636304.aspx).  
  
## <a name="BKMK_multidomainclusters"></a>Workgroup and Multi\-domain clusters  
In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and previous versions, a cluster can only be created between member nodes joined to the same domain.   [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] breaks down these barriers and introduces the ability to create a Failover Cluster without Active Directory dependencies. You can now create failover clusters in the following configurations:  
  
-   **Single\-domain Clusters.** Clusters with all nodes joined to the same domain.  
  
-   **Multi\-domain Clusters.** Clusters with nodes which are members of different domains.  
  
-   **Workgroup Clusters.** Clusters with nodes which are member servers \/ workgroup \(not domain joined\).  
  
For more information, see [Workgroup and Multi-domain clusters in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/08/17/10635825.aspx)  
## <a name="BKMK_VMNodeFairness"></a>Virtual Machine Node Fairness  
Virtual machine Node Fairness is a new feature in Failover Clustering that facilitates the seamless load balancing of virtual machines across the nodes in a cluster. Overcommitted nodes are identified based on virtual machine Memory and CPU utilization on the node. Virtual machines are then moved (live migrated) from an overcommitted node to nodes with available bandwidth (if applicable). The aggressiveness of the balancing can be tuned to ensure optimal cluster performance and utilization.  By default, Node Fairness is enabled by default in Windows Sever 2016 Technical Preview. However, Node Fairness is disabled when SCVMM Dynamic Optimization is enabled.  
## <a name="BKMK_VMStartOrder"></a>Virtual Machine Start Order  
Virtual machine Start Order is a new feature in Failover Clustering that introduces start order orchestration for Virtual machines (and all groups) in a cluster. Virtual machines can now be grouped into tiers, and start order dependencies can be created between different tiers. This ensures that the most important virtual machines (such as Domain Controllers or Utility virtual machines) are started first. Virtual machines are not started until the virtual machines that they have a dependency on are also started.  
  
## <a name="BKMK_SMBMultiChannel"></a> Simplified SMB Multichannel and Multi-NIC Cluster Networks  
Failover Cluster networks are no longer limited to a single NIC per subnet / network. With Simplified SMB Multichannel and Multi-NIC Cluster Networks, network configuration is automatic and every NIC on the subnet can be used for cluster and workload traffic. This enhancement allows customers to maximize network throughput for Hyper-V, SQL Server Failover Cluster Instance, and other SMB workloads.  
  
##See Also  
* [Storage](Storage.md)  
* [What's New in File and Storage Services](What-s-New-in-File-and-Storage-Services-in-Windows-Server-2016-Technical-Preview.md)  

