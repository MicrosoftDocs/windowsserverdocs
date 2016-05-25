---
title: Returning Unused Disk Space from the Active Directory Database to the File System
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5c495ab9-d732-4831-9d6b-eca6f98ac18a
author: Femila
---
# Returning Unused Disk Space from the Active Directory Database to the File System
  During ordinary operation, the free disk space in the Active Directory database file becomes fragmented. Each time garbage collection runs \(every 12 hours, by default\), free disk space is automatically defragmented online to optimize its use within the database file. The unused disk space is maintained for the database; it is not returned to the file system.  
  
 Only offline defragmentation can return unused disk space from the directory database to the file system. When database contents have decreased considerably through a bulk deletion \(for example, when you remove the global catalog from a domain controller\), or if the size of the database backup is significantly increased as a result of the amount of free disk space, use offline defragmentation to reduce the size of the Ntds.dit file.  
  
 You can determine how much free disk space is recoverable from the Ntds.dit file by setting the garbage collection logging level in the registry. Changing the garbage collection logging level from the default value of **0** to a value of **1** results in event ID 1646 being logged in the directory service log. This event describes the total amount of disk space that the database file uses as well as the amount of free disk space that is recoverable from the Ntds.dit file through offline defragmentation.  
  
 At garbage collection logging level 0, only critical events and error events are logged in the Directory Service log. These events include Event IDs 700 and 701, which report when online defragmentation begins and ends, respectively. At level 1, higher\-level events are logged as well. At level 1, Event ID 1646 is also reported, which indicates the amount of free space that is available in the database relative to the amount of allocated space.  
  
> [!CAUTION]  
>  Setting the value of entries in the Diagnostics subkey to greater than 3 can degrade server performance and is not recommended.  
  
 On domain controllers that are running Windows Server 2008, offline defragmentation does not require restarting the domain controller in Directory Services Restore Mode \(DSRM\), as is required on domain controllers that are running versions of Windows Server 2000 and Windows Server 2003. You can use a new feature in Windows Server 2008, restartable Active Directory Domain Services \(AD DS\), to stop the AD DS service. When the service is stopped, services that depend on AD DS shut down automatically. However, any other services that are running on the domain controller, such as Dynamic Host Configuration Protocol \(DHCP\), continue to run and respond to clients. For more information about restartable AD DS, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\).  
  
 After offline defragmentation completes, perform a database integrity check. The **integrity** command in Ntdsutil.exe detects binary\-level database corruption by reading every byte in the database file. This process ensures that the correct headers exist in the database itself and that all of the tables are functioning and consistent. Therefore, depending on the size of your Ntds.dit file and the domain controller hardware, the process might take considerable time. In testing environments, the speed of 2 gigabytes \(GB\) per hour is considered to be typical. When you run the command, an online graph displays the percentage completed.  
  
 If the database integrity check fails, you must perform semantic database analysis.  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Regedit.exe  
  
-   Windows Server Backup  
  
-   Ntdsutil.exe  
  
 To complete this task, perform the following procedures:  
  
1.  [Change the Garbage Collection Logging Level to 1](../Topic/Change-the-Garbage-Collection-Logging-Level-to-1.md)  
  
2.  Perform a System State Backup of a Domain Controller by Using the Command Line \(Wbadmin\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=118357](http://go.microsoft.com/fwlink/?LinkId=118357)\)  
  
3.  [Compact the Directory Database File &#40;Offline Defragmentation&#41;](../Topic/Compact-the-Directory-Database-File--Offline-Defragmentation-.md)  
  
     As part of the offline defragmentation procedure, check directory database integrity.  
  
4.  [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md)  
  
  