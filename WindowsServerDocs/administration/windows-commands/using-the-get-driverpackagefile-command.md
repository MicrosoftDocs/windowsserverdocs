---
title: Using the get-DriverPackageFile Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f01a2c67-7e9c-4aad-b625-383f5a1fca25
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Using the get-DriverPackageFile Command



Displays information about a driver package, including the drivers and files it contains.

## Syntax

```
WDSUTIL /Get-DriverPackageFile /InfFile:<Inf File path> [/Architecture:{x86 | ia64 | x64}] [/Show:{Drivers | Files | All}]
```

## Parameters

|         Parameter         |                              Description                               |
|---------------------------|------------------------------------------------------------------------|
| /InfFile:\<Inf File path> | Specifies the full path and file name of the driver package .inf file. |
|    [/Architecture:{x86    |                                  ia64                                  |
|     [/Show: {Drivers      |                                 Files                                  |

## <a name="BKMK_examples"></a>Examples

To view information about a driver file, type:
```
WDSUTIL /Get-DriverPackageFile /InfFile:"C:\temp\1394.inf" /Architecture:x86
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)