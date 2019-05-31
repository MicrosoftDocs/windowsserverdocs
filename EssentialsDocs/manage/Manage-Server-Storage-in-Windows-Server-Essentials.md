---
title: "Manage Server Storage in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1836682e-c7bb-4dd5-a2b5-6ff032693574
author: nnamuhcs
ms.author: coreyp
manager: dongill
---



# Manage Server Storage in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
   
 Windows Server Essentials enables you to manage all your server storage (including hard drives and storage spaces) from the **Hard Drives** pages on the **Storage** tab of the Dashboard.  
  
 The following sections provide information that will help you increase your server storage, understand and use storage spaces, and manage your hard drives:  
  
-   [Manage hard drives using the Dashboard](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Increase storage on the server](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Perform checks and repairs on hard drives](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_Check)  
  
-   [Format hard drives](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_3)  
  
-   [Add a new hard drive](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_4)  
  
-   [Storage Spaces Overview](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Create a storage space](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_6)  
  
##  <a name="BKMK_1"></a> Manage hard drives using the Dashboard  
 Windows Server Essentials allows you to manage all the hard drives that are connected to the server through the Dashboard. On the Dashboard **Storage** tab, **Hard Drives** displays all the hard drives that are available on the server for storing data and server backups. The server monitors the space available on each hard drive, and displays an alert if hard drive space becomes low. The **Hard Drives** tab displays the following information:  
  
- The name of each hard drive  
  
- The capacity of each hard drive  
  
- The amount of used space on each hard drive  
  
- The amount of free space on each hard drive  
  
- The status of each hard drive; a blank status means that the hard drive is operating properly  
  
- The details pane, which displays all the storage stack information (for storage pool, storage space, and hard drive) if the selected hard drive is located on a Storage Space (instead of a physical disk)  
  
  The following table lists the hard drive management tasks that are available in the Dashboard and their descriptions. Some of the tasks are displayed only when a hard drive is selected.  
  
### Available hard drive management tasks  
  
|Task Name|Description|  
|---------------|-----------------|  
|**View the hard drive properties**|Opens the *HardDriveName***Properties** page. This task is displayed when the hard drive is selected. The **General** tab of the *HardDriveName* Properties page includes the following additional tasks:<br /><br /> -   **Drive cleanup**:  Allows you to clean up unused files on the hard drive (this task is only available in  Windows Server Essentials).<br />-   **Check and repair**:  Checks the hard drive for file system errors and attempts to repair detected errors automatically.<br /><br /> The **Shadow Copies** tab of the *HardDriveName***Properties** page allows you to enable shadow copies. This tab also displays the next time that shadow copies is scheduled to run.|  
|**Manage Storage Spaces**|**Note:** For  Windows Server Essentials, this task is only displayed when there is an existing storage space.<br /><br /> Opens the **Storage Spaces** control panel, from which you can create and manage storage pools and storage spaces.|  
|**Create a storage space**|Opens the Create a Storage Space Wizard, which allows you to use one or more hard drives to increase the capacity of a storage pool.|  
|**Increase storage pool capacity**|**Note:** This task is only visible if the selected hard drive is located on a storage space.<br /><br /> Opens the Increase Capacity of a Storage Pool Wizard, which allows you to use one or more hard drives to increase the capacity of a storage pool.|  
  
##  <a name="BKMK_2"></a> Increase storage on the server  
 To increase the storage on the server, you can add an additional internal hard disk to the server. To add the additional internal hard disk, you must shut down the server, add the internal hard disk, and then restart the server. You do not need to shut down the server if the hard disk is attached to the SCSI controller. In that case, the hard disk can be plugged in while the server is running.  
  
 Depending on whether the hard disk to be added is formatted, do one of the following:  
  
-   **Formatted** If the internal hard disk is formatted with NTFS or ReFS, the server assigns it a drive letter, and the hard disk appears on the **Hard Drives** tab. You can now create or move server folders to the new hard drive.  
  
-   **Not formatted** If the internal hard disk is unformatted, the following alert appears: One or more unformatted hard drives are connected to the server. Use the following procedure to format the hard disk.  
  
#### To format the hard disk  
  
1.  Open the Dashboard.  
  
2.  In the navigation pane, click the alert icon to launch the **Alert Viewer** in  Windows Server Essentials, or the **Health Monitoring** tab in  Windows Server Essentials.  
  
