---
title: Using the remove-DriverGroupFilter Command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 837bd5d4-c79d-4714-942d-9875bd8e61dcauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the remove-DriverGroupFilter Command
Removes a filter rule from a driver group on a server.
## Syntax
```
WDSUTIL /Remove-DriverGroupFilter /DriverGroup:<Group Name> [/Server:<Server name>] /FilterType:<Filter Type>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|[/FilterType:<FilterType>]|Specifies the type of the filter to remove from the group. <FilterType> can be one of the following:<br /><br />**BiosVendor**<br /><br />**BiosVersion**<br /><br />**ChassisType**<br /><br />**Manufacturer**<br /><br />**Uuid**<br /><br />**OsVersion**<br /><br />**OsEdition**<br /><br />**OsLanguage**|
## <a name="BKMK_examples"></a>Examples
To remove a filter, type one of the following:
```
WDSUTIL /Remove-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer
```
```
WDSUTIL /Remove-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /FilterType:OSLanguage
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
