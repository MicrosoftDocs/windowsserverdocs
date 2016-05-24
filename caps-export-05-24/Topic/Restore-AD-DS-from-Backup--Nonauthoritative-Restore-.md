---
title: Restore AD DS from Backup (Nonauthoritative Restore)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8c3f19e4-469c-488d-a551-e04622aded98
author: Femila
---
# Restore AD DS from Backup (Nonauthoritative Restore)
  Nonauthoritative restore from backup restores Active Directory Domain Services \(AD DS\) from its current state to the previous state of a backup. Use this procedure before you perform an authoritative restore procedure to recover objects that were deleted after the time of the backup. To restore AD DS from backup, use a system state or critical\-volumes backup.  
  
 To restore AD DS from backup, you must restart the domain controller in Directory Services Restore Mode \(DSRM\).  
  
> [!NOTE]  
>  If you are logging on to a read\-only domain controller \(RODC\) locally or remotely, do not use a domain administrative account. Use only the delegated RODC administrator account. For more information about access to RODCs, see the Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\).  
  
 Be sure that you know the name and location of the version of the backup that you are restoring. Backup files are named for the date and time of the backup. When you restore the backup, the version must be stated in the form MM\/DD\/YYYY\-HH:MM \(month\/day\/year\-hour:minute\), which specifies the name of backup that you want to restore. The Wbadmin.exe command\-line tool does not require that you provide the target for the recovery. By specifying the backup version that you want to recover, the command proceeds to recover to the source location of the backup version that you specify.  
  
> [!NOTE]  
>  The **systemstaterecovery** command in Wbadmin.exe causes a nonauthoritative restore of SYSVOL by default \(only updates to SYSVOL since the time of the backup are replicated to the recovery domain controller\). If you want to restore SYSVOL authoritatively \(all of SYSVOL is replicated from the recovery domain controller to other domain controllers in the domain\), specify the **–authsysvol** option in the command.  
  
 The Administrator password for DSRM is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)] The server must be running in DSRM.  
  
### To perform a nonauthoritative restore of AD DS  
  
1.  At the **Windows** logon screen, click **Switch User**, and then click **Other User**.  
  
2.  Type **.\\administrator** as the user name, type the DSRM password for the server, and then press ENTER.  
  
3.  Open a Command Prompt.  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
     `wbadmin get versions -backuptarget:<targetDrive>:`  
  
     `-machine:<BackupComputerName>`  
  
     Where:  
  
    -   `<targetDrive>:` is the location of the backup that you want to restore.  
  
    -   `<BackupComputerName>` is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was made.  
  
5.  Identify the backup version that you want to restore.  
  
     You must enter this backup version exactly in the next step.  
  
6.  At the command prompt, type the following command, and then press ENTER:  
  
     `wbadmin start systemstaterecovery -version:<MM/DD/YYYY-HH:MM>`  
  
     `-backuptarget:<targetDrive>: -machine:<BackupComputerName>`  
  
     `-quiet`  
  
     Where:  
  
    -   `<MM/DD/YYYY-HH:MM>` is the version of the backup that you want to restore.  
  
    -   `<targetDrive>:` is the volume that contains the backup.  
  
    -   `<BackupComputerName>` is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was taken.  
  
     If you do not specify the `-quiet` parameter, you are prompted to press Y to proceed with the restore process and then press Y to confirm that the replication engine for SYSVOL has not changed since you created the backup.  
  
 After the recovery operation is complete, if you are not going to perform an authoritative restore of any restored objects, restart the server.  
  
## Additional references  
  
-   [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
-   [Enable Remote Desktop](../Topic/Enable-Remote-Desktop.md)  
  
-   [Create a Remote Desktop Connection](../Topic/Create-a-Remote-Desktop-Connection.md)  
  
-   [Restart the Domain Controller in Directory Services Restore Mode Remotely](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Remotely.md)  
  
-   [Performing Authoritative Restore of Active Directory Objects](../Topic/Performing-Authoritative-Restore-of-Active-Directory-Objects.md)  
  
  