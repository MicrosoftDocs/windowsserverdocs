---
title: Data Deduplication Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 77d16687-fb4c-4c1e-9801-a05b0a92daef
author: JasonGerend
---
# Data Deduplication Overview
This topic describes the data deduplication feature in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], and it explains practical applications for the feature.  
  
## <a name="BKMK_APP"></a>Feature description  
Data deduplication involves finding and removing duplication within data without compromising its fidelity or integrity. The goal is to store more data in less space by segmenting files into small variable\-sized chunks \(32–128 KB\), identifying duplicate chunks, and maintaining a single copy of each chunk. Redundant copies of the chunk are replaced by a reference to the single copy. The chunks are compressed and then organized into special container files in the System Volume Information folder.  
  
The result is an on\-disk transformation of each file as shown in Figure 1. After deduplication, files are no longer stored as independent streams of data, and they are replaced with stubs that point to data blocks that are stored within a common chunk store. Because these files share blocks, those blocks are only stored once, which reduces the disk space needed to store all files. During file access, the correct blocks are transparently assembled to serve the data without calling the application or the user having any knowledge of the on\-disk transformation to the file. This enables administrators to apply deduplication to files without having to worry about any change in behavior to the applications or impact to users who are accessing those files.  
  
![](media/1_Dedup_Rev_Guide.jpg)  
  
**Figure 1** On\-disk transformation of files during data deduplication  
  
After a volume is enabled for deduplication and the data is optimized, the volume contains the following:  
  
-   **Unoptimized files**. For example, unoptimized files could include files that do not meet the selected file\-age policy setting, system state files, alternate data streams, encrypted files, files with extended attributes, files smaller than 32 KB, other reparse point files, or files in use by other applications \(the “in use” limit is removed in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]\).  
  
-   **Optimized files**. Files that are stored as reparse points that contain pointers to a map of the respective chunks in the chunk store that are needed to restore the file when it is requested.  
  
-   **Chunk store**. Location for the optimized file data.  
  
-   **Additional free space**. The optimized files and chunk store occupy much less space than they did prior to optimization.  
  
## <a name="BKMK_OVER"></a>Practical applications  
To cope with data storage growth in the enterprise, administrators are consolidating servers and making capacity scaling and data optimization key goals. Data deduplication provides practical ways to achieve these goals, including:  
  
-   **Capacity optimization.** Data deduplication  stores more data in less physical space. It achieves greater storage efficiency than was possible by using features such as Single Instance Storage \(SIS\) or NTFS compression. Data deduplication uses subfile variable\-size chunking and compression, which deliver optimization ratios of 2:1 for general file servers and up to 20:1 for virtualization data.  
  
-   **Scale and performance.** Data deduplication is highly scalable, resource efficient, and nonintrusive. It can process up to 50 MB per second in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], and about 20 MB of data per second in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. It can run on multiple volumes simultaneously without affecting other workloads on the server. Low impact on the server workloads is maintained by throttling the CPU and memory resources that are consumed. If the server gets very busy, deduplication can stop completely. In addition, administrators have the flexibility to run data deduplication jobs at any time, set schedules for when data deduplication should run, and establish file selection policies.  
  
-   **Reliability and data integrity.** When data deduplication is applied, the integrity of the data is maintained. Data Deduplication uses checksum, consistency, and identity validation to ensure data integrity. For all metadata and the most frequently referenced data, data deduplication maintains redundancy to ensure that the data is recoverable in the event of data corruption.  
  
-   **Bandwidth efficiency with BranchCache.** Through integration with BranchCache, the same optimization techniques are applied to data transferred over the WAN to a branch office. The result is faster file download times and reduced bandwidth consumption.  
  
-   **Optimization management with familiar tools.** Data deduplication has optimization functionality built into Server Manager and Windows PowerShell. Default settings can provide savings immediately, or administrators can fine\-tune the settings to see more gains. One can easily use Windows PowerShell cmdlets to start an optimization job or schedule one to run in the future. Installing the Data Deduplication feature and enabling deduplication on selected volumes can also be accomplished by using an Unattend.xml file that calls a Windows PowerShell script and can be used with Sysprep to deploy deduplication when a system first boots.  
  
