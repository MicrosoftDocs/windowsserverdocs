---
title: Using the get-Image Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0ecaa999-72ad-4191-adb5-a418de42a001
---
# Using the get-Image Command
Retrieves information about an image.

## Syntax
for boot images:

```
wdsutil [Options] /Get-Imagmedia:<Image name> [/Server:<Server name>mediatype:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<File name>]
```

for install images:

```
wdsutil [Options] /Get-Imagmedia:<Image name> [/Server:<Server name>mediatype:InstallmediaGroup:<Image group name>] [/Filename:<File name>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
mediatype:{Boot &#124; Install}|Specifies the type of image.|
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because it is possible to have the same image name for boot images in different architectures, specifying the architecture value ensures that the correct image is returned.|
|\[\/Filename:<File name>\]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|
|\mediaGroup:<Image group name>\]|Specifies the image group that contains the image. if no image group is specified and only one image group exists on the server, that group will be used. if more than one image group exists on the server, you must use this parameter to specify the image group.|

## <a name="BKMK_examples"></a>Examples
To retrieve information about a boot image, type one of the following:

```
wdsutil /Get-Imagmedia:"WinPE boot imagemediatype:Boot /Architecture:x86
wdsutil /verbose /Get-Imagmedia:"WinPE boot image" /Server:MyWDSServemediatype:Boot /Architecture:x86 /Filename:boot.wim

```

To retrieve information about an install image, type one of the following:

```
wdsutil /Get-Imagmedia:"Windows Vista with Officemediatype:Install
wdsutil /verbose /Get-Imagmedia:"Windows Vista with Office" /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1 /Filename:install.wim
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-Image Command](../using-add-command/using-addimage-command.md)

[Using the copy-Image Command](../using-copy-command/using-copyimage-command.md)

[Using the Export-Image Command](../using-exportimage-command.md)

[Using the remove-Image Command](../using-remove-command/using-removeimage-command.md)

[Using the replace-Image Command](../using-replaceimage-command.md)

[Subcommand: set-Image](../the-set-command/subcommand-setimage.md)


