---
title: Using the add-DriverGroupFilter Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a66c5e68-99ea-4e47-b68d-8109633ae336
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the add-DriverGroupFilter Command

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

adds a filter to a driver group on a server.  
  
## Syntax  
  
```  
wdsutil /add-DriverGroupFilter /DriverGroup:<Group Name> [/Server:<Server name>] /Filtertype:<Filter type> /Policy:{Include | Exclude} /Value:<Value> [/Value:<Value> ...]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|/DriverGroup:<Group Name>|Specifies the name of the driver group.|  
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.|  
|/Filtertype:<Filtertype>|Specifies the type of filter to add to the group. You can specify multiple filter types in a single command. Each filter type must be followed by **/Policy** and include at least one **/Value**. <Filtertype> can be **BiosVendor**, **Biosversion**, **Chassistype**, **Manufacturer**, **Uuid**, **Osversion**, **Osedition**, or **OsLanguage**. For information about obtaining the values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) (http://go.microsoft.com/fwlink/?LinkID=155158).|  
|[/Policy:{Include &#124; Exclude}]|if **/Policy** is set to **Include**, client computers that match the filter are allowed to install the drivers in this group. If **/Policy** is set to **Exclude**, client computers that match the filter are not allowed to install the drivers in this group.|  
|[/Value:<Value>]|Specifies the client value that corresponds to **/Filtertype**. You can specify multiple values for a single type. See the following list for valid values for **Chassistype**. For information about obtaining the values for all other filter types, see [Driver Group Filters](http://go.microsoft.com/fwlink/?LinkID=155158) (http://go.microsoft.com/fwlink/?LinkID=155158).<br /><br />**Other**<br /><br />**UnknownChassis**<br /><br />**Desktop**<br /><br />**LowProfileDesktop**<br /><br />**PizzaBox**<br /><br />**MiniTower**<br /><br />**Tower**<br /><br />**Portable**<br /><br />**Laptop**<br /><br />**Notebook**<br /><br />**Handheld**<br /><br />**DockingStation**<br /><br />**AllInOne**<br /><br />**SubNotebook**<br /><br />**SpaceSaving**<br /><br />**LunchBox**<br /><br />**MainSystemChassis**<br /><br />**ExpansionChassis**<br /><br />**SubChassis**<br /><br />**BusExpansionChassis**<br /><br />**PeripheralChassis**<br /><br />**StorageChassis**<br /><br />**RackmountChassis**<br /><br />**SealedCasecomputer**<br /><br />**MultiSystemChassis**<br /><br />**compactPci**<br /><br />**AdvancedTca**|  
  
## <a name="BKMK_examples"></a>Examples  
To add a filter to a driver group, type one of the following:  
  
```  
wdsutil /add-DriverGroupFilter /DriverGroup:printerdrivers /Filtertype:Manufacturer /Policy:Include /Value:Name1 /Value:Name2  
```  
  
```  
wdsutil /add-DriverGroupFilter /DriverGroup:printerdrivers /Filtertype:Manufacturer /Policy:Include /Value:Name1 /Filtertype:Chassistype /Policy:Exclude /Value:Tower /Value:MiniTower  
```  
  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  
[Using the add-DriverGroup command]()  
  

