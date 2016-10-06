---
title: Using the disable-TransportServer Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a009706b-8e89-486b-8e3d-512cd9f4de74
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the disable-TransportServer Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Disables all services for a Transport Server.
## Syntax
```
WDSUTIL [Options] /Disable-TransportServer [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the Transport Server to be disabled. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no Transport Server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To disable the server, type:
```
WDSUTIL /Disable-TransportServer
WDSUTIL /Verbose /Disable-TransportServer /Server:MyWDSServer
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the enable-TransportServer Command](Using-the-enable-TransportServer-Command.md)
[Using the get-TransportServer Command](Using-the-get-TransportServer-Command.md)
[Subcommand: set-TransportServer](Subcommand--set-TransportServer.md)
[Subcommand: start-TransportServer](Subcommand--start-TransportServer.md)
[Subcommand: stop-TransportServer](Subcommand--stop-TransportServer.md)
