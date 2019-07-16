---
title: Extend a basic volume
description: This article describes how to add space on primary and logical drives extend a basic volume
ms.date: 06/07/2019
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---
# Extend a basic volume

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can add more space to existing primary partitions and logical drives by extending them into adjacent unallocated space on the same disk. To extend a basic volume, it must be raw (not formatted with a file system) or formatted with the NTFS file system. You can extend a logical drive within contiguous free space in the extended partition that contains it. If you extend a logical drive beyond the free space available in the extended partition, the extended partition grows to contain the logical drive.

For logical drives, and boot or system volumes, you can extend the volume only into contiguous space and only if the disk can be upgraded to a dynamic disk. For other volumes, you can extend the volume into non-contiguous space, but you will be prompted to convert the disk to dynamic.

## Extending a basic volume

#### To extend a basic volume using the Windows interface

1. In Disk Manager, right-click the basic volume you want to extend.

2. Click **Extend Volume**.

3. Follow the on-screen instructions.

#### To extend a basic volume using a command line

1. Open a command prompt and type `diskpart`.

2. At the **DISKPART** prompt, type `list volume`. Make note of the basic volume you want to extend.

3. At the **DISKPART** prompt, type `select volume <volumenumber>`. This selects the basic volume *volumenumber* that you want to extend into contiguous, empty space on the same disk.

4. At the **DISKPART** prompt, type `extend [size=<size>]`. This extends the selected volume by *size* in megabytes (MB).

| Value | Description |
| --- | --- |
| **list volume** | Displays a list of basic and dynamic volumes on all disks. |
| **select volume** | Selects the specified volume, where <em>volumenumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus. |
| **extend** | <ul><li>Extends the volume with focus into next contiguous unallocated space. For basic volumes, the unallocated space must be on the same disk as, and must follow (be of higher sector offset than) the partition with focus. A dynamic simple or spanned volume can be extended to any empty space on any dynamic disk. Using this command, you can extend an existing volume into newly-created space.</li ><li>If the partition was previously formatted with the NTFS file system, the file system is automatically extended to occupy the larger partition. No data loss occurs. If the partition was previously formatted with any file system format other than NTFS, the command fails with no change to the partition.</li></ul> |
| **size=** <em>size</em> | The amount of space, in megabytes (MB), to add to the current partition. If you do not specify a size, the disk is extended to take up all the contiguous unallocated space. |

## Additional considerations

-   If the disk does not contain boot or system partitions, you can extend the volume into other non-boot or non-system disks, but the disk will be converted to a dynamic disk (if it can be upgraded).

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)
