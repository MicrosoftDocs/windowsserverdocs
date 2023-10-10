---
title: type
description: Reference article for the type command, which displays the contents of a text file.
ms.topic: reference
ms.assetid: c44fe905-a865-4c97-8cc5-fb95fec7d4d5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2020
---

# type

In the Windows Command shell, **type** is a built in command which displays the contents of a text file. Use the **type** command to view a text file without modifying it.

In PowerShell, **type** is a built-in alias to the [Get-Content cmdlet](/powershell/module/microsoft.powershell.management/get-content), which also displays the contents of a file, but using a different syntax.

## Syntax

```
type [<drive>:][<path>]<filename>
```

### Parameters

| Parameter | Description |
|--|--|
| `[<drive>:][<path>]<filename>` | Specifies the location and name of the file or files that you want to view. If your `<filename>` contains spaces, you must enclose it in quotation marks (for example, "Filename Containing Spaces.txt"). You can also add multiple filenames by adding spaces between them. |
| /? | Displays help at the command prompt. |

#### Remarks

- If you display a binary file or a file that is created by a program, you may see strange characters on the screen, including formfeed characters and escape-sequence symbols. These characters represent control codes that are used in the binary file. In general, avoid using the **type** command to display binary files.

## Examples

To display the contents of a file named *holiday.mar*, type:

```
type holiday.mar
```

To display the contents of a lengthy file named *holiday.mar* one screen at a time, type:

```
type holiday.mar | more
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
