---
title: Using the add-Image Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d5b6f4da-90ba-4b0e-9423-66c8ef5172e2
---
# Using the add-Image Command
adds images to a Windows deployment Services server. for examples of how you can use this command, see [Examples](#BKMK_examples).

## Syntax
for boot images, use the following syntax:

```
wdsutil /add-ImagmediaFile:<wim file path> [/Server:<Server name>mediatype:Boot [/Skipverify] [/Name:<Image name>] [/Description:<Image description>] 
[/Filename:<New wim file name>]
```

for install images, use the following syntax:

```
wdsutil /add-ImagmediaFile:<wim file path>
     [/Server:<Server name>]
   mediatype:Install
     [/Skipverify]
    mediaGroup:<Image group name>]
     [/SingleImage:<Single image name>]
         [/Name:<Name>]
         [/Description:<Description>]
     [/Filename:<File name>]
     [/UnattendFile:<Unattend file path>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
mediaFile:<.wim file path>|Specifies the full path and file name of the Windows Image \(.wim\) file that contains the images to be added.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if a server name is not specified, the local server will be used.|
mediatype:{Boot&#124;Install}|Specifies the type of images to be added.|
|\[\/Skipverify\]|Specifies that integrity verification will not be performed on the source image file before the image is added.|
|\[\/Name:<Name>\]|Sets the display name of the image.|
|\[\/Description:<Description>\]|Sets the description of the image.|
|\[\/Filename:<Filename>\]|Specifies the new file name for the .wim file. This enables you to change the file name of the .wim file when adding the image. if no file name is specified, the source image file name will be used. In all cases, Windows deployment Services checks to determine whether the file name is unique in the boot image store of the destination computer.|
|\mediaGroup:<Image group name>\]|Specifies the name of the image group in which the images are to be added. if more than one image group exists on the server, the image group must be specified. if this is not specified and an image group does not already exist, a new image group will be created. Otherwise, the existing image group will be used.|
|\[\/SingleImage:<Single image name>\] \[\/Name:<Name>\] \[\/Description:<Description>\]|Copies the specified single image out of a .wim file, and sets the image's display name and description.|
|\[\/UnattendFile:<Unattend file path>\]|Specifies the full path to the unattended installation file to be associated with the images that are being added. if **\/SingleImage** is not specified, the same unattend file will be associated with all of the images in the .wim file.|

## <a name="BKMK_examples"></a>Examples
To add a boot image, type:

```
wdsutil /add-ImagmediaFile:"C:\MyFolder\Boot.wimmediatype:Boot
wdsutil /verbose /Progress /add-ImagmediaFile:\\MyServer\Share\Boot.wim /Server:MyWDSServemediatype:Boot /Name:"My WinPE Image" 
/Description:"WinPE Image containing the WDS Client" /Filename:WDSBoot.wim
```

To add an install image, type one of the following:

```
wdsutil /add-ImagmediaFile:"C:\MyFolder\Install.wimmediatype:Install
wdsutil /verbose /Progress /add-ImagmediaFile:\\MyServer\Share \Install.wim /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1 
/SingleImage:"Windows Professional" /Name:"My WDS Image"
/Description:"Windows Professional image with MSOffice" /Filename:"Win Pro.wim" /UnattendFile:"\\server\share\unattend.xml"
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the copy-Image Command](../using-copy-command/using-copyimage-command.md)

[Using the Export-Image Command](../using-exportimage-command.md)

[Using the get-Image Command](../using-get-command/using-getimage-command.md)

[Using the remove-Image Command](../using-remove-command/using-removeimage-command.md)

[Using the replace-Image Command](../using-replaceimage-command.md)

[Subcommand: set-Image](../the-set-command/subcommand-setimage.md)


