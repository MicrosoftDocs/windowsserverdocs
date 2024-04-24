---
title: wdsutil add-drivergrouppackage
description: Reference article for the wdsutil add-drivergrouppackage command, which adds a driver package to a driver group.
ms.topic: reference
ms.assetid: 7cd323ae-9049-448e-a460-6c7d6462d4c8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-drivergrouppackage

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds a driver package to a driver group.

## Syntax

```
wdsutil /add-DriverGroupPackage /DriverGroup:<Group Name> [/Server:<Server Name>] {/DriverPackage:<Name> | /PackageId:<ID>}
```

### Parameters

| Parameter | Description |
|--|--|
| /DriverGroup:`<Groupname>` | Specifies the name of the new driver group. |
| /Server:`<Servername>` | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| /DriverPackage:`<Name>` | Specifies the name of the driver package to be added to the group. You must specify this option if the driver package cannot be uniquely identified by name. |
| /PackageId:`<ID>` | Specifies the ID for a package. To find the Package ID, select the driver group that the package is in (or the **All Packages** node), right-click the package, and then select **Properties**. The Package ID is listed on the **General** tab, for example: **{DD098D20-1850-4fc8-8E35-EA24A1BEFF5E}**. |

## Examples

To add a driver group package, type either:

```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```

```
wdsutil /add-DriverGroupPackage /DriverGroup:printerdrivers /DriverPackage:XYZ
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-drivergroupfilter command](wdsutil-add-drivergroupfilter.md)

- [wdsutil add-drivergrouppackages command](wdsutil-add-drivergrouppackages.md)

- [wdsutil add-drivergroup command](wdsutil-add-drivergroup.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
