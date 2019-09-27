---
title: wbadmin get items
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 27d08ce3-6e06-4260-b264-fc1bde132d09
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin get items



Lists the items included in a specific backup.

To use this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt** and then click **Run as administrator**.)

For examples of how to use this subcommand, see [Examples](#BKMK_examples).

## Syntax

```
wbadmin get items
-version:<VersionIdentifier>
[-backupTarget:{<BackupDestinationVolume> | <NetworkSharePath>}]
[-machine:<BackupMachineName>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-version|Specifies the version of the backup in MM/DD/YYYY-HH:MM format. If you do not know the version information, type **wbadmin get versions**.|
|-backupTarget|Specifies the storage location that contains the backups for which you want the details. Use for listing backups stored at that target location. Backup target locations can be a locally attached disk drive or a remote shared folder. If **wbadmin get items**is run on the same computer where the backup was created, this parameter is not needed. However, this parameter is required to get information about a backup created from another computer.|
|-machine|Specifies the name of the computer that you want the backup details for. Useful when multiple computers have been backed up to the same location. Should be used when **-backupTarget** is specified.|

## <a name="BKMK_examples"></a>Examples

To list items from the backup that was run on March 31, 2013 at 9:00 A.M., type:
```
wbadmin get items -version:03/31/2013-09:00
```
To list items from the backup of server01 that was run on April 30, 2013 at 9:00 A.M. and stored on \\\\servername\share, type:
```
wbadmin get items -version:04/30/2013-09:00 -backupTarget:\\servername\share -machine:server01
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Get-WBBackupSet](https://technet.microsoft.com/library/jj902473.aspx) cmdlet