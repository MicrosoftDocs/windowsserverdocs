---
title: "Manage Client Computer Backup in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b4776e8-9504-4b98-ae80-11da797d9819
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Manage Client Computer Backup in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
 
 This topic includes information about common backup tasks for client computers that you can accomplish by using the Windows Server Essentials Dashboard, and includes the following sections:  
  
-   [How the Repair the Backup Database Wizard works](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Understand the computer backup settings](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Set up backup for a client computer](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_3)  
  
-   [Change the time that backup is scheduled to run](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_4)  
  
-   [Change the computer backup retention policy](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Reset backup to default settings](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_6)  
  
-   [Use repair and recovery tools](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_7)  
  
-   [Repair the backup database](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_8)  
  
-   [Disable backup for a computer](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_9)  
  
-   [Run the backup Cleanup task](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_10)  
  
-   [View alerts in the task bar on a client computer](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_11)  
  
-   [View backup status from the Launchpad](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_12)  
  
-   [Stop a backup in progress from the Launchpad](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_13)  
  
-   [Start a backup from the Launchpad](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_14)  
  
-   [How computer backup works](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_15)  
  
-   [Tips to help prevent data loss due to corruption of the client backup database](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_16)  
  
-   [Restore files or folders from a client computer backup](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_17)  
  
-   [Understanding File History](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_FileHistory)  
  
##  <a name="BKMK_1"></a> How the Repair the Backup Database Wizard works  
 If Windows Server Essentials detects errors in your backup database, it sends you a health notification, and the alert status changes to red, which indicates a critical condition.  
  
 On the Windows Server Essentials Dashboard, click the alert status icon to see the backup database error notification. The notification includes a **Repair** button, which starts the Repair the Backup Database Wizard. The wizard may take several hours to finish.  
  
 The wizard examines your backup database for the selected computer and attempts to repair the database if errors are detected. In some cases, the wizard cannot repair the entire backup database. Before you start the wizard, verify that all the external hard drives that you use on your server are connected to the server, turned on, and functioning properly. The backup database error may be fixed automatically by reconnecting a missing hard drive.  
  
> [!CAUTION]
>  You should back up the database before attempting to repair it. Depending on the type of errors found in the backup database, the wizard may not be able to recover some backups. Some or all backups may be permanently lost.  
  
##  <a name="BKMK_2"></a> Understand the computer backup settings  
 After backup is configured for client computers, you can specify a different window of time for the backup to occur. Similarly, you can specify a longer or shorter backup retention time than the default.  
  
 The **Restore to defaults** option lets you reset the backup window and retention policy to the defaults provided during initial backup configuration.  
  
 The defaults are:  
  
|Backup setting|Default|Description|  
|--------------------|-------------|-----------------|  
|Start time|6:00 PM|Specifies the time that the daily backup starts. It is recommended that you set this to a time when users are not using their computers.|  
|End time|9:00 AM|Specifies the time that the backup must be finished. If the backup does not require the duration specified, it uses only the time required to successfully backup the computer.|  
|Retain daily backups|5 days|Specifies the number of days that daily backups are retained. For example, using the default setting, 5 daily backups are retained. On the 6th day and each day thereafter, the oldest daily backup file is deleted.|  
|Retain weekly backups|4 weeks|Specifies the number of weeks that the last backup of the week is retained. For example, using the default settings, 4 weekly backups are retained. On the 5th week and each week thereafter, the oldest weekly backup is deleted.|  
|Retain monthly backups|6 months|Specifies the number of months that the last backup of the month is retained. For example, using the default setting, 6 months of backups are retained. On the 7th month and each month thereafter, the oldest monthly backup is deleted.|  
  
##  <a name="BKMK_3"></a> Set up backup for a client computer  
 If backup is disabled, you can set up backup for the computer from the Dashboard. When you set up backup for a computer, you can choose to back up everything on the computer or select the volumes and folders that you want to back up.  
  
> [!NOTE]
>  The computer must be online for you to set up backup.  
  
> [!IMPORTANT]
>   Windows Server Essentials does not support backing up and restoring dynamic disks on client computers.  
  
#### To set up backup for a client computer  
  
1.  Open the **Dashboard**, and then click the **Devices** tab.  
  
2.  Click the name of the client computer that you want to set up backup for, and then in the **Tasks** pane, click **Set up Backup for this computer**.  
  
    > [!NOTE]
    >  If backup is already set up for the client computer, **Customize Backup for this computer** is listed in the **Tasks** pane instead of **Set up Backup for this computer**.  
  
