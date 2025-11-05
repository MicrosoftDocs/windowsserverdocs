---
title: wdsutil get-alldrivergroups
description: Reference article for the wdsutil get-alldrivergroups command, which displays information about all the driver groups on a server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# wdsutil get-alldrivergroups



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
