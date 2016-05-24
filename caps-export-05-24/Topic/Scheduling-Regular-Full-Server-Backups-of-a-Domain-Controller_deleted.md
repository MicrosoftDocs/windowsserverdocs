---
title: Scheduling Regular Full Server Backups of a Domain Controller_deleted
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d858e444-0132-4049-864e-bb68ed456291
author: femila
---
# Scheduling Regular Full Server Backups of a Domain Controller_deleted
You can use these procedures to schedule daily backups of the full domain controller with Windows Server Backup or the Wbadmin.exe command\-line tool. This backup operation captures all volumes on the server.  
  
## Requirements for scheduling daily domain controller backups  
The following conditions are requirements for scheduling daily domain controller backups:  
  
-   The destination volume for the backup must be on a separate hard disk from the source volumes. You cannot perform a scheduled backup to a network shared folder.  
  
-   The external storage device for the backup must be connected to the domain controller that you are backing up.  
  
Membership in **Builtin Administrators**, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To schedule daily backup of Active Directory Domain Services \(AD DS\) by using the graphical user interface \(GUI\)  
  
1.  Click **Start**, click **Administrative Tools**, and then click **Windows Server Backup**.  
  
2.  Click **Action**, and then click **Backup Schedule**.  
  
3.  Review the information on the **Getting Started** page, and then click **Next**.  
  
4.  Click **Full Server \(recommended\)**, and then click **Next**.  
  
5.  Specify a backup time, and then click **Next**.  
  
6.  Click the check box for your destination disk, and then click **Next**.  
  
7.  Click **Yes** to confirm that the destination disk will be reformatted.  
  
8.  Verify the label for the destination disk, and then click **Next**.  
  
9. Verify the information on the **Summary** page, and then click **Finish**.  
  
10. On the **Confirmation** page, click **Close**.  
  
#### To schedule daily backup of AD DS by using the command line  
  
1.  Click **Start**, click **Command Prompt**, and then click **Run as administrator**.  
  
2.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
3.  Obtain the `DiskIdentifier` value to use for the backup target, as follows:  
  
    1.  To view the disk identifiers for all connected hard disks, at the command prompt, type the following command, and then press ENTER:  
  
        `wbadmin get disks`  
  
    2.  Select and copy to the Clipboard the value in `DiskIdentifier` for the correct external disk.  
  
4.  At the command prompt, type the following command, and then press ENTER:  
  
    `wbadmin enable backup -addtarget: <DiskIdentifier>`  
  
    `-schedule:<HH:MM>,<HH:MM>,... <HH:MM>`  
  
    `-include:<sourceDrive_1>:,<sourceDrive_2>:,... <sourceDrive_x>:`  
  
    Where:  
  
    -   `<DiskIdentifier>` identifies the copied value from the `wbadmin get disks` command that provides the external storage location for the scheduled backup.  
  
    -   `<HH:MM>` identifies the time or times for the backup to occur on a daily basis, separated by commas and no spaces.  
  
    -   `<sourceDrive_x>` identifies the critical volume or volumes to be backed up, separated by commas and no spaces.  
  
5.  If you are creating the first backup of the domain controller, type **Y**.  
  
6.  To enable backups with the settings that you have configured, type **Y**.  
  
7.  To format and use the volumes on the specified drive as the location to store scheduled backups, type **Y**.  
  
8.  Label the backup disk as specified in the response, so that you can identify the backup disk.  
  
    The `wbadmin` command provides label instructions. The `wbadmin` command confirms that the scheduled backup is enabled.  
  
The following Wbadmin.exe output shows the commands and responses for scheduling a daily backup of the C: and E: volumes at 20:00, beginning with the request for the connected disks:  
  
<pre>C:\Users\Administrator>wbadmin get disks  
wbadmin 1.0 - Backup command-line tool  
© Copyright 2004 Microsoft Corp.  
Disk name       : HDS72808 0PLAT20 USB Device  
DiskIdentifier  : {018230e0-0000-0000-0000-000000000000}  
Total space     : 76.69 GB  
Used space      : 92.93 MB  
Volumes         : G:[G:]  
Disk name       : IC35L040AVER07-0 ATA Device  
DiskIdentifier  : {4e1224e4-0000-0000-0000-000000000000}  
Total space     : 37.27 GB  
Used space      : 17.80 GB  
Volumes         : C:[C:],F:[F:],E:[E:]  
C:\Users\Administrator>wbadmin enable backup -addtarget:{018230e0-0000-0000-0000  
-000000000000} -schedule:20:00 -include:c:,e:  
wbadmin 1.0 - Backup command-line tool  
(C) Copyright 2004 Microsoft Corp.  
Retrieving volume information...  
Scheduled backup settings:  
Volumes in backup: C:,E:  
Location to store backup: HDS72808 0PLAT20 USB Device  
Times of day to run backup: 20:00  
Do you want to enable backups with the above settings?  
[Y] Yes [N] No y  
Do you want to format and use HDS72808 0PLAT20 USB Device (having volumes G:) as  
the location to store scheduled backups?  
[Y] Yes [N] No y  
Please label the backup disk as MH4-5/26/2006-14.08-Disk01. This information must be used to identify this backup disk.  
Scheduled backup is enabled.  
C:\Users\Administrator></pre>  
  
Use the following procedure to disable a scheduled backup.  
  
#### To disable a scheduled backup  
  
1.  In Windows Server Backup, click **Backup Schedule**, and then click **Stop Backup**.  
  
2.  Click **Next**, and then click **Finish**.  
  
3.  To confirm that you want to stop the backup schedule, click **Yes**, and then click **Close**.  
  
> [!NOTE]  
> As an alternative, you can disable a scheduled backup at the command prompt: type `wbadmin disable backup`, and then press ENTER.  
  
## Additional considerations  
Be aware of the following issues when you perform scheduled backups:  
  
-   The target drive is reformatted the first time that you schedule a backup.  
  
-   You cannot schedule weekly or monthly backups by using Windows Server Backup. However, you can use Task Scheduler to schedule manual backups that are performed at different times of the week.  
  
## Additional references  
For more information, see the Step\-by\-Step Guide for Windows Server Backup in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=87597](http://go.microsoft.com/fwlink/?LinkId=87597)\).  
  
