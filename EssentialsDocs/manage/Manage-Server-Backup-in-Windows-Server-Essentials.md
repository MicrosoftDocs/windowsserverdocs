---
title: "Manage Server Backup in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0302d070-c58a-40f2-b56d-7e7842813d02
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Manage Server Backup in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
  
 The following topics include information about common backup tasks that you can accomplish by using the Windows Server Essentials Dashboard:  
  
-   [Which backup should I choose?](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_WhichBackup)  
  
-   [Set up or customize server backup](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Stop server backup in progress](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Remotely manage your backups](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_3)  
  
-   [Disable server backup](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_4)  
  
-   [Learn more about setting up server backup](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Repartition a hard drive on the server](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_6)  
  
-   [Restore files and folders from a server backup](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_7)  
  
##  <a name="BKMK_WhichBackup"></a> Which backup should I choose?  
 Choosing a backup can be straightforward if you have a very recent successful backup and you know that the backup contains all of your critical data. If you are trying to restore to the server or a computer from an older backup, choosing a good backup to restore to may require some investigation and, possibly, some compromise.  
  
#### To choose a backup  
  
1.  Check with the owner of the files or folders, and note the dates and times when they added or edited them. Use these dates and times as a starting point.  
  
2.  On the **Choose a restore option** page in the Restore Files and Folders Wizard, click **Restore from a backup that I select (advanced)**.  
  
3.  Depending on whether you want to restore an older or newer version of the files or folders, select the backup that best fits the dates and times noted in step 1.  
  
4.  As a best practice, you can restore files and folders to an alternate location, and then let the owner of the files and folders move the ones that they need to the original location. When they finish, the files and folders that remain in the alternate location can be deleted.  
  
##  <a name="BKMK_1"></a> Set up or customize server backup  
 Server backup is not automatically configured during installation. You should protect your server and its data automatically by scheduling daily backups. It is recommended that you maintain a daily backup plan because most organizations cannot afford to lose the data that has been created over several days. For more information, see [Set up or customize server backup](Set-up-or-customize-server-backup.md).  
  
##  <a name="BKMK_2"></a> Stop server backup in progress  
 Whether a server backup starts at a regularly scheduled time or you start a server backup manually, you can stop the backup in progress.  
  
#### To stop a backup in progress  
  
1.  Open the Dashboard.  
  
2.  In the navigation bar, click **Devices**.  
  
3.  In the list of computers, click the server, and then click **Stop backup for the server** in the **Tasks** pane.  
  
4.  Click **Yes** to confirm your action.  
  
##  <a name="BKMK_3"></a> Remotely manage your backups  
 When you are away from the office, you can use Windows Server Essentials Remote Web Access to access the Windows Server Essentials Dashboard to manage your server.  
  
#### To use Remote Web Access to manage your server  
  
1. Open a web browser.  
  
2. In the address box, type the name of the Windows Server Essentials domain.  
  
3. When prompted, enter your user name and password.  
  
4. When you click the name of the server in  Remote Web Access, the logon page for the Dashboard is displayed.  
  
