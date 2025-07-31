---
title: Extend a basic or dynamic volume in Windows and Windows Server
description: Extend a basic or dynamic volume in Windows or Windows Server. Use Disk Management or PowerShell to add unallocated space to a volume.
ms.date: 06/10/2025
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
#customer intent: As a storage administrator, I want to extend a basic volume so that I can increase the storage capacity of the volume.
---

# Extend a basic or dynamic volume

You can add space to an existing volume by extending the volume into available unallocated (empty) space on a disk drive. This article shows you how to extend a basic or dynamic volume by using Disk Management or Windows PowerShell. Also learn about prerequisites, how to view unallocated space, and how to troubleshoot common issues that can prevent you from extending a volume.

You can also use Azure File Sync to extend your volume into the cloud. For more information, see [Planning for an Azure File Sync deployment on Windows Server](/azure/storage/files/storage-sync-files-planning).

## Prerequisites

Before you extend a volume, make sure that you have the following prerequisites:

- **Administrator permissions** to open Disk Management or Windows PowerShell with elevated permissions. If you don't have administrator permissions, you can ask a member of the **Administrators** group to extend the volume for you.

- **Unallocated space** on the disk drive that you want to extend. The unallocated space must meet the following conditions:

  - The unallocated space must be located immediately after the volume that you want to extend. If there are any other volumes between the volume to extend and the unallocated space, you can't extend the volume.

  - The unallocated space must be on the same disk drive as the volume to extend. You can't extend a volume across multiple disk drives.

- **A basic or dynamic disk drive**. You can extend a volume on a basic or dynamic disk drive.

- **A volume formatted with NTFS or ReFS**. You can extend a volume only if the volume is formatted with the NTFS or ReFS file system. If the volume is formatted with a different file system, you must first move or back up the files on the volume, and then reformat the volume with the NTFS or ReFS file system.

## View unallocated space

You can view the space utilization for a disk drive by using Disk Management.

1. Select and hold (or right-click) the **Start** button, and then select **Disk Management**.

   If you can't open Disk Management, in the search box on the taskbar, enter **diskmgmt.msc**. Select and hold (or right-click) **diskmgmt.msc**, and then select **Run as administrator**.

1. In the Disk Management window, you can see the disk drives and their partitions. The unallocated space on a disk drive appears as a black bar with the label **Unallocated**.

1. If you have multiple disk drives, you can select a disk drive to see its details, including the unallocated space.

The following image shows the details for a disk drive. The unallocated space on the disk drive appears at the right and has a red border outline.

:::image type="content" source="media/extend-volume-space-highlighted.png" alt-text="Screenshot of Disk Management showing available unallocated space for a volume extension.":::

## Extend a volume

To extend a volume, you can use either Disk Management or Windows PowerShell. Select the method that you prefer to use.

### [Disk Management](#tab/disk-management)

To extend a volume by using Disk Management, follow these steps.

1. In Disk Management, select and hold (or right-click) the volume that you want to extend, and then select **Extend Volume**. The Extend Volume Wizard opens.

   If the **Extend Volume** option isn't available, see the following section and [check for volume extension issues](#check-for-volume-extension-issues) to resolve.

1. In the Extend Volume Wizard, select **Next**.

1. In the wizard, under **Select Disks**, select how much disk drive space to use to extend the volume.

   The default approach is to use all available empty space (**Maximum available**) on the disk drive. 

   If you plan to create other volumes in the available empty space, you can select a smaller amount of space to use to extend the volume.

   :::image type="content" source="media/extend-volume-wizard.png" alt-text="Screenshot of the Extend Volume Wizard showing how to select available space to extend a volume.":::

1. Select **Next**, and then select **Finish** to extend the volume.

### [PowerShell](#tab/powershell)

To extend a volume by using PowerShell, follow these steps.

1. In the search box on the taskbar, enter **Windows PowerShell**.

1. Select and hold (or right-click) **Windows PowerShell**, and then select **Run as administrator**.

1. Enter the following command to resize the volume to the maximum size.

   For the `$drive_letter` variable, specify the drive letter of the volume to extend.

   ```PowerShell
   # Variable specifies the disk drive to extend
   $drive_letter = "C"

   # Get the partition sizes
   $size = (Get-PartitionSupportedSize -DriveLetter $drive_letter)

   # Resize the partition to the maximum size
   Resize-Partition -DriveLetter $drive_letter -Size $size.SizeMax
   ```

---

### Check for volume extension issues

If the Disk Management **Extend Volume** option isn't available, check your configuration for the following possible issues.

| Issue to check | Description | Resolution steps |
| --- | --- | --- |
| **Elevated permissions for Disk Management** | Confirm the Disk Management (or Computer Management) prompt has **administrator** (elevated) permissions. | If the Disk Management (or Computer Management) prompt doesn't have **administrator** permissions, close the prompt and reopen Disk Management by following the steps earlier in the article. |
| **Location of empty space on disk drive** | Confirm the disk drive has unallocated space immediately after (or _to the right of_) the volume to extend. For an example of this spacing, see [View unallocated space on a disk drive](#view-unallocated-space). In the image, a red border outlines the unallocated space. | If another volume is between the unallocated space and the volume that you want to extend, you have several options: </br> - Delete the in-between volume on the disk drive and all files on that volume. Be sure to back up or move any important files on the in-between volume before you delete the volume.</br> - Use a non-Microsoft disk partitioning application that can move volumes without destroying data.</br> - Don't proceed with this volume extension. Instead, create a new separate volume in the unallocated space on the disk drive. |
| **Volume uses NTFS or ReFS file system** | Confirm the volume is formatted with the NTFS or ReFS file system. Other file systems can't be extended. | If the volume to extend has a different file system, you must first move or back up the files on the volume, and then reformat the volume with the NTFS or ReFS file system. |
| **Disk drive size and format** | Check the disk drive format. If the volume to extend is on a disk drive that's larger than 2 terabytes, the disk must use the GPT partitioning scheme. | To use more than 2 terabytes on a disk, the disk drive must be initialized with the GPT partitioning scheme. To convert a disk drive to the GPT format, see [Change an MBR disk into a GPT disk](change-an-mbr-disk-into-a-gpt-disk.md). |

After you address these issues, if you still can't extend the volume, try searching the [Microsoft community - Files, folders, and storage](https://answers.microsoft.com/en-us/windows/forum/windows_10-files) site.

If you don't find an answer on the site, you can post a question for input from Microsoft or other members of the community. You can also [Contact Microsoft Support](https://support.microsoft.com/contactus/).


## Related content

- [Resize-Partition](/powershell/module/storage/resize-partition)
- [Diskpart extend](../../administration/windows-commands/extend.md)
