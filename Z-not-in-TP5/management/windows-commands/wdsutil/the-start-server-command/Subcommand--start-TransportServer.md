---
title: Subcommand: start-TransportServer
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e93bc84-5b9e-4f9d-8cf0-1634417da0f6
---
# Subcommand: start-TransportServer
Starts all services for a Transport Server.

## Syntax

```
WDSUTIL [Options] /Start-TransportServer [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To start the server, type one of the following:

```
WDSUTIL /Start-TransportServer
WDSUTIL /Verbose /Start-TransportServer /Server:MyWDSServer
```

#### Additional references
[Command-Line Syntax Key](../../Command-Line-Syntax-Key.md)

[Using the disable-TransportServer Command](../using-the-disable-command/Using-the-disable-TransportServer-Command.md)

[Using the enable-TransportServer Command](../using-the-enable-command/Using-the-enable-TransportServer-Command.md)

[Using the get-TransportServer Command](../using-the-get-command/Using-the-get-TransportServer-Command.md)

[Subcommand: set-TransportServer](../the-set-command/Subcommand--set-TransportServer.md)

[Subcommand: stop-TransportServer](../the-stop-server-command/Subcommand--stop-TransportServer.md)


