---
title: select commands
description: Reference article for the select commands, which shifts the focus to a disk, partition, volume, or virtual hard disk (VHD).
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# select commands

Shifts the focus to a disk, partition, volume, or virtual hard disk (VHD).

## Syntax

```
select disk
select partition
select vdisk
select volume
```

### Parameters

| Parameter | Description |
|--|--|
| [Select disk](select-disk.md) | Shifts the focus to a disk. |
| [Select partition](select-partition.md) | Shifts the focus to a partition. |
| [Select vdisk](select-vdisk.md) | Shifts the focus to a VHD. |
| [Select volume](select-volume.md) | Shifts the focus to a volume. |

#### Remarks

- If a volume is selected with a corresponding partition, the partition will be automatically selected.

- If a partition is selected with a corresponding volume, the volume will be automatically selected.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
