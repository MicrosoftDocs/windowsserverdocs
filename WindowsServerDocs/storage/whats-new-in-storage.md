---
ms.assetid: 0f2a7f7b-aca8-4e5d-ad67-4258e88bc52f
title: What's new in storage in Windows Server
ms.prod: windows-server
ms.author: jgerend
ms.manager: dongill
ms.technology: storage
ms.topic: article
author: jasongerend
ms.date: 05/29/2019
---
# What's new in Storage in Windows Server

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

This topic explains the new and changed functionality in storage in Windows Server 2019, Windows Server 2016, and Windows Server Semi-Annual Channel releases.

## What's new in storage in Windows Server, version 1903

This release of Windows Server adds the following changes and technologies.

### Storage Migration Service now migrates local accounts, clusters, and Linux servers

Storage Migration Service makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers and then transfers the data and configuration to newer servers—all without apps or users having to change anything.

When using this version of Windows Server to orchestrate migrations, we've added the following abilities:

- Migrate local users and groups to the new server
- Migrate storage from failover clusters
- Migrate storage from a Linux server that uses Samba
- More easily sync migrated shares into Azure by using Azure File Sync
- Migrate to new networks such as Azure

For more info about Storage Migration Service, see [Storage Migration Service overview](storage-migration-service/overview.md).

### System Insights disk anomaly detection

[System Insights](../manage/system-insights/overview.md) is a predictive analytics feature that locally analyzes Windows Server system data and provides insight into the functioning of the server. It comes with a number of built-in capabilities, but we've added the ability to install additional capabilities via Windows Admin Center, starting with disk anomaly detection.

Disk anomaly detection is a new capability that highlights when disks are behaving *differently* than usual. While different isn't necessarily a bad thing, seeing these anomalous moments can be helpful when troubleshooting issues on your systems.

This capability is also available for servers running Windows Server 2019.

### Windows Admin Center enhancements

A new release of Windows Admin Center is out, adding new functionality to Windows Server. For info on the latest features, see [Windows Admin Center](../manage/windows-admin-center/understand/windows-admin-center.md).

## What's new in storage in Windows Server 2019 and Windows Server, version 1809

This release of Windows Server adds the following changes and technologies.

### Manage storage with Windows Admin Center

[Windows Admin Center](../manage/windows-admin-center/overview.md) is a new locally deployed, browser-based app for managing servers, clusters, hyper-converged infrastructure with Storage Spaces Direct, and Windows 10 PCs. It comes at no additional cost beyond Windows and is ready for production use.

To be fair, Windows Admin Center is a separate download that runs on Windows Server 2019 and other versions of Windows, but it's new and we didn't want you to miss it...

### Storage Migration Service

Storage Migration Service is a new technology that makes it easier to migrate servers to a newer version of Windows Server. It provides a graphical tool that inventories data on servers, transfers the data and configuration to newer servers, and then optionally moves the identities of the old servers to the new servers so that apps and users don't have to change anything. For more info, see [Storage Migration Service](storage-migration-service/overview.md).

### <a id="storage-spaces-direct"></a>Storage Spaces Direct (Windows Server 2019 only)

