---
title: Using the get-AllImages Command
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 19de3720-4315-415a-8dc6-486caa0b2100
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Using the get-AllImages Command

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Retrieves information about all images on a server.
## Syntax
```
WDSUTIL /Get-AllImages [/Server:<Server name>] /Show:{Boot | Install | LegacyRis | All} [/Detailed]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Show: {Boot &#124; Install &#124; LegacyRis &#124; All}|-   **Boot** returns only boot images.<br />-   **Install** returns install images as well as information about the image groups that contain them.<br />-   **LegacyRis** returns only Remote Installation Services (RIS) images.<br />-   **All** returns boot image information, install image information (including information about the image groups), and RIS image information.|
|[/Detailed]|Indicates that all image metadata from each image should be returned. If this option is not used, the default behavior is to return only the image name, description, and file name.|
## <a name="BKMK_examples"></a>Examples
To view information about the images, type one of the following:
```
WDSUTIL /Get-AllImages /Show:Install
WDSUTIL /Verbose /Get-AllImages /Server:MyWDSServer /Show:All /Detailed
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-Image Command](Using-the-add-Image-Command.md)
[Using the copy-Image Command](Using-the-copy-Image-Command.md)
[Using the Export-Image Command](Using-the-Export-Image-Command.md)
[Using the remove-Image Command](Using-the-remove-Image-Command.md)
[Using the replace-Image Command](Using-the-replace-Image-Command.md)
[Subcommand: set-Image](Subcommand--set-Image.md)
