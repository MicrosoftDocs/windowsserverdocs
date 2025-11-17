---
title: wdsutil enable-server
description: Reference article for the wdsutil enable-server command, which enables all services for Windows Deployment Services.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# wdsutil enable-server



Enables all services for Windows Deployment Services.

## Syntax

```
wdsutil [options] /Enable-Server [/Server:<Servername>]
```

### Parameters

| Parameter | Description |
|--|--|
| [/Server:`<Servername>`] | Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used. |

## Examples

To enable the services on the server, type either:

```
wdsutil /Enable-Server
```

```
wdsutil /verbose /Enable-Server /Server:MyWDSServer
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [wdsutil disable-server command](wdsutil-disable-server.md)

- [wdsutil get-Server command](wdsutil-get-server.md)

- [wdsutil initialize-server command](wdsutil-initialize-server.md)

- [wdsutil set-server command](wdsutil-set-server.md)

- [wdsutil start-server command](wdsutil-start-server.md)

- [wdsutil stop-server command](wdsutil-stop-server.md)

- [wdsutil uninitialize-server command](wdsutil-uninitialize-server.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
