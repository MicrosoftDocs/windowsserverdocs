---
title: Using the add-ImageDriverPackage Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c2a4833-6427-47f8-9ffb-20b3786cb406
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the add-ImageDriverPackage Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

adds a driver package that is in the driver store to an existing boot image on the server. The image version must be Windows 7 or Windows Server 2008 R2 or later.
## Syntax
```
wdsutil /add-ImageDriverPackage [/Server:<Server name>media:<Image namemediatype:Boot /Architecture:{x86 | ia64 | x64} 
```
```
[/Filename:<File name>] {/DriverPackage:<Package Name> | /PackageId:<ID>}
```
## Parameters

|                 Parameter                  |                                                                                                                                                                                                            Description                                                                                                                                                                                                             |
|--------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|           [/Server:<Server name>           |                                                                                                                                               Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.                                                                                                                                                |
|             media:<Image name>             |                                                                                                                                                                                       Specifies the name of the image to add the driver to.                                                                                                                                                                                        |
|               mediatype:Boot               |                                                                                                                                                                Specifies the type of image to add the driver to. Driver packages can only be added to boot images.                                                                                                                                                                 |
| /Architecture:{x86 &#124; ia64 &#124; x64} |                                                                                                       Specifies the architecture of the boot image. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure the correct image is used.                                                                                                        |
|           /Filename:<File name>]           |                                                                                                                                                        Specifies the name of the file. If the image cannot be uniquely identified by name, the file name must be specified.                                                                                                                                                        |
|           [/DriverPackage:<Name>           |                                                                                                                                                                                   Specifies the name of the driver package to add to the image.                                                                                                                                                                                    |
|             [/PackageId:<ID>]              | Specifies the Windows Deployment Services ID of the driver package. You must specify this option if the driver package cannot be uniquely identified by name. To find the Package ID, click the driver group that the package is in (or the **All Packages** node), right-click the package, and then click **Properties**. The Package ID is listed on the **General** tab. For example:  {DD098D20-1850-4fc8-8E35-EA24A1BEFF5E}. |

## <a name="BKMK_examples"></a>Examples
To add a driver package to a boot image, type one of the following:
```
wdsutil /add-ImageDriverPackagmedia:"WinPE Boot Imagemediatype:Boot /Architecture:x86 /DriverPackage:XYZ
```
```
wdsutil /verbose /add-ImageDriverPackagmedia:"WinPE Boot Image" /Server:MyWDSServemediatype:Boot /Architecture:x64 /PackageId:{4D36E972-E325-11CE-Bfc1-08002BE10318}
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-ImageDriverPackages Command](using-the-add-imagedriverpackages-command.md)
