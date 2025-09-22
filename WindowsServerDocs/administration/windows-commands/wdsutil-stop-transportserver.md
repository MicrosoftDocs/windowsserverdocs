---
title: wdsutil stop-transportserver
description: Reference article for stop-TransportServer
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---
# wdsutil stop-transportserver



Stops all services on a Transport Server.
## Syntax
```
wdsutil [Options] /Stop-TransportServer [/Server:<Server name>]
```
### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no Transport Server is specified, the local server will be used.|

## Examples
To stop the services, type one of the following:
```
wdsutil /Stop-TransportServer
wdsutil /verbose /Stop-TransportServer /Server:MyWDSServer
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-transportserver command](wdsutil-disable-transportserver.md)
- [wdsutil enable-transportserver command](wdsutil-enable-transportserver.md)
- [wdsutil get-transportserver command](wdsutil-get-transportserver.md)
- [wdsutil set-transportserver command](wdsutil-set-transportserver.md)
- [wdsutil start-transportserver command](wdsutil-start-transportserver.md)
