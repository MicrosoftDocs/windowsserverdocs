---
title: set id
description: Reference article for the Diskpart set id command, which changes the partition type field for the partition with focus.
ms.topic: reference
ms.assetid: 5793d7ad-827e-4285-b2c6-ae60eeb0e886
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# set id (Diskpart)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the partition type field for the partition with focus. This command doesn't work on dynamic disks or on Microsoft Reserved partitions.

> [!IMPORTANT]
> This command is intended for use by original equipment manufacturers (OEMs) only. Changing partition type fields with this parameter might cause your computer to fail or be unable to boot. Unless you are an OEM or experienced with gpt disks, you should not change partition type fields on gpt disks by using this parameter. Instead, always use the [create partition efi](create-partition-efi.md) command to create EFI system partitions, the [create partition msr](create-partition-msr.md) command to create Microsoft Reserved partitions, and the [create partition primary](create-partition-primary.md) command without the ID parameter to create primary partitions on gpt disks.

## Syntax

```
set id={ <byte> | <GUID> } [override] [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| `<byte>` | For master boot record (MBR) disks, specifies the new value for the type field, in hexadecimal form, for the partition. Any partition type **byte** can be specified with this parameter except for type 0x42, which specifies an LDM partition. Note that the leading  0x is omitted when specifying the hexadecimal partition type. |
| `<GUID>` | For GUID partition table (gpt) disks, specifies the new GUID value for the type field for the partition. Recognized GUIDs include:<ul><li>**EFI system partition:** c12a7328-f81f-11d2-ba4b-00a0c93ec93b</li><li>**Basic data partition:** ebd0a0a2-b9e5-4433-87c0-68b6b72699c7</li></ul>Any partition type GUID can be specified with this parameter except the following:<ul><li>**Microsoft Reserved partition:** e3c9e316-0b5c-4db8-817d-f92df00215ae</li><li>**LDM metadata partition on a dynamic disk:** 5808c8aa-7e8f-42e0-85d2-e1e90434cfb3</li><li>**LDM data partition on a dynamic disk:** af9b60a0-1431-4f62-bc68-3311714a69ad</li><li>**Cluster metadata partition:** db97dba9-0840-4bae-97f0-ffb9a327c7e1</li></ul> |
| override | forces the file system on the volume to dismount before changing the partition type. When you run the **set id** command, DiskPart attempts to lock and dismount the file system on the volume. If **override** isn't specified, and the call to lock the file system fails (for example, because there is an open handle), the operation fails. If **override** is specified, DiskPart forces the dismount even if the call to lock the file system fails, and any open handles to the volume will stop being valid. |
| noerr | Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Remarks

- Other than the limitations previously mentioned, DiskPart doesn't check the validity of the value that you specify (except to ensure that it is a byte in hexadecimal form or a GUID).

## Examples

To set the type field to *0x07* and force the file system to dismount, type:

```
set id=0x07 override
```

To set the type field to be a basic data partition, type:

```
set id=ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
