---
title: Restoring a Critical-Volume Backup to an Alternate Location_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8a9ed79a-46d0-48f5-b173-88fb20c24cef
author: femila
---
# Restoring a Critical-Volume Backup to an Alternate Location_deleted
You can use the following procedure to restore a critical\-volumes backup to an alternate location, where it can be used as installation media for creating more domain controllers. However, you should use the **ntdsutil ifm** subcommand instead to create installation media for domain controllers that run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Using the **ntdsutil ifm** subcommand is more efficient because the installation media that it creates contains only the files that are necessary to install an additional domain controller. For more information, see "Using the Ntdsutil ifm subcommand to optimize backups for installing additional domain controllers" in [Scenario Overviews for Backing Up and Recovering AD DS_deleted](../Topic/Scenario-Overviews-for-Backing-Up-and-Recovering-AD-DS_deleted.md). You can use a system state backup instead of a critical\-volumes backup.  
  
To restore a critical\-volumes backup or system state backup to an alternate location, use the **wbadmin start recovery** command.  
  
## Requirements for restoring a critical\-volumes backup to an alternate location  
Restoring a backup of Active Directory Domain Services \(AD DS\) to create installation media has the following requirements:  
  
-   You must have a critical\-volumes backup or a system state backup available.  
  
-   You must have adequate removable media available to transfer either the backup or the restored files to the restore location.  
  
**Administrative credentials**  
  
You must be a member of the Administrators group or the Backup Operators group to perform this procedure.  
  
#### To restore a critical\-volume backup to an alternate location  
  
1.  At the command prompt, type the following command and then press ENTER:  
  
    ```  
    diskpart  
    ```  
  
2.  At the Diskpart prompt, type the following command and then press ENTER:  
  
    ```  
    list vol  
    ```  
  
3.  Identify the volume in the list that corresponds to the location of the backup that you want to restore. The drive letters do not necessarily match the volumes as they appear in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
4.  At the command prompt, type `exit`, and then press ENTER.  
  
5.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    wbadmin start recovery -backupTarget:<Drive>: -machine:<BackupComputerName> -version:<MM/DD/YYYY-HH:MM> -items:ADIFM -itemtype:app -recoveryTarget:"<Destination_directory>" -quiet  
    ```  
  
    Where  
  
    -   `<Drive>:` is the volume that contains the critical\-volumes backup, as identified by running the `list vol` command.  
  
    -   `<BackupComputerName>` is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was taken.  
  
    -   `<MM/DD/YYYY-HH:MM>` is the name of the backup version that you are restoring.  
  
    -   `<Destination_directory>` is the drive letter or shared folder path to which the backup is being restored.  
  
    If you do not specify the `-quiet` parameter, you are prompted to press Y to proceed with the restore process.  
  
    Windows Recovery restores the critical\-volumes backup to the specified destination in the following subfolders:  
  
    -   Active Directory, which contains the Ntds.dit files and logs  
  
    -   Registry, which contains the system registry  
  
    -   SYSVOL, which contains the SYSVOL tree structure and files  
  
## Additional considerations  
After you restore the critical\-volumes backup to a local hard drive or a remote shared folder, you must copy the restored files to removable media. For more information, see "Using the Ntdsutil ifm subcommand to optimize backups for installing additional domain controllers" in [Scenario Overviews for Backing Up and Recovering AD DS_deleted](../Topic/Scenario-Overviews-for-Backing-Up-and-Recovering-AD-DS_deleted.md).  
  
## Additional references  
For information about installing a domain controller by using the Install from Media \(IFM\) method, see the Step\-by\-Step Guide for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Active Directory Domain Services Installation and Removal \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=86716](http://go.microsoft.com/fwlink/?LinkID=86716)\), which is part of this documentation set.  
  
