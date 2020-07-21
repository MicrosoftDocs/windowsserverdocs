---
title: Subcommand start-Server
description: Reference article for Subcommand start-Server, which starts all services for a Windows Deployment Services server.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 1e4343e2-0a16-4e65-8769-c09adaef5680
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Subcommand: start-Server

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Starts all services for a Windows Deployment Services server.

## Syntax
```
wdsutil [Options] /start-Server [/Server:<Server name>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server to be started. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## Examples
To start the server, type one of the following:
```
wdsutil /start-Server
wdsutil /verbose /start-Server /Server:MyWDSServer
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-Server Command](using-the-disable-server-command.md)
[Using the enable-Server Command](using-the-enable-server-command.md)
[Using the get-Server Command](using-the-get-server-command.md)
[Using the Initialize-Server Command](using-the-initialize-server-command.md)
[Subcommand: set-Server](subcommand-set-server.md)
[Subcommand: stop-Server](subcommand-stop-server.md)
[The uninitialize-Server Option](the-uninitialize-server-option.md)