3.  In the Set Up Backup Wizard, you can choose to back up all of the folders or select certain folders that you want to back up. Follow the instructions in the wizard.  
  
4.  Click **Close** when backup is set up for the computer.  
  
### Critical system files  
 When you install the Windows operating system, the Setup program creates folders on your system drive where it places files that the system requires to start and run. Critical system files include files with .dll, .exe, .ocx, and .sys file extensions. Some of these files are True Type fonts. In addition, system state files, such as the system's registry, are required for the operating system to run properly.  
  
### Find the file you are looking for  
 You can restore all the folders for a computer, multiple files and folders, or a single file or folder from an existing backup.  
  
 After you select the backup that you want to use to restore from, the backup file is read and all the files and folders are displayed. You can drill down to the specific file or folder to restore by double-clicking the top level folder, and then drilling down through the hierarchy of folders until you locate the file that you are looking for.  
  
### Why am I unable to select some items?  
 The check box on the selection menu of the **Select which items to back up page** can indicate different status for each folder. When the check box is:  
  
- **Selected**, the associated folder and the folder contents are selected for backup.  
  
- **Unselected**, the associated folder and the folder contents are excluded from backup.  
  
- **Solid**, the associated folder is selected for backup, but one or more items within that folder are excluded from the backup.  
  
  If you cannot select a specific folder:  
  
- The volume may be configured for backup, but it may be offline. This is common for removable USB drives. Volumes that are offline are shown in grey text.  
  
- You can only back up data from a local drive that is formatted as an NTFS file system. Drives formatted as FAT (including FAT32) or ReFS file systems do not appear in the list of drives to back up.  
  
