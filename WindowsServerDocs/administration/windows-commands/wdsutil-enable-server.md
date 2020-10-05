---
title: wdsutil enable-server
description: Reference article for wdsutil enable-server, which enables all services for Windows Deployment Services.
ms.topic: reference
ms.assetid: 939ffbfb-cf3c-4310-9627-6e7e0c0644d6
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil enable-server

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables all services for Windows Deployment Services.

## Syntax
```
wdsutil [Options] /Enable-Server [/Server:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## Examples
To enable the services on the server, run one of the following:
```
wdsutil /Enable-Server
wdsutil /verbose /Enable-Server /Server:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[wdsutil disable-server command](wdsutil-disable-server.md)
[wdsutil get-Server command](wdsutil-get-server.md)
[wdsutil initialize-server command](wdsutil-initialize-server.md)
[wdsutil set-server command](wdsutil-set-server.md)
[wdsutil start-server command](wdsutil-start-server.md)
[wdsutil stop-server command](wdsutil-stop-server.md)
[wdsutil uninitialize-server command](wdsutil-uninitialize-server.md)
