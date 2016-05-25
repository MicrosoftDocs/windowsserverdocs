---
title: Windows Server Backup Command Reference
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 03de0a65-21f0-4dd7-a3ae-251c98bbf6eb
---
# Windows Server Backup Command Reference
The following subcommands for **wbadmin** provide backup and recovery functionality from a command prompt.  
  
To configure a backup schedule, you must be a member of the **Administrators** group. To perform all other tasks with this command, you must be a member of the **Backup Operators** or the **Administrators** group, or you must have been delegated the appropriate permissions.  
  
You must run **wbadmin** from an elevated command prompt. \(To open an elevated command prompt, click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.\)  
  
|Subcommand|Description|  
|--------------|---------------|  
|[Wbadmin enable backup](../Topic/Wbadmin-enable-backup.md)|Configures and enables a daily backup schedule.|  
|[Wbadmin disable backup](../Topic/Wbadmin-disable-backup.md)|Disables your daily backups.|  
|[Wbadmin start backup](../Topic/Wbadmin-start-backup.md)|Runs a one\-time backup. If used with no parameters, uses the settings from the daily backup schedule.|  
|[Wbadmin stop job](../Topic/Wbadmin-stop-job.md)|Stops the currently running backup or recovery operation.|  
|[Wbadmin get versions](../Topic/Wbadmin-get-versions.md)|Lists details of backups recoverable from the local computer or, if another location is specified, from another computer.|  
|[Wbadmin get items](../Topic/Wbadmin-get-items.md)|Lists the items included in a specific backup.|  
|[Wbadmin start recovery](../Topic/Wbadmin-start-recovery.md)|Runs a recovery of the volumes, applications, files, or folders specified.|  
|[Wbadmin get status](../Topic/Wbadmin-get-status.md)|Shows the status of the currently running backup or recovery operation.|  
|[Wbadmin get disks](../Topic/Wbadmin-get-disks.md)|Lists disks that are currently online.|  
|[Wbadmin start systemstaterecovery](../Topic/Wbadmin-start-systemstaterecovery.md)|Runs a system state recovery.|  
|[Wbadmin start systemstatebackup](../Topic/Wbadmin-start-systemstatebackup.md)|Runs a system state backup.|  
|[Wbadmin delete systemstatebackup](../Topic/Wbadmin-delete-systemstatebackup.md)|Deletes one or more system state backups.|  
|[Wbadmin start sysrecovery](../Topic/Wbadmin-start-sysrecovery.md)|Runs a recovery of the full system \(at least all the volumes that contain the operating system's state\). This subcommand is only available if you are using the Windows Recovery Environment.|  
|[Wbadmin restore catalog](../Topic/Wbadmin-restore-catalog.md)|Recovers a backup catalog from a specified storage location in the case where the backup catalog on the local computer has been corrupted.|  
|[Wbadmin delete catalog](../Topic/Wbadmin-delete-catalog.md)|Deletes the backup catalog on the local computer. Use this command only if the backup catalog on this computer is corrupted and you have no backups stored at another location that you can use to restore the catalog.|  
  
