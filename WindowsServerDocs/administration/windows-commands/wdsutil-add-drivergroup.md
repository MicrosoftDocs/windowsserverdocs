---
title: wdsutil add-drivergroup
description: Reference article for the wdsutil add-drivergroup command, which adds a driver group to the server.
ms.topic: reference
ms.assetid: 2a92fe8f-03f9-462a-b99e-f23275259807
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil add-drivergroup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Adds a driver group to the server.

## Syntax

```
wdsutil /add-DriverGroup /DriverGroup:<Groupname>\n\ [/Server:<Servername>] [/Enabled:{Yes | No}] [/Applicability:{Matched | All}] [/Filtertype:<Filtertype> /Policy:{Include | Exclude} /Value:<Value> [/Value:<Value> ...]]
```

### Parameters

| Parameter | Description |
|--|--|
| /DriverGroup:`<Groupname>` | Specifies the name of the new driver group. |
| /Server:`<Servername>` | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If no server name is specified, the local server is used. |
| /Enabled:`{Yes|No}` | Enables or disables the package. |
| /Applicability:`{Matched|All}` | Specifies which packages to install if the filter criteria are met. **Matched** means install only the driver packages that match a client s hardware. **All** means install all the packages to clients regardless of their hardware. |
| /Filtertype:`<Filtertype>` | Specifies the type of the filter to add to the group. You can specify multiple filter types in a single command. Each filter type must be followed by **/Policy** and at least one **/Value**. Valid values include:<ul><li>BiosVendor</li><li>Biosversion</li><li>Chassistype</li><li>Manufacturer</li><li>Uuid</li><li>Osversion</li><li>Osedition</li><li>OsLanguage</li></ul> For information about getting values for all other filter types, see [Driver Group Filters](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759191(v=ws.11)). |
| [/Policy:`{Include|Exclude}`] | Specifies the policy to be set on the filter. If **/Policy** is set to **Include**, client computers that match the filter are allowed to install the drivers in this group. If **/Policy** is set to **Exclude**, then client computers that match the filter are not allowed to install the drivers in this group. |
| [/Value:`<Value>`] | Specifies the client value that corresponds to **/Filtertype**. You can specify multiple values for a single type. For information about acceptable filter type values, see [Driver Group Filters](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759191(v=ws.11)). |

## Examples

To add a driver group, type either:

```
wdsutil /add-DriverGroup /DriverGroup:printerdrivers /Enabled:Yes
```

```
wdsutil /add-DriverGroup /DriverGroup:printerdrivers /Applicability:All /Filtertype:Manufacturer /Policy:Include /Value:Name1 /Filtertype:Chassistype /Policy:Exclude /Value:Tower /Value:MiniTower
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil add-drivergrouppackage command](wdsutil-add-drivergrouppackage.md)

- [wdsutil add-drivergrouppackages command](wdsutil-add-drivergrouppackages.md)

- [wdsutil add-drivergroupfilter command](wdsutil-add-drivergroupfilter.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
