---
title: wdsutil initialize-server
description: Reference article for wdsutil initialize-server, which configures a Windows Deployment Services server for initial use after the server role has been installed.
ms.topic: reference
ms.assetid: 68a26ad9-5eb2-4490-b782-b7cd46b8000d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil initialize-server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Configures a Windows Deployment Services server for initial use after the server role has been installed. After you run this command, you should use the [wdsutil add-Image command](wdsutil-add-image.md) command to add images to the server.

## Syntax

```
wdsutil /Initialize-Server [/Server:<Server name>] /remInst:<Full path> [/Authorize]
```

### Parameters

|Parameter|Description|
|-------|--------|
|[/Server:\<Server name\>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/remInst:\<Full path\>|Specifies the full path and name of the remoteInstall folder. If the specified folder does not already exist, this option will create it when the command is run. You should always enter a local path, even in the case of a remote computer. For example: **D:\remoteInstall**.|
|[/Authorize]|Authorizes the server in Dynamic Host Control Protocol (DHCP). This option is necessary only if DHCP rogue detection is enabled, meaning that the Windows Deployment Services PXE server must be authorized in DHCP before client computers can be serviced. Note that DHCP rogue detection is disabled by default.|

## Examples

To initialize the server and set the remoteInstall shared folder to the F: drive, type.

```
wdsutil /Initialize-Server /remInst:F:\remoteInstall
```

To initialize the server and set the remoteInstall shared folder to the C: drive, type.

```
wdsutil /verbose /Progress /Initialize-Server /Server:MyWDSServer /remInst:C:\remoteInstall
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil disable-server command](wdsutil-disable-server.md)
- [wdsutil enable-server command](wdsutil-enable-server.md)
- [wdsutil get-server command](wdsutil-get-server.md)
- [wdsutil set-server command](wdsutil-set-server.md)
- [wdsutil start-server command](wdsutil-start-server.md)
- [wdsutil stop-server command](wdsutil-stop-server.md)
- [wdsutil uninitialize-server command](wdsutil-uninitialize-server.md)
