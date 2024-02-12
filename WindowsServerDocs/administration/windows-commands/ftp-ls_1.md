---
title: ftp ls
description: Reference article for the ftp ls command, which displays an abbreviated list of files and subdirectories from the remote computer.
ms.topic: reference
ms.assetid: 5e03c7db-1e2b-419c-acb2-8a68f3db9615
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp ls

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays an abbreviated list of files and subdirectories from the remote computer.

## Syntax

```
ls [<remotedirectory>] [<localfile>]
```

### Parameters

| Parameter | Description |
| --------- |------------ |
| `[<remotedirectory>]` | Specifies the directory for which you want to see a listing. If no directory is specified, the current working directory on the remote computer is used. |
| `[<localfile>]` | Specifies a local file in which to store the listing. If a local file is not specified, results are displayed on the screen. |

### Examples

To display an abbreviated list of files and subdirectories from the remote computer, type:

```
ls
```

To get an abbreviated directory listing of *dir1* on the remote computer and save it in a local file called *dirlist.txt*, type:

```
ls dir1 dirlist.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
