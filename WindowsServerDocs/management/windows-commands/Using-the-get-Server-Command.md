---
title: Using the get-Server Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bef60db4-d58d-4304-ab4b-be53dd3271c3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the get-Server Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Retrieves information from the specified Windows Deployment Services server.
## Syntax
```
WDSUTIL [Options] /Get-Server [/Server:<Server name>] /Show:{Config | Images | All} [/Detailed]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server is used.|
|/Show:{Config &#124; Images &#124; All}|Specifies the type of information to return.<br /><br />-   **Config** returns configuration information.<br />-   **Images** returns information about image groups, boot images, and install images.<br />-   **All** returns configuration information and image information.|
|[/Detailed]|You can use this option with **/Show:Images** or **/Show:All** to indicate that all image metadata from each image should be returned. If the **/Detailed** option is not used, the default behavior is to return the image name, description, and file name.|
## <a name="BKMK_examples"></a>Examples
To view information about the server, type:
```
WDSUTIL /Get-Server /Show:Config
```
To view detailed information about the server, type:
```
WDSUTIL /Verbose /Get-Server /Server:MyWDSServer /Show:All /Detailed
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the disable-Server Command](Using-the-disable-Server-Command.md)
[Using the enable-Server Command](Using-the-enable-Server-Command.md)
[Using the Initialize-Server Command](Using-the-Initialize-Server-Command.md)
[Subcommand: set-Server](Subcommand-set-Server.md)
[Subcommand: start-Server](Subcommand-start-Server.md)
[Subcommand: stop-Server](Subcommand-stop-Server.md)
[The uninitialize-Server Option](The-uninitialize-Server-Option.md)
