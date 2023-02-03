---
title: wdsutil copy-image
description: Reference article for the wdsutil copy-image command, which copies images that are within the same image group.
ms.topic: reference
ms.assetid: bea41cf4-36e6-4181-afa5-00170ebd4fdc
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil copy-image

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies images that are within the same image group. To copy images between image groups, use the [wdsutil Export-Image command](wdsutil-export-image.md) command and then the [wdsutil add-Image command](wdsutil-add-image.md) command.

## Syntax

```
wdsutil [Options] /copy-Image image:<Image name> [/Server:<Server name>] imagetype:Install imageGroup:<Image group name>] [/Filename:<File name>] /DestinationImage /Name:<Name> /Filename:<File name> [/Description:<Description>]
```

### Parameters

| Parameter | Description |
|--|--|
| image:`<Imagename>` | Specifies the name of the image to be copied. |
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used. |
| imagetype:Install | Specifies the type of image to be copied. This option must be set to **install**. |
| \imageGroup:`<Image groupname>`] | Specifies the image group that contains the image to be copied. If no image group is specified and only one group exists on the server, that image group is used by default. If more than one image group exists on the server, you must specify the image group. |
| [/Filename:`<Filename>`] | Specifies the file name of the image to be copied. If the source image cannot be uniquely identified by name, you must specify the file name. |
| /DestinationImage | Specifies the settings for the destination image. The valid values are:<ul><li>/Name:`<Name>` - Sets the display name of the image to be copied.</li><li>/Filename:`<Filename>` - Sets the name of the destination image file that will contain the image copy.</li><li>[/Description:`<Description>`] - Sets the description of the image copy.</li></ul> |

## Examples

To create a copy of the specified image and name it WindowsVista.wim, type:

```
wdsutil /copy-Image image:Windows Vista with Office imagetype:Install /DestinationImage /Name:copy of Windows Vista with Office / Filename:WindowsVista.wim
```

To create a copy of the specified image, apply the specified settings, and name the copy WindowsVista.wim, type:

```
wdsutil /verbose /Progress /copy-Image image:Windows Vista with Office /Server:MyWDSServe imagetype:Install imageGroup:ImageGroup1
/Filename:install.wim /DestinationImage /Name:copy of Windows Vista with Office /Filename:WindowsVista.wim /Description:This is a copy of the original Windows image with Office installed
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-image command](wdsutil-add-image.md)

- [wdsutil export-image command](wdsutil-export-image.md)

- [wdsutil get-image command](wdsutil-get-image.md)

- [wdsutil remove-image command](wdsutil-remove-image.md)

- [wdsutil replace-image command](wdsutil-replace-image.md)

- [wdsutil set-image command](wdsutil-set-image.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
