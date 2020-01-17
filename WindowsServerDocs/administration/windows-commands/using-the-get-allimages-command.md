---
title: Using the get-AllImages Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 19de3720-4315-415a-8dc6-486caa0b2100
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the get-AllImages Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about all images on a server.
## Syntax
```
wdsutil /Get-AllImages [/Server:<Server name>] /Show:{Boot | Install | LegacyRis | All} [/detailed]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Show: {Boot &#124; Install &#124; LegacyRis &#124; All}|-   **Boot** returns only boot images.<br />-   **Install** returns install images as well as information about the image groups that contain them.<br />-   **LegacyRis** returns only remote Installation Services (RIS) images.<br />-   **All** returns boot image information, install image information (including information about the image groups), and RIS image information.|
|[/detailed]|Indicates that all image metadata from each image should be returned. If this option is not used, the default behavior is to return only the image name, description, and file name.|
## <a name="BKMK_examples"></a>Examples
To view information about the images, type one of the following:
```
wdsutil /Get-AllImages /Show:Install
wdsutil /verbose /Get-AllImages /Server:MyWDSServer /Show:All /detailed
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-Image Command](using-the-add-image-command.md)
[Using the copy-Image Command](using-the-copy-image-command.md)
[Using the Export-Image Command](using-the-export-image-command.md)
[Using the remove-Image Command](using-the-remove-image-command.md)
[Using the replace-Image Command](using-the-replace-image-command.md)
[Subcommand: set-Image](subcommand-set-image.md)
