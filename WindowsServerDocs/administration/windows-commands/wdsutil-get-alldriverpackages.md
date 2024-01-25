---
title: wdsutil get-alldriverpackages
description: Reference article for the wdsutil get-alldriverpackages command, which displays information about all the driver packages on a server that match the specified search criteria.
ms.topic: reference
ms.assetid: 9eb8fcb7-ef46-4c8d-9623-8969a3c8b8a4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-alldriverpackages

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about all the driver packages on a server that match the specified search criteria.

## Syntax

```
wdsutil /get-alldriverpackages [/server:<servername>] [/show:{drivers | files | all}] [/filtertype:<filtertype> /operator:{equal | notequal | greaterorequal | lessorequal | contains} /value:<value> [/value:<value> ...]]
```

### Parameters

| Parameter | Description |
|--|--|
| `[/server:<servername>] `| The name of the server. This can be the NetBIOS name or the FQDN. If a server name isn't specified, the local server is used. |
| `[/show:{drivers | files | all}]` | Indicates the package information to display. If **/show** isn't specified, the default is to return only the driver package metadata. **Drivers** displays the list of drivers in the package, **files** displays the list of files in the package, and **all** displays drivers and files. |
| `/filtertype:<filtertype>` | Specifies the attribute of the driver package to search for. You can specify multiple attributes in a single command. You must also specify **/operator** and **/value** with this option.<p>The `<filtertype>` can be one of the following:<ul><li>PackageId</li><li>PackageName</li><li>PackageEnabled</li><li>Packagedateadded</li><li>PackageInfFilename</li><li>PackageClass</li><li>PackageProvider</li><li>PackageArchitecture</li><li>PackageLocale</li><li>PackageSigned</li><li>PackagedatePublished</li><li>Packageversion</li><li>Driverdescription</li><li>DriverManufacturer</li><li>DriverHardwareId</li><li>DrivercompatibleId</li><li>DriverGroupId</li><li>DriverGroupName</li></ul> |
| `/operator:{equal | notequal | greaterorequal | lessorequal | contains}` | Specifies the relationship between the attribute and the values. You can specify **contains** only with string attributes. You can specify **greaterorequal** and **lessorequal** only with date and version attributes. |
| `/value:<value>` | Specifies the value to search on for the specified `<attribute>`. You can specify multiple values for a single **/filtertype**. The list below outlines the attributes you can specify for each filter. For more information about these attributes, see [Driver and Package attributes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759262(v=ws.11)). The attributes can include:<ul><li>**PackageId.** Specifies a valid GUID. For example:{4d36e972-e325-11ce-bfc1-08002be10318}.</li><li>**PackageName.** Specifies any string value.</li><li>**PackageEnabled.** Specifies *Yes* or *No*.</li><li>**Packagedateadded.** Specifies the date in the following format: YYYY/MM/DD</li><li>**PackageInfFilename.** Specifies any string value.</li><li>**PackageClass.** Specifies a valid class name or class GUID. For example: *DiskDrive*, *Net*, or *{4d36e972-e325-11ce-bfc1-08002be10318}*.</li><li>**PackageProvider.** Specifies any string value.</li><li>**PackageArchitecture.** Specifies *x86*, *x64*, or *ia64*.</li><li>**PackagLocale.** Specifies a valid language identifier. For example: *en-US* or *es-ES*.</li><li>**PackageSigned.** Specifies **Yes** or **No**.</li><li>**PackagedatePublished.** Specifies the date in the following format: YYYY/MM/DD.</li><li>**Packageversion.** Specifies the version in the following format: a.b.x.y. For example: 6.1.0.0.</li><li>**Driverdescription.** Specifies any string value.</li><li>**DriverManufacturer.** Specifies any string value.</li><li>**DriverHardwareId.** Specifies any string value.</li><li>**DrivercompatibleId.** Specifies any string value.</li><li>**DriverExcludeId.** Specifies any string value.</li><li>**DriverGroupId.** Specifies a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}.</li><li>**DriverGroupName.** Specifies any string value.</li></ul> |

## Examples

To display information, type either:

```
wdsutil /get-alldriverpackages /server:MyWdsServer /show:all /filtertype:drivergroupname /operator:contains /value:printer /filtertype:packagearchitecture /operator:equal /value:x64 /value:x86
```

```
wdsutil /get-alldriverpackages /show:drivers /filtertype:packagedateadded /operator:greaterorequal /value:2008/01/01
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil get-driverpackage command](wdsutil-get-driverpackage.md)

- [wdsutil get-driverpackagefile command](wdsutil-get-driverpackagefile.md)
