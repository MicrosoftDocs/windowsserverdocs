---
title: wdsutil get-driverpackagefile
description: Reference article for wdsutil get-driverpackagefile, which displays information about a driver package, including the drivers and files it contains.
ms.topic: reference
ms.assetid: f01a2c67-7e9c-4aad-b625-383f5a1fca25
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-driverpackagefile

Displays information about a driver package, including the drivers and files it contains.

## Syntax

```
wdsutil /Get-DriverPackageFile /InfFile:<Inf File path> [/Architecture:{x86 | ia64 | x64}] [/Show:{Drivers | Files | All}]
```

### Parameters

|         Parameter         |                              Description                               |
|---------------------------|------------------------------------------------------------------------|
| /InfFile:\<Inf File path> | Specifies the full path and file name of the driver package .inf file. |
|    [/Architecture:{x86    |                                  ia64                                  |
|     [/Show: {Drivers      |                                 Files                                  |

## Examples

To view information about a driver file, type:
```
wdsutil /Get-DriverPackageFile /InfFile:C:\temp\1394.inf /Architecture:x86
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)