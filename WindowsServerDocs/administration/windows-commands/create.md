---
title: create
description: Reference article for the create command, which creates a partition or shadow partition on a disk, a volume on one or more disks, or a virtual hard disk (VHD).
ms.topic: reference
ms.author: roharwoo
author: robinharwood
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

## Examples

You run these commands in the DiskPart interpreter. To start it, type `diskpart` at an elevated command prompt. Each example creates a 1000-megabyte (MB) object; omit the `size` parameter to use the remaining available space. For the full parameter list and behavior of each command, see the linked child article.

Before you create a partition, run `list disk` to identify the intended basic disk, then use the [select disk](select-disk.md) command to give it focus. In the following example, replace `<disk-number>` with the number of the basic disk you want. To create a 1000-MB primary partition on the disk with focus:

```
select disk <disk-number>
create partition primary size=1000
```

Volume commands create volumes on dynamic disks that you specify by number. To create a 1000-MB simple volume on dynamic disk 1:

```
create volume simple size=1000 disk=1
```

To create a 1000-MB mirrored volume across dynamic disks 1 and 2:

```
create volume mirror size=1000 disk=1,2
```

To create a 1000-MB striped volume across dynamic disks 1 and 2:

```
create volume stripe size=1000 disk=1,2
```

To create a 1000-MB RAID-5 volume across dynamic disks 1, 2, and 3:

```
create volume raid size=1000 disk=1,2,3
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
