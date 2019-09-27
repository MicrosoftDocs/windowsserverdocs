---
title: wbadmin start sysrecovery
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 95b8232f-7c42-452b-838e-15b0cf6faebe
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin start sysrecovery



Performs a system recovery (bare metal recovery) using the parameters that you specify.

> [!NOTE]
> This subcommand can be run only from the Windows Recovery Environment, and it is not listed by default in the usage text of **Wbadmin**. For more information, see [Windows Recovery Environment (Windows RE) Overview](https://technet.microsoft.com/library/hh825173.aspx).

To perform a system recovery with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions.

For examples of how to use this subcommand, see [Examples](#BKMK_examples).

## Syntax

```
wbadmin start sysrecovery
-version:<VersionIdentifier>
-backupTarget:{<BackupDestinationVolume> | <NetworkShareHostingBackup>}
[-machine:<BackupMachineName>]
[-restoreAllVolumes]
[-recreateDisks]
[-excludeDisks]
[-skipBadClusterCheck]
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-version|Specifies the version identifier for the backup to recover in MM/DD/YYYY-HH:MM format. If you do not know the version identifier, type **wbadmin get versions**.|
|-backupTarget|Specifies the storage location that contains the backup or backups that you want to recover. This parameter is useful when the storage location is different from where backups of this computer are usually stored.|
|-machine|Specifies the name of the computer that you want to recover. This parameter is useful when multiple computers have been backed up to the same location. Should be used when the **-backupTarget** parameter is specified.|
|-restoreAllVolumes|Recovers all volumes from the selected backup. If this parameter is not specified, only critical volumes (volumes that contain the system state and operating system components) are recovered. This parameter is useful when you need to recover non-critical volumes during system recovery.|
|-recreateDisks|Recovers a disk configuration to the state that existed when the backup was created.</br>Warning: This parameter deletes all data on volumes that host operating system components. It might also delete data from data volumes.|
|-excludeDisks|Valid only when specified with the **-recreateDisks** parameter and must be input as a comma-delimited list of disk identifiers (as listed in the output of **wbadmin get disks**). Excluded disks are not partitioned or formatted. This parameter helps preserve data on disks that you do not want modified during the recovery operation.|
|-skipBadClusterCheck|Skips checking your recovery disks for bad cluster information. If you are restoring to an alternate server or hardware, we recommend that you do not use this parameter. You can manually run **chkdsk /b** on your recovery disks at any time to check them for bad clusters, and then update the file system information accordingly.</br>Warning: Until you run **chkdsk** as described, the bad clusters reported on your recovered system may not be accurate.|
|-quiet|Runs the command with no prompts to the user.|

## <a name="BKMK_examples"></a>Examples

To start recovering the information from the backup that was run on March 31, 2013 at 9:00 A.M., located on drive d:, type:
```
wbadmin start sysrecovery -version:03/31/2013-09:00 -backupTarget:d:
```
To start recovering the information from the backup that was run on April 30, 2013 at 9:00 A.M., located in the shared folder \\\\servername\shared: for server01, type:
```
wbadmin start sysrecovery -version:04/30/2013-09:00 -backupTarget:\\servername\share -machine:server01
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Get-WBBareMetalRecovery](https://technet.microsoft.com/library/jj902461.aspx) cmdlet