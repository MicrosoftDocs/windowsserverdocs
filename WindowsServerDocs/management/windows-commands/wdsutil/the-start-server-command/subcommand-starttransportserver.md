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
starts all services for a Transport Server.

## Syntax

```
wdsutil [Options] /start-TransportServer [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To start the server, type one of the following:

```
wdsutil /start-TransportServer
wdsutil /verbose /start-TransportServer /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-TransportServer Command](../using-disable-command/using-disabletransportserver-command.md)

[Using the enable-TransportServer Command](../using-enable-command/using-enabletransportserver-command.md)

[Using the get-TransportServer Command](../using-get-command/using-gettransportserver-command.md)

[Subcommand: set-TransportServer](../the-set-command/subcommand-settransportserver.md)

[Subcommand: stop-TransportServer](../the-stop-server-command/subcommand-stoptransportserver.md)


