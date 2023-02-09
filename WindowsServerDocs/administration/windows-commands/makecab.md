---
title: makecab
description: Reference article for the makecab command, which packages existing files into a cabinet (.cab) file.
ms.topic: reference
ms.assetid: 4da95297-c593-427b-9f76-2f389c46cbf4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# makecab

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Package existing files into a cabinet (.cab) file.


> [!NOTE]
> This command is the same as the [diantz command](diantz.md).

## Syntax

```
makecab [/v[n]] [/d var=<value> ...] [/l <dir>] <source> [<destination>]
makecab [/v[<n>]] [/d var=<value> ...] /f <directives_file> [...]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<source>` | File to compress. |
| `<destination>` | File name to give compressed file. If omitted, the last character of the source file name is replaced with an underscore (_) and used as the destination. |
| /f `<directives_file>` | A file with **makecab** directives (may be repeated). |
| /d var=`<value>` | Defines variable with specified value. |
| /l `<dir>` | Location to place destination (default is current directory). |
| /v[`<n>`] | Set debugging verbosity level (0=none,...,3=full). |
| /? | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [diantz command](diantz.md)

- [Microsoft Cabinet format](/previous-versions/bb417343(v=msdn.10))
