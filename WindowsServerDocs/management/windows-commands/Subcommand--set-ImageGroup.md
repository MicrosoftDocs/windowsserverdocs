---
title: Subcommand: set-ImageGroup
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4d86946a-e261-4d41-8b0c-1ab0ba2e3430
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Subcommand: set-ImageGroup
Changes the attributes of an image group.
## Syntax
```
WDSUTIL [Options] /Set-ImageGroumediaGroup:<Image group name> [/Server:<Server name>] [/Name:<New image group name>] [/Security:<SDDL>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
mediaGroup:<Image group name>|Specifies the name of the image group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If not specified, the local server will be used.|
|[/Name:<New image group name>]|Specifies the new name of the image group.|
|[/Security:<SDDL>]|Specifies the new Security Descriptor of the image group, in security descriptor definition language (SDDL) format.|
## <a name="BKMK_examples"></a>Examples
To set the name for an image group, type:
```
WDSUTIL /Set-ImageGroumediaGroup:ImageGroup1 /Name:"New Image Group Name"
```
To specify various settings for an image group, type:
```
WDSUTIL /Verbose /Set-ImageGroumediaGroup:ImageGroup1 /Server:MyWDSServer /Name:"New Image Group Name" 
/Security:"O:BAG:S-1-5-21-2176941838-3499754553-4071289181-513 D:AI(A;ID;FA;;;SY)(A;OICIIOID;GA;;;SY)(A;ID;FA;;;BA)(A;OICIIOID;GA;;;BA) (A;ID;0x1200a9;;;AU)(A;OICIIOID;GXGR;;;AU)"
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-ImageGroup Command](Using-the-add-ImageGroup-Command.md)
[Using the get-AllImageGroups Command](Using-the-get-AllImageGroups-Command.md)
[Using the get-ImageGroup Command](Using-the-get-ImageGroup-Command.md)
[Using the remove-ImageGroup Command](Using-the-remove-ImageGroup-Command.md)
