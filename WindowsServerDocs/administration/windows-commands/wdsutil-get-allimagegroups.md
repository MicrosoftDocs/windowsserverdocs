---
title: wdsutil get-allimagegroups
description: Reference article for the wdsutil get-allimagegroups command, which retrieves information about all image groups on a server and all images in those image groups.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# wdsutil get-allimagegroups



Retrieves information about all image groups on a server and all images in those image groups.

## Syntax

```
wdsutil [options] /get-allimagegroups [/server:<servername>] [/detailed]
```

### Parameters

| Parameter | Description |
|--|--|
| `[/server:<servername>]` | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used. |
| [/detailed] | Returns the image metadata from each image. If this parameter isn't used, the default behavior is to return only the image name, description, and file name for each image. |

## Examples

To view information about the image groups, type either:

```
wdsutil /get-allimagegroups
```

```
wdsutil /verbose /get-allimagegroups /server:MyWDSServer /detailed
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-imagegroup command](wdsutil-add-imagegroup.md)

- [wdsutil remove-imagegroup command](wdsutil-remove-imagegroup.md)

- [wdsutil set-imagegroup command](wdsutil-set-imagegroup.md)
