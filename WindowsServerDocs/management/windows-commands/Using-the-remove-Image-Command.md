---
title: Using the remove-Image Command
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce5e2384-2264-4b22-92af-74eec8c10ae0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the remove-Image Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Deletes an image from a server.
## Syntax
For boot images:
```
WDSUTIL [Options] /Remove-Imagmedia:<Image name> [/Server:<Server name>mediaType:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<Filename>]
```
For install images:
```
WDSUTIL [Options] /Remove-Imagmedia:<Image name> [/Server:<Server name>mediaType:InstallmediaGroup:<Image group name>] [/Filename:<Filename>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediaType:{Boot &#124; Install}|Specifies the type of image.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture value ensures that the correct image will be removed.|
|\mediaGroup:<Image group name>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists, you must use this option to specify the image group.|
|[/Filename:<File name>]|If the image cannot be uniquely identified by name, you must use this option to specify the file name.|
## <a name="BKMK_examples"></a>Examples
To remove a boot image, type:
```
WDSUTIL /Remove-Imagmedia:"WinPE Boot ImagemediaType:Boot /Architecture:x86
```
```
WDSUTIL /Verbose /Remove-Imagmedia:"WinPE Boot Image" /Server:MyWDSServemediaType:Boot /Architecture:x64 /Filename:boot.wim
```
To remove an install image, type:
```
WDSUTIL /Remove-Imagmedia:"Windows Vista with OfficemediaType:Install
```
```
WDSUTIL /Verbose /Remove-Imagmedia:"Windows Vista with Office" /Server:MyWDSServemediaType:InstalmediaGroup:ImageGroup1 /Filename:install.wim
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-Image Command](Using-the-add-Image-Command.md)
[Using the copy-Image Command](Using-the-copy-Image-Command.md)
[Using the Export-Image Command](Using-the-Export-Image-Command.md)
[Using the get-Image Command](Using-the-get-Image-Command.md)
[Using the replace-Image Command](Using-the-replace-Image-Command.md)
[Subcommand: set-Image](Subcommand--set-Image.md)
