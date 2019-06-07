---
title: Using the convert-RiprepImage Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 88c2b96f-5947-4b64-9dcf-1946b3c013cf
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Using the convert-RiprepImage Command



Converts an existing Remote Installation Preparation (RIPrep) image to Windows Image (.wim) format.

## Syntax

```
WDSUTIL [Options] /Convert-RIPrepImage /FilePath:<File path and name>
     /DestinationImage
         /FilePath:<File path and name>
         [/Name:<Name>]
         [/Description:<Description>]
         [/InPlace]
         [/Overwrite:{Yes | No | Append}]
```

## Parameters

|            Parameter            |                                                                                                                                                                                                                                                                                                               Description                                                                                                                                                                                                                                                                                                                |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /FilePath:\<File path and name> |                                                                                                                                                                                                       Specifies the full path and file name of the .sif file that corresponds to the RIPrep image. This file is typically called Riprep.sif and is found in the \Templates subfolder of the folder that contains the RIPrep image.                                                                                                                                                                                                       |
|        /DestinationImage        | Specifies the settings for the destination image, using the following options.</br>-   /FilePath:\<File path and name> - Sets the full file path for the new file. For example: **C:\Temp\convert.wim**</br>-   [/Name:\<Name>] - Sets the display name of the image. If no display name is specified, the display name of the source image will be used.</br>-   [/Description: \<Description>] - Sets the description of the image.</br>-   [/InPlace] - Specifies that the conversion should take place on the original RIPrep image and not on a copy of the original image, which is the default behavior.</br>-   [/Overwrite:{Yes |

## <a name="BKMK_examples"></a>Examples

To convert the specified RIPrep.sif image to RIPREP.wim, type:
```
WDSUTIL /Convert-RiPrepImage /FilePath:"R:\RemoteInstall\Setup\English
\Images\Win2k3.SP1\i386\Templates\riprep.sif" /DestinationImage
/FilePath:"C:\Temp\RIPREP.wim"
```
To convert the specified RIPrep.sif image to RIPREP.wim with the specified name and description, and overwrite it with the new file if a file already exists, type:
```
WDSUTIL /Verbose /Progress /Convert-RiPrepImage /FilePath:"\\Server
\RemInst\Setup\English\Images\WinXP.SP2\i386\Templates\riprep.sif"
/DestinationImage /FilePath:"\\Server\Share\RIPREP.wim"
/Name:"WindowsXP image" /Description:"Converted RIPREP image of WindowsXP"
/Overwrite:Append
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)