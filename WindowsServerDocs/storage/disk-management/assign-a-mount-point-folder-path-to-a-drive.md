---
title: Assign a mount point folder path to a drive.
description: This article describes how to assign a mount point folder path (rather than a drive letter) to a drive. 
keywords: virtualization, security, malware
ms.date: 06/07/2019
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---
# Assign a mount point folder path to a drive

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use Disk Management to assign a mount point folder path (rather than a drive letter) to the drive. Mount point folder paths are available only on empty folders on basic or dynamic NTFS volumes.

## Assigning a mount point folder path to a drive

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

#### To assign a mount point folder path to a drive by using the Windows interface

1.  In Disk Manager, right-click the partition or volume where you want to assign the mount point folder path. 
2. Click **Change Drive Letter and Paths** and then click **Add**. 
3. Click **Mount in the following empty NTFS folder**.
4. Type the path to an empty folder on an NTFS volume, or click **Browse** to locate it.

#### To assign a mount point folder path to a drive using a command line

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list volume`, making note of the volume number you want to assign the path to.

3.  At the **DISKPART** prompt, type `select volume <volumenumber>`. 

4. Select the simple volume *volumenumber* that you want to assign the path to.

5.  At the **DISKPART** prompt, type `assign [mount=<path>]`.

#### To remove a mount point folder path to a drive

-   To remove the mount point folder path, click it and then click **Remove**.

| Value | Description |
| --- | --- |
| **list volume** | Displays a list of basic and dynamic volumes on all disks. |
| **select volume**        | Selects the specified volume, where <em>volumenumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point folder path. On a basic disk, selecting a volume also gives the corresponding partition focus.|
| **assign** | <ul><li> Assigns a drive letter or mount point folder path to the volume with focus. If no drive letter or mount point folder path is specified, then the next available drive letter is assigned. If the drive letter or mount point folder path is already in use, an error is generated.</li>  <li>Using the **assign** command, you can change the drive letter associated with a removable drive.</li> <li> You cannot assign drive letters to boot volumes, or volumes that contain the paging file. In addition, you cannot assign a drive letter to an Original Equipment Manufacturer (OEM) partition, EFI system partition, or any GPT partition other than a basic data partition.</li></ul> |
| **mount=** <em>path</em> | Specifies an empty, existing NTFS folder where the mounted drive will reside.  |

## Additional considerations

-   If you are administering a local or remote computer, you can browse NTFS folders on that computer.
-   Mount point folder paths are available only on empty folders on basic or dynamic NTFS volumes.
-   To modify a mount point folder path, remove it, and then create a new folder path using the new location. You cannot modify the mount point folder path directly.
-   When assigning a mount point folder path to a drive, use **Event Viewer** to check the system log for any Cluster service errors or warnings indicating mount point folder path failures. These errors would be listed as **ClusSvc** in the **Source** column and **Physical Disk Resource** in the **Category** column.
-   You can also create a mounted drive using the [mountvol](https://go.microsoft.com/fwlink/?linkid=64111) command.

## See also
-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


