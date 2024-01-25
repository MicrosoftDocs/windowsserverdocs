---
title: create partition extended
description: Reference article for the create partition extended command, which creates an extended partition on the disk with focus.
ms.topic: reference
ms.assetid: 4ad7cb66-9c66-4153-b94e-1030a7225070
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# create partition extended

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates an extended partition on the disk with focus. After the partition has been created, the focus automatically shifts to the new partition.

>[!IMPORTANT]
> You can use this command only on Master Boot Record (MBR) disks. You must use the [select disk](select-disk.md) command to select a basic MBR disk and shift the focus to it.
>
> You must create an extended partition before you can create logical drives. Only one extended partition can be created per disk. This command fails if you attempt to create an extended partition within another extended partition.

## Syntax

```
create partition extended [size=<n>] [offset=<n>] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | Specifies the size of the partition in megabytes (MB). If no size is given, the partition continues until there is no more free space in the extended partition. |
| offset=`<n>` | Specifies the offset in kilobytes (KB), at which the partition is created. If no offset is given, the partition will start at the beginning of the free space on the disk that is large enough to hold the new partition. |
| align=`<n>` | Aligns all partition extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To create an extended partition of 1000 megabytes in size, type:

```
create partition extended size=1000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)

- [select disk](select-disk.md)
