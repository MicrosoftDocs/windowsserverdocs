---
title: "Set up or customize server backup"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 441c2d6c-435a-42cb-90f2-6d680d279d34
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Set up or customize server backup

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
  
 Server backup is not automatically configured during installation. You should protect your server and its data automatically by scheduling daily backups. It is recommended that you maintain a daily backup plan because most organizations cannot afford to lose the data that has been created over several days.  
  
 See the following sections to set up or customize server backup:  
  
-   [Set up or change server backup settings](Set-up-or-customize-server-backup.md#BKMK_1)  
  
-   [Server backup schedule](Set-up-or-customize-server-backup.md#BKMK_2)  
  
-   [Backup target drive](Set-up-or-customize-server-backup.md#BKMK_Target)  
  
-   [Items to be backed up](Set-up-or-customize-server-backup.md#BKMK_4)  
  
##  <a name="BKMK_1"></a> Set up or change server backup settings  
  
#### To set up or change server backup settings  
  
1.  Open the **Dashboard**, and then click the **Devices** tab.  
  
2.  In the List view, click your server to select it.  
  
3.  In the Tasks pane, click **Set up Backup for the server**.  
  
    > [!NOTE]
    >  If you want to change the existing backup settings, click **Customize Backup for the server**.  
  
4.  Follow the instructions in the wizard.  
  
    > [!NOTE]
    >  If you start the wizard before attaching the external hard drive to the server, click **Refresh list** on the **Select the backup destination** page after attaching the hard drive.  
  
> [!NOTE]
>  In the default installation of  Windows Server Essentials, the server is configured to automatically perform a defragmentation once each week. This can result in larger than normal backups if you use non-Microsoft imaging software. If it is not necessary to defragment the server on a regular basis, you can follow these steps to turn off the defragmentation schedule:  
> 
> 1. Press the Windows key + W to open **Search**.  
>    2. In the Search text box, type **Defragment**.  
>    3. In the results section, click **Defragment and Optimize Your Drives**.  
>    4. In the **Optimize Drives** page, select a drive, and then click **Change settings**.  
>    5. In the **Optimization schedule** window, clear the **Run on a schedule (recommended)** check box, and then click **OK** to save the change.  
  
##  <a name="BKMK_2"></a> Server backup schedule  
 When you use the Set Up Server Backup Wizard or the Customize Server Backup Wizard, you can choose to back up server data at multiple times during the day. Because the wizards schedule incremental-based backups, the backups run quickly, and server performance is not significantly impacted. By default, the wizards schedule a backup to run daily at 12:00 PM and 11:00 PM. However, you can adjust the backup schedule according to the needs of your organization. You should occasionally evaluate the effectiveness of your backup plan, and change the plan as necessary.  
  
##  <a name="BKMK_Target"></a> Backup target drive  
 You can use multiple external storage drives for backups, and you can rotate the drives between onsite and offsite storage locations. This can improve your disaster preparedness planning by helping you recover your data if physical damage occurs to the hardware onsite.  
  
 When choosing a storage drive for your server backup, consider the following:  
  
-   Choose a drive that contains sufficient space to store your data. Your storage drives should contain at least 2.5 times the storage capacity of the data that you want to back up. The drives should also be large enough to accommodate the future growth of your server data.  
  
-   When using an external storage drive, make sure that the drive is empty or contains only data that you do not need.  
  
    > [!CAUTION]
    >  The Set Up Server Backup Wizard formats the storage drives when it configures them for backup.  
  
-   If the backup target drive contains offline drives, the backup configuration will not succeed. To complete the configuration, when selecting the backup target, clear the check box to exclude drives that are offline.  
  
-   If you choose a drive that contains previous backups as the backup target, the wizard allows you choose if you want to keep the previous backups. If you keep the backups, the wizard does not format the drive.  
  
-   You should visit the website for your external storage drive manufacturer to ensure that your backup drive is supported on computers running  Windows Server Essentials.  
  
-   The drive cannot contain an Extensible Firmware Interface (EFI) system partition. If an EFI partition is present on a USB drive, it is assumed that the disk is a startup disk. If you are certain that you don't need the data on the disk, you can reformat the disk and use it for backups.  
  
    > [!CAUTION]
    >  All data will be deleted when you reformat the disk.  
  
    #### To remove an EFI system partition from a USB disk  
  
    1.  In Control Panel, open **Systems and Security**.  
  
    2.  Under **Administrative Tools**, click **Create and format hard disk partitions**.  
  
    3.  Delete all volumes on the USB disk, or just delete the EFI partition. The Set Up Server Backup Wizard will delete all volumes.  
  
-   The drive cannot contain any shared server folders. Before you can use the disk as a backup target drive, you must stop sharing on any shared server folders. You can stop sharing from the Dashboard or in File Explorer.  
  
    #### To stop sharing on a server folder from the Dashboard  
  
    1.  On the Dashboard, click **Storage**, and then click **Server Folders**.  
  
    2.  Select the folder you want to stop sharing, and then, on the task pane, click **Stop**.  
  
> [!NOTE]
>  If a backup is unsuccessful because the backup drive had insufficient space, the drive letter for the backup target drive is removed from the Windows Server Essentials database, and the Dashboard does not display the drive. If you want to use the drive in future backups, you must reassign the drive letter using a native tool.  
> 
>  **To reassign a drive letter for an existing volume**  
> 
> 1. In Control Panel, open **Systems and Security**.  
>    2. Under **Administrative Tools**, click **Create and format hard disk partitions**.  
>    3. Right-click the drive, and click **Change Drive Letter and Paths**.  
>    4. Click **Add**.  
>    5. In the Add Drive Letter or Path dialog box, select a drive letter to assign. (You can reassign the same drive letter.) Then click **OK**.  
> 
>    The drive will appear on the Dashboard immediately.  
  
##  <a name="BKMK_4"></a> Items to be backed up  
 You can choose to back up all the drives, files, and folders on the server, or select only individual drives, files, or folders to backup.  
  
 When you add or remove a drive, or add or remove shared files and folders, you should revisit the server backup configuration to make sure that these items are added to or removed from the backup configuration. To add or remove items for the backup, do one of the following:  
  
- To include a data drive in the server backup, select the adjacent check box  
  
- To exclude a data drive from the server backup, clear the adjacent check box  
  
  > [!NOTE]
  >  If you want to exclude the **Operating System** item from the backup, you must first clear the **System Backup (recommended)** check box.  
  
  To minimize the amount of server storage that your server backups use, you may want to exclude any folders that contain files that you do not consider valuable or particularly important.  
  
  For example, you may have a folder that contains recorded television programs that uses a lot of hard drive space. You may choose not to back up these files because you normally delete them after viewing them anyway. Or you may have a folder that contains temporary files that you do not intend to keep.  
  
## See also  
  
-   [Manage Server Backup](Manage-Server-Backup-in-Windows-Server-Essentials.md)  
  
-   [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)
