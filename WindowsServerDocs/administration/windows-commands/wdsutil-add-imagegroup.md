---
title: wdsutil add-imagegroup
description: Reference article for the wdsutil add-imagegroup command, which adds an image group to a Windows Deployment Services server.
ms.topic: reference
ms.assetid: 6ca88671-51de-4924-b969-88f3dfd84270
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-imagegroup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds an image group to a Windows Deployment Services server.

## Syntax

```
wdsutil [Options] /add-ImageGroup imageGroup:<Imagegroupname> [/Server:<Server name>]
```

### Parameters

| Parameter | Description |
|--|--|
| imageGroup:`<Imagegroupname>`] | Specifies the name of the image to be added. |
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If a server name is not specified, the local server is used. |

## Examples

To add an image group, type either:

```
wdsutil /add-ImageGroup imageGroup:ImageGroup2
```

```
wdsutil /verbose /add-Imagegroup imageGroup:My Image Group /Server:MyWDSServer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil get-allimagegroups command](wdsutil-get-allimagegroups.md)

- [wdsutil get-imagegroup command](wdsutil-get-imagegroup.md)

- [wdsutil remove-imagegroup command](wdsutil-remove-imagegroup.md)

- [wdsutil set-imagegroup command](wdsutil-set-imagegroup.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
