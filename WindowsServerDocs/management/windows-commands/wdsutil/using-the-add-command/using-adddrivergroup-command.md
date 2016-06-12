---
title: Using the add-DriverGroup command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2a92fe8f-03f9-462a-b99e-f23275259807
---
# Using the add-DriverGroup command
adds a driver group to the server.

for examples of how you can use this command, see [Examples](#BKMK_examples).

## Syntax

```
wdsutil /add-DriverGroup /DriverGroup:<Group Name>\n\
[/Server:<Server name>] [/Enabled:{Yes | No}] [/Applicability:{Matched | All}] [/Filtertype:<Filter type> /Policy:{Include | Exclude} /Value:<Value> [/Value:<Value> ...]]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\/DriverGroup:<Group Name>|Specifies the name of the new driver group.|
|\/Server:<Server name>|Specifies the name of the server. This can be the NetBIOS name or the FQDN. if no server name is specified, the local server is used.|
|\/Enabled:{Yes &#124; No}|Enables or disables the package.|
|\/Applicability:{Matched &#124; All}|Specifies which packages to install if the filter criteria are met. **Matched** means install only the driver packages that match a client’s hardware. **All** means install all the packages to clients regardless of their hardware.|
|\/Filtertype:<Filtertype>|Specifies the type of the filter to add to the group. You can specify multiple filter types in a single command. Each filter type must be followed by **\/Policy** and at least one **\/Value**. <Filtertype> can be one of the following:<br /><br />**BiosVendor**<br /><br />**Biosversion**<br /><br />**Chassistype**<br /><br />**Manufacturer**<br /><br />**Uuid**<br /><br />**Osversion**<br /><br />**Osedition**<br /><br />**OsLanguage**<br /><br />for information about obtaining values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=155158\).|
|\[\/Policy:{Include &#124; Exclude}\]|Specifies the policy to be set on the filter. if **\/Policy** is set to **Include**, client computers that match the filter are allowed to install the drivers in this group. if **\/Policy** is set to **Exclude**, then client computers that match the filter are not allowed to install the drivers in this group.|
|\[\/Value:<Value>\]|Specifies the client value that corresponds to **\/Filtertype**. You can specify multiple values for a single type. See the following list for valid values for certain filter types. The Following attributes are for **Chassistype**. for information about obtaining the values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=155158\).<br /><br />**Other**<br /><br />**UnknownChassis**<br /><br />**Desktop**<br /><br />**LowProfileDesktop**<br /><br />**PizzaBox**<br /><br />**MiniTower**<br /><br />**Tower**<br /><br />**Portable**<br /><br />**Laptop**<br /><br />**Notebook**<br /><br />**Handheld**<br /><br />**DockingStation**<br /><br />**AllInOne**<br /><br />**SubNotebook**<br /><br />**SpaceSaving**<br /><br />**LunchBox**<br /><br />**MainSystemChassis**<br /><br />**ExpansionChassis**<br /><br />**SubChassis**<br /><br />**BusExpansionChassis**<br /><br />**PeripheralChassis**<br /><br />**StorageChassis**<br /><br />**RackmountChassis**<br /><br />**SealedCasecomputer**<br /><br />**MultiSystemChassis**<br /><br />**compactPci**<br /><br />**AdvancedTca**|

## <a name="BKMK_examples"></a>Examples
To add a driver group, type one of the following:

```
wdsutil /add-DriverGroup /DriverGroup:printerdrivers /Enabled:Yes
```

```
wdsutil /add-DriverGroup /DriverGroup:printerdrivers /Applicability:All /Filtertype:Manufacturer /Policy:Include /Value:Name1 /Filtertype:Chassistype /Policy:Exclude /Value:Tower /Value:MiniTower
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-DriverGroupPackage Command](using-adddrivergrouppackage-command.md)

[Using the add-DriverGroupPackages Command](using-adddrivergrouppackages-command.md)

[Using the add-DriverGroupFilter Command]()


