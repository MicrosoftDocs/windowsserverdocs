---
title: get-AllImages
description: Reference article for get-AllImages, which retrieves information about all images on a server.
ms.topic: reference
ms.assetid: 19de3720-4315-415a-8dc6-486caa0b2100
ms.author: lizross
author: eross-msft
manager: mtillman
ms.date: 10/16/2017
---
# get-AllImages

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about all images on a server.

## Syntax
```
wdsutil /Get-AllImages [/Server:<Server name>] /Show:{Boot | Install | LegacyRis | All} [/detailed]
```
### Parameters
|Parameter|Description|
|-------|--------|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
|/Show: {Boot &#124; Install &#124; LegacyRis &#124; All}|-   **Boot** returns only boot images.<br />-   **Install** returns install images as well as information about the image groups that contain them.<br />-   **LegacyRis** returns only remote Installation Services (RIS) images.<br />-   **All** returns boot image information, install image information (including information about the image groups), and RIS image information.|
|[/detailed]|Indicates that all image metadata from each image should be returned. If this option is not used, the default behavior is to return only the image name, description, and file name.|
## Examples
To view information about the images, type one of the following:
```
wdsutil /Get-AllImages /Show:Install
wdsutil /verbose /Get-AllImages /Server:MyWDSServer /Show:All /detailed
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)
[wdsutiladd-Image command](wdsutil-add-image.md)
[wdsutilcopy-Image command](wdsutil-copy-image.md)
[wdsutilExport-Image command](wdsutil-export-image.md)
[wdsutilremove-Image command](wdsutil-remove-image.md)
[wdsutilreplace-Image command](wdsutil-replace-image.md)
[wdsutil  set-Image](wdsutil-set-image.md)
