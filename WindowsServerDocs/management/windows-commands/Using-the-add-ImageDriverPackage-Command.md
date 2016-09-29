---
title: Using the add-ImageDriverPackage Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c2a4833-6427-47f8-9ffb-20b3786cb406
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the add-ImageDriverPackage Command
Adds a driver package that is in the driver store to an existing boot image on the server. The image version must be Windows 7 or Windows Server 2008 R2 or later.
## Syntax
```
WDSUTIL /Add-ImageDriverPackage [/Server:<Server name>media:<Image namemediaType:Boot /Architecture:{x86 | ia64 | x64} 
```
```
[/Filename:<File name>] {/DriverPackage:<Package Name> | /PackageId:<ID>}
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.|
media:<Image name>|Specifies the name of the image to add the driver to.|
mediaType:Boot|Specifies the type of image to add the driver to. Driver packages can only be added to boot images.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image. Because it is possible to have the same image name for boot images in different architectures, you should specify the architecture to ensure the correct image is used.|
|/Filename:<File name>]|Specifies the name of the file. If the image cannot be uniquely identified by name, the file name must be specified.|
|[/DriverPackage:<Name>|Specifies the name of the driver package to add to the image.|
|[/PackageId:<ID>]|Specifies the Windows Deployment Services ID of the driver package. You must specify this option if the driver package cannot be uniquely identified by name. To find the Package ID, click the driver group that the package is in (or the **All Packages** node), right-click the package, and then click **Properties**. The Package ID is listed on the **General** tab. For example:  {DD098D20-1850-4FC8-8E35-EA24A1BEFF5E}.|
## <a name="BKMK_examples"></a>Examples
To add a driver package to a boot image, type one of the following:
```
WDSUTIL /Add-ImageDriverPackagmedia:"WinPE Boot ImagemediaType:Boot /Architecture:x86 /DriverPackage:XYZ
```
```
WDSUTIL /verbose /Add-ImageDriverPackagmedia:"WinPE Boot Image" /Server:MyWDSServemediaType:Boot /Architecture:x64 /PackageId:{4D36E972-E325-11CE-BFC1-08002BE10318}
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-ImageDriverPackages Command](Using-the-add-ImageDriverPackages-Command.md)
