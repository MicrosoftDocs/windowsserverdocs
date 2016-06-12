---
title: Using the enable-Server Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 939ffbfb-cf3c-4310-9627-6e7e0c0644d6
---
# Using the enable-Server Command
Enables all services for Windows deployment Services.

## Syntax

```
wdsutil [Options] /Enable-Server [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To enable the services on the server, run one of the following:

```
wdsutil /Enable-Server
wdsutil /verbose /Enable-Server /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-Server Command]()

[Using the get-Server Command](../using-get-command/using-getserver-command.md)

[Using the Initialize-Server Command](../using-initializeserver-command.md)

[Subcommand: set-Server](../the-set-command/subcommand-setserver.md)

[Subcommand: start-Server](../the-start-server-command/subcommand-startserver.md)

[Subcommand: stop-Server](../the-stop-server-command/subcommand-stopserver.md)

[The uninitialize-Server Option](../the-uninitializeserver-option.md)


