---
title: wdsutil add-imagedriverpackage
description: Reference article for the wdsutil add-imagedriverpackage command, which adds a driver package that is in the driver store to an existing boot image on the server.
ms.topic: reference
ms.assetid: 6c2a4833-6427-47f8-9ffb-20b3786cb406
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-imagedriverpackage

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds a driver package that is in the driver store to an existing boot image on the server.

## Syntax

```
wdsutil /add-ImageDriverPackage [/Server:<Servername>] [media:<Imagename>] [mediatype:Boot] [/Architecture:{x86 | ia64 | x64}] [/Filename:<Filename>] {/DriverPackage:<Package Name> | /PackageId:<ID>}
```

### Parameters

| Parameter | Description |
|--|--|
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If a server name is not specified, the local server is used. |
| [media:`<Imagename>`] | Specifies the name of the image to add the driver to. |
| [mediatype:Boot] | Specifies the type of image to add the driver to. Driver packages can only be added to boot images. |
| [/Architecture:`{x86 | ia64 | x64}`] | Specifies the architecture of the boot image. Because it's possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure the correct image is used. |
| [/Filename:`<Filename>`] | Specifies the name of the file. If the image cannot be uniquely identified by name, the file name must be specified. |
| [/DriverPackage:`<Name>` | Specifies the name of the driver package to add to the image. |
| [/PackageId:`<ID>`] | Specifies the Windows Deployment Services ID of the driver package. You must specify this option if the driver package can't be uniquely identified by name. To find the Package ID, select the driver group that the package is in (or the **All Packages** node), right-click the package, and then select **Properties**. The Package ID is listed on the **General** tab. For example:  {DD098D20-1850-4fc8-8E35-EA24A1BEFF5E}. |

## Examples

To add a driver package to a boot image, type either:

```
wdsutil /add-ImageDriverPackagmedia:WinPE Boot Imagemediatype:Boot /Architecture:x86 /DriverPackage:XYZ
```

```
wdsutil /verbose /add-ImageDriverPackagmedia:WinPE Boot Image /Server:MyWDSServemediatype:Boot /Architecture:x64 /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-imagedriverpackages command](wdsutil-add-imagedriverpackages.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
