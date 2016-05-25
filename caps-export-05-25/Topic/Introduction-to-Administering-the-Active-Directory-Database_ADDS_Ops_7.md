---
title: Introduction to Administering the Active Directory Database_ADDS_Ops_7
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 126f8e02-e221-4287-9644-34c531559410
author: Femila
---
# Introduction to Administering the Active Directory Database_ADDS_Ops_7
  Active Directory Domain Services \(AD DS\) is stored in the Ntds.dit database file. In addition to this file, the directory service uses log files, which store transactions before they commit them to the database file. For best performance, store the log files and the database on separate hard drives.  
  
 Before you perform any procedures that affect the directory database, be sure that you have a current system state or critical\-volume backup. For information about backing up AD DS, see [Backing Up Active Directory Domain Services](../Topic/Backing-Up-Active-Directory-Domain-Services.md).  
  
## Database management conditions  
 The Active Directory database is a self\-maintained system. It requires no daily maintenance, other than regular backup, during ordinary operation. However, you may have to manage it if the following conditions occur:  
  
-   Low disk space: move the files to a different location permanently, or replace the disk on which the database or log files are stored.  
  
-   Pending or current hardware failure: upgrade or replace the disk on which the database or log files are stored.  
  
-   A need to recover physical disk space: defragment the database after bulk deletion or removal of the global catalog.  
  
## Disk space monitoring recommendations  
 Monitor free disk space on the partition or partitions that store the directory database and logs. The following are the recommended parameters for free disk space:  
  
-   Ntds.dit partition: The greater of 20 percent of the Ntds.dit file size or 500 megabytes \(MB\).  
  
-   Log file partition: The greater of 20 percent of the combined log files size or 500 MB.  
  
-   Ntds.dit and logs on the same volume: The greater of 20 percent of the combined Ntds.dit and log files sizes or 1 gigabyte \(GB\).  
  
## Database defragmentation  
 During ordinary operation, you will delete objects from AD DS. When you delete an object, free \(unused\) disk space is created in the database. On a regular basis, the database consolidates this free disk space through a process called online defragmentation. This disk space will be reused when new objects are added \(without adding any size to the file itself\). This automatic online defragmentation redistributes and retains free disk space for use by the database, but does not release the disk space to the file system. Therefore, the database size does not shrink, even though objects might be deleted.  
  
 In cases in which the data decreases significantly, such as when the global catalog is removed from a domain controller, free disk space is not automatically returned to the file system. Although this condition does not affect database operation, it does result in large amounts of free disk space in the database. To decrease the size of the database file by returning free disk space from the database file to the file system, you can perform an offline defragmentation of the database. Whereas online defragmentation occurs automatically while AD DS is running, offline defragmentation requires taking the domain controller offline and using the Ntdsutil.exe command\-line tool to perform the procedure.  
  
> [!NOTE]  
>  NTFS disk compression is not supported for the database and log files.  
  
## Restartable AD DS  
 On domain controllers that are running Windows Server 2008, performing offline defragmentation and other database management tasks does not require a restart of the domain controller in Directory Services Restore Mode \(DSRM\). You can stop the AD DS service while you perform database management procedures. This feature, called restartable AD DS, eliminates the need to restart the domain controller when you perform certain database management tasks. Services that are running on the server that depend on AD DS to function shut down before AD DS shuts down. The following services stop when you stop AD DS:  
  
-   DNS Server service  
  
-   File Replication Service \(FRS\)  
  
-   Kerberos Key Distribution Center \(KDC\)  
  
-   Intersite Messaging  
  
-   Distributed File System \(DFS\) Replication  
  
 Other services that are running on the server and that do not depend on AD DS to function, such as Dynamic Host Configuration Protocol \(DHCP\), remain available to satisfy client requests while AD DS is stopped. For information about restartable AD DS, see Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\).  
  
## See Also  
 [Managing the Active Directory Database](../Topic/Managing-the-Active-Directory-Database.md)  
  
  