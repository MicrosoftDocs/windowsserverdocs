---
title: disable-Server
description: Reference article for disable-Server, which disables all services for a Windows Deployment Services server.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: b69fcfe0-b744-4794-bc75-2c9218c0ba66
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# disable-Server

Disables all services for a Windows Deployment Services server.

## Syntax

```
WDSUTIL [Options] /Disable-Server [/Server:<Server name>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|[/Server:\<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|

## Examples

To disable the server, run one of the following:
```
WDSUTIL /Disable-Server
WDSUTIL /Verbose /Disable-Server /Server:MyWDSServer
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

