---
title: wbadmin delete catalog
description: Reference article for the wbadmin delete catalog command, which deletes the backup catalog that is stored on the local computer.
ms.topic: reference
ms.assetid: d3041407-4577-4716-a39f-2c8ab48818d1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin delete catalog

Deletes the backup catalog that is stored on the local computer. Use this command when the backup catalog has been corrupted and you can't restore it using the [wbadmin restore catalog](wbadmin-restore-catalog.md) command.

To delete a backup catalog using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

## Syntax

```
wbadmin delete catalog [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -quiet | Runs the command without prompts to the user. |

#### Remarks

- If you delete the backup catalog of a computer, you'll no longer be able to get to any backups created for that computer using the Windows Server Backup snap-in. However, if you can get to another backup location and run the [wbadmin restore catalog](wbadmin-restore-catalog.md) command, you can restore the backup catalog from that location.

- We strongly recommend you create a new backup after you delete a backup catalog.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin restore catalog command](wbadmin-restore-catalog.md)

- [Remove-WBCatalog](/powershell/module/windowsserverbackup/Remove-WBCatalog)
