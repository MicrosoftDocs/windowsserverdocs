---
title: "Restore or repair your server running Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 27bf6f24-30c4-4935-9b24-069eb43e22f4
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Restore or repair your server running Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
 
 This topic provides an overview and supporting procedures for restoring or repairing a server running  Windows Server Essentials, and includes the following sections:  
  
-   [Overview of server system restores](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_Overview)  
  
-   [Restore or repair the system drive](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_Restore)  
  
-   [Restore files and folders on the server](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_RestoreFilesAndFolders)  
  
##  <a name="BKMK_Overview"></a> Overview of server system restores  
 The state of the server when you perform a restore affects the restore method that is available and how comprehensive a restore you can perform.  
  
 The most common reasons for restoring a server are:  
  
- A virus on the server cannot be inoculated or deleted.  
  
- The server configuration settings are bad, and you cannot start the server.  
  
- You replaced the system drive.  
  
- You are retiring the server, and you want to restore to a new server.  
  
  You can either restore the server from a backup, or you can restore the server to factory default settings.  
  
- [Restoring the server from a backup](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_RestoreFromBackup)  
  
- [Resetting the server to factory default settings](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_FactoryReset)  
  
###  <a name="BKMK_RestoreFromBackup"></a> Restoring the server from a backup  
 This section provides guidance on what type of backup to choose.  
  
 If a backup is available, your best choice for restoring your server is to use the manufacturer's installation media to restore from an external backup. The restoration will recover server settings and folders from the backup that you choose. You only need to configure settings and restore data created after the backup.  
  
 When you choose to recover your server by restoring from a previous backup, you must choose the specific backup that you want restored, and you must have a valid backup file on an external hard drive that is directly connected to the server:  
  
- **If you have a very recent successful backup of the server**, and you know that the backup contains all of your critical data, your choice is fairly straightforward. You will only need to recreate data that was created after your last good backup and reconfigure settings changes made after the backup.  
  
- **If you are restoring your server because of a virus**, select a backup that you know occurred prior to receiving the virus. You might need to go back several days to select a backup that is clean.  
  
- **If you are restoring your server because of bad configuration settings**, select a backup that you know occurred prior to the configuration setting change that is causing the issue on the server.  
  
  When you restore from a backup, the exact process and the required follow-up depend on the number of hard drives on the server and whether the system drive is replaced:  
  
- **If the server has a single hard drive and the drive is not replaced**, the drive partition information is left intact when you restore the server. The system volume is restored, and the data on the remaining volume is preserved.  
  
- **If the server has a single hard drive and the drive is replaced**, the system volume is restored, and then you must manually restore folders to the data volume. Any non-default shared folders need to be created because they are not created when the server storage is recreated.  
  
- **If the server has multiple hard drives, and drive 0 (contains the system volume) is not replaced**, the drive partition information is left intact when you restore the server. The system volume is restored, and the data on all remaining volumes is preserved.  
  
- **If the server has multiple hard drives, and drive 0 (contains the system volume) is replaced**, the system volume is restored, and then you must manually restore any shared folders that were previously stored on drive 0.  
  
###  <a name="BKMK_FactoryReset"></a> Resetting the server to factory default settings  
 If you do not have a backup that you can restore from, or for some other reason you want or need to perform a full system restore without restoring the previous server configuration, you can perform a restore that resets the server to factory default settings by using installation or recovery media from the server hardware manufacturer.  
  
 When you restore your server by resetting it to factory default settings, all existing settings and installed applications on your server are deleted, and you must configure your server again. After a factory reset, your server restarts.  
  
 When you perform a factory reset, you can choose to keep your data or delete it, with the following effects:  
  
-   If you choose to keep all your data, all data on the system volume is deleted, but the data on other volumes is retained.  
  
    > [!CAUTION]
    >  If the disk settings do not match the default settings, all data on a disk will be deleted. If you replaced the system disk, the new disk must be larger than the original disk's system volume.  
    >   
    >  If the partition information for a system drive is unreadable, or if you replace the system drive, all data on the system drive will be removed, even if you choose to keep all your data.  
  
-   If you plan to decommission or repurpose the server, choose to delete all of your data. In addition to the server configuration, other settings, and the data on the system volume, all other data is deleted, and all hard drives on the server are reformatted.  
  
> [!NOTE]
>  If Storage Spaces is configured on the server, before you perform a factory reset, you should use the **Advanced** section of the **Manage Storage Spaces** console to manually remove all storage spaces.  
  
 After a factory reset, you will need to perform the following tasks:  
  
-   **Reconfigure the server.** On the server, use the Configure Server Wizard to reenter configuration settings. To configure a remotely managed  Windows Server Essentials server from a client computer, open a web browser, and then type **http://**_<YourServerName\>_ in the address bar.  
  
