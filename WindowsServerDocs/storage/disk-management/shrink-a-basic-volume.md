---
title: Shrink a Basic Volume
description: See how to decrease the space used by primary partitions and logical drives by shrinking them into adjacent, contiguous space on the same disk.
ms.date: 04/22/2025
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
# customer intent: As an administrator, I want to see how to shrink primary partitions and logical drives into adjacent, contiguous space on the same disk so that I can create new unallocated space.
---

# Shrink a basic volume

You can decrease the space used by primary partitions and logical drives by shrinking them into adjacent, contiguous space on the same disk. For example, you might discover that you need another partition but don't have more disks. To create new unallocated space, you can shrink the existing partition from the end of the volume. That space can then be used for a new partition. Certain file types can block the shrink operation. For more information, see [Other considerations](#other-considerations).

When you shrink a partition, any ordinary files are automatically relocated on the disk to create the new unallocated space. There's no need to reformat the disk to shrink the partition.

You can shrink primary partitions and logical drives on raw partitions, which are partitions without a file system, or on partitions that use New Technology File System (NTFS).

> [!CAUTION]
> If the partition is a raw partition that contains data, such as a database file, shrinking the partition might destroy the data.

## Ways to shrink a basic volume

> [!NOTE]
> You must be a member of the Backup Operators or Administrators group, at minimum, to complete these steps.

### Shrink a basic volume by using Disk Management

1. In Disk Management, right-click the basic volume you want to shrink.

1. Select **Shrink Volume**.

1. Follow the on-screen instructions.

> [!NOTE]
> You can only shrink basic volumes that have no file system or that use NTFS.

### Shrink a basic volume by using the command line

1. Open Command Prompt and enter `diskpart`.

1. At the `DISKPART` prompt, enter `list volume`. The output lists information about the volumes on all disks. Note the number of the simple volume that you want to shrink.

1. To select the volume that you want to shrink, at the `DISKPART` prompt, enter `select volume <volume-number>`. For the *volume-number* value, use the number you noted in the previous step.

1. To shrink the volume that you selected, at the `DISKPART` prompt, enter `shrink [desired=<desired-size>] [minimum=<minimum-size>]`. If possible, this command shrinks the volume by the amount specified in megabytes (MB) in *desired-size*. If *desired-size* is too large, the command shrinks the volume by the amount specified in *minimum-size*.

The following table lists the `diskpart` commands, parameters, and arguments that you use to shrink a volume.

| Value | Description |
| --- | --- |
| `list volume` | Displays a list of basic and dynamic volumes on all disks. |
| `select volume <volume-number>` | Selects the specified volume, where *volume-number* is the volume number, and gives it focus. If no volume is specified, the `select` command lists the current volume with focus. You can specify the volume by number, drive letter, or mount point path. On a basic disk, selecting a volume also gives the corresponding partition focus. |
| `shrink` | Shrinks the volume that has the focus, to create unallocated space. No data loss occurs. If the partition includes unmovable files, such as the page file or the shadow copy storage area, the volume shrinks to the point where the unmovable files are located. |
| `desired=<desired-size>` | Specifies the amount of space, in megabytes, to recover to the current partition. If you don't specify a desired size, the command reduces the volume by the minimum amount. If you don't specify a desired or minimum size, the command reclaims the maximum amount of space possible. |
| `minimum=<minimum-size>` | Specifies the minimum amount of space, in megabytes, to recover to the current partition. If you don't specify a minimum size, the command reduces the volume by the desired amount. If you don't specify a desired or minimum size, the command reclaims the maximum amount of space possible. |

## Other considerations

- When you shrink a partition, certain files like the paging file or the shadow copy storage area can't be automatically relocated. Also, you can't decrease the allocated space beyond the point where the unmovable files are located.

- If the shrink operation fails, use one of the following methods to identify the unmovable file that's blocking the shrink operation:
  - Check the application log for an event with ID 259. This type of event provides information about the unmovable file.
  - If you know which clusters are associated with the unmovable file, use the `fsutil` command with the `querycluster` parameter at a command prompt. When you provide the `querycluster` parameter, this command displays the unmovable file that's preventing the shrink operation from succeeding. For information about how to use this command, enter `fsutil volume querycluster /?`.

  In some cases, you can relocate the file temporarily. For example, if you need to shrink the partition further, you can use Control Panel to move the paging file or stored shadow copies to another disk. Then you can delete the stored shadow copies, shrink the volume, and move the paging file back to the disk.

- If the number of bad clusters detected by dynamic bad-cluster remapping is too high, you can't shrink the partition. If this situation occurs, consider moving the data and replacing the disk. Don't use a block-level copy operation to transfer the data, because this method also copies the bad sector table. As a result, the sectors on the new disk that contain data from the bad sectors are treated as bad, even though they're healthy.

## Related content

- [Manage basic volumes](manage-basic-volumes.md)

