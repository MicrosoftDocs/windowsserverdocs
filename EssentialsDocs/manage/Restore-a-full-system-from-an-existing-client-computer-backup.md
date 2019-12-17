---
title: "Restore a full system from an existing client computer backup"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47e498a6-1b71-47de-88f6-8c13c221d108
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Restore a full system from an existing client computer backup

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials 
  
 Hardware and operating system failures are rare, but they can happen. A malfunctioning fan could overheat a computer motherboard and render it useless. The operating system could become corrupt and refuse to start. Fire and water damage can result in permanent hardware damage. A hard disk drive may fail or you may decide to replace it with a larger hard disk drive.  
  
 This document provides information about the following topics:  
  
-   [What is computer full system restore?](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_WhatIs)  
  
-   [How does the system restore environment work?](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_HowDoes)  
  
-   [Create a bootable USB flash drive to restore a client computer](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_CreateBootable)  
  
-   [Using the Full System Restore Wizard](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_Using)  
  
-   [Where can I find the drivers for my hardware?](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_FindDrivers)  
  
##  <a name="BKMK_WhatIs"></a> What is computer full system restore?  
 In the event that you replace a hard disk drive or your computer fails to the point where it cannot be used or does not start up, you can restore the system from a previous backup of the computer. A full system restore returns the system to the state that it was in at the time of the backup.  
  
> [!IMPORTANT]
>  You cannot perform a full system restore on computer hardware, such as a system board, that is not similar to the computer hardware that is being replaced. An installed operating system is closely dependent on the underlying hardware of the computer. However, you can perform a full system restore to a hard drive that is equal in size or larger than the one that is being replaced.  
  
 When performing a full system restore, you can choose a specific computer backup to restore the system, with all of the applications, configurations, and settings familiar to the user prior to the failure, catastrophe, or theft. You can also choose which volumes that you want to restore.  
  
 When planning or preparing to restore the full system to a network computer, considering the following:  
  
### Windows Preinstallation Environment  
 Windows Preinstallation Environment (Windows PE) is a minimal operating system designed to prepare a computer for Windows installation. For servers running Windows Server Essentials, Windows PE is installed automatically when you insert the restore media on a computer to be restored. For servers running Windows Server Essentials, Windows PE is installed automatically when you start the computer with the client restore service or with the USB flash drive.  
  
 Windows PE does not support wireless connections. Because of this, the computer being restored must be physically connected to the small business network.  
  
### BitLocker  
 BitLocker Drive Encryption (BitLocker) is a data protection feature that is available in some versions of  Windows Vista,  Windows 7, and  Windows 8. BitLocker protects against data theft or exposure on computers that are lost or stolen, and offers more secure data deletion when computers are decommissioned.  
  
 **For Windows Server Essentials:** If the computer that you need to restore was encrypted using BitLocker (whether it was just the operating system drive or the operating system drive and single or multiple other fixed drives), you can still use the full system restore media contained on the CD provided with your server and the Full System Restore Wizard to re-install the hard drive image, including the operating system, from a backup and restore the data to the new or repaired computer.  
  
 **For Windows Server Essentials:** If the computer that you need to restore was encrypted using BitLocker (whether it was just the operating system drive or the operating system drive and single or multiple other fixed drives), you can still use the Full System Restore Wizard to re-install the hard drive image, including the operating system, from a backup and restore the data to the new or repaired computer.  
  
 When the server backs up drives, folders, and files, an unencrypted version is saved to the server. During full system restore, this unencrypted version is copied to the computer.  
  
