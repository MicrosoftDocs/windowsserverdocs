---
title: Using the Initialize-Server Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 68a26ad9-5eb2-4490-b782-b7cd46b8000d
---
# Using the Initialize-Server Command
Configures a Windows deployment Services server for initial use after the server role has been installed. After you run this command, you should use the [Using the add-Image Command](using-add-command/using-addimage-command.md) command to add images to the server.

## Syntax

```
wdsutil /Initialize-Server [/Server:<Server name>] /remInst:<Full path> [/Authorize]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
|\/remInst:"<Full path>"|Specifies the full path and name of the remoteInstall folder. if the specified folder does not already exist, this option will create it when the command is run. You should always enter a local path, even in the case of a remote computer. for example: **D:\\remoteInstall**.|
|\[\/Authorize\]|Authorizes the server in Dynamic Host Control Protocol \(DHCP\). This option is necessary only if DHCP rogue detection is enabled, meaning that the Windows deployment Services PXE server must be authorized in DHCP before client computers can be serviced. Note that DHCP rogue detection is disabled by default.|

## <a name="BKMK_examples"></a>Examples
To initialize the server and set the remoteInstall shared folder to the F: drive, type.

```
wdsutil /Initialize-Server /remInst:"F:\remoteInstall"
```

To initialize the server and set the remoteInstall shared folder to the C: drive, type.

```
wdsutil /verbose /Progress /Initialize-Server /Server:MyWDSServer /remInst:"C:\remoteInstall"
```

#### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[Using the disable-Server Command]()

[Using the enable-Server Command](using-enable-command/using-enableserver-command.md)

[Using the get-Server Command](using-get-command/using-getserver-command.md)

[Subcommand: set-Server](the-set-command/subcommand-setserver.md)

[Subcommand: start-Server](the-start-server-command/subcommand-startserver.md)

[Subcommand: stop-Server](the-stop-server-command/subcommand-stopserver.md)

[The uninitialize-Server Option](the-uninitializeserver-option.md)


