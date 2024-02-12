---
title: wdsutil get-allimages
description: Reference article for the wdsutil get-allimages command, which retrieves information about all images on a server.
ms.topic: reference
ms.assetid: 19de3720-4315-415a-8dc6-486caa0b2100
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-allimages

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about all images on a server.

## Syntax

```
wdsutil /get-allimages [/server:<servername>] /show:{boot | install | legacyris | all} [/detailed]
```

### Parameters

| Parameter | Description |
|--|--|
| `[/server:<servername>]` | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used. |
| `/show:{boot | install | legacyris | all}` | Where **boot** returns only boot images, **install** returns install images as well as information about the image groups that contain them, **LegacyRis** returns only remote Installation Services (RIS) images, and **All** returns boot image information, install image information (including information about the image groups), and RIS image information. |
| [/detailed] | Indicates that all image metadata from each image should be returned. If this option is not used, the default behavior is to return only the image name, description, and file name. |

## Examples

To view information about the images, type either:

```
wdsutil /get-allimages /show:install
```

```
wdsutil /verbose /get-allimages /server:MyWDSServer /show:all /detailed
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-image command](wdsutil-add-image.md)

- [wdsutil copy-image command](wdsutil-copy-image.md)

- [wdsutil export-image command](wdsutil-export-image.md)

- [wdsutil remove-image command](wdsutil-remove-image.md)

- [wdsutil replace-image command](wdsutil-replace-image.md)

- [wdsutil set-image command](wdsutil-set-image.md)