5. Log on to the Dashboard as an administrator, and then click **Devices**.  
  
   For more information about  Remote Web Access, see [Remote Web Access overview](Manage-Remote-Web-Access-in-Windows-Server-Essentials.md#BKMK_Overview).  
  
##  <a name="BKMK_4"></a> Disable server backup  
 You should protect your server and its data automatically by scheduling daily backups. It is recommended that you maintain a daily backup plan because most organizations cannot afford to lose the data that has been created over several days.  
  
 If you already have server backup configured, and later want to use a third-party application to back up the server, you can disable Windows Server Essentials server backup.  
  
#### To disable server backup  
  
1.  Log on to the Windows Server Essentials Dashboard using an administrator account and password.  
  
2.  Click the **Devices** tab, and then click the name of the server.  
  
3.  In the Tasks pane, click **Customize Backup for the server**.  
  
    > [!NOTE]
    >  The **Customize Backup for the server** task is displayed after you have configured server backup using the Set Up Server Backup Wizard. For more information about setting up server backup, see [Set up or customize server backup](Manage-Server-Backup-in-Windows-Server-Essentials.md#BKMK_1).  
  
4.  The Customize Server Backup Wizard appears.  
  
5.  On the **Configuration Options** page, click **Disable Server Backup**. Follow the instructions in the wizard.  
  
##  <a name="BKMK_5"></a> Learn more about setting up server backup  
 Server backup is not enabled during server setup.  
  
> [!NOTE]
>  When you configure server backup, you should connect at least one external hard drive to the server to use as the backup destination hard drive.  
  
###  <a name="BKMK_Target"></a> Backup destination drive  
 You can use multiple external storage drives for backups, and you can rotate the drives between onsite and offsite storage locations. This can improve your disaster preparedness planning by helping you recover your data if physical damage occurs to the hardware onsite.  
  
 When choosing a storage drive for your server backup, consider the following:  
  
-   Choose a drive that contains sufficient space to store your data. Your storage drives should contain at least 2.5 times the storage capacity of the data that you want to back up. The drives should also be large enough to accommodate the future growth of your server data.  
  
-   If the backup destination drive contains offline drives, the backup configuration will not succeed. To complete the configuration, when selecting the backup destination, clear the check box to exclude drives that are offline.  
  
-   If you choose a drive that contains previous backups as the backup destination, the wizard allows you choose if you want to keep the previous backups. If you keep the backups, the wizard does not format the drive.  
  
-   When reusing an external storage drive, make sure that the drive is empty or contains only data that you do not need.  
  
-   You should visit the website for your external storage drive manufacturer to ensure that your backup drive is supported on computers running Windows Server Essentials.  
  
> [!CAUTION]
>  The Set Up Server Backup Wizard formats the storage drives when it configures them for backup.  
  
### Server backup schedule  
 You should protect your server and its data automatically by scheduling daily backups. It is recommended that you maintain a daily backup plan because most organizations cannot afford to lose the data that has been created over several days.  
  
 When you use the Windows Server Essentials Set Up Server Backup Wizard, you can choose to back up server data at multiple times during the day. Because the wizard schedules differential-based backups, Backup runs quickly, and server performance is not significantly impacted. By default, **Set Up Server Backup** schedules a backup to run daily at 12:00 PM and 11:00 PM. However, you can adjust the backup schedule according to the needs of your organization. You should occasionally evaluate the effectiveness of your backup plan, and change the plan as necessary.  
  
> [!NOTE]
>  In the default installation of Windows Server Essentials, the server is configured to automatically perform a defragmentation once each week. This can result in larger than normal backups if you use non-Microsoft imaging software. If it is not necessary to defragment the server on a regular basis, you can follow these steps to turn off the defragmentation schedule:  
> 
> 1. Press the Windows key + W to open **Search**.  
>    2. In the Search text box, type **Defragment**.  
>    3. In the results section, click **Defragment and Optimize Drives**.  
>    4. In the **Optimize Drives** page, select a drive, and then click **Change settings**.  
>    5. In the **Optimization schedule** window, clear the **Run on a schedule (recommended)** check box, and then click **OK** to save the change.  
  
### Items to be backed up  
 By default, all operating system files and folders are selected for backup. You can choose to back up all the hard disks, files, and folders on the server, or select only individual hard disks, files, or folders to backup. To add or remove items for the backup, do one of the following:  
  
-   To include a data drive in the server backup, select the adjacent check box.  
  
-   To exclude a data drive from the server backup, clear the adjacent check box.  
  
> [!NOTE]
>  If you want to exclude the **Operating System** item from the backup, you must first clear the **System Backup (recommended)** check box.  
  
 To minimize the amount of backup hard disk space that your server backups use, you may want to exclude any folders that contain files that you don't consider valuable or particularly important.  
  
 For example, you may have a folder that contains recorded television programs that uses a lot of hard drive space. You may choose not to back up these files because you normally delete them after viewing them anyway. Alternatively, you may have a folder that contains temporary files that you do not intend to keep.  
  
##  <a name="BKMK_6"></a> Repartition a hard drive on the server  
 When an unformatted internal hard disk drive is detected on the Windows Server Essentials server, a health alert is raised that contains a link to the Add a New Hard Drive Wizard. The Add a New Hard Drive Wizard walks you through the various options for formatting the hard drive. When the wizard is finished, one or more, depending on the size of the drive, logical hard drives formatted will be created on the hard drive and formatted as NTFS.  
  
 If it becomes necessary to repartition a hard disk drive, follow these instructions:  
  
#### To repartition a hard disk drive  
  
1.  On the **Start** screen, click **Administrative Tools**, and then double-click **Computer Management**.  
  
2.  In Computer Management, click **Storage**, and then double-click **Disk Management**.  
  
3.  Right-click the drive that you want to repartition, click **Delete Volume**, and then click **Yes**.  
  
    > [!NOTE]
    >  Repeat this step for each partition on the hard disk drive.  
  
4.  Right-click the **Unallocated** hard disk drive, and then click **New Simple Volume**.  
  
5.  In the New Simple Volume Wizard, create and format a volume that is 16 TB (16,000,000 MB) or less.  
  
    > [!NOTE]
    >  Repeat this step until all unallocated space on the hard disk drive is used.  
  
##  <a name="BKMK_7"></a> Restore files and folders from a server backup  
 You can browse and restore individual files and folders from a server backup.  
  
#### To restore files and folders from a server backup  
  
1.  Open the Dashboard, and then click the **Devices** tab.  
  
2.  Click the name of the server, and then click **Restore files or folders for the server** in the **Tasks** pane.  
  
3.  The Restore Files or Folders Wizard opens. Follow the instructions in the wizard to restore the files or folders.  
  
## See also  
  
-   [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)
