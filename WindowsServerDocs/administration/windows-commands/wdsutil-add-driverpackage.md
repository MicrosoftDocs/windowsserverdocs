---
title: add-DriverPackage
description: Reference article for add-DriverPackage, which adds a driver package to the server.
ms.topic: reference
ms.assetid: 3ac9e8d5-63ec-4ce8-86fc-85d28011050b
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# add-DriverPackage

Adds a driver package to the server.

## Syntax

```
wdsutil /Add-DriverPackage /InfFile:<Inf File path> [/Server:<Server name>] [/Architecture:{x86 | ia64 | x64}] [/DriverGroup:<Group Name>] [/Name:<Friendly Name>]
```

### Parameters

|          Parameter           |                                                              Description                                                              |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------|
|   InfFile:\<Inf File path>   |                                           Specifies the full path of the .inf file to add.                                            |
|    /Server:\<Server name>    | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
|      /Architecture:{x86      |                                                                 ia64                                                                  |
| [/DriverGroup:\<Group Name>] |                             Specifies the name of the driver group to which the package should be added.                              |
|   [/Name:\<Friendly Name>]   |                                           States the friendly name for the driver package.                                            |

## Examples

To add a driver package, type one of the following:
```
wdsutil /verbose /Add-DriverPackage /InfFile:C:\Temp\Display.inf
```
```
wdsutil /Add-DriverPackage /Server:MyWDSServer /InfFile:C:\Temp\Display.inf /Architecture:x86 /DriverGroup:x86Drivers /Name:Display Driver
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

