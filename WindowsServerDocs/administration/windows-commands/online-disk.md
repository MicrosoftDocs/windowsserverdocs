---
title: online disk
description: Reference article for the online disk command, which takes the offline disk to the online state.
ms.topic: reference
ms.assetid: bc44a783-eaa4-40ca-be01-5703b5bf4eb3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# online disk

Takes the offline disk to the online state. For basic disks, this command attempts to bring online the selected disk and all volumes on that disk. For dynamic disks, this command attempts to bring online all disks that are not marked as foreign on the local computer. It also attempts to bring online all volumes on the set of dynamic disks.

If a dynamic disk in a disk group is brought online and it's the only disk in the group, then the original group is recreated and the disk is moved to that group. If there are other disks in the group and they're online, then the disk is simply added back into the group. If the group of a selected disk contains mirrored or RAID-5 volumes, this command also resynchronizes these volumes.

> [!NOTE]
> A disk must be selected for the **online disk** command to succeed. Use the [select disk](select-disk.md) command to select a disk and shift the focus to it.

> [!IMPORTANT]
> This command will fails if it's used on a read-only disk.

## Syntax

```
online disk [noerr]
```

### Parameters

For instructions about using this command, see [Reactivate a Missing or Offline Dynamic Disk](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732026(v=ws.11)).

| Parameter | Description |
|--|--|
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

### Examples

To take the disk with focus online, type:

```
online disk
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
