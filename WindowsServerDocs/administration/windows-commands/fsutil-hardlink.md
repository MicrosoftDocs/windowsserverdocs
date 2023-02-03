---
title: fsutil hardlink
description: Reference article for the fsutil hardlink command, which creates a hard link between an existing file and a new file.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: 835fc6f1-cc84-4189-b29a-dde90792469e
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil hardlink

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Creates a hard link between an existing file and a new file. A hard link is a directory entry for a file. Every file can be considered to have at least one hard link.

On NTFS volumes, each file can have multiple hard links, so a single file can appear in many directories (or even in the same directory with different names). Because all of the links reference the same file, programs can open any of the links and modify the file. A file is deleted from the file system only after all links to it have been deleted. After you create a hard link, programs can use it like any other file name.

## Syntax

```
fsutil hardlink create <newfilename> <existingfilename>
fsutil hardlink list <filename>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| create | Establishes an NTFS hard link between an existing file and a new file. (An NTFS hard link is similar to a POSIX hard link.) |
| \<newfilename> | Specifies the file that you want to create a hard link to. |
| \<existingfilename> | Specifies the file that you want to create a hard link from. |
| list | Lists the hard links to *filename*. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
