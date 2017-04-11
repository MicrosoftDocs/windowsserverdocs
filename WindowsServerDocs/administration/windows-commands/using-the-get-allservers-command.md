---
title: Using the get-AllServers Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe2e3c69-8f2e-457d-af55-d249ebf70f53
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the get-AllServers Command

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about all Windows Deployment Services servers.
> [!NOTE]
> This command may take an extended amount of time to complete if there are many Windows Deployment Services servers in your environment or if the network connection linking the servers is slow.
## Syntax
```
wdsutil [Options] /Get-AllServers /Show:{Config | Images | All} [/detailed] [/forest:{Yes | No}]
```
## Parameters
|Parameter|Description|
|-------|--------|
|/Show:{Config &#124; Images &#124; All}|Specifies what type of information to return.<br /><br />-   **Config** returns server configuration information.<br />-   **Images** returns information about image groups, boot images, and installation images on the server.<br />-   **All** returns server configuration and image information.|
|[/detailed]|When used in conjunction with the **/Show:Images** or **/Show:All**, returns all image metadata from each image. If the **/detailed** option is not specified, the default behavior is to return the image name, description, and file name.|
|[/forest:{Yes &#124; No}]|Specifies whether to return information for the entire forest or the local domain. If a value for this option is not specified, the default behavior is to return the servers in the local domain.|
## <a name="BKMK_examples"></a>Examples
To view information about all servers, type:
```
wdsutil /Get-AllServers /Show:Config
```
To view detailed information about all servers, type:
```
wdsutil /verbose /Get-AllServers /Show:All /detailed /forest:Yes
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
