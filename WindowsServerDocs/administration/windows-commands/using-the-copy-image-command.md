---
title: Using the copy-Image Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bea41cf4-36e6-4181-afa5-00170ebd4fdc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Using the copy-Image Command

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies images that are within the same image group. To copy images between image groups, use the [Using the Export-Image Command](using-the-export-image-command.md) command and then the [Using the add-Image Command](using-the-add-image-command.md) command.
for examples of how you can use this command, see [Examples](#BKMK_examples).
## Syntax
```
wdsutil [Options] /copy-Imagmedia:<Image name> [/Server:<Server name>]
   mediatype:Install
    mediaGroup:<Image group name>]
     [/Filename:<File name>]
     /DestinationImage
         /Name:<Name>
         /Filename:<File name>
         [/Description:<Description>]
```
## Parameters
|Parameter|Description|
|-------|--------|
media:<Image name>|Specifies the name of the image to be copied.|
|[/Server:<Server name>]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used.|
mediatype:Install|Specifies the type of image to be copied. This option must be set to **install**.|
|\mediaGroup:<Image group name>]|Specifies the image group that contains the image to be copied. If no image group is specified and only one group exists on the server, that image group will be used by default. If more than one image group exists on the server, you must specify the image group.|
|[/Filename:<Filename>]|Specifies the file name of the image to be copied. If the source image cannot be uniquely identified by name, you must specify the file name.|
|/DestinationImage|Specifies the settings for the destination image, as described in the following table.<br /><br />-   /Name:<Name> - Sets the display name of the image to be copied.<br />-   /Filename:<Filename> - Sets the name of the destination image file that will contain the image copy.<br />-   [/Description: <Description>] - Sets the description of the image copy.|
## <a name="BKMK_examples"></a>Examples
To create a copy of the specified image and name it WindowsVista.wim, type:
```
wdsutil /copy-Imagmedia:"Windows Vista with Officemediatype:Install /DestinationImage /Name:"copy of Windows Vista with Office" /Filename:"WindowsVista.wim"
```
To create a copy of the specified image, apply the specified settings, and name the copy WindowsVista.wim, type:
```
wdsutil /verbose /Progress /copy-Imagmedia:"Windows Vista with Office" /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1 
/Filename:install.wim /DestinationImage /Name:"copy of Windows Vista with Office" /Filename:"WindowsVista.wim" /Description:"This is a copy of the original Windows image with Office installed"
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[Using the add-Image Command](using-the-add-image-command.md)
[Using the Export-Image Command](using-the-export-image-command.md)
[Using the get-Image Command](using-the-get-image-command.md)
[Using the remove-Image Command](using-the-remove-image-command.md)
[Using the replace-Image Command](using-the-replace-image-command.md)
[Subcommand: set-Image](subcommand-set-image.md)
