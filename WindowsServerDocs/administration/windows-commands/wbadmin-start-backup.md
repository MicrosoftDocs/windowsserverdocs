---
title: wbadmin start backup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 56f3e752-d99a-4c3d-8e97-10303c37dd78
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin start backup



Creates a backup using specified parameters. If no parameters are specified and you have created a scheduled daily backup, this subcommand creates the backup by using the settings for the scheduled backup. If parameters are specified, it creates a Volume Shadow Copy Service (VSS) copy backup and will not update the history of the files that are being backed up.

To create a one-time backup with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command Prompt** and then click **Run as administrator**.)

For examples of how to use this subcommand, see [Examples](#BKMK_examples).

## Syntax

Syntax for Windows°Vista and Windows Server 2008:
```
wbadmin start backup
[-backupTarget:{<BackupTargetLocation> | <TargetNetworkShare>}]
[-include:<VolumesToInclude>]
[-allCritical]
[-noVerify]
[-user:<UserName>]
[-password:<Password>]
[-noinheritAcl]
[-vssFull]
[-quiet]
```
Syntax for Windows°7 and Windows Server 2008 R2 and later:
```
Wbadmin start backup
[-backupTarget:{<BackupTargetLocation> | <TargetNetworkShare>}]
[-include:<ItemsToInclude>]
[-nonRecurseInclude:<ItemsToInclude>]
[-exclude:<ItemsToExclude>]
[-nonRecurseExclude:<ItemsToExclude>]
[-allCritical]
[-systemState]
[-noVerify]
[-user:<UserName>]
[-password:<Password>]
[-noInheritAcl]
[-vssFull | -vssCopy] 
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-backupTarget|Specifies the storage location for this backup. Requires a hard disk drive letter (f:), a volume GUID-based path in the format of \\\\?\Volume{GUID}, or a Universal Naming Convention (UNC) path to a remote shared folder (\\\\\<servername>\<sharename>\). By default, the backup will be saved at: \\\\<servername>\<sharename>\**WindowsImageBackup**\\<ComputerBackedUp>\.</br>Important: If you save a backup to a remote shared folder, that backup will be overwritten if you use the same folder to back up the same computer again. In addition, if the backup operation fails, you may end up with no backup because the older backup will be overwritten, but the newer backup will not be usable. You can avoid this by creating subfolders in the remote shared folder to organize your backups. If you do this, the subfolders will need twice the space as the parent folder.|
|-include|For Windows°Vista and Windows Server 2008, specifies the comma-delimited list of volume drive letters, volume mount points, or GUID-based volume names to include in the backup. This parameter should be used only when the **-backupTarget** parameter is used.</br>For Windows°7 and Windows Server 2008 R2 and later, specifies the comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (\*) in the file name when specifying a path to a file. Should be used only when the **-backupTarget** parameter is used.|
|-exclude|For Windows°7 and Windows Server 2008 R2 and later, specifies the comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (\*) in the file name when specifying a path to a file. Should be used only when the **-backupTarget** parameter is used.|
|-nonRecurseInclude|For Windows°7 and Windows Server 2008 R2 and later, specifies the non-recursive, comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (\*) in the file name when specifying a path to a file. Should be used only when the **-backupTarget** parameter is used.|
|-nonRecurseExclude|For Windows°7 and Windows Server 2008 R2 and later, specifies the non-recursive, comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. Volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (\*) in the file name when specifying a path to a file. Should be used only when the **-backupTarget** parameter is used.|
|-allCritical|Specifies that all critical volumes (volumes that contain operating system's state) be included in the backups. This parameter is useful if you are creating a backup for bare metal recovery. It should be used only when **-backupTarget** is specified, otherwise the command will fail. Can be used with the **-include** option.</br>Tip: The target volume for a critical-volume backup can be a local drive, but it cannot be any of the volumes that are included in the backup.|
|-systemState|For Windows°7 and Windows Server 2008 R2 and later, creates a backup that includes the system state in addition to any other items that you specified with the **-include** parameter. The system state contains boot files (Boot.ini, NDTLDR, NTDetect.com), the Windows Registry including COM settings, the SYSVOL (Group Policies and Logon Scripts), the Active Directory and NTDS.DIT on Domain Controllers and, if the certificates service is installed, the Certificate Store. If your server has the Web server role installed, the IIS Metadirectory will be included. If the server is part of a cluster, Cluster Service information will also be included.|
|-noVerify|Specifies that backups saved to removable media (such as a DVD) are not verified for errors. If you do not use this parameter, backups saved to removable media are verified for errors.|
|-user|If the backup is saved to a remote shared folder, specifies the user name with write permission to the folder.|
|-password|Specifies the password for the user name that is provided by the parameter **-user**.|
|-noInheritAcl|Applies the access control list (ACL) permissions that correspond to the credentials provided by the **-user** and **-password** parameters to \\\\\<servername>\<sharename>\WindowsImageBackup\<ComputerBackedUp>\ (the folder that contains the backup). To access the backup later, you must use these credentials or be a member of the Administrators group or the Backup Operators group on the computer with the shared folder. If **-noInheritAcl** is not used, the ACL permissions from the remote shared folder are applied to the \<ComputerBackedUp> folder by default so that anyone with access to the remote shared folder can access the backup.|
|-vssFull|Performs a full back up using the Volume Shadow Copy Service (VSS). All files are backed up, each file's history is updated to reflect that it was backed up, and the logs of previous backups may be truncated. If this parameter is not used **wbadmin start backup** makes a copy backup, but the history of files being backed up is not updated.</br>Caution: Do not use this parameter if you are using a product other than Windows Server Backup to back up applications that are on the volumes included in the current backup. Doing so can potentially break the incremental, differential, or other type of backups that the other backup product is creating because the history that they are relying on to determine how much data to backup might be missing and they might perform a full backup unnecessarily.|
|-vssCopy|For Windows 7 and Windows Server 2008 R2 and later, performs a copy backup using VSS. All files are backed up but the history of the files being backup up is not updated so you preserve the all the information on which files where changed, deleted, and so on, as well as any application log files. Using this type of backup does not affect the sequence of incremental and differential backups that might happen independent of this copy backup. This is the default value.</br>Warning: A copy backup cannot be used for incremental or differential backups or restores.|
|-quiet|Runs the subcommand with no prompts to the user.|

## <a name="BKMK_examples"></a>Examples

The following examples show how the **wbadmin start backup** command can be used in different backup scenarios:

Scenario #1
- Create a backup of volumes e:, d:\mountpoint, and \\\\?\Volume{cc566d14-4410-11d9-9d93-806e6f6e6963}
- Save the backup to volume f:
  ```
  wbadmin start backup -backupTarget:f: -include:e:,d:\mountpoint,\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
  ```
  Scenario #2
- Perform a one-time backup of *f:\folder1* and *h:\folder2* to volume *d:*.
- Backup the system state
- Make a copy backup so that the normally scheduled differential backup is not impacted.
  ```
  wbadmin start backup –backupTarget:d: -include:g\folder1,h:\folder2 –systemstate -vsscopy
  ```
  Scenario #3
- Perform a one-time backup of *d:\folder1* that should be backed up non-recursively.
- Backup the folder to the network location *\\\\backupshare\backup1*
- Restrict access to the backup to members of the **Administrators** or **Backup Operators** group.
  ```
  wbadmin start backup –backupTarget: \\backupshare\backup1 -noinheritacl -nonrecurseinclude:d:\folder1
  ```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
