---
title: enable-TransportServer
description: Reference article for enable-TransportServer, which enables all services for the Transport Server.
ms.topic: reference
ms.assetid: 9d79dba1-4b57-4a00-8cba-877e6b8618e6
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# enable-TransportServer

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables all services for the Transport Server.

## Syntax
```
wdsutil [Options] /Enable-TransportServer [/Server:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no name is specified, the local server will be used.|
## Examples
To enable the services on the server, run one of the following:
```
wdsutil /Enable-TransportServer
wdsutil /verbose /Enable-TransportServer /Server:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[wdsutildisable-TransportServer command](wdsutil-disable-transportserver.md)
[wdsutilget-TransportServer command](wdsutil-get-transportserver.md)
[wdsutil  set-TransportServer](wdsutil-set-transportserver.md)
[wdsutil  start-TransportServer](wdsutil-start-transportserver.md)
[wdsutil  stop-TransportServer](wdsutil-stop-transportserver.md)
