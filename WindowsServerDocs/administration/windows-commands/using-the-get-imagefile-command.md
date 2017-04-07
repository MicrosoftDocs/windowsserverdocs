---
title: Using the get-ImageFile Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e1e296fb-20cf-4a60-9db4-4cbac7d4dab5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Using the get-ImageFile Command

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Retrieves information about the images contained in a Windows Image (.wim) file.
## Syntax
```
wdsutil [Options] /Get-ImageFilmediaFile:<wim file path> [/detailed]
```
## Parameters
|Parameter|Description|
|-------|--------|
mediaFile:<WIM file path>|Specifies the full path and file name of the .wim file.|
|[/detailed]|Returns all image metadata from each image. If this option is not used, the default behavior is to return only the image name, description, and file name.|
## <a name="BKMK_examples"></a>Examples
To view information about an image, type:
```
wdsutil /Get-ImageFilmediaFile:"C:\temp\install.wim"
```
To view detailed information, type:
```
wdsutil /verbose /Get-ImageFilmediaFile:"\\Server\Share\My Folder \install.wim" /detailed
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