3.  In the **Alert Viewer** or the **Health Monitoring** tab, click the alert, and then in the tasks pane, click **Troubleshoot this issue**.  
  
4.  Follow the instructions to complete the Add a New Hard Drive Wizard.  
  
###  <a name="BKMK_Clean"></a> To clean up the hard drive  
  
1.  Open the Dashboard.  
  
2.  In the navigation pane, click **Storage**, and then click **Hard Drives**.  
  
3.  In the **Hard drives** section, select the drive letter that was assigned to the newly added hard disk, and in the task pane, click **View the hard drive properties**.  
  
4.  In **<Driveletter\> Properties**, on the **General** tab, click **Drive cleanup**.  
  
##  <a name="BKMK_Check"></a> Perform checks and repairs on hard drives  
 The hard drives check and repair process verifies the health of the file system stored on the hard drives. It runs a **chkdsk** process on the volume that the backup files are stored in. The following alert issue can be resolved by running a check and repair on the hard drives:  
  
-   One or more hard drives in Server Backup must be checked.  
  
#### To check and repair hard drives  
  
1.  Open the Dashboard.  
  
2.  Click **Server Folders and Hard Drives**, and then click **Hard Drives**.  
  
3.  Select the hard drive that is displaying the error, and then select **View the hard drive properties**.  
  
4.  On the **Check and Repair** tab, click **Check and Repair**.  
  
##  <a name="BKMK_3"></a> Format hard drives  
 When an unformatted internal hard drive is detected on the server, a health alert guides the user through the process of formatting it. The Add a New Hard Drive Wizard walks you through formatting the hard drive and enables you to configure the hard drive in one of the following ways:  
  
1.  Format the hard drive and automatically create a drive on it. If you choose this option, when the wizard is completed, one logical hard drive formatted with the NTFS file system is created.  
  
2.  Format the hard drive and set it up for server backup. If you choose this option, the Set Up Server Backup Wizard is launched, and it walks you through the server backup configuration.  
  
3.  If a storage space doesn't exist, use the new hard drive to create a storage space. You must have at least two hard drives to create a storage space.  
  
4.  If a storage space already exists, use the new hard drive to increase the capacity of a storage pool. This option is only displayed if there is an existing storage space created on the server. If you choose this option, the wizard will add this hard drive to the storage pool.  
  
##  <a name="BKMK_4"></a> Add a new hard drive  
 When you plug a new hard disk drive into a server running Windows Server Essentials, you can:  
  
-   [Use the new hard drive to store server folders](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_4a)  
  
-   [Use the new hard drive to store server backups](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_4b)  
  
-   [Use the new hard drive to increase storage pool capacity](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_4c)  
  
###  <a name="BKMK_4a"></a> Use the new hard drive to store server folders  
 To use the new hard drive to store server folders, you can add a new server folder to the hard drive or move an existing server folder to the hard drive.  
  
##### To store server folders  
  
1. Open the Dashboard.  
  
2. Click the **STORAGE** tab, and then click **Server Folders**.  
  
3. In the **Server Folders Tasks** pane, do one of the following:  
  
   1.  To add a server folder, click **Add a folder**.  
  
   2.  To move a server folder, select the folder that you want to move to the new hard drive, and then click **Move a folder**.  
  
   > [!NOTE]
   >  If you browse to the hard drive and select it as the server folder location without creating a folder, the following error message appears: **A root directory (such as C:\\, D:\\) cannot be added as a server folder. Create a new folder or select an existing one under the root directory, and then try again**. To resolve this error, create a new folder in the newly added hard drive, and then select the new folder as the location to store server folders.  
  
