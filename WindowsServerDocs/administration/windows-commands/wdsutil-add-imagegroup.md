---
title: add-ImageGroup
description: Reference article for add-ImageGroup, which adds an image group to a Windows Deployment Services server.
ms.topic: reference
ms.assetid: 6ca88671-51de-4924-b969-88f3dfd84270
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# add-ImageGroup

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds an image group to a Windows Deployment Services server.

## Syntax
```
wdsutil [Options] /add-ImageGroumediaGroup:<Image group name> [/Server:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
mediaGroup:<Image group name>|Specifies the name of the image group to be added.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If a server name is not specified, the local server will be used.|
## Examples
To add an image group, type one of the following:
```
wdsutil /add-ImageGroumediaGroup:ImageGroup2
wdsutil /verbose /add-ImageGroumediaGroup:My Image Group /Server:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[wdsutilget-AllImageGroups command](wdsutil-get-allimagegroups.md)
[wdsutilget-ImageGroup command](wdsutil-get-imagegroup.md)
[wdsutilremove-ImageGroup command](wdsutil-remove-imagegroup.md)
[wdsutil  set-ImageGroup](wdsutil-set-imagegroup.md)
