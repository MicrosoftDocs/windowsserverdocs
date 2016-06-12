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
wdsutil [Options] /Disable-TransportServer [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the Transport Server to be disabled. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no Transport Server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To disable the server, type:

```
wdsutil /Disable-TransportServer
wdsutil /verbose /Disable-TransportServer /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the enable-TransportServer Command](../using-enable-command/using-enabletransportserver-command.md)

[Using the get-TransportServer Command](../using-get-command/using-gettransportserver-command.md)

[Subcommand: set-TransportServer](../the-set-command/subcommand-settransportserver.md)

[Subcommand: start-TransportServer](../the-start-server-command/subcommand-starttransportserver.md)

[Subcommand: stop-TransportServer](../the-stop-server-command/subcommand-stoptransportserver.md)


