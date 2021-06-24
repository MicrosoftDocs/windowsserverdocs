---
title: wdsutil add-drivergrouppackages
description: Reference article for the wdsutil add-drivergrouppackages command, which add driver group packages.
ms.topic: reference
ms.assetid: 29022f53-ce14-4b2d-a81a-679c18e022b2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-drivergrouppackages

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds driver group packages.

## Syntax

```
wdsutil /add-DriverGroupPackages /DriverGroup:<Group Name> [/Server:<Server Name>] /Filtertype:<Filter type> /Operator:{Equal | NotEqual | GreaterOrEqual | LessOrEqual | Contains} /Value:<Value> [/Value:<Value>]
```

### Parameters

| Parameter | Description |
|--|--|
| /DriverGroup:`<Groupname>` | Specifies the name of the new driver group. |
| /Server:`<Servername>` | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| /Filtertype:`<Filtertype>` | Specifies the type of the driver package to search for. You can specify multiple attributes in a single command. You must also specify **/Operator** and **/Value** with this option. Valid values include:<ul><li>PackageId</li><li>PackageName</li><li>PackageEnabled</li><li>Packagedateadded</li><li>PackageInfFilename</li><li>PackageClass<p>PackageProvider</li><li>PackageArchitecture</li><li>PackageLocale</li><li>PackageSigned</li><li>PackagedatePublished</li><li>Packageversion</li><li>Driverdescription</li><li>DriverManufacturer</li><li>DriverHardwareId</li><li>DrivercompatibleId</li><li>DriverExcludeId</li><li>DriverGroupId</li><li>DriverGroupName**</li></ul>. |
| /Operator:`{Equal|NotEqual|GreaterOrEqual|LessOrEqual|Contains}` | Specifies the relationship between the attribute and the values. You can only specify **Contains** with string attributes. You can only specify **Equal**, **NotEqual**, **GreaterOrEqual** and **LessOrEqual** with date and version attributes. |
| /Value:`<Value>` | Specifies the client value corresponding to **/Filtertype**. You can specify multiple values for a single **/Filtertype**. The available values for each filter are:<ul><li>**PackageId** - Specify a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}</li><li>**PackageName** - Specify any string value</li><li>**PackageEnabled** - Specify **Yes** or **No**</li><li>**Packagedateadded** - Specify the date in the following format: YYYY/MM/DD</li><li>**PackageInfFilename** - Specify any string value</li><li>**PackageClass** - Specify a valid class name or class GUID. For example: **DiskDrive**, **Net**, or {4d36e972-e325-11ce-bfc1-08002be10318}</li><li>**PackageProvider** - Specify any string value</li><li>**PackageArchitecture** - Specify **x86**, **x64**, or **ia64**</li><li>**PackageLocale** - Specify a valid language identifier. For example: **en-US** or **es-ES**</li><li>**PackageSigned** - Specify **Yes** or **No**</li><li>**PackagedatePublished** - Specify the date in the following format: YYYY/MM/DD</li><li>**Packageversion** - Specify the version in the following format: a.b.x.y. For example: 6.1.0.0</li><li>**Driverdescription** - Specify any string value</li><li>**DriverManufacturer** - Specify any string value</li><li>**DriverHardwareId** - Specify any string value</li><li>**DrivercompatibleId** - Specify any string value</li><li>**DriverExcludeId** - Specify any string value</li><li>**DriverGroupId** - Specify a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}</li><li>**DriverGroupName** - Specify any string value</li></ul> For more information about these values, see [Driver and Package attributes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759262(v=ws.11)). |

## Examples

To add a driver group package, type either:

```
wdsutil /verbose /add-DriverGroupPackages /DriverGroup:printerdrivers /Filtertype:PackageClass /Operator:Equal /Value:printer /Filtertype:DriverManufacturer /Operator:NotEqual /Value:Name1 /Value:Name2
```

```
wdsutil /verbose /add-DriverGroupPackages /DriverGroup:DisplayDriversX86 /Filtertype:PackageClass /Operator:Equal /Value:Display /Filtertype:PackageArchitecture /Operator:Equal /Value:x86 /Filtertype:Packagedateadded /Operator:LessOrEqual /Value:2008/01/01
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-driverpackage command](wdsutil-add-driverpackage.md)

- [wdsutil add-drivergrouppackage command](wdsutil-add-drivergrouppackage.md)

- [wdsutil add-alldriverpackages command](wdsutil-add-alldriverpackages.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
