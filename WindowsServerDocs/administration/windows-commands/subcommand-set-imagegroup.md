---
title: Subcommand set-ImageGroup
description: Reference article for Subcommand set-ImageGroup, which changes the attributes of an image group.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 4d86946a-e261-4d41-8b0c-1ab0ba2e3430
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Subcommand: set-ImageGroup

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the attributes of an image group.

## Syntax
```
wdsutil [Options] /Set-ImageGroumediaGroup:<Image group name> [/Server:<Server name>] [/Name:<New image group name>] [/Security:<SDDL>]
```
### Parameters
|Parameter|Description|
|-------|--------|
mediaGroup:<Image group name>|Specifies the name of the image group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If not specified, the local server will be used.|
|[/Name:<New image group name>]|Specifies the new name of the image group.|
|[/Security:<SDDL>]|Specifies the new Security Descriptor of the image group, in security descriptor definition language (SDDL) format.|
## Examples
To set the name for an image group, type:
```
wdsutil /Set-ImageGroumediaGroup:ImageGroup1 /Name:New Image Group Name
```
To specify various settings for an image group, type:
```
wdsutil /verbose /Set-ImageGroumediaGroup:ImageGroup1 /Server:MyWDSServer /Name:New Image Group Name
/Security:O:BAG:S-1-5-21-2176941838-3499754553-4071289181-513 D:AI(A;ID;FA;;;SY)(A;OICIIOID;GA;;;SY)(A;ID;FA;;;BA)(A;OICIIOID;GA;;;BA) (A;ID;0x1200a9;;;AU)(A;OICIIOID;GXGR;;;AU)
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-ImageGroup Command](using-the-add-imagegroup-command.md)
[Using the get-AllImageGroups Command](using-the-get-allimagegroups-command.md)
[Using the get-ImageGroup Command](using-the-get-imagegroup-command.md)
[Using the remove-ImageGroup Command](using-the-remove-imagegroup-command.md)
