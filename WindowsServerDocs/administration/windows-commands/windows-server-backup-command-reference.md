---
title: Windows Server Backup Command Reference
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 03de0a65-21f0-4dd7-a3ae-251c98bbf6eb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Windows Server Backup Command Reference

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The following subcommands for **wbadmin** provide backup and recovery functionality from a command prompt.
To configure a backup schedule, you must be a member of the **Administrators** group. To perform all other tasks with this command, you must be a member of the **Backup Operators** or the **Administrators** group, or you must have been delegated the appropriate permissions.
You must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt, click **start**, right-click **Command prompt**, and then click **Run as administrator**.)
|Subcommand|Description|
|-------|--------|
|[wbadmin enable backup](wbadmin-enable-backup.md)|Configures and enables a daily backup schedule.|
|[wbadmin disable backup](wbadmin-disable-backup.md)|Disables your daily backups.|
|[wbadmin start backup](wbadmin-start-backup.md)|Runs a one-time backup. If used with no parameters, uses the settings from the daily backup schedule.|
|[wbadmin stop job](wbadmin-stop-job.md)|Stops the currently running backup or recovery operation.|
|[wbadmin get versions](wbadmin-get-versions.md)|lists details of backups recoverable from the local computer or, if another location is specified, from another computer.|
|[wbadmin get items](wbadmin-get-items.md)|lists the items included in a specific backup.|
|[wbadmin start recovery](wbadmin-start-recovery.md)|Runs a recovery of the volumes, applications, files, or folders specified.|
|[wbadmin get status](wbadmin-get-status.md)|Shows the status of the currently running backup or recovery operation.|
|[wbadmin get disks](wbadmin-get-disks.md)|lists disks that are currently online.|
|[wbadmin start systemstaterecovery](wbadmin-start-systemstaterecovery.md)|Runs a system state recovery.|
|[wbadmin start systemstatebackup](wbadmin-start-systemstatebackup.md)|Runs a system state backup.|
|[wbadmin delete systemstatebackup](wbadmin-delete-systemstatebackup.md)|deletes one or more system state backups.|
|[wbadmin start sysrecovery](wbadmin-start-sysrecovery.md)|Runs a recovery of the full system (at least all the volumes that contain the operating system's state). This subcommand is only available if you are using the Windows recovery Environment.|
|[wbadmin restore catalog](wbadmin-restore-catalog.md)|recovers a backup catalog from a specified storage location in the case where the backup catalog on the local computer has been corrupted.|
|[wbadmin delete catalog](wbadmin-delete-catalog.md)|deletes the backup catalog on the local computer. Use this command only if the backup catalog on this computer is corrupted and you have no backups stored at another location that you can use to restore the catalog.|
