---
title: Perform a System State Backup of a Domain Controller by Using the Command Line (Wbadmin)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fbbd5105-662a-4973-a7ae-8953e23133e3
author: Femila
---
# Perform a System State Backup of a Domain Controller by Using the Command Line (Wbadmin)
You can use this procedure to back up system state on a domain controller.  
  
Membership in **Builtin Administrators** or **Backup Operators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)] In addition, you must have write access to the target backup location.  
  
#### To perform a system state backup of a domain controller  
  
1.  Click **Start**, click **Command Prompt**, and then click **Run as administrator**.  
  
2.  If you are prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then click **OK**.  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
    `wbadmin start systemstatebackup -backuptarget:<targetDrive>: -quiet`  
  
    Where `<targetDrive>` identifies the local volume or the letter of the physical disk drive to receive the backup. You cannot store a system state backup on a network shared drive.  
  
    If you do not specify the `-quiet` parameter, you are prompted to press Y to proceed with the backup operation.  
  
#### Additional considerations  
Be aware of the following issues when you perform a system state backup:  
  
-   To use Wbadmin.exe, you must install Windows Server Backup. For more information about installing Windows Server Backup, see Installing Windows Server Backup \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=96495](http://go.microsoft.com/fwlink/?LinkID=96495)\).  
  
-   The target volume for a system state backup can be a local drive, but it cannot be any of the volumes that are included in the backup by default. To store the system state backup on a volume that is included in the backup, you must add the **AllowSSBToAnyVolume** registry entry to the server that you are backing up. There are also some prerequisites for storing system state backup on a volume that is included in the backup. For more information, see Known Issues for AD DS Backup and Recovery \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=117940](http://go.microsoft.com/fwlink/?LinkID=117940)\).  
  
