---
title: convert-riprepimage
description: Reference article for the convert-riprepimage command, which converts an existing Remote Installation Preparation (RIPrep) image to Windows Image (.wim) format.
ms.topic: reference
ms.assetid: 88c2b96f-5947-4b64-9dcf-1946b3c013cf
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# convert-riprepimage

Converts an existing Remote Installation Preparation (RIPrep) image to Windows Image (.wim) format.

## Syntax

```
wdsutil [Options] /Convert-RIPrepImage /FilePath:<Filepath and name> /DestinationImage /FilePath:<Filepath and name> [/Name:<Name>] [/Description:<Description>] [/InPlace] [/Overwrite:{Yes | No | Append}]
```

### Parameters

| Parameter | Description |
|--|--|
| /FilePath:`<Filepath and name>` | Specifies the full filepath and name of the .sif file that corresponds to the RIPrep image. This file is typically called Riprep.sif and is found in the **\Templates** subfolder of the folder that contains the RIPrep image. |
| /DestinationImage | Specifies the settings for the destination image.  Uses the following options;<ul><li>`/FilePath:<Filepath and name>` - Sets the full file path for the new file. For example: **C:\Temp\convert.wim**</li><li>[`/Name:<Name>`] - Sets the display name of the image. If no display name is specified, the display name of the source image is used.</li><li>[`/Description:<Description>`] - Sets the description of the image.</li><li>[/InPlace] - Specifies that the conversion should take place on the original RIPrep image and not on a copy of the original image, which is the default behavior.</li><li>[`/Overwrite:{Yes | No | Append}` - Sets whether this image should overwrite or append any existing files.</li></ul> |

## Examples

To convert the specified RIPrep.sif image to RIPREP.wim, type:

```
wdsutil /Convert-RiPrepImage /FilePath:R:\RemoteInstall\Setup\English \Images\Win2k3.SP1\i386\Templates\riprep.sif /DestinationImage /FilePath:C:\Temp\RIPREP.wim
```

To convert the specified RIPrep.sif image to RIPREP.wim with the specified name and description, and overwrite it with the new file if a file already exists, type:

```
wdsutil /Verbose /Progress /Convert-RiPrepImage /FilePath:\\Server \RemInst\Setup\English\Images\WinXP.SP2\i386\Templates\riprep.sif /DestinationImage /FilePath:\\Server\Share\RIPREP.wim /Name:WindowsXP image /Description:Converted RIPREP image of WindowsXP /Overwrite:Append
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Windows Deployment Services cmdlets](/powershell/module/wds)
