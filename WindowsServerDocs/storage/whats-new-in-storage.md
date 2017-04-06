---
ms.assetid: 0f2a7f7b-aca8-4e5d-ad67-4258e88bc52f
title: What's new in storage in Windows Server
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dongill
ms.technology: storage
ms.topic: article
author: kumudd
ms.date: 09/15/2016
--- 
# What's new in Storage in Windows Server 2016

>Applies To: Windows Server 2016

This topic explains the new and changed functionality in Storage in Windows Server 2016.

## <a name="s2d"></a>Storage Spaces Direct  
Storage Spaces Direct enables building highly available and scalable storage using servers with local storage. It simplifies the deployment and management of software-defined storage systems and unlocks use of new classes of disk devices, such as SATA SSD and NVMe disk devices, that were previously not possible with clustered Storage Spaces with shared disks.  

**What value does this change add?**  
Storage Spaces Direct enables service providers and enterprises to use industry standard servers with local storage to build highly available and scalable software defined storage. Using servers with local storage decreases complexity, increases scalability, and enables use of storage devices that were not previously possible, such as SATA solid state disks to lower cost of flash storage, or NVMe solid state disks for better performance.  

Storage Spaces Direct removes the need for a shared SAS fabric, simplifying deployment and configuration. Instead it uses the network as a storage fabric, leveraging SMB3 and SMB Direct (RDMA) for high-speed, low-latency CPU efficient storage. To scale out, simply add more servers to increase storage capacity and I/O performance  
For more information, see the [Storage Spaces Direct in Windows Server 2016](storage-spaces/storage-spaces-direct-overview.md).  

**What works differently?**  
This capability is new in Windows Server 2016.  

## <a name="storage-replica"></a>Storage Replica  
Storage Replica enables storage-agnostic, block-level, synchronous replication between servers or clusters for disaster recovery, as well as stretching of a failover cluster between sites. Synchronous replication enables mirroring of data in physical sites with crash-consistent volumes to ensure zero data loss at the file-system level. Asynchronous replication allows site extension beyond metropolitan ranges with the possibility of data loss.  

**What value does this change add?**  
Storage Replication enables you to do the following:  

* Provide a single vendor disaster recovery solution for planned and unplanned outages of mission critical workloads.
* Use SMB3 transport with proven reliability, scalability, and performance.
* Stretch Windows failover clusters to metropolitan distances.
* Use Microsoft software end to end for storage and clustering, such as Hyper-V, Storage Replica, Storage Spaces, Cluster, Scale-Out File Server, SMB3, Deduplication, and ReFS/NTFS.
* Help reduce cost and complexity as follows: 
    * Is hardware agnostic, with no requirement for a specific storage configuration like DAS or SAN.
    * Allows commodity storage and networking technologies.
    * Features ease of graphical management for individual nodes and clusters through Failover Cluster Manager.
    * Includes comprehensive, large-scale scripting options through Windows PowerShell. 
* Help reduce downtime, and increase reliability and productivity intrinsic to Windows.  
* Provide supportability, performance metrics, and diagnostic capabilities.  

For more information, see the [Storage Replica in Windows Server 2016](storage-replica/storage-replica-overview.md).  

**What works differently?**  
This capability is new in Windows Server 2016.  

## <a name="storage-qos"></a>Storage Quality of Service  
You can now use storage quality of service (QoS) to centrally monitor end-to-end storage performance and create management policies using Hyper-V and CSV clusters in Windows Server 2016.  

**What value does this change add?**  
You can now create storage QoS policies on a CSV cluster and assign them to one or more virtual disks on Hyper-V virtual machines. Storage performance is automatically readjusted to meet policies as the workloads and storage loads fluctuate.  

* Each policy can specify a reserve (minimum) and/or a limit (maximum) to be applied to a collection of data flows, such as a virtual hard disk, a single virtual machine or a group of virtual machines, a service, or a tenant.  
* Using Windows PowerShell or WMI, you can perform the following tasks:  
    * Create policies on a CSV cluster.
    * Enumerate policies available on a CSV cluster.
    * Assign a policy to a virtual hard disk of a Hyper-V virtual machine. 
    * Monitor the performance of each flow and status within the policy.  
* If multiple virtual hard disks share the same policy, performance is fairly distributed to meet demand within the policy's minimum and maximum settings. Therefore, a policy can be used to manage a virtual hard disk, a virtual machine, multiple virtual machines comprising a service, or all virtual machines owned by a tenant.  

