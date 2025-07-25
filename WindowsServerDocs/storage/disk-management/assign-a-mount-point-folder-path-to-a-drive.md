---
title: Assign a mount point folder path to a drive in Windows and Windows Server
description: Mount point folder path lets you use a drive as a folder. Follow these steps to set up or remove a mounted drive in Windows.
ms.date: 06/10/2025
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
#customer intent: As a storage administrator, I want to mount a drive in a folder so that I can access it like a regular folder.
---

# Mount a drive in a folder

Mount point folder paths let you use a drive as if it were a regular folder, making storage management more flexible. This article shows you how to assign a mount point folder path to a drive in Windows and Windows Server, using either Disk Management, the command line, or PowerShell. Also learn how to remove a mount point and review important considerations before you start.

## Prerequisites

Before you mount a drive in a folder, make sure that you have the following prerequisites:

- **Administrator permissions** to open Disk Management or Windows PowerShell with elevated permissions. If you don't have administrator permissions, you can ask a member of the **Administrators** group to mount the drive for you.

- You must be a member of the **Backup Operators** or **Administrators** group to mount a drive or remove a mount point.

- **An empty folder** on an NTFS or ReFS drive. You need to create a new empty folder to store the mounted drive. The folder can be on a basic or dynamic disk.

- **A volume formatted with NTFS or ReFS**. You can mount a drive in a folder only if the volume is formatted with the NTFS or ReFS file system. If the volume is formatted with a different file system, you must first move or back up the files on the volume, and then reformat the volume with the NTFS or ReFS file system.

## Mount a drive in an empty folder

You can mount a drive in an empty folder using Disk Management, the command line, or PowerShell.

Select the method that you prefer to use:

### [Disk Management](#tab/disk-management)

1. Select and hold (or right-click) the **Start** button, and then select **Disk Management**.

   If you can't open Disk Management, in the search box on the taskbar, enter **diskmgmt.msc**. Select and hold (or right-click) **diskmgmt.msc**, and then select **Run as administrator**.

1. Choose the partition or volume that has the folder you want to mount the drive.

1. Go to **Action** > **All Tasks** > **Change Drive Letter and Paths**, then choose **Add**.

1. Select **Mount in the following empty NTFS folder** option.

1. Select the **Browse** button to locate the folder.

1. After you select the folder, choose select **OK**.

1. Select **OK** in the **Change Drive Letter and Paths** dialog box to finish.

### [Command line](#tab/command-line)

You can also mount a drive in an empty folder using the command line with the `diskpart` utility.

To help you navigate the steps, here are terms used by `diskpart`:

| Term | Description |
| --- | --- |
| **list volume** | Displays a list of basic and dynamic volumes on all disks. |
| **select volume**        | Selects the specified volume, where `volumenumber` is the volume number, and gives it focus. If you don't specify a volume, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point folder path. On a basic disk, selecting a volume also gives the corresponding partition focus.|
| **assign** |  Assigns a drive letter or mount point folder path to the volume with focus. If you don't specify a drive letter or mount point folder path, the next available drive letter is assigned. If the drive letter or mount point folder path is already in use, an error generates.</br> Using the **assign** command, you can change the drive letter associated with a removable drive.</br> You can't assign drive letters to boot volumes, or volumes that contain the paging file. Also, you can't assign a drive letter to an Original Equipment Manufacturer (OEM) partition, EFI system partition, or any GPT partition other than a basic data partition. |
| **mount=** *path* | Specifies an empty, existing NTFS folder where the mounted drive resides.

To mount a drive in a folder using the command line, follow these steps:

1. Open a command prompt and type `diskpart`.

1. At the **DISKPART** prompt, type `list volume`, and select **Enter**. Make note of the volume number of the drive you want to mount to the folder.

1. At the **DISKPART** prompt, type `select volume <volumenumber>`, and select **Enter**. Make sure to specify the volume number in the command.

   For example: `select volume 5`

