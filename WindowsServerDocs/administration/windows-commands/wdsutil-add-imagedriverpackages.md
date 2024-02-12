---
title: wdsutil add-imagedriverpackages
description: Reference article for the wdsutil add-imagedriverpackages command, which adds driver packages from the driver store to a boot image.
ms.topic: reference
ms.assetid: 9dc78909-a4d1-42a2-af8f-21ebcbfe8302
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-imagedriverpackages

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds driver packages from the driver store to a boot image.

## Syntax

```
wdsutil /add-ImageDriverPackages [/Server:<Server name>media:<Image namemediatype:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>] /Filtertype:<Filter type> /Operator:{Equal | NotEqual | GreaterOrEqual | LessOrEqual | Contains} /Value:<Value> [/Value:<Value> ...]
```

### Parameters

| Parameter | Description |
|--|--|
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If a server name is not specified, the local server is used. |
| [media:`<Imagename>`] | Specifies the name of the image to add the driver to. |
| [mediatype:Boot] | Specifies the type of image to add the driver to. Driver packages can only be added to boot images. |
| [/Architecture:`{x86 | ia64 | x64}`] | Specifies the architecture of the boot image. Because it's possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure the correct image is used. |
| [/Filename:`<Filename>`] | Specifies the name of the file. If the image cannot be uniquely identified by name, the file name must be specified. |
| /Filtertype:`<Filtertype>` | Specifies the attribute of the driver package to search for. You can specify multiple attributes in a single command. You must also specify **/Operator** and **/Value** with this option. Valid values include:<ul><li>PackageId</li><li>PackageName</li><li>PackageEnabled</li><li>Packagedateadded</li><li>PackageInfFilename</li><li>PackageClass<p>PackageProvider</li><li>PackageArchitecture</li><li>PackageLocale</li><li>PackageSigned</li><li>PackagedatePublished</li><li>Packageversion</li><li>Driverdescription</li><li>DriverManufacturer</li><li>DriverHardwareId</li><li>DrivercompatibleId</li><li>DriverExcludeId</li><li>DriverGroupId</li><li>DriverGroupName**</li></ul>. |
| /Operator:`{Equal|NotEqual|GreaterOrEqual|LessOrEqual|Contains}` | Specifies the relationship between the attribute and the values. You can only specify **Contains** with string attributes. You can only specify **GreaterOrEqual** and **LessOrEqual** with date and version attributes. |
| /Value:`<Value>` | Specifies the value to search for relative to the specified `<attribute>`. You can specify multiple values for a single **/Filtertype**. The available values for each filter are:<ul><li>**PackageId** - Specify a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}</li><li>**PackageName** - Specify any string value</li><li>**PackageEnabled** - Specify **Yes** or **No**</li><li>**Packagedateadded** - Specify the date in the following format: YYYY/MM/DD</li><li>**PackageInfFilename** - Specify any string value</li><li>**PackageClass** - Specify a valid class name or class GUID. For example: **DiskDrive**, **Net**, or {4d36e972-e325-11ce-bfc1-08002be10318}</li><li>**PackageProvider** - Specify any string value</li><li>**PackageArchitecture** - Specify **x86**, **x64**, or **ia64**</li><li>**PackageLocale** - Specify a valid language identifier. For example: **en-US** or **es-ES**</li><li>**PackageSigned** - Specify **Yes** or **No**</li><li>**PackagedatePublished** - Specify the date in the following format: YYYY/MM/DD</li><li>**Packageversion** - Specify the version in the following format: a.b.x.y. For example: 6.1.0.0</li><li>**Driverdescription** - Specify any string value</li><li>**DriverManufacturer** - Specify any string value</li><li>**DriverHardwareId** - Specify any string value</li><li>**DrivercompatibleId** - Specify any string value</li><li>**DriverExcludeId** - Specify any string value</li><li>**DriverGroupId** - Specify a valid GUID. For example: {4d36e972-e325-11ce-bfc1-08002be10318}</li><li>**DriverGroupName** - Specify any string value</li></ul> For more information about these values, see [Driver and Package attributes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759262(v=ws.11)). |

## Examples

To add driver packages to a boot image, type one of the following:

```
wdsutil /add-ImageDriverPackagemedia:WinPE Boot Imagemediatype:Boot /Architecture:x86 /Filtertype:DriverGroupName /Operator:Equal /Value:x86Bus /Filtertype:PackageProvider /Operator:Contains /Value:Provider1 /Filtertype:Packageversion /Operator:GreaterOrEqual /Value:6.1.0.0
```

```
wdsutil /verbose /add-ImageDriverPackagemedia: WinPE Boot Image /Server:MyWDSServemediatype:Boot /Architecture:x64 /Filtertype:PackageClass /Operator:Equal /Value:Net /Filtertype:DriverManufacturer /Operator:NotEqual /Value:Name1 /Value:Name2 /Filtertype:Packagedateadded /Operator:LessOrEqual /Value:2008/01/01
```

```
wdsutil /verbose /add-ImageDriverPackagemedia:WinPE Boot Image /Server:MyWDSServemediatype:Boot /Architecture:x64 /Filtertype:PackageClass /Operator:Equal /Value:Net /Value:System /Value:DiskDrive /Value:HDC /Value:SCSIAdapter
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
-
- [wdsutil add-imagedriverpackage command](wdsutil-add-imagedriverpackage.md)
-
- [wdsutil add-alldriverpackages command](wdsutil-add-alldriverpackages.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
