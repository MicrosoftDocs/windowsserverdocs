---
title: create partition msr
description: Reference article for create partition msr, which creates a Microsoft Reserved (MSR) partition on a GUID partition table (gpt) disk.
ms.topic: reference
ms.assetid: 04fba033-23cb-4521-bd5d-db96131f2e73
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# create partition msr

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a Microsoft Reserved (MSR) partition on a GUID partition table (gpt) disk. A Microsoft Reserved partition is required on every gpt disk. The size of this partition depends on the total size of the gpt disk. The size of the gpt disk must be at least 32 MB to create a Microsoft Reserved partition.

> [!IMPORTANT]
> Be very careful when using this command. Because gpt disks require a specific partition layout, creating Microsoft Reserved partitions can cause the disk to become unreadable.
>
> A basic gpt disk must be selected for this operation to succeed. You must use the [select disk](select-disk.md) command to select a basic gpt disk and shift the focus to it.

## Syntax

```
create partition msr [size=<n>] [offset=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | The size of the partition in megabytes (MB). The partition is at least as long in bytes as the number specified by `<n>`. If no size is given, the partition continues until there is no more free space in the current region. |
| offset=`<n>` | Specifies the offset in kilobytes (KB), at which the partition is created. The offset rounds up to completely fill whatever sector size is used. If no offset is given, the partition is placed in the first disk extent that is large enough to hold it. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

#### Remarks

- On gpt disks that are used to boot the Windows operating system, the Extensible Firmware Interface (EFI) system partition is the first partition on the disk, followed by the Microsoft Reserved partition. gpt disks that are used only for data storage do not have an EFI system partition, in which case the Microsoft Reserved partition is the first partition.

- Windows doesn't mount Microsoft Reserved partitions. You cannot store data on them and you cannot delete them.

## Examples

To create a Microsoft Reserved partition of 1000 megabytes in size, type:

```
create partition msr size=1000
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)

- [select disk](select-disk.md)
