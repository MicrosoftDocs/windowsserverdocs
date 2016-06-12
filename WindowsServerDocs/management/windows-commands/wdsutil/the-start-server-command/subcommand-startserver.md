---
title: Subcommand: start-Server
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e4343e2-0a16-4e65-8769-c09adaef5680
---
# Subcommand: start-Server
starts all services for a Windows deployment Services server.

## Syntax

```
wdsutil [Options] /start-Server [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server to be started. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To start the server, type one of the following:

```
wdsutil /start-Server
wdsutil /verbose /start-Server /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-Server Command]()

[Using the enable-Server Command](../using-enable-command/using-enableserver-command.md)

[Using the get-Server Command](../using-get-command/using-getserver-command.md)

[Using the Initialize-Server Command](../using-initializeserver-command.md)

[Subcommand: set-Server](../the-set-command/subcommand-setserver.md)

[Subcommand: stop-Server](../the-stop-server-command/subcommand-stopserver.md)

[The uninitialize-Server Option](../the-uninitializeserver-option.md)


