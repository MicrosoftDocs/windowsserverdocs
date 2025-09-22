---
title: wdsutil remove-driverpackage
description: Reference article for wdsutil remove-driverpackage, which removes a driver package from a server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# wdsutil remove-driverpackage



Removes a driver package from a server.

## Syntax
```
wdsutil /remove-DriverPackage [/Server:<Server name>] {/DriverPackage:<Package Name> | /PackageId:<ID>}
```
### Parameters

|        Parameter        |                                                                            Description                                                                             |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name\>] |              Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.              |
| [/DriverPackage:\<Name\>] |                                                        Specifies the name of the driver package to remove.                                                         |
|    [/PackageId:\<ID\>]    | Specifies the Windows Deployment Services ID of the driver package to remove. You must specify the ID if the driver package cannot be uniquely identified by name. |

## Examples
To view information about the images, type one of the following:
```
wdsutil /remove-DriverPackage /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```
```
wdsutil /remove-DriverPackage /Server:MyWdsServer /DriverPackage:MyDriverPackage
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil remove-driverpackages command](wdsutil-remove-driverpackages.md)
