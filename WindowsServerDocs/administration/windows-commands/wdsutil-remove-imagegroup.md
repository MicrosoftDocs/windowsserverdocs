---
title: wdsutil remove-imagegroup
description: Reference article for wdsutil remove-imagegroup, which removes an image group from a server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# wdsutil remove-imagegroup



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
