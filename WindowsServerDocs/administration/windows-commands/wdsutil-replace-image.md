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

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Replaces an existing image with a new version of that image.
## Syntax
for boot images:
```
WDSUTIL [Options]
        /Replace-Image
        /Image:<Image name>
        [/Server:<Server name>]
        /ImageType:Boot
        /Architecture:{x86 | x64 | arm | arm64}
        [/Filename:<File name>]
        /ReplacementImage
          /ImageFile:<WIM file path>
          [/Name:<Image name>]
          [/Description:<Image description>]

/Architecture:{x86 | x64 | arm | arm64}
        The architecture of the image to be replaced. Since it is
        possible to have the same image name for boot images in
        different architectures, specifying the architecture value
        ensures that the correct image is replaced.

[/Filename:<File name>]
        If the image cannot be uniquely identified by name, the file
        name must be specified.

/ReplacementImage
  /ImageFile:<WIM file path>
        Specifies the full path and file name of the new WIM file.

  [/Name:<Name>]
        Sets the display name of the image.

  [/Description:<Description>]
        Sets the description of the image.
```
for install images:
```
WDSUTIL [Options]
        /Replace-Image
        /Image:<Image name>
        [/Server:<Server name>]
        /ImageType:Install
        [/ImageGroup:<Image group name>]
        [/Filename:<File name>]
        /ReplacementImage
          /ImageFile:<WIM file path>
          [/SourceImage:<Source image name>]
          [/Name:<Image name>]
          [/Description:<Image description>]

[/ImageGroup:<Image group name>]
        The image group containing the image to be replaced. If not
        specified and only one image group exists on the server, that
        image group will be used by default. If more than one image
        group exists on the server, then the image group must be
        specified.

[/Filename:<File name>]
        If the image cannot be uniquely identified by name, the file
        name must be specified.

/ReplacementImage
  /ImageFile:<WIM file path>
        Specifies the full path and file name of the new WIM file.

  [/SourceImage:<image name>]
        Specifies the image to use if the new WIM file contains
        multiple images.

  [/Name:<Name>]
        Sets the display name of the image.

  [/Description:<Description>]
        Sets the description of the image.
```
### Parameters

|Parameter|Description|
|-------|--------|
/Image:\<Image name\>|Specifies the name of the image to be replaced.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
mediatype:{Boot \| Install}|Specifies the type of image to be replaced.|
|/Architecture:{x86 \| ia64 \| x64}|Specifies the architecture of the image to be replaced. Because it's possible to have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is replaced.|
|[/Filename:\<File name\>]|if the image can't be uniquely identified by name, you must use this option to specify the file name.|
|/replacementImage|Specifies the settings for the replacement image. You set these settings using the following options:<p>-  mediaFile: \<file path\> - Specifies the name and location (full path) of the new .wim file.<br />-   [/SourceImage: \<image name\>] - Specifies the image to be used if the .wim file contains multiple images. This option applies only to install images.<br />-   [/Name:\<Image name\>]   Sets the display name of the image.<br />-   [/Description:\<Image description\>] - Sets the description of the image.|

## Examples
To replace a boot image, type one of the following:
```
WDSUTIL /Replace-Image /Image:"WinPE Boot Image" /ImageType:Boot /Architecture:x86 /ReplacementImage /ImageFile:"C:\MyFolder\Boot.wim"

WDSUTIL /Verbose /Progress /Replace-Image /Image:"WinPE Boot Image" /Server:MyWDSServer /ImageType:Boot /Architecture:x64 /Filename:boot.wim /ReplacementImage /ImageFile:\\MyServer\Share\Boot.wim /Name:"My WinPE Image" /Description:"WinPE Image with drivers"
```
To replace an install image, type one of the following:
```
WDSUTIL /Replace-Image /Image:"Windows 10 Home"
/ImageType:Install /ReplacementImage /ImageFile:"C:\MyFolder\Install.wim"

WDSUTIL /Verbose /Progress /Replace-Image /Image:"Windows 10 Pro" /Server:MyWDSServer /ImageType:Install /ImageGroup:ImageGroup1 /Filename:Install.wim /ReplacementImage /ImageFile:\\MyServer\Share \Install.wim /SourceImage:"Windows 10 Pro" /Name:"Windows Vista Desktop" /Description:"Windows 10 Pro with standard business applications."
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-image command](wdsutil-add-image.md)
- [wdsutil copy-image command](wdsutil-copy-image.md)
- [wdsutil export-image command](wdsutil-export-image.md)
- [wdsutil get-image command](wdsutil-get-image.md)
- [wdsutil replace-image command](wdsutil-replace-image.md)
- [wdsutil set-image command](wdsutil-set-image.md)
