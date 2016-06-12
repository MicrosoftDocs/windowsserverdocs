---
title: Subcommand: stop-TransportServer
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dc1b1eec-6893-445e-81dc-16b3fae287fa
---
# Subcommand: stop-TransportServer
Stops all services on a Transport Server.

## Syntax

```
wdsutil [Options] /Stop-TransportServer [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no Transport Server is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To stop the services, type one of the following:

```
wdsutil /Stop-TransportServer
wdsutil /verbose /Stop-TransportServer /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-TransportServer Command](../using-disable-command/using-disabletransportserver-command.md)

[Using the enable-TransportServer Command](../using-enable-command/using-enabletransportserver-command.md)

[Using the get-TransportServer Command](../using-get-command/using-gettransportserver-command.md)

[Subcommand: set-TransportServer](../the-set-command/subcommand-settransportserver.md)

[Subcommand: start-TransportServer](../the-start-server-command/subcommand-starttransportserver.md)


