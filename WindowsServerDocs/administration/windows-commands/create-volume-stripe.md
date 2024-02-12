---
title: create volume stripe
description: Reference article for the create volume stripe command, which creates a striped volume using two or more specified dynamic disks.
ms.topic: reference
ms.assetid: 20dce735-5f7c-4f83-a580-d087e2913a00
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# create volume stripe

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a striped volume using two or more specified dynamic disks. After you create the volume, the focus automatically shifts to the new volume.

## Syntax

```
create volume stripe [size=<n>] disk=<n>,<n>[,<n>,...] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- |  -----------|
| size=`<n>` | The amount of disk space, in megabytes (MB), that the volume will occupy on each disk. If no size is given, the new volume takes up the remaining free space on the smallest disk and an equal amount of space on each subsequent disk. |
| disk=`<n>,<n>[,<n>,...]` | The dynamic disks on which the striped volume is created. You need at least two dynamic disks to create a striped volume. An amount of space equal to `size=<n>` is allocated on each disk. |
| align=`<n>` | Aligns all volume extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To create a striped volume of 1000 megabytes in size, on disks 1 and 2, type:

```
create volume stripe size=1000 disk=1,2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)
