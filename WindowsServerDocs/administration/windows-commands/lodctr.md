---
title: lodctr
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5a849abd-6b31-4833-bc8a-306c05eca29a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# lodctr

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to register or save performance counter name and registry settings in a file and designate trusted services.
## Syntax
```
lodctr <filename> [/s:<filename>] [/r:<filename>] [/t:<servicename>]
```
### Parameters

|    Parameter     |                                                                                                                                         Description                                                                                                                                          |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    <filename>    |                                                                                          Registers the Performance counter name settings and Explain text provided in initialization file FileName.                                                                                          |
|  /s:<filename>   |                                                                                                       Saves Performance counter registry settings and Explain text to file <filename>.                                                                                                       |
|        /r        |                                Restores counter registry settings and Explain text from current registry settings and cached performance files related to the registry.<br /><br />This option is available only in the Windows Server 2003 operating system.                                |
|  /r:<filename>   | Restores Performance counter registry settings and Explain text from file <filename>. **Warning:** if you use the **lodctr /r** command, you will overwrite all Performance counter registry settings and Explain text, replacing them with the configuration defined in the file specified. |
| /t:<servicename> |                                                                                                                       Indicates that service <servicename> is trusted.                                                                                                                       |
|        /?        |                                                                                                                             Displays help at the command prompt.                                                                                                                             |

## Remarks
If the information that you supply contains spaces, use quotation marks around the text (for example, "<filename>").
## <a name="BKMK_Examples"></a>Examples
To save the current Performance registry settings and counter Explain text to file **perf backup1.txt**:
```
lodctr /s:"perf backup1.txt"
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)

