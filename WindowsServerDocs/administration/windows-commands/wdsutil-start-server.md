---
title: wdsutil start-server
description: Reference article for Subcommand start-Server, which starts all services for a Windows Deployment Services server.
ms.topic: reference
ms.assetid: 1e4343e2-0a16-4e65-8769-c09adaef5680
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# wdsutil start-server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Starts all services for a Windows Deployment Services server.

## Syntax
```
wdsutil [Options] /start-Server [/Server:<Server name>]
```
### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server to be started. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|

## Examples
To start the server, type one of the following:
```
wdsutil /start-Server
wdsutil /verbose /start-Server /Server:MyWDSServer
```
## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-server command](wdsutil-disable-server.md)
- [wdsutil enable-server command](wdsutil-enable-server.md)
- [wdsutil get-server command](wdsutil-get-server.md)
- [wdsutil initialize-server command](wdsutil-initialize-server.md)
- [wdsutil set-server command](wdsutil-set-server.md)
- [wdsutil stop-server command](wdsutil-stop-server.md)
- [wdsutil start-server command](wdsutil-start-server.md)
- [wdsutil uninitialize-server command](wdsutil-uninitialize-server.md)
