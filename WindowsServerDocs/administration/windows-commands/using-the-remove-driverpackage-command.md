---
title: remove-DriverPackage
description: Reference article for remove-DriverPackage, which removes a driver package from a server.
ms.topic: reference
ms.assetid: 6b201e91-0d44-4e4a-8252-8b0235df1002
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# remove-DriverPackage

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes a driver package from a server.

## Syntax
```
wdsutil /remove-DriverPackage [/Server:<Server name>] {/DriverPackage:<Package Name> | /PackageId:<ID>}
```
### Parameters

|        Parameter        |                                                                            Description                                                                             |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:<Server name>] |              Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.              |
| [/DriverPackage:<Name>] |                                                        Specifies the name of the driver package to remove.                                                         |
|    [/PackageId:<ID>]    | Specifies the Windows Deployment Services ID of the driver package to remove. You must specify the ID if the driver package cannot be uniquely identified by name. |

## Examples
To view information about the images, type one of the following:
```
wdsutil /remove-DriverPackage /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```
```
wdsutil /remove-DriverPackage /Server:MyWdsServer /DriverPackage:MyDriverPackage
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the remove-DriverPackages Command](using-the-remove-driverpackages-command.md)
