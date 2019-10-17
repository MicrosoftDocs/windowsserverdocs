---
title: wbadmin delete systemstatebackup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 707d37cb-448d-4542-b6ac-1fc89e749788
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin delete systemstatebackup



Deletes the system state backups that you specify. If the specified volume contains backups other than system state backups of your local server, those backups will not be deleted.

> [!NOTE]
> Windows Server Backup does not back up or recover registry user hives (HKEY_CURRENT_USER) as part of system state backup or system state recovery.

To delete a system state backup with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt**, and then click **Run as administrator**.)

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
wbadmin delete systemstatebackup
{-keepVersions:<NumberofCopies> | -version:<VersionIdentifier> | -deleteOldest}
[-backupTarget:<VolumeName>]
[-machine:<BackupMachineName>]
[-quiet]
```

> [!IMPORTANT]
> One and only one of these parameters must be specified: **-keepVersions**, **-version**, or **-deleteOldest**.

## Parameters

|Parameter|Description|
|---------|-----------|
|-keepVersions|Specifies the number of the latest system state backups to keep. The value must be a positive integer. The parameter value **-keepVersions:0** deletes all the system state backups.|
|-version|Specifies the version identifier of the backup in MM/DD/YYYY-HH:MM format. If you do not know the version identifier, type **wbadmin get versions**.</br>Versions that are exclusively system state backups can be deleted using this command. Use **wbadmin get items** to view the version type.|
|-deleteOldest|Deletes the oldest system state backup.|
|-backupTarget|Specifies the storage location for the backup that you want to delete. The storage location for backups of disks can be a drive letter, a mount point, or a GUID-based volume path. This value only needs to be specified for locating backups that are not of the local computer. Information about backups for the local computer will be available in the backup catalog on the local computer.|
|-machine|Specifies the computer whose system state backup you want to delete. Useful when multiple computers were backed up to the same location. Should be used when the **-backupTarget** parameter is specified.|
|-quiet|Runs the subcommand with no prompts to the user.|

## <a name="BKMK_examples"></a>Examples

To delete the system state backup created on March 31, 2013 at 10:00 AM, type:
```
wbadmin delete systemstatebackup -version:03/31/2013-10:00
```
To delete all system state backups, except the three most recent, type:
```
wbadmin delete systemstatebackup -keepVersions:3
```
To delete the oldest system state backup stored on disk f, type:
```
wbadmin delete systemstatebackup -backupTarget:f -deleteOldest
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)