> [!IMPORTANT]
>  Volume Shadow Copy Service (VSS) does not support creating a shadow copy of a virtual volume and the host volume in the same snapshot set. VSS does support creating snapshots of volumes on a virtual hard disk (VHD), if backup of the virtual volume is necessary. For more information, see [Servicing and Backing Up Virtual Hard Disks](https://go.microsoft.com/fwlink/p/?LinkId=256577).  
  
##  <a name="BKMK_4"></a> Change the time that backup is scheduled to run  
 The backup process should be scheduled during a time when as few people as possible are using their networked computers. This is usually during the late evening or early morning hours. The default time for backup is 6:00 PM until 9:00 AM. The server attempts to back up client computers only during the scheduled window of time.  
  
 However, if your business is active during these traditionally off hours, you may want to change these default settings.  
  
#### To change the time that backup is scheduled to run  
  
1.  Open the server **Dashboard**, and then click **Devices**.  
  
2.  In **Devices Tasks**, click **Customize Computer Backup and File History settings**.  
  
    > [!NOTE]
    >  In  Windows Server Essentials, this task has been renamed **Client computer backup tasks**.  
  
3.  In **Client computer backup settings and tools**, on the **Computer Backup** tab, you can change the start and end times to meet your needs.  
  
4.  Click **Apply**, and then click **OK**.  
  
##  <a name="BKMK_5"></a> Change the computer backup retention policy  
 Daily backups of all your computers accumulate on your server over time. To help you manage these backups, Windows Server Essentials can help you manage the database of computer backups. You can configure how many backups to keep for all your computers.  
  
 The backup retention policy determines how long a backup is kept before it is deleted during the backup cleanup process. Backup cleanup runs at 11:59 PM every Saturday. It deletes all the backups that fall outside the backup retention policy. The defaults for the backup retention policy are:  
  
-   **Retain daily backups for 5 days.** The first backup of the day is retained as the daily backup. After 5 days, the oldest daily backup is deleted in the cleanup process.  
  
-   **Retain weekly backup for 4 weeks.** The first backup of the week is retained as the weekly backup. After 4 weeks, the oldest weekly backup is deleted in the cleanup process.  
  
-   **Retain monthly backups for 6 months.** The first backup of the month is retained as the monthly backup. After 6 months, the oldest monthly backup is deleted in the cleanup process  
  
#### To change the computer backup retention policy  
  
1.  Open the **Dashboard**.  
  
2.  Click **Devices**.  
  
3.  In the **Devices Tasks** pane, click **Customize Computer Backup and File History settings**.  
  
    > [!NOTE]
    >  In  Windows Server Essentials, this task has been renamed **Client Computer backup tasks**.  
  
4.  In **Client computer backup settings and tools**, in the **Client computer backup retention policy** section, make the changes to the retention policy that meets your needs.  
  
5.  When you finish, click **OK** to apply the changes and close the dialog box. The updated retention policy will be applied the next time that backup cleanup runs.  
  
    > [!NOTE]
    >  The updated retention policy applies to all of the client computers on your network that are configured for backup.  
  
##  <a name="BKMK_6"></a> Reset backup to default settings  
 After backup is configured for client computers, the network administrator may have specified a different window of time. Similarly, the administrator may have specified a longer or shorter backup retention time than the default. The **Reset to defaults** button lets you reset the backup window and retention policy to the defaults provided during initial backup configuration.  
  
 The defaults are:  
  
-   Backup start time: 6:00 PM  
  
-   End time: 9:00 AM  
  
-   Number of days that daily backups are retained: 5 days  
  
-   Number of weeks that the last backup of the week is retained: 4 weeks  
  
-   Number of months that the last backup of the month is retained: 6 months  
  
#### To reset Computer Backup to the default settings  
  
1.  Open the **Dashboard**, and then open the **Devices** page.  
  
2.  In **Devices Tasks**, click **Customize Computer Backup and File History settings**.  
  
    > [!NOTE]
    >  In  Windows Server Essentials, click **Client computer backup tasks**.  
  
3.  On the **Computer Backup** tab of the **Client computer and backup settings and tools** page, click **Reset to defaults**.  
  
    > [!NOTE]
    >  You may want to write down the customized schedule and retention policy settings because they will be gone when you reset to the default settings.  
  
4.  Click **Apply**, and then click **OK**.  
  
##  <a name="BKMK_7"></a> Use repair and recovery tools  
 **Repair backups:** If the database of computer backups becomes corrupt or unusable for some reason, you can attempt to repair the database by using the Repair the Backup Database Wizard. The wizard analyzes the backup files to determine if there are any issues that can be repaired. The wizard then attempts to fix any issues that are found.  
  
> [!WARNING]
>  If an issue cannot be fixed, the wizard may permanently delete a computer backup file.  
  
 **Computer recovery:** You can create a bootable USB flash drive to use to restore a computer from an existing backup. You must use a USB flash drive that is 1 GB or larger. After the bootable USB flash drive is created, you insert it into the computer that you want to restore, and then boot to the USB flash drive to start the full system restore process.  
  
##  <a name="BKMK_8"></a> Repair the backup database  
 If you receive an alert telling you that the computer backup database has issues, you can attempt to repair it.  
  
#### To repair the backup database  
  
1.  Open the **Dashboard**.  
  
2.  Click **Devices**.  
  
3.  In the **Devices Tasks** pane, click **Customize Computer Backup and File History settings.**  
  
    > [!NOTE]
    >  In  Windows Server Essentials, click **Client computer backup tasks**.  
  
4.  In **Client computer backup settings and tools**, click the **Tools** tab.  
  
5.  In the **Repair backups** section, click **Repair now**. The Repair the Backup Database Wizard opens.  
  
6.  Follow the instructions in the Repair the Backup Database Wizard.  
  
7.  Depending on how large the backup database is, the database repair can take several hours. Click **Close**, and then click **OK** to close the **Customize Computer Backup and File History settings** page.  
  
    > [!NOTE]
    >  In  Windows Server Essentials, click **Client computer backup settings and tools**.  
  
#### To review the results of the backup database repair  
  
1.  Open the **Dashboard**.  
  
2.  Click **Devices**.  
  
3.  In the **Devices Tasks** pane, click **Customize Computer Backup and File History settings.**  
  
    > [!NOTE]
    >  In  Windows Server Essentials, click **Client computer backup tasks**.  
  
4.  In **Client computer backup settings and tools**, click the **Tools** tab.  
  
5.  The results are displayed in the **Repair backups** section.  
  
##  <a name="BKMK_9"></a> Disable backup for a computer  
 Use the Dashboard to quickly disable backups for computers on your network.  
  
#### To disable backup for a computer  
  
1. Open the **Dashboard**.  
  
2. Click the **Devices** tab.  
  
3. Click the name of the computer for which you want to disable backups.  
  
4. In the Tasks pane, click **Customize Backup for the computer**. The Customize Backup Wizard appears.  
  
5. Click **Disable backup for this computer**, and then select whether you want to keep or delete the existing backup files.  
  
6. Click **Save changes**, and then click **Close**.  
  
   For information about how to enable backup for a computer after backup has been disabled, see [Set up backup for a client computer](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_3).  
  
##  <a name="BKMK_10"></a> Run the backup Cleanup task  
 The client computer backup cleanup task is scheduled to run at 11:59 PM every Saturday after all backups are complete. The cleanup task deletes backups from the client computer backup database according to the backup retention policy. The default settings for the backup retention policy are:  
  
- Number of days that daily backups are retained: 5 days  
  
- Number of weeks that the last backup of the week is retained: 4 weeks  
  
- Number of months that the last backup of the month is retained: 6 months  
  
  For information about changing the backup retention policy, see [Change the computer backup retention policy](Manage-Client-Computer-Backup-in-Windows-Server-Essentials.md#BKMK_5).  
  
#### To run the client backup database cleanup task  
  
1.  Log on to the server with your administrator user account and password.  
  
2.  On the server, open **Task Scheduler**. You can access the Task Scheduler program from the **Administrative Tools** console.  
  
3.  In Task Scheduler, expand **Task Scheduler Library**, expand **Microsoft**, expand **Windows**, and then click **Windows Server Essentials**.  
  
4.  Click the **Backup Cleanup** task, and then click **Run** in the **Actions** pane. The Status changes to **Running** until the task is complete.  
  
##  <a name="BKMK_11"></a> View alerts in the task bar on a client computer  
 You can receive a backup notice in the taskbar on your computer for the following reasons:  
  
-   A backup started.  
  
-   A backup ended.  
  
-   There is not a recent successful backup. The number of days since the last successful backup is included in the notice.  
  
-    Windows Server Essentials only: A new volume is added to your computer. The person who administers your network needs to run the Customize Backup Wizard to include or exclude the volume for future backups.  
  
##  <a name="BKMK_12"></a> View backup status from the Launchpad  
 Use the Launchpad to view quick backup status for your computer.  
  
> [!TIP]
>  For a quick status, move the cursor over the Launchpad icon in the notification area of the desktop. The backup status appears in the tooltip.  
  
#### To view status of a backup for your computer  
  
1.  Sign in to the **Launchpad** with your user name and password.  
  
2.  Click **Backup**.  
  
3.  In the **Backup Properties** dialog box, in the **Backup status** section, the status of the backup is displayed.  
  
    -   **No previous backups**: Either Backup has not yet run, or the backup history was deleted.  
  
    -   **Backup pending**: A backup is waiting for another process on the server to complete.  
  
    -   **Connecting**: Backup is connecting to the server.  
  
    -   **Cannot connect**: Backup cannot connect to the Windows Server Client Computer Backup Provider Service.  
  
        > [!NOTE]
        >  In  Windows Server Essentials, this service has been renamed Windows Server Essentials Client Computer Management Service.  
  
    -   **Backup in progress**: Displays the percentage of backup completed.  
  
    -   **Backup was cancelled**: Displays the date and time that the backup started if you or the network administrator cancelled the backup.  
  
    -   **Backup succeeded**: Displays the date and time that the backup started if the backup completed successfully.  
  
    -   **Backup was incomplete**: Displays the date and time that the backup started if the backup did not complete successfully.  
  
    -   **Backup was unsuccessful**: Displays the date and time that the backup started if the backup did not complete successfully.  
  
4.  Click **OK** to close the **Backup Properties** dialog box.  
  
##  <a name="BKMK_13"></a> Stop a backup in progress from the Launchpad  
 You can easily stop a backup that is in progress.  
  
#### To stop a backup in progress  
  
1.  Open the **Launchpad**.  
  
    > [!NOTE]
    >  If asked, log on to the **Launchpad** with your user name and password.  
  
2.  Click **Backup**.  
  
3.  In the **Backup Properties** dialog box, in the **Backup status** section, the **Start backup** button changes to **Stop backup** when the backup is in progress. Click **Stop backup**, and then click **Yes** to confirm. The backup will continue to run until you click **Yes**.  
  
4.  When you stop a backup in progress, the status changes to **Backup was cancelled** with the date and time that the backup started. If, instead, you see a status of **Successful**, **Incomplete**, or **Failed**, the last backup has already finished.  
  
5.  Click **OK** to close the **Backup Properties** dialog box.  
  
##  <a name="BKMK_14"></a> Start a backup from the Launchpad  
 There may be times when you want to back up your files and folders prior to the regularly-scheduled backup time set up on your server. The Launchpad enables you to initiate backup of your computer manually.  
  
#### To start a backup  
  
1.  Open the **Launchpad**.  
  
    > [!NOTE]
    >  If asked, log on to the **Launchpad** with your user name and password.  
  
2.  Click **Backup**.  
  
3.  In the **Backup Properties** dialog box, in the **Backup status** section, click **Start backup**, and then click **OK**.  
  
4.  Type a description for the backup, and then click **OK**. The status changes to **Starting backup**, and then to **Backup in process** with a percentage complete.  
  
5.  After backup starts, the button changes to **Stop backup**. If the backup is in progress and you want to stop it, click **Stop backup**, and then click **Yes**. When you stop a backup in progress, the status changes to **Backup was cancelled** with the date and time that the backup was started.  
  
6.  When the backup finishes successfully, the status changes to **Backup succeeded** with the date and time that the finished backup started.  
  
7.  Click **OK** to close the **Backup Properties** dialog box.  
  
##  <a name="BKMK_15"></a> How computer backup works  
 The following things happen during the backup each day:  
  
-   Network computers are backed up one after another.  
  
-   A backup that is in progress finishes, even if you close the backup window.  
  
-   Windows Updates are installed, and Windows Server Essentials restarts (if required).  
  
-   On Sunday, Backup Cleanup runs.  
  
> [!IMPORTANT]
>  Volume Shadow Copy Service (VSS) does not support creating a shadow copy of a virtual volume and the host volume in the same snapshot set. VSS does support creating snapshots of volumes on a virtual hard disk (VHD), if backup of the virtual volume is necessary. For more information, see [Servicing and Backing Up Virtual Hard Disks](https://go.microsoft.com/fwlink/p/?LinkId=256577).  
  
##  <a name="BKMK_16"></a> Tips to help prevent data loss due to corruption of the client backup database  
 If the client backup database becomes corrupt, you can lose critical data.  
  
 To help prevent data loss due to corruption of the client backup database, consider the following:  
  
-   Enable an additional method of backing up the client backup database. For example, depending on the version of Windows Server Essentials you are running, use Server Backup, Online Backup, or  Microsoft Azure Backup to back up the database.  
  
    > [!IMPORTANT]
    >  Make sure that you select to back up all files in the **Client Computers Backup** folder.  
  
-   In the event that you must restore the database, be sure to restore all files in the **Client Computers Backup** folder. If you do not restore all of the files, the database might become inconsistent.  
  
-   Before you clean up or restore the client backup database, make sure to stop all client backups that are currently in progress.  
  
     If you are running  Windows Server Essentials, you should also stop the Windows Server Client Computer Backup Service and the Windows Server Client Computer Backup Provider Service.  
  
     If you are running  Windows Server Essentials, you should also stop the Windows Server Computer Backup Service.  
  
     After completing the restore operation, restart the service.  
  
##  <a name="BKMK_17"></a> Restore files or folders from a client computer backup  
 You can browse and restore individual files and folders from a backup.  
  
> [!NOTE]
>  You cannot restore files and folders to a client computer by using the Dashboard on the server. You must open the Dashboard on a client computer to complete the task.  
  
> [!IMPORTANT]
>  You cannot restore files and folders to a hard disk that has been configured to be a dynamic disk.  
  
#### To restore files and folders  
  
1.  Open the **Dashboard** on a client computer.  
  
2.  Click the **Devices** tab.  
  
3.  Click the computer for which you want to restore files and folders, and then click **Restore files or folders for the computer** in the **Tasks** pane. The Restore Files or Folders Wizard opens.  
  
4.  Follow the instructions in the wizard.  
  
##  <a name="BKMK_FileHistory"></a> Understanding File History  
 The File History feature of Windows Server Essentials automatically backs up files that are in the Libraries, Contacts, Desktop, and Favorites folders of network computers that have File History capability. If the originals are lost, damaged or deleted, you can restore them. You can also find different versions of your files from a specific point in time. Over time, you will have a complete history of your files.  
  
 In  Windows Server Essentials, you can customize File History settings from the **File History** page of **Client computer backup settings and tools**.  
  
 In Windows Server Essentials, you can customize the File History settings by going to the **Users** tab, and then selecting the **Change the File History setting** task.  
  
 The File History page provides the following options:  
  
|Backup setting|Default|Description|  
|--------------------|-------------|-----------------|  
|Turn On / Turn Off|On|File History is turned on by default when you install Windows Server Essentials.|  
|Backup data|Documents and Desktop|There are three pre-configured settings, which allow you to specify a variety of backup solutions. You can choose one of the following options:<br /><br /> - Documents and Desktop<br /><br /> - All Libraries, Desktop, Contacts, and Favorites<br /><br /> - All data in Libraries, Desktop, Contacts, and Favorites excluding data in the Music, Video and Pictures Libraries|  
|Backup frequency|Every hour|Specifies how often File History creates a backup of the selected data. You can choose from several options that range from every 10 minutes to daily.|  
|Retain copies for|1 year|Specifies the amount of time that File History keeps a copy of a backup.|  
  
 For information about file history issues, see [Troubleshoot File History](../support/Troubleshoot-File-History-in-Windows-Server-Essentials.md).  
  
## See also  
  
-   [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)
