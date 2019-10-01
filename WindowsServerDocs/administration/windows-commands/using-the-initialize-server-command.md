---
title: Using the Initialize-Server Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68a26ad9-5eb2-4490-b782-b7cd46b8000d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the Initialize-Server Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures a Windows Deployment Services server for initial use after the server role has been installed. After you run this command, you should use the [Using the add-Image Command](using-the-add-image-command.md) command to add images to the server.
## Syntax
```
wdsutil /Initialize-Server [/Server:<Server name>] /remInst:<Full path> [/Authorize]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/remInst:"<Full path>"|Specifies the full path and name of the remoteInstall folder. If the specified folder does not already exist, this option will create it when the command is run. You should always enter a local path, even in the case of a remote computer. For example: **D:\remoteInstall**.|
|[/Authorize]|Authorizes the server in Dynamic Host Control Protocol (DHCP). This option is necessary only if DHCP rogue detection is enabled, meaning that the Windows Deployment Services PXE server must be authorized in DHCP before client computers can be serviced. Note that DHCP rogue detection is disabled by default.|
## <a name="BKMK_examples"></a>Examples
To initialize the server and set the remoteInstall shared folder to the F: drive, type.
```
wdsutil /Initialize-Server /remInst:"F:\remoteInstall"
```
To initialize the server and set the remoteInstall shared folder to the C: drive, type.
```
wdsutil /verbose /Progress /Initialize-Server /Server:MyWDSServer /remInst:"C:\remoteInstall"
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-Server Command](using-the-disable-server-command.md)
[Using the enable-Server Command](using-the-enable-server-command.md)
[Using the get-Server Command](using-the-get-server-command.md)
[Subcommand: set-Server](subcommand-set-server.md)
[Subcommand: start-Server](subcommand-start-server.md)
[Subcommand: stop-Server](subcommand-stop-server.md)
[The uninitialize-Server Option](the-uninitialize-server-option.md)
