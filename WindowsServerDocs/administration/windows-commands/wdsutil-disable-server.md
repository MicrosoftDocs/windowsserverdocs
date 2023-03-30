---
title: wdsutil disable-server
description: Reference article for the wdsutil disable-server command, which disables all services for a Windows Deployment Services server.
ms.topic: reference
ms.assetid: b69fcfe0-b744-4794-bc75-2c9218c0ba66
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil disable-server

Disables all services for a Windows Deployment Services server.

## Syntax

```
wdsutil [Options] /Disable-Server [/Server:<Server name>]
```

### Parameters

| Parameter | Description |
|--|--|
| [/Server:`<Servername>`] | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used. |

## Examples

To disable the server, type either:

```
wdsutil /Disable-Server
```

```
wdsutil /Verbose /Disable-Server /Server:MyWDSServer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
