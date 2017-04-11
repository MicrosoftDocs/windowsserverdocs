---
title: wbadmin enable backup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0e57f8a-70fa-4c60-9754-e762e8ad8772
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# wbadmin enable backup

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

creates and enables a daily backup schedule or modifies an existing backup schedule. With no parameters specified, it displays the currently scheduled backup settings.
To configure or modify a daily backup schedule, you must be a member of either the **Administrators** or **Backup Operators** group. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt right-click **Command prompt** and then click **Run as administrator**.)
for examples of how to use this subcommand, see [Examples](#BKMK_examples).
## Syntax
Syntax for  Windows Server 2008 :
```
wbadmin enable backup
[-addtarget:<BackupTargetDisk>]
[-removetarget:<BackupTargetDisk>]
[-schedule:<timeToRunBackup>]
[-include:<volumesToInclude>]
[-allCritical]
[-quiet]
```
Syntax for  Windows Server 2008 R2 :
```
wbadmin enable backup
[-addtarget:<BackupTarget>]
[-removetarget:<BackupTarget>]
[-schedule:<timeToRunBackup>]
[-include:<volumesToInclude>]
[-nonRecurseInclude:<ItemsToInclude>]
[-exclude:<ItemsToExclude>]
[-nonRecurseExclude:<ItemsToExclude>][-systemState]
[-allCritical]
[-vssFull | -vsscopy]
[-user:<UserName>]
[-password:<Password>]
[-quiet]
```
Syntax for  Windows Server 2012  and  Windows Server 2012 R2 :
```
wbadmin enable backup
[-addtarget:<BackupTarget>]
[-removetarget:<BackupTarget>]
[-schedule:<timeToRunBackup>]
[-include:<volumesToInclude>]
[-nonRecurseInclude:<ItemsToInclude>]
[-exclude:<ItemsToExclude>]
[-nonRecurseExclude:<ItemsToExclude>][-systemState]
[-hyperv:<HyperVcomponentsToExclude>]
[-allCritical]
[-systemState] 
[-vssFull | -vsscopy]
[-user:<UserName>]
[-password:<Password>]
[-quiet] 
[-allowdeleteOldBackups]
```
## Parameters
|Parameter|Description|
|-------|--------|
|-addtarget|for  Windows Server 2008 , specifies the storage location for backups. Requires you to specify a destination for backups as a disk identifier (see remarks). The disk is formatted before use, and any existing data on it is permanently erased.<br /><br />for  Windows Server 2008 R2  and later, Specifies the storage location for backups. Requires you to specify the location as a disk, volume, or Universal Naming Convention (UNC) path to a remote shared folder (\\\\<servername>\\<sharename>\\). By default, the backup will be saved at:  \\\\<servername>\\<sharename>\WindowsImageBackup\\<computerBackedUp>\\. If you specify a disk, the disk will be formatted before use, and any existing data on it is permanently erased. If you specify a shared folder, you cannot add more locations. You can only specify one shared folder as a storage location at a time. **IMPORTANT:** if you save a backup to a remote shared folder, that backup will be overwritten if you use the same folder to back up the same computer agin. In addition, if the backup operation fails, you may end up with no backup because the older backup will be overwritten, but the newer backup will not be usable. You can avoid this by creating subfolders in the remote shared folder to organize your backups. If you do this, the subfolders will need twice the space of the parent folder.<br /><br />Only one location can be specified in a single command. Multiple volume and disk backup storage locations can be added by running the command again.|
|-removetarget|Specifies the storage location that you want to remove from the existing backup schedule. Requires you to specify the location as a disk identifier (see remarks).|
|-schedule|Specifies times of day to create a backup, formatted as HH:MM and comma delimited.|
|-include|for  Windows Server 2008 , specifies the comma-delimited list of volume drive letters, volume mount points, or GUID-based volume names to include in the backup.<br /><br />for  Windows Server 2008 R2 and later, Specifies the comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (*) in the file name when specifying a path to a file.|
|-nonRecurseInclude|for  Windows Server 2008 R2  and later, specifies the non-recursive, comma-delimited list of items to include in the backup. You can include multiple files, folders, or volumes. volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (*) in the file name when specifying a path to a file. Should be used only when the -backupTarget parameter is used.|
|-exclude|for  Windows Server 2008 R2  and later, specifies the comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (*) in the file name when specifying a path to a file.|
|-nonRecurseExclude|for  Windows Server 2008 R2  and later, specifies the non-recursive, comma-delimited list of items to exclude from the backup. You can exclude files, folders, or volumes. volume paths can be specified using volume drive letters, volume mount points, or GUID-based volume names. If you use a GUID-based volume name, it should be terminated with a backslash (\\). You can use the wildcard character (*) in the file name when specifying a path to a file.|
|-hyperv|Specifies the comma-delimited list of components to be included in backup. The identifier could be a component name or component GUID (with or without braces).|
|-systemState|for Windows 7 and  Windows Server 2008 R2  and later, creates a backup that includes the system state in addition to any other items that you specified with the **-include** parameter. The system state contains boot files (Boot.ini, NDTLDR, NTDetect.com), the Windows registry including COM settings, the SYSvol (Group Policies and Logon Scripts), the active directory and NTDS.DIT on domain controllers and, if the certificates service is installed, the Certificate Store. If your server has the Web server role installed, the IIS Metadirectory will be included. If the server is part of a cluster, Cluster service information is also included.|
|-allCritical|Specifies that all critical volumes (volumes that contain operating system's state) be included in the backups. This parameter is useful if you are creating a backup for full system or system state recovery. It should be used only when -backupTarget is specified, otherwise the command will fail. Can be used with the **-include** option. **Tip:** The target volume for a critical-volume backup can be a local drive, but it cannot be any of the volumes that are included in the backup.|
|-vssFull|for  Windows Server 2008 R2  and later, Performs a full back up using the volume shadow copy Service (VSS). All files are backed up, each file's history is updated to reflect that it was backed up, and the logs of previous backups may be truncated. If this parameter is not used wbadmin start backup makes a copy backup, but the history of files being backed up is not updated. **Caution:** Do not use this parameter if you are using a product other than Windows Server Backup to back up applications that are on the volumes included in the current backup. Doing so can potentially break the incremental, differential, or other type of backups that the other backup product is creating because the history that they are relying on to determine how much data to backup might be missing and they might perform a full backup unnecessarily.|
|-vsscopy|for  Windows Server 2008 R2  and later, performs a copy backup using VSS. All files are backed up but the history of the files being backup up is not updated so you preserve the all the information on which files where changed, deleted, and so on, as well as any application log files. Using this type of backup does not affect the sequence of incremental and differential backups that might happen independent of this copy backup. This is the default value. **Warning:** A copy backup cannot be used for incremental or differential backups or restores.|
|-user|for  Windows Server 2008 R2  and later, specifies the user with write permission to the backup storage destination (if it is a remote shared folder). The user needs to be a member of the Administrators group or Backup Operators group on the computer that is getting backed up.|
|-password|for  Windows Server 2008 R2  and later, specifies the password for the user name provided by the parameter -user.|
|-quiet|Runs the subcommand with no prompts to the user.|
|-allowdeleteOldBackups|Overwrites any backups made before the computer was upgraded.|
## remarks
To view the disk identifier value for your disks, type **wbadmin get disks**.
## <a name="BKMK_examples"></a>Examples
The following examples show how the **wbadmin enable backup** command can be used in different backup scenarios:
Scenario #1
-   Schedule backups of hard disk drives e:, d:\mountpoint, and \\\\?\volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
-   Save the files to the disk DiskID
-   Run backups daily at 9:00 A.M. and 6:00 P.M.
```
wbadmin enable backup -addtarget:DiskID -schedule:09:00,18:00 -include:e:,d:\mountpoint,\\?\volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
```
Scenario #2
-   Schedule backups of the folder d:\documents to the network location \\\backupshare\backup1
-   Use the network credentials for the backup administrator Aaren Ekelund (aekel), who is a member of the domain CONTOSOEAST to authenticate access to the network share. Aaren s password is *$3hM9^5lp*.
-   Run backups daily at 12:00 A.M. and 7:00 P.M.
```
wbadmin enable backup  addtarget:\\backupshare\backup1  include: d:\documents  user:CONTOSOEAST\aekel  password:$3hM9^5lp  schedule:00:00,19:00
```
Scenario #3
-   Schedule backups of volume t: and folder d:\documents to the drive h:, but exclude the folder d:\documents\\~tmp
-   Perform a full backup using the volume shadow copy Service.
-   Run backups daily at 1:00 A.M.
```
wbadmin enable backup  addtarget:H:  include T:,D:\documents  exclude D:\documents\~tmp  vssfull  schedule:01:00
```
#### additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [wbadmin](wbadmin.md)
