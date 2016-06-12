---
title: Using the get-Server Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bef60db4-d58d-4304-ab4b-be53dd3271c3
---
# Using the get-Server Command
Retrieves information from the specified Windows deployment Services server.

## Syntax

```
wdsutil [Options] /Get-Server [/Server:<Server name>] /Show:{Config | Images | All} [/detailed]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server is used.|
|\/Show:{Config &#124; Images &#124; All}|Specifies the type of information to return.<br /><br />-   **Config** returns configuration information.<br />-   **Images** returns information about image groups, boot images, and install images.<br />-   **All** returns configuration information and image information.|
|\[\/detailed\]|You can use this option with **\/Show:Images** or **\/Show:All** to indicate that all image metadata from each image should be returned. if the **\/detailed** option is not used, the default behavior is to return the image name, description, and file name.|

## <a name="BKMK_examples"></a>Examples
To view information about the server, type:

```
wdsutil /Get-Server /Show:Config
```

To view detailed information about the server, type:

```
wdsutil /verbose /Get-Server /Server:MyWDSServer /Show:All /detailed
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the disable-Server Command]()

[Using the enable-Server Command](../using-enable-command/using-enableserver-command.md)

[Using the Initialize-Server Command](../using-initializeserver-command.md)

[Subcommand: set-Server](../the-set-command/subcommand-setserver.md)

[Subcommand: start-Server](../the-start-server-command/subcommand-startserver.md)

[Subcommand: stop-Server](../the-stop-server-command/subcommand-stopserver.md)

[The uninitialize-Server Option](../the-uninitializeserver-option.md)


