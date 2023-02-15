---
title: wbadmin enable backup
description: Reference article for the wbadmin enable backup command, which creates and enables a daily backup schedule or modifies an existing backup schedule.
ms.topic: reference
ms.assetid: c0e57f8a-70fa-4c60-9754-e762e8ad8772
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin enable backup

Creates and enables a daily backup schedule or modifies an existing backup schedule. With no parameters specified, it displays the currently scheduled backup settings.

To configure or modify a daily backup schedule using this command, you must be a member of the **Backup Operators** group or the **Administrators** group. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

To view the disk identifier value for your disks, run the [wbadmin get disks](wbadmin-get-disks.md) command.

## Syntax

```
wbadmin enable backup [-addtarget:<BackupTarget>] [-removetarget:<BackupTarget>] [-schedule:<TimeToRunBackup>] [-include:<VolumesToInclude>] [-nonRecurseInclude:<ItemsToInclude>] [-exclude:<ItemsToExclude>] [-nonRecurseExclude:<ItemsToExclude>][-systemState] [-hyperv:<HyperVComponentsToExclude>] [-allCritical] [-systemState] [-vssFull | -vssCopy] [-user:<UserName>] [-password:<Password>] [-allowDeleteOldBackups]  [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -addtarget | Specifies the storage location for backups. Requires you to specify the location as a disk, volume, or Universal Naming Convention (UNC) path to a remote shared folder (`\\<servername>\<sharename>`). By default, the backup will be saved at: `\\<servername>\<sharename> WindowsImageBackup <ComputerBackedUp>`. If you specify a disk, the disk will be formatted before use, and any existing data on it is permanently erased. If you specify a shared folder, you can't add more locations. You can only specify one shared folder as a storage location at a time.<p>**Important:** If you save a backup to a remote shared folder, that backup is overwritten if you use the same folder to back up the same computer again. In addition, if the backup operation fails, you could end up with no backup because the older backup will be overwritten, but the newer backup won't be usable. You can avoid this by creating sub-folders in the remote shared folder to organize your backups. If you do this, the sub-folders need twice the space of the parent folder.<p>Only one location can be specified in a single command. Multiple volume and disk backup storage locations can be added by running the command again. |
| -removetarget | Specifies the storage location that you want to remove from the existing backup schedule. Requires you to specify the location as a disk identifier. |
| -schedule | Specifies times of day to create a backup, formatted as HH:MM and comma delimited. |
| -include | Specifies the comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should end with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. |
| -nonRecurseInclude | Specifies the non-recursive, comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should end with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. Should be used only when the **-backupTarget** parameter is used. |
| -exclude | Specifies the comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should end with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. |
| -nonRecurseExclude | Specifies the non-recursive, comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should end with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. |
| -hyperv | Specifies the comma-delimited list of components to be included in backup. The identifier can be a component name or component GUID (with or without braces). |
| -systemState | Creates a backup that includes the system state in addition to any other items that you specified with the **-include** parameter. The system state contains boot files (Boot.ini, NDTLDR, NTDetect.com), the Windows Registry including COM settings, the SYSVOL (Group Policies and Logon Scripts), the Active Directory and NTDS.DIT on domain controllers and, if the certificates service is installed, the Certificate Store. If your server has the Web server role installed, the IIS Metadirectory will be included. If the server is part of a cluster, Cluster service information is also included. |
| -allCritical | Specifies that all critical volumes (volumes that contain operating system's state) be included in the backups. This parameter is useful if you are creating a backup for full system or system state recovery. It should be used only when **-backupTarget** is specified; otherwise, the command fails. Can be used with the **-include** option.<p>**Tip:** The target volume for a critical-volume backup can be a local drive, but it can't be any of the volumes that are included in the backup. |
| -vssFull | Performs a full back up using the Volume Shadow Copy Service (VSS). All files are backed up, each file's history is updated to reflect that it was backed up, and the logs of previous backups may be truncated. If this parameter is not used, the [wbadmin start backup](wbadmin-start-backup.md) command makes a copy backup, but the history of files being backed up is not updated.<p>**Caution:** Don't use this parameter if you're using a product other than Windows Server Backup to back up apps that are on the volumes included in the current backup. Doing so can potentially break the incremental, differential, or other type of backups that the other backup product is creating because the history that they are relying on to determine how much data to backup might be missing and they might perform a full backup unnecessarily. |
| -vssCopy | Performs a copy backup using VSS. All files are backed up but the history of the files being backup up is not updated so you preserve the all the information on which files where changed, deleted, and so on, as well as any application log files. Using this type of backup does not affect the sequence of incremental and differential backups that might happen independent of this copy backup. This is the default value.<p>**Warning:** A backup copy can't be used for incremental or differential backups or restores. |
| -user | Specifies the user with write permission to the backup storage destination (if it's a remote shared folder). The user needs to be a member of the **Administrators** or **Backup Operators** group on the computer getting backed up. |
| -password | Specifies the password for the user name provided by the parameter **-user**. |
| -allowDeleteOldBackups | Overwrites any backups made before the computer was upgraded. |
| -quiet | Runs the command without prompts to the user. |

## Examples

To schedule daily backups at 9:00 AM and 6:00 PM for hard disk drives E:, D:\mountpoint, and `\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\`, and to save the files to the disk named, DiskID, type:

```
wbadmin enable backup -addtarget:DiskID -schedule:09:00,18:00 -include:E:,D:\mountpoint,\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
```

To schedule daily backups of the D:\documents folder at 12:00 AM and 7:00 PM to the network location `\\backupshare\backup1`, using the network credentials for the **Backup Operator**, Aaren Ekelund (aekel), who's password is *$3hM9^5lp* and who is a member of the domain CONTOSOEAST, used to authenticate access to the network share, type:

```
wbadmin enable backup –addtarget:\\backupshare\backup1 –include: D:\documents –user:CONTOSOEAST\aekel –password:$3hM9^5lp –schedule:00:00,19:00
```

To schedule daily backups of volume T: and the D:\documents folder at 1:00 AM to drive H:, excluding the folder `d:\documents\~tmp`, and performing a full backup using the Volume Shadow Copy Service, type:

```
wbadmin enable backup –addtarget:H: –include T:,D:\documents –exclude D:\documents\~tmp –vssfull –schedule:01:00
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)

- [wbadmin enable backup command](wbadmin-enable-backup.md)

- [wbadmin start backup command](wbadmin-start-backup.md)

- [wbadmin get disks command](wbadmin-get-disks.md)
