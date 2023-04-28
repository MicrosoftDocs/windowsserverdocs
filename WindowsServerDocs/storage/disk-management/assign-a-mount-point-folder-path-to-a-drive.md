---
title: Assign a mount point folder path to a drive.
description: Learn how to mount a drive as a folder rather than a letter and how to unmount a drive from a folder.
ms.date: 03/24/2023
ms.topic: conceptual
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Mount a drive in a folder

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, Windows Server 2016

You can use Disk Management to mount (make a drive accessible) in a folder rather than a drive letter. It looks like just another folder. You can mount drives only in empty folders on basic or dynamic NTFS volumes.

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group to mount a drive or remove a mount point.

## Mount a drive in an empty folder

You can mount a drive in an empty folder using Disk Management or the command line.

### Before you start

- **Create an empty folder**. You need to create a new empty folder and store it on an NTFS or ReFS drive.

- **Review the terms**. To help you navigate the steps, here are terms used throughout this article.

| Term | Description |
| --- | --- |
| **list volume** | Displays a list of basic and dynamic volumes on all disks. |
| **select volume**        | Selects the specified volume, where *volumenumber* is the volume number, and gives it focus. If you don't specify a volume, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point folder path. On a basic disk, selecting a volume also gives the corresponding partition focus.|
| **assign** |  Assigns a drive letter or mount point folder path to the volume with focus. If you don't specify a drive letter or mount point folder path, the next available drive letter is assigned. If the drive letter or mount point folder path is already in use, an error generates.</br>Using the **assign** command, you can change the drive letter associated with a removable drive.</br> You can't assign drive letters to boot volumes, or volumes that contain the paging file. Also, you can't assign a drive letter to an Original Equipment Manufacturer (OEM) partition, EFI system partition, or any GPT partition other than a basic data partition. |
| **mount=** *path* | Specifies an empty, existing NTFS folder where the mounted drive resides.  

### Mount a drive as a folder with Disk Management

1. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**.

1. Choose the partition or volume that has the folder you want to mount the drive.

1. Go to **Action** > **All Tasks** > **Change Drive Letter and Paths**, then choose **Add**.

1. Select **Mount in the following empty NTFS folder** option.

1. Select the **Browse** button to locate the folder.

1. After you select the folder, choose select **OK**.

1. Select **OK** in the **Change Drive Letter and Paths** dialog box to finish.

### Mount a drive as a folder with the command line

1. Open a command prompt and type `diskpart`.

1. At the **DISKPART** prompt, type `list volume`, and select **Enter**. Make note of the volume number of the drive you want to mount to the folder.

1. At the **DISKPART** prompt, type `select volume <volumenumber>`, and select **Enter**. Make sure to specify the volume number in the command.
   </br>For example: `select volume 5`

1. At the **DISKPART** prompt, type `assign [mount=<path>]`, and select **Enter**. Make sure to specify the full path in the command.
    </br>For example: `assign mount="C:\Users\Smith\Desktop\Demo Drive"`

1. Close command prompt.

## Remove a mount point

To remove the mount point so that the drive is no longer accessible through a folder, do the following steps.

1. Open Disk Management. In the search box on the taskbar, enter **Computer Management**, and select **Disk Management**

1. Choose the drive mounted to the folder, then choose **Change Drive Letters and Paths**.

1. Go to **Action** > **All Tasks** > **Change Drive Letter and Paths**.

1. Select the folder from the list, and then choose **Remove**.

## Additional considerations

- If you're administering a local or remote computer, you can browse NTFS folders on that computer.
- Mount point folder paths are available only on empty folders on basic or dynamic NTFS volumes.
- To modify a mount point folder path, remove it, and then create a new folder path using the new location. You can't modify the mount point folder path directly.
- When assigning a mount point folder path to a drive, use **Event Viewer** to check the system log for any Cluster service errors or warnings indicating mount point folder path failures. These errors display as **ClusSvc** in the **Source** column and **Physical Disk Resource** in the **Category** column.
- You can also create a mounted drive using the [mountvol](/previous-versions/orphan-topics/ws.10/cc772671(v=ws.10)) command.

## See also

- [Command-line syntax notation](/previous-versions/orphan-topics/ws.11/cc742449(v=ws.11))
