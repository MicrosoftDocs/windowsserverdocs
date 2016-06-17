---
title: Using the disable-TransportServer Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a009706b-8e89-486b-8e3d-512cd9f4de74
---
# Using the disable-TransportServer Command
Disables all services for a Transport Server.

## Syntax

```
WDSUTIL [Options] /Disable-TransportServer [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the Transport Server to be disabled. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no Transport Server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To disable the server, type:

```
WDSUTIL /Disable-TransportServer
WDSUTIL /Verbose /Disable-TransportServer /Server:MyWDSServer
```

#### Additional references
[Command-Line Syntax Key](../../Command-Line-Syntax-Key.md)

[Using the enable-TransportServer Command](../using-the-enable-command/Using-the-enable-TransportServer-Command.md)

[Using the get-TransportServer Command](../using-the-get-command/Using-the-get-TransportServer-Command.md)

[Subcommand: set-TransportServer](../the-set-command/Subcommand--set-TransportServer.md)

[Subcommand: start-TransportServer](../the-start-server-command/Subcommand--start-TransportServer.md)

[Subcommand: stop-TransportServer](../the-stop-server-command/Subcommand--stop-TransportServer.md)


