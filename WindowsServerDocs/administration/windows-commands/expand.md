---
title: expand
description: Reference article for the expand command, which expands one or more compressed files.
ms.topic: reference
ms.assetid: 66de0488-a0c4-40c2-9b03-e40c107ba343
ms.author: alalve
author: JasonGerend
ms.date: 11/01/2022
---

# expand

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Expands one or more compressed files. You can also use this command to retrieve compressed files from distribution disks.

The **expand** command can also run from the Windows Recovery Console, using different parameters. For more information, see [Windows Recovery Environment (WinRE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference).

## Syntax

```
expand [-r] <source> <destination>
expand -r <source> [<destination>]
expand -i <source> [<destination>]
expand -d <source>.cab [-f:<files>]
expand <source>.cab -f:<files> <destination>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -r | Renames expanded files. |
| source | Specifies the files to expand. *Source* can consist of a drive letter and colon, a directory name, a file name, or a combination of these. You can use wildcards (**&#42;** or **?**). |
| destination | Specifies where files are to be expanded.<p>If *source* consists of multiple files and you don't specify **-r**, the *destination* must be a directory that already exists. *Destination* can consist of a drive letter and colon, a directory name, a file name, or a combination of these. Destination `file \| path` specification. |
| -i | Renames expanded files but ignores the directory structure. |
| -d | Displays a list of files in the source location. Doesn't expand or extract the files. |
| -f:`<files>` | Specifies the files in a cabinet (.cab) file that you want to expand. You can use wildcards (**&#42;** or **?**). |
| /? | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
