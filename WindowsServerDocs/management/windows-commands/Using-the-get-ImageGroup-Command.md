---
title: Using the get-ImageGroup Command
description: "Windows Commands topic for **** -- "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0fc25aca-a529-44ee-bc8e-96bc8affb458
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the get-ImageGroup Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Retrieves information about an image group and the images within it.
## Syntax
```
WDSUTIL [Options] /Get-ImageGroumediaGroup:<Image group name> [/Server:<Server name>] [/Detailed]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
mediaGroup:<Image group name>|Specifies the name of the image group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|[/Detailed]|Returns the image metadata for each image. If this parameter is not use, the default behavior is to return only the image name, description, and file name.|
## <a name="BKMK_examples"></a>Examples
To view information about an image group, type:
```
WDSUTIL /Get-ImageGroumediaGroup:ImageGroup1
```
To view information including metadata, type:
```
WDSUTIL /Verbose /Get-ImageGroumediaGroup:ImageGroup1 /Server:MyWDSServer /Detailed
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-ImageGroup Command](Using-the-add-ImageGroup-Command.md)
[Using the get-AllImageGroups Command](Using-the-get-AllImageGroups-Command.md)
[Using the remove-ImageGroup Command](Using-the-remove-ImageGroup-Command.md)
[Subcommand: set-ImageGroup](Subcommand--set-ImageGroup.md)
