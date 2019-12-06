---
title: wbadmin start recovery
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 52381316-a0fa-459f-b6a6-01e31fb21612
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# wbadmin start recovery



Runs a recovery operation based on the parameters that you specify.

To perform a recovery with this subcommand, you must be a member of the **Backup Operators** group or the **Administrators** group, or you must have been delegated the appropriate permissions. In addition, you must run **wbadmin** from an elevated command prompt. (To open an elevated command prompt, click **Start**, right-click **Command Prompt**, and then click **Run as administrator**.)

For examples of how to use this subcommand, see [Examples](#BKMK_Examples).

## Syntax

```
wbadmin start recovery
-version:<VersionIdentifier>
-items:{<VolumesToRecover> | <AppsToRecover> | <FilesOrFoldersToRecover>}
-itemtype:{Volume | App | File}
[-backupTarget:{<VolumeHostingBackup> | <NetworkShareHostingBackup>}]
[-machine:<BackupMachineName>]
[-recoveryTarget:{<TargetVolumeForRecovery> | <TargetPathForRecovery>}]
[-recursive]
[-overwrite:{Overwrite | CreateCopy | Skip}]
[-notRestoreAcl]
[-skipBadClusterCheck]
[-noRollForward]
[-quiet]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-version|Specifies the version identifier of the backup to recover in MM/DD/YYYY-HH:MM format. If you do not know the version identifier, type **wbadmin get versions**.|
|-items|Specifies a comma-delimited list of volumes, applications, files, or folders to recover.</br>-   If **-itemtype** is **Volume**, you can specify only a single volume—by providing the volume drive letter, volume mount point, or GUID-based volume name.</br>-   If **-itemtype** is **App**, you can specify only a single application. To be recovered, the application must have registered with Windows Server Backup. You can also use the value **ADIFM** to recover an installation of Active Directory. See Remarks in for more information.</br>-   If **-itemtype** is **File**, you can specify files or folders, but they should be part of the same volume and they should be under the same parent folder.|
|-itemtype|Specifies type of items to recover. Must be **Volume**, **App**, or **File**.|
|-backupTarget|Specifies the storage location that contains the backup that you want to recover. This parameter is useful when the location is different from where backups of this computer are usually stored.|
|-machine|Specifies the name of the computer that you want to recover the backup for. This parameter is useful when multiple computers have been backed up to the same location. It should be used when the **-backupTarget** parameter is specified.|
|-recoveryTarget|Specifies the location to restore to. This parameter is useful if this location is different than the location that was previously backed up. It can also be used for restorations of volumes, files, or applications. If you are restoring a volume, you can specify the volume drive letter of the alternate volume. If you are restoring a file or application, you can specify an alternate recovery location.|
|-recursive|Valid only when recovering files. Recovers the files in the folders and all files subordinate to the specified folders. By default, only files which reside directly in the specified folders are recovered.|
|-overwrite|Valid only when recovering files. Specifies the action to take when a file that is being recovered already exists in the same location.</br>-   **Skip** causes Windows Server Backup to skip the existing file and continue with recovery of the next file.</br>-   **CreateCopy** causes Windows Server Backup to create a copy of the existing file so that the existing file is not modified.</br>-   **Overwrite** causes Windows Server Backup to overwrite the existing file with the file from the backup.|
|-notRestoreAcl|Valid only when recovering files. Specifies to not restore the security access control lists (ACLs) of the files being recovered from the backup. By default, the security ACLs are restored (the default value is **true)**. If this parameter is used, the ACLs for the restored files will be inherited from the location to which the files are being restored.|
|-skipBadClusterCheck|Valid only when recovering volumes. Skips checking the disks that you are recovering to for bad cluster information. If you are recovering to an alternate server or hardware, we recommend that you do not use this parameter. You can manually run the command **chkdsk /b** on these disks at any time to check them for bad clusters, and then update the file system information accordingly.</br>Important: Until you run **chkdsk** as described, the bad clusters reported on your recovered system may not be accurate.|
|-noRollForward|Valid only when recovering applications. Allows for previous point-in-time recovery of an application if the latest version from the backups is selected. For other versions of the application that are not the latest, previous point-in-time recovery is done as the default.|
|-quiet|Runs the subcommand with no prompts to the user.|

## Remarks

-   To view a list of items that are available for recovery from a specific backup version, use **wbadmin get items**. If a volume did not have a mount point or drive letter at the time of backup, then this subcommand would return a GUID-based volume name that should be used for recovering the volume.
-   When the **-itemtype** is **App**, you can use a value of **ADIFM** for **-item** to perform an install from media operation to recover all the related data needed for Active Directory Domain Services. **ADIFM** creates a copy of the Active Directory database, registry, and SYSVOL state, and then saves this information in the location specified by **-recoveryTarget**. Use this parameter only when **-recoveryTarget** is specified.

>     [!NOTE]
>     Before using **wbadmin** to perform an install from media operation, you should consider using the **ntdsutil** command because **ntdsutil** only copies the minimum amount of data needed, and it uses a more secure data transport method.

## <a name="BKMK_Examples"></a>Examples

To run a recovery of the backup from March 31, 2013, taken at 9:00 A.M., of volume d:, type:
```
wbadmin start recovery -version:03/31/2013-09:00 -itemType:Volume -items:d:
```
To run a recovery to drive d of the backup from March 31, 2013, taken at 9:00 A.M., of the registry, type:
```
wbadmin start recovery -version:03/31/2013-09:00 -itemType:App -items:Registry -recoverytarget:d:\
```
To run a recovery of the backup from March 31, 2013, taken at 9:00 A.M., of the d:\folder and folders subordinate to d:\folder, type:
```
wbadmin start recovery -version:03/31/2013-09:00 -itemType:File -items:d:\folder -recursive
```
To run a recovery of the backup from March 31, 2013, taken at 9:00 A.M., of the volume \\\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\, type:
```
wbadmin start recovery -version:03/31/2013-09:00 -itemType:Volume 
-items:\\?\Volume{cc566d14-44a0-11d9-9d93-806e6f6e6963}\
```
To run a recovery of the backup from April 30, 2013, taken at 9:00 A.M., of the shared folder \\\\servername\share from server01, type:
```
wbadmin start recovery -version:04/30/2013-09:00 -backupTarget:\\servername\share -machine:server01
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Wbadmin](wbadmin.md)
-   [Start-WBFileRecovery](https://technet.microsoft.com/library/jj902457.aspx) cmdlet
-   [Start-WBHyperVRecovery](https://technet.microsoft.com/library/jj902463.aspx) cmdlet
-   [Start-WBSystemStateRecovery](https://technet.microsoft.com/library/jj902449.aspx) cmdlet
-   [Start-WBVolumeRecovery](https://technet.microsoft.com/library/jj902470.aspx) cmdlet