-   **Reconnect client computers to the server.** If a computer was previously connected to the server, you must uninstall the  Windows Server Essentials Connector software from the computer before you connect the computer to the server again. For more information, see [Uninstall the Connector software](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_13) and [Connect computers to the server](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_9).  
  
##  <a name="BKMK_Restore"></a> Restore or repair the system drive  
 The first step in server restoration is to restore or repair the server system drive. After you restore the system drive, you will do whatever is needed to restore the data drives on the server and restore any sharing that was lost in the restore.  
  
 Three methods are available for performing the restore:  
  
-   [Restore or repair your server using installation media](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_Restore_1). Use the installation media from the server manufacturer to restore from a backup.  
  
-   **Use the installation media to restore the server to default factory settings**. To find out how to do this on your server, see the documentation from the server manufacturer.  
  
-   [Restore or reset your server from a client computer using the recovery DVD](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_Restore_2). If you need to restore a remotely administered server that is running  Windows Server Essentials, you must perform the restore from a client computer by using the restoration DVD from the server manufacturer.  
  
###  <a name="BKMK_Restore_1"></a> Restore or repair your server using installation media  
 The following procedure describes how to restore your server system drive from a backup by using the  Windows Server Essentials installation media. (To find out how to use the installation media to restore to factory default settings, see the documentation from the server manufacturer.)  
  
> [!NOTE]
>  If the server uses Storage Spaces, and you are restoring the data to a new server, you should recover the system drive first, and then log on to the  Windows Server Essentials Dashboard, configure Storage Spaces in a similar way as on the old server, and then recover the data volumes.  
  
##### To restore the server system drive from a backup using installation media  
  
1.  Insert the  Windows Server Essentials installation DVD in the server DVD drive, restart the server, and then press any key to start from the DVD.  
  
    > [!NOTE]
    >  If the restore process does not start automatically, check the BIOS settings for your server to ensure that the DVD drive appears first in the boot menu.  
  
     -Or-  
  
     If the manufacturer preloaded the installation media on the server, press F8 at startup to start from the installation media.  
  
2.  After the Windows Server files load, choose your language and other preferences, and then click **Next**.  
  
3.  On the next page of the wizard, click **Repair your computer**.  
  
    > [!CAUTION]
    >  Do not choose the **Install now** option. That option will guide you through a full system installation that deletes all configuration settings and all data on the system drive.  
  
4.  On the **Choose an option** page, click **Troubleshoot**.  
  
5.  On the **System Image Recovery** page, select the current system ?either **Windows Server Essentials** or **Windows Server Essentials**.  
  
     The Re-image Your Computer Wizard opens.  
  
6.  On the **Select a system image backup** page, you can choose to use the latest backup or you can select an earlier backup. The system will be restored to the state that it was in at the time of the backup that you choose for restoring or repairing your server. Data that was added or changes to settings that were made after the backup was saved must be recreated.  
  
     Select one of the following options, and then click **Next**:  
  
    -   **Use the latest available system image (recommended)**  
  
    -   **Select a system image**  
  
    > [!NOTE]
    >  If you have a very recent successful backup of the server, and you know that the backup contains all of your critical data, your choice is fairly straightforward. You will only need to recreate data that was created after your last good backup and reconfigure settings changes made after the backup.  
    >   
    >  If you are restoring your server because of a virus, select a backup that you know occurred prior to receiving the virus. You might need to go back several days to select a backup that is clean.  
    >   
    >  If you are restoring your server because of bad configuration settings, select a backup that you know occurred prior to the configuration setting change that is causing the issue on the server.  
  
7.  Follow the instructions in the wizard to complete the system restore.  
  
8.  After the server is successfully restored, remove the installation DVD if you used one, and then restart the server.  
  
> [!NOTE]
>  To restore and share folders on the server, you may need to take additional steps. For more information, see [Restore files and folders on the server](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_RestoreFilesAndFolders).  
  
###  <a name="BKMK_Restore_2"></a> Restore or reset your server from a client computer using the recovery DVD  
 In  Windows Server Essentials, you can start the server from a bootable USB flash drive that you create, and then you recover the server from a client computer by using the recovery DVD that you received from the server manufacturer. The client computer must be on the same network as the server. This method is not available in  Windows Server Essentials.  
  
 The following procedure provides general steps for performing a server restore. The steps are equally applicable for restoring from a back or restoring to factory default settings. For more specific instructions, see the documentation from your server manufacturer.  
  
##### To restore or reset the server from a client computer using the recovery DVD  
  
1.  Insert the  Windows Server Essentials server recovery media that you received from the server manufacturer in a client computer.  
  
     The Recover Your Server Wizard opens.  
  
2.  Follow the instructions in the wizard to create a bootable USB flash drive that you will use to start the server in recovery mode.  
  
