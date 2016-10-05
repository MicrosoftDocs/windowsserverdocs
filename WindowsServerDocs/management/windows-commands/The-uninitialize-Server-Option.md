---
title: The uninitialize-Server Option
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 015efb04-fe84-469f-bd81-49d0046296b2
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# The uninitialize-Server Option
Reverts changes made to the server during the initial server configuration. This includes changes made by either the **/initialize-server** option or the Windows Deployment Services MMC snap-in. Note that this command resets the server to an unconfigured state. This command does not modify the contents of the RemoteInstall shared folder. Rather, it resets the server's state so that you can reinitialize the server.
## Syntax
```
WDSUTIL [Options] /Uninitialize-Server [/Server:<Server name>]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
## <a name="BKMK_examples"></a>Examples
To reinitialize the server, type one of the following:
```
WDSUTIL /Uninitialize-Server
WDSUTIL /Verbose /Uninitialize-Server /Server:MyWDSServer
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the disable-Server Command](Using-the-disable-Server-Command.md)
[Using the enable-Server Command](Using-the-enable-Server-Command.md)
[Using the get-Server Command](Using-the-get-Server-Command.md)
[Using the Initialize-Server Command](Using-the-Initialize-Server-Command.md)
[Subcommand: set-Server](Subcommand--set-Server.md)
[Subcommand: start-Server](Subcommand--start-Server.md)
[Subcommand: stop-Server](Subcommand--stop-Server.md)
