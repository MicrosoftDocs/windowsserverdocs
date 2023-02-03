---
title: clean
description: Reference article for the Diskpart clean command, which removes all partitions or volume formatting from the disk with focus.
ms.topic: reference
ms.assetid: 9bbe6fd3-e07e-487b-9035-910957a1d326
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# clean

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes all partitions or volume formatting from the disk with focus.

>[!NOTE]
> For a PowerShell version of this command, see [clear-disk command](/powershell/module/storage/clear-disk).

## Syntax

```
clean [all]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| all | Specifies that each and every sector on the disk is set to zero, which completely deletes all data contained on the disk. |

#### Remarks

- On master boot record (MBR) disks, only the MBR partitioning information and hidden sector information is overwritten.

- On GUID Partition Table (gpt) disks, the gpt partitioning information, including the Protective MBR, is overwritten. There is no hidden sector information.

- A disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.

## Examples

To remove all formatting from the selected disk, type:

```
clean
```

## Related links

- [clear-disk command](/powershell/module/storage/clear-disk)

- [Command-Line Syntax Key](command-line-syntax-key.md)
