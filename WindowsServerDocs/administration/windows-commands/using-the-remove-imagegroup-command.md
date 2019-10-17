---
title: Using the remove-ImageGroup Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5b2c9813-5df2-4272-8449-26f3bb16f82b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the remove-ImageGroup Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes an image group from a server.
## Syntax
```
wdsutil [Options] /remove-ImageGroumediaGroup:<Image group name> [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
mediaGroup:<Image group name>|Specifies the name of the image group to be removed|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To remove the image group, type one of the following:
```
wdsutil /remove-ImageGroumediaGroup:ImageGroup1
wdsutil /verbose /remove-ImageGroumediaGroup:"My Image Group" /Server:MyWDSServer 
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)  
[Using the add-ImageGroup Command](using-the-add-imagegroup-command.md)  
[Using the get-AllImageGroups Command](using-the-get-allimagegroups-command.md)  
[Using the get-ImageGroup Command](using-the-get-imagegroup-command.md)  
[Subcommand: set-ImageGroup](subcommand-set-imagegroup.md)  
