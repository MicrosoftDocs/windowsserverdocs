---
title: wdsutil get-driverpackagefile
description: Reference article for wdsutil get-driverpackagefile, which displays information about a driver package, including the drivers and files it contains.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/19/2024
---

# wdsutil get-driverpackagefile

Displays information about a driver package, including the drivers and files it contains.

## Syntax

```
wdsutil /Get-DriverPackageFile /InfFile:<InfFilePath> [/Architecture:{x86 | x64 | arm | arm64}] [/Show:{Drivers | Files | All}]
```

### Parameters

|         Parameter         |                              Description                               |
|---------------------------|------------------------------------------------------------------------|
| /InfFile:`<InfFilePath>` | Specifies the full path and file name of the driver package `.inf` file. |
| /Architecture:`x86 | x64 | arm | arm64` | The architecture of the driver package. |
| /Show:`Drivers | Files | All` | Indicates the package information to display. The default, if `/show` isn't specified, is to return only the driver package metadata. <br><ul><li> **Drivers** displays the list of drivers in the package. <li> **Files** displays the list of files in the package. <li> **All** displays drivers and files. </ul></li> |

## Examples

To view information about a driver file, type:

```
wdsutil /Get-DriverPackageFile /InfFile:C:\temp\1394.inf /Architecture:x86
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
