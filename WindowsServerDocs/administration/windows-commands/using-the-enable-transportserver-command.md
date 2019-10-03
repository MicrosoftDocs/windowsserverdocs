---
title: Using the enable-TransportServer Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d79dba1-4b57-4a00-8cba-877e6b8618e6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the enable-TransportServer Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables all services for the Transport Server.
## Syntax
```
wdsutil [Options] /Enable-TransportServer [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To enable the services on the server, run one of the following:
```
wdsutil /Enable-TransportServer
wdsutil /verbose /Enable-TransportServer /Server:MyWDSServer
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-TransportServer Command](using-the-disable-transportserver-command.md)
[Using the get-TransportServer Command](using-the-get-transportserver-command.md)
[Subcommand: set-TransportServer](subcommand-set-transportserver.md)
[Subcommand: start-TransportServer](subcommand-start-transportserver.md)
[Subcommand: stop-TransportServer](subcommand-stop-transportserver.md)
