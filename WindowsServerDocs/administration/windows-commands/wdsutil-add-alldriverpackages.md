---
title: wdsutil add-alldriverpackages
description: Reference article for the wdsutil add-alldriverpackages command, which adds all driver packages that are stored in a folder to a server.
ms.topic: reference
ms.assetid: ba6641c1-d7e9-43a9-9819-702dad5484ed
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-alldriverpackages

Adds all driver packages that are stored in a folder to a server.

## Syntax

```
wdsutil /Add-AllDriverPackages /FolderPath:<folderpath> [/Server:<servername>] [/Architecture:{x86 | ia64 | x64}] [/DriverGroup:<groupname>]
```

### Parameters

| Parameter | Description |
|--|--|
| /FolderPath:`<folderpath>` | Specifies the full path to the folder that contains the .inf files for the driver packages. |
| [/Server:`<servername>`] | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| [/Architecture:`{x86|ia64|x64}`] | Specifies the architecture type for the driver package. |
| [/DriverGroup:`<groupname>`] | Specifies the name of the driver group to which the packages should be added. |

## Examples

To add driver packages, type either:

```
wdsutil /verbose /Add-AllDriverPackages /FolderPath:C:\Temp\Drivers /Architecture:x86
```

```
wdsutil /Add-AllDriverPackages /FolderPath:C:\Temp\Drivers\Printers /DriverGroup:Printer Drivers
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)

- [Add-WdsDriverPackage](/powershell/module/wds/add-wdsdriverpackage)
