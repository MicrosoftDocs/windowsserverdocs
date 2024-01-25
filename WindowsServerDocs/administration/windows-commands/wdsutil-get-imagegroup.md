---
title: wdsutil get-imagegroup
description: Reference article for wdsutil get-imagegroup, which retrieves information about an image group and the images in it.
ms.topic: reference
ms.assetid: 0fc25aca-a529-44ee-bc8e-96bc8affb458
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-imagegroup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about an image group and the images within it.

## Syntax

```
wdsutil [Options] /Get-ImageGroup ImageGroup:<Image group name> [/Server:<Server name>] [/detailed]
```

### Parameters

|Parameter|Description|
|-------|--------|
|/ImageGroup:\<Image group name\>|Specifies the name of the image group.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|[/detailed]|Returns the image metadata for each image. If this parameter is not use, the default behavior is to return only the image name, description, and file name.|

## Examples

To view information about an image group, type:

```
wdsutil /Get-ImageGroup ImageGroup:ImageGroup1
```

To view information including metadata, type:

```
wdsutil /verbose /Get-ImageGroup ImageGroup:ImageGroup1 /Server:MyWDSServer /detailed
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-imagegroup command](wdsutil-add-imagegroup.md)
- [wdsutil get-allimagegroups command](wdsutil-get-allimagegroups.md)
- [wdsutil remove-imagegroup command](wdsutil-remove-imagegroup.md)
- [wdsutil set-imagegroup command](wdsutil-set-imagegroup.md)
