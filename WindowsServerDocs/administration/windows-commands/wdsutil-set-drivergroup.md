---
title: Subcommand set-DriverGroup
description: Reference article for Subcommand set-DriverGroup, which sets the properties of an existing driver group on a server.
ms.topic: reference
ms.assetid: e4ba9b1c-8c52-4fd5-969b-f7905611b364
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# Subcommand: set-DriverGroup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the properties of an existing driver group on a server.

## Syntax
```
wdsutil /Set-DriverGroup /DriverGroup:<Group Name> [/Server:<Server Name>] [/Name:<New Group Name>] [/Enabled:{Yes | No}] [/Applicability:{Matched | All}]
```
### Parameters

|Parameter|Description|
|-------|--------|
|/DriverGroup:\<Group Name\>|Specifies the name of the driver group.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|[/Name:\<New Group Name\>]|Specifies the new name for the driver group.|
|[/Enabled:{Yes \| No}|Enables or disables the driver group.|
|[/Applicability:{Matched \| All}]|Specifies which packages to install if the filter criteria is met. **Matched** means install only the driver packages that match a client s hardware. **All** means install all packages to clients regardless of their hardware.|

## Examples
To set the properties for a driver group, type one of the following:
```
wdsutil /Set-DriverGroup /DriverGroup:printerdrivers /Enabled:Yes
```
```
wdsutil /Set-DriverGroup /DriverGroup:printerdrivers /Name:colorprinterdrivers /Applicability:All
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Subcommand: set-DriverGroupFilter](./wdsutil-set-drivergroupfilter.md)
