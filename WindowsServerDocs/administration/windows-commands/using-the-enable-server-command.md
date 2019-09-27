---
title: Using the enable-Server Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 939ffbfb-cf3c-4310-9627-6e7e0c0644d6
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the enable-Server Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables all services for Windows Deployment Services.
## Syntax
```
wdsutil [Options] /Enable-Server [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To enable the services on the server, run one of the following:
```
wdsutil /Enable-Server
wdsutil /verbose /Enable-Server /Server:MyWDSServer
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-Server Command](using-the-disable-server-command.md)
[Using the get-Server Command](using-the-get-server-command.md)
[Using the Initialize-Server Command](using-the-initialize-server-command.md)
[Subcommand: set-Server](subcommand-set-server.md)
[Subcommand: start-Server](subcommand-start-server.md)
[Subcommand: stop-Server](subcommand-stop-server.md)
[The uninitialize-Server Option](the-uninitialize-server-option.md)
