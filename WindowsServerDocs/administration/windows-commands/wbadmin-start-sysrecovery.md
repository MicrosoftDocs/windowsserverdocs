---
title: wbadmin start sysrecovery
description: Reference article for the wbadmin start sysrecovery command, which performs a system recovery (bare metal recovery) using your specified parameters.
ms.topic: reference
ms.assetid: 95b8232f-7c42-452b-838e-15b0cf6faebe
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin start sysrecovery

Performs a system recovery (bare metal recovery) using your specified parameters.

To perform a system recovery using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions.

> [!IMPORTANT]
> The **wbadmin start sysrecovery** command must be run from the Windows Recovery Console, and isn't listed in the default usage text for the **wbadmin** tool. For more information, see [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

## Syntax

```
wbadmin start sysrecovery -version:<VersionIdentifier> -backupTarget:{<BackupDestinationVolume> | <NetworkShareHostingBackup>}  [-machine:<BackupMachineName>] [-restoreAllVolumes] [-recreateDisks] [-excludeDisks] [-skipBadClusterCheck] [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -version | Specifies the version identifier of the backup to recover in MM/DD/YYYY-HH:MM format. If you don't know the version identifier, run the [wbadmin get versions command](wbadmin-get-versions.md). |
| -backupTarget | Specifies the storage location that contains the backup(s) you want to recover. This parameter is useful when the storage location is different from where backups of this computer are usually stored. |
| -machine | Specifies the name of the computer that you want to recover the backup for. This parameter must be used when the **-backupTarget** parameter is specified. The **-machine** parameter is useful when multiple computers have been backed up to the same location. |
| -restoreAllVolumes | Recovers all volumes from the selected backup. If this parameter is not specified, only critical volumes (volumes that contain the system state and operating system components) are recovered. This parameter is useful when you need to recover non-critical volumes during system recovery. |
| -recreateDisks | Recovers a disk configuration to the state that existed when the backup was created.<p>**Warning:** This parameter deletes all data on volumes that host operating system components. It might also delete data from data volumes. |
| -excludeDisks | Valid only when specified with the **-recreateDisks** parameter and must be input as a comma-delimited list of disk identifiers (as listed in the output of the [wbadmin get disks command](wbadmin-get-disks.md)). Excluded disks aren't partitioned or formatted. This parameter helps preserve data on disks that you don't want modified during the recovery operation. |
| -skipBadClusterCheck | Valid only when recovering volumes. Skips checking the disks you are recovering to for bad cluster information. If you are recovering to an alternate server or hardware, we recommend that you don't use this parameter. You can manually run the command **chkdsk /b** on these disks at any time to check them for bad clusters, and then update the file system information accordingly.<p>**Important:** Until you run **chkdsk /b**, the bad clusters reported on your recovered system might not be accurate. |
| -quiet | Runs the command without prompts to the user. |

## Examples

To start recovering the information from the backup that was run on March 31, 2020 at 9:00 A.M., located on drive d:, type:

```
wbadmin start sysrecovery -version:03/31/2020-09:00 -backupTarget:d:
```

To start recovering the information from the backup that was run on April 30, 2020 at 9:00 A.M., located in the shared folder `\\servername\share` for server01, type:

```
wbadmin start sysrecovery -version:04/30/2020-09:00 -backupTarget:\\servername\share -machine:server01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [Get-WBBareMetalRecovery](/powershell/module/windowsserverbackup/get-wbbaremetalrecovery)
