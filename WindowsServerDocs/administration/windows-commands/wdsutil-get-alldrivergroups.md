---
title: wdsutil get-alldrivergroups
description: Reference article for the wdsutil get-alldrivergroups command, which displays information about all the driver groups on a server.
ms.topic: reference
ms.assetid: f245ba53-f150-41b1-8418-38dcf0410a05
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-alldrivergroups

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about all the driver groups on a server.

## Syntax

```
wdsutil /get-alldrivergroups [/server:<servername>] [/show:{packagemetadata | filters | all}]
```

### Parameters

| Parameter | Description |
|--|--|
| `[/server:<servername>]` | Specifies the name of the server. This can be the NetBIOS name or the FQDN. If a server name is not specified, the local server is used. |
| `/show:{packagemetadata | filters | all}]` | Displays the metadata for all the driver packages in the specified group. **PackageMetaData** displays information about all the filters for the driver group. **Filters** displays the metadata for all driver packages and filters for the group. |

## Examples

To view information about a driver file, type either:

```
wdsutil /get-alldrivergroups /server:MyWdsServer /show:All
```

```
wdsutil /get-alldrivergroups [/show:packagemetadata]
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
-
- [wdsutil get-drivergroup command](wdsutil-get-drivergroup.md)
