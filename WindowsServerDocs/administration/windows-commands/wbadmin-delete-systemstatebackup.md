---
title: wbadmin delete systemstatebackup
description: Reference article for the wbadmin delete systemstatebackup command, which deletes the system state backups that you specify.
ms.topic: reference
ms.assetid: 707d37cb-448d-4542-b6ac-1fc89e749788
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin delete systemstatebackup

Deletes the system state backups that you specify. If the specified volume contains backups other than system state backups of your local server, those backups will not be deleted.

To delete a system state backup using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

> [!NOTE]
> Windows Server Backup does not back up or recover registry user hives (HKEY_CURRENT_USER) as part of system state backup or system state recovery.

## Syntax

```
wbadmin delete systemstatebackup {-keepVersions:<numberofcopies> | -version:<versionidentifier> | -deleteoldest} [-backupTarget:<volumename>] [-machine:<backupmachinename>] [-quiet]
```

> [!IMPORTANT]
> You must only specify one of these parameters: **-keepVersions**, **-version**, or **-deleteOldest**.

### Parameters

| Parameter | Description |
|--|--|
| -keepVersions | Specifies the number of the latest system state backups to keep. The value must be a positive integer. The parameter value **-keepversions:0** deletes all the system state backups. |
| -version | Specifies the version identifier of the backup in MM/DD/YYYY-HH:MM format. If you don't know the version identifier, run the [wbadmin get versions](wbadmin-get-versions.md) command.<p>Versions made up of exclusively system state backups can be deleted using this command. Run the [wbadmin get items](wbadmin-get-items.md) command to view the version type. |
| -deleteOldest | Deletes the oldest system state backup. |
| -backupTarget | Specifies the storage location for the backup that you want to delete. The storage location for disk backups can be a drive letter, a mount point, or a GUID-based volume path. This value only needs to be specified for locating backups that are not on the local computer. Information about backups for the local computer is available in the backup catalog on the local computer. |
| -machine | Specifies the computer whose system state backup you want to delete. Useful when multiple computers were backed up to the same location. Should be used when the **-backupTarget** parameter is specified. |
| -quiet | Runs the command without prompts to the user. |

## Examples

To delete the system state backup created on March 31, 2013 at 10:00 AM, type:

```
wbadmin delete systemstatebackup -version:03/31/2013-10:00
```

To delete all system state backups, except the three most recent, type:

```
wbadmin delete systemstatebackup -keepVersions:3
```

To delete the oldest system state backup stored on disk f:, type:

```
wbadmin delete systemstatebackup -backupTarget:f:\ -deleteOldest
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin get versions command](wbadmin-get-versions.md)

- [wbadmin get items command](wbadmin-get-items.md)
