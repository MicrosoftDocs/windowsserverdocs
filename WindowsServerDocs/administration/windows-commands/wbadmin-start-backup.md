---
title: wbadmin start backup
description: Reference article for the wbadmin start backup command, which creates a backup using specified parameters.
ms.topic: reference
ms.assetid: 56f3e752-d99a-4c3d-8e97-10303c37dd78
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wbadmin start backup

Creates a backup using specified parameters. If no parameters are specified and you have created a scheduled daily backup, this command creates the backup by using the settings for the scheduled backup. If parameters are specified, it creates a Volume Shadow Copy Service (VSS) copy backup and won't update the history of the files that are being backed up.

To create a one-time backup using this command, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt, by right-clicking **Command Prompt**, and then selecting **Run as administrator**.

## Syntax

```com
wbadmin start backup [-backupTarget:{<BackupTargetLocation> | <TargetNetworkShare>}] [-include:<ItemsToInclude>] [-nonRecurseInclude:<ItemsToInclude>] [-exclude:<ItemsToExclude>] [-nonRecurseExclude:<ItemsToExclude>] [-allCritical] [-systemState] [-noVerify] [-user:<UserName>] [-password:<Password>] [-noInheritAcl] [-vssFull | -vssCopy] [-quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| -backupTarget | Specifies the storage location for this backup. Requires a hard disk drive letter (f:), a volume GUID-based path in the format of `\\?\Volume{GUID}`, or a Universal Naming Convention (UNC) path to a remote shared folder `(\\<servername>\<sharename>\)`. By default, the backup will be saved at: `\\<servername>\<sharename>\WindowsImageBackup\<ComputerBackedUp>\`. |
| -include | Specifies the comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. The **-include** parameter should only be used in conjunction with the **-backupTarget** parameter. |
| -exclude | Specifies the comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. The **-exclude** parameter should only be used in conjunction with the **-backupTarget** parameter. |
| -nonRecurseInclude | Specifies the non-recursive, comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. The **-nonRecurseInclude** parameter should only be used in conjunction with the **-backupTarget** parameter. |
| -nonRecurseExclude | Specifies the non-recursive, comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (`\`). You can use the wildcard character (`*`) in the file name when specifying a path to a file. The **-nonRecurseExclude** parameter should only be used in conjunction with the **-backupTarget** parameter. |
| -allCritical | Specifies that all critical volumes (volumes that contain operating system's state) be included in the backups. This parameter is useful if you're creating a backup for bare metal recovery. It should be used only when **-backupTarget** is specified, otherwise the command fails. Can be used with the **-include** option.<p>**Tip:** The target volume for a critical-volume backup can be a local drive, but it Can't be any of the volumes that are included in the backup. |
| -systemState | Creates a backup that includes the system state in addition to any other items that you specified with the **-include** parameter. The system state contains boot files (Boot.ini, NDTLDR, NTDetect.com), the Windows Registry including COM settings, the SYSVOL (Group Policies and Logon Scripts), the Active Directory and NTDS.DIT on Domain Controllers and, if the certificates service is installed, the Certificate Store. If your server has the Web server role installed, the IIS Metadirectory will be included. If the server is part of a cluster, Cluster Service information will also be included. |
| -noVerify | Specifies that backups saved to removable media (such as a DVD) are not verified for errors. If you do not use this parameter, backups saved to removable media are verified for errors. |
| -user | If the backup is saved to a remote shared folder, specifies the user name with write permission to the folder. |
| -password | Specifies the password for the user name that is provided by the parameter **-user**. |
| -noInheritAcl | Applies the access control list (ACL) permissions that correspond to the credentials provided by the **-user** and **-password** parameters to `\\<servername>\<sharename>\WindowsImageBackup\<ComputerBackedUp>\` (the folder that contains the backup). To access the backup later, you must use these credentials or be a member of the Administrators group or the Backup Operators group on the computer with the shared folder. If **-noInheritAcl** is not used, the ACL permissions from the remote shared folder are applied to the `\<ComputerBackedUp>` folder by default so that anyone with access to the remote shared folder can access the backup. |
| -vssFull | Performs a full back up using the Volume Shadow Copy Service (VSS). All files are backed up, each file's history is updated to reflect that it was backed up, and the logs of previous backups may be truncated. If this parameter isn't used, **wbadmin start backup** makes a copy backup, but the history of files being backed up is not updated.<p>**Caution:** Don't use this parameter if you are using a product other than Windows Server Backup to back up apps that are on the volumes included in the current backup. Doing so can potentially break the incremental, differential, or other type of backups that the other backup product is creating because the history that they are relying on to determine how much data to backup might be missing and they might perform a full backup unnecessarily. |
| -vssCopy | Performs a copy backup using VSS. All files are backed up but the history of the files being backup up is not updated so you preserve the all the information on which files where changed, deleted, and so on, as well as any application log files. Using this type of backup does not affect the sequence of incremental and differential backups that might happen independent of this copy backup. This is the default value.<p>**Warning:** A copy backup can't be used for incremental or differential backups or restores. |
| -quiet | Runs the command without prompts to the user. |

#### Remarks

- If you save your backup to a remote shared folder, and then perform another backup to the same computer and the same remote shared folder, you will overwrite your previous backup.

- If your backup operation fails, you can end up without a backup because the older backup is overwritten, but the newer backup isn't usable. To avoid this, we recommend creating subfolders in the remote shared folder to organize your backups. However, because of this organization, you must have twice the space available as the parent folder.

## Examples

To create a backup of volumes *e:*, *d:\\mountpoint*, and `\\?\Volume{cc566d14-4410-11d9-9d93-806e6f6e6963}\` to volume *f:*, type:

```
wbadmin start backup -backupTarget:f: -include:e:,d:\mountpoint,\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
```

To perform a one-time backup of *f:\\folder1* and *h:\\folder2* to volume *d:*, to backup the system state, and to make a copy backup so the normally scheduled differential backup isn't impacted, type:

```
wbadmin start backup –backupTarget:d: -include:g\folder1,h:\folder2 –systemstate -vsscopy
```

To perform a one-time, non-recursive backup of *d:\\folder1* to the `\\backupshare\backup1*` network location, and to restrict access to members of the **Administrators** or **Backup Operators** group, type:

```
wbadmin start backup –backupTarget: \\backupshare\backup1 -noinheritacl -nonrecurseinclude:d:\folder1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wbadmin command](wbadmin.md)
