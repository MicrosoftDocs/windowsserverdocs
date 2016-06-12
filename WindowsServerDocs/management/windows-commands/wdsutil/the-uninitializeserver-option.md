---
title: The uninitialize-Server Option
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 015efb04-fe84-469f-bd81-49d0046296b2
---
# The uninitialize-Server Option
reverts changes made to the server during the initial server configuration. This includes changes made by either the **\/initialize\-server** option or the Windows deployment Services mmc snap\-in. Note that this command resets the server to an unconfigured state. This command does not modify the contents of the remoteInstall shared folder. Rather, it resets the server's state so that you can reinitialize the server.

## Syntax

```
wdsutil [Options] /Uninitialize-Server [/Server:<Server name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|

## <a name="BKMK_examples"></a>Examples
To reinitialize the server, type one of the following:

```
wdsutil /Uninitialize-Server
wdsutil /verbose /Uninitialize-Server /Server:MyWDSServer
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[Using the disable-Server Command]()

[Using the enable-Server Command](using-enable-command/using-enableserver-command.md)

[Using the get-Server Command](using-get-command/using-getserver-command.md)

[Using the Initialize-Server Command](using-initializeserver-command.md)

[Subcommand: set-Server](the-set-command/subcommand-setserver.md)

[Subcommand: start-Server](the-start-server-command/subcommand-startserver.md)

[Subcommand: stop-Server](the-stop-server-command/subcommand-stopserver.md)


