---
title: wdsutil stop-transportserver
description: Reference article for stop-TransportServer
ms.topic: reference
ms.assetid: dc1b1eec-6893-445e-81dc-16b3fae287fa
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# wdsutil stop-transportserver

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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
