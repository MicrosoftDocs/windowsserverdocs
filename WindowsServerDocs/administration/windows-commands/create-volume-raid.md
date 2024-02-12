---
title: create volume raid
description: Reference article for the create volume raid command, which creates a RAID-5 volume using three or more specified dynamic disks.
ms.topic: reference
ms.assetid: 9f257950-9240-4d5f-9537-8ad653d48ebf
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# create volume raid

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a RAID-5 volume using three or more specified dynamic disks. After you create the volume, the focus automatically shifts to the new volume.

## Syntax

```
create volume raid [size=<n>] disk=<n>,<n>,<n>[,<n>,...] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | The amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the largest possible RAID-5 volume will be created. The disk with the smallest available contiguous free space determines the size for the RAID-5 volume and the same amount of space is allocated from each disk. The actual amount of usable disk space in the RAID-5 volume is less than the combined amount of disk space because some of the disk space is required for parity. |
| disk=`<n>,<n>,<n>[,<n>,...]` | The dynamic disks on which to create the RAID-5 volume. You need at least three dynamic disks in order to create a RAID-5 volume. An amount of space equal to `size=<n>` is allocated on each disk. |
| align=`<n>` | Aligns all volume extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To create a RAID-5 volume of 1000 megabytes in size, using disks 1, 2 and 3, type:

```
create volume raid size=1000 disk=1,2,3
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)
