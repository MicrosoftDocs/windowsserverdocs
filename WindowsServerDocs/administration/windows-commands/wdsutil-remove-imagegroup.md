---
title: wdsutil remove-imagegroup
description: Reference article for wdsutil remove-imagegroup, which removes an image group from a server.
ms.topic: reference
ms.assetid: 5b2c9813-5df2-4272-8449-26f3bb16f82b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil remove-imagegroup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Removes an image group from a server.

## Syntax
```
wdsutil [Options] /remove-ImageGroup Group:<Image group name> [/Server:<Server name>]
```
### Parameters

|Parameter|Description|
|-------|--------|
|imagegroup:\<Image group name\>|Specifies the name of the image group to be removed|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|

## Examples
To remove the image group, type one of the following:
```
wdsutil /remove-ImageGroumediaGroup:ImageGroup1
wdsutil /verbose /remove-ImageGroumediaGroup:My Image Group /Server:MyWDSServer
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-imagegroup command](wdsutil-add-imagegroup.md)
- [wdsutil get-allimagegroups command](wdsutil-get-allimagegroups.md)
- [wdsutil get-imagegroup command](wdsutil-get-imagegroup.md)
- [wdsutil set-imagegroup command](wdsutil-set-imagegroup.md)
