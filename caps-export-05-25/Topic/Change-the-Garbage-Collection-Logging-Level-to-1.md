---
title: Change the Garbage Collection Logging Level to 1
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 21cf40db-774e-42b4-baec-e150b98bdf75
author: Femila
---
# Change the Garbage Collection Logging Level to 1
  Garbage collection in Active Directory Domain Services \(AD DS\) is the process of removing deleted objects \(tombstones\) from the directory database. This process results in free disk space in the directory database. By default, this free space is not reported in Event Viewer. To see the amount of free disk space that can be made available to the file system by offline defragmentation, you can change the garbage collection logging level so that the disk space is reported in the Directory Service event log. After you change the logging level, check the Directory Service event log for Event ID 1646, which reports the amount of disk space that you can recover by performing offline defragmentation.  
  
 The garbage collection logging level is an NTDS diagnostics setting in the registry. You can use this procedure to change the garbage collection logging level to 1 so that you can view Event ID 1646 in Event Viewer.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!CAUTION]  
>  The Registry Editor bypasses standard safeguards, allowing settings that can damage your system or even require you to reinstall Windows. If you must edit the registry, back up system state first. For information about backing up system state, see [Introduction to Administering Active Directory Backup and Recovery](../Topic/Introduction-to-Administering-Active-Directory-Backup-and-Recovery.md).  
  
### To change the garbage collection logging level  
  
1.  Click **Start**, click **Run**, type **regedit**, and then press ENTER.  
  
2.  In Registry Editor, navigate to the **Garbage Collection** entry in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Diagnostics**.  
  
3.  Double\-click **Garbage Collection**. In the **Value data** box, type **1**, and then click **OK**.  
  
## See Also  
 [Compact the Directory Database File &#40;Offline Defragmentation&#41;](../Topic/Compact-the-Directory-Database-File--Offline-Defragmentation-.md)  
  
  