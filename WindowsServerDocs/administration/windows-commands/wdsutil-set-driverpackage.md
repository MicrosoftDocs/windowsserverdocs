---
title: Subcommand set-DriverPackage
description: Reference article for Subcommand set-DriverPackage, which renames and/or enables or disables a driver package on a server.
ms.topic: reference
ms.assetid: 11804bb6-ca29-4461-8c63-5131748cd742
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# Subcommand: set-DriverPackage

Renames and/or enables or disables a driver package on a server.

## Syntax

```
wdsutil /Set-DriverPackage [/Server:<Server name>] {/DriverPackage:<Name> | /PackageId:<ID>} [/Name:<New Name>] [/Enabled:{Yes | No}
```

### Parameters

|        Parameter         |                                                                                                                                                                                                               Description                                                                                                                                                                                                                |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name>] |                                                                                                                                                 Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.                                                                                                                                                 |
| [/DriverPackage:\<Name>] |                                                                                                                                                                                       Specifies the current name of the driver package to modify.                                                                                                                                                                                        |
|    [/PackageId:\<ID>]    | Specifies the Windows Deployment Services ID of the driver package. You must specify this option if the driver package cannot be uniquely identified by name. To find this ID for a package, click the driver group that the package is in (or the **All Packages** node), right-click the package, and then click **Properties**. The Package ID is listed on the **General** tab. For example: {DD098D20-1850-4FC8-8E35-EA24A1BEFF5E}. |
|   [/Name:\<New Name>]    |                                                                                                                                                                                              Specifies the new name for the driver package.                                                                                                                                                                                              |
|      [/Enabled:{Yes      |                                                                                                                                                                                                                   No}                                                                                                                                                                                                                    |

## Examples

To change settings about a package, type one of the following:
```
wdsutil /Set-DriverPackage /PackageId:{4D36E972-E325-11CE-BFC1-08002BE10318} /Name:MyDriverPackage
```
```
wdsutil /Set-DriverPackage /DriverPackage:MyDriverPackage /Name:NewName /Enabled:Yes
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)