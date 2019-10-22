---
title: Using the replace-Image Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68ded3df-e309-420f-9f5d-caeb609385a5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the replace-Image Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

replaces an existing image with a new version of that image.
## Syntax
for boot images:
```
wdsutil [Options] /replace-Imagmedia:<Image name> [/Server:<Server name>]
   mediatype:Boot
     /Architecture:{x86 | ia64 | x64}
     [/Filename:<File name>]
     /replacementImage
       mediaFile:<wim file path>
         [/Name:<Image name>]
         [/Description:<Image description>]
```
for install images:
```
wdsutil [Options] /replace-Imagmedia:<Image name> [/Server:<Server name>]
   mediatype:Install
    mediaGroup:<Image group name>]
     [/Filename:<File name>]
     /replacementImage
       mediaFile:<wim file path>
         [/SourceImage:<Source image name>]
         [/Name:<Image name>]
         [/Description:<Image description>]
```
## Parameters
|Parameter|Description|
|-------|--------|
media:<Image name>|Specifies the name of the image to be replaced.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediatype:{Boot &#124; Install}|Specifies the type of image to be replaced.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image to be replaced. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is replaced.|
|[/Filename:<File name>]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|/replacementImage|Specifies the settings for the replacement image. You set these settings using the following options:<br /><br />-  mediaFile: <file path> - Specifies the name and location (full path) of the new .wim file.<br />-   [/SourceImage: <image name>] - Specifies the image to be used if the .wim file contains multiple images. This option applies only to install images.<br />-   [/Name:<Image name>]   Sets the display name of the image.<br />-   [/Description:<Image description>] - Sets the description of the image.|
## <a name="BKMK_examples"></a>Examples
To replace a boot image, type one of the following:
```
wdsutil /replace-Imagmedia:"WinPE Boot Imagemediatype:Boot /Architecture:x86 /replacementImagmediaFile:"C:\MyFolder\Boot.wim"
wdsutil /verbose /Progress /replace-Imagmedia:"WinPE Boot Image" /Server:MyWDSServemediatype:Boot /Architecture:x64 /Filename:boot.wim 
/replacementImagmediaFile:\\MyServer\Share\Boot.wim /Name:"My WinPE Image" /Description:"WinPE Image with drivers"
```
To replace an install image, type one of the following:
```
wdsutil /replace-Imagmedia:"Windows Vista Homemediatype:Install /replacementImagmediaFile:"C:\MyFolder\Install.wim"
wdsutil /verbose /Progress /replace-Imagmedia:"Windows Vista Pro" /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1 
/Filename:Install.wim /replacementImagmediaFile:\\MyServer\Share \Install.wim /SourceImage:"Windows Vista Ultimate" /Name:"Windows Vista Desktop" /Description:"Windows Vista Ultimate with standard business applications."
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-Image Command](using-the-add-image-command.md)
[Using the copy-Image Command](using-the-copy-image-command.md)
[Using the Export-Image Command](using-the-export-image-command.md)
[Using the get-Image Command](using-the-get-image-command.md)
[Using the replace-Image Command](using-the-replace-image-command.md)
[Subcommand: set-Image](subcommand-set-image.md)
