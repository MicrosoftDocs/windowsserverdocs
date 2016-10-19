---
title: Subcommand: stop-Server
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 09f411c0-099f-4591-95fd-b77b3fd9118a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Subcommand: stop-Server

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Stops all services on a Windows Deployment Services server.
## Syntax
```
WDSUTIL [Options] /Stop-Server [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To stop the services, type one of the following:
```
WDSUTIL /Stop-Server
WDSUTIL /Verbose /Stop-Server /Server:MyWDSServer
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the disable-Server Command](Using-the-disable-Server-Command.md)
[Using the enable-Server Command](Using-the-enable-Server-Command.md)
[Using the get-Server Command](Using-the-get-Server-Command.md)
[Using the Initialize-Server Command](Using-the-Initialize-Server-Command.md)
[Subcommand: set-Server](Subcommand-set-Server.md)
[Subcommand: start-Server](Subcommand-start-Server.md)
[The uninitialize-Server Option](The-uninitialize-Server-Option.md)
