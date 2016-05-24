---
title: NTFS Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c94d33ff-bf8c-46a3-a29e-6d378070028c
---
# NTFS Overview
The NTFS file system provides performance and reliability,      and includes built\-in security features such as file and folder permissions. NTFS supportsvolumes as large as 256 terabytes, disk quotas,compression, and mounted drives. For information on new and changed functionality in NTFS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see [What's New in NTFS for Windows Server 2012 R2](assetId:///4ea6c56e-935d-4dbc-aae7-501fb0ad3db0).  
  
## Practical applications  
  
-   **Increased reliability**. NTFS uses its log file and checkpoint information to restore the consistency of the file system when the computer is restarted in the event of a system failure. In the event of a bad\-sector error, NTFS dynamically remaps the cluster containing the bad sector and allocates a new cluster for the data, as well as marking the cluster as bad and no longer using it. For example, by formatting a POP3 mail server with NTFS, the mail store can offer logging and recovery. In the event of a server crash, NTFS can recover data by replaying its log files.  
  
-   **Increase security**. NTFS allows you to set permissions on a file or folder, and specify the groups and users whose access you want to restrict or allow, and then to select the type of access.  
  
-   **Support for 256 TB volumes**. NTFS supports volumesas large as256 terabytes. Supported volume sizes are affected by the cluster size and the number of clusters. WIth \(2<sup>23</sup> \- 1\) clusters \(the maximum number of clusters that NTFS supports\), the following volume sizes are supported for the default and maximum cluster sizes. [Detailed explanation of volume size limits in Windows storage](http://blogs.technet.com/b/askcore/archive/2010/02/18/understanding-the-2-tb-limit-in-windows-storage.aspx)  
  
    |Cluster size|Largest volume|Largest file|  
    |----------------|------------------|----------------|  
    |4KB \(default size\)|16 TB|16 TB|  
    |64 KB \(maximum size\)|256 TB|256 TB|  
  
-   **Increase storage capacity on volumes with limited disk space**. If the space on a volume is limited, NTFS provides these methods for increasing storage capacity on the server:  
  
    -   Use disk quotas to track and control disk space usage on NTFS volumes for individual users.  
  
    -   Use compression to store more data in the same space.  
  
    -   Increase the size of an NTFS volume, by  adding unallocated space from the same disk or from a  different disk.  
  
    -   Mount a volume at any empty folder on a local NTFS volume if you run out of drive letters or need to create additional space that is accessible from an existing folder.  
  
## See also  
For additional related information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|Evaluation|-   [What's New in NTFS for Windows Server \(Windows Server 2012 R2\)](https://technet.microsoft.com/library/dn466520.aspx)<br />-   [NTFS Health and ChkDsk \(Introduced in Windows Server 2012\)](https://technet.microsoft.com/library/hh831536.aspx)<br />-   [What's New in NTFS \(Windows Server 2008\)](https://technet.microsoft.com/library/dn466520.aspx)<br />-   [Self\-Healing NTFS \(introduced in Windows Server 2008\)](https://technet.microsoft.com/library/cc771388(v=ws.10).aspx)<br />-   [Transactional NTFS \(introduced in Windows Server 2008\)](https://technet.microsoft.com/library/cc730726(v=ws.10).aspx)|  
|Community resources|-   [Understanding the 2 TB Limit in Windows Storage](http://blogs.technet.com/b/askcore/archive/2010/02/18/understanding-the-2-tb-limit-in-windows-storage.aspx) \(Ask the Core Team blog\)<br />-   [Windows Storage Team Blog](http://blogs.msdn.com/b/san/)|  
|Related technologies|-   [File and Storage Services Overview](https://technet.microsoft.com/library/hh831487.aspx)<br />-   Cluster Shared Volumes \(CSVs\): [Use Cluster Shared Volumes in a Failover Cluster](https://technet.microsoft.com/library/jj612868.aspx); [Designing Your Cloud Infrastructure](https://technet.microsoft.com/library/hh831630.aspx) \(See the “Cluster Shared Volumes” and “Storage Design” sections.\)<br />-   [Storage Spaces Overview](https://technet.microsoft.com/library/hh831739.aspx)<br />-   [Resilient File System \(ReFS\) Overview](https://technet.microsoft.com/library/hh831724.aspx)<br />-   [DFS Namespaces and DFS Replication Overview](https://technet.microsoft.com/library/jj127250.aspx)|  
  
