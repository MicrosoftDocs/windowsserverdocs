---
title: Performing an Unscheduled Backup of a Domain Controller_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b7504cfe-ab08-4afc-9c0c-69a0a2585576
author: femila
---
# Performing an Unscheduled Backup of a Domain Controller_deleted
There are three types of backup that you can perform to back up Active Directory Domain Services \(AD DS\) on a domain controller. You can also use all three backup types to restore AD DS. A full server backup contains all volumes on the domain controller. To back up only the files that are required to recover AD DS, you can perform either a system state backup or a critical\-volumes backup:  
  
-   A system state backup creates a backup that is similar to a backup that you can create by using the Ntbackup tool in Windows Server 2003.  
  
-   A critical\-volumes backup includes all files that are stored on all volumes that contain system state files.  
  
A system state backup is not incremental. Therefore, each system state backup requires a similar amount of space. A critical\-volumes backup is incremental, which means that it includes only the difference between this backup and the previous backup. However, because the critical\-volumes backup can include other files in addition to the volumes that are required for system state, you can expect critical\-volume backups to increase over time with unnecessary files.  
  
To help manage the number of versions of system state backups that you store, you can use the **wbadmin delete systemstatebackup** command. For more information, see Wbadmin delete systemstatebackup \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111836](http://go.microsoft.com/fwlink/?LinkId=111836)\).  
  
## Requirements for performing domain controller backups  
  
-   The target volume for a critical\-volumes backup can be a local drive or network shared folder, but it cannot be any of the volumes that are included in the backup.  
  
-   If you use an external storage device for the backup, it must be connected to the domain controller that you are backing up.  
  
-   The target volume for a system state backup cannot be a network shared folder.  
  
-   The target volume for a system state backup cannot be the same volume that hosts any of the system state components by default. To change the default, you must add the **AllowSSBToAnyVolume** registry entry to the server. For more information, see [Known Issues for AD DS Backup and Recovery_deleted](../Topic/Known-Issues-for-AD-DS-Backup-and-Recovery_deleted.md).  
  
-   Do not store critical\-volume and system state backups on the same volume.  
  
-   Although Windows Server Backup appears on the **Administrative Tools** menu by default, you must add Windows Server Backup as a feature in Server Manager before you can use the tool. For more information, see [Installing Windows Server Backup_deleted](../Topic/Installing-Windows-Server-Backup_deleted.md).  
  
## Procedures for performing domain controller backups  
The procedures in this section provide instructions for performing unscheduled backups of all three backup types. You can use the Windows Server Backup snap\-in to perform unscheduled full server and critical\-volume backups. For information about performing scheduled backups, see [Scheduling Regular Full Server Backups of a Domain Controller_deleted](../Topic/Scheduling-Regular-Full-Server-Backups-of-a-Domain-Controller_deleted.md). For system state backups, you must use the Wbadmin.exe command\-line tool. You cannot use the Windows Server Backup snap\-in to back up system state.  
  
To perform backups on a domain controller, use the following procedures:  
  
-   [Perform a Backup of Critical Volumes of a Domain Controller by Using the GUI &#40;Windows Server Backup&#41;](../Topic/Perform-a-Backup-of-Critical-Volumes-of-a-Domain-Controller-by-Using-the-GUI--Windows-Server-Backup-.md)  
  
-   [Perform a System State Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-System-State-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md)  
  
-   [Perform a Full Server Backup of a Domain Controller by Using the GUI &#40;Windows Server Backup&#41;](../Topic/Perform-a-Full-Server-Backup-of-a-Domain-Controller-by-Using-the-GUI--Windows-Server-Backup-.md)  
  
-   [Perform a Full Server Backup of a Domain Controller by Using the Command Line &#40;Wbadmin&#41;](../Topic/Perform-a-Full-Server-Backup-of-a-Domain-Controller-by-Using-the-Command-Line--Wbadmin-.md)  
  
