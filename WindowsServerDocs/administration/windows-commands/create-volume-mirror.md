---
title: create volume mirror
description: Reference article for the create volume mirror command, which creates a volume mirror by using the two specified dynamic disks.
ms.topic: reference
ms.assetid: 48776917-783a-47ff-8da4-1cab77cea34b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# create volume mirror

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a volume mirror by using the two specified dynamic disks. After the volume has been created, the focus automatically shifts to the new volume.

## Syntax

```
create volume mirror [size=<n>] disk=<n>,<n>[,<n>,...] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | Specifies the amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the new volume takes up the remaining free space on the smallest disk and an equal amount of space on each subsequent disk. |
| disk=`<n>`,`<n>`[`,<n>,...`] | Specifies the dynamic disks on which the mirror volume is created. You need two dynamic disks to create a mirror volume. An amount of space that is equal to the size specified with the **size** parameter is allocated on each disk. |
| align=`<n>` | Aligns all volume extents to the closest alignment boundary. This parameter is typically used with hardware RAID logical unit number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error. |

## Examples

To create a mirrored volume of 1000 megabytes in size, on disks 1 and 2, type:

```
create volume mirror size=1000 disk=1,2
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)
