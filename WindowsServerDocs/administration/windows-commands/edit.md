---
title: edit
description: Reference article for the edit command, which starts the MS-DOS Editor, so you can create and change ASCII text files.
ms.topic: reference
ms.assetid: 4e0ff2e8-3518-47c1-8c69-5e93f895fa0e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# edit

Starts the MS-DOS Editor, which creates and changes ASCII text files.

## Syntax

```
edit [/b] [/h] [/r] [/s] [/<nnn>] [[<drive>:][<path>]<filename> [<filename2> [...]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[<drive>:][<path>]<filename> [<filename2> [...]]` | Specifies the location and name of one or more ASCII text files. If the file doens't exist, MS-DOS Editor creates it. If the file exists, MS-DOS Editor opens it and displays its contents on the screen. The *filename* option can contain wildcard characters (**&#42;** and **?**). Separate multiple file names with spaces. |
| /b | Forces monochrome mode, so that MS-DOS Editor displays in black and white. |
| /h | Displays the maximum number of lines possible for the current monitor. |
| /r | Loads file(s) in read-only mode. |
| /s | Forces the use of short filenames. |
| `<nnn>` | Loads binary file(s), wrapping lines to *nnn* characters wide. |
| /? | Displays help at the command prompt. |

#### Remarks

- For additional help, open MS-DOS Editor, and then press the F1 key.

- Some monitors don't support the display of shortcut keys by default. If your monitor doesn't display shortcut keys, use **/b**.

### Examples

To open MS-DOS Editor, type:

```
edit
```

To create and edit a file named *newtextfile.txt* in the current directory, type:

```
edit newtextfile.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
