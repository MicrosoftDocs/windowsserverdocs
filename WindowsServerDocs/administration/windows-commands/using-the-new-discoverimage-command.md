---
title: Using the new-DiscoverImage Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ede9fbbb-0bba-4309-8c21-3cc13e1dc3cd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Using the new-DiscoverImage Command



Creates a new discover image from an existing boot image. Discover images are boot images that force the Setup.exe program to start in Windows Deployment Services mode and then discover a Windows Deployment Services server. Typically these images are used to deploy images to computers that are not capable of booting to PXE. For more information, see Creating Images ([https://go.microsoft.com/fwlink/?LinkId=115311](https://go.microsoft.com/fwlink/?LinkId=115311)).

## Syntax

```
WDSUTIL [Options] /New-DiscoverImage [/Server:<Server name>]
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

## Parameters

|        Parameter         |                                                                                                                                                                                                                                                                                                                                                                                                                       Description                                                                                                                                                                                                                                                                                                                                                                                                                       |
|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name>] |                                                                                                                                                                                                                                                                                                                                     Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.                                                                                                                                                                                                                                                                                                                                     |
|   /Image:\<Image name>   |                                                                                                                                                                                                                                                                                                                                                                                                      Specifies the name of the source boot image.                                                                                                                                                                                                                                                                                                                                                                                                       |
|    /Architecture:{x86    |                                                                                                                                                                                                                                                                                                                                                                                                                          ia64                                                                                                                                                                                                                                                                                                                                                                                                                           |
| [/Filename:\<File name>] |                                                                                                                                                                                                                                                                                                                                                                         If the image cannot be uniquely identified by name, you must use this option to specify the file name.                                                                                                                                                                                                                                                                                                                                                                          |
|    /DestinationImage     | Specifies the settings for the destination image. You can specify the settings using the following options:</br>-   /FilePath:< File path and name> - Sets full file path for the new image.</br>-   [/Name:\<Name>] - Sets the display name of the image. If no display name is specified, the display name of the source image will be used.</br>-   [/Description: \<Description>] - Sets the description of the image.</br>-   [/WDSServer: \<Server name>] - Specifies the name of the server that all clients who boot from the specified image should contact to download the install image. By default, all clients who boot this image will discover a valid Windows Deployment Services server. Using this option bypasses the discovery functionality and forces the booted client to contact the specified server.</br>-   [/Overwrite:{Yes |

## <a name="BKMK_examples"></a>Examples

To create a discover image out of boot image, and name it WinPEDiscover.wim, type:
```
WDSUTIL /New-DiscoverImage /Image:"WinPE boot image" /Architecture:x86 /DestinationImage /FilePath:"C:\Temp\WinPEDiscover.wim"
```
To create a discover image out of boot image, and name it WinPEDiscover.wim with the specified settings, type:
```
WDSUTIL /Verbose /Progress /New-DiscoverImage /Server:MyWDSServer
/Image:"WinPE boot image" /Architecture:x64 /Filename:boot.wim /DestinationImage /FilePath:"\\Server\Share\WinPEDiscover.wim" 
/Name:"New WinPE image" /Description:"WinPE image for WDS Client discovery" /Overwrite:No
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)