---
title: Storage Spaces Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bbfe20d3-59c4-4826-82b4-90154b0b3457
---
# Storage Spaces Overview
This topic discusses Storage Spaces, a technology in Windows and Windows Server that enables you to virtualize storage by grouping industry\-standard disks into storage pools, and then creating virtual disks called *storage spaces* from the available capacity in the storage pools. This topic provides an overview of the technology and new Storage Spaces functionality in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The end of the topic also provides an up\-to\-date list of essential Storage Spaces topics.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Migrate to Azure Premium Storage](http://aka.ms/mk36m5)<br />\- [Learn about StorSimple Hybrid Cloud Storage](http://aka.ms/fuxxdp)|  
  
**Did you mean…**  
  
-   [Storage Spaces in Windows 10](http://windows.microsoft.com/en-us/windows-10/storage-spaces-windows-10)  
  
-   [Storage Spaces: Frequently Asked Questions](http://windows.microsoft.com/windows-8/storage-spaces-pools) \(Windows 8.1\)  
  
-   [Software-Defined Storage Design Considerations Guide](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md) \(Important design tips for Storage Spaces\)  
  
-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](assetId:///e70fcb94-0576-4582-a1e0-8c41f8d745cc) \(a large\-scale Storage Spaces environment\)  
  
-   [Storage Spaces Frequently Asked Questions \(FAQ\)](http://social.technet.microsoft.com/wiki/contents/articles/11382.storage-spaces-frequently-asked-questions-faq.aspx) \(TechNet Wiki\)  
  
## In this topic  
  
-   [Technology description](../Topic/Storage-Spaces-Overview.md#BKMK_TechDescription)  
  
-   [Important functionality](../Topic/Storage-Spaces-Overview.md#BKMK_ImportantFunctionality)  
  
-   [New and changed functionality](../Topic/Storage-Spaces-Overview.md#BKMK_NEW)  
  
-   [Requirements](../Topic/Storage-Spaces-Overview.md#BKMK_Requirements)  
  
-   [See also](../Topic/Storage-Spaces-Overview.md#BKMK_LINKS)  
  
## <a name="BKMK_TechDescription"></a>Technology description  
Storage Spaces enables cost\-effective, highly available, scalable, and flexible storage solutions for business\-critical \(virtual or physical\) deployments. Storage Spaces delivers sophisticated storage virtualization capabilities, which empower customers to use industry\-standard storage for single computer and scalable multi\-node deployments. It is appropriate for a wide range of customers, including enterprise and cloud hosting companies, which use Windows Server for highly available storage that can cost\-effectively grow with demand.  
  
With Storage Spaces the Windows storage stack has been fundamentally enhanced to incorporate two new abstractions:  
  
-   **Storage pools**. A collection of physical disks that enable you to aggregate disks, expand capacity in a flexible manner, and delegate administration.  
  
-   **Storage spaces**. Virtual disks created from free space in a storage pool. Storage spaces have such attributes as resiliency level, storage tiers, fixed provisioning, and precise administrative control.  
  
Storage Spaces is integrated with failover clustering for high availability, and it’s integrated with cluster shared volumes \(CSV\) for scale\-out file server deployments. You can manage Storage Spaces through:  
  
-   System Center Virtual Machine Manager  
  
-   Failover Cluster Manager  
  
-   Server Manager  
  
-   Windows PowerShell  
  
-   Windows Management Instrumentation \(WMI\)  
  
## <a name="BKMK_ImportantFunctionality"></a>Important functionality  
Storage Spaces includes the following features:  
  
-   **Storage pools**. Storage pools are the fundamental building blocks for Storage Spaces. Storage administrators are already familiar with this concept, obviating the need to learn a new model. They can flexibly create storage pools based on the needs of the deployment. For example, given a set of physical disks, an administrator can create one pool \(by using all the available physical disks\) or multiple pools \(by dividing the physical disks as required\). Furthermore, to maximize the value from storage hardware, the administrator can combine hard disks and solid\-state drives \(SSDs\) in the same pool, using storage tiers to move frequently accessed portions of files to SSD storage, and using write\-back caches to buffer small random writes to SSD storage. Pools can be expanded dynamically by simply adding additional disks, thereby seamlessly scaling to cope with data growth.  
  
-   **Resilient storage**. Storage Spaces provides three storage layouts \(also known as resiliency types\):  
  
    -   **Mirror**. Writes data in a stripe across multiple disks while also writing one or two extra copies of the data. Use the mirror layout for most workloads – it helps protect your data from disk failures and provides great performance, especially when you add some SSDs to your storage pool and use storage tiers.  
  
    -   **Parity**. Writes data in a stripe across physical disks while also writing one or two copies of parity information. Use the parity layout for archival and streaming media workloads, or other workloads where you want to maximize capacity and you’re OK with lower write performance.  
  
    -   **Simple \(no resiliency\)**. Writes data in a stripe across physical disks without any extra copies or parity information. Because the simple layout doesn’t provide any protection from disk failures, use it only when you require the highest performance and capacity and you’re OK with losing or recreating the data if a disk fails. You can also use the simple layout when your application provides its own data protection.  
  
    Additionally, Storage Spaces can automatically repair mirror and parity spaces in which a disk fails by using dedicated disks that are reserved for replacing failed disks \(hot spares\), or more rapidly by using spare capacity on other disks in the pool. Storage Spaces also includes background scrubbing and intelligent error correction to allow continuous service availability despite storage component failures. In the event of a power failure or cluster failover, the integrity of data is preserved so that recovery happens quickly without lost data.  
  
-   **Continuous availability**. Storage Spaces is integrated with failover clustering, which allows it to deliver continuously available service deployments. One or more pools can be clustered across multiple nodes within a single cluster. Storage spaces are accessed by one node, and the storage will seamlessly fail over to a different node when necessary \(in response to failure conditions or due to load balancing\). Integration with CSVs permits scale\-out access to data.  
  
-   **Storage tiers**. Storage tiers combine the best attributes of SSDs and hard disk drives \(HDDs\) by letting you create virtual disks with two tiers of storage – an SSD tier for frequently accessed data, and a HDD tier for less\-frequently accessed data. New data is generally written to the HDD tier and then Storage Spaces transparently moves data at a sub\-file level between the two tiers based on how frequently data is accessed. As a result, storage tiers can dramatically increase performance for the most used \(“hot”\) data by moving it to SSD storage, without sacrificing the ability to store large quantities of data on inexpensive HDDs.  
  
-   **Write\-back cache**. Storage Spaces in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] supports creating a write\-back cache that uses a small amount of space on existing SSDs in the pool to buffer small random writes. Random writes, which often dominate common enterprise workloads, are directed to SSDs and later are written to HDDs.  
  
-   **Operational simplicity**. The Windows Storage Management API, WMI, and Windows PowerShell permit full scripting and remote management. Storage Spaces can also be easily managed through the File and Storage Services role in Server Manager and through System Center Virtual Machine Manager. Storage Spaces also provides notifications when the amount of available capacity in a storage pool hits a configurable threshold.  
  
-   **Multitenancy**. Administration of storage pools can be controlled through access control lists \(ACLs\) and delegated on a per\-pool basis, thereby supporting hosting scenarios that require tenant isolation. Storage Spaces follows the familiar Windows security model; therefore, it can be fully integrated with Active Directory Domain Services.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
The following table describes some of the major changes in Storage Spaces. For more detailed information, see [What's New in Storage Spaces in Windows Server 2012 R2](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e).  
  
|Feature\/functionality|New or updated?|Description|  
|--------------------------|-------------------|---------------|  
|[Storage tiers](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e#bkmk_tiers)|New|Automatically moves frequently accessed data to faster \(SSD\) storage and infrequently accessed data to slower \(HDD\) storage.|  
|[Write\-back cache](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e#bkmk_wbc)|New|Buffers small random writes to SSD storage, reducing the latency of writes.|  
|[Parity space support for failover clusters](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e#bkmk_parityfailover)|New|Enables you to create parity spaces on failover clusters.|  
|[Dual parity](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e#bkmk_dualparity)|New|Stores two copies of the parity information on a parity space, helping protect you from two simultaneous disk failures while optimizing for storage efficiency.|  
|[Automatically rebuild storage spaces from storage pool free space](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e#bkmk_rebuild)|New|Greatly decreases how long it takes to rebuild a storage space after a disk failure by using spare capacity in the pool instead of a single hot spare.|  
  
## <a name="BKMK_Requirements"></a>Requirements  
Storage Spaces has the following requirements:  
  
-   [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]  
  
-   Serial ATA \(SATA\) or Serial Attached SCSI \(SAS\) connected disks, optionally in a just\-a\-bunch\-of\-disks \(JBOD\) enclosure  
  
    RAID adapters, if used, must have all RAID functionality disabled and must not obscure any attached devices, including enclosure services provided by an attached JBOD.  
  
    > [!NOTE]  
    > Consumers can use USB drives with Storage Spaces, though USB 3 drives are recommended to ensure a high level of performance. USB 2 drives will decrease performance – a single USB 2 hard drive can saturate the bandwidth available on the shared USB bus, limiting performance when multiple drives are attached to the same USB 2 controller. When using USB 2 drives, plug them directly into different USB controllers on your computer, do not use USB hubs, and add USB 2 drives to a separate storage pool used only for storage spaces that do not require a high level of performance.  
  
-   For shared\-storage deployments on failover clusters:  
  
    -   Two or more servers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
    -   Requirements as specified for failover clustering and Cluster Shared Volumes \(CSV\)  
  
    -   SAS connected JBODs that comply with Windows Certification requirements  
  
        For a list of certified JBODs, see the [Windows Server Catalog](http://windowsservercatalog.com/results.aspx?&chtext=&cstext=&csttext=&chbtext=&bCatID=1645&cpID=0&avc=10&ava=0&avq=0&OR=1&PGS=25&ready=0).  
  
    -   Identical SAS HBAs that are certified for use with Storage Spaces  
  
        These HBAs are connected to all JBOD enclosures in the file server cluster, and can’t have built\-in RAID functionality.  
  
For information about using Storage Spaces to host virtual machines for large scale Hyper\-V workloads, see [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](assetId:///e70fcb94-0576-4582-a1e0-8c41f8d745cc).  
  
## <a name="BKMK_LINKS"></a>See also  
For additional related information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Evaluation**|-   [What's New in Storage Spaces in Windows Server 2012 R2](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e)<br />-   [Storage Spaces: What’s New in Windows Server 2012 R2 \(TechEd 2013 Video\)](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2013/MDC-B218)<br />-   [Storage and Availability Improvements in Windows Server 2012 R2 \(TechEd 2013 Video\)](http://channel9.msdn.com/Events/TechEd/Europe/2013/MDC-B333)<br />-   [Case Studies on Storage Spaces, Scale\-Out File Servers with SMB3](http://blogs.technet.com/b/josebda/archive/2015/01/05/case-studies-on-storage-spaces-scale-out-file-servers-with-smb3-or-both.aspx) \(blog\)<br />-   [Achieving Over 1\-Million IOPS from Hyper\-V VMs in a Scale\-Out File Server Cluster Using Windows Server 2012 R2](http://www.microsoft.com/download/details.aspx?id=42960)<br />-   [Using Storage Spaces for Storage Subsystem Performance](http://msdn.microsoft.com/windows/hardware/dn567634)<br />-   [Virtualizing storage for scale, resiliency, and efficiency](http://blogs.msdn.com/b/b8/archive/2012/01/05/virtualizing-storage-for-scale-resiliency-and-efficiency.aspx) \(Building Windows 8 Blog\)<br />-   [Storage Spaces Overview](http://social.technet.microsoft.com/wiki/contents/articles/15198.storage-spaces-overview.aspx) \(TechNet Wiki\)<br />-   [High Performance Storage Solutions with Windows 8](http://blogs.windows.com/windows/b/extremewindows/archive/2013/02/15/high-performance-storage-solutions-with-windows-8.aspx)<br />-   [Microsoft Cloud Platform System Storage Performance](https://www.microsoft.com/en-us/download/details.aspx?id=45917&WT.mc_id=Blog_WS_Announce_TTD)|  
|**Design**|-   [Software-Defined Storage Design Considerations Guide](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md)<br />-   [Software\-Defined Storage Design Calculator](http://aka.ms/sdscalc)|  
|**Deployment**|-   [Deploy Storage Spaces on a Stand\-Alone Server](assetId:///a00b4171-4de4-4f4d-8712-22b68be7fc77)<br />-   [Deploy Clustered Storage Spaces](assetId:///7b33931e-7971-49b0-b385-b1e5a90d94fe)<br />-   [Storage Spaces \- Designing for Performance](http://social.technet.microsoft.com/wiki/contents/articles/15200.storage-spaces-designing-for-performance.aspx)<br />-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](assetId:///e70fcb94-0576-4582-a1e0-8c41f8d745cc)<br />-   [Windows Server 2012 IaaS Build Tables: Step\-by\-Step with PowerShell Examples](http://gallery.technet.microsoft.com/Windows-Server-2012-IaaS-e4533522)|  
|**Operations**|-   [Storage Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/hh848705.aspx)<br />-   [Storage Spaces Cmdlets](http://technet.microsoft.com/library/jj851254.aspx)<br />-   [Test Storage Spaces Performance Using Synthetic Workloads in Windows Server](../Topic/Test-Storage-Spaces-Performance-Using-Synthetic-Workloads-in-Windows-Server.md)<br />-   [How Storage Spaces Makes Use of Hot Spares](../Topic/How-Storage-Spaces-Makes-Use-of-Hot-Spares.md)<br />-   [How Storage Spaces responds to errors on physical disks](http://social.technet.microsoft.com/wiki/contents/articles/17947.how-storage-spaces-responds-to-errors-on-physical-disks.aspx)<br />-   [Monitor Storage Tiers Performance in Windows Server 2012 R2](../Topic/Monitor-Storage-Tiers-Performance-in-Windows-Server-2012-R2.md)<br />-   [Replace Failed Disks and Repair JBODs for Storage Spaces in Windows Server](../Topic/Replace-Failed-Disks-and-Repair-JBODs-for-Storage-Spaces-in-Windows-Server.md)|  
|**Community resources**|-   [Storage Spaces Frequently Asked Questions \(FAQ\)](http://social.technet.microsoft.com/wiki/contents/articles/11382.storage-spaces-frequently-asked-questions-faq.aspx)<br />-   [Storage Spaces Survival Guide](http://blogs.technet.com/b/josebda/archive/2014/09/20/storage-spaces-survival-guide-links-to-presentations-articles-blogs-tools.aspx) \(blog\)<br />-   [Windows Server Storage Spaces: What is it and why should I use it? \(CuratedAnswers\)](https://curatedviews.cloudapp.net/5049/windows-server-2012-r2-storage-spaces-what-is-it-and-why-should-i-use-it)<br />-   [DiskSpd, PowerShell and storage performance: measuring IOPs, throughput and latency for both local disks and SMB file shares \(blog\)](http://blogs.technet.com/b/josebda/archive/2014/10/13/diskspd-powershell-and-storage-performance-measuring-iops-throughput-and-latency-for-both-local-disks-and-smb-file-shares.aspx)<br />-   [Step\-by\-Step for Mirrored Storage Spaces Resiliency using PowerShell](http://blogs.technet.com/b/josebda/archive/2014/04/01/step-by-step-for-mirrored-storage-spaces-resiliency-using-powershell.aspx)<br />-   [Managing Storage with Windows PowerShell on Windows Server 2012](http://blogs.msdn.com/b/san/archive/2012/07/03/managing-storage-with-windows-powershell-on-windows-server-2012.aspx)<br />-   [Deploy and Manage Storage Spaces with Windows PowerShell](http://www.microsoft.com/download/details.aspx?id=30125)<br />-   [Step\-by\-step for Storage Spaces Tiering in Windows Server 2012 R2](http://blogs.technet.com/b/josebda/archive/2013/08/28/step-by-step-for-storage-spaces-tiering-in-windows-server-2012-r2.aspx)<br />-   [The File Services and Storage TechNet Forum](http://social.technet.microsoft.com/forums/en-US/winserverfiles/threads/)<br />-   [Storage Team at Microsoft File Cabinet Blog](http://blogs.technet.com/filecab/)<br />-   [Jose Barreto's Blog](http://blogs.technet.com/b/josebda/)<br />-   [Windows Storage Team Blog](http://blogs.msdn.com/b/san/)|  
|**Related technologies**|-   [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)<br />-   [Thin Provisioning and Trim Storage Overview](assetId:///10062089-3259-4d7e-8605-f7abc57fd06f)<br />-   [Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md)<br />-   [iSCSI Target Server Overview](../Topic/iSCSI-Target-Server-Overview.md)<br />-   [Resilient File System Overview](../Topic/Resilient-File-System-Overview.md)|  
  
