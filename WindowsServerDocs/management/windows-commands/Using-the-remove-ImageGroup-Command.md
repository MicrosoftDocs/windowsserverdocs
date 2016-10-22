---
title: Using the remove-ImageGroup Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5b2c9813-5df2-4272-8449-26f3bb16f82b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the remove-ImageGroup Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Removes an image group from a server.
## Syntax
```
WDSUTIL [Options] /Remove-ImageGroumediaGroup:<Image group name> [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
mediaGroup:<Image group name>|Specifies the name of the image group to be removed|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To remove the image group, type one of the following:
```
WDSUTIL /Remove-ImageGroumediaGroup:ImageGroup1
WDSUTIL /Verbose /Remove-ImageGroumediaGroup:"My Image Group" /Server:MyWDSServer 
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-ImageGroup Command](Using-the-add-ImageGroup-Command.md)
[Using the get-AllImageGroups Command](Using-the-get-AllImageGroups-Command.md)
[Using the get-ImageGroup Command](Using-the-get-ImageGroup-Command.md)
[Subcommand: set-ImageGroup](Subcommand-set-ImageGroup.md)
