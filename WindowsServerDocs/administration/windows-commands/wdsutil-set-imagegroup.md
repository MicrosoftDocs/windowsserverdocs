---
title: wdsutil set-imagegroup
description: Reference article for Subcommand set-ImageGroup, which changes the attributes of an image group.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# wdsutil set-imagegroup



Changes the attributes of an image group.

## Syntax
```
wdsutil [Options] /set-imagegroup:<Image group name> [/Server:<Server name>] [/Name:<New image group name>] [/Security:<SDDL>]
```
### Parameters

|Parameter|Description|
|-------|--------|
|/set-imagegroup:\<Image group name\>|Specifies the name of the image group.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If not specified, the local server will be used.|
|[/Name:\<New image group name\>]|Specifies the new name of the image group.|
|[/Security:\<SDDL\>]|Specifies the new Security Descriptor of the image group, in security descriptor definition language (SDDL) format.|

## Examples
To set the name for an image group, type:
```
wdsutil /Set-ImageGroup:ImageGroup1 /Name:New Image Group Name
```
To specify various settings for an image group, type:
```
wdsutil /verbose /Set-ImageGroupGroup:ImageGroup1 /Server:MyWDSServer /Name:New Image Group Name
/Security:O:BAG:S-1-5-21-2176941838-3499754553-4071289181-513 D:AI(A;ID;FA;;;SY)(A;OICIIOID;GA;;;SY)(A;ID;FA;;;BA)(A;OICIIOID;GA;;;BA) (A;ID;0x1200a9;;;AU)(A;OICIIOID;GXGR;;;AU)
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil add-imagegroup command](wdsutil-add-imagegroup.md)
- [wdsutil get-allimagegroups command](wdsutil-get-allimagegroups.md)
- [wdsutil get-imagegroup command](wdsutil-get-imagegroup.md)
- [wdsutil remove-imagegroup command](wdsutil-remove-imagegroup.md)
