---
title: gpt
description: Reference article for the gpt command, which assigns the gpt attribute(s) to the partition with focus.
ms.topic: reference
ms.assetid: 1d6f9029-807f-4420-a336-36669b5361bc
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# gpt

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

On basic GUID partition table (gpt) disks, this command assigns the gpt attribute(s) to the partition with focus. Gpt partition attributes give additional information about the use of the partition. Some attributes are specific to the partition type GUID.

You must choose a basic gpt partition for this operation to succeed. Use the [select partition command](select-partition.md) to select a basic gpt partition and shift the focus to it.

> [!CAUTION]
> Changing the gpt attributes might cause your basic data volumes to fail to be assigned drive letters, or to prevent the file system from mounting. We strongly recommend that you don't change the gpt attributes unless you're an original equipment manufacturer (OEM) or an IT professional who's experienced with gpt disks.

## Syntax

```
gpt attributes=<n>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| attributes=`<n>` | Specifies the value for the attribute that you want to apply to the partition with focus. The gpt attribute field is a 64-bit field that contains two subfields. The higher field is interpreted only in the context of the partition ID, while the lower field is common to all partition IDs. Accepted values include:<ul><li>**0x0000000000000001** - Specifies that the partition is required by the computer to function properly.</li><li>**0x8000000000000000** - Specifies that the partition won't receive a drive letter by default when the disk is moved to another computer, or when the disk is seen for the first time by a computer.</li><li>**0x4000000000000000** - Hides a partition's volume so it's not detected by the mount manager.</li><li>**0x2000000000000000** - Specifies that the partition is a shadow copy of another partition.</li><li>**0x1000000000000000** - Specifies that the partition is read-only. This attribute prevents the volume from being written to.</li></ul><p>For more information about these attributes, see the attributes section at [create_PARTITION_PARAMETERS Structure](/windows/win32/api/vds/ns-vds-create_partition_parameters). |

#### Remarks

- The EFI System partition contains only those binaries necessary to start the operating system. This makes it easy for OEM binaries or binaries specific to an operating system to be placed in other partitions.

### Examples

To prevent the computer from automatically assigning a drive letter to the partition with focus, while moving a gpt disk, type:

```
gpt attributes=0x8000000000000000
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select partition command](select-partition.md)

- [create_PARTITION_PARAMETERS Structure](/windows/win32/api/vds/ns-vds-create_partition_parameters)
