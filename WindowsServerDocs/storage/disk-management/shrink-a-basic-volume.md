---
title: Shrink a basic volume
description: This article describes how to shrink a basic volume
ms.date: 10/10/2017
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jgerend 
---

# Shrink a basic volume

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can decrease the space used by primary partitions and logical drives by shrinking them into adjacent, contiguous space on the same disk. For example, if you discover that you need an additional partition but do not have additional disks, you can shrink the existing partition from the end of the volume to create new unallocated space that can then be used for a new partition. The shrink operation can be blocked by the presence of certain file types. For more information, see [Additional Considerations](#addcon) 

When you shrink a partition, any ordinary files are automatically relocated on the disk to create the new unallocated space. There is no need to reformat the disk to shrink the partition.

> [!CAUTION]
> If the partition is a raw partition (that is, one without a file system) that contains data (such as a database file), shrinking the partition might destroy the data.

## Shrinking a basic volume

-   [Using the Windows interface](#BKMK_WINUI)
-   [Using a command line](#BKMK_CMD)

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

<a id="BKMK_WINUI"></a>
#### To shrink a basic volume using the Windows interface

1.  In Disk Manager, right-click the basic volume you want to shrink.

2.  Click **Shrink Volume**.

3.  Follow the on-screen instructions.

<br />

> [!NOTE]
> You can only shrink basic volumes that have no file system or that use the NTFS file 

<a id="BKMK_CMD"></a>
#### To shrink a basic volume using a command line

1.  Open a command prompt and type `diskpart`.

2.  At the **DISKPART** prompt, type `list volume`. Note the number of the simple volume you want to shrink.

3.  At the **DISKPART** prompt, type `select volume <volumenumber>`. Selects the simple volume *volumenumber* you want to shrink.

4.  At the **DISKPART** prompt, type `shrink [desired=<desiredsize>] [minimum=<minimumsize>]`. Shrinks the selected volume to *desiredsize* in megabytes (MB) if possible, or to *minimumsize* if *desiredsize* is too large.

<br />

| Value | Description|
|---|---|
| <p>**list volume**</p> | <p>Displays a list of basic and dynamic volumes on all disks.</p>|
| <p>**select volume**</p> | <p>Selects the specified volume, where <em>volumenumber</em> is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus.</p> |
| <p>**shrink**</p> | <p><ul><li>Shrinks the volume with focus to create unallocated space.</p></li>    <p><li>No data loss occurs. If the partition includes unmovable files (such as the page file or the shadow copy storage area), the volume will shrink to the point where the unmovable files are located.</p></li></ul> |
| <p>**desired=** <em>desiredsize</em></p> | <p>The amount of space, in megabytes, to recover to the current partition.</p> |
| <p>**minimum=** <em>minimumsize</em></p> | <p>The minimum amount of space, in megabytes, to recover to the current partition. If you do not specify a desired or minimum size, the command will reclaim the maximum amount of space possible.</p> 

<a id="addcon"></a>

## Additional considerations

-   When you shrink a partition, certain files (for example, the paging file or the shadow copy storage area) cannot be automatically relocated, and you cannot decrease the allocated space beyond the point where the unmovable files are located. 
If the shrink operation fails, check the Application Log for Event 259, which will identify the unmovable file. If you know the cluster(s) associated with the file that is preventing the shrink operation, you can also use the **fsutil** command at a command prompt (type **fsutil volume querycluster /?** for usage). When you provide the **querycluster** parameter, the command output will identify the unmovable file that is preventing the shrink operation from succeeding.
In some cases, you can relocate the file temporarily. For example, if you need to shrink the partition further, you can use Control Panel to move the paging file or stored shadow copies to another disk, delete the stored shadow copies, shrink the volume, and then move the paging file back to the disk. If the number of bad clusters detected by dynamic bad-cluster remapping is too high, you cannot shrink the partition. If this occurs, you should consider moving the data and replacing the disk.

-  Do not use a block-level copy to transfer the data. This will also copy the bad sector table and the new disk will treat the same sectors as bad even though they are normal.

-   You can shrink primary partitions and logical drives on raw partitions (those without a file system) or partitions using the NTFS file system.

## See Also

-   [Manage basic volumes](manage-basic-volumes.md)