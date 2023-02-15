---
title: wbadmin start recovery
description: Reference article for the wbadmin start recovery command, which runs a recovery operation based on the parameters that you specify.
ms.topic: reference
ms.assetid: 52381316-a0fa-459f-b6a6-01e31fb21612
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin start recovery

Runs a recovery operation based on the parameters that you specify.

To perform a recovery using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

## Syntax

```
wbadmin start recovery -version:<VersionIdentifier> -items:{<VolumesToRecover> | <AppsToRecover> | <FilesOrFoldersToRecover>} -itemtype:{Volume | App | File} [-backupTarget:{<VolumeHostingBackup> | <NetworkShareHostingBackup>}] [-machine:<BackupMachineName>] [-recoveryTarget:{<TargetVolumeForRecovery> | <TargetPathForRecovery>}] [-recursive] [-overwrite:{Overwrite | CreateCopy | Skip}] [-notRestoreAcl] [-skipBadClusterCheck] [-noRollForward] [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -version | Specifies the version identifier of the backup to recover in MM/DD/YYYY-HH:MM format. If you don't know the version identifier, run the [wbadmin get versions command](wbadmin-get-versions.md). |
| -items | Specifies a comma-delimited list of volumes, apps, files, or folders to recover. You must use this parameter with the **-itemtype** parameter. |
| -itemtype | Specifies type of items to recover. Must be **Volume**, **App**, or **File**. If the **-itemtype** is *Volume*, you can specify only a single volume, by providing the volume drive letter, volume mount point, or GUID-based volume name. If the **-itemtype** is *App*, you can specify only a single application or you can use the value **ADIFM** to recover an installation of Active Directory. To be recovered, the app must have registered with Windows Server Backup. If the **-itemtype** is *File*, you can specify files or folders, but they should be part of the same volume and they should be under the same parent folder. |
| -backupTarget | Specifies the storage location that contains the backup that you want to recover. This parameter is useful when the location is different from where backups of this computer are usually stored. |
| -machine | Specifies the name of the computer that you want to recover the backup for. This parameter must be used when the **-backupTarget** parameter is specified. The **-machine** parameter is useful when multiple computers have been backed up to the same location. |
| -recoveryTarget | Specifies the location to restore to. This parameter is useful if this location is different than the location that was previously backed up. It can also be used for restorations of volumes, files, or apps. If you're restoring a volume, you can specify the volume drive letter of the alternate volume. If you're restoring a file or app, you can specify an alternate recovery location. |
| -recursive | Valid only when recovering files. Recovers the files in the folders and all files subordinate to the specified folders. By default, only files which reside directly in the specified folders are recovered. |
|-overwrite | Valid only when recovering files. Specifies the action to take when a file that is being recovered already exists in the same location. The valid options are:<ul><li>**Skip** - Causes Windows Server Backup to skip the existing file and continue with recovery of the next file.</li><li>**CreateCopy** - Causes Windows Server Backup to create a copy of the existing file so that the existing file is not modified.</li><li>**Overwrite** - Causes Windows Server Backup to overwrite the existing file with the file from the backup. |
| -notRestoreAcl | Valid only when recovering files. Specifies to not restore the security access control lists (ACLs) of the files being recovered from the backup. By default, the security ACLs are restored (the default value is **true**). If this parameter is used, the ACLs for the restored files will be inherited from the location to which the files are being restored. |
| -skipBadClusterCheck | Valid only when recovering volumes. Skips checking the disks you are recovering to for bad cluster information. If you are recovering to an alternate server or hardware, we recommend that you don't use this parameter. You can manually run the command **chkdsk /b** on these disks at any time to check them for bad clusters, and then update the file system information accordingly.<p>**Important:** Until you run **chkdsk /b**, the bad clusters reported on your recovered system might not be accurate. |
| -noRollForward | Valid only when recovering apps. Allows for previous point-in-time recovery of an app if you select the latest version from the backups. Previous point-in-time recovery is done as the default for all other non-latest versions of the app. |
| -quiet | Runs the command without prompts to the user. |

#### Remarks

- To view a list of items available to recover from a specific backup version, run the [wbadmin get items command](wbadmin-get-items.md). If a volume didn't have a mount point or drive letter at the time of backup, then this command returns a GUID-based volume name that should be used for recovering the volume.

- If you use a value of **ADIFM** to perform an install from media operation to recover the related data needed for Active Directory Domain Services, **ADIFM** creates a copy of the Active Directory database, registry, and SYSVOL state, and then saves this information in the location specified by **-recoveryTarget**. Use this parameter only when **-recoveryTarget** is specified.

## Examples

To run a recovery of the backup from March 31, 2020, taken at 9:00 A.M., of volume d:, type:

```
wbadmin start recovery -version:03/31/2020-09:00 -itemType:Volume -items:d:
```

To run a recovery to drive d of the backup from March 31, 2020, taken at 9:00 A.M., of the registry, type:

```
wbadmin start recovery -version:03/31/2020-09:00 -itemType:App -items:Registry -recoverytarget:d:\
```

To run a recovery of the backup from March 31, 2020, taken at 9:00 A.M., of the d:\folder and folders subordinate to d:\folder, type:

```
wbadmin start recovery -version:03/31/2020-09:00 -itemType:File -items:d:\folder -recursive
```

To run a recovery of the backup from March 31, 2020, taken at 9:00 A.M., of the volume `\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\`, type:

```
wbadmin start recovery -version:03/31/2020-09:00 -itemType:Volume -items:\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
```

To run a recovery of the backup from April 30, 2020, taken at 9:00 A.M., of the shared folder `\\servername\share` from server01, type:

```
wbadmin start recovery -version:04/30/2020-09:00 -backupTarget:\\servername\share -machine:server01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [Start-WBFileRecovery](/powershell/module/windowsserverbackup/start-wbfilerecovery)

- [Start-WBHyperVRecovery](/powershell/module/windowsserverbackup/start-wbhypervrecovery)

- [Start-WBSystemStateRecovery](/powershell/module/windowsserverbackup/start-wbsystemstaterecovery)

- [Start-WBVolumeRecovery](/powershell/module/windowsserverbackup/start-wbvolumerecovery)