4. Follow the instructions to finish the wizard.  
  
   For more information about moving server folders, see [Add or move a server folder](Manage-Server-Folders-in-Windows-Server-Essentials.md#BKMK_5).  
  
###  <a name="BKMK_4b"></a> Use the new hard drive to store server backups  
 You can use the newly added hard drive to store server backups.  
  
##### To store server backups  
  
1. Open the Dashboard.  
  
2. Click the **Devices** tab, select the server from the list pane, and then from the task pane, do one of the following:  
  
   1. If Server Backup is not configured on the server, click **Set up Server Backup**.  
  
   2. If Server Backup is configured on the server, click **Customize Server Backup**.  
  
      The Set Up Server Backup Wizard appears.  
  
3. In the **Select the Backup Destination** page, select the new hard drive as the backup destination.  
  
4. Follow the instructions to finish the wizard.  
  
###  <a name="BKMK_4c"></a> Use the new hard drive to increase storage pool capacity  
 When your storage pool capacity is low, you receive an alert stating that you can increase the storage pool capacity by adding a new hard drive to the storage pool by using the Increase Capacity of a Storage Pool Wizard.  
  
> [!NOTE]
>  You can perform this procedure only if you created a storage pool on the server.  
  
##### To increase storage pool capacity  
  
1.  Open the Dashboard.  
  
2.  Click the **Storage** tab, and then click **Hard Drives**.  
  
3.  Select the drive that is showing a low capacity.  
  
4.  From the task pane, select **Increase storage pool capacity**. The Increase Capacity of a Storage Pool Wizard appears.  
  
5.  Follow the instructions to finish the wizard.  
  
##  <a name="BKMK_5"></a> Storage Spaces Overview  
 Storage Spaces lets you group disks together in a storage pool. You can then use pool capacity to create storage spaces. Storage spaces are virtual drives that appear on the **Hard Drives** tab of the Dashboard. You can use storage spaces like any other drive, so it's easy to work with files on them. When you run low on pool capacity, you can create large storage spaces and add more drives to the storage pool. If you have two or more disks within the storage pool, you can create storage spaces with a two-way mirror that won't be affected by a drive failure ?or even the failure of two drives ?if you create a three-way mirror storage space.  
  
 To create a storage space, all you need is one or more extra drives in addition to the drive on which Windows is installed. These drives can be internal or external hard drives, or solid state drives. You can use a variety of types of drives with Storage Spaces, including USB, SATA, and SAS drives.  
  
> [!NOTE]
>  If you configure Storage Spaces on a server running  Windows Server Essentials, you cannot perform a Factory Reset with the **Clean Data** option. The workaround for this issue is to first remove Storage Spaces and then perform a Factory Reset with the **Clean Data** option.  
  
 For more information about Storage Spaces, see [Storage Spaces Frequently Asked Questions (FAQ)](https://social.technet.microsoft.com/wiki/contents/articles/11382.storage-spaces-frequently-asked-questions-faq.aspx).  
  
##  <a name="BKMK_6"></a> Create a storage space  
 To begin working with Storage Spaces on server, the following minimum requirements must be met:  
  
-   The server running Windows Server Essentials must be attached to additional physical drives (not just the boot drive), the drives must not host any volumes and must have a minimum capacity of 10 GB. One physical drive is required to create a storage pool; a minimum of two physical drives is needed to create a resilient mirror storage space.  
  
-   A minimum of two physical drives are required to create a storage space with resiliency through parity or two-way mirroring.  
  
> [!NOTE]
>  If you configure Storage Spaces on a server running  Windows Server Essentials, you cannot perform a Factory Reset with the **Clean Data** option. The workaround for this issue is to first remove Storage Spaces and then perform a Factory Reset with the **Clean Data** option.  
  
#### To create a storage space in Windows Server Essentials  
  
1. Add or connect all the drives that you want to group together with Storage Spaces to the server running Windows Server Essentials.  
  
2. From the Dashboard, click **Advanced: Manage Storage Spaces**.  
  
3. Click **Create a new pool and storage space**.  
  
4. Select the drives you want to add to the new storage space, and then click **Create pool**.  
  
5. Give the drive a name and letter, and then choose a layout. **Two-way mirror**, **Three-way mirror**, and **Parity** can help protect the files in the storage space from drive failure.  
  
6. Enter the maximum size the storage space can reach, and then click **Create storage space**.  
  
   In  Windows Server Essentials, you can create a two-way mirrored storage space by using the Create a Storage Space Wizard from the Dashboard.  
  
#### To create a storage space in Windows Server Essentials  
  
1. Add or connect all the drives that you want to group together with Storage Spaces to the server running Windows Server Essentials.  
  
2. From the Dashboard, click **Manage Storage Spaces**. The Create a Storage Space Wizard appears.  
  
3. Follow the instructions to complete the wizard.  
  
   For information about increasing storage pool capacity, see [Use the new hard drive to increase storage pool capacity](Manage-Server-Storage-in-Windows-Server-Essentials.md#BKMK_4c).  
  
## See also  
  
-   [Manage Server Folders](Manage-Server-Folders-in-Windows-Server-Essentials.md)  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
