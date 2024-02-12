---
title: wbadmin restore catalog
description: Reference article for the wbadmin restore catalog command, which recovers a backup catalog for the local computer from a storage location that you specify.
ms.topic: reference
ms.assetid: ce1e24a0-821d-4353-b09d-8f82c5c4ad56
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin restore catalog

Recovers a backup catalog for the local computer from a storage location that you specify.

To recover a backup catalog included in a specific backup using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

> [!NOTE]
> If the location (disk, DVD, or remote shared folder) where you store your backups is damaged or lost and can't be used to restore the backup catalog, run the [wbadmin delete catalog](wbadmin-delete-catalog.md) command to delete the corrupted catalog. In this case, we recommend creating a new backup after your backup catalog is deleted.

## Syntax

```
wbadmin restore catalog -backupTarget:{<BackupDestinationVolume> | <NetworkShareHostingBackup>} [-machine:<BackupMachineName>] [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -backupTarget | Specifies the location of the backup catalog of the system as it was at the point after the backup was created. |
| -machine | Specifies the name of the computer that you want to recover the backup catalog for. Use when backups for multiple computers have been stored at the same location. Should be used when **-backupTarget** is specified. |
| -quiet | Runs the command without prompts to the user. |

## Examples

To restore a catalog from a backup stored on disk D:, type:

```
wbadmin restore catalog -backupTarget:D
```

To restore a catalog from a backup stored in the shared folder `\\<servername>\<share>` of server01, type:

```
wbadmin restore catalog -backupTarget:\\servername\share -machine:server01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin delete catalog command](wbadmin-delete-catalog.md)

- [Restore-WBCatalog](/powershell/module/windowsserverbackup/restore-wbcatalog)
