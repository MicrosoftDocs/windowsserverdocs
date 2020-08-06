---
title: extract
description: Reference article for the extract command, which extracts files from a source location.
ms.topic: article
ms.assetid: 20dab03e-f6e1-4eb8-b8a1-fd6f1d97ee83
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# extract

Extracts files from a cabinet or source.

## Syntax

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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