**What works differently?**  
This capability is new in Windows Server 2016. Managing minimum reserves, monitoring flows of all virtual disks across the cluster via a single command, and centralized policy based management were not possible in previous releases of Windows Server.  

For more information, see [Storage Quality of Service](storage-qos/storage-qos-overview.md)

## <a name="dedup"></a>Data Deduplication  
| Functionality | New or Updated | Description |
|---------------|----------------|-------------|
| [Support for Large Volumes](data-deduplication/whats-new.md#large-volume-support) | Updated | Prior to Windows Server 2016, volumes had to specifically sized for the expected churn, with volume sizes above 10 TB not being good candidates for deduplication. In Windows Server 2016, Data Deduplication supports volume sizes **up to 64 TB**. |
| [Support for Large Files](data-deduplication/whats-new.md#large-file-support) | Updated | Prior to Windows Server 2016, files approaching 1 TB in size were not good candidates for deduplication. In Windows Server 2016, files **up to 1 TB** are fully supported. |
| [Support for Nano Server](data-deduplication/whats-new.md#nano-server-support) | New | Data Deduplication is available and fully supported in the new Nano Server deployment option for Windows Server 2016. |
| [Simplified Backup Support](data-deduplication/whats-new.md#simple-backup-support) | New | In Windows Server 2012 R2, Virtualized Backup Applications, such as Microsoft's [Data Protection Manager](https://technet.microsoft.com/en-us/library/hh758173.aspx), were supported through a series of manual configuration steps. In Windows Server 2016, a new default Usage Type "Backup", has been added for seamless deployment of Data Deduplication for Virtualized Backup Applications. |
| [Support for Cluster OS Rolling Upgrades](data-deduplication/whats-new.md#cluster-upgrade-support) | New | Data Deduplication fully supports the new [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) feature of Windows Server 2016. |

## <a name="smb-hardening-improvements"></a>SMB hardening improvements for SYSVOL and NETLOGON connections  
In Windows 10 and Windows Server 2016 client connections to the Active Directory Domain Services default SYSVOL and NETLOGON shares on domain controllers now require SMB signing and mutual authentication (such as Kerberos).   

**What value does this change add?**  
This change reduces the likelihood of man-in-the-middle attacks.   

**What works differently?**  
If SMB signing and mutual authentication are unavailable, a Windows 10 or Windows Server 2016 computer won't process domain-based Group Policy and scripts.  

> [!NOTE]  
> The registry values for these settings aren't present by default, but the hardening rules still apply until overridden by Group Policy or other registry values.  

For more information on these security improvements - also referred to as UNC hardening, see Microsoft Knowledge Base article [3000483](http://support.microsoft.com/kb/3000483) and [MS15-011 & MS15-014: Hardening Group Policy](http://blogs.technet.microsoft.com/srd/2015/02/10/ms15-011-ms15-014-hardening-group-policy).  

## Work Folders
Improved change notification when the Work Folders sever is running Windows Server 2016 and the Work Folders client is Windows 10.

**What value does this change add?**<br>
For Windows Server 2012 R2, when file changes are synced to the Work Folders server, clients are not notified of the change and wait up to 10 minutes to get the update.  When using Windows Sever 2016, the Work Folders server immediately notifies Windows 10 clients and the file changes are synced immediately.

**What works differently?**<br>
This capability is new in Windows Server 2016. This requires a Windows Server 2016 Work Folders server and the client must be Windows 10.

If you're using an older client or the Work Folders server is Windows Server 2012 R2, the client will continue to poll every 10 minutes for changes.

## ReFS 
The next iteration of ReFS provides support for large-scale storage deployments with diverse workloads, delivering reliability, resiliency, and scalability for your data.     

**What value does this change add?**<br>
ReFS introduces the following improvements:

* ReFS implements new storage tiers functionality, helping deliver faster performance and increased storage capacity. This new functionality enables:
    * Multiple resiliency types on the same virtual disk (using mirroring in the performance tier and parity in the capacity tier, for example).
    * Increased responsiveness to drifting working sets. 
    * Support for SMR (Shingled Magnetic Recording) media. 
* The introduction of block cloning substantially improves the performance of VM operations, such as .vhdx checkpoint merge operations.
* The new ReFS scan tool enables the recovery of leaked storage and helps salvage data from critical corruptions. 

**What works differently?**<br>
These capabilities are new in Windows Server 2016. 

## See also  
* [What's New in Windows Server 2016](../get-started/what-s-new-in-windows-server-2016.md)  
