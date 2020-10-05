---
title: wdsutil add-alldriverpackages
description: Reference article for wdsutil add-alldriverpackages, which adds all driver packages that are stored in a folder to a server.
ms.topic: reference
ms.assetid: ba6641c1-d7e9-43a9-9819-702dad5484ed
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-alldriverpackages

Adds all driver packages that are stored in a folder to a server.

## Syntax

```
WDSUTIL /Add-AllDriverPackages /FolderPath:<Folder Path> [/Server:<Server name>] [/Architecture:{x86 | ia64 | x64}] [/DriverGroup:<Group Name>]
```

### Parameters

|          Parameter           |                                                              Description                                                              |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
|  /FolderPath:\<Folder Path>  |                      Specifies the full path to the folder that contains the .inf files for the driver packages.                      |
|   [/Server:\<Server name>]   | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
|     [/Architecture:{x86      |                                                                 ia64                                                                  |
| [/DriverGroup:\<Group Name>] |                             Specifies the name of the driver group to which the packages should be added.                             |

## Examples

To add driver packages, type one of the following:
```
WDSUTIL /verbose /Add-AllDriverPackages /FolderPath:C:\Temp\Drivers /Architecture:x86
```
```
WDSUTIL /Add-AllDriverPackages /FolderPath:C:\Temp\Drivers\Printers /DriverGroup:Printer Drivers
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wsdutil add-wdsdriverpackage](/previous-versions/windows/powershell-scripting/dn283440(v=wps.630))
