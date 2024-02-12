---
title: select partition
description: Reference article for the select partition command, which selects the specified partition and shifts the focus to it.
ms.topic: reference
ms.assetid: 25f70083-b8f7-4a8e-9b34-4b3ffbe06670
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# select partition

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Selects the specified partition and shifts the focus to it. This command can also be used to display the partition that currently has the focus in the selected disk.

## Syntax

```
select partition=<n>
```

### Parameters

| Parameter | Description |
|--|--|
| partition=`<n>` | The number of the partition to receive the focus. You can view the numbers for all partitions on the disk currently selected by using the **list partition** command in DiskPart. |

#### Remarks

- Before you can select a partition you must first select a disk using the **select disk** command.

  - If no partition number is specified, this option displays the partition that currently has the focus in the selected disk.

  - If a volume is selected with a corresponding partition, the partition is automatically selected.

  - If a partition is selected with a corresponding volume, the volume is automatically selected.

## Examples

To shift the focus to *partition 3*, type:

```
select partitition=3
```

To display the partition that currently has the focus in the selected disk, type:

```
select partition
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [create partition efi command](create-partition-efi.md)

- [create partition extended command](create-partition-extended.md)

- [create partition logical command](create-partition-logical.md)

- [create partition msr command](create-partition-msr.md)

- [create partition primary command](create-partition-primary.md)

- [delete partition command](delete-partition.md)

- [detail partition command](detail-partition.md)

- [select disk command](select-disk.md)

- [select vdisk command](select-vdisk.md)

- [select volume command](select-volume.md)
