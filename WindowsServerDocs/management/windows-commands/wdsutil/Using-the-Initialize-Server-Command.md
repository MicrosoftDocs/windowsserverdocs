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
Configures a Windows Deployment Services server for initial use after the server role has been installed. After you run this command, you should use the [Using the add-Image Command](using-the-add-command/Using-the-add-Image-Command.md) command to add images to the server.

## Syntax

```
WDSUTIL /Initialize-Server [/Server:<Server name>] /RemInst:<Full path> [/Authorize]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|
|\/RemInst:"<Full path>"|Specifies the full path and name of the RemoteInstall folder. If the specified folder does not already exist, this option will create it when the command is run. You should always enter a local path, even in the case of a remote computer. For example: **D:\\RemoteInstall**.|
|\[\/Authorize\]|Authorizes the server in Dynamic Host Control Protocol \(DHCP\). This option is necessary only if DHCP rogue detection is enabled, meaning that the Windows Deployment Services PXE server must be authorized in DHCP before client computers can be serviced. Note that DHCP rogue detection is disabled by default.|

## <a name="BKMK_examples"></a>Examples
To initialize the server and set the RemoteInstall shared folder to the F: drive, type.

```
WDSUTIL /Initialize-Server /RemInst:"F:\RemoteInstall"
```

To initialize the server and set the RemoteInstall shared folder to the C: drive, type.

```
WDSUTIL /Verbose /Progress /Initialize-Server /Server:MyWDSServer /RemInst:"C:\RemoteInstall"
```

#### Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)

[Using the disable-Server Command]()

[Using the enable-Server Command](using-the-enable-command/Using-the-enable-Server-Command.md)

[Using the get-Server Command](using-the-get-command/Using-the-get-Server-Command.md)

[Subcommand: set-Server](the-set-command/Subcommand--set-Server.md)

[Subcommand: start-Server](the-start-server-command/Subcommand--start-Server.md)

[Subcommand: stop-Server](the-stop-server-command/Subcommand--stop-Server.md)

[The uninitialize-Server Option](The-uninitialize-Server-Option.md)


