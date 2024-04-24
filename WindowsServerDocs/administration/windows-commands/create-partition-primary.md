---
title: create partition primary
description: Reference article for the create partition primary command, which creates a primary partition on the basic disk with focus.
ms.topic: reference
ms.assetid: 6d652d8e-3935-4a91-8ced-b17c0e7937be
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# create partition primary

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates a primary partition on the basic disk with focus. After the partition has been created, the focus automatically shifts to the new partition.

> [!IMPORTANT]
> A basic disk must be selected for this operation to succeed. You must use the [select disk](select-disk.md) command to select a basic disk and shift the focus to it.

## Syntax

```
create partition primary [size=<n>] [offset=<n>] [id={ <byte> | <guid> }] [align=<n>] [noerr]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| size=`<n>` | Specifies the size of the partition in megabytes (MB). If no size is given, the partition continues until there is no more unallocated space in the current region. |
| offset=`<n>` | The offset in kilobytes (KB), at which the partition is created. If no offset is given, the partition will start at the beginning of the largest disk extent that is large enough to hold it. |
| align=`<n>` | Aligns all partition extents to the closest alignment boundary. Typically used with hardware RAID Logical Unit Number (LUN) arrays to improve performance. `<n>` is the number of kilobytes (KB) from the beginning of the disk to the closest alignment boundary. |
| id={ `<byte>  | <guid>` } | Specifies the partition type. This parameter is intended for original equipment manufacturer (OEM) use only. Any partition type byte or GUID can be specified with this parameter. DiskPart doesn't check the partition type for validity except to ensure that it is a byte in hexadecimal form or a GUID. **Caution:** Creating partitions with this parameter might cause your computer to fail or be unable to start up. Unless you are an OEM or an IT professional experienced with gpt disks, do not create partitions on gpt disks using this parameter. Instead, always use the [create partition efi](create-partition-efi.md) command to create EFI System partitions, the [create partition msr](create-partition-msr.md) command to create Microsoft Reserved partitions, and the [create partition primary](create-partition-primary.md)) command (without the `id={ <byte>  | <guid>` parameter) to create primary partitions on gpt disks.<p>**For master boot record (MBR) disks**, you must specify a partition type byte, in hexadecimal form, for the partition. If this parameter isn't specified, the command creates a partition of type `0x06`, which specifies that a file system isn't installed. Examples include:<ul><li>**LDM data partition:** 0x42</li><li>**Recovery partition:** 0x27</li><li>**Recognized OEM partition:** 0x12, 0x84, 0xDE, 0xFE, 0xA0</li></ul><p>**For GUID partition table (gpt) disks**, you can specify a partition type GUID for the partition that you want to create. Recognized GUIDs include:<ul><li>**EFI system partition:** c12a7328-f81f-11d2-ba4b-00a0c93ec93b</li><li>**Microsoft Reserved partition:** e3c9e316-0b5c-4db8-817d-f92df00215ae</li><li>**Basic data partition:** ebd0a0a2-b9e5-4433-87c0-68b6b72699c7</li><li>**LDM metadata partition (dynamic disk):** 5808c8aa-7e8f-42e0-85d2-e1e90434cfb3</li><li>**LDM data partition  (dynamic disk):** af9b60a0-1431-4f62-bc68-3311714a69ad</li><li>**Recovery partition:** de94bba4-06d1-4d40-a16a-bfd50179d6ac<p>If this parameter isn't specified for a gpt disk, the command creates a basic data partition.</li></ul> |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without the noerr parameter, an error causes DiskPart to exit with an error code. |

## Examples

To create a primary partition of 1000 megabytes in size, type:

```
create partition primary size=1000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [assign command](assign.md)

- [create command](create.md)

- [select disk](select-disk.md)
