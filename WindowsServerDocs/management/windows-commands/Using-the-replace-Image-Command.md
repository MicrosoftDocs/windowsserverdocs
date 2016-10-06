---
title: Using the replace-Image Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68ded3df-e309-420f-9f5d-caeb609385a5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the replace-Image Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Replaces an existing image with a new version of that image.
## Syntax
For boot images:
```
WDSUTIL [Options] /Replace-Imagmedia:<Image name> [/Server:<Server name>]
   mediaType:Boot
     /Architecture:{x86 | ia64 | x64}
     [/Filename:<File name>]
     /ReplacementImage
       mediaFile:<wim file path>
         [/Name:<Image name>]
         [/Description:<Image description>]
```
For install images:
```
WDSUTIL [Options] /Replace-Imagmedia:<Image name> [/Server:<Server name>]
   mediaType:Install
    mediaGroup:<Image group name>]
     [/Filename:<File name>]
     /ReplacementImage
       mediaFile:<wim file path>
         [/SourceImage:<Source image name>]
         [/Name:<Image name>]
         [/Description:<Image description>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image to be replaced.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediaType:{Boot &#124; Install}|Specifies the type of image to be replaced.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image to be replaced. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is replaced.|
|[/Filename:<File name>]|If the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|/ReplacementImage|Specifies the settings for the replacement image. You set these settings using the following options:<br /><br />-  mediaFile: <file path> - Specifies the name and location (full path) of the new .wim file.<br />-   [/SourceImage: <image name>] - Specifies the image to be used if the .wim file contains multiple images. This option applies only to install images.<br />-   [/Name:<Image name>] – Sets the display name of the image.<br />-   [/Description:<Image description>] - Sets the description of the image.|
## <a name="BKMK_examples"></a>Examples
To replace a boot image, type one of the following:
```
WDSUTIL /Replace-Imagmedia:"WinPE Boot ImagemediaType:Boot /Architecture:x86 /ReplacementImagmediaFile:"C:\MyFolder\Boot.wim"
WDSUTIL /Verbose /Progress /Replace-Imagmedia:"WinPE Boot Image" /Server:MyWDSServemediaType:Boot /Architecture:x64 /Filename:boot.wim 
/ReplacementImagmediaFile:\\MyServer\Share\Boot.wim /Name:"My WinPE Image" /Description:"WinPE Image with drivers"
```
To replace an install image, type one of the following:
```
WDSUTIL /Replace-Imagmedia:"Windows Vista HomemediaType:Install /ReplacementImagmediaFile:"C:\MyFolder\Install.wim"
WDSUTIL /Verbose /Progress /Replace-Imagmedia:"Windows Vista Pro" /Server:MyWDSServemediaType:InstalmediaGroup:ImageGroup1 
/Filename:Install.wim /ReplacementImagmediaFile:\\MyServer\Share \Install.wim /SourceImage:"Windows Vista Ultimate" /Name:"Windows Vista Desktop" /Description:"Windows Vista Ultimate with standard business applications."
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-Image Command](Using-the-add-Image-Command.md)
[Using the copy-Image Command](Using-the-copy-Image-Command.md)
[Using the Export-Image Command](Using-the-Export-Image-Command.md)
[Using the get-Image Command](Using-the-get-Image-Command.md)
[Using the replace-Image Command](Using-the-replace-Image-Command.md)
[Subcommand: set-Image](Subcommand--set-Image.md)
