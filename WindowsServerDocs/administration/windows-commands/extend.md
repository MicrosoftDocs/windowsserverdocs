---
title: extend
description: Reference article for the extend command, which extends the volume or partition with focus and its file system into free (unallocated) space on a disk.
ms.topic: reference
ms.assetid: 2414e21d-fc0b-40e8-9e33-3e072f8ad76b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# extend

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Extends the volume or partition with focus and its file system into free (unallocated) space on a disk.

## Syntax

```
extend [size=<n>] [disk=<n>] [noerr]
extend filesystem [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | Specifies the amount of space in megabytes (MB) to add to the current volume or partition. If no size is given, all of the contiguous free space that is available on the disk is used. |
| disk=`<n>` | Specifies the disk on which the volume or partition is extended. If no disk is specified, the volume or partition is extended on the current disk. |
| filesystem | Extends the file system of the volume with focus. For use only on disks where the file system was not extended with the volume. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

#### Remarks

- On basic disks, the free space must be on the same disk as the volume or partition with focus. It must also immediately follow the volume or partition with focus (that is, it must start at the next sector offset).

- On dynamic disks with simple or spanned volumes, a volume can be extended to any free space on any dynamic disk. Using this command, you can convert a simple dynamic volume into a spanned dynamic volume. Mirrored, RAID-5 and striped volumes cannot be extended.

- If the partition was previously formatted with the NTFS file system, the file system is automatically extended to fill the larger partition and no data loss will occur.

- If the partition was previously formatted with a file system other than NTFS, the command fails with no change to the partition.

- If the partition was not previously formatted with a file system, the partition will still be extended.

- The partition must have an associated volume before it can be extended.

## Examples

To extend the volume or partition with focus by 500 megabytes, on disk 3, type:

```
extend size=500 disk=3
```

To extend the file system of a volume after it was extended, type:

```
extend filesystem
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
