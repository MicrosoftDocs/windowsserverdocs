---
title: Performing a Nonauthoritative Restore of AD DS_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 510b106b-e7fb-42a5-bcb2-0c3278a5d73e
author: femila
---
# Performing a Nonauthoritative Restore of AD DS_deleted
To perform a nonauthoritative restore of Active Directory Domain Services \(AD DS\), you need at least a system state backup. For more information about the specific components that are included in a system state backup, see [What's New in AD DS Backup and Recovery?_deleted](../Topic/What-s-New-in-AD-DS-Backup-and-Recovery-_deleted.md).  
  
To restore a system state backup, use the **wbadmin start systemstaterecovery** command. The procedure in this topic uses the **wbadmin start systemstaterecovery** command.  
  
You can also use a critical\-volume backup to perform a nonauthoritative restore, or a full server backup if you do not have a system state or critical\-volume backup. A full server backup is generally larger than a critical\-volume backup or system state backup. Restoring a full server backup not only rolls back data in AD DS to the time of backup, but it also rolls back all data in other volumes. Rolling back this additional data is not necessary to achieve nonauthoritative restore of AD DS. To restore a critical\-volume backup or full server backup, use the **wbadmin start recovery** command.  
  
## Requirements for performing nonauthoritative restore of AD DS  
To perform a nonauthoritative restore, you must start the domain controller in Directory Services Restore Mode \(DSRM\). When the domain controller starts in DSRM, you must supply the administrator password for DSRM.  
  
> [!NOTE]  
> Be sure to provide the local administrator account and the DSRM password when you start in DSRM, as described in the following steps. If another domain controller is available, you can log on to a domain controller that is started in DSRM by using credentials for a domain user account. However, the DSRM account and password are required to restore the domain controller.  
  
If you cannot start the server, you must perform a full server recovery instead of a system state restore. For more information about performing a full server recovery, see [Performing a Full Server Recovery of a Domain Controller](../Topic/Performing-a-Full-Server-Recovery-of-a-Domain-Controller.md).  
  
Use either of the following two methods to start the domain controller in DSRM. If you use the Bcdedit.exe command\-line tool to have the server restart in DSRM, you must use Bcdedit.exe to restart the server normally after you complete the recovery operation. Members of the Backup Operators group might not be able to use the Bcdedit.exe command\-line tool to have the server restart in DSRM.  
  
Method 1: Press F8 to restart in DSRM.  
  
1.  Restart the domain controller.  
  
    Some computers might require you to shut down the computer, rather than restart it, to see the option to start the domain controller in DSRM.  
  
2.  After the boot option menu appears, press F8 to start the domain controller in DSRM.  
  
3.  When the recovery options menu appears, select the option for DSRM.  
  
Method 2: Use Bcdedit.exe to restart in DSRM.  
  
1.  Click **Start**, click **Command Prompt**, and then click **Run as administrator**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    `bcdedit /set safeboot dsrepair`  
  
3.  Type the following command, and then press ENTER:  
  
    `shutdown -t 0 -r`  
  
4.  To restart the server normally after you perform the restore operation, type the following command, and then press ENTER to have the server restart normally:  
  
    `bcdedit /deletevalue safeboot`  
  
    Type the following command, and then press ENTER:  
  
    `shutdown -t 0 -r`  
  
You can use this procedure to perform a nonauthoritative restore of AD DS. After replication occurs and is complete, AD DS is recovered on the domain controller.  
  
You can use the DSRM administrator password to either locally or remotely log on to the domain controller that you are restoring. You specify the DSRM password when you install AD DS.  
  
#### To perform a nonauthoritative restore of AD DS  
  
1.  At the **Windows** logon screen, click **Switch User**, and then click **Other User**.  
  
2.  Type **.\\administrator** as the user name, type the DSRM password for the server, and then press ENTER.  
  
3.  Click **Start**, right\-click **Command Prompt**, and then click **Run as Administrator**.  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
    `wbadmin get versions -backuptarget:<targetDrive>:`  
  
    `-machine:<BackupComputerName>`  
  
    Where:  
  
    -   `<targetDrive>:` is the location of the backup that you want to restore.  
  
    -   `<BackupComputerName>` is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was taken.  
  
5.  Identify the version that you want to restore.  
  
    You must enter this version exactly in the next step.  
  
6.  At the command prompt, type the following command, and then press ENTER:  
  
    `wbadmin start systemstaterecovery -version:<MM/DD/YYYY-HH:MM>`  
  
    `-backuptarget:<targetDrive>: -machine:<BackupComputerName>`  
  
    `-quiet`  
  
    Where:  
  
    -   `<MM/DD/YYYY-HH:MM>` is the version of the backup that you want to restore.  
  
    -   `<targetDrive>:` is the volume that contains the backup.  
  
    -   `<BackupComputerName>` is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was taken.  
  
    If you do not specify the `-quiet` parameter, you are prompted to press Y to proceed with the restore process and press Y to confirm that the replication engine for SYSVOL has not changed since you created the backup.  
  
    After the recovery operation has completed, if you are not going to perform an authoritative restore of any restored objects, restart the server.  
  
### Additional considerations  
Be aware of the following issues when you perform a nonauthoritative restore of AD DS:  
  
-   If the nonauthoritative restore procedure is preliminary to performing an authoritative restore of any restored objects, do not restart the domain controller until after you have completed the authoritative restore procedure.  
  
-   When you use System Recovery Options to restore a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller in an environment that has Distributed File System \(DFS\) Replication implemented, the SYSVOL restore is performed nonauthoritatively by default. To perform an authoritative restore of SYSVOL, include the **\-authsysvol** switch in your recovery command, as shown in the following example:  
  
    `wbadmin start systemstaterecovery <otheroptions> -authsysvol`  
  
-   If you use File Replication Service \(FRS\), the restore operation sets the **BURFLAGS** registry keys for FRS, which affects all replica sets that are replicated by FRS.  
  
-   Wbadmin.exe does not require that you provide the target for the recovery. By specifying the backup version that you want to recover, the command proceeds to recover to the source location of the specified backup version.  
  
-   Backup files are named for the date and time of the backup. When you recover, the version must be stated in the form MM\/DD\/YYYY\-HH:MM, which specifies the name of backup that you want to recover.  
  
-   After the restore is completed, restart the server normally, and perform basic verification. When you restart the computer normally, AD DS and Active Directory Certificate Services \(AD CS\) automatically detect that they have been recovered from a backup. They perform an integrity check and index the database again.  
  
-   After you log on to the system, browse AD DS, and verify that the following conditions are met:  
  
    -   All of the user objects and group objects that were present in the directory at the time of the backup are restored.  
  
    > [!NOTE]  
    > Active Directory replication updates the objects that you restore with any changes that have been made to them since the time that the backup was taken.  
  
    -   Files that were members of a FRS replica set and certificates that were issued by AD CS are present.  
  
    -   The Windows Time service \(W32time\) is synchronized correctly.  
  
    -   The NETLOGON and SYSVOL folders are properly shared.  
  
    -   The Preferred DNS server address is configured correctly.  
  
    -   Host \(A\) and service \(SRV\) resource records are registered correctly in Domain Name System \(DNS\).  
  
