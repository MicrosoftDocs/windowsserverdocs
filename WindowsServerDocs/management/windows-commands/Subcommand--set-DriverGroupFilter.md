---
title: Subcommand: set-DriverGroupFilter
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 829ab1f0-4514-421e-9cc0-767b238da69c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Subcommand: set-DriverGroupFilter
Adds or removes an existing driver group filter from a driver group.
## Syntax
```
WDSUTIL /Set-DriverGroupFilter /DriverGroup:<Group Name> [/Server:<Server name>] /FilterType:<Filter Type> [/Policy:{Include | Exclude}] [/AddValue:<Value> [/AddValue:<Value> ...]] [/RemoveValue:<Value> [/RemoveValue:<Value> ...]]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/DriverGroup:<Group Name>|Specifies the name of the driver group.|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used.|
|/FilterType:<FilterType>|Specifies the type of driver group filter to add or remove. You can specify multiple filters in a single command. For each **/FilterType**, you can add or remove multiple values using **/RemoveValue** and **/AddValue**. <FilterType> can be one of the following:<br /><br />**BiosVendor**<br /><br />**BiosVersion**<br /><br />**ChassisType**<br /><br />**Manufacturer**<br /><br />**Uuid**<br /><br />**OsVersion**<br /><br />**OsEdition**<br /><br />**OsLanguage**|
|[/Policy:{Include &#124; Exclude}]|Specifies the new policy to be set on the filter. If **/Policy** is set to **Include**, client computers that match the filter are allowed to install the drivers in this group. If **/Policy** is set to **Exclude**, then client computers that fit the filter are not allowed to install the drivers in this group.|
|[/AddValue:<Value>]|Specifies the new client value to add to the filter. You can specify multiple values for a single filter type. See the following list for valid attribute values for **ChassisType**. For information about obtaining the values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) (http://go.microsoft.com/fwlink/?LinkID=155158).<br /><br />**Other**<br /><br />**UnknownChassis**<br /><br />**Desktop**<br /><br />**LowProfileDesktop**<br /><br />**PizzaBox**<br /><br />**MiniTower**<br /><br />**Tower**<br /><br />**Portable**<br /><br />**Laptop**<br /><br />**Notebook**<br /><br />**Handheld**<br /><br />**DockingStation**<br /><br />**AllInOne**<br /><br />**SubNotebook**<br /><br />**SpaceSaving**<br /><br />**LunchBox**<br /><br />**MainSystemChassis**<br /><br />**ExpansionChassis**<br /><br />**SubChassis**<br /><br />**BusExpansionChassis**<br /><br />**PeripheralChassis**<br /><br />**StorageChassis**<br /><br />**RackMountChassis**<br/><br />**SealedCaseComputer**<br /><br />**MultiSystemChassis**<br /><br />**CompactPci**<br /><br />**AdvancedTca**|
|[/RemoveValue:<Value>]|Specifies the existing client value to remove from the filter as specified with **/AddValue**.|
## <a name="BKMK_examples"></a>Examples
To remove a filter, type one of the following:
```
WDSUTIL /Set-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /Policy:Include /AddValue:Name1 /RemoveValue:Name2
```
```
WDSUTIL /Set-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /Policy:Include /RemoveValue:Name1 /FilterType:ChassisType /Policy:Exclude /AddValue:Tower /AddValue:MiniTower
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
