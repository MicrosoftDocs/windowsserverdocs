---
title: new-CaptureImage
description: Reference article for new-CaptureImage, which creates a new capture image from an existing boot image.
ms.topic: reference
ms.assetid: 2dfd08f0-be59-4715-96e6-c498305873f4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# new-CaptureImage

Creates a new capture image from an existing boot image. Capture images are boot images that start the Windows Deployment Services capture utility instead of starting Setup. When you boot a reference computer (that has been prepared with Sysprep) into a capture image, a wizard creates an install image of the reference computer and saves it as a Windows Image (.wim) file. You can also add the image to media (such as a CD, DVD, or USB drive), and then boot a computer from that media. After you create the install image, you can add the image to the server for PXE boot deployment. For more information, see Creating Images ([https://go.microsoft.com/fwlink/?LinkId=115311](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730907(v=ws.10))).

## Syntax

```
wdsutil [Options] /New-CaptureImage [/Server:<Server name>]
     /Image:<Image name>
     /Architecture:{x86 | ia64 | x64}
     [/Filename:<File name>]
     /DestinationImage
        /FilePath:<File path and name>
        [/Name:<Name>]
        [/Description:<Description>]
        [/Overwrite:{Yes | No | Append}]
        [/UnattendFilePath:<File path>]
```

### Parameters

|        Parameter         |                                                                                                                                                                                                                         Description                                                                                                                                                                                                                          |
|--------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [/Server:\<Server name>] |                                                                                                                                       Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.                                                                                                                                        |
|   /Image:\<Image name>   |                                                                                                                                                                                                         Specifies the name of the source boot image.                                                                                                                                                                                                         |
|   /Architecture: {x86    |                                                                                                                                                                                                                             ia64                                                                                                                                                                                                                             |
| [/Filename: \<Filename>] |                                                                                                                                                                            If the image cannot be uniquely identified by name, you must use this option to specify the file name.                                                                                                                                                                            |
|    /DestinationImage     | Specifies the settings for the destination image. You specify the settings using the following options:</br>-   /FilePath: \<File path and name> Sets the full file path for the new capture image.</br>-   [/Name: \<Name>] - Sets the display name of the image. If no display name is specified, the display name of the source image will be used.</br>-   [/Description: \<Description>] - Sets the description of the image.</br>-   [/Overwrite: {Yes |

## Examples

To create a capture image and name it WinPECapture.wim, type:
```
wdsutil /New-CaptureImage /Image:WinPE boot image /Architecture:x86 /DestinationImage /FilePath:C:\Temp\WinPECapture.wim
```
To create a capture image and apply the specified settings, type:
```
wdsutil /Verbose /Progress /New-CaptureImage /Server:MyWDSServer /Image:WinPE boot image /Architecture:x64 /Filename:boot.wim
/DestinationImage /FilePath:\\Server\Share\WinPECapture.wim /Name:New WinPE image /Description:WinPE image with capture utility /Overwrite:No /UnattendFilePath:\\Server\Share\WDSCapture.inf
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)