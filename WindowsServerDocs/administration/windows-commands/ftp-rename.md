---
title: ftp rename
description: Reference article for the ftp rename command, which renames remote files.
ms.topic: reference
ms.assetid: 977b7c95-6428-4980-80ec-79c3ae7e8c4d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp rename

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Renames remote files.

## Syntax

```
rename <filename> <newfilename>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<filename>` | Specifies the file that you want to rename. |
| `<newfilename>` | Specifies the new file name. |

### Examples

To rename the remote file *example.txt* to *example1.txt*, type:

```
rename example.txt example1.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
