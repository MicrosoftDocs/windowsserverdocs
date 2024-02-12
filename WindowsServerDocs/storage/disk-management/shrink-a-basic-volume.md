---
title: Shrink a basic volume
description: Learn how to decrease the space used by primary partitions and logical drives by shrinking them into adjacent, contiguous space on the same disk.
ms.date: 09/11/2023
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Shrink a basic volume

> **Applies To:** Windows 11, Windows 10, Windows 8.1, Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can decrease the space used by primary partitions and logical drives by shrinking them into adjacent, contiguous space on the same disk. For example, if you discover that you need another partition but don't have more disks, you can shrink the existing partition from the end of the volume to create new unallocated space. That space can then be used for a new partition. Certain file types can block the shrink operation. For more information, see [Other considerations](#other-considerations).

When you shrink a partition, any ordinary files are automatically relocated on the disk to create the new unallocated space. There's no need to reformat the disk to shrink the partition.

You can shrink primary partitions and logical drives on raw partitions&mdash;those without a file system&mdash;or partitions that use the NTFS file system.

> [!CAUTION]
> If the partition is a raw partition (that is, one without a file system) that contains data (such as a database file), shrinking the partition might destroy the data.

## Ways to shrink a basic volume

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

### Shrink a basic volume by using Disk Management

1. In Disk Management, right-click the basic volume you want to shrink.

1. Select **Shrink Volume**.

1. Follow the on-screen instructions.

> [!NOTE]
> You can only shrink basic volumes that have no file system or that use the NTFS file system.

### Shrink a basic volume by using the command line

1. Open a command prompt and enter `diskpart`.

1. At the **DISKPART** prompt, enter `list volume`. Note the number of the simple volume you want to shrink.

1. At the **DISKPART** prompt, enter `select volume <volumenumber>`. Select the simple volume *volumenumber* you want to shrink.

1. At the **DISKPART** prompt, enter `shrink [desired=<desiredsize>] [minimum=<minimumsize>]`. Shrink the selected volume by the amount specified in *desiredsize* in megabytes (MB) if possible, or by the amount specified in *minimumsize* if *desiredsize* is too large.

| Value             | Description |
| ---               | ----------- |
| **list volume** | Displays a list of basic and dynamic volumes on all disks. |
| **select volume** | Selects the specified volume, where *volumenumber* is the volume number, and gives it focus. If no volume is specified, the **select** command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus. |
| **shrink** | Shrinks the volume with focus to create unallocated space. No data loss occurs. If the partition includes unmovable files, such as the page file or the shadow copy storage area, the volume shrinks to the point where the unmovable files are located. |
| **desired=** *desiredsize* | The amount of space, in megabytes, to recover to the current partition. |
| **minimum=** *minimumsize* | The minimum amount of space, in megabytes, to recover to the current partition. If you don't specify a desired or minimum size, the command reclaims the maximum amount of space possible. |

## Other considerations

- When you shrink a partition, certain files like the paging file or the shadow copy storage area can't be automatically relocated. Also, you can't decrease the allocated space beyond the point where the unmovable files are located.

- If the shrink operation fails, check the Application Log for Event 259, which identifies the unmovable file. If you know the cluster(s) associated with the file that's preventing the shrink operation, you can also use the **fsutil** command at a command prompt (enter **fsutil volume querycluster /?** for usage). When you provide the **querycluster** parameter, the command output identifies the unmovable file that's preventing the shrink operation from succeeding.

  In some cases, you can relocate the file temporarily. For example, if you need to shrink the partition further, you can use Control Panel to move the paging file or stored shadow copies to another disk, delete the stored shadow copies, shrink the volume, and then move the paging file back to the disk.

- If the number of bad clusters detected by dynamic bad-cluster remapping is too high, you can't shrink the partition. If this situation occurs, consider moving the data and replacing the disk. Don't use a block-level copy to transfer the data. This method also copies the bad sector table, and the new disk treats these sectors as bad even though they're healthy.

## Related links

- [Manage basic volumes](manage-basic-volumes.md)
