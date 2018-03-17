---
ms.assetid: 6b74bc7c-a58d-4915-af8e-2cc27f2c4726
title: Storage overview
ms.prod: windows-server-threshold
ms.technology: storage
ms.topic: article
author: JasonGerend
manager: dongill
ms.author: jgerend
ms.date: 03/16/2018
ms.localizationpriority: high
---
# Storage in Windows Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

<img src="../media/landing-icons/storage.png" style='float:left; padding:.5em;' alt="Icon representing a drive"> Storage in Windows Server provides new and improved features for software-defined datacenter (SDDC) customers focusing on virtualized workloads. Windows Server also provides extensive support for enterprise customers using file servers with existing workloads.

To find out about what's new in storage, see [What's new in storage](whats-new-in-storage.md) and [What's new in Failover Clustering](../failover-clustering/whats-new-in-failover-clustering.md).

For an overview of storage technologies included in Windows Server, see the following list (categorized by workload).

## Software-defined storage for virtualized workloads

* [Storage Spaces Direct](storage-spaces/storage-spaces-direct-overview.md) - Storage Spaces now includes support for Storage Spaces Direct - a new architecture for Storage Spaces clusters that uses directly attached local storage - including SATA and NVME devices. Other enhancements include the ability to optimize disk usage after adding new physical disks and faster virtual disk repair times.

* [Storage Replica](storage-replica/storage-replica-overview.md) - Storage Replica enables storage-agnostic, block-level, synchronous replication between clusters or servers for disaster preparedness and recovery, as well as stretching of a failover cluster across sites for high availability. Synchronous replication enables mirroring of data in physical sites with crash-consistent volumes, ensuring zero data loss at the file system level. Asynchronous replication allows site extension beyond metropolitan ranges.

* [Storage QoS](storage-qos/storage-qos-overview.md) - Storage Quality of Service (QoS) provides a way to centrally monitor and manage storage performance for virtual machines using Hyper-V and the Scale-Out File Server roles. The feature automatically improves storage resource fairness between multiple virtual machines using the same file server cluster and allows specific minimum and maximum performance goals to be configured in units of normalized IOPs.

* [Data Deduplication](data-deduplication/overview.md) - Data Deduplication is a feature of Windows Server 2016 that can help reduce the impact of redundant data on storage costs. When enabled, Data Deduplication optimizes free space on a volume by examining the data on the volume for duplication. Once identified, duplicated portions of the volume's dataset are stored once and are (optionally) compressed for additional savings. Data Deduplication optimizes redundancies without compromise data fidelity or integrity.

## General-purpose file servers

* [Work Folders](work-folders/work-folders-overview.md) - With Work Folders users can store and access work files on personal computers and devices, often referred to as bring-your-own device (BYOD), in addition to corporate PCs. Users gain a convenient location to store work files, and they can access them from anywhere. Organizations maintain control over corporate data by storing the files on centrally managed file servers, and optionally specifying user device policies such as encryption and lock-screen passwords.

* [Offline Files, Folder Redirection, and Roaming User Profiles](https://technet.microsoft.com/library/hh848267(v=ws.11).aspx) - Folder Redirection and Offline Files are used together to redirect the path of local folders (such as the Documents folder) to a network location, while caching the contents locally for increased speed and availability. Roaming User Profiles is used to redirect a user profile to a network location.  

* [DFS Namespaces](dfs-namespaces/dfs-overview.md) - Enables you to group shared folders that are located on different servers into one or more logically structured namespaces. Each namespace appears to users as a single shared folder with a series of subfolders. However, the underlying structure of the namespace can consist of numerous file shares that are located on different servers and in multiple sites.

* [DFS Replication](https://technet.microsoft.com/library/jj127250(v=ws.11).aspx) - Enables you to efficiently replicate folders (including those referred to by a DFS namespace path) across multiple servers and sites. DFS Replication uses a compression algorithm known as remote differential compression (RDC). RDC detects changes to the data in a file, and it enables DFS Replication to replicate only the changed file blocks instead of the entire file.

* [File Server Resource Manager](fsrm/fsrm-overview.md) - File Server Resource Manager enables you to manage and classify data stored on file servers.

* [iSCSI Target Server](https://technet.microsoft.com/library/hh848272(v=ws.11).aspx) - iSCSI Target Server provides block storage to other servers and applications on the network by using the Internet SCSI (iSCSI) standard.

* [iSCSI Target Boot](iscsi/iscsi-boot-overview.md) - iSCSI Target Server in Windows Server can boot hundreds of computers from a single operating system image that is stored in a centralized location. This improves efficiency, manageability, availability, and security.

## File systems, protocols, etc.

* [ReFS](refs/refs-overview.md) - ReFS is a resilient file system that maximizes data availability, scales efficiently to very large data sets across diverse workloads, and provides data integrity by means of resiliency to corruption (regardless of software or hardware failures).

* [SMB](https://technet.microsoft.com/library/hh831795(v=ws.11).aspx) - The Server Message Block (SMB) protocol is a network file sharing protocol that allows applications on a computer to read and write to files and to request services from server programs in a computer network. The SMB protocol can be used on top of its TCP/IP protocol or other network protocols. Using the SMB protocol, an application (or the user of an application) can access files or other resources at a remote server. This allows applications to read, create, and update files on the remote server. It can also communicate with any server program that is set up to receive an SMB client request.

* [Storage-class memory](storage-spaces/Storage-class-memory-health.md) - Storage-class memory such as NVDIMM-N devices provide performance similar to computer memory (really fast), but with the data persistence of normal storage drives. Windows treats storage-class memory similary to normal drives (just faster), but there are some differences in the way device health is managed.

* [BitLocker](https://technet.microsoft.com/library/cc766295(v=ws.10).aspx) - BitLocker Drive Encryption stores data on volumes in an encrypted format, even if the computer is tampered with or when the operating system is not running. This helps protect against offline attacks, attacks made by disabling or circumventing the installed operating system, or made by physically removing the hard drive to attack the data separately.

* [NTFS](https://technet.microsoft.com/library/dn466522(v=ws.11).aspx) - NTFS—the primary file system for recent versions of Windows and Windows Server—provides a full set of features including security descriptors, encryption, disk quotas, and rich metadata, and can be used with Cluster Shared Volumes (CSV) to provide continuously available volumes that can be accessed simultaneously from multiple nodes of a Failover Cluster.

* [NFS](https://technet.microsoft.com/library/jj592688(v=ws.11).aspx) - Network File System (NFS) provides a file sharing solution for enterprises that have heterogeneous environments that consist of both Windows and non-Windows computers.

## See also

* [What's new in storage](whats-new-in-storage.md)
* [What's new in Failover Clustering](../failover-clustering/whats-new-in-failover-clustering.md)
* [Windows IT Pro Support](https://www.microsoft.com/itpro/windows/support)
* [PowerShell cmdlets in Windows Server 2016 and Windows 10](https://technet.microsoft.com/library/mt156917.aspx)
* [Azure Storage](https://azure.microsoft.com/documentation/services/storage/)
* [Azure StorSimple](https://www.microsoft.com/en-us/cloud-platform/azure-storsimple)
