---
title: Change a dynamic disk back to a basic disk
description: Describes how to convert a dynamic disk back to a basic disk.
ms.date: 12/18/2019
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---
# Change a dynamic disk back to a basic disk

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic describes how to delete everything on a dynamic disk and then convert it back to a basic disk. Dynamic disks have been deprecated from Windows and we don't recommend using them anymore. Instead, we recommend using basic disks or using the newer [Storage Spaces](https://support.microsoft.com/help/12438/windows-10-storage-spaces) technology when you want to pool disks together into larger volumes. If you want to mirror the volume from which Windows boots, you might want to use a hardware RAID controller, such as the one included on many motherboards.

> [!WARNING]
> To convert a dynamic disk back to a basic disk you must delete all volumes from the disk, permanently erasing all data on the disk. Make sure you back up any data you want to keep before proceeding.

## To change a dynamic disk back to a basic disk by using Disk Management

1.  Back up all volumes on the disk you want to convert from dynamic to basic.

2. Open Disk Management with administrator permissions.

   An easy way to do so is to type **Computer Management** in the search box on the taskbar, select and hold (or right-click) **Computer Management**, and then select **Run as administrator** > **Yes**. After Computer Management opens, go to **Storage** > **Disk Management**.

2.  In Disk Management, select and hold (or right-click) each volume on the dynamic disk you want to convert to a basic disk, and then click **Delete Volume**.

3.  When all volumes on the disk have been deleted, right-click the disk, and then click **Convert to Basic Disk**.

## To change a dynamic disk back to a basic disk by using a command line

1.  Back up all volumes on the disk you want to convert from dynamic to basic.

2.  Open a command prompt and type `diskpart`.

3.  At the **DISKPART** prompt, type `list disk`. Note the disk number you want to convert to basic.

4.  At the **DISKPART** prompt, type `select disk <disknumber>`.

5.  At the **DISKPART** prompt, type `detail disk`.

6.  For each volume on the disk, at the **DISKPART** prompt, type `select volume= <volumenumber>` and then type `delete volume`.

7.  At the **DISKPART** prompt, type `select disk <disknumber>`, specifying the disk number of the disk that you want to convert to a basic disk.

8.  At the **DISKPART** prompt, type `convert basic`.

| Value  | Description |
| --- | --- |
| **list disk**                         | Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus. |
| **select disk** <em>disknumber</em>   | Selects the specified disk, where <em>disknumber</em> is the disk number, and gives it focus.  |
| **detail disk** <em>disknumber</em>   | Displays the properties of the selected disk and the volumes on that disk.  |
| **select volume** <em>disknumber</em> | Selects the specified volume, where <em>disknumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus. |
| **delete volume**                     | Deletes the selected volume. You cannot delete the system volume, boot volume, or any volume that contains the active paging file or crash dump (memory dump). |
| **convert basic** | Converts an empty dynamic disk into a basic disk.  |

## Additional considerations

-   The disk must not contain any volumes or data before you can change it back to a basic disk. If you want to keep your data, back it up or move it to another volume before you convert the disk to a basic disk.
-   Once you change a dynamic disk back to a basic disk, you can create only partitions and logical drives on that disk.

## Additional References

-   [Command-line syntax notation](/previous-versions/orphan-topics/ws.11/cc742449(v=ws.11))
