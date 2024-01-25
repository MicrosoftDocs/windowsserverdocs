---
title: extract
description: Reference article for the extract command, which extracts files from a source location.
ms.topic: reference
ms.assetid: 20dab03e-f6e1-4eb8-b8a1-fd6f1d97ee83
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 12/29/2020
---

# extract / extrac32

Extracts files from a cabinet or source.

> [!NOTE]
> On Windows Server 2016 and newer, and on Windows 10, the program file Extract.exe is neither provided nor supported.
> It is replaced by Extrac32.exe, originally part of Internet Explorer, now part of the operating system.

## Syntax

## Extract.exe

```
extract [/y] [/a] [/d | /e] [/l dir] cabinet [filename ...]
extract [/y] source [newname]
extract [/y] /c source destination
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| cabinet | Use if you want to extract two or more files. |
| filename | Name of the file to extract from the cabinet. Wild cards and multiple filenames (separated by blanks) may be used. |
| source | Compressed file (a cabinet with only one file). |
| newname | New filename to give the extracted file. If not supplied, the original name is used. |
| /a | Process ALL cabinets. Follows cabinet chain starting in first cabinet mentioned. |
| /c | Copy source file to destination (to copy from DMF disks). |
| /d | Display cabinet directory (use with filename to avoid extract). |
| /e | Extract (use instead of *.* to extract all files). |
| /l dir | Location to place extracted files (default is current directory). |
| /y | Don't prompt before overwriting an existing file. |

## Extrac32.exe

> [!NOTE]
> Extrac32.exe can be used from the command line, but does not display any output on the console.
> Redirect the help output through the [more](./more.md) command, like this: `extrac32.exe /? | more`

```
Extrac32 [/Y] [/A] [/D | /E] [/L dir] cabinet [filename ...]
Extrac32 [/Y] source [newname]
Extrac32 [/Y] /C source destination
```

### Parameters

| Parameter | Description |
| :-------- | :---------- |
| cabinet   | Cabinet file (contains two or more files). |
| filename  | Name of the file to extract from the cabinet. Wild cards and multiple filenames (separated by blanks) may be used. |
| source    | Compressed file (a cabinet with only one file). |
| newname   | New filename to give the extracted file. If not supplied, the original name is used. |
| /A        | Process ALL cabinets.  Follows cabinet chain starting in first cabinet mentioned. |
| /C        | Copy source file to destination (to copy from DMF disks). |
| /D        | Display cabinet directory (use with filename to avoid extract). |
| /E        | Extract (use instead of *.* to extract all files). |
| /L dir    | Location to place extracted files (default is current directory). |
| /Y        | Do not prompt before overwriting an existing file. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)