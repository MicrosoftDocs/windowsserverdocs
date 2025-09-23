---
title: wdsutil start-transportserver
description: Reference article for Subcommand start-TransportServer, which starts all services for a Transport Server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# wdsutil start-transportserver



Starts all services for a Transport Server.

## Syntax
```
wdsutil [Options] /start-TransportServer [/Server:<Server name>]
```
### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|

## Examples
To start the server, type one of the following:
```
wdsutil /start-TransportServer
wdsutil /verbose /start-TransportServer /Server:MyWDSServer
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-transportserver command](wdsutil-disable-transportserver.md)
- [wdsutil enable-transportserver command](wdsutil-enable-transportserver.md)
- [wdsutil get-transportserver command](wdsutil-get-transportserver.md)
- [wdsutil set-transportserver command](wdsutil-set-transportserver.md)
- [wdsutil stop-transportserver command](wdsutil-stop-transportserver.md)