3.  After the Recover Your Server Wizard prepares the bootable USB flash drive, insert the flash drive in the server, and then start the server in recovery mode. To learn how to start your server in recovery mode, refer to the documentation from the manufacturer of your server hardware.  
  
     After you start the server in recovery mode, the Recover Your Server Wizard locates the server and then establishes a connection.  
  
4.  Follow the instructions in the wizard to finish restoring the server.  
  
> [!NOTE]
>  This method of server recovery ignores external storage devices that are attached to the server during the recovery. If you want to erase the data on an external storage device, you must do so manually.  
  
> [!NOTE]
>  If you created additional shared folders on the server, after you restore the data from the backup, the additional shared folders might not be recognized by the server. You must share those folders again. For more information, see [Restore files and folders on the server](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_RestoreFilesAndFolders).  
  
##  <a name="BKMK_RestoreFilesAndFolders"></a> Restore files and folders on the server  
 Depending on the method that you used to restore or repair your server, and the type of storage the server uses, you might need to recover the data volumes after you restore the system drive. In some case, you might need to share existing folders again so that the server recognizes them.  
  
 Following are some examples of when you may need to restore files and folders:  
  
-   [Restore files and folders from a server backup](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_RestoreFilesFromBackup). If you replaced the system disk, or if the partition information on the system disk is unreadable, you can restore the system, but you cannot restore data from other volumes on this disk. To restore files and folders from other data volumes, you must use the Restore Files and Folders Wizard.  
  
-   [Restore shared folders on the server](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_ConfigreSharedFolders). If you created additional shared folders on the server, after you restore the system drive from the backup, the shared folders are still on the data partition or were restored to the data partition, but might not be recognized by the server. You must share those folders again.  
  
###  <a name="BKMK_RestoreFilesFromBackup"></a> Restore files and folders from a server backup  
 The Restore Files and Folders Wizard helps you protect your data if your hard disk stops working or your files are accidentally erased. With  Windows Server Essentials Backup, you can create a copy of all the data on your hard drive and store the data on an external storage device. If the original data on your hard drive is accidentally erased, overwritten, or becomes inaccessible because of a malfunction, you can restore the data from the backup. The Restore Files or Folders Wizard helps you restore a single file or folder, multiple files or folders, or an entire hard drive from an existing backup.  
  
 After a system restore, you might need to use the Restore Files and Folders Wizard to restore files and folders that were not retained during the restore. For example, if you replaced the system disk, or if the partition information on the system disk is unreadable, you cannot restore data from other volumes on the system disk.  
  
> [!NOTE]
>  You cannot use the Restore Files and Folders Wizard to restore the full system drive. For information about how to restore the full system, see [Restore or repair your server using installation media](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_Restore_1) or [Restore or reset your server from a client computer using the recovery DVD](Restore-or-repair-your-server-running-Windows-Server-Essentials.md#BKMK_Restore_2).  
  
##### To restore files and folders from a server backup  
  
1.  Open the  Windows Server Essentials Dashboard, and then click the **Devices** tab.  
  
2.  Click the name of the server, and then click **Restore files or folders for the server** in the **Tasks** pane.  
  
     The Restore Files and Folders Wizard opens.  
  
3.  Follow the instructions in the wizard to restore the files or folders.  
  
> [!WARNING]
>  For more information about backing up and restoring files and folders, see [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md).  
  
###  <a name="BKMK_ConfigreSharedFolders"></a> Restore shared folders on the server  
 After you restore the server's system drive, if shared folders are still on the data partition or were restored to the data partition, you might need to configure the shared folders again in order for the server to recognize the folders. The following procedure describes how to add shared folders that have been shared before.  
  
##### To add an existing folder to the server shared folders  
  
1.  In File Explorer, locate the shared folder on the hard drive.  
  
2.  Right-click the shared folder, click **Properties**, click the **Sharing** tab, and then write down the folder permissions.  
  
3.  Log on to the  Windows Server Essentials Dashboard, click the **Storage** tab, and then click **Add a folder** in the **Server Folders Tasks** pane.  
  
     The Add a Folder Wizard opens.  
  
4.  Type a name for the share in the **Name** box.  
  
5.  Click **Browse**, navigate to *<drive\>\\<ServerName\>*\ServerFolders (for example *d:\Contoso\ServerFolders*), select the folder that you want to share, and then click **OK**.  
  
6.  Click **Next**.  
  
7.  Specify the permissions that you wrote down in step 2, and then click **Add folder**.  
  
    > [!IMPORTANT]
    >  These permissions will replace any existing permissions that were not added to the folder by using the  Windows Server Essentials Dashboard.  
  
> [!IMPORTANT]
>  After you finish adding folders to the list of shared folders, ensure that the folders are included in the server backup. For information about adding folders to the server backup, see [Set up or customize server backup](Set-up-or-customize-server-backup.md).  
  
## See also  
  
-   [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)
