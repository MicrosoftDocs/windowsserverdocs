---
title: active
description: "Windows Commands topic for **active** - On basic disks, marks the partition with focus as active."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1f25da2e-87fc-4392-a7ee-f38d09b7873c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# active



On basic disks, marks the partition with focus as active.

> [!CAUTION]
> DiskPart verifies only that the partition is capable of containing the operating system startup files. DiskPart does not check the contents of the partition. If you mistakenly mark a partition as active and it does not contain the operating system startup files, your computer might not start.

## Syntax

```
active
```

## Remarks

-   This informs the basic input/output system (BIOS) or Extensible Firmware Interface (EFI) that the partition or volume is a valid system partition or system volume.
-   Only partitions can be marked as active.
-   A partition must be selected for this operation to succeed. Use the **select partition** command to select a partition and shift the focus to it.

## <a name="BKMK_examples"></a>Examples

To mark the partition with focus as the active partition, type:
```
active
```

#### Additional references

