---
title: ftp dir
description: Reference article for the ftp dir command, which displays a list of directory files and subdirectories on a remote computer.
ms.topic: reference
ms.assetid: a29a92a5-7b79-4e6e-95cf-2ccb38bb6fb2
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp dir

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays a list of directory files and subdirectories on a remote computer.

## Syntax

```
dir [<remotedirectory>] [<localfile>]
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| `[<remotedirectory>]` | Specifies the directory for which you want to see a listing. If no directory is specified, the current working directory on the remote computer is used. |
| `[<localfile>]` | Specifies a local file in which to store the directory listing. If a local file is not specified, results are displayed on the screen. |

### Examples

To display a directory listing for *dir1* on the remote computer, type:

```
dir dir1
```

To save a list of the current directory on the remote computer in the local file *dirlist.txt*, type:

```
dir . dirlist.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
