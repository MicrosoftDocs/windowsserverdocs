---
title: Subcommand: start-TransportServer
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e93bc84-5b9e-4f9d-8cf0-1634417da0f6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Subcommand: start-TransportServer

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Starts all services for a Transport Server.
## Syntax
```
WDSUTIL [Options] /Start-TransportServer [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To start the server, type one of the following:
```
WDSUTIL /Start-TransportServer
WDSUTIL /Verbose /Start-TransportServer /Server:MyWDSServer
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the disable-TransportServer Command](Using-the-disable-TransportServer-Command.md)
[Using the enable-TransportServer Command](Using-the-enable-TransportServer-Command.md)
[Using the get-TransportServer Command](Using-the-get-TransportServer-Command.md)
[Subcommand: set-TransportServer](Subcommand-set-TransportServer.md)
[Subcommand: stop-TransportServer](Subcommand-stop-TransportServer.md)
