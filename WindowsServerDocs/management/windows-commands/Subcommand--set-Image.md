---
title: Subcommand: set-Image
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ae03c86-7a13-4e38-9182-32e55fffd504
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Subcommand: set-Image
Changes the attributes of an image.
## Syntax
For boot images:
```
WDSUTIL /Set-Imagmedia:<Image name> [/Server:<Server name>mediaType:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>] [/Name:<Name>] 
[/Description:<Description>] [/Enabled:{Yes | No}]
```
For install images:
```
WDSUTIL /Set-Imagmedia:<Image name> [/Server:<Server name>]
   mediaType:InstallmediaGroup:<Image group name>]
     [/Filename:<File name>]
     [/Name:<Name>]
     [/Description:<Description>]
     [/UserFilter:<SDDL>]
     [/Enabled:{Yes | No}]
     [/UnattendFile:<Unattend file path>]
         [/OverwriteUnattend:{Yes | No}]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediaType:{Boot &#124; Install}|Specifies the type of image.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because you can have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is modified.|
|[/Filename:<File name>]|If the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|[/Name]|Specifies the name of the image.|
|[/Description:<Description>]|Sets the description of the image.|
|[/Enabled:{Yes &#124; No}]|Enables or disables the image.|
|\mediaGroup:<Image group name>]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group will be used. If more than one image group exists on the server, you must use this option to specify the image group.|
|[/UserFilter:<SDDL>]|Sets the user filter on the image. The filter string must be in Security Descriptor Definition Language (SDDL) format. Note that, unlike the **/Security** option for image groups, this option only restricts who can see the image definition, and not the actual image file resources. To restrict access to the file resources, and therefore access to all images within an image group, you will need to set security for the image group itself.|
|[/UnattendFile:<Unattend file path>]|Sets the full path to the unattend file to be associated with the image. For example: **D:\Files\Unattend\Img1Unattend.xml**|
|[/OverwriteUnattend:{Yes &#124; No}]|You can specify **/Overwrite** to overwrite the unattend file if there is already an unattend file associated with the image. Note that the default setting is **No**.|
## <a name="BKMK_examples"></a>Examples
To set values for a boot image, type one of the following:
```
WDSUTIL /Set-Imagmedia:"WinPE boot imagemediaType:Boot /Architecture:x86 /Description:"New description"
WDSUTIL /Verbose /Set-Imagmedia:"WinPE boot image" /Server:MyWDSServemediaType:Boot /Architecture:x86 /Filename:boot.wim 
/Name:"New Name" /Description:"New Description" /Enabled:Yes
```
To set values for an install image, type one of the following:
```
WDSUTIL /Set-Imagmedia:"Windows Vista with OfficemediaType:Install /Description:"New description" 
WDSUTIL /Verbose /Set-Imagmedia:"Windows Vista with Office" /Server:MyWDSServemediaType:InstalmediaGroup:ImageGroup1 
/Filename:install.wim /Name:"New name" /Description:"New description" /UserFilter:"O:BAG:DUD:AI(A;ID;FA;;;SY)(A;ID;FA;;;BA)(A;ID;0x1200a9;;;AU)" /Enabled:Yes /UnattendFile:\\server\share\unattend.xml /OverwriteUnattend:Yes
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Using the add-Image Command](Using-the-add-Image-Command.md)
[Using the copy-Image Command](Using-the-copy-Image-Command.md)
[Using the Export-Image Command](Using-the-Export-Image-Command.md)
[Using the get-Image Command](Using-the-get-Image-Command.md)
[Using the remove-Image Command](Using-the-remove-Image-Command.md)
[Using the replace-Image Command](Using-the-replace-Image-Command.md)
