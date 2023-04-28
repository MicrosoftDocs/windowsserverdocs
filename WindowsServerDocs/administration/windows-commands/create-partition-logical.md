---
title: create partition logical
description: Reference article for the create partition logical command, which creates a logical partition in an existing extended partition.
ms.topic: reference
ms.assetid: 1f59b79a-d690-4d0e-ad38-40df5a0ce38e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# create partition logical

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a logical partition on an existing extended partition. After the partition has been created, the focus automatically shifts to the new partition.

>[!IMPORTANT]
> You can use this command only on Master Boot Record (MBR) disks. You must use the [select disk](select-disk.md) command to select a basic MBR disk and shift the focus to it.
>
> You must create an [extended partition](create-partition-extended.md) before you can create logical drives.

## Syntax

```
create partition logical [size=<n>] [offset=<n>] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | Specifies the size of the logical partition in megabytes (MB), which must be smaller than the extended partition. If no size is given, the partition continues until there is no more free space in the extended partition. |
| offset=`<n>` | Specifies the offset in kilobytes (KB), at which the partition is created. The offset rounds up to completely fill whatever cylinder size is used. If no offset is given, then the partition is placed in the first disk extent that is large enough to hold it. The partition is at least as long in bytes as the number specified by **size=`<n>`**. If you specify a size for the logical partition, it must be smaller than the extended partition. |
| align=`<n>` | Aligns all volume or partition extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

#### Remarks

- If the **size** and **offset** parameters aren't specified, the logical partition is created in the largest disk extent available in the extended partition.

## Examples

To create a logical partition of 1000 megabytes in size, in the extended partition of the selected disk, type:

```
create partition logical size=1000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create command](create.md)

- [select disk](select-disk.md)
