---
title: add-ImageGroup
description: Reference topic for add-ImageGroup, which adds an image group to a Windows Deployment Services server. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 6ca88671-51de-4924-b969-88f3dfd84270
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
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
[Using the get-AllImageGroups Command](using-the-get-allimagegroups-command.md)
[Using the get-ImageGroup Command](using-the-get-imagegroup-command.md)
[Using the remove-ImageGroup Command](using-the-remove-imagegroup-command.md)
[Subcommand: set-ImageGroup](subcommand-set-imagegroup.md)
