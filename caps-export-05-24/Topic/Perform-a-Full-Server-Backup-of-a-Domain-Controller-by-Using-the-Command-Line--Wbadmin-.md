---
title: Perform a Full Server Backup of a Domain Controller by Using the Command Line (Wbadmin)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 72cdcfc9-5398-4eed-bc83-80cc41bd41c6
author: Femila
---
# Perform a Full Server Backup of a Domain Controller by Using the Command Line (Wbadmin)
A full server backup captures all volumes on all locally attached volumes. Windows Server Backup treats Universal Serial Bus \(USB\) drives and Internet SCSI \(iSCSI\) devices as locally attached volumes. If the backup target is a locally attached drive, it is excluded from the backup set.  
  
You can use this procedure to back up all volumes with the Wbadmin.exe command\-line tool.  
  
Membership in **Builtin Administrators** or **Backup Operators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)] In addition, you must have write access to the target backup location.  
  
#### To perform an unscheduled backup of all volumes by using the command line  
  
1.  Click **Start**, click **Command Prompt**, and then click **Run as administrator**.  
  
2.  If you are prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then click **OK**.  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
    `wbadmin start backup -include:<sourceDrive_1>:,<sourceDrive_2>:,... <sourceDrive_n>: -backuptarget:<targetDrive>: -quiet`  
  
    Where:  
  
    -   `<sourceDrive_x>` identifies the volume or volumes to be backed up, separated by commas and no spaces.  
  
    -   `<targetDrive>` identifies the local volume or the letter of the network shared drive or physical disk drive to receive the backup.  
  
    If you do not specify the `-quiet` parameter, you are prompted to press Y to proceed with the restore process.  
  
#### Additional considerations  
Be aware of the following issues when you perform unscheduled backups:  
  
-   To use Wbadmin.exe, you must install Windows Server Backup. For more information about installing Windows Server Backup, see Installing Windows Server Backup \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=96495](http://go.microsoft.com/fwlink/?LinkID=96495)\).  
  
-   The target volume for an unscheduled backup can be a local drive, but it cannot be any of the volumes that are included in the backup.  
  