## New and changed functionality  
The following table describes the changes in Data Deduplication functionality. For more information, see [What's New in Data Deduplication in Windows Server 2012 R2](assetId:///70d1bb99-d5ad-4356-a641-0cc22333a3b9).  
  
|Feature\/Functionality|New or updated?|Description|  
|--------------------------|-------------------|---------------|  
|Data deduplication for remote storage of Virtual Desktop Infrastructure \(VDI\) workloads|New in Windows Server 2012 R2|Optimize active virtual hard disks \(VHDs\) for Virtual Desktop Infrastructure \(VDI\) workloads by implementing Data Deduplication on Cluster Shared Volumes \(CSVs\).|  
|Expand an optimized file on its original path|New in Windows Server 2012 R2|Use the new **Expand\-DedupFile** cmdlet in Windows PowerShell to expand optimized files on a specified path on the original path if needed for compatibility with applications, performance, or other requirements. For more information about the cmdlet, see T:Deduplication.Expand\-DedupFile.|  
|Data deduplication for backup volumes used by virtualized backup applications|New in Windows Server 2012 R2|Optimize active virtual hard disks \(VHDs\) used by virtualized backup application workloads by implementing Data Deduplication on Cluster Shared Volumes \(CSVs\) or limited hyper\-converged configurations. \(Supported with Windows Server 2012 R2 with the November 2014 update rollup \([KB 3000850](https://support.microsoft.com/en-us/kb/3000850)\) or later.\).|  
  
## Requirements  
To take advantage of data deduplication, the environment must meet the following requirements:  
  
-   Server: One computer or virtual machine running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] with at least one data volume  
  
-   \(Optional\) Another computer or virtual machine running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] that is connected to the server over a network  
  
    > [!IMPORTANT]  
    > If Data Deduplication is performed on VDI or virtualized backup workloads, all the VHD files must either be:  
    >   
    > -   Stored on a file server running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], and the storage node and the computation node are run on different servers.  
    > -   Stored on local storage in a specific, limited hyper\-converged configuration.  For detailed requirements,  see [Plan to Deploy Data Deduplication](https://technet.microsoft.com/en-us/library/hh831700.aspx).  
  
## Interoperability with Azure virtual machines  
You can run this Windows Server role service on a virtual machine in [!INCLUDE[azure_2](includes/azure_2_md.md)]. This scenario has been tested with [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]. We recommend using Data Deduplication with Windows Azure virtual machines that have volumes with frequent reads but infrequent writes. In these circumstances, Data Deduplication can provide an efficient way to store more data in Azure VMs.  
  
The following workloads can be good candidates for use with Data Deduplication on Azure VMs:  
  
-   General file servers with relatively static content  
  
-   Microsoft SharePoint sites with relatively static content  
  
-   Web sites with relatively static content  
  
The following workloads aren’t recommended for use with Data Deduplication on Azure VMs due to the frequency of changes to the large files used by the workloads:  
  
-   Messaging servers such as Microsoft Exchange Server  
  
-   Database servers such as Microsoft SQL Server  
  
To learn about how to get started with [!INCLUDE[azure_2](includes/azure_2_md.md)] virtual machines, visit the [Azure web site](http://www.windowsazure.com/en-us/documentation/services/virtual-machines).  
  
## Architecture overview  
The Data Deduplication feature consists of a filter driver that monitors local or remote I\/O and a deduplication service that controls the three types of jobs that are available \(Optimization, Garbage Collection, and Scrubbing\).  
  
Inherent in the deduplication architecture is resiliency during hardware failures—with full checksum validation on data and metadata, including redundancy for metadata and the most accessed data chunks.  
  
Data Deduplication can potentially process all of the data on a selected volume \(except a file size less than 32 KB, files in folders that are excluded, or files that have age settings applied\). You should carefully determine if a server and attached volumes are suitable candidates for deduplication prior to enabling the feature. We strongly recommend that during deduplication, you regularly back up important data.  
  
## See also  
For additional related information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|-   [Extending Data Deduplication to new workloads in Windows Server 2012 R2](http://blogs.technet.com/b/filecab/archive/2013/07/31/extending-data-deduplication-to-new-workloads-in-windows-server-2012-r2.aspx)|  
|**Deployment**|-   [Deploying Data Deduplication for VDI storage in Windows Server 2012 R2](http://blogs.technet.com/b/filecab/archive/2013/07/31/deploying-data-deduplication-for-vdi-storage-in-windows-server-2012-r2.aspx)<br />-   [Plan to Deploy Data Deduplication](Plan-to-Deploy-Data-Deduplication.md)<br />-   [Backup and Restore Considerations for Deduplicated Volumes](Backup-and-Restore-Considerations-for-Deduplicated-Volumes.md)<br />-   [Data Deduplication Interoperability](Data-Deduplication-Interoperability.md)<br />-   [Install and Configure Data Deduplication](Install-and-Configure-Data-Deduplication.md)|  
|**Operations**|-   [Monitor and Report for Data Deduplication](Monitor-and-Report-for-Data-Deduplication.md)|  
|**Community resources**|-   [The File Services and Storage TechNet Forum](http://social.technet.microsoft.com/forums/winserverfiles/threads/)<br />-   [Storage Team at Microsoft File Cabinet Blog](http://blogs.technet.com/filecab/)<br />-   [Ask the Directory Services Team Blog](http://blogs.technet.com/b/askds/)<br />-   [Jose Barreto's Blog](http://blogs.technet.com/b/josebda/)<br />-   [Windows Server Information Experience on Twitter](http://twitter.com/windowsserver)|  
|**Related technologies**|-   [File and Storage Services Overview](File-and-Storage-Services-Overview.md)<br />-   [Failover Clustering](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)<br />-   [Storage Spaces Overview](Storage-Spaces-Overview.md)|  
  