> [!NOTE]
>  After a successful full system restore, you must reactivate BitLocker on the computer.  
>   
>  For instructions about how to enable BitLocker on computers that are running  Windows 8, see [BitLocker: How to enable BitLocker](https://go.microsoft.com/fwlink/p/?LinkID=254918).  
>   
>  For instructions about how to enable BitLocker on computers that are running  Windows 7, see [BitLocker Drive Encryption Step-by-Step Guide for Windows 7](https://go.microsoft.com/fwlink/p/?LinkId=140225).  
  
 For more information about BitLocker Drive Encryption basics, see [BitLocker Frequently Asked Questions (FAQ)](https://go.microsoft.com/fwlink/p/?LinkID=254917).  
  
### Encrypting File System-encrypted files  
 The Encrypting File System (EFS) feature in Windows can provide additional user-based file level encryption for different levels of security among multiple users of the same computer. It is important to note that, unlike BitLocker-encrypted drives, EFS-encrypted folders and files continue to be encrypted in any computer backup. EFS is not available in Windows XP Home Edition,  Windows Vista Starter,  Windows Vista Home Basic, Windows Vista Home Premium,  Windows 7 Starter,  Windows 7 Home Basic,  Windows 7 Home Premium, or Windows 8. It is only available in Windows 8 Pro.  
  
> [!WARNING]
>  Unlike BitLocker, you can only access EFS-protected files from within the operating system that encrypted them.  
  
### Disk partitions  
 If the hard disk drive size on the new computer is the same, or larger than, the original, the hard disk drive is automatically reformatted and repartitioned. Refer to the chart below for specifics:  
  
|Original Computer|Restored or New Computer|  
|-----------------------|------------------------------|  
|Single disk with multiple partitions|Single disk with multiple partitions and any extra space is allocated to the last partition|  
|Single disk with a single partition|Single disk with a single partition, and all available space is used for the single partition|  
  
> [!NOTE]
>  If there are disk size and partition layout differences between the original and the restored or new computer, you must use Disk Management to create the appropriate partitions on the restored or new computer. You can do this in the Full System Restore Wizard.  
  
### RAID and dynamic disks  
 Backing up redundant array of independent disks (RAID) and dynamic disks is not supported.  
  
##  <a name="BKMK_HowDoes"></a> How does the system restore environment work?  
 The system restore media supplied with  Windows ServerÂ® 2012 Essentials installs Windows Preinstallation Environment (Windows PE) on the computer. Windows PE replaces the MS-DOS environment and contains the core program files for Windows. In Windows Server Essentials, there are two supported ways to restore a system: using the client restore service, which uses a network and does not rely on media, or using the USB flash drive.  
  
> [!NOTE]
>  Windows PE does not support wireless connections. Because of this, the computer being restored must be physically connected to the small business network.  
  
 The system restore environment comes with 32-bit (x86) and 64-bit (x64) program files. After inserting the system restore media, choose the appropriate version of the files. 32-bit (x86) is the default, and is selected automatically if you do not choose within 30 seconds. If there are updates to the full system restore program files on the server, the updated files are downloaded to the computer automatically.  
  
 After the preinstallation environment is set up, the Full System Restore Wizard starts. The wizard helps you restore your computer from a previous backup. You can also use the system restore environment to restore a backup to a new computer with similar hardware.  
  
 In most instances, the program files and drivers contained on the system restore environment are all that is needed to restart the new or restored computer. Depending on the new or restored computer hardware, the system restore environment may not include all of the storage and network adapter drivers that are required when you restart your new or restored computer. The Full System Restore Wizard gives you an opportunity to install drivers, if necessary. For information about finding your hardware drivers, see [Where can I find the drivers for my hardware?](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_FindDrivers). For information about how to use the system restore media, see [Using the Full System Restore Wizard](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_Using).  
  
##  <a name="BKMK_CreateBootable"></a> Create a bootable USB flash drive to restore a client computer  
 If you need to restore a client computer from an existing backup but cannot locate the Restore CD that came with your server (in Windows Server Essentials) or you do not want to set up the client restore service on your server (in Windows Server Essentials), you can create a bootable USB flash drive. You can then use the USB flash drive to start the client computer and restore the system. The USB flash drive that you use must be at least 1 GB or larger.  
  
#### To create a bootable USB flash drive  
  
1.  Open the **Dashboard**.  
  
2.  Click the **Devices** tab.  
  
3.  In **Tasks** pane, click **Customize Computer Backup and File History settings**.  
  
    > [!NOTE]
    >  In Windows Server Essentials, click **Client computer backup tasks**.  
  
4.  Click the **Tools** tab, and then click **Create key** in the **Computer recovery** section. The Create Computer Recovery Key Wizard opens.  
  
5.  Insert a 1 GB or larger USB flash drive in the server, and then follow the instructions in the wizard.  
  
    > [!CAUTION]
    >  All data on the USB flash drive will be deleted.  
  
##  <a name="BKMK_Using"></a> Using the Full System Restore Wizard  
 After successfully using the restore media, client restore service, or USB flash drive to start your computer and verify that all hardware drivers are loaded on the restored or new client computer, the Full System Restore Wizard appears. This wizard enables you to access the server, the computer backup, and the source volumes that you want to restore to the computer, and performs the actual restore process.  
  
> [!NOTE]
>   Windows Server Essentials does not support the following restore scenarios:  
> 
> - Restoring a Master Boot Record (MBR) disk to a Unified Extensible Firmware Interface (UEFI)-based computer.  
>   -   Restoring a UEFI/GPT backup to a BIOS system.  
> 
>   If you restore data in either of these scenarios, you will not be able to boot the system. In addition, you might not be able to use hard drives that are larger than two terabytes in size.  
  
 **Prerequisites:**  
  
-   Before starting the full system restore process, use a network cable (a wired connection) to connect the computer to the same network as the server. Make sure that you have access to all hard drives on the client computer.  
  
    > [!WARNING]
    >  Do not attempt to perform a full system restore to a computer that uses a wireless connection to the network.  
  
-   If you know that the computer is missing critical network or storage device drivers, you will need to locate and copy those drivers to a flash drive before starting the full system restore process. For Windows Server Essentials: If you are using the full system restore media that is provided on CD, that CD must remain in the drive during the start portion of the full system restore process. Therefore, you should not copy the missing drivers onto a CD or DVD unless you have a second CD/DVD drive. Instead, copy the missing drivers to a USB flash drive.  
  
     For information about how to find the drivers for your computer, see [Where can I find the drivers for my hardware?](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_FindDrivers)  
  
-   For Windows Server Essentials: If you cannot locate the  Windows Server Essentials Restore CD, you can create a bootable USB flash drive. For more information, see [Create a bootable USB flash drive to restore a client computer](Restore-a-full-system-from-an-existing-client-computer-backup.md#BKMK_CreateBootable).  
  
#### To use the Full System Restore Wizard  
  
1. Do one of the following:  
  
   -   Windows Server Essentials: Turn on the client computer that you want to restore, insert the restore media, and then turn the computer off.  
  
        Turn the computer on again, and during Power On Self Test (POST), press the appropriate function key (F-key) to access the Boot Device Menu, and then select the CD/DVD drive. The Windows Boot Manager starts.  
  
   -   Windows Server Essentials: If you are using the client restore service, restart the computer using the **Boot from network** option. Otherwise, start the computer using the USB key.  
  
        Turn the computer on again, and during Power On Self Test (POST), press the appropriate function key (F-key) to access the Boot Device Menu, and then select **Boot from network** (or you can choose to boot from the USB key). The Windows Boot Manager starts.  
  
   > [!NOTE]
   >  Check the documentation from your computer manufacturer to determine which function key accesses the Boot Device Menu.  
  
2. The computer restore media contains 32-bit (x86) and 64-bit (x64) boot options. In the Windows Boot Manager, choose **Full System Restore (x86)** or **Full System Restore (x64)**. If the computer hardware drivers are 32-bit, choose x86; if they are 64-bit, choose x64. Windows files are loaded, and the Full System Restore Wizard performs a check to make sure that all hardware drivers are available.  
  
3. In the **Full System Restore Wizard** window, choose your preferred language, and then click the arrow.  
  
4. Choose the appropriate **Time and currency format**, and the **Keyboard or input method** for this computer. Click **Continue**.  
  
5. If drivers are missing, the message The restore process cannot verify the drivers is displayed. Click **Close**, and then on the Welcome dialog box click **Load drivers**.  
  
   1.  On the **Detect Hardware** dialog box, click **Install drivers**.  
  
   2.  Insert the USB flash drive that contains the hardware drivers, and then on the **Install Drivers** dialog box, click **Scan**.  
  
   3.  On the **Install Drivers** dialog box, click **OK** when the drivers are found.  
  
   4.  On the **Detect Hardware** dialog box, click **Continue**.  
  
6. If all drivers were found in the initial check or when all critical drivers are installed, on the **Full System Restore** window, click **Continue**.  
  
7. On the **Welcome to the Full System Restore Wizard** page, click **Next**.  
  
8. The wizard searches for your server.  
  
   1.  If the wizard cannot locate your server, you are given the option to search again, or to enter the IP address of the server.  
  
   2.  If multiple servers were detected, you are asked to select one.  
  
   3.  If your server is located, the **Log on to <YourServerName\>** page is displayed.  
  
9. On the **Log on to <YourServerName\>** page, type *<AdministratorAccountName\>* in the **User name** text box, and the administrator account password in the **Password** text box, and then click **Next**.  
  
    > [!IMPORTANT]
    >  You must use an administrator account that is created in English. If you do not have one, then you must create a new administrator account. To do so, first open the **Users** tab on the server dashboard, next set the keyboard language format to English, and then run the **Add a user account** task to create the administrator account. Next, use the new administrator account to continue to restore the client computer.  
  
10. On the **Select a computer to restore** page, select the computer you want to restore, and then click **Next**. You can choose either **<ComputerName\>: (This computer)** or choose a different computer on the network from the **Another computer** drop down list.  
  
    > [!NOTE]
    >  If this is a computer that is unknown to the server (for example, a new or a repurposed computer), the **This computer** option is not displayed.  
  
11. On the **Select a backup to restore** page, review the list of available backups and select the one that you want to restore to the computer.  
  
    > [!NOTE]
    >  It is recommended that you select a successful (green-checked) backup. This helps ensure that all system and data files are restored successfully.  
  
12. (*Optional*) Select a backup and then click **Details** to open the **Backup Details** page and view more information about that backup. Use the information on the **Backup Details** page to compare multiple backups and help you decide which backup is the best choice. Click **Close** on the **Backup Details** page to return to the **Select a backup to restore** page.  
  
13. On the **Select a backup to restore** page, select a backup and then click the **Next** button.  
  
14. On the **Select restore option** page, click one of the following, and then click **Next**.  
  
    > [!NOTE]
    >  This page is not displayed if automatic partitioning is not supported.  
  
    1.  **Let the wizard fully restore the computer (recommended)**. This option helps assure that the computer is restored to the state that it was just prior to the time and date of the backup that you chose. If you choose this option, skip to step 15.  
  
    2.  **Let me select volumes to restore (advanced)**. This option allows you to choose the volumes that you want to restore and where you want to restore them. You can also create partitions on the hard drive.  
  
15. On the **Select the volumes to restore** page, you can choose the volumes that you want to restore.  
  
    > [!NOTE]
    >  This page is displayed if there are multiple hard drives on the backup source computer, or if the restore destination drive has less storage space than the backup source drive.  
  
    1. The wizard attempts to match the source and destination volumes. You should verify that the default mapping is correct.  
  
       1.  To deselect a volume, click the list menu arrow for that volume, and then click **None**.  
  
       2.  When you finish selecting the volumes, click **Next**.  
  
    2. If the source volume and the destination volume are the same size, or if the source size is smaller than the destination, a green arrow appears between the two. If there is a volume size mismatch (where the source volume is bigger than the destination volume), a red X appears between the source and the destination.  
  
       > [!NOTE]
       >  A red X can also appear if:  
       > 
       > - The disk sector size of the source volume does not match the disk sector size of the destination volume. This can occur if you replace the physical disk with a disk that has a different sector size, or if you configure Storage Spaces (which may have a different sector size than that of the physical disk).  
       >   -   You reach the cluster number limitation. To restore the source volume to the destination volume, you must format the destination volume with the same cluster size as the source volume. If the destination volume is too large, and if the cluster size is too small, you can reach cluster number limitation.  
  
       1. Click **Run Disk Manager (advanced)**, and create a new volume that is the same size as the system reserved volume.  
  
          > [!NOTE]
          >  If a client computer is Unified Extensible Firmware Interface (UEFI)-based, you must use the **diskpart** tool to initialize the system disk. To do this, open a command window (press Ctrl+Alt+Shift for 5 seconds in the WinPE environment), run **diskpart.exe**, and then run the following diskpart commands:  
          > 
          > 1. **DISKPART>  list disk**  
          >    2. **DISKPART> select disk #** *<disk\>*  
          >    3. **DISKPART> clean**  
          >    4. **DISKPART> convert gpt**  
          >    5. **DISKPART> create partition efi size=** *100* (where *100* is an example partition size in MB, should be the same as the original partition)  
          >    6. **DISKPART> create partition msr size=** *128* (where *128* is an example partition size in MB, should be the same as the original partition)  
          >    7. **DISKPART> exit**  
  
       2. *(Optional)* Select the option **Do Not Assign a Drive Letter or Drive Path**.  
  
       3. Format the volume as **NTFS**.  
  
       4. When formatting is complete, right-click the new system volume, and then click **Mark Partition as Active**.  
  
       5. If you require additional volumes to correspond with other volumes in the backup, repeat steps *ii* through *iv* to create and activate the volumes, and then close **Disk Management**.  
  
       6. On the **Select the volumes to restore** page, map the system reserved volume of the backup source to the volume of the same size that you created in step *v*.  
  
       7. Map all other source volumes to the corresponding destination volumes.  
  
       8. Click **Next** to continue with the restore.  
  
16. On the **Confirm volumes to restore** page, review the mapping, and then click **Next**. If you need to make any changes, click **Back**, and then repeat step 14.  
  
17. The **Restoring <ComputerName\> from <Date and time of backup\>** page reports the progress of the restore process.  
  
18. On the **The restore finished successfully** page, remove the restore media, and then click **Finish**. The computer restarts.  
  
    > [!IMPORTANT]
    >  If BitLocker Drive Encryption was enabled on the computer before the restore, you must enable BitLocker manually after the computer restarts.  
  
##  <a name="BKMK_FindDrivers"></a> Where can I find the drivers for my hardware?  
 Depending on the new or restored computer hardware, the restore media may not include all of the storage and network adapter drivers that are needed when you restart your restored computer. You must determine which drivers are missing, locate those drivers on existing media or on the manufacturer's website, copy them to a flash drive, and then copy them from the flash drive to the new or restored computer when you run the Full System Restore Wizard.  
  
 When a computer is backed up, the drivers for the computer are saved in the backup. If your recovery media does not include all of the drivers that you need, you can open a backup for that computer, and then copy the drivers to a USB flash drive.  
  
#### To copy drivers from a backup to a USB flash drive  
  
1. On another computer, open the Dashboard.  
  
2. Click **Devices**, and then click the computer for which you need drivers.  
  
3. Click **Restore files or folders for the computer**. The Restore Files or Folders Wizard opens.  
  
4. Click the most recent successful backup, and then click **Next**.  
  
5. Click a volume to open, and then click **Next**. A window opens that lists the files and folders in the backup.  
  
6. Insert your USB flash drive in a USB connector on the computer, and then copy the Drivers for Full System Restore folder to your USB flash drive.  
  
   > [!NOTE]
   >  You may need to click **Up one level** until you reach the root of the system volume.  
  
7. Remove the flash drive, and then insert it into the computer that you are restoring.  
  
   You can use the USB flash drive to install the drivers for your computer when you restore it. The Restore Files or Folders Wizard looks for additional drivers on this USB flash drive while using the Full System Restore Wizard. The drivers that you are most likely to need are the network adapter driver and storage device drivers.  
  
## See also  
  
-   [Manage Backup and Restore](Manage-Backup-and-Restore-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
