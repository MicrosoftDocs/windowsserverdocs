---
title: Extend a simple or spanned volume
description: This article describes how to extend a simple or spanned volume
ms.date: 10/10/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Extend a simple or spanned volume

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A spanned volume is a dynamic volume that consists of disk space on more than one physical disk. If a simple volume is not a system volume or boot volume, you can extend it across multiple disks, when it becomes a spanned volume.

You can extend a volume only if it does not have a file system or if it is formatted using the NTFS file system. You cannot extend volumes formatted using FAT or FAT32.

## Extending a simple or spanned volume

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.


<a id="BKMK_WINUI"></a>
#### To extend a simple or spanned volume using the Windows interface

1.  In Disk Management, right-click the simple or spanned volume you want to extend.

2.  Click **Extend Volume**.

3.  Follow the on-screen instructions.

<a id="BKMK_CMD"></a> 
#### To extend a simple or spanned volume using a command line

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list volume`. Note the number of the simple volume you want to extend onto another disk.

3.  At the **DISKPART** prompt, type `select volume <volumenumber>`. This selects the simple volume *volumenumber* you want to extend onto another disk.

4.  At the **DISKPART** prompt, type `list disk`. Note the number of the disk onto which you want to extend the simple volume.

5.  At the **DISKPART** prompt, type `extend [size=<size>] [disk=<disknumber>]`. This extends the selected volume onto disk *disknumber* and makes the extension size=*size* megabytes (MB).

<br />

| Value | Description |
| --- | --- |
| <p>**list volume**</p>  | <p>Displays a list of basic and dynamic volumes on all disks.</p> |
| <p>**select volume**</p> | <p>Selects the specified volume, where <em>volumenumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus.</p> |
| <p>**list disk**</p> | <p>Displays a list of disks and information about them, such as their size, the amount of available free space, whether the disk is a basic or dynamic disk, and whether the disk uses the Master Boot Record (MBR) or GUID Partition Table (GPT) partition style. The disk marked with an asterisk (*) has focus.</p> |
| <p>**extend**</p> | <p> <ul><li>Extends the volume with focus into the next contiguous unallocated space. For basic volumes, the unallocated space must be on the same disk as, and must follow (be of higher sector offset than) the partition with focus. A dynamic simple or spanned volume can be extended to any empty space on any dynamic disk. Using this command, you can extend an existing volume into newly-created space.</p></li> <p><li>If the partition was previously formatted with the NTFS file system, the file system is automatically extended to occupy the larger partition. No data loss occurs. If the partition was previously formatted with any file system format other than NTFS, the command fails with no change to the partition.</p></li></ul>|
| <p>**disk=** <em>disknumber</em></p> | <p>The dynamic disk on which to extend the volume. An amount of space equal to **size=**<em>size</em> is allocated on the disk. If no disk is specified, the volume is extended on the current disk.</p> |
| <p>**size=** <em>size</em></p> | <p>The amount of space, in megabytes (MB), to add to the current partition. If you do not specify a size, the disk is extended to take up all the contiguous unallocated space.</p>

## See Also

-   [Command-line syntax notation](https://technet.microsoft.com/library/cc742449(v=ws.11).aspx)


