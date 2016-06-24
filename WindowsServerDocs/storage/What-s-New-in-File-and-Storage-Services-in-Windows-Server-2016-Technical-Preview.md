---
title: What&#39;s New in File and Storage Services in Windows Server 2016 Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 596f28ec-e154-4c2e-9e82-7e42afe0e9fa
author: kumudd
---
# What&#39;s New in File and Storage Services in Windows Server 2016 Technical Preview
This topic explains the new and changed functionality in Storage Services in Windows Server 2016 Technical Preview.  

-   [Storage Spaces Direct](#BKMK_SSD)  

-   [Storage Replica](#BKMK_SR)  

-   [Storage Quality of Service](#BKMK_QoS)  

-   [Data Deduplication](#BKMK_Dedup)  

-   [SMB hardening improvements](#BKMK_SMB)   

## <a name="BKMK_SSD"></a>Storage Spaces Direct  
Storage Spaces Direct enables building highly available and scalable storage using servers with local storage. It simplifies the deployment and management of software-defined storage systems and unlocks use of new classes of disk devices, such as SATA SSD and NVMe disk devices, that were previously not possible with clustered Storage Spaces with shared disks.  

**What value does this change add?**  

Storage Spaces Direct enables service providers and enterprises to use industry standard servers with local storage to build highly available and scalable software defined storage. Using servers with local storage decreases complexity, increases scalability, and enables use of storage devices that were not previously possible, such as SATA solid state disks to lower cost of flash storage, or NVMe solid state disks for better performance.  

Storage Spaces Direct removes the need for a shared SAS fabric, simplifying deployment and configuration. Instead it uses the network as a storage fabric, leveraging SMB3 and SMB Direct (RDMA) for high-speed, low-latency CPU efficient storage. To scale out, simply add more servers to increase storage capacity and I/O performance  
For more information, see the [Storage Spaces Direct in Windows Server 2016 Technical Preview](storage-spaces/Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md).  

**What works differently?**  

This capability is new in Windows Server 2016 Technical Preview.  

## <a name="BKMK_SR"></a>Storage Replica  
Storage Replica (SR) is a new feature that enables storage-agnostic, block-level, synchronous replication between servers or clusters for disaster recovery, as well as stretching of a failover cluster between sites. Synchronous replication enables mirroring of data in physical sites with crash-consistent volumes to ensure zero data loss at the file-system level. Asynchronous replication allows site extension beyond metropolitan ranges with the possibility of data loss.  

**What value does this change add?**  

Storage Replication enables you to do the following:  

-   Provide a single vendor disaster recovery solution for planned and unplanned outages of mission critical workloads.  

-   Use SMB3 transport with proven reliability, scalability, and performance.  

-   Stretch Windows failover clusters to metropolitan distances.  

-   Use Microsoft software end to end for storage and clustering, such as Hyper-V, Storage Replica, Storage Spaces, Cluster, Scale-Out File Server, SMB3, Deduplication, and ReFS/NTFS.  

-   Help reduce cost and complexity as follows:  

    -   Is hardware agnostic, with no requirement for a specific storage configuration like DAS or SAN.  

    -   Allows commodity storage and networking technologies.  

    -   Features ease of graphical management for individual nodes and clusters through Failover Cluster Manager.  

    -   Includes comprehensive, large-scale scripting options through Windows PowerShell.  

-   Help reduce downtime, and increase reliability and productivity intrinsic to Windows.  

-   Provide supportability, performance metrics, and diagnostic capabilities.  

For more information, see the [Storage Replica in Windows Server 2016 Technical Preview](storage-replica/Storage-Replica-in-Windows-Server-2016-Technical-Preview.md).  

**What works differently?**  

This capability is new in Windows Server 2016 Technical Preview.  

## <a name="BKMK_QoS"></a>Storage Quality of Service  
You can now use storage quality of service (QoS) to centrally monitor end-to-end storage performance and create policies using Hyper-V and Scale-Out File Servers in Windows Server 2016 Technical Preview.  

**What value does this change add?**  

You can now create storage QoS policies on a Scale-Out File Server and assign them to one or more virtual disks on Hyper-V virtual machines. Storage performance is automatically readjusted to meet policies as the storage load fluctuates.  

-   Each policy specifies a reserve (minimum) and a limit (maximum) to be applied to a collection of data flows, such as a virtual hard disk, a single virtual machine or a group of virtual machines, a service, or a tenant.  

-   Using Windows PowerShell or WMI, you can perform the following tasks:  

    -   Create policies on a Scale-Out File Server.  

    -   Enumerate policies available on a Scale-Out File Server.  

    -   Assign a policy to a virtual hard disk on a server running Hyper-V.  

    -   Monitor the performance of each flow and status within the policy.  

-   If multiple virtual hard disks share the same policy, performance is fairly distributed to meet demand within the policy minimum and maximum. Therefore, a policy can be used to represent a virtual machine, multiple virtual machines comprising a service, or all virtual machines owned by a tenant.  

**What works differently?**  

This capability is new in Windows Server 2016 Technical Preview. It was not possible to configure centralized policies for storage QoS in previous releases of Windows Server.  

For more information, see [Storage Quality of Service](software-defined-storage/Storage-Quality-of-Service.md)  

## <a name="BKMK_Dedup"></a>Data Deduplication  
This section describes changes in the Data Deduplication feature in Windows Server 2016 Technical Preview, including major performance improvements to better support large scale deployments and integrated support for virtualized backup workloads.  For more information about Data Duplication, see [Data Deduplication Overview](https://technet.microsoft.com/library/hh831602.aspx).  

The following table describes the changes in Data Deduplication functionality in Windows Server 2016 Technical Preview:  

|Functionality|New or Updated|Description|  
|-----------------|------------------|---------------|  
|[Support for Volume Sizes up to 64 TB](#BKMK_Dedup1)|Updated|Deduplication Processing Pipeline is now multithreaded and able to utilize multiple CPU’s per volume to increase optimization throughput rates on volume sizes up to 64 TB.|  
|[Support for File Sizes up to 1 TB](#BKMK_Dedup2)|Updated|Deduplication of large files is vastly improved: faster optimization throughput, better performance access, and the ability to resume optimization of large files (rather than restart) after failover.|  
|[Simplified Deduplication Configuration for Virtualized Backup Applications](#BKMK_Dedup3)|Updated|New predefined configuration for Virtualized Backup Applications |  
|[Support for Nano server](#BKMK_Dedup4)|New |Deduplication is now supported in the Nano Server deployment option for Windows Server 2016.|  
|[Support for Cluster Rolling Upgrades](#BKMK_Dedup5)|New|Deduplication can run in a cluster with different nodes running a mix of  Windows Server 2012 R2  and Windows Server 2016 Technical Preview, providing full access to deduplicated volumes during a cluster rolling upgrade.|  
### <a name="BKMK_Dedup1"></a>Support for Volume Sizes up to 64 TB  
**What value does this change add?**  

In Windows Server 2012 R2, in order to get the best performance out of Data Deduplication, workload type must be considered when creating the volume to ensure that the Deduplication Processing Pipeline can keep up with the rate of data changes, or “churn”. Typically, this means that Deduplication in Windows Server 2012 R2 is not performant on volumes greater than 10 TB in size (or less for workloads with a high rate of data changes).  
In Windows Server 2016, Data Deduplication performs on volumes up to 64 TB  

**What works differently?**  

In  Windows Server 2012 R2 , Data Deduplication optimizes data using a single-threaded job and I/O queue for each volume. In Windows Server 2016, the Deduplication Processing Pipeline has been redesigned to run multiple threads in parallel using multiple I/O queues for each volume, resulting in performance that was only possible before by dividing up data into multiple, smaller volumes..  

### <a name="BKMK_Dedup2"></a>Support for File Sizes up to 1 TB  

**What value does this change add?**  
In Windows Server 2012 R2, very large files are not good candidates for Data Deduplication due to decreased performance of the Deduplication Processing Pipeline. In Windows Server 2016, Deduplication of files up to 1 TB is very performant, enabling administrators to apply deduplication savings to a larger range of workloads. For example, enabling deduplication of very large files normally associated with backup workloads.  

**What works differently?**  
In Windows Server 2016, Data Deduplication makes use of new stream map structures and other “under-the-hood” improvements to increase optimization throughput and access performance. Additionally, the Deduplication Processing Pipeline can now resume optimization progress on a file (rather than restart) after a failover. These changes add up to Deduplication on files up to 1 TB being highly performant.  

### <a name="BKMK_Dedup3"></a>Simplified Deduplication Configuration for Virtualized Backup Applications  
**What value does this change add?**  
While Deduplication for Virtualized Backup Applications is a supported scenario in Windows Server 2012 R2, it requires manually tuning the Deduplication settings. In Windows Server 2016, the configuration of Deduplication for Virtualized Backup Applications is drastically simplified by a predefined “Usage Type” option when enabling Deduplication for a volume, just like our options for General Purpose File Server and VDI.   

### <a name="BKMK_Dedup4"></a>Support for Nano Server  
**What value does this change add?**  

Nano Server is a new headless deployment option in Windows Server 2016 that has far small system resource footprint, starts up significantly faster, and requires fewer updates and restarts than the Windows Server Core deployment option. Data Deduplication is fully supported on Nano Server. For more information about Nano Server, see [Getting Started with Nano Server](../compute/nano-server/Getting-Started-with-Nano-Server.md).  
### <a name="BKMK_Dedup5"></a>Support for Cluster Rolling Upgrades  
**What value does this change add?**  

Windows Failover Clusters running deduplication can have a mix of nodes running  Windows Server 2012 R2  versions of deduplication alongside nodes running Windows Server 2016 Technical Preview versions of deduplication.  This enhancement provides full data access to all deduplicated volumes during a cluster rolling upgrade, allowing for the gradual rollout of the new version of deduplication on an existing  Windows Server 2012 R2  cluster without incurring downtime to upgrade all nodes at once.  

**What works differently?**  

With previous versions of Windows Server, a Windows Failover Cluster required all nodes in the cluster to be at the exact same Windows Server version.  Starting with the Windows Server 2016 Technical Preview, the cluster rolling upgrade functionality allows a cluster to run in a mixed-mode. Deduplication supports this new mixed-mode cluster configuration to enable full data access during a cluster rolling upgrade.  

> [!NOTE]  
> Although both Windows versions of deduplication can access the optimized data, the optimization jobs will only run on the  Windows Server 2012 R2  nodes and be blocked from running on the Windows Server 2016 Technical Preview nodes until the cluster rolling upgrade is complete.  


### <a name="BKMK_SMB"></a>SMB hardening improvements for SYSVOL and NETLOGON connections  
In Windows 10 and Windows Server 2016 Technical Preview client connections to the Active Directory Domain Services default SYSVOL and NETLOGON shares on domain controllers now require SMB signing and mutual authentication (such as Kerberos).   

**What value does this change add?**  
This change reduces the likelihood of man-in-the-middle attacks.   

**What works differently?**  
If SMB signing and mutual authentication are unavailable, a Windows 10 or Windows Server 2016 computer won’t process domain-based Group Policy and scripts.  

> [!NOTE]  
> The registry values for these settings aren’t present by default, but the hardening rules still apply until overridden by Group Policy or other registry values.  

For more information on these security improvements – also referred to as UNC hardening, see Microsoft Knowledge Base article [3000483](http://support.microsoft.com/kb/3000483) and [MS15-011 & MS15-014: Hardening Group Policy](http://blogs.technet.microsoft.com/srd/2015/02/10/ms15-011-ms15-014-hardening-group-policy).  


## See also  
[What's New in Windows Server 2016 Technical Preview 5](../get-started/What-s-New-in-Windows-Server-2016-Technical-Preview-5.md)  
