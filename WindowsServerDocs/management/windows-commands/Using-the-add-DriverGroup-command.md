---
title: Using the add-DriverGroup command
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a92fe8f-03f9-462a-b99e-f23275259807
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Using the add-DriverGroup command
Adds a driver group to the server.
For examples of how you can use this command, see [Examples](#BKMK_examples).
## Syntax
```
WDSUTIL /Add-DriverGroup /DriverGroup:<Group Name>\n\
[/Server:<Server name>] [/Enabled:{Yes | No}] [/Applicability:{Matched | All}] [/FilterType:<Filter Type> /Policy:{Include | Exclude} /Value:<Value> [/Value:<Value> ...]]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/DriverGroup:<Group Name>|Specifies the name of the new driver group.|
|/Server:<Server name>|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.|
|/Enabled:{Yes &#124; No}|Enables or disables the package.|
|/Applicability:{Matched &#124; All}|Specifies which packages to install if the filter criteria are met. **Matched** means install only the driver packages that match a client’s hardware. **All** means install all the packages to clients regardless of their hardware.|
|/FilterType:<FilterType>|Specifies the type of the filter to add to the group. You can specify multiple filter types in a single command. Each filter type must be followed by **/Policy** and at least one **/Value**. <FilterType> can be one of the following:<br /><br />**BiosVendor**<br /><br />**BiosVersion**<br /><br />**ChassisType**<br /><br />**Manufacturer**<br /><br />**Uuid**<br /><br />**OsVersion**<br /><br />**OsEdition**<br /><br />**OsLanguage**<br /><br />For information about obtaining values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) (http://go.microsoft.com/fwlink/?LinkID=155158).|
|[/Policy:{Include &#124; Exclude}]|Specifies the policy to be set on the filter. If **/Policy** is set to **Include**, client computers that match the filter are allowed to install the drivers in this group. If **/Policy** is set to **Exclude**, then client computers that match the filter are not allowed to install the drivers in this group.|
|[/Value:<Value>]|Specifies the client value that corresponds to **/FilterType**. You can specify multiple values for a single type. See the following list for valid values for certain filter types. The Following attributes are for **ChassisType**. For information about obtaining the values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) (http://go.microsoft.com/fwlink/?LinkID=155158).<br /><br />**Other**<br /><br />**UnknownChassis**<br /><br />**Desktop**<br /><br />**LowProfileDesktop**<br /><br />**PizzaBox**<br /><br />**MiniTower**<br /><br />**Tower**<br /><br />**Portable**<br /><br />**Laptop**<br /><br />**Notebook**<br /><br />**Handheld**<br /><br />**DockingStation**<br /><br />**AllInOne**<br /><br />**SubNotebook**<br /><br />**SpaceSaving**<br /><br />**LunchBox**<br /><br />**MainSystemChassis**<br /><br />**ExpansionChassis**<br /><br />**SubChassis**<br /><br />**BusExpansionChassis**<br /><br />**PeripheralChassis**<br /><br />**StoraeChassis**<br /><br />**RackMountChassis**<br /><br />**SealedCaseComputer**<br /><br />**MultiSystemChassis**<br /><br />**CompactPci**<br /><br />**AdvancedTca**|
## <a name="BKMK_examples"></a>Examples
To add a driver group, type one of the following:
```
WDSUTIL /Add-DriverGroup /DriverGroup:PrinterDrivers /Enabled:Yes
```
```
WDSUTIL /Add-DriverGroup /DriverGroup:PrinterDrivers /Applicability:All /FilterType:Manufacturer /Policy:Include /Value:Name1 /FilterType:ChassisType /Policy:Exclude /Value:Tower /Value:MiniTower
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-DriverGroupPackage Command](Using-the-add-DriverGroupPackage-Command.md)
[Using the add-DriverGroupPackages Command](Using-the-add-DriverGroupPackages-Command.md)
[Using the add-DriverGroupFilter Command](Using-the-add-DriverGroupFilter-Command.md)
