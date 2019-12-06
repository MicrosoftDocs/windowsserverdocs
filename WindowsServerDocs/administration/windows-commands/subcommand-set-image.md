---
title: Subcommand set-Image
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ae03c86-7a13-4e38-9182-32e55fffd504
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Subcommand: set-Image

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

changes the attributes of an image.
## Syntax
for boot images:
```
wdsutil /Set-Imagmedia:<Image name> [/Server:<Server name>mediatype:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>] [/Name:<Name>] 
[/Description:<Description>] [/Enabled:{Yes | No}]
```
for install images:
```
wdsutil /Set-Imagmedia:<Image name> [/Server:<Server name>]
   mediatype:InstallmediaGroup:<Image group name>]
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
|-------|--------|
media:<Image name>|Specifies the name of the image.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediatype:{Boot &#124; Install}|Specifies the type of image.|
|/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because you can have the same image name for different boot images in different architectures, specifying the architecture ensures that the correct image is modified.|
|[/Filename:<File name>]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|
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
wdsutil /Set-Imagmedia:"WinPE boot imagemediatype:Boot /Architecture:x86 /Description:"New description"
wdsutil /verbose /Set-Imagmedia:"WinPE boot image" /Server:MyWDSServemediatype:Boot /Architecture:x86 /Filename:boot.wim 
/Name:"New Name" /Description:"New Description" /Enabled:Yes
```
To set values for an install image, type one of the following:
```
wdsutil /Set-Imagmedia:"Windows Vista with Officemediatype:Install /Description:"New description" 
wdsutil /verbose /Set-Imagmedia:"Windows Vista with Office" /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1 
/Filename:install.wim /Name:"New name" /Description:"New description" /UserFilter:"O:BAG:DUD:AI(A;ID;FA;;;SY)(A;ID;FA;;;BA)(A;ID;0x1200a9;;;AU)" /Enabled:Yes /UnattendFile:\\server\share\unattend.xml /OverwriteUnattend:Yes
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-Image Command](using-the-add-image-command.md)
[Using the copy-Image Command](using-the-copy-image-command.md)
[Using the Export-Image Command](using-the-export-image-command.md)
[Using the get-Image Command](using-the-get-image-command.md)
[Using the remove-Image Command](using-the-remove-image-command.md)
[Using the replace-Image Command](using-the-replace-image-command.md)
