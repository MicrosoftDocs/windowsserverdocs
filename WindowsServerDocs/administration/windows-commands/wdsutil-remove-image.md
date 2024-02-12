---
title: wdsutil remove-image
description: Reference article for wdsutil remove-image, which deletes an image from a server.
ms.topic: reference
ms.assetid: ce5e2384-2264-4b22-92af-74eec8c10ae0
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil remove-image

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Deletes an image from a server.

## Syntax
for boot images:
```
wdsutil [Options] /remove-Image:<Image name> [/Server:<Server name> type:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<Filename>]
```
for install images:
```
wdsutil [Options] /remove-image:<Image name> [/Server:<Server name> type:Install ImageGroup:<Image group name>] [/Filename:<Filename>]
```
### Parameters

|Parameter|Description|
|-------|--------|
| /remove-image:\<Image name\>|Specifies the name of the image.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediatype:{Boot \| Install}|Specifies the type of image.|
|/Architecture:{x86 \| ia64 \| x64}|Specifies the architecture of the image. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture value ensures that the correct image will be removed.|
|\ImageGroup:\<Image group name\>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists, you must use this option to specify the image group.|
|[/Filename:\<File name\>]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|

## Examples
To remove a boot image, type:
```
wdsutil /remove-Imagmedia:WinPE Boot Imagemediatype:Boot /Architecture:x86
```
```
wdsutil /verbose /remove-Image:WinPE Boot Image /Server:MyWDSServer type:Boot /Architecture:x64 /Filename:boot.wim
```
To remove an install image, type:
```
wdsutil /remove-Image:Windows Vista with Officemediatype:Install
```
```
wdsutil /verbose /remove-Image:Windows Vista with Office /Server:MyWDSServemediatype:Instal ImageGroup:ImageGroup1 /Filename:install.wim
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-image command](wdsutil-add-image.md)
- [wdsutil copy-image command](wdsutil-copy-image.md)
- [wdsutil export-image command](wdsutil-export-image.md)
- [wdsutil get-image command](wdsutil-get-image.md)
- [wdsutil replace-image command](wdsutil-replace-image.md)
- [wdsutil set-image command](wdsutil-set-image.md)
