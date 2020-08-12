---
title: get-AllImageGroups
description: Reference article for get-AllImageGroups, which retrieves information about all image groups on a server and all images in those image groups.
ms.topic: article
ms.assetid: 2ca06533-bcf5-4590-ac8e-263d6c9874f8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# get-AllImageGroups

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about all image groups on a server and all images in those image groups.

## Syntax
```
wdsutil [Options] /Get-AllImageGroups [/Server:<Server name>] [/detailed]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|[/detailed]|Returns the image metadata from each image. If this parameter is not used, the default behavior is to return only the image name, description, and file name for each image.|
## Examples
To view information about the image groups, type one of the following:
```
wdsutil /Get-AllImageGroups
wdsutil /verbose /Get-AllImageGroups /Server:MyWDSServer /detailed
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-ImageGroup Command](using-the-add-imagegroup-command.md)
[Using the get-ImageGroup Command](using-the-get-imagegroup-command.md)
[Using the remove-ImageGroup Command](using-the-remove-imagegroup-command.md)
[Subcommand: set-ImageGroup](subcommand-set-imagegroup.md)
