---
title: wdsutil get-image
description: Reference article for wdsutil get-image, which retrieves information about an image.
ms.topic: reference
ms.assetid: 0ecaa999-72ad-4191-adb5-a418de42a001
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-image

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about an image.

## Syntax

For boot images:

```
wdsutil [Options] /Get-Image image:<Image name> [/Server:<Server name> imagetype:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>]
```

For install images:

```
wdsutil [Options] /Get-image image:<Image name> [/Server:<Server name> imagetype:Install imagegroup:<Image group name>] [/Filename:<File name>]
```

### Parameters

|Parameter|Description|
|-------|--------|
| \image:\<Image name\>|Specifies the name of the image.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
| imagetype:{Boot \| Install}|Specifies the type of image.|
|/Architecture:{x86 \| ia64 \| x64}|Specifies the architecture of the image. Because it is possible to have the same image name for boot images in different architectures, specifying the architecture value ensures that the correct image is returned.|
|[/Filename:\<File name\>]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|\imagegroup:\<Image group name\>]|Specifies the image group that contains the image. If no image group is specified and only one image group exists on the server, that group will be used. If more than one image group exists on the server, you must use this parameter to specify the image group.|

## Examples

To retrieve information about a boot image, type one of the following:

```
wdsutil /Get-Image image:WinPE boot imagetype:Boot /Architecture:x86
wdsutil /verbose /Get-Image image:WinPE boot image /Server:MyWDSServer imagetype:Boot /Architecture:x86 /Filename:boot.wim
```

To retrieve information about an install image, type one of the following:

```
wdsutil /Get-Image:Windows Vista with Office imagetype:Install
wdsutil /verbose /Get-Image:Windows Vista with Office /Server:MyWDSServer imagetype:Install imagegroup:ImageGroup1 /Filename:install.wim
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-image command](wdsutil-add-image.md)
- [wdsutil copy-image command](wdsutil-copy-image.md)
- [wdsutil export-image command](wdsutil-export-image.md)
- [wdsutil remove-image command](wdsutil-remove-image.md)
- [wdsutil replace-image command](wdsutil-replace-image.md)
- [wdsutil set-image command](wdsutil-set-image.md)
