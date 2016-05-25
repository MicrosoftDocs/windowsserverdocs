---
title: Resilient File System Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b8eda28d-c93f-491b-9159-01bc56cd2103
author: JasonGerend
---
# Resilient File System Overview
This topic describes Resilient File System \(ReFS\), a new file system in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the deployment scenarios for the new file system, and the new and changed functionality for ReFS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## Feature description  
Windows customers want a cost\-effective platform that maximizes data availability, scales efficiently to very large data sets across diverse workloads, and guarantees data integrity by means of resiliency to corruption \(regardless of software or hardware failures\). ReFS is a new file system that targets these needs while providing a foundation for significant future innovations. By utilizing an integrated storage stack comprising ReFS and the new Storage Spaces feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], customers can now deploy the most cost\-effective platform for available and scalable data access using commodity storage.  
  
Storage Spaces protects data from partial and complete disk failures by maintaining copies on multiple disks. ReFS interfaces with Storage Spaces to automatically repair the corruption. For more information about Storage Spaces, see [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md) and the [Storage Spaces](http://social.technet.microsoft.com/wiki/contents/articles/15198.storage-spaces-overview.aspx) Microsoft TechNet blog.  
  
The key attributes of ReFS include:  
  
-   Maintaining a high level of data availability and reliability, even when the individual underlying storage devices experience failures.  
  
-   Providing a full, end\-to\-end resilient architecture when used in conjunction with Storage Spaces. When used together, ReFS and Storage Spaces provide enhanced resiliency to storage device failures.  
  
For information about new and updated functionality in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [New and updated functionality](../Topic/Resilient-File-System-Overview.md#BKMK_newforBlue) later in this topic.  
  
## Deployment scenarios  
ReFS provides functionality that helps customers store and protect data, regardless of the reliability of the underlying hardware and software stack. This minimizes the cost of storage and reduces capital expenditures for businesses. Customers can deploy a [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] file server attached to a just a bunch of disks \(JBOD\) storage configuration with Serial ATA \(SATA\) or Serially Attached SCSI \(SAS\) drives. Additionally, the deployment could include failover clustering where the customer deploys a scale\-out, two\-node file server cluster with Storage Spaces, where the cluster uses a shared JBOD storage configuration with SAS drives.  
  
## Important functionality  
The significant functionality included with ReFS is described as follows:  
  
-   **Integrity**. ReFS stores data in a way that protects it from many of the common errors that can normally cause data loss. When ReFS is used in conjunction with a mirror space or a parity space, detected corruption—both metadata and user data, when integrity streams are enabled—can be automatically repaired using the alternate copy provided by Storage Spaces. In addition, there are Windows PowerShell cmdlets \(**Get\-FileIntegrity** and **Set\-FileIntegrity**\) that you can use to manage the integrity and disk scrubbing policies.  
  
-   **Availability**. ReFS prioritizes the availability of data. Historically, file systems were often susceptible to data corruption that would require the system to be taken offline for repair. With ReFS, if corruption occurs, the repair process is both localized to the area of corruption and performed online, requiring no volume downtime. Although rare, if a volume does become corrupted or you choose not to use it with a mirror space or a parity space, ReFS implements *salvage*, a feature that removes the corrupt data from the namespace on a live volume and ensures that good data is not adversely affected by nonrepairable corrupt data. Because ReFS performs all repair operations online, it does not have an offline **chkdsk** command.  
  
-   **Scalability**. As the amount and size of data that is stored on computers continues to rapidly increase, ReFS is designed to work well with extremely large data sets—petabytes and larger—without performance impact. ReFS is not only designed to support volume sizes of 2^64 bytes \(allowed by Windows stack addresses\), but ReFS is also designed to support even larger volume sizes of up to 2^78 bytes using 16 KB cluster sizes. This format also supports 2^64\-1 byte file sizes, 2^64 files in a directory, and the same number of directories in a volume.  
  
-   **Proactive Error Correction**. The integrity capabilities of ReFS are leveraged by a data integrity scanner, which is also known as a *scrubber*. The integrity scanner periodically scans the volume, identifying latent corruptions and proactively triggering a repair of that corrupt data.  
  
## <a name="BKMK_newforBlue"></a>New and updated functionality  
The following table lists the features and functionality that are updated or new to ReFS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
|Feature\/functionality|New or updated|Description|  
|--------------------------|------------------|---------------|  
|[Corruptions on parity spaces](../Topic/Resilient-File-System-Overview.md#BKMK_parityspace)|Updated|When a corruption occurs on a parity space, ReFS automatically corrects the corruption.|  
|[Subfolder recovery from ReFS metadata corruption](../Topic/Resilient-File-System-Overview.md#BKMK_ReFSMetadata)|Updated|When corruption of ReFS metadata occurs, subfolders and their associated files are automatically recovered.|  
|[ReFS is available on client operating systems](../Topic/Resilient-File-System-Overview.md#BKMK_ReFSclient)|New|ReFS is now available to use on [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)].|  
|[ReFS registry entry](../Topic/Resilient-File-System-Overview.md#ReFSregistry)|New|The new **RefsDisableLastAccessUpdate** registry entry is equivalent to **NtfsDisableLastAccessUpdate**.|  
|[Storage cmdlets in Windows](../Topic/Resilient-File-System-Overview.md#BKMK_WScmdlets)|New|New storage cmdlets, **Get\-FileIntegrity** and **Set\-FileIntegrity**, are available to manage integrity and disk scrubbing policies.|  
  
### <a name="BKMK_parityspace"></a>Corruptions on parity spaces  
ReFS can automatically correct corruption on a parity space when integrity streams are enabled to detect corrupt data and because ReFS examines the second \(and third\) copies that the data parity spaces contain. ReFS then uses the correct version to correct the corruption.  
  
> [!NOTE]  
> ReFS can already detect corruption on mirrored spaces and automatically repair those corruptions.  
  
### <a name="BKMK_ReFSMetadata"></a>Subfolder recovery from ReFS metadata corruption  
When the metadata for a ReFS directory is corrupted, subfolders and their associated files are automatically recovered. ReFS identifies and recovers the files while ReFS remains online. Unrecoverable corruption of the ReFS directory metadata affects only those files that are in the directory in which the corruption has occurred.  
  
### <a name="BKMK_ReFSclient"></a>ReFS is available on client operating systems  
In [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], you have the option to format a storage space as ReFS using mirrored Storage Spaces in Control Panel. ReFS also supports alternate data streams \(up to 128K for both [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\), which enables Office document thumbnails, Mark of the Web \(MOTW\), and similar features available on [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)].  
  
### <a name="ReFSregistry"></a>ReFS registry entry  
ReFS includes a new registry entry, **RefsDisableLastAccessUpdate**, which is the equivalent of the previous **NtfsDisableLastAccessUpdate** registry entry. For more information, see [NtfsDisableLastAccessUpdate](http://technet.microsoft.com/library/cc959914.aspx).  
  
### <a name="BKMK_WScmdlets"></a>Storage cmdlets in Windows  
New storage cmdlets in Windows PowerShell are available \([Get\-FileIntegrity](http://technet.microsoft.com/library/jj218348.aspx) and [Set\-FileIntegrity](http://technet.microsoft.com/library/jj218351.aspx)\) for you to manage the integrity and disk scrubbing policies.  
  
## See also  
The following list provides additional resources on the web about related technologies in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)  
  
-   [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md)  
  
-   [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
