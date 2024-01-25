---
title: wbadmin
description: Reference article for the wbadmin commands, which lets you back up and restore your operating system, volumes, files, folders, and applications from a command prompt.
ms.topic: reference
ms.assetid: 4b0b3f32-d21f-4861-84bb-b2eadbf1e7b8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin

Enables you to back up and restore your operating system, volumes, files, folders, and applications from a command prompt.

To configure a regularly scheduled backup using this command, you must be a member of the **Administrators** group. To perform all other tasks with this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions.

You must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

## Parameters

| Parameter | Description |
|--|--|
| [wbadmin delete catalog](wbadmin-delete-catalog.md) | Deletes the backup catalog on the local computer. Use this command only if the backup catalog on this computer is corrupted and you have no backups stored at another location that you can use to restore the catalog. |
| [wbadmin delete systemstatebackup](wbadmin-delete-systemstatebackup.md) | Deletes one or more system state backups. |
| [wbadmin disable backup](wbadmin-disable-backup.md) | Disables your daily backups. |
| [wbadmin enable backup](wbadmin-enable-backup.md) | Configures and enables a regularly scheduled backup. |
| [wbadmin get disks](wbadmin-get-disks.md) | Lists disks that are currently online. |
| [wbadmin get items](wbadmin-get-items.md) | Lists the items included in a backup. |
| [wbadmin get status](wbadmin-get-status.md) | Shows the status of the currently running backup or recovery operation. |
| [wbadmin get versions](wbadmin-get-versions.md) | Lists details of backups recoverable from the local computer or, if another location is specified, from another computer. |
| [wbadmin restore catalog](wbadmin-restore-catalog.md) | Recovers a backup catalog from a specified storage location in the case where the backup catalog on the local computer has been corrupted. |
| [wbadmin start backup](wbadmin-start-backup.md) | Runs a one-time backup. If used with no parameters, uses the settings from the daily backup schedule. |
| [wbadmin start recovery](wbadmin-start-recovery.md) | Runs a recovery of the volumes, applications, files, or folders specified. |
| [wbadmin start sysrecovery](wbadmin-start-sysrecovery.md) | Runs a recovery of the full system (at least all the volumes that contain the operating system's state). This command  is only available if you are using the Windows Recovery Environment. |
| [wbadmin start systemstatebackup](wbadmin-start-systemstatebackup.md) | Runs a system state backup. |
| [wbadmin start systemstaterecovery](wbadmin-start-systemstaterecovery.md) | Runs a system state recovery. |
| [wbadmin stop job](wbadmin-stop-job.md) | Stops the currently running backup or recovery operation. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Windows Server Backup Cmdlets in Windows PowerShell](/powershell/module/windowsserverbackup)

- [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference)