1. At the **DISKPART** prompt, type `assign mount=<path>`, and select **Enter**. Make sure to specify the full path in the command.

   For example: `assign mount="C:\Demo Drive"`

### [PowerShell](#tab/powershell)

To mount a drive in an empty folder using PowerShell, follow these steps:

1. In the search box on the taskbar, enter **Windows PowerShell**.

1. Select and hold (or right-click) **Windows PowerShell**, and then select **Run as administrator**.

1. Get the disk number of the drive you want to mount using the `Get-Disk` cmdlet to list all disks and their properties.

   ```PowerShell
   Get-Disk
   ```

1. Get the partition number of the drive you want to mount using the `Get-Partition` cmdlet to list all partitions on a specific disk. Replace `<disknumber>` with the actual disk number you found in the previous step.

   ```PowerShell
   Get-Partition -DiskNumber <disknumber>
   ```

1. Add the mount point folder path using the `Add-PartitionAccessPath` cmdlet. Replace `<disknumber>` and `<partitionnumber>` with the actual disk and partition numbers you found in the previous step.

   ```PowerShell
   # Variable specifies the path to the empty folder where you want to mount the drive
   $mount_path = "C:\Demo Drive"

   # Mount the drive in the specified folder
   Add-PartitionAccessPath -DiskNumber <disknumber> -PartitionNumber <partitionnumber> -AccessPath $mount_path
   ```

---

> [!TIP]
>
> - To modify a mount point folder path, remove it using the step in the following section, and then create a new folder path using the new location. You can't modify the existing mount point folder path.
>
> - If you're using Failover Cluster, use **Event Viewer** to check the **System** log for any Cluster service errors or warnings indicating mount point folder path failures. These errors display as **ClusSvc** in the **Source** column and **Physical Disk Resource** in the **Category** column.

## Remove a mount point

To remove the mount point so that the drive is no longer accessible through a folder, select the method that you prefer to use:

### [Disk Management](#tab/disk-management)

To remove a mount point folder path using Disk Management, follow these steps:

1. Open Disk Management. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**

1. Select the **View** menu, and then select **Drive Paths**.

1. Select the drive path from the list, and then choose **Remove**.

### [Command line](#tab/command-line)

To remove a mount point folder path using the command line, follow these steps:

1. Open a command prompt and type `diskpart`.

1. At the **DISKPART** prompt, type `list volume`, and select **Enter**. Make note of the volume number of the drive you want to remove the mount point from.

1. At the **DISKPART** prompt, type `select volume <volumenumber>`, and select **Enter**. Make sure to specify the volume number in the command.

   For example: `select volume 5`

1. At the **DISKPART** prompt, type `remove mount=<path>`, and select **Enter**. Make sure to specify the full path in the command.

   For example: `remove mount="C:\Demo Drive"`

### [PowerShell](#tab/powershell)

To remove a mount point folder path using PowerShell, follow these steps:

1. In the search box on the taskbar, enter **Windows PowerShell**.

1. Select and hold (or right-click) **Windows PowerShell**, and then select **Run as administrator**.

1. Get the disk number of the drive you want to remove the mount point from using the `Get-Disk` cmdlet to list all disks and their properties.

   ```PowerShell
   Get-Disk
   ```

1. Get the partition number of the drive you want to remove the mount point from using the `Get-Partition` cmdlet to list all partitions on a specific disk. Replace `<disknumber>` with the actual disk number you found in the previous step.

   ```PowerShell
   Get-Partition -DiskNumber <disknumber>
   ```

1. Remove the mount point folder path using the `Remove-PartitionAccessPath` cmdlet. Replace `<disknumber>` and `<partitionnumber>` with the actual disk and partition numbers you found in the previous step.

   ```PowerShell
   # Variable specifies the path to the empty folder where the drive is mounted
   $mount_path = "C:\Demo Drive"

   # Remove the mount point folder path
   Remove-PartitionAccessPath -DiskNumber <disknumber> -PartitionNumber <partitionnumber> -AccessPath $mount_path
   ```

---
