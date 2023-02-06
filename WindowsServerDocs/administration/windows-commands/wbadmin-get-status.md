---
title: wbadmin get status
description: Reference article for the wbadmin get status command, which reports the status of the backup or recovery operation that is currently running.
ms.topic: reference
ms.assetid: 2911b944-7b95-46aa-8c1e-1d55a2fcc94c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin get status

Reports the status of the backup or recovery operation that is currently running.

To get the status of the currently running backup or recovery operation using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

> [!IMPORTANT]
> This command doesn't stop until the backup or recovery operation is finished. The command continues to run even if you close the command window. To stop the current backup or recovery operation, run the [wbadmin stop job](wbadmin-stop-job.md) command.

## Syntax

```
wbadmin get status
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin stop job command](wbadmin-stop-job.md)

- [Get-WBJob](/powershell/module/windowsserverbackup/get-wbjob)
