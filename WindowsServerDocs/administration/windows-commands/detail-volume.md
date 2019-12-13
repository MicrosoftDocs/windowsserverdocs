---
title: detail volume
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 38f2bc75-2ed6-4e80-aa74-ab83133db1cd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# detail volume



Displays the disks on which the current volume resides.

## Syntax

```
detail volume
```

## Remarks

-   A volume must be selected for this operation to succeed. Use the **select volume** command to select a volume and shift the focus to it.
-   The volume details are not applicable to read-only volumes, such as a DVD-ROM or CD-ROM drive.

## <a name="BKMK_examples"></a>Examples

To see all the disks in which the current volume resides, type:
```
detail volume
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

