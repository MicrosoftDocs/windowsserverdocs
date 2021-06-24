---
title: wdsutil replace-image
description: Reference article for wdsutil replace-image, which replaces an existing image with a new version of that image.
ms.topic: reference
ms.assetid: 68ded3df-e309-420f-9f5d-caeb609385a5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil replace-image

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Replaces an existing image with a new version of that image.
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
### Parameters
|Parameter|Description|
|-------|--------|
media:<Image name>|Specifies the name of the image to be replaced.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediatype:{Boot &#124; Install}|Specifies the type of image to be replaced.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image to be replaced. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is replaced.|
|[/Filename:<File name>]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|/replacementImage|Specifies the settings for the replacement image. You set these settings using the following options:<p>-  mediaFile: <file path> - Specifies the name and location (full path) of the new .wim file.<br />-   [/SourceImage: <image name>] - Specifies the image to be used if the .wim file contains multiple images. This option applies only to install images.<br />-   [/Name:<Image name>]   Sets the display name of the image.<br />-   [/Description:<Image description>] - Sets the description of the image.|
## Examples
To replace a boot image, type one of the following:
```
wdsutil /replace-Imagmedia:WinPE Boot Imagemediatype:Boot /Architecture:x86 /replacementImagmediaFile:C:\MyFolder\Boot.wim
wdsutil /verbose /Progress /replace-Imagmedia:WinPE Boot Image /Server:MyWDSServemediatype:Boot /Architecture:x64 /Filename:boot.wim
/replacementImagmediaFile:\\MyServer\Share\Boot.wim /Name:My WinPE Image /Description:WinPE Image with drivers
```
To replace an install image, type one of the following:
```
wdsutil /replace-Imagmedia:Windows Vista Homemediatype:Install /replacementImagmediaFile:C:\MyFolder\Install.wim
wdsutil /verbose /Progress /replace-Imagmedia:Windows Vista Pro /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1
/Filename:Install.wim /replacementImagmediaFile:\\MyServer\Share \Install.wim /SourceImage:Windows Vista Ultimate /Name:Windows Vista Desktop /Description:Windows Vista Ultimate with standard business applications.
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-image command](wdsutil-add-image.md)
- [wdsutil copy-image command](wdsutil-copy-image.md)
- [wdsutil export-image command](wdsutil-export-image.md)
- [wdsutil get-image command](wdsutil-get-image.md)
- [wdsutil replace-image command](wdsutil-replace-image.md)
- [wdsutil set-image command](wdsutil-set-image.md)
