---
title: wbadmin start systemstaterecovery
description: Reference article for the wbadmin start systemstaterecovery command, which performs a system state recovery to a location, and from a backup, that you specify.
ms.topic: reference
ms.assetid: 208b1be9-3452-4aba-bb49-46bc587fca96
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin start systemstaterecovery

Performs a system state recovery to a location and from a backup that you specify.

To perform a system state recovery using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

> [!NOTE]
> Windows Server Backup doesn't back up or recover registry user hives (HKEY_CURRENT_USER) as part of system state backup or system state recovery.

## Syntax

```
wbadmin start systemstaterecovery -version:<VersionIdentifier> -showsummary [-backupTarget:{<BackupDestinationVolume> | <NetworkSharePath>}]
[-machine:<BackupMachineName>] [-recoveryTarget:<TargetPathForRecovery>] [-authsysvol] [-autoReboot] [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -version | Specifies the version identifier of the backup to recover in MM/DD/YYYY-HH:MM format. If you don't know the version identifier, run the [wbadmin get versions command](wbadmin-get-versions.md). |
| -showsummary | Reports the summary of the last system state recovery (after the restart required to finish the operation). This parameter can't be accompanied by any other parameters. |
| -backupTarget | Specifies the storage location with the backup(s) you want to recover. This parameter is useful when the storage location is different from where backups are usually stored. |
| -machine | Specifies the name of the computer to recover the backup for. This parameter must be used when the **-backupTarget** parameter is specified. The **-machine** parameter is useful when multiple computers have been backed up to the same location. |
| -recoveryTarget | Specifies what directory to restore to. This parameter is useful if the backup is restored to an alternate location. |
| -authsysvol | Performs an authoritative restore of the System Volume (sysvol) shared directory. |
| -autoReboot | Specifies to restart the system at the end of the system state recovery operation. This parameter is valid only for a recovery to the original location. We don't recommend you use this parameter if you need to perform steps after the recovery operation. |
| -quiet | Runs the command without prompts to the user. |

## Examples

To start a system state recovery of the backup from 03/31/2020 at 9:00 A.M., type:

```
wbadmin start systemstaterecovery -version:03/31/2020-09:00
```

To start a system state recovery of the backup from 04/30/2020 at 9:00 A.M. that is stored on the shared resource `\\servername\share` for server01, type:

```
wbadmin start systemstaterecovery -version:04/30/2013-09:00 -backupTarget:\\servername\share -machine:server01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [Start-WBSystemStateRecovery](/powershell/module/windowsserverbackup/start-wbsystemstaterecovery)
