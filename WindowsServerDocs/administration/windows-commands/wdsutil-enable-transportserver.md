---
title: wdsutil enable-transportserver
description: Reference article for the wdsutil enable-transportserver command, which enables all services for the Transport Server.
ms.topic: reference
ms.assetid: 9d79dba1-4b57-4a00-8cba-877e6b8618e6
ms.author: alalve
author: xelu86
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil enable-transportserver



Enables all services for the Transport Server.

## Syntax

```
wdsutil [options] /Enable-TransportServer [/Server:<Servername>]
```

### Parameters

| Parameter | Description |
|--|--|
| [/Server:`<Servername>`] | Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used. |

## Examples

To enable the services on the server, type either:

```
wdsutil /Enable-TransportServer
```

```
wdsutil /verbose /Enable-TransportServer /Server:MyWDSServer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil disable-transportserver command](wdsutil-disable-transportserver.md)

- [wdsutil get-transportserver command](wdsutil-get-transportserver.md)

- [wdsutil set-transportserver command](wdsutil-set-transportserver.md)

- [wdsutil start-transportserver command](wdsutil-start-transportserver.md)

- [wdsutil stop-transportserver command](wdsutil-stop-transportserver.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
