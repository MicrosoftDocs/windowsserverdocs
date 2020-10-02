---
title: add-DriverGroupPackage
description: Reference article for add-DriverGroupPackage, which adds a driver package to a driver group.
ms.topic: reference
ms.assetid: 7cd323ae-9049-448e-a460-6c7d6462d4c8
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# add-DriverGroupPackage

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds a driver package to a driver group.

## Syntax
```
wdsutil /add-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}
```
### Parameters

|         Parameter         |                                                                                                                                               Description                                                                                                                                               |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /DriverGroup:<Group Name> |                                                                                                                                 Specifies the name of the driver group.                                                                                                                                 |
|   /Server:<Server name>   |                                                                                  Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.                                                                                  |
|   /DriverPackage:<Name>   |                                                                      Specifies the name of the driver package to be added to the group. You must specify this option if the driver package cannot be uniquely identified by name.                                                                       |
|      /PackageId:<ID>      | Specifies the ID for a package. To find the Package ID, click the driver group that the package is in (or the **All Packages** node), right-click the package, and then click **Properties**. The Package ID is listed on the **General** tab, for example: **{DD098D20-1850-4fc8-8E35-EA24A1BEFF5E}**. |

## Examples
To add a driver package, type one of the following:
```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```
```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /DriverPackage:XYZ
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[wdsutiladd-DriverGroupPackages command](wdsutil-add-drivergrouppackages.md)
[wdsutiladd-DriverPackage command](wdsutil-add-driverpackage.md)
[wdsutiladd-AllDriverPackages subcommand](wdsutil-add-alldriverpackages-subcommand.md)