There are a number of improvements to Storage Spaces Direct in Windows Server 2019 (Storage Spaces Direct isn't included in Windows Server, Semi-Annual Channel):

- **Deduplication and compression for ReFS volumes**

    Store up to ten times more data on the same volume with deduplication and compression for the ReFS filesystem. (It's [just one click](https://www.youtube.com/watch?v=PRibTacyKko&feature=youtu.be) to turn on with Windows Admin Center.) The variable-size chunk store with optional compression maximizes savings rates, while the multi-threaded post-processing architecture keeps performance impact minimal. Supports volumes up to 64 TB and will deduplicate the first 4 TB of each file.

- **Native support for persistent memory**

    Unlock unprecedented performance with native Storage Spaces Direct support for persistent memory modules, including Intel® Optane™ DC PM and NVDIMM-N. Use persistent memory as cache to accelerate the active working set, or as capacity to guarantee consistent low latency on the order of microseconds. Manage persistent memory just as you would any other drive in PowerShell or Windows Admin Center.

- **Nested resiliency for two-node hyper-converged infrastructure at the edge**

    Survive two hardware failures at once with an all-new software resiliency option inspired by RAID 5+1. With nested resiliency, a two-node Storage Spaces Direct cluster can provide continuously accessible storage for apps and virtual machines even if one server node goes down and a drive fails in the other server node.

- **Two-server clusters using a USB flash drive as a witness**

    Use a low-cost USB flash drive plugged into your router to act as a witness in two-server clusters. If a server goes down and then back up, the USB drive cluster knows which server has the most up-to-date data. For more info, see the [Storage at Microsoft blog](https://blogs.technet.microsoft.com/filecab/2018/06/27/windows-server-summit-recap/).

- **Windows Admin Center**

    Manage and monitor Storage Spaces Direct with the new [purpose-built Dashboard](../manage/windows-admin-center/use/manage-hyper-converged.md) and experience in Windows Admin Center. Create, open, expand, or delete volumes with just a few clicks. Monitor performance like IOPS and IO latency from the overall cluster down to the individual SSD or HDD. Available at no additional cost for Windows Server 2016 and Windows Server 2019.

- **Performance history**

    Get effortless visibility into resource utilization and performance with [built-in history](storage-spaces/performance-history.md). Over 50 essential counters spanning compute, memory, network, and storage are automatically collected and stored on the cluster for up to one year. Best of all, there's nothing to install, configure, or start – it just works. Visualize in Windows Admin Center or query and process in PowerShell.

- **Scale up to 4 PB per cluster**

    Achieve multi-petabyte scale – great for media, backup, and archival use cases. In Windows Server 2019, Storage Spaces Direct supports up to 4 petabytes (PB) = 4,000 terabytes of raw capacity per storage pool. Related capacity guidelines are increased as well: for example, you can create twice as many volumes (64 instead of 32), each twice as large as before (64 TB instead of 32 TB). Stitch multiple clusters together into a [cluster set](storage-spaces/cluster-sets.md) for even greater scale within one storage namespace. For more info, see the [Storage at Microsoft blog](https://blogs.technet.microsoft.com/filecab/2018/06/27/windows-server-summit-recap/).

- **Mirror-accelerated parity is 2X faster**

    With mirror-accelerated parity you can create Storage Spaces Direct volumes that are part mirror and part parity, like mixing RAID-1 and RAID-5/6 to get the best of both. (It's [easier than you think](https://www.youtube.com/watch?v=R72QHudqWpE) in Windows Admin Center.) In Windows Server 2019, the performance of mirror-accelerated parity is more than doubled relative to Windows Server 2016 thanks to optimizations.

- **Drive latency outlier detection**

    Easily identify drives with abnormal latency with proactive monitoring and built-in outlier detection, inspired by Microsoft Azure's long-standing and successful approach. Whether it's average latency or something more subtle like 99th percentile latency that stands out, slow drives are automatically labeled in PowerShell and Windows Admin Center with ‘Abnormal Latency' status.

- **Manually delimit the allocation of volumes to increase fault tolerance**

    This enables admins to manually delimit the allocation of volumes in Storage Spaces Direct. Doing so can significantly increase fault tolerance under certain conditions, but imposes some added management considerations and complexity. For more info, see [Delimit the allocation of volumes](storage-spaces/delimit-volume-allocation.md).

### <a name="storage-replica2019"></a>Storage Replica

There are a number of improvements to [Storage Replica](storage-replica/storage-replica-overview.md) in this release:

#### Storage Replica in Windows Server, Standard Edition

You can now use Storage Replica with Windows Server, Standard Edition in addition to Datacenter Edition. Storage Replica running on Windows Server, Standard Edition, has the following limitations:

- Storage Replica replicates a single volume instead of an unlimited number of volumes.
- Volumes can have a size of up to 2 TB instead of an unlimited size.

#### Storage Replica log performance improvements

We also made improvements to how the Storage Replica log tracks replication, improving replication throughput and latency, especially on all-flash storage as well as Storage Spaces Direct clusters that replicate between each other.

To gain the increased performance, all members of the replication group must run Windows Server 2019.

#### Test failover

You can now temporarily mount a snapshot of the replicated storage on a destination server for testing or backup purposes. For more information, see [Frequently Asked Questions about Storage Replica](https://aka.ms/srfaq).

#### Windows Admin Center support

Support for graphical management of replication is now available in Windows Admin Center via the Server Manager tool. This includes server-to-server replication, cluster-to-cluster, as well as stretch cluster replication.

#### Miscellaneous improvements

Storage Replica also contains the following improvements:

-   Alters asynchronous stretch cluster behaviors so that automatic failovers now occur
-   Multiple bug fixes

### SMB

- **SMB1 and guest authentication removal**: Windows Server no longer installs the SMB1 client and server by default. Additionally, the ability to authenticate as a guest in SMB2 and later is off by default. For more information, review [SMBv1 is not installed by default in Windows 10, version 1709 and Windows Server, version 1709](https://support.microsoft.com/help/4034314/smbv1-is-not-installed-by-default-in-windows-10-rs3-and-windows-server). 

- **SMB2/SMB3 security and compatibility**: Additional options for security and application compatibility were added, including the ability to disable oplocks in SMB2+ for legacy applications, as well as require signing or encryption on per-connection basis from a client. For more information, review the SMBShare PowerShell module help.

### Data Deduplication

- **Data Deduplication now supports ReFS**: You no longer must choose between the advantages of a modern file system with ReFS and the Data Deduplication: now, you can enable Data Deduplication wherever you can enable ReFS. Increase storage efficiency by upwards of 95% with ReFS.
- **DataPort API for optimized ingress/egress to deduplicated volumes**: Developers can now take advantage of the knowledge Data Deduplication has about how to store data efficiently to move data between volumes, servers, and clusters efficiently.

### File Server Resource Manager

Windows Server 2019 includes the ability to prevent the File Server Resource Manager service from creating a change journal (also known as a USN journal) on all volumes when the service starts. This can conserve space on each volume, but will disable real-time file classification. For more information, see [File Server Resource Manager overview](fsrm/fsrm-overview.md).

## What's new in storage in Windows Server, version 1803

### File Server Resource Manager

Windows Server, version 1803 includes the ability to prevent the File Server Resource Manager service from creating a change journal (also known as a USN journal) on all volumes when the service starts. This can conserve space on each volume, but will disable real-time file classification. For more information, see [File Server Resource Manager overview](fsrm/fsrm-overview.md).

## What's new in storage in Windows Server, version 1709

Windows Server, version 1709 is the first Windows Server release in the Semi-Annual Channel. The Semi-Annual Channel is a Software Assurance benefit and is fully supported in production for 18 months, with a new version every six months.

For more information, see [Windows Server Semi-annual Channel Overview](../get-started/semi-annual-channel-overview.md).

### Storage Replica

The disaster recovery protection added by Storage Replica is now expanded to include:

- **Test failover**: the option to mount the destination storage is now possible through the test failover feature. You can mount a snapshot of the replicated storage on destination nodes temporarily for testing or backup purposes. For more information, see [Frequently Asked Questions about Storage Replica](https://aka.ms/srfaq).
- **Windows Admin Center support**: Support for graphical management of replication is now available in Windows Admin Center via the Server Manager tool. This includes server-to-server replication, cluster-to-cluster, as well as stretch cluster replication.

Storage Replica also contains the following improvements:

-   Alters asynchronous stretch cluster behaviors so that automatic failovers now occur
-   Multiple bug fixes

### SMB

- **SMB1 and guest authentication removal**: Windows Server, version 1709 no longer installs the SMB1 client and server by default. Additionally, the ability to authenticate as a guest in SMB2 and later is off by default. For more information, review [SMBv1 is not installed by default in Windows 10, version 1709 and Windows Server, version 1709](https://support.microsoft.com/help/4034314/smbv1-is-not-installed-by-default-in-windows-10-rs3-and-windows-server). 

- **SMB2/SMB3 security and compatibility**: Additional options for security and application compatibility were added, including the ability to disable oplocks in SMB2+ for legacy applications, as well as require signing or encryption on per-connection basis from a client. For more information, review the SMBShare PowerShell module help.

### Data Deduplication

- **Data Deduplication now supports ReFS**: You no longer must choose between the advantages of a modern file system with ReFS and the Data Deduplication: now, you can enable Data Deduplication wherever you can enable ReFS. Increase storage efficiency by upwards of 95% with ReFS.
- **DataPort API for optimized ingress/egress to deduplicated volumes**: Developers can now take advantage of the knowledge Data Deduplication has about how to store data efficiently to move data between volumes, servers, and clusters efficiently.

## What's new in storage in Windows Server 2016

### <a name="s2d"></a>Storage Spaces Direct  
Storage Spaces Direct enables building highly available and scalable storage using servers with local storage. It simplifies the deployment and management of software-defined storage systems and unlocks use of new classes of disk devices, such as SATA SSD and NVMe disk devices, that were previously not possible with clustered Storage Spaces with shared disks.  

**What value does this change add?**  
Storage Spaces Direct enables service providers and enterprises to use industry standard servers with local storage to build highly available and scalable software defined storage. Using servers with local storage decreases complexity, increases scalability, and enables use of storage devices that were not previously possible, such as SATA solid state disks to lower cost of flash storage, or NVMe solid state disks for better performance.  

Storage Spaces Direct removes the need for a shared SAS fabric, simplifying deployment and configuration. Instead it uses the network as a storage fabric, leveraging SMB3 and SMB Direct (RDMA) for high-speed, low-latency CPU efficient storage. To scale out, simply add more servers to increase storage capacity and I/O performance  
For more information, see the [Storage Spaces Direct in Windows Server 2016](storage-spaces/storage-spaces-direct-overview.md).  

**What works differently?**  
This capability is new in Windows Server 2016.  

### <a name="storage-replica"></a>Storage Replica

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

### <a name="storage-qos"></a>Storage Quality of Service  
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

### <a name="dedup"></a>Data Deduplication  
| Functionality | New or Updated | Description |
|---------------|----------------|-------------|
| [Support for Large Volumes](data-deduplication/whats-new.md#large-volume-support) | Updated | Prior to Windows Server 2016, volumes had to specifically sized for the expected churn, with volume sizes above 10 TB not being good candidates for deduplication. In Windows Server 2016, Data Deduplication supports volume sizes **up to 64 TB**. |
| [Support for Large Files](data-deduplication/whats-new.md#large-file-support) | Updated | Prior to Windows Server 2016, files approaching 1 TB in size were not good candidates for deduplication. In Windows Server 2016, files **up to 1 TB** are fully supported. |
| [Support for Nano Server](data-deduplication/whats-new.md#nano-server-support) | New | Data Deduplication is available and fully supported in the new Nano Server deployment option for Windows Server 2016. |
| [Simplified Backup Support](data-deduplication/whats-new.md#simple-backup-support) | New | In Windows Server 2012 R2, Virtualized Backup Applications, such as Microsoft's [Data Protection Manager](https://technet.microsoft.com/library/hh758173.aspx), were supported through a series of manual configuration steps. In Windows Server 2016, a new default Usage Type "Backup", has been added for seamless deployment of Data Deduplication for Virtualized Backup Applications. |
| [Support for Cluster OS Rolling Upgrades](data-deduplication/whats-new.md#cluster-upgrade-support) | New | Data Deduplication fully supports the new [Cluster OS Rolling Upgrade](..//failover-clustering/cluster-operating-system-rolling-upgrade.md) feature of Windows Server 2016. |

### <a name="smb-hardening-improvements"></a>SMB hardening improvements for SYSVOL and NETLOGON connections  
In Windows 10 and Windows Server 2016 client connections to the Active Directory Domain Services default SYSVOL and NETLOGON shares on domain controllers now require SMB signing and mutual authentication (such as Kerberos).   

**What value does this change add?**  
This change reduces the likelihood of man-in-the-middle attacks.   

**What works differently?**  
If SMB signing and mutual authentication are unavailable, a Windows 10 or Windows Server 2016 computer won't process domain-based Group Policy and scripts.  

> [!NOTE]  
> The registry values for these settings aren't present by default, but the hardening rules still apply until overridden by Group Policy or other registry values.  

For more information on these security improvements - also referred to as UNC hardening, see Microsoft Knowledge Base article [3000483](https://support.microsoft.com/kb/3000483) and [MS15-011 & MS15-014: Hardening Group Policy](https://blogs.technet.microsoft.com/srd/2015/02/10/ms15-011-ms15-014-hardening-group-policy).  

### Work Folders
Improved change notification when the Work Folders server is running Windows Server 2016 and the Work Folders client is Windows 10.

**What value does this change add?**<br>
For Windows Server 2012 R2, when file changes are synced to the Work Folders server, clients are not notified of the change and wait up to 10 minutes to get the update.  When using Windows Server 2016, the Work Folders server immediately notifies Windows 10 clients and the file changes are synced immediately.

**What works differently?**<br>
This capability is new in Windows Server 2016. This requires a Windows Server 2016 Work Folders server and the client must be Windows 10.

If you're using an older client or the Work Folders server is Windows Server 2012 R2, the client will continue to poll every 10 minutes for changes.

### ReFS 
The next iteration of ReFS provides support for large-scale storage deployments with diverse workloads, delivering reliability, resiliency, and scalability for your data.     

**What value does this change add?**<br>
ReFS introduces the following improvements:

* ReFS implements new storage tiers functionality, helping deliver faster performance and increased storage capacity. This new functionality enables:
    * Multiple resiliency types on the same virtual disk (using mirroring in the performance tier and parity in the capacity tier, for example).
    * Increased responsiveness to drifting working sets.  
* The introduction of block cloning substantially improves the performance of VM operations, such as .vhdx checkpoint merge operations.
* The new ReFS scan tool enables the recovery of leaked storage and helps salvage data from critical corruptions. 

**What works differently?**<br>
These capabilities are new in Windows Server 2016. 

## See also  
* [What's New in Windows Server 2016](../get-started/what-s-new-in-windows-server-2016.md)  
