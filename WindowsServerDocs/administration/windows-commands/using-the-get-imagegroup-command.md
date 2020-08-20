---
title: get-ImageGroup
description: Reference article for get-ImageGroup, which retrieves information about an image group and the images in it.
ms.topic: article
ms.assetid: 0fc25aca-a529-44ee-bc8e-96bc8affb458
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# get-ImageGroup

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about an image group and the images within it.

## Syntax
```
wdsutil [Options] /Get-ImageGroumediaGroup:<Image group name> [/Server:<Server name>] [/detailed]
```
### Parameters
|Parameter|Description|
|-------|--------|
mediaGroup:<Image group name>|Specifies the name of the image group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|[/detailed]|Returns the image metadata for each image. If this parameter is not use, the default behavior is to return only the image name, description, and file name.|
## Examples
To view information about an image group, type:
```
wdsutil /Get-ImageGroumediaGroup:ImageGroup1
```
To view information including metadata, type:
```
wdsutil /verbose /Get-ImageGroumediaGroup:ImageGroup1 /Server:MyWDSServer /detailed
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-ImageGroup Command](using-the-add-imagegroup-command.md)
[Using the get-AllImageGroups Command](using-the-get-allimagegroups-command.md)
[Using the remove-ImageGroup Command](using-the-remove-imagegroup-command.md)
[Subcommand: set-ImageGroup](subcommand-set-imagegroup.md)
