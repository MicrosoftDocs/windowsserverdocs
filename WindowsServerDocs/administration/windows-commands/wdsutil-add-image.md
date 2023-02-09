---
title: wdsutil add-image
description: Reference article for the wdsutil add-image command, which adds images to a Windows Deployment Services server.
ms.topic: reference
ms.assetid: d5b6f4da-90ba-4b0e-9423-66c8ef5172e2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 06/30/2022
---

# wdsutil add-image

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds images to a Windows Deployment Services server.

## Syntax

For boot images, use the following syntax:

```
wdsutil /Add-Image /ImageFile:<wim file path> [/Server:<Server name> /ImageType:Boot [/SkipVerify] [/Name:<Image name>] [/Description:<Image description>] [/Filename:<New wim file name>]
```

For install images, use the following syntax:

```
wdsutil /Add-Image /ImageFile:<wim filepath> [/Server:<Servername>] /ImageType:Install [/SkipVerify] /ImageGroup:<Image group name>] [/SingleImage:<Single image name>] [/Name:<Name>] [/Description:<Description>] [/Filename:<File name>] [/UnattendFile:<Unattend file path>]
```

### Parameters

| Parameter | Description |
|--|--|
| /ImageFile:`<.wim filepath>` | Specifies the full path and file name of the Windows Image (.wim) file that contains the images to be added. |
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If a server name is not specified, the local server is used. |
| [/ImageType:`{Boot \| Install}`] | Specifies the type of images to be added. |
| [/SkipVerify] | Specifies that integrity verification will not be performed on the source image file before the image is added. |
| [/Name:`<Name>`] | Sets the display name of the image. |
| [/Description:`<Description>`] | Sets the description of the image. |
| [/Filename:`<Filename>`] | Specifies the new file name for the .wim file. This enables you to change the filename of the .wim file when adding the image. If you don't specify a filename, the source image filename is used. In all cases, Windows Deployment Services checks to determine whether the file name is unique in the boot image store of the destination computer. |
| /ImageGroup:`<Imagegroupname>`] | Specifies the name of the image group in which the images are to be added. If more than one image group exists on the server, the image group must be specified. If you don't specify the image group, and an image group doesn't already exist, a new image group is created. Otherwise, the existing image group is used. |
| [/SingleImage:`<Singleimagename>`] [/Name:`<Name>`] [/Description:`<Description>`] | Copies the specified single image out of a .wim file, and sets the image's display name and description. |
| [/UnattendFile:`<Unattendfilepath>`] | Specifies the full path to the unattended installation file to be associated with the images that are being added. If **/SingleImage** isn't specified, the same unattend file is associated with all of the images in the .wim file. |

## Examples

To add a boot image, type:

```
wdsutil /Add-Image /ImageFile:"C:\MyFolder\Boot.wim" /ImageType:Boot
wdsutil /Verbose /Progress /Add-Image /ImageFile:\\MyServer\Share\Boot.wim /Server:MyWDSServer /ImageType:Boot /Name:"My WinPE Image" /Description:"WinPE Image containing the WDS Client" /Filename:WDSBoot.wim
```

To add an install image, type one of the following:

```
wdsutil /Add-Image /ImageFile:"C:\MyFolder\Install.wim" /ImageType:Install
wdsutil /Verbose /Progress /Add-Image /ImageFile:\\MyServer\Share\Install.wim /Server:MyWDSServer /ImageType:Install /ImageGroup:ImageGroup1
/SingleImage:"Windows Pro" /Name:"My WDS Image" /Description:"Windows Pro image with Microsoft Office" /Filename:"Win Pro.wim" /UnattendFile:"\\server\share\unattend.xml"
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil copy-image command](wdsutil-copy-image.md)

- [wdsutil export-image command](wdsutil-export-image.md)

- [wdsutil get-image command](wdsutil-get-image.md)

- [wdsutil remove-image command](wdsutil-remove-image.md)

- [wdsutil replace-image command](wdsutil-replace-image.md)

- [wdsutil set-image command](wdsutil-set-image.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
