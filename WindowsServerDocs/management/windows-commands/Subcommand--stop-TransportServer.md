---
title: Subcommand: stop-TransportServer
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc1b1eec-6893-445e-81dc-16b3fae287fa
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Subcommand: stop-TransportServer

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Stops all services on a Transport Server.
## Syntax
```
WDSUTIL [Options] /Stop-TransportServer [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no Transport Server is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To stop the services, type one of the following:
```
WDSUTIL /Stop-TransportServer
WDSUTIL /Verbose /Stop-TransportServer /Server:MyWDSServer
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the disable-TransportServer Command](Using-the-disable-TransportServer-Command.md)
[Using the enable-TransportServer Command](Using-the-enable-TransportServer-Command.md)
[Using the get-TransportServer Command](Using-the-get-TransportServer-Command.md)
[Subcommand: set-TransportServer](Subcommand--set-TransportServer.md)
[Subcommand: start-TransportServer](Subcommand--start-TransportServer.md)
