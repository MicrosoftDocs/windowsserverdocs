---
title: add-DriverGroupFilter
description: Reference article for add-DriverGroupFilter, which adds a filter to a driver group on a server.
ms.topic: reference
ms.assetid: a66c5e68-99ea-4e47-b68d-8109633ae336
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# add-DriverGroupFilter

Adds a filter to a driver group on a server.

## Syntax

```
WDSUTIL /Add-DriverGroupFilter /DriverGroup:<Group Name> [/Server:<Server name>] /FilterType:<Filter Type> /Policy:{Include | Exclude} /Value:<Value> [/Value:<Value> ...]
```

### Parameters

|         Parameter          |                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /DriverGroup:\<Group Name> |                                                                                                                                                                                                                                                                                                                                                                                                                                                              Specifies the name of the driver group.                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|  [/Server:\<Server name>]  |                                                                                                                                                                                                                                                                                                                                                                                                               Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used.                                                                                                                                                                                                                                                                                                                                                                                                               |
| /FilterType:\<FilterType>  |                                                                                                                                                                                                   Specifies the type of filter to add to the group. You can specify multiple filter types in a single command. Each filter type must be followed by **/Policy** and include at least one **/Value**. \<FilterType> can be **BiosVendor**, **BiosVersion**, **ChassisType**, **Manufacturer**, **Uuid**, **OsVersion**, **OsEdition**, or **OsLanguage**. For information about obtaining the values for all other filter types, see [Driver Group Filters](https://go.microsoft.com/fwlink/?LinkID=155158) (<https://go.microsoft.com/fwlink/?LinkID=155158>).                                                                                                                                                                                                    |
|     [/Policy:{Include      |                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Exclude}]                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|     [/Value:\<Value>]      | Specifies the client value that corresponds to **/FilterType**. You can specify multiple values for a single type. See the following list for valid values for **ChassisType**. For information about obtaining the values for all other filter types, see [Driver Group Filters](https://go.microsoft.com/fwlink/?LinkID=155158) (<https://go.microsoft.com/fwlink/?LinkID=155158>).</br>**Other**</br>**UnknownChassis**</br>**Desktop**</br>**LowProfileDesktop**</br>**PizzaBox**</br>**MiniTower**</br>**Tower**</br>**Portable**</br>**Laptop**</br>**Notebook**</br>**Handheld**</br>**DockingStation**</br>**AllInOne**</br>**SubNotebook**</br>**SpaceSaving**</br>**LunchBox**</br>**MainSystemChassis**</br>**ExpansionChassis**</br>**SubChassis**</br>**BusExpansionChassis**</br>**PeripheralChassis**</br>**StorageChassis**</br>**RackMountChassis**</br>**SealedCaseComputer**</br>**MultiSystemChassis**</br>**CompactPci**</br>**AdvancedTca** |

## Examples

To add a filter to a driver group, type one of the following:
```
WDSUTIL /Add-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /Policy:Include /Value:Name1 /Value:Name2
```
```
WDSUTIL /Add-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /Policy:Include /Value:Name1 /FilterType:ChassisType /Policy:Exclude /Value:Tower /Value:MiniTower
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

