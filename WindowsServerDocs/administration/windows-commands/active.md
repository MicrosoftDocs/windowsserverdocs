---
title: active
description: Reference article for the active command, which on basic disks, marks the partition with focus as active.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 1f25da2e-87fc-4392-a7ee-f38d09b7873c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# active

On basic disks, marks the partition with focus as active. Only partitions can be marked as active. A partition must be selected for this operation to succeed. Use the **select partition** command to select a partition and shift the focus to it.

> [!CAUTION]
> DiskPart only informs the basic input/output system (BIOS) or Extensible Firmware Interface (EFI) that the partition or volume is a valid system partition or system volume, and is capable of containing the operating system startup files. DiskPart does not check the contents of the partition. If you mistakenly mark a partition as active and it does not contain the operating system startup files, your computer might not start.

## Syntax

```
active
```

## Examples

To mark the partition with focus as the active partition, type:

```
active
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [select partition command](select-partition.md)
