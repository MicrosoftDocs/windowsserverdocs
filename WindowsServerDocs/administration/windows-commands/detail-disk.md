---
title: detail disk
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6b09cf40-8d93-452b-b449-5242e62a4102
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# detail disk



Displays the properties of the selected disk and the volumes on that disk.

## Syntax

```
detail disk
```

## Remarks

-   A disk must be selected for this operation to succeed. Use the **select disk** command to select a disk and shift the focus to it.
-   If the selected disk is a virtual hard disk (VHD), **detail disk** reports the disk's bus type as Virtual.

## <a name="BKMK_examples"></a>Examples

To see the properties of the selected disk, and information about the volumes in the disk, type:
```
detail disk
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

