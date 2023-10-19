---
title: add
description: Reference article for the add command, which adds a disk or volume in an existing RAID configuration.
ms.topic: reference
ms.author: wscontent
author: xelu86
ms.date: 10/12/2023
---

# add

Mirrors the simple volume with focus to the specified active disk.

> [!NOTE]
> This DiskPart command isn't available in any edition of Windows Vista.

## Syntax

```
add disk=<n> [align=<n>] [wait] [noerr]
```

## Parameters

|Parameter|Description|
|-|-|
|disk=`<n>`|Specifies a disk, other than the one containing the existing simple volume, to contain the mirror. You can mirror only simple volumes. The specified disk must have unallocated space at least as large as the size of the simple volume you want to mirror.|
|align=`<n>`|Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. Aligns all volume or partition extents to the closest alignment boundary. `n` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary.|
|wait|Waits for the volume to finish synchronizing with the added disk before returning. Without this parameter, DiskPart returns after the mirrored volume is created and doesn't wait for the synchronization to complete.|
|noerr|For scripting only. When an error is encountered, DiskPart continues to process commands as if the error didn't occur. Without this parameter, an error causes DiskPart to exit with an error code.|

### Remarks

- A volume must be selected for this operation to succeed. Use the select volume command to select a volume and shift the focus to it.

## Examples

To create a mirror of the volume with focus on disk 2, type:

```
add disk=2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
