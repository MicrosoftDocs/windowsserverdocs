---
title: Using the get-Server Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bef60db4-d58d-4304-ab4b-be53dd3271c3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the get-Server Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information from the specified Windows Deployment Services server.
## Syntax
```
wdsutil [Options] /Get-Server [/Server:<Server name>] /Show:{Config | Images | All} [/detailed]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|/Show:{Config &#124; Images &#124; All}|Specifies the type of information to return.<br /><br />-   **Config** returns configuration information.<br />-   **Images** returns information about image groups, boot images, and install images.<br />-   **All** returns configuration information and image information.|
|[/detailed]|You can use this option with **/Show:Images** or **/Show:All** to indicate that all image metadata from each image should be returned. If the **/detailed** option is not used, the default behavior is to return the image name, description, and file name.|
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
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the disable-Server Command](using-the-disable-server-command.md)
[Using the enable-Server Command](using-the-enable-server-command.md)
[Using the Initialize-Server Command](using-the-initialize-server-command.md)
[Subcommand: set-Server](subcommand-set-server.md)
[Subcommand: start-Server](subcommand-start-server.md)
[Subcommand: stop-Server](subcommand-stop-server.md)
[The uninitialize-Server Option](the-uninitialize-server-option.md)
