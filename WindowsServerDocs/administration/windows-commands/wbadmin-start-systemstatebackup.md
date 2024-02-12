---
title: wbadmin start systemstatebackup
description: Reference article for the wbadmin start systemstatebackup command, which creates a system state backup of the local computer and stores it on the location specified.
ms.topic: reference
ms.assetid: 998366c1-0a64-45e6-9ed3-4c3f5b8406f0
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin start systemstatebackup

Creates a system state backup of the local computer and stores it on the location specified.

To perform a system state backup using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

> [!NOTE]
> Windows Server Backup doesn't back up or recover registry user hives (HKEY_CURRENT_USER) as part of system state backup or system state recovery.

## Syntax

```
wbadmin start systemstatebackup -backupTarget:<VolumeName> [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -backupTarget | Specifies the location where you want to store the backup. The storage location requires a drive letter or a GUID-based volume of the format: `\\?\Volume{*GUID*}`. Use the command `-backuptarget:\\servername\sharedfolder\` to store system state backups. |
| -quiet | Runs the command without prompts to the user. |

## Examples

To create a system state backup and store it on volume f, type:

```
wbadmin start systemstatebackup -backupTarget:f:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [Start-WBBackup](/powershell/module/windowsserverbackup/start-wbbackup)
