---
title: Subcommand start-TransportServer
description: Reference article for Subcommand start-TransportServer, which starts all services for a Transport Server.
ms.topic: reference
ms.assetid: 0e93bc84-5b9e-4f9d-8cf0-1634417da0f6
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# Subcommand: start-TransportServer

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Starts all services for a Transport Server.

## Syntax
```
wdsutil [Options] /start-TransportServer [/Server:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## Examples
To start the server, type one of the following:
```
wdsutil /start-TransportServer
wdsutil /verbose /start-TransportServer /Server:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-TransportServer Command](using-the-disable-transportserver-command.md)
[Using the enable-TransportServer Command](using-the-enable-transportserver-command.md)
[Using the get-TransportServer Command](using-the-get-transportserver-command.md)
[Subcommand: set-TransportServer](subcommand-set-transportserver.md)
[Subcommand: stop-TransportServer](subcommand-stop-transportserver.md)
