---
title: wdsutil stop-server
description: Reference article for Subcommand stop-Server, which stops all services on a Windows Deployment Services server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# wdsutil stop-server



Stops all services on a Windows Deployment Services server.

## Syntax
```
wdsutil [Options] /Stop-Server [/Server:<Server name>]
```
### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|

## Examples
To stop the services, type one of the following:
```
wdsutil /Stop-Server
wdsutil /verbose /Stop-Server /Server:MyWDSServer
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-server command](wdsutil-disable-server.md)
- [wdsutil enable-server command](wdsutil-enable-server.md)
- [wdsutil get-server command](wdsutil-get-server.md)
- [wdsutil initialize-server command](wdsutil-initialize-server.md)
- [wdsutil set-server command](wdsutil-set-server.md)
- [wdsutil start-server command](wdsutil-start-server.md)
- [wdsutil uninitialize-server command](wdsutil-uninitialize-server.md)

