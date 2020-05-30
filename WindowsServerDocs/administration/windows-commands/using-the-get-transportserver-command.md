---
title: get-TransportServer
description: Reference topic for get-TransportServer, which displays information about a specified Transport Server. 
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: de634123-0179-41b2-9c6f-726508130ff5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# get-TransportServer

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about a specified Transport Server.

## Syntax
```
wdsutil [Options] /Get-TransportServer [/Server:<Server name>] /Show:{Config}
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Show:{Config}|Returns configuration information about the specified Transport Server.|
## Examples
To view information about the server, type:
```
wdsutil /Get-TransportServer /Show:Config
```
To view configuration information, type:
```
wdsutil /Get-TransportServer /Server:MyWDSServer /Show:Config
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-TransportServer Command](using-the-disable-transportserver-command.md)
[Using the enable-TransportServer Command](using-the-enable-transportserver-command.md)
[Subcommand: set-TransportServer](subcommand-set-transportserver.md)
[Subcommand: start-TransportServer](subcommand-start-transportserver.md)
[Subcommand: stop-TransportServer](subcommand-stop-transportserver.md)
