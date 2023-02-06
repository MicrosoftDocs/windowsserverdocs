---
title: wbadmin get versions
description: Reference article for the wbadmin get versions command, which lists details about the available backups that are stored on the local computer or another computer.
ms.topic: reference
ms.assetid: b986acc4-d083-4d32-9434-862314ed5e97
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin get versions

Lists details about the available backups that are stored on the local computer or another computer. The details provided for a backup include the backup time, the backup storage location, the version identifier, and the type of recoveries you can perform.

To get details about available backups using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

If this command is used without parameters, it lists all backups of the local computer, even if those backups are not available.

## Syntax

```
wbadmin get versions [-backupTarget:{<BackupTargetLocation> | <NetworkSharePath>}] [-machine:BackupMachineName]
```

### Parameters

| Parameter | Description |
|--|--|
| -backupTarget | Specifies the storage location that contains the backups that you want the details for. Use for listing backups stored at that target location. Backup target locations can be locally attached disk drives, volumes, remote shared folders, removable media such as DVD drives or other optical media. If this command is run on the same computer where the backup was created, this parameter isn't needed. However, this parameter is required to get information about a backup created from another computer. |
| -machine | Specifies the computer that you want backup details for. Use when backups of multiple computers are stored in the same location. Should be used when **-backupTarget** is specified. |

## Examples

To see a list of available backups that are stored on volume H:, type:

```
wbadmin get versions -backupTarget:H:
```

To see a list of available backups that are stored in the remote shared folder `\\<servername>\<share>` for the computer server01, type:

```
wbadmin get versions -backupTarget:\\servername\share -machine:server01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin get items command](wbadmin-get-items.md)

- [Get-WBBackupTarget](/powershell/module/windowsserverbackup/get-wbbackuptarget)
