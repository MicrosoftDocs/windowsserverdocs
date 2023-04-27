---
title: get-DriverPackage
description: Reference article for get-DriverPackage, which displays information about a driver package on the server.
ms.topic: reference
ms.assetid: 94d231e4-ff01-48e7-9bc8-7b0d97a4339e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# get-DriverPackage

Displays information about a driver package on the server.

## Syntax

```
wdsutil /Get-DriverPackage [/Server:<Server name>] {/DriverPackage:<Package Name> | /PackageId:<ID>} [/Show:{Drivers | Files | All}]
```

### Parameters

|        Parameter         |                                                                           Description                                                                            |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name>] |              Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.               |
| [/DriverPackage:\<Name>] |                                                        Specifies the name of the driver package to show.                                                         |
|    [/PackageId:\<ID>]    | Specifies the Windows Deployment Services ID of the driver package to show. You must specify the ID if the driver package cannot be uniquely identified by name. |
|     [/Show: {Drivers     |                                                                              Files                                                                               |

## Examples

To view information about a driver package, type one of the following:
```
wdsutil /Get-DriverPackage /PackageId:{4D36E972-E325-11CE-BFC1-08002BE10318}
```
```
wdsutil /Get-DriverPackage /DriverPackage:MyDriverPackage /Show:All
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)