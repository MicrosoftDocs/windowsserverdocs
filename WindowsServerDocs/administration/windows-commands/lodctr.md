---
title: lodctr
description: Reference article for the lodctr command, which allows you to register or save performance counter name and registry settings in a file and designate trusted services.
ms.topic: reference
ms.assetid: 5a849abd-6b31-4833-bc8a-306c05eca29a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# lodctr

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Allows you to register or save performance counter name and registry settings in a file and designate trusted services.

## Syntax

```
lodctr <filename> [/s:<filename>] [/r:<filename>] [/t:<servicename>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<filename>` | Specifies the name of the initialization file that registers the performance counter name settings and explanatory text. |
| /s:`<filename>` | Specifies the name of the file to which the performance counter registry settings and explanatory text are saved. |
| /r | Restores counter registry settings and explanatory text from current registry settings and cached performance files related to the registry. |
| /r:`<filename>` | Specifies the name of the file that restores the performance counter registry settings and explanatory text.<p>**Warning:** If you use this command, you'll overwrite all performance counter registry settings and explanatory text, replacing them with the configuration defined in the specified file. |
| /t:`<servicename>` | Indicates that service `<servicename>` is trusted. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the information that you supply contains spaces, use quotation marks around the text (for example, "file name 1").

### Examples

To save the current performance registry settings and explanatory text to file *"perf backup1.txt"*, type:

```
lodctr /s:"perf backup1.txt"
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
