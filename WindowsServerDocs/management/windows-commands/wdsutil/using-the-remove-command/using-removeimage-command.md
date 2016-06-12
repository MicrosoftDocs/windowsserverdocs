---
title: Using the remove-Image Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce5e2384-2264-4b22-92af-74eec8c10ae0
---
# Using the remove-Image Command
deletes an image from a server.

## Syntax
for boot images:

```
wdsutil [Options] /remove-Imagmedia:<Image name> [/Server:<Server name>mediatype:Boot /Architecture:{x86 | ia64 | x64} [/Filename:<Filename>]
```

for install images:

```
wdsutil [Options] /remove-Imagmedia:<Image name> [/Server:<Server name>mediatype:InstallmediaGroup:<Image group name>] [/Filename:<Filename>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
media:<Image name>|Specifies the name of the image.|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.|
mediatype:{Boot &#124; Install}|Specifies the type of image.|
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the image. Because it is possible to have the same image name for different boot images in different architectures, specifying the architecture value ensures that the correct image will be removed.|
|\mediaGroup:<Image group name>\]|Specifies the image group that contains the image. if no image group name is specified and only one image group exists on the server, that image group will be used. if more than one image group exists, you must use this option to specify the image group.|
|\[\/Filename:<File name>\]|if the image cannot be uniquely identified by name, you must use this option to specify the file name.|

## <a name="BKMK_examples"></a>Examples
To remove a boot image, type:

```
wdsutil /remove-Imagmedia:"WinPE Boot Imagemediatype:Boot /Architecture:x86
```

```
wdsutil /verbose /remove-Imagmedia:"WinPE Boot Image" /Server:MyWDSServemediatype:Boot /Architecture:x64 /Filename:boot.wim
```

To remove an install image, type:

```
wdsutil /remove-Imagmedia:"Windows Vista with Officemediatype:Install
```

```
wdsutil /verbose /remove-Imagmedia:"Windows Vista with Office" /Server:MyWDSServemediatype:InstalmediaGroup:ImageGroup1 /Filename:install.wim
```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the add-Image Command](../using-add-command/using-addimage-command.md)

[Using the copy-Image Command](../using-copy-command/using-copyimage-command.md)

[Using the Export-Image Command](../using-exportimage-command.md)

[Using the get-Image Command](../using-get-command/using-getimage-command.md)

[Using the replace-Image Command](../using-replaceimage-command.md)

[Subcommand: set-Image](../the-set-command/subcommand-setimage.md)


