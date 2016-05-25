---
title: What&#39;s New in AD DS Backup and Recovery?_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 67f18955-c504-4d63-9f84-9b8c25d428e8
author: femila
---
# What&#39;s New in AD DS Backup and Recovery?_deleted
  
-   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] includes a new backup application named Windows Server Backup. Windows Server Backup is not installed by default. You must install it by using the **Add Features** option in Server Manager before you can use the Wbadmin.exe command\-line tool or **Windows Server Backup** on the **Administrative Tools** menu. For more information, see [Installing Windows Server Backup_deleted](../Topic/Installing-Windows-Server-Backup_deleted.md).  
  
-   To back up a domain controller, you should use the **wbadmin startsystemstatebackup** command to back up system state data. If you use the **wbadmin startsystemstatebackup** command, the backup contains only system state data, which minimizes the size of the backup. This method provides system state data backups that are similar to the system state backups that are provided by the Ntbackup tool in previous versions of Windows Server.  
  
    As another option, you can use the **wbadmin start backup** command with the **\-allcritical** parameter or use Windows Server Backup to perform a backup of all critical volumes, rather than only backing up system state data. However, this method backs up all the critical volumes entirely. A volume is considered critical if any system state file is reported on that particular volume.  
  
-   In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the system components that make up system state data depend on the server roles that are installed on the computer. The system state data includes at least the following data, plus additional data, depending on the server roles that are installed:  
  
    -   Registry  
  
    -   COM\+ Class Registration database  
  
    -   Boot files  
  
    -   Active Directory Certificate Services \(AD CS\) database  
  
    -   Active Directory database \(Ntds.dit\)  
  
    -   SYSVOL directory  
  
    -   Cluster service information  
  
    -   Microsoft Internet Information Services \(IIS\) metadirectory  
  
    -   System files that are under Windows Resource Protection  
  
-   When you use Windows Server Backup to back up the critical volumes on a domain controller, the backup includes all data that resides on the volumes that include the following:  
  
    -   The volume that hosts the boot files, which consist of the Bootmgr file and the Boot Configuration Data \(BCD\) store  
  
    -   The volume that hosts the Windows operating system and the registry  
  
    -   The volume that hosts the SYSVOL tree  
  
    -   The volume that hosts the Active Directory database \(Ntds.dit\)  
  
    -   The volume that hosts the Active Directory database log files  
  
-   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] supports the following types of backup:  
  
    -   Manual backup  
  
        A member of the Administrators group or the or Backup Operators group can initiate a manual backup by using Server Backup or the Wbadmin.exe command\-line tool each time that a backup is needed. If the target volume is not included in the backup set, you can make manual backups on a remote network share or on a volume on a local hard drive.  
  
    -   Scheduled backup  
  
        A member of the Administrators group can use the Windows Server Backup or the Wbadmin.exe command\-line tool to schedule backups. The scheduled backups must be made on a local, physical drive that does not host any critical volumes. Because scheduled backups reformat the target drive that hosts the backup files, we recommend that you use a dedicated backup volume.  
  
-   Windows Server Backup supports DVDs or CDs as backup media. You cannot use magnetic tape cartridges. You cannot use a dynamic volume as a backup target.  
  
-   Windows Server Backup does not support backing up individual files or directories. You must back up the entire volume that hosts the files that you want to back up.  
  
-   For Install from Media \(IFM\) installations, use the enhanced version of Ntdsutil.exe that is included in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] to create the installation media, rather than Windows Server Backup. Ntdsutil.exe in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] includes a new **ifm** command that creates installation media for additional domain controllers. For read\-only domain controller \(RODC\) installations, the **ntdsutil ifm** command can create secure installation media, in which the command strips secrets from the Active Directory data. You can also include SYSVOL data in the installation media.  
  
-   When you need to restore a domain controller, you can use Bcdedit.exe to toggle the default startup mode between normal and Directory Services Restore Mode \(DSRM\).  
  
    -   To start the server in DSRM by using Bcdedit.exe, at a command prompt, type the following command, and then press ENTER:  
  
        `bcdedit /set safeboot dsrepair`  
  
    -   To restart the server normally, at a command prompt, type the following command, and then press ENTER:  
  
        `bcdedit /deletevalue safeboot`  
  
-   Windows Server backup in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] has three recovery modes:  
  
    -   Full server recovery  
  
    -   System state recovery  
  
    -   File\/folder recovery  
  
    As with previous versions of Active Directory, you can perform a system state recovery only by starting the domain controller in DSRM, which you access by pressing F8 during the initial boot phase of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. If you cannot start the server, you must perform a full server recovery. For more information, see [Performing a Full Server Recovery of a Domain Controller](../Topic/Performing-a-Full-Server-Recovery-of-a-Domain-Controller.md).  
  
