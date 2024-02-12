---
title: add-DriverPackage
description: Reference article for the add-DriverPackage command, which adds a driver package to the server.
ms.topic: reference
ms.assetid: 3ac9e8d5-63ec-4ce8-86fc-85d28011050b
ms.author: jgerend
author: JasonGerend
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

| Parameter | Description |
|--|--|
| /InfFile:`<InfFilepath>` | Specifies the full path of the .inf file to add. |
| [/Server:`<Servername>`] | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| [/Architecture:`{x86 | ia64 | x64}`] | Specifies the architecture type for the driver package. |
| [/DriverGroup:`<groupname>`] | Specifies the name of the driver group to which the packages should be added. |
| [/Name:`<friendlyname>`] | Specifies the friendly name for the driver package. |

## Examples

To add a driver package, type either:

```
wdsutil /verbose /Add-DriverPackage /InfFile:C:\Temp\Display.inf
```

```
wdsutil /Add-DriverPackage /Server:MyWDSServer /InfFile:C:\Temp\Display.inf /Architecture:x86 /DriverGroup:x86Drivers /Name:Display Driver
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-drivergrouppackage command](wdsutil-add-drivergrouppackage.md)

- [wdsutil add-alldriverpackages command](wdsutil-add-alldriverpackages.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
