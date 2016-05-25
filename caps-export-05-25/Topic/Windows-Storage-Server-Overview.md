---
title: Windows Storage Server Overview
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 08080810-1f10-460a-b015-1703448b603e
author: JasonGerend
---
# Windows Storage Server Overview
This topic describes Windows Storage Server including supported roles and features, practical applications, the most significant new and updated functionality in [!INCLUDE[wssblue_2](../Token/wssblue_2_md.md)] and [!INCLUDE[wss_2](../Token/wss_2_md.md)], hardware and software requirements, and application compatibility.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Learn about StorSimple Hybrid Cloud Storage](http://aka.ms/fuxxdp)|  
  
## Did you mean…  
[File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)  
  
[Windows Storage Server 2008 R2](http://technet.microsoft.com/library/gg232660.aspx)  
  
## Product description  
A computer that runs Windows Storage Server is referred to as a *storage appliance*. Windows Storage Server is based on the Windows Server operating system, and it is specifically optimized for use with network\-attached storage devices. Windows Storage Server offers you a platform to build storage appliances that are customized for your hardware.  
  
In addition, iSCSI Target Server enables you to offer customers block\-level storage services, and it operates with a wide range of iSCSI initiators. iSCSI Target Server is included with all editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] including Windows Storage Server editions.  
  
## Windows Storage Server editions  
Storage appliances are available with the following editions of [!INCLUDE[wssblue_2](../Token/wssblue_2_md.md)] and [!INCLUDE[wss_2](../Token/wss_2_md.md)]:  
  
-   [!INCLUDE[wssblue_workgroup_2](../Token/wssblue_workgroup_2_md.md)]  
  
-   [!INCLUDE[wssblue_standard_2](../Token/wssblue_standard_2_md.md)]  
  
-   [!INCLUDE[wss_workgroup_2](../Token/wss_workgroup_2_md.md)]  
  
-   [!INCLUDE[wss_standard_2](../Token/wss_standard_2_md.md)]  
  
The following roles and features are supported in each edition of Windows Storage Server.  
  
|Role\/Feature|[!INCLUDE[wssblue_workgroup_2](../Token/wssblue_workgroup_2_md.md)]<br /><br />[!INCLUDE[wss_workgroup_2](../Token/wss_workgroup_2_md.md)]|[!INCLUDE[wssblue_standard_2](../Token/wssblue_standard_2_md.md)]<br /><br />[!INCLUDE[wss_standard_2](../Token/wss_standard_2_md.md)]|  
|-----------------|--------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|  
|Active Directory domain controller|No|No|  
|Domain join|Yes|Yes|  
|Active Directory Lightweight Directory Services \(AD LDS\)|Yes|Yes|  
|Active Directory Certificate Services \(AD CS\)|No|No|  
|Active Directory Federation Services \(AD FS\)|No|No|  
|Active Directory Rights Management Services \(AD RMS\)|No|No|  
|BranchCache™ Peer to Peer|Yes|Yes|  
|BranchCache™ Hosted cache|No|Yes|  
|Failover clustering|No|Yes|  
|Data Deduplication|No|Yes|  
|Virtualization \(Hyper\-V® host or guest support\)|No|Yes, 2 VMs|  
|Dynamic Host Configuration Protocol \(DHCP\)|No|Yes|  
|DNS|No|Yes|  
|Windows Internet Name Service \(WINS\)|No|Yes|  
|Application Server|No|No|  
|Network Policy|No|No|  
|Desktop Broker|No|No|  
|Windows Deployment Server \(WDS\)|No|No|  
|Fax Server|No|No|  
  
> [!NOTE]  
> When configuring Windows Storage Server for failover clustering, we recommend that you have separate network interfaces for cluster communications and public communications.  
>   
> When configuring Windows Storage Server for failover clustering with iSCSI Software Target, you can take advantage of multiple network interfaces by using Microsoft Multipath I\/O \(MPIO\) or Load Balance and Failover \(LBFO\) to provide load balancing and path redundancy.  
  
## Hardware features supported in Windows Storage Server  
The following hardware features are available in each edition of Storage Server.  
  
|Hardware feature|[!INCLUDE[wssblue_workgroup_2](../Token/wssblue_workgroup_2_md.md)]<br /><br />[!INCLUDE[wss_workgroup_2](../Token/wss_workgroup_2_md.md)]|[!INCLUDE[wssblue_standard_2](../Token/wssblue_standard_2_md.md)]<br /><br />[!INCLUDE[wss_standard_2](../Token/wss_standard_2_md.md)]|  
|--------------------|--------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|  
|Architecture|x64|x64|  
|CPU Sockets|1|2 per license|  
|Random access memory \(RAM\)|32 gigabytes|Unlimited \(2 TB on [!INCLUDE[wss_standard_2](../Token/wss_standard_2_md.md)]\)|  
|Disks \(number \/ interfaces \/ RAID type\)|6\/Non\-external SAS\/Any|Any\/Any\/Any|  
|Concurrent Server Message Block \(SMB\) connections|250|Unlimited|  
|Maximum number of users|50|Unlimited|  
  
## Practical applications  
This section discusses the following practical applications for new and enhanced capabilities of [!INCLUDE[wss_2](../Token/wss_2_md.md)]:  
  
-   [Reduce storage costs, and increase cost efficiency for file storage](../Topic/Windows-Storage-Server-Overview.md#BKMK_ReduceStorageCosts)  
  
-   [Use iSCSI storage devices to serve remote disks as though they were local](../Topic/Windows-Storage-Server-Overview.md#BKMK_UseiSCSIStorage)  
  
-   [Offload printing to your storage server](../Topic/Windows-Storage-Server-Overview.md#BKMK_OffloadPrinting)  
  
-   [Storage management for complex applications](../Topic/Windows-Storage-Server-Overview.md#BKMK_StorageManagementforComplexApps)  
  
-   [Improved scalability and performance for branch offices](../Topic/Windows-Storage-Server-Overview.md#BKMK_BranchOfficeScalabilityPerformance)  
  
-   [New options for storage through SMB 3.0](../Topic/Windows-Storage-Server-Overview.md#BKMK_NewSMB3Options)  
  
### <a name="BKMK_ReduceStorageCosts"></a>Reduce storage costs, and increase cost efficiency for file storage  
**Use Storage Spaces to provide cost\-effective, highly available and scalable storage using industry\-standard disks** In Windows Storage Server, you can use Storage Spaces to provide enterprise\-class storage using industry standard SAS or SATA disks, either internally or in JBOD enclosures. This provides a high level of performance and availability without the added cost of Fibre Channel components and RAID adapters. For details, see [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md).  
  
**Store your Hyper\-V virtual machines and Microsoft SQL Server databases on SMB file shares** In Windows Storage Server you can leverage the high\-performance and high\-availability features of SMB 3.0 for application\-based file shares for SQL Server and Hyper\-V. SMB Direct and SMB Multichannel on a file server hosting VDX drivers for a Hyper\-V cluster approach the performance of local storage on Hyper\-V guest operating systems. And you get the resiliency of failover and cluster\-aware updating to maintain service during planned updates or failures. For details, see [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md).  
  
**Use DFS Namespaces and DFS Replication to replicate folders across multiple servers and sites** Enhancements to DFS Namespaces and DFS Replication in the File and Storage Services role improve performance and efficiency and reduce administrative overhead when replicating folders across multiple servers and sites. For details, see [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md).  
  
**Use BranchCache with Server Message Block \(SMB\) to optimize performance over the WAN** In hosted branch caching if identical content exists in a file – or across many files on the content server or hosted cache server – BranchCache stores only one instance of the content, reducing storage costs. In addition, client computers at office locations download only one instance of duplicate content, saving additional wide area network \(WAN\) bandwidth. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] streamlines deployment of BranchCache and introduces significant improvements in scalability, security, performance, and manageability. For more information, see [BranchCache Overview](assetId:///a92ec0b2-eb08-4fe7-b6a6-d140e0f55fd5).  
  
**Provide highly available storage through clustering** You can provide continuous availability, with transparent server\-side failover, for applications deployed in Network File System \(NFS\) version 3 or NFS version 2. For continuous availability in heterogeneous environments, you can deploy iSCSI target servers in failover clusters. For more information, see [Failover Clustering overview](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49).  
  
**Use NFS as backend storage for your VMware environment** Enhancements to NFS improve the experience of running your VMware ESX and VMware ESXi virtual machines from file\-based storage. You can deploy NFS servers in a failover cluster for continuous availability; improvements in failover clustering make the NFS server fail over much faster than in earlier versions of Windows Server. Starting in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], both the NFS server and the NFS client run on top of a new, scalable, high\-performance RPC\-XDR runtime infrastructure. For more information, see [Network File System Overview](../Topic/Network-File-System-Overview.md).  
  
**Store more data in less space** Use Data Deduplication to store more data in less space. The goal of data duplication is to save disk space by segmenting files into small, variable\-size chunks, identifying duplicate chunks, and maintaining a single copy of each chunk. When integrated with BranchCache, Data Deduplication provides faster download times and reduced bandwidth consumption over a WAN. For more information, see [Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md).  
  
### <a name="BKMK_UseiSCSIStorage"></a>Use iSCSI storage devices to serve remote disks as though they were local  
The iSCSI Target Server role service lets you use Server Manager to quickly create and share iSCSI LUNs over the network. Virtual hard disk \(VHDx or VHD\) files appear as locally attached hard drives. Application servers running just about any workload can connect to the target using an iSCSI initiator.  
  
The following are a few of many practical uses for iSCSI Target Server.  
  
**Consolidate storage for multiple application servers with diverse storage requirements** Applications running just about any workload can connect to the target using the iSCSI initiator. Interoperability with non\-Windows applications makes this particularly useful.  
  
**Set up an iSCSI SAN for a Windows Server\-based failover cluster** You can use Windows Storage Server as inexpensive SAN storage for a failover cluster using the iSCSI protocol instead of SMB if your applications don’t support SMB fail over.  
  
**Create inexpensive development and test environments** Using iSCSI Target Server, you can create inexpensive development and test environments for complex scenarios such as clustering, live migration, SAN transfer, and Storage Manager. For example, you can set up an iSCSI SAN for a clustered SQL Server instance on a single computer. For more information, see the blog entry [Six Uses for the Microsoft iSCSI Software Target](http://blogs.technet.com/b/storageserver/archive/2009/12/11/six-uses-for-the-microsoft-iscsi-software-target.aspx) and [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md).  
  
### <a name="BKMK_OffloadPrinting"></a>Offload printing to your storage server  
[!INCLUDE[wssblue_2](../Token/wssblue_2_md.md)] and [!INCLUDE[wss_2](../Token/wss_2_md.md)] includes the Printer Server role. This is especially useful for branch offices, which can now manage printing on the same server that provides infrastructure services and file and storage services, including iSCSI SAN management.  
  
### <a name="BKMK_StorageManagementforComplexApps"></a>Storage management for complex applications  
Migrate existing data for complex applications, such as hierarchical storage management \(HSM\) and medical applications, to new storage.  
  
**Programmatically control highly sensitive files for LOB applications** Take advantage of improvements to File Classification Infrastructure \(FCI\) features of File Server Resource Manager \(FSRM\) to programmatically control highly sensitive files for your line\-of\-business \(LOB\) applications. With FCI, you can classify files by defining automated rules, and then programmatically perform tasks on those files based on their classification. For example, to access high\-business\-impact \(HBI\) data, you might require that a user be a full\-time employee, obtain access from a managed device, and log on with a smart card.  
  
The [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system introduced the [Microsoft Data Classification Toolkit](http://www.microsoft.com/download/details.aspx?id=27123), which reduced administrative overhead by defining a basic set of classification properties related to common compliance requirements. However, the classifications were local to each file server, which meant the administrator had to ensure that the same classification properties were used on all file servers. Starting in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the classification properties are managed centrally in Active Directory Domain Services \(AD DS\), making the classification properties standard on all file servers.  
  
For more information, see the blog entry [Protect everything: using FCI to protect files of any type with Windows Server 2012](http://blogs.technet.com/b/rms/archive/2012/11/09/protect-everything-using-fci-to-protect-files-of-any-type-with-windows-server-2012.aspx).  
  
### <a name="BKMK_BranchOfficeScalabilityPerformance"></a>Improved scalability and performance for branch offices  
Windows Storage Server can provide comprehensive infrastructure services for the branch office. Use DNS and WINS for server address identification. Use your storage server as your primary DHCP server or as a DHCP failover target if the primary DHCP server goes offline.  
  
### <a name="BKMK_NewSMB3Options"></a>New options for storage through SMB 3.0  
The introduction of the Server Message Block \(SMB\) 3.0 protocol opens new storage options and capabilities, and simplifies storage management in a heterogeneous environment. These include the following capabilities. For more information, see [What's New for SMB in Windows Server 2012 R2](assetId:///46c0ac80-a54a-4324-948a-2dee66bcec75).  
  
**Highly available shared data storage for SQL Server databases and Hyper\-V workloads** Scale\-Out File Server, new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], lets you store server application data, such as Hyper\-V virtual machine files, on file shares, and obtain a similar level of reliability, availability, manageability, and high performance that you would expect from a storage area network. All file shares are online on all nodes simultaneously. This is also known as an active\-active cluster. For more information, see [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md).  
  
**Direct access to your Fibre Channel infrastructure** Hyper\-V virtual Fibre Channel provides direct access to Fibre Channel storage arrays by using Fibre Channel ports in the Hyper\-V guest operating system. This enables you to virtualize workloads that require direct access to Fibre Channel storage and to cluster guest operating systems over Fibre Channel.  
  
**No application downtime for planned maintenance or unexpected failures** With SMB Transparent Failover, file shares move transparently between file server cluster nodes with no service interruption on the SMB client.  
  
**Built\-in data encryption for secure wire transfers** SMB 3.0 performs transport\-level encryption, and setting it up is as simple as selecting a single check box. You can configure a single share or an entire file server for SMB 3.0 encryption. Clients running earlier versions of SMB will not even see the shares.  
  
**SMB file share backup using the same backup solution used for local storage** Volume Shadow Copy Service \(VSS\) now supports backup of remote file storage. Any third\-party backup software that uses VSS can back up files, virtual machines, and databases stored on SMB file shares.  
  
## New and changed features in Windows Storage Server 2012 R2  
[!INCLUDE[wssblue_2](../Token/wssblue_2_md.md)] makes significant improvements throughout File and Storage Services, including to protocols, data access and replication, continuous availability, scalability, deployment and management.  
  
> [!NOTE]  
> This table summarizes some of the most significant new and updated features of [!INCLUDE[wssblue_2](../Token/wssblue_2_md.md)]. For a complete list of new features available through File and Storage Services in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md).  
  
|Feature\/functionality|New or updated|Summary|  
|--------------------------|------------------|-----------|  
|Storage protocols|Updated|-   **iSCSI Target Server** –Improvements to iSCSI Target Server include support for VHDx \(VHD 2.0\) virtual hard disks for capacities of up to 64 TB. iSCSI Target Server also now supports SMI\-S, enabling end\-to\-end provisioning using System Center Virtual Machine Manager. For more information, see [What's New in iSCSI Target Server in Windows Server 2012 R2](assetId:///3858a8b3-4eb7-448b-a535-c1264449f378)<br />-   **SMB** – Improvements to the Server Message Block \(SMB\) protocol include better SMB Direct performance, automatic rebalancing for Cluster Shared Volumes \(CSV\) on scale\-out file servers, shared VHDx files, Hyper\-V Live Migration over SMB, SMB bandwidth management, detailed event messages, and more. For more information, see [What's New in SMB in Windows Server 2012 R2](assetId:///46c0ac80-a54a-4324-948a-2dee66bcec75).|  
|Data access and replication|New|-   **Work Folders** \- a new feature that facilitates the BYOD \(bring\-your\-own\-device\) scenario by enabling users to access work files from their personal computers and devices. Organizations retain centralized control over their data and can specify device policies such as encryption and lock screen password. For more information, see [Work Folders Overview](../Topic/Work-Folders-Overview.md).|  
|Updated|-   **DFS Replication** – Enhancements include increases in scalability, the ability to do database cloning and corruption recovery, a Windows PowerShell module, a new WMI provider, faster replication on high bandwidth connections, and recovery tools for conflicts. For more information, see [What's New in DFS Replication in Windows Server 2012 R2](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601).|  
|Continuous availability|Updated|-   **Failover Clustering** \- Enhancements include improvements to virtual machine availability, Cluster Shared Volumes \(CSV\), dynamic cluster quorums, cluster node health detection, deployment, updating and monitoring. For more information, see [What's New in Failover Clustering in Windows Server 2012 &#91;redirected&#93;](assetId:///187d6191-4f92-4f98-9cae-c5e6d5b74e76).<br />-   **Hyper\-V** \- Enhancements include shared virtual hard disks, resizing of virtual hard disks while a VM is running, storage quality of service \(QoS\), improved performance for live migrations, cross\-version live migrations, and several more new or improved capabilities. For more information, see [What’s New in Hyper\-V in Windows Server 2012 R2](assetId:///439023ea-f0d3-4895-921d-4bf0799a47dd).|  
|Scalability improvements|Updated|-   **Storage Spaces** – Enhancements include storage tiering, SSD write\-back caches for storage spaces, parity storage spaces on failover clusters, dual parity storage spaces, and faster rebuilding of storage spaces after disk failures. For more information, see [What's New in Storage Spaces in Windows Server 2012 R2](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e).<br />-   **Data Deduplication** \- Enhancements include support for Cluster Shared Volumes and deduplication of live Virtual Desktop Infrastructure \(VDI\) VMs that reside on a file server connected via SMB. For more information, see [Extending Data Deduplication to new workloads in Windows Server 2012 R2](http://blogs.technet.com/b/filecab/archive/2013/07/31/extending-data-deduplication-to-new-workloads-in-windows-server-2012-r2.aspx).|  
|Deployment and management||-   **OEM Appliance OOBE \(out\-of\-the\-box experience\)** \- Enhancements include added support for four\-node cluster deployments and a wizard for creating a domain controller within a Hyper\-V VM that can be used to deploy a turnkey cluster\-in\-a\-box.<br />-   **Storage Management API** – Enhancements include an improved Storage Management API enables 10x faster enumerations, added cluster\-awareness, and remote management for Storage Spaces new features.|  
  
## New and changed features in Windows Storage Server 2012  
Improved processes and added capabilities throughout Storage and File Services in [!INCLUDE[wss_2](../Token/wss_2_md.md)] make significant improvements to security, performance, management, and scalability.  
  
> [!NOTE]  
> This table summarizes some of the most significant new and updated features of [!INCLUDE[wss_2](../Token/wss_2_md.md)]. For a complete list of new features available through File and Storage Services in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md) and the [Storage: Windows Server 2012](http://download.microsoft.com/download/A/B/E/ABE02B78-BEC7-42B0-8504-C880A1144EE1/WS%202012%20White%20Paper_Storage.pdf) white paper.  
  
|Feature\/functionality|New or updated|Summary|  
|--------------------------|------------------|-----------|  
|Security improvements|Updated|[!INCLUDE[wss_2](../Token/wss_2_md.md)] provides multilayered security for your storage infrastructure:<br /><br />-   Transport\-level security through easily enabled SMB 3.0 data encryption<br />-   Application\-level security through Active Directory Rights Management Services \(AD RMS\) file encryption<br />-   Claims\-based identity and access through Dynamic Access Control<br />-   Data protection through BitLocker Drive Encryption|  
|Performance improvements|Updated|Changes throughout the File and Storage Services features of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] enhance storage and network performance:<br /><br />-   **SMB\-Direct** – SMB Direct supports high\-speed data transfers by using Kernel Mode Direct Memory Access \(KRDMA\) to offload network I\/O processing to specialized network adapters. This results in high throughput with low latency, increasing scalability, reducing the path for network requests, and reducing power usage.<br />-   **SMB Multichannel** – New in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], SMB Multichannel Improves server\-to\-server performance by allowing multiple TCP connections for each SMB session, thus enabling the use of multiple network adapters and more RSS queues. SMB Multichannel enables bandwidth aggregation, load balancing, and transparent failover and recovery from a network failure if another connection is available.<br />-   **NIC teaming** – With NIC teaming, you can mix and match network adapters in both native and virtualized environments. For more information, see [NIC Teaming Overview](assetId:///912908f6-4c97-43d3-a442-7e11b62dda8a).<br />-   **Reduced memory footprint** – Less advance allocation of data structures and reduced non\-paged spool usage reduce the memory footprint in [!INCLUDE[wss_2](../Token/wss_2_md.md)].<br />-   **Improved disk efficiency** – A reduced number of I\/Os and seeks improves disk efficiency.<br />-   **SMB Directory Leasing** – Particularly helpful over WAN links, SMB Directory Leasing enables client computers to cache more information \(with longer duration for directory information\) and thus reduce round trips. For more information, see [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md).<br />-   **Chkdsk offline scanning** – The Chkdsk tool can now perform disk scans offline, saving hours of processing time and reducing risks associated with deploying high\-capacity volumes. When used with cluster shared volumes \(CSVs\), Chkdsk requires no offline time. For more information, see [NTFS Health and Chkdsk](../Topic/NTFS-Health-and-Chkdsk.md).<br />-   **Offloaded Data Transfer \(ODX\)** – ODX functionality maximizes an enterprise’s investment in intelligent storage arrays by enabling the arrays to directly transfer data within or between compatible storage devices, bypassing the host computer. By moving large files and virtual machines directly between intelligent storage arrays, you reduce host CPU usage and network resource consumption. A feature of the storage stack in Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], ODX supports rapid provisioning and migration of virtual machines. For more information, see [Windows Offloaded Data Transfers Overview](../Topic/Windows-Offloaded-Data-Transfers-Overview.md).|  
|Simplified management|Updated|Management improvements enable you to manage more of a heterogeneous storage infrastructure centrally on the File and Storage Service pane of Server Manager or, alternatively, perform scripted and remote management using Windows PowerShell 4.0.<br /><br />-   **Seamless management of network storage view iSCSI, SMB, and NFS** \- Support for the industry\-standard Storage Management Initiative \(SMI\-S\), coupled with the new Storage Management API \(SMAPI\), enables vendor\-independent and system\-independent management of SAN and direct attached storage using the new File and Storage Services pane of Server Manager. The new ISCSI Software Target role lets you use Server Manager to quickly create and share iSCSI LUNs over the network.<br />-   **Expanded Windows PowerShell support for storage management** \- New cmdlets have been added to Windows PowerShell 4.0 in nearly all File and Storage Services feature areas. For an overview, see [Windows PowerShell Reference Sheet for File and Storage Services in Windows Server](http://blogs.technet.com/b/roiyz/archive/2012/03/06/windows-powershell-reference-sheet-for-file-and-storage-services-in-windows-server-8-beta.aspx) \(open FileServicesGettingStarted.pdf at the bottom of the page\) and [What's new in Windows PowerShell](http://technet.microsoft.com/library/hh857339.aspx).|  
|Scalability improvements|Updated|In Microsoft internal testing, file server scalability in [!INCLUDE[wss_2](../Token/wss_2_md.md)] increased 25 percent over [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] client computers in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]; throughput improved up to 40 percent on a 4\-socket system.|  
  
## Hardware and software requirements  
An appliance based on Windows Storage Server must meet basic system and hardware requirements of Windows Server.  
  
For [!INCLUDE[wssblue_2](../Token/wssblue_2_md.md)], see [System Requirements and Installation Information for Windows Server 2012 R2](../Topic/System-Requirements-and-Installation-Information-for-Windows-Server-2012-R2.md).  
  
For [!INCLUDE[wss_2](../Token/wss_2_md.md)], see [Installing Windows Server 2012](../Topic/Installing-Windows-Server-2012.md) and [Windows Storage Server Getting Started](../Topic/Windows-Storage-Server-Getting-Started.md).  
  
For special requirements for individual storage features, see the feature overviews under [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md).  
  
## Application compatibility in Windows Storage Server  
Use the following guidelines to determine your applications’ compatibility with Windows Storage Server. For more information, see the [Windows 8 and Windows Server 2012 Compatibility Cookbook](http://www.microsoft.com/download/details.aspx?id=27416).  
  
-   Windows Storage Server and Windows Server are built on the same code base. Applications certified for Windows Server are expected to have the same application compatibility profile on Windows Storage Server.  
  
-   Windows Storage Server and Windows Server have the same application frameworks, services, libraries, and tools to support running the full breadth of Windows\-compatible applications.  
  
-   Applications that rely on roles that are removed from [!INCLUDE[wss_2](../Token/wss_2_md.md)] \- such as Fax Server, Active Directory Domain Services \(AD DS\), and Remote Desktop Services \(RDS\) \- will not be able to leverage those roles.  
  
    > [!NOTE]  
    > All versions of Windows Storage Server can be added to an Active Directory domain, but the server cannot function as a domain controller.  
  
-   Ultimately, Independent Software Vendors \(ISVs\) decide which versions and editions of the Windows operating system their products support. Customers should review ISV compatibility and support information before purchasing software for use on a Windows Storage Server appliance.  
  
-   Windows Storage Server customers should review the End User License Agreement \(EULA\) to see the types of applications that are permitted for installation. After installation, you can find the license agreement in %SystemDrive%\\Windows\\System32\\license.rtf. Or, on the **Start** page, open **Run**, and enter **winver**.  
  
-   You can run antivirus software on Windows Storage Server, just like on Windows Server.  
  
## See also  
For additional related information, see the following resources.  
  
|**Content type**|References|  
|--------------------|--------------|  
|**Product evaluation**|[Windows Storage Server 2012 Is Available to Microsoft’s Hardware Partners](http://blogs.technet.com/b/storageserver/archive/2012/09/16/3520264.aspx) &#124; [Storage: Windows Server 2012](http://download.microsoft.com/download/A/B/E/ABE02B78-BEC7-42B0-8504-C880A1144EE1/WS%202012%20White%20Paper_Storage.pdf) \(white paper\)<br /><br />[Windows Server 2012](http://technet.microsoft.com/windowsserver/hh534429) &#124; [Windows Server 2012 Products and Editions Comparison](http://www.microsoft.com/download/confirmation.aspx?id=38809) &#124; [Windows Server Storage Solutions](http://technet.microsoft.com/library/hh874925(v=ws.10).aspx) \(all versions\) &#124; [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)|  
|**Deployment**|[Windows Storage Server Getting Started](../Topic/Windows-Storage-Server-Getting-Started.md) &#124; [Windows Storage Server Planning and Deployment](../Topic/Windows-Storage-Server-Planning-and-Deployment.md) &#124; [Windows Storage Server Testing and Troubleshooting](../Topic/Windows-Storage-Server-Testing-and-Troubleshooting.md) &#124; [Windows Server 2012 OEM Appliance OOBE Four\-Node Cluster Setup Guide](http://www.microsoft.com/download/details.aspx?id=38766)<br /><br />Product downloads: [Windows Storage Server 2012 Evaluation Editions](http://www.microsoft.com/download/details.aspx?id=34592) &#124; [Windows Server 2012 4\-Node Cluster Deployment Support \(Hotfix 2769588\)](http://support.microsoft.com/kb/2769588)|  
|**Tools and settings**|[Windows PowerShell Reference Sheet for File and Storage Services in Windows Server](http://blogs.technet.com/b/filecab/archive/2013/07/30/storage-and-file-services-powershell-cmdlets-quick-reference-card-for-windows-server-2012-r2-preview-edition.aspx) &#124; [What's new in Windows PowerShell](http://technet.microsoft.com/library/hh857339.aspx) &#124; [The basics of SMB PowerShell, a feature of Windows Server 2012 and SMB 3.0](http://blogs.technet.com/b/josebda/archive/2012/06/27/the-basics-of-smb-powershell-a-feature-of-windows-server-2012-and-smb-3-0.aspx)<br /><br />[Windows Storage Management API](http://msdn.microsoft.com/library/windows/desktop/hh830613(v=vs.85).aspx)|  
|**Community resources**|[Updated Links on Windows Server 2012 File Server and SMB 3.0](http://blogs.technet.com/b/josebda/archive/2012/08/02/updated-links-on-windows-server-2012-file-server-and-smb-3-0.aspx) &#124; [Home Directory Consolidation on Windows Storage Server 2012](http://www.microsoft.com/download/details.aspx?id=39081) &#124; [Protect everything: using FCI to protect files of any type with Windows Server 2012](http://blogs.technet.com/b/rms/archive/2012/11/09/protect-everything-using-fci-to-protect-files-of-any-type-with-windows-server-2012.aspx) &#124; [Windows Server 2012 File Classification Infrastructure](http://windowsitpro.com/windows-server-2012/windows-server-2012-fci)<br /><br />Blogs and forums: [The Storage Team at Microsoft’s File Cabinet Blog](http://blogs.technet.com/b/filecab/) &#124; [Windows Storage Server TechNet blog](http://blogs.technet.com/b/storageserver/) &#124; [Windows Storage Server 2012 Forum](http://social.technet.microsoft.com/Forums/windowsserver/home?category=windowsserver&brandIgnore=True&sort=relevancedesc&searchTerm=Windows+Storage+Server+2012)|  
|**Related technologies**|[File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md) &#124; [Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md) &#124; [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md) &#124; [File Server Resource Manager Overview_1](../Topic/File-Server-Resource-Manager-Overview_1.md) &#124; [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md) &#124; [iSCSI Target Boot Overview](../Topic/iSCSI-Target-Boot-Overview.md) &#124; [Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md) &#124; [Resilient File System Overview](../Topic/Resilient-File-System-Overview.md) &#124; [Windows Offloaded Data Transfers Overview](../Topic/Windows-Offloaded-Data-Transfers-Overview.md) &#124; [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md) &#124; [Supporting Information Workers with Reliable File Services and Storage](../Topic/Supporting-Information-Workers-with-Reliable-File-Services-and-Storage.md) &#124; [Storage Management Overview](assetId:///d8442e86-3b63-44e0-b36c-7981643999f8) &#124; [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md) &#124; [Thin Provisioning and Trim Storage Overview](assetId:///10062089-3259-4d7e-8605-f7abc57fd06f) &#124; [NTFS Health and Chkdsk](../Topic/NTFS-Health-and-Chkdsk.md) &#124; [Server for NFS Data Store](../Topic/Server-for-NFS-Data-Store.md)|  
  
