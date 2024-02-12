---
title: create volume simple
description: Reference article for the create volume simple command, which creates a simple volume on the specified dynamic disk.
ms.topic: reference
ms.assetid: da0f208d-7fda-471a-9db2-5de5ba5207c6
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# create volume simple

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a simple volume on the specified dynamic disk. After you create the volume, the focus automatically shifts to the new volume.

## Syntax

```
create volume simple [size=<n>] [disk=<n>] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>`  | The size of the volume in megabytes (MB). If no size is given, the new volume takes up the remaining free space on the disk. |
| disk=`<n>`  | The dynamic disk on which the volume is created. If no disk is specified, the current disk is used. |
| align=`<n>` | Aligns all volume extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To create a volume of 1000 megabytes in size, on disk 1, type:

```
create volume simple size=1000 disk=1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)
