---
title: recover (DiskPart)
description: Reference article for the DiskPart recover command, which refreshes the state of all disks in a disk group, attempt to recover disks in an invalid disk group, and resynchronizes mirrored volumes and RAID-5 volumes that have stale data.
ms.topic: reference
ms.assetid: 8cc3a73d-9456-41a0-b375-2b4cc37c3992
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# recover (DiskPart)

Refreshes the state of all disks in a disk group, attempt to recover disks in an invalid disk group, and resynchronizes mirrored volumes and RAID-5 volumes that have stale data. This command operates on disks that are failed or failing. It also operates on volumes that are failed, failing, or in failed redundancy state.

This command operates on groups of dynamic disks. If this command is used on a group with a basic disk, it won't return an error, but no action will be taken.

> [!NOTE]
> A disk that is part of a disk group must be selected for this operation to succeed. Use the [select disk command](select-disk.md) to select a disk and shift the focus to it.

## Syntax

```
recover [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To recover the disk group that contains the disk with focus, type:

```
recover
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
