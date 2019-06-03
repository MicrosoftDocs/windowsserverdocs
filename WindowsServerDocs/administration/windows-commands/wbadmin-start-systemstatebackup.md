---
title: wbadmin start systemstatebackup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 998366c1-0a64-45e6-9ed3-4c3f5b8406f0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin start systemstatebackup



Creates a system state backup of the local computer and stores it on the location specified.

> [!NOTE]
> Windows Server Backup does not back up or recover registry user hives (HKEY_CURRENT_USER) as part of system state backup or system state recovery.

To perform a system state backup with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt**, and then click **Run as administrator**.)

For examples of how to use this subcommand, see [Examples](#BKMK_examples).

## Syntax

```
wbadmin start systemstatebackup
-backupTarget:<VolumeName>
[-quiet]
```

## Parameters

|   Parameter   |                                                                                                                                                                                                                      Description                                                                                                                                                                                                                      |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| -backupTarget | Specifies the location where you want to store the backup. The storage location requires a drive letter or a GUID-based volume of the format: \\\\?\Volume{*GUID*}.</br>A system state backup to a shared network folder is not supported on a computer running Windows Server 2008. If your server is running Windows Server 2008 R2 or later you can use the command **-backuptarget:\\\\servername\sharedFolder\\** to store system state backups. |
|    -quiet     |                                                                                                                                                                                                   Runs the subcommand with no prompts to the user.                                                                                                                                                                                                    |

## Remarks

For information about saving a system state backup to a volume that, in turn, contains system state files, see article 944530 in the Microsoft Knowledge Base ([https://go.microsoft.com/fwlink/?LinkId=110439](https://go.microsoft.com/fwlink/?LinkId=110439)).

## <a name="BKMK_examples"></a>Examples

To create a system state backup and store it on volume f, type:
```
wbadmin start systemstatebackup -backupTarget:f:
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Start-WBBackup](https://technet.microsoft.com/library/jj902459.aspx) cmdlet