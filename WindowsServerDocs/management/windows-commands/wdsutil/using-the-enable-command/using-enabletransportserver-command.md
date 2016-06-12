---
title: Using the enable-TransportServer Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d79dba1-4b57-4a00-8cba-877e6b8618e6
---
# Using the enable-TransportServer Command
Enables all services for the Transport Server.

## Syntax

```
wdsutil [Options] /Enable-TransportServer [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the Transport Server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To enable the services on the server, run one of the following:

```
wdsutil /Enable-TransportServer
wdsutil /verbose /Enable-TransportServer /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-TransportServer Command](../using-disable-command/using-disabletransportserver-command.md)

[Using the get-TransportServer Command](../using-get-command/using-gettransportserver-command.md)

[Subcommand: set-TransportServer](../the-set-command/subcommand-settransportserver.md)

[Subcommand: start-TransportServer](../the-start-server-command/subcommand-starttransportserver.md)

[Subcommand: stop-TransportServer](../the-stop-server-command/subcommand-stoptransportserver.md)


