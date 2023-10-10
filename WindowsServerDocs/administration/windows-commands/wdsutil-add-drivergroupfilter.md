---
title: add-DriverGroupFilter
description: Reference article for the add-DriverGroupFilter command, which adds a filter to a driver group on a server.
ms.topic: reference
ms.assetid: a66c5e68-99ea-4e47-b68d-8109633ae336
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# add-DriverGroupFilter

Adds a filter to a driver group on a server.

## Syntax

```
wdsutil /Add-DriverGroupFilter /DriverGroup:<Group Name> [/Server:<Server name>] /FilterType:<Filter Type> /Policy:{Include | Exclude} /Value:<Value> [/Value:<Value> ...]
```

### Parameters

| Parameter | Description |
|--|--|
| /DriverGroup:`<Groupname>` | Specifies the name of the new driver group. |
| /Server:`<Servername>` | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| /Filtertype:`<Filtertype>` | Specifies the type of the filter to add to the group. You can specify multiple filter types in a single command. Each filter type must be followed by **/Policy** and at least one **/Value**. Valid values include:<ul><li>BiosVendor</li><li>Biosversion</li><li>Chassistype</li><li>Manufacturer</li><li>Uuid</li><li>Osversion</li><li>Osedition</li><li>OsLanguage</li></ul> For information about getting values for all other filter types, see [Driver Group Filters](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759191(v=ws.11)). |
| [/Policy:`{Include|Exclude}`] | Specifies the policy to be set on the filter. If **/Policy** is set to **Include**, client computers that match the filter are allowed to install the drivers in this group. If **/Policy** is set to **Exclude**, then client computers that match the filter are not allowed to install the drivers in this group. |
| [/Value:`<Value>`] | Specifies the client value that corresponds to **/Filtertype**. You can specify multiple values for a single type. For information about acceptable filter type values, see [Driver Group Filters](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759191(v=ws.11)). |

## Examples

To add a filter to a driver group, type either:

```
wdsutil /Add-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /Policy:Include /Value:Name1 /Value:Name2
```

```
wdsutil /Add-DriverGroupFilter /DriverGroup:PrinterDrivers /FilterType:Manufacturer /Policy:Include /Value:Name1 /FilterType:ChassisType /Policy:Exclude /Value:Tower /Value:MiniTower
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-drivergrouppackage command](wdsutil-add-drivergrouppackage.md)

- [wdsutil add-drivergrouppackages command](wdsutil-add-drivergrouppackages.md)

- [wdsutil add-drivergroup command](wdsutil-add-drivergroup.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)