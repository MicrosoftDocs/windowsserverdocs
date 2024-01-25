---
title: get-ImageFile
description: Reference article for get-ImageFile, which retrieves information about the images contained in a Windows Image (.wim) file.
ms.topic: reference
ms.assetid: e1e296fb-20cf-4a60-9db4-4cbac7d4dab5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# get-ImageFile

Retrieves information about the images contained in a Windows Image (.wim) file.

## Syntax

```
wdsutil [Options] /Get-ImageFile /ImageFile:<wim file path> [/Detailed]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|/ImageFile:\<WIM file path>|Specifies the full path and file name of the .wim file.|
|[/Detailed]|Returns all image metadata from each image. If this option is not used, the default behavior is to return only the image name, description, and file name.|

## Examples

To view information about an image, type:
```
wdsutil /Get-ImageFile /ImageFile:C:\temp\install.wim
```
To view detailed information, type:
```
wdsutil /Verbose /Get-ImageFile /ImageFile:\\Server\Share\My Folder \install.wim /Detailed
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)