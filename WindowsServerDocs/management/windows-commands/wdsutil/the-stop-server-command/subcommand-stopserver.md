---
title: Subcommand: stop-Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 09f411c0-099f-4591-95fd-b77b3fd9118a
---
# Subcommand: stop-Server
Stops all services on a Windows deployment Services server.

## Syntax

```
wdsutil [Options] /Stop-Server [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To stop the services, type one of the following:

```
wdsutil /Stop-Server
wdsutil /verbose /Stop-Server /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-Server Command]()

[Using the enable-Server Command](../using-enable-command/using-enableserver-command.md)

[Using the get-Server Command](../using-get-command/using-getserver-command.md)

[Using the Initialize-Server Command](../using-initializeserver-command.md)

[Subcommand: set-Server](../the-set-command/subcommand-setserver.md)

[Subcommand: start-Server](../the-start-server-command/subcommand-startserver.md)

[The uninitialize-Server Option](../the-uninitializeserver-option.md)


