---
title: create
description: Reference article for the create command, which creates a partition or shadow partition on a disk, a volume on one or more disks, or a virtual hard disk (VHD).
ms.topic: reference
ms.assetid: b45acde1-8f4f-4ec3-b905-d8188f884af8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# create

Creates a partition or shadow on a disk, a volume on one or more disks, or a virtual hard disk (VHD). If you're using this command to create a volume on the shadow disk, you must already have at least one volume in the shadow copy set.

## Syntax

```
create partition
create volume
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [create partition primary command](create-partition-primary.md) | Creates a primary partition on the basic disk with focus. |
| [create partition efi command](create-partition-efi.md) | Creates an Extensible Firmware Interface (EFI) system partition on a GUID Partition Table (gpt) disk on Itanium-based computers. |
| [create partition extended command](create-partition-extended.md) | Creates an extended partition on the disk with focus. |
| [create partition logical command](create-partition-logical.md) | Creates a logical partition in an existing extended partition. |
| [create partition msr command](create-partition-msr.md) | Creates a Microsoft Reserved (MSR) partition on a GUID partition table (gpt) disk. |
| [create volume simple command](create-volume-simple.md) | Creates a simple volume on the specified dynamic disk. |
| [create volume mirror command](create-volume-mirror.md) | Creates a volume mirror by using the two specified dynamic disks. |
| [create volume raid command](create-volume-raid.md) | Creates a RAID-5 volume using three or more specified dynamic disks. |
| [create volume stripe command](create-volume-stripe.md) | Creates a striped volume using two or more specified dynamic disks. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
