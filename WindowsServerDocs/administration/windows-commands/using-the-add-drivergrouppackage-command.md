---
title: Using the add-DriverGroupPackage Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7cd323ae-9049-448e-a460-6c7d6462d4c8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the add-DriverGroupPackage Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

adds a driver package to a driver group.
## Syntax
```
wdsutil /add-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}
```
## Parameters

|         Parameter         |                                                                                                                                               Description                                                                                                                                               |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /DriverGroup:<Group Name> |                                                                                                                                 Specifies the name of the driver group.                                                                                                                                 |
|   /Server:<Server name>   |                                                                                  Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.                                                                                  |
|   /DriverPackage:<Name>   |                                                                      Specifies the name of the driver package to be added to the group. You must specify this option if the driver package cannot be uniquely identified by name.                                                                       |
|      /PackageId:<ID>      | Specifies the ID for a package. To find the Package ID, click the driver group that the package is in (or the **All Packages** node), right-click the package, and then click **Properties**. The Package ID is listed on the **General** tab, for example: **{DD098D20-1850-4fc8-8E35-EA24A1BEFF5E}**. |

## <a name="BKMK_examples"></a>Examples
To add a driver package, type one of the following:
```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```
```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /DriverPackage:XYZ
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-DriverGroupPackages Command](using-the-add-drivergrouppackages-command.md)
[Using the add-DriverPackage Command](using-the-add-driverpackage-command.md)
[Using the add-AllDriverPackages subcommand](using-the-add-alldriverpackages-subcommand.md)
