---
title: repair
description: Reference article for the repair command, which repairs RAID-5 volumes by replacing the failed disk region with a specified dynamic disk.
ms.topic: reference
ms.assetid: 9f84f661-f3cd-48c8-bf08-87819cf626fe
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# repair

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Repairs the RAID-5 volume with focus by replacing the failed disk region with the specified dynamic disk.

A volume in a RAID-5 array must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.

## Syntax

```
repair disk=<n> [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| disk=`<n>` | Specifies the dynamic disk that will replace the failed disk region. Where *n* must have free space greater than or equal to the total size of the failed disk region in the RAID-5 volume. |
| align=`<n>` | Aligns all volume or partition extents to the closest alignment boundary. Where *n* is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | for scripting only. When an error is encountered, DiskPart continues to process commands as if the error didn't occur. Without this parameter, an error causes DiskPart to exit with an error code. |

### Examples

To replace the volume with focus by replacing it with dynamic disk 4, type:

```
repair disk=4
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select volume command](select-volume.md)
