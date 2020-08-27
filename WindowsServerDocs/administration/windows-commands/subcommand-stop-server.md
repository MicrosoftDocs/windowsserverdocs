---
title: Subcommand stop-Server
description: Reference article for Subcommand stop-Server, which stops all services on a Windows Deployment Services server.
ms.topic: reference
ms.assetid: 09f411c0-099f-4591-95fd-b77b3fd9118a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Subcommand: stop-Server

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Stops all services on a Windows Deployment Services server.

## Syntax
```
wdsutil [Options] /Stop-Server [/Server:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## Examples
To stop the services, type one of the following:
```
wdsutil /Stop-Server
wdsutil /verbose /Stop-Server /Server:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-Server Command](using-the-disable-server-command.md)
[Using the enable-Server Command](using-the-enable-server-command.md)
[Using the get-Server Command](using-the-get-server-command.md)
[Using the Initialize-Server Command](using-the-initialize-server-command.md)
[Subcommand: set-Server](subcommand-set-server.md)
[Subcommand: start-Server](subcommand-start-server.md)
[The uninitialize-Server Option](the-uninitialize-server-option.md)
