---
title: new-DiscoverImage
description: Reference article for new-DiscoverImage, which creates a new discover image from an existing boot image.
ms.topic: reference
ms.assetid: ede9fbbb-0bba-4309-8c21-3cc13e1dc3cd
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# new-DiscoverImage

Creates a new discover image from an existing boot image. Discover images are boot images that force the Setup.exe program to start in Windows Deployment Services mode and then discover a Windows Deployment Services server. Typically these images are used to deploy images to computers that are not capable of booting to PXE. For more information, see Creating Images ([https://go.microsoft.com/fwlink/?LinkId=115311](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730907(v=ws.10))).

## Syntax

```
wdsutil [Options] /New-DiscoverImage [/Server:<Server name>]
     /Image:<Image name>
     /Architecture:{x86 | ia64 | x64}
     [/Filename:<File name>]
     /DestinationImage
         /FilePath:<File path and name>
         [/Name:<Name>]
         [/Description:<Description>]
         [/WDSServer:<Server name>]
         [/Overwrite:{Yes | No | Append}]
```

### Parameters

|        Parameter         |                                                                                                                                                                                                                                                                                                                                                                                                                       Description                                                                                                                                                                                                                                                                                                                                                                                                                       |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name>] |                                                                                                                                                                                                                                                                                                                                     Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.                                                                                                                                                                                                                                                                                                                                     |
|   /Image:\<Image name>   |                                                                                                                                                                                                                                                                                                                                                                                                      Specifies the name of the source boot image.                                                                                                                                                                                                                                                                                                                                                                                                       |
|    /Architecture:{x86    |                                                                                                                                                                                                                                                                                                                                                                                                                          ia64                                                                                                                                                                                                                                                                                                                                                                                                                           |
| [/Filename:\<File name>] |                                                                                                                                                                                                                                                                                                                                                                         If the image cannot be uniquely identified by name, you must use this option to specify the file name.                                                                                                                                                                                                                                                                                                                                                                          |
|    /DestinationImage     | Specifies the settings for the destination image. You can specify the settings using the following options:</br>-   /FilePath:< File path and name> - Sets full file path for the new image.</br>-   [/Name:\<Name>] - Sets the display name of the image. If no display name is specified, the display name of the source image will be used.</br>-   [/Description: \<Description>] - Sets the description of the image.</br>-   [/WDSServer: \<Server name>] - Specifies the name of the server that all clients who boot from the specified image should contact to download the install image. By default, all clients who boot this image will discover a valid Windows Deployment Services server. Using this option bypasses the discovery functionality and forces the booted client to contact the specified server.</br>-   [/Overwrite:{Yes |

## Examples

To create a discover image out of boot image, and name it WinPEDiscover.wim, type:
```
wdsutil /New-DiscoverImage /Image:WinPE boot image /Architecture:x86 /DestinationImage /FilePath:C:\Temp\WinPEDiscover.wim
```
To create a discover image out of boot image, and name it WinPEDiscover.wim with the specified settings, type:
```
wdsutil /Verbose /Progress /New-DiscoverImage /Server:MyWDSServer
/Image:WinPE boot image /Architecture:x64 /Filename:boot.wim /DestinationImage /FilePath:\\Server\Share\WinPEDiscover.wim
/Name:New WinPE image /Description:WinPE image for WDS Client discovery /Overwrite:No
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)