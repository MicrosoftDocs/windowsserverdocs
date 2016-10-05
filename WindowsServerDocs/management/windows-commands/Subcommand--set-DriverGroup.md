---
title: Subcommand: set-DriverGroup
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4ba9b1c-8c52-4fd5-969b-f7905611b364
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Subcommand: set-DriverGroup
Sets the properties of an existing driver group on a server.
## Syntax
```
WDSUTIL /Set-DriverGroup /DriverGroup:<Group Name> [/Server:<Server Name>] [/Name:<New Group Name>] [/Enabled:{Yes | No}] [/Applicability:{Matched | All}]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|[/Name:<New Group Name>]|Specifies the new name for the driver group.|
|[/Enabled:{Yes &#124; No}|Enables or disables the driver group.|
|[/Applicability:{Matched &#124; All}]|Specifies which packages to install if the filter criteria is met. **Matched** means install only the driver packages that match a client’s hardware. **All** means install all packages to clients regardless of their hardware.|
## <a name="BKMK_examples"></a>Examples
To set the properties for a driver group, type one of the following:
```
WDSUTIL /Set-DriverGroup /DriverGroup:PrinterDrivers /Enabled:Yes
```
```
WDSUTIL /Set-DriverGroup /DriverGroup:PrinterDrivers /Name:ColorPrinterDrivers /Applicability:All
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Subcommand: set-DriverGroupFilter](Subcommand--set-DriverGroupFilter.md)
