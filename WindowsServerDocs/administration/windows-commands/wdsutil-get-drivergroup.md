---
title: wdsutil get-drivergroup
description: Reference article for wdsutil get-drivergroup, which displays information about the driver groups on a server.
ms.topic: reference
ms.assetid: 7cfe10c3-a63f-48e7-bef9-f6b474b4ddbe
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-drivergroup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about the driver groups on a server.

## Syntax

```
wdsutil /Get-DriverGroup /DriverGroup:<Group Name> [/Server:<Server name>]
```

### Parameters

|Parameter|Description|
|-------|--------|
|/DriverGroup:\<Group Name\>|Specifies the name of the driver group.|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be the NetBIOS name or the FQDN.  if a server name is not specified, the local server is used.|
|[/Show: {PackageMetaData \| Filters \| All}]|Displays the metadata for all the driver packages in the specified group. **PackageMetaData** displays information about all the filters for the driver group. **Filters** displays the metadata for all driver packages and filters for the group.|

## Examples

To view information about a driver file, type:

```
wdsutil /Get-DriverGroup /DriverGroup:printerdrivers /Show:PackageMetaData
```

```
wdsutil /Get-DriverGroup /DriverGroup:printerdrivers /Server:MyWdsServer /Show:Filters
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil get-alldrivergroups command](wdsutil-get-alldrivergroups.md)
