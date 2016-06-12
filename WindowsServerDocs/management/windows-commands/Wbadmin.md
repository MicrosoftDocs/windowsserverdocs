---
title: wbadmin
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4b0b3f32-d21f-4861-84bb-b2eadbf1e7b8
---
# wbadmin
Enables you to back up and restore your operating system, volumes, files, folders, and applications from a command prompt.  
  
To configure a regularly scheduled backup, you must be a member of the **Administrators** group. To perform all other tasks with this command, you must be a member of the **Backup Operators** or the **Administrators** group, or you must have been delegated the appropriate permissions.  
  
You must run **wbadmin** from an elevated command prompt. \(To open an elevated command prompt, right\-click **Command prompt**, and then click **Run as administrator**.\)  
  
## Subcommands  
  
|Subcommand|Description|  
|--------------|---------------|  
|[wbadmin enable backup]()|Configures and enables a regularly scheduled backup.|  
|[wbadmin disable backup]()|Disables your daily backups.|  
|[wbadmin start backup]()|Runs a one\-time backup. if used with no parameters, uses the settings from the daily backup schedule.|  
|[wbadmin stop job]()|Stops the currently running backup or recovery operation.|  
|[wbadmin get versions]()|lists details of backups recoverable from the local computer or, if another location is specified, from another computer.|  
|[wbadmin get items]()|lists the items included in a backup.|  
|[wbadmin start recovery]()|Runs a recovery of the volumes, applications, files, or folders specified.|  
|[wbadmin get status]()|Shows the status of the currently running backup or recovery operation.|  
|[wbadmin get disks]()|lists disks that are currently online.|  
|[wbadmin start systemstaterecovery]()|Runs a system state recovery.|  
|[wbadmin start systemstatebackup]()|Runs a system state backup.|  
|[wbadmin delete systemstatebackup]()|deletes one or more system state backups.|  
|[wbadmin start sysrecovery]()|Runs a recovery of the full system \(at least all the volumes that contain the operating system's state\). This subcommand  is only available if you are using the Windows recovery Environment.|  
|[wbadmin restore catalog]()|recovers a backup catalog from a specified storage location in the case where the backup catalog on the local computer has been corrupted.|  
|[wbadmin delete catalog]()|deletes the backup catalog on the local computer. Use this subcommand only if the backup catalog on this computer is corrupted and you have no backups stored at another location that you can use to restore the catalog.|  
  
## additional references  
  
-   [Backup and recovery](http://go.microsoft.com/fwlink/?LinkID=195054)  
  
-   [Windows Server Backup cmdlets in Windows powershell](http://technet.microsoft.com/library/jj902428.aspx)  
  

