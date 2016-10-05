---
title: Using the get-DriverPackageFile Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f01a2c67-7e9c-4aad-b625-383f5a1fca25
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the get-DriverPackageFile Command
Displays information about a driver package, including the drivers and files it contains.
## Syntax
```
WDSUTIL /Get-DriverPackageFile /InfFile:<Inf File path> [/Architecture:{x86 | ia64 | x64}] [/Show:{Drivers | Files | All}]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/InfFile:<Inf File path>|Specifies the full path and file name of the driver package .inf file.|
|[/Architecture:{x86 &#124; ia64 &#124; x64}]|Specifies the architecture of the driver package.|
|[/Show: {Drivers &#124; Files &#124; All}]|Indicates the package information to display. If **/Show** is not specified, the default is to return only the driver package metadata. **Drivers** displays the list of drivers in the package. **Files** displays the list of files in the package. **All** displays drivers and files.|
## <a name="BKMK_examples"></a>Examples
To view information about a driver file, type:
```
WDSUTIL /Get-DriverPackageFile /InfFile:"C:\temp\1394.inf" /Architecture:x86
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
