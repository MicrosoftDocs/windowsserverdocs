---
title: wbadmin restore catalog
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce1e24a0-821d-4353-b09d-8f82c5c4ad56
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin restore catalog



Recovers a backup catalog for the local computer from a storage location that you specify.

To recover a backup catalog with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt**, and then click **Run as administrator**.)

For examples of how to use this subcommand, see [Examples](#BKMK_examples).

## Syntax

```
wbadmin restore catalog
-backupTarget:{<BackupDestinationVolume> | <NetworkShareHostingBackup>}
[-machine:<BackupMachineName>]
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-backupTarget|Specifies the location of the backup catalog of the system as it was at the point after the backup was created.|
|-machine|Specifies the name of the computer that you want to recover the backup catalog for. Use when backups for multiple computers have been stored at the same location. Should be used when **-backupTarget** is specified.|
|-quiet|Runs the subcommand with no prompts to the user.|

## Remarks

If the location (disk, DVD, or remote shared folder) where you store your backups is damaged or lost and cannot be used to restore the backup catalog, use **wbadmin delete catalog** to delete the corrupted catalog. In this case, you should create a new backup once your backup catalog is deleted.

## <a name="BKMK_examples"></a>Examples

To restore a catalog from a backup stored on disk d:, type:
```
wbadmin restore catalog -backupTarget:d
```
To restore a catalog from a backup stored in the shared folder \\\\servername\share of server01, type:
```
wbadmin restore catalog -backupTarget:\\servername\share -machine:server01
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Restore-WBCatalog](https://technet.microsoft.com/library/jj902437.aspx) cmdlet