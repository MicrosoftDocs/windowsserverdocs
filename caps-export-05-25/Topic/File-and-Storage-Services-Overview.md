---
title: File and Storage Services Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4cb00829-8d05-4499-8adc-7506e159f857
author: JasonGerend
---
# File and Storage Services Overview
This topic discusses the File and Storage Services server role in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including what’s new, a list of role services, and where to find evaluation and deployment information.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Learn about StorSimple hybrid cloud storage](http://aka.ms/fuxxdp)<br />\- [Use Azure StorSimple for hybrid cloud storage](http://aka.ms/x9a7wq)<br />\- [Migrate to Azure Premium Storage](http://aka.ms/mk36m5)|  
  
**Did you mean…**  
  
-   [File Services in Windows Server 2008 R2](http://technet.microsoft.com/library/dd463985)  
  
-   [File Services Windows Server Protocols](http://msdn.microsoft.com/library/cc239875.aspx)  
  
-   [Windows Storage Server 2008 R2](http://technet.microsoft.com/library/gg232660.aspx)  
  
-   [Step 4: Configure iSCSI storage provider identity credentials](../Topic/iSCSI-Target-Block-Storage,-How-To.md#BKMK_Step4)  
  
## <a name="BKMK_OVER"></a>Role description  
File and Storage Services includes technologies that help you set up and manage one or more file servers, which are servers that provide central locations on your network where you can store files and share them with users. If your users need access to the same files and applications, or if centralized backup and file management are important to your organization, you should set up one or more servers as a file server by installing the File and Storage Services role and the appropriate role services.  
  
The File and Storage Services role and the Storage Services role service are installed by default, but without any additional role services. This basic functionality enables you to use Server Manager or Windows PowerShell to manage the storage functionality of your servers. However, to set up or manage a file server, you should use the Add Roles and Features Wizard in Server Manager or the `Install-WindowsFeature` Windows PowerShell cmdlet to install additional File and Storage Services role services, such as the role services discussed in this topic.  
  
## <a name="BKMK_APP"></a>Practical applications  
Administrators can use the File and Storage Services role to set up and manage multiple file servers and their storage capabilities by using Server Manager or Windows PowerShell. Some of the specific applications include the following:  
  
-   **Work Folders** Use to enable users to store and access work files on personal PCs and devices, in addition to corporate PCs. Users gain a convenient location to store work files and access them from anywhere. Organizations maintain control over corporate data by storing the files on centrally managed file servers and optionally specifying user device policies \(such as encryption and lock screen passwords\). Work Folders is a new role service in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   **Data Deduplication** Use to reduce the disk space requirements of your files, saving money on storage.  
  
-   **iSCSI Target Server** Use to create centralized, software\-based, and hardware\-independent iSCSI disk subsystems in storage area networks \(SANs\).  
  
-   **Storage Spaces** Use to deploy high availability storage that is resilient and scalable by using cost\-effective industry\-standard disks.  
  
-   **Server Manager** Use to remotely manage multiple file servers from a single window.  
  
-   **Windows PowerShell** Use to automate the management of the majority of administration tasks for file servers.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
For information about new File and Storage Services functionality in [!INCLUDE[winthreshold_server_2](../Token/winthreshold_server_2_md.md)], see [What's New in File and Storage Services in Windows Server Technical Preview](../Topic/What-s-New-in-File-and-Storage-Services-in-Windows-Server-2016-Technical-Preview.md).  
  
The following table describes some of the major changes in File and Storage Services functionality that is available in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
|Feature\/functionality|New or updated?|Description|  
|--------------------------|-------------------|---------------|  
|Work Folders|New|Provides a consistent way for users to access their work files from their personal computers and devices. See [Work Folders Overview](../Topic/Work-Folders-Overview.md) for more information.|  
|Server Message Block|Updated|Enhancements include automatic rebalancing of Scale\-Out File Server clients, improved performance of SMB Direct, and improved SMB event messages. See [What's New for SMB in Windows Server 2012 R2](assetId:///46c0ac80-a54a-4324-948a-2dee66bcec75) for more information.|  
|Storage Spaces|Updated|Enhancements include SSD and HDD storage tiers, an SSD\-based write\-back cache, parity space support for failover clusters, dual parity support, and greatly decreased storage space rebuild times. See [What's New in Storage Spaces in Windows Server 2012 R2](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e) for more information.|  
|DFS Replication|Updated|Enhancements include database cloning for large performance gains during initial sync, a Windows PowerShell module for DFS Replication, a new DFS Replication WMI provider, faster replication on high bandwidth connections, conflict and preexisting data recovery, and support for rebuilding corrupt databases without unexpected data loss. See [What's New in DFS Replication in Windows Server 2012 R2](assetId:///7ced384c-ed6d-42dc-a813-cf3a28e77601) for more information.|  
|iSCSI Target Server|Updated|Updates include virtual disk enhancements, manageability enhancements in a hosted or private cloud, and improved optimization to allow disk\-level caching. See [What's New for iSCSI Target in Windows Server 2012 R2](assetId:///3858a8b3-4eb7-448b-a535-c1264449f378) for more information.|  
  
The following table describes some of the major changes in File and Storage Services functionality that are available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
|Feature\/functionality|New or updated?|Description|  
|--------------------------|-------------------|---------------|  
|[Data Deduplication](../Topic/File-and-Storage-Services-Overview.md#BKMK_Dedupe)|New|Saves disk space by storing a single copy of identical data on the volume.|  
|[iSCSI Target Server](../Topic/File-and-Storage-Services-Overview.md#BKMK_iSCSITarget)|New|Provides block storage to other servers and applications on the network by using the Internet SCSI \(iSCSI\) standard.|  
|[Storage Spaces and storage pools](../Topic/File-and-Storage-Services-Overview.md#BKMK_Spaces)|New|Enables you to virtualize storage by grouping industry\-standard disks into storage pools and then creating storage spaces from the available capacity in the storage pools.|  
|[Unified remote management of File and Storage Services in Server Manager](../Topic/File-and-Storage-Services-Overview.md#BKMK_Unified_Management)|New|Enables you to remotely manage multiple file servers, including their role services and storage, from a single window.|  
|[Windows PowerShell cmdlets for File and Storage Services](../Topic/File-and-Storage-Services-Overview.md#BKMK_PowerShell)|New|Provides Windows PowerShell cmdlets to perform the majority of administration tasks for file and storage servers.|  
  
For more information about what else is new in File and Storage Services and related technologies, see the following topics.  
  
-   [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md)  
  
-   [Encrypted Hard Drive](../Topic/Encrypted-Hard-Drive.md)  
  
-   [NTFS Health and Chkdsk](../Topic/NTFS-Health-and-Chkdsk.md)  
  
-   [What's New in File Server Resource Manager in Windows Server 2012 \[redirected\]](assetId:///d53c603e-6217-4b98-8508-e8e492d16083)  
  
-   [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md)  
  
-   [Thin Provisioning and Trim Storage Overview](assetId:///10062089-3259-4d7e-8605-f7abc57fd06f)  
  
-   [Windows Offloaded Data Transfers Overview](../Topic/Windows-Offloaded-Data-Transfers-Overview.md)  
  
### <a name="BKMK_Dedupe"></a>Data Deduplication  
By using the Data Deduplication role service to reduce the number of duplicate blocks of data in storage, you can store much more data in a given amount of storage capacity than was possible in previous releases that used Single Instance Storage \(SIS\) or NTFS file system compression. General purpose file servers can typically reduce storage capacity utilization by a 2:1 ratio \(for example, files that previously used 1 TB would use 500 GB after data deduplication\). Servers that host virtualization data \(such as VHD files\) often reduce storage capacity utilization by a 20:1 ratio, which reduces 1 TB of data to 50 GB.  
  
Data deduplication is highly scalable, resource efficient, and nonintrusive. It can run on dozens of large volumes of primary data simultaneously without affecting other workloads on the server. Low impact on the server workloads is maintained by throttling the CPU and memory resources that are consumed. By using data deduplication jobs, you can schedule when data deduplication should run, specify the resources to duplicate, and tune file selection. Data integrity and recoverability are maximized through checksum and other algorithms by using selective redundancy.  
  
When combined with BranchCache, the same optimization techniques are applied to data that is transferred over the WAN to a branch office. This results in faster file download times and reduced bandwidth consumption.  
  
**What value does this change add?**  
  
Data deduplication uses variable\-size chunking and compression, which together deliver storage optimization ratios of 2:1 for general file servers and up to 20:1 for virtualization data.  
  
**What works differently?**  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes Data Deduplication as a role service that you can install and manage by using Server Manager or Windows PowerShell cmdlets. The default settings can quickly reduce the amount of storage capacity that is used by your data. You can fine\-tune the settings to see more gains or use Windows PowerShell cmdlets to create scripts that will trigger storage optimization when and where you want it.  
  
For more detailed information, see [Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md).  
  
### <a name="BKMK_iSCSITarget"></a>iSCSI Target Server  
iSCSI Target Server provides block storage to other servers and applications on the network by using the Internet SCSI \(iSCSI\) standard. When combined with other continuously available technologies in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], iSCSI Target Server provides continuously available storage that was previously available only on expensive, high\-end storage area network \(SAN\) devices.  
  
**What value does this change add?**  
  
-   **Network or diskless boot** By using boot\-capable network adapters or a software loader, you can deploy hundreds of diskless servers. With the iSCSI Target Server, the deployment is fast \(in Microsoft testing, 256 computers deployed in 34 minutes\). By using differencing virtual hard disks, you can save up to 90% of the storage space for the operating system images. This is ideal for large deployments of identical operating system images, such as a server farm that is running Hyper\-V or high\-performance computing \(HPC\) clusters.  
  
-   **Server application storage** Some applications \(for example, Hyper\-V and Exchange Server\) require block storage, which is raw storage that appears to applications as an unformatted disk, which is ready for direct management by the application. iSCSI Target Server can provide these applications with continuously available block storage. Because the storage is remotely accessible, iSCSI Target Server can also consolidate block storage for central or branch office locations.  
  
-   **Heterogeneous storage** iSCSI Target Server supports iSCSI initiators on operating systems other than Windows, making it easy to share storage in a heterogeneous environment.  
  
-   **Dev, test, and demo lab environments** With iSCSI Target Server, any computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can be a network\-accessible block storage device. This is useful for testing applications prior to deployment on a SAN storage device.  
  
**What works differently?**  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], iSCSI Target Server management functionality moves from a separate download to part of the Windows Server operating system. You can use Server Manager or Windows PowerShell cmdlets to set up, configure, and manage iSCSI Target Server. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] also includes changes to the clustering resource model that improve scalability so that more initiators can connect to the target servers.  
  
For more detailed information, see [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md).  
  
### <a name="BKMK_Spaces"></a>Storage Spaces and storage pools  
Storage Spaces is a storage subsystem that is included in Windows that enables you to group industry\-standard disks \(such as Serial ATA or Serial Attached SCSI disks\) into one or more storage pools, and then create virtual disks known as “storage spaces” from the available capacity in the storage pools. Storage Spaces provides resilient storage virtualization capabilities for business\-critical virtual or physical deployments, including deployments on scalable multinode servers.  
  
After you group physical disks into storage pools, you can create virtual disks from the available capacity without individually managing each physical disk. This aggregation of disks enables you to make more efficient use of disk capacity, easily add storage without impacting users, and delegate administration of storage. In Windows Server, you can use storage pools with Storage Spaces or with non\-Microsoft storage subsystems, including subsystems that use the SMI\-S standard.  
  
**What value does this change add?**  
  
Storage Spaces and storage pools reduce administration costs by decreasing the time administrators spend provisioning storage. They also simplify administration tasks, enabling administrators who are not storage professionals to set up and manage resilient and high availability storage. Storage Spaces also saves hardware costs by using industry\-standard disks for resilient storage with high availability.  
  
**What works differently?**  
  
With storage pools, instead of managing each disk individually, you add physical disks to one or more pools and then create virtual disks from the available capacity. You then create volumes on the virtual disks, as if they were physical disks. When you run low on the available capacity in the pool, simply create more virtual disks.  
  
Virtual disks also provide thinly provisioning, which means that pool capacity is used only according to the size of the files that you copy to the virtual disks, not the size of the virtual disk you create. For example, a 10 TB virtual disk might consume 100 MB of pool capacity if you haven’t copied many files to the disk yet.  
  
For more information, see [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md) and [Storage Management Overview](assetId:///d8442e86-3b63-44e0-b36c-7981643999f8).  
  
### <a name="BKMK_Unified_Management"></a>Unified remote management of File and Storage Services in Server Manager  
The File and Storage Services role in Server Manager enables you to remotely manage multiple file servers from a single window in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including role services and storage. The File and Storage Services page in Server Manager provides the following sections to manage all servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] that have been added to Server Manager:  
  
-   **Servers** Manage basic server functionality on servers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008 R2, or Windows Server 2008. You can use the **Servers** page to perform such tasks as restarting servers and launching administrative tools.  
  
-   **Storage Pools** Manage storage pools, including the physical disks that make up the pools and virtual disks that are created from available capacity in the pools.  
  
-   **Volumes** Manage volumes, including scanning for file system errors, extending volumes, and configuring Data Deduplication.  
  
-   **Shares** Manage SMB and NFS shares, including creating new shares and setting up quotas.  
  
-   **iSCSI Virtual Disks** Manage iSCSI virtual disks, including creating new iSCSI virtual disks and targets.  
  
**What value does this change add?**  
  
Managing multiple file servers and file server technologies from a single Server Manager window enables administrators to work more efficiently and get a better overall view of the servers they manage, so managing multiple servers becomes as easy as managing one.  
  
**What works differently?**  
  
Prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], managing multiple file servers meant using Remote Desktop to connect to each server, or opening multiple instances of the administration console \(one per server\). In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can use Server Manager to perform many of the functions that are provided by the following standalone management consoles:  
  
-   Disk Management  
  
-   Share and Storage Management  
  
-   File Server Resource Manager \(quotas and assigning folder management properties to file shares\)  
  
-   Microsoft iSCSI Software Target \(not available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\)  
  
-   Storage Manager for SANs \(not available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\)  
  
In addition to the integrated functionality, you can use the **Tools** menu in Server Manager to launch administrative tools on any of the managed servers, including DFS Management, File Server Resource Manager, and Services for Network File System \(NFS\).  
  
> [!NOTE]  
> Although the File and Storage Services role in Server Manager does not support fully managing servers running Windows Server 2008 R2 or Windows Server 2008, you can add these servers to Server Manager and use the **Servers**, and **All Servers** pages to view details about the servers and launch administrative tools. For more information, see [Managing Down\-Level Windows\-based Servers from Server Manager in Windows Server 2012](http://blogs.technet.com/b/servermanager/archive/2012/09/10/managing-downlevel-windows-based-servers-from-server-manager-in-windows-server-2012.aspx).  
  
### <a name="BKMK_PowerShell"></a>Windows PowerShell cmdlets for File and Storage Services  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes Windows PowerShell cmdlets to perform the majority of administration tasks for file and storage servers.  
  
**What value does this change add?**  
  
Extensive Windows PowerShell cmdlets allow administrators to automate common administration tasks by using Windows PowerShell scripts.  
  
**What works differently?**  
  
Instead of using a variety of snap\-ins or disparate command\-line utilities, administrators can manage their servers by using Windows PowerShell cmdlets and scripts. [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] include Windows PowerShell cmdlets to manage the following file and storage technologies.  
  
-   [BranchCache](http://technet.microsoft.com/library/hh848392.aspx)  
  
-   [Data Deduplication](http://technet.microsoft.com/library/hh848450.aspx)  
  
-   [DFS Namespaces](http://technet.microsoft.com/library/jj884270.aspx)  
  
-   [DFS Replication](http://technet.microsoft.com/library/dn296591.aspx) \(New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\)  
  
-   [File Server Resource Manager](http://technet.microsoft.com/library/jj900651.aspx)  
  
-   [iSCSI](http://technet.microsoft.com/library/hh826099.aspx)  
  
-   [iSCSI Target](http://technet.microsoft.com/library/hh826097.aspx)  
  
-   [MultiPath I\/O \(MPIO\)](http://technet.microsoft.com/library/hh826113.aspx)  
  
-   [Primary Computer](http://archive.msdn.microsoft.com/PrimaryComputer)  
  
-   [Server for NFS](http://technet.microsoft.com/library/jj603081.aspx)  
  
-   [SMB Shares](http://technet.microsoft.com/library/jj635726.aspx)  
  
-   [SMB Witness](http://technet.microsoft.com/library/jj635726.aspx)  
  
-   [SMI\-S](http://technet.microsoft.com/library/jj884239.aspx)  
  
-   [Storage](http://technet.microsoft.com/library/hh848705.aspx)  
  
-   [Storage Spaces](http://technet.microsoft.com/library/jj851254.aspx)  
  
-   [Sync Share \(Work Folders\)](http://technet.microsoft.com/library/dn296644.aspx) \(New in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\)  
  
There are numerous related Windows PowerShell cmdlets that are also useful for file and storage workloads. For example, you can use the Best Practices Analyzer \(BPA\) cmdlets to compare servers to a known set of best practices for the File and Storage Services role.  
  
For a reference sheet that contains some of the File and Storage Services cmdlets that are most commonly used, download the [Windows PowerShell Reference Sheet for File and Storage Services](http://blogs.technet.com/cfs-file.ashx/__key/communityserver-components-postattachments/00-03-48-49-38/FileServicesGettingStartedCmdlets.pdf).  
  
## <a name="BKMK_DEP"></a>Removed or deprecated functionality  
The following features are included in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], but they are being phased out, and they likely will be removed entirely from future versions of Windows Server.  
  
|Deprecated feature|Replacement|  
|----------------------|---------------|  
|DFS Namespaces command\-line tool: Dfscmd|Windows PowerShell cmdlets for DFS Namespaces|  
|File Replication Service \(FRS\)|DFS Replication|  
|File Server Resource Manager command\-line tools: Dirquota, Filescrn, and Storrept|Windows PowerShell cmdlets for File Server Resource Manager|  
|Share and Storage Management snap\-in|File and Storage Services role in Server Manager|  
|Shared Folders snap\-in|File and Storage Services role in Server Manager|  
|Virtual Disk Service \(VDS\) provider|Storage Management APIs and storage provider or the SMI\-S standard and a compliant storage provider|  
  
The following features are not present in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
|Deprecated feature|Replacement|  
|----------------------|---------------|  
|Storage Manager for SANs snap\-in|File and Storage Services role in Server Manager and Storage Management Windows PowerShell cmdlets|  
|SCSIport host\-bus adapter drivers|Storport drivers or a different host\-bus adapter|  
  
For a list of deprecated features in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [Features Removed or Deprecated in Windows Server 2012](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012.md).  
  
For more information about File Replication Service support in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and Windows Server 2008 R2, see [File Replication Service \(FRS\) Is Deprecated in Windows Server 2008 R2](http://msdn.microsoft.com/library/ff384840.aspx).  
  
## Requirements for running File and Storage Services  
There are no special hardware or software requirements for running File and Storage Services. However, File Server Resource Manager and DFS Replication support only volumes that are formatted with the NTFS file system—the Resilient File System \(ReFS\) and the FAT file system are not supported.  
  
The following sections explain common questions about File and Storage Services requirements.  
  
### How do I deploy and configure this role in a multiserver environment?  
You can split the functionality of File and Storage Services across multiple servers by installing the role and appropriate role services on each appropriate server. You can then add all the servers to Server Manager for centralized management, or use Windows PowerShell scripts to simultaneously manage multiple servers.  
  
### Can I run this role on virtual machines?  
Yes. You can run File and Storage Services and all its role services on Hyper\-V virtual machines.  
  
> [!IMPORTANT]  
> Using Hyper\-V snapshots to restore a server running DFS Replication for replication of anything other than the SYSVOL folder causes DFS Replication to fail, which requires special database recovery steps. For more information, see [article 2517913](http://support.microsoft.com/kb/2517913) in the Microsoft Knowledge Base.  
  
### Can I run this role in a clustered environment?  
Yes. You can run all File and Storage Services role services in a clustered environment. However, DFS Replication does not support replicating content that is stored in Cluster Shared Volumes.  
  
### Are there considerations for managing this role remotely?  
You can manage File and Storage Services remotely by using the following tools:  
  
-   Server Manager  
  
-   Windows PowerShell cmdlets  
  
-   DFS Management  
  
-   File Server Resource Manager  
  
-   Services for Network File System  
  
-   DFS command\-line utilities  
  
No special considerations are necessary.  
  
### Are there considerations for managing the role on the Server Core installation option?  
You can install and run File and Storage Services on the Server Core installation option or the Minimal Server Interface of [!INCLUDE[win8_server_2_help](../Token/win8_server_2_help_md.md)]. Server Manager and the administrative consoles do not work on the Server Core installation option, although they can be used with the Minimal Server Interface. They can also be used to remotely administer servers that use the Server Core option.  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
The following role services can be installed with the File and Storage Services server role.  
  
> [!NOTE]  
> Server Manager cannot be used to add roles and features to servers that are running Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003. For more information, see [Remote, Multiserver Management: scenario overview \[Pillar Scenario\]](assetId:///0a2292a7-bf03-41c9-b1fc-903805cef658). Also, Server Manager can receive only an online or offline status from servers that are running Windows Server 2003.  
  
|Role service|Description|  
|----------------|---------------|  
|File Services|Provides a grouping for role services that are related to file servers—it doesn’t install anything.|  
|File Server|Manages file shares and enables users to access files on this computer from the network. For more information about file shares that use the Server Message Block \(SMB\) protocol, see [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md).|  
|BranchCache for Network Files|Enables computers in branch offices to cache commonly downloaded files from file shares on which BranchCache is enabled, and then provide those files to other computers in the branch office. This reduces network bandwidth usage and provides faster access to the files. For more information about BranchCache, see [BranchCache Overview](assetId:///a92ec0b2-eb08-4fe7-b6a6-d140e0f55fd5).|  
|Data Deduplication|Saves disk space by storing a single copy of identical data on the volume. For more information about Data Deduplication, see [Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md).|  
|DFS Namespaces|Enables you to group file shares that are located on different servers into one or more logically structured namespaces. Each namespace appears to users as a single file share with a series of subfolders. However, the underlying structure of the namespace can consist of numerous file shares located on different servers in multiple sites. Because the underlying structure of file shares is hidden from users, a single folder in a DFS namespace can correspond to multiple file shares on multiple servers. This structure provides fault tolerance and the ability to automatically connect users to local file shares, when they are available, instead of routing users over wide area network \(WAN\) connections. For more information, see [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md).|  
|DFS Replication|Replicates data between multiple servers over limited bandwidth network connections and local area network connections. It is a multiple master replication engine that uses the Remote Differential Compression \(RDC\) protocol to update only the portions of files that have changed since the last replication. DFS Replication can be used in conjunction with DFS Namespaces or by itself. For more information, see [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md).|  
|File Server Resource Manager|Helps you manage and understand the files and folders on a file server by scheduling file management tasks and storage reports, classifying files and folders, configuring folder quotas, and defining file screening policies. For more information, see [File Server Resource Manager Overview_1](../Topic/File-Server-Resource-Manager-Overview_1.md).|  
|File Server VSS Agent Service|Enables you to create volume shadow copies of applications that store data files on this file server.|  
|iSCSI Target Server|Provides management tools for iSCSI targets. For more information, see [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md).|  
|Server for Network File System \(NFS\)|Enables this computer to share files with UNIX\-based computers and other computers that use the network file system \(NFS\) protocol.|  
|Storage Services|Provides storage management functionality that is always installed, including Storage Spaces and storage pools.|  
  
## <a name="BKMK_LINKS"></a>See also  
For related information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md) &#124; [DFS Namespaces and DFS Replication Overview](../Topic/DFS-Namespaces-and-DFS-Replication-Overview.md) &#124; [High\-Performance, Continuously Available File Share Storage for Server Applications Technical Preview](assetId:///22d2c70e-f3f9-44cb-a430-5e02959537a9) &#124; [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md) &#124; [Network File System Overview](../Topic/Network-File-System-Overview.md) &#124; [Windows Offloaded Data Transfers Overview](../Topic/Windows-Offloaded-Data-Transfers-Overview.md) &#124; [Resilient File System Overview](../Topic/Resilient-File-System-Overview.md) &#124; [Server Availability Overview](assetId:///22c42d93-e045-4491-8906-4273569d160f) &#124; [Scenario: Get Insight into Your Data by Using Classification](../Topic/Scenario--Get-Insight-into-Your-Data-by-Using-Classification.md) &#124; [Scenario: Implement Retention of Information on File Servers](../Topic/Scenario--Implement-Retention-of-Information-on-File-Servers.md) &#124; [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md) &#124; [Introduction to SMI\-S](http://blogs.technet.com/b/filecab/archive/2012/06/25/introduction-to-smi-s.aspx) &#124; [Storage Management Technical Preview](assetId:///d8442e86-3b63-44e0-b36c-7981643999f8) &#124; [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md) &#124; [Supporting Information Workers with Reliable File Services and Storage](../Topic/Supporting-Information-Workers-with-Reliable-File-Services-and-Storage.md) &#124; [Thin Provisioning and Trim Storage Technical Preview](assetId:///10062089-3259-4d7e-8605-f7abc57fd06f)|  
|**Deployment**|[Plan to Deploy Data Deduplication](../Topic/Plan-to-Deploy-Data-Deduplication.md) &#124; [Deploy Network File System](../Topic/Deploy-Network-File-System.md) &#124; [Scale\-Out File Server for Application Data Overview](http://go.microsoft.com/fwlink/p/?LinkId=237257) &#124; [Understand and Troubleshoot Storage Spaces and Pools in Windows Server "8" Beta](http://go.microsoft.com/fwlink/p/?LinkId=237255)|  
|**Operations**|[iSCSI Target Block Storage, How To](../Topic/iSCSI-Target-Block-Storage,-How-To.md) &#124; [Windows PowerShell Reference Sheet for File and Storage Services](http://blogs.technet.com/cfs-file.ashx/__key/communityserver-components-postattachments/00-03-48-49-38/FileServicesGettingStartedCmdlets.pdf)|  
|**Tools and settings**|[BranchCache Cmdlets](http://technet.microsoft.com/library/hh831487.aspx) &#124; [Deduplication Cmdlets](http://technet.microsoft.com/library/hh848450.aspx) &#124; [DFS Namespaces cmdlets](http://technet.microsoft.com/library/jj884270.aspx) &#124; [DFS Replication cmdlets](http://technet.microsoft.com/library/dn296591.aspx) &#124; [File Server Resource Manager cmdlets](http://technet.microsoft.com/library/jj900651.aspx) &#124; [iSCSI Cmdlets](http://technet.microsoft.com/library/hh826099.aspx) &#124; [iSCSI Target Cmdlets](http://technet.microsoft.com/library/jj612803.aspx) &#124; [MultiPath I\/O \(MPIO\) Cmdlets](http://technet.microsoft.com/library/hh826113.aspx) &#124; [Server for NFS cmdlets](http://technet.microsoft.com/library/jj603081.aspx) &#124; [SMB Shares cmdlets](http://technet.microsoft.com/library/jj635726.aspx) &#124; [SMB Witness cmdlets](http://technet.microsoft.com/library/jj635726.aspx) &#124; [SMI\-S cmdlets](http://technet.microsoft.com/library/jj884239.aspx) &#124; [Storage cmdlets](http://technet.microsoft.com/library/hh848705.aspx) &#124; [Storage Management API Classes](http://msdn.microsoft.com/library/windows/desktop/hh830612.aspx) &#124; [Sync Share \(Work Folders\) cmdlets](http://technet.microsoft.com/library/dn296644.aspx)|  
|**Troubleshooting**|[Known Issues: File and Storage Services in Windows Server 2012](http://social.technet.microsoft.com/wiki/contents/articles/13392.known-issues-file-and-storage-services-in-windows-server-2012.aspx)|  
|**Community resources**|[The File Services and Storage TechNet Forum](http://social.technet.microsoft.com/forums/winserverfiles/threads/) &#124; [Storage Team at Microsoft File Cabinet Blog](http://blogs.technet.com/filecab/) &#124; [Ask the Directory Services Team Blog](http://blogs.technet.com/b/askds/) &#124; [Jose Barreto's Blog](http://blogs.technet.com/b/josebda/) &#124; [Windows Storage Team Blog](http://blogs.msdn.com/b/san/) &#124; [DFS Replication Survival Guide \(TechNet Wiki\)](http://social.technet.microsoft.com/wiki/contents/articles/dfs-replication-survival-guide.aspx) &#124; [Windows Server Information Experience on Twitter](http://twitter.com/windowsserver)|  
|**Related technologies**|[Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md) &#124; [Failover Clustering](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)|  
  
