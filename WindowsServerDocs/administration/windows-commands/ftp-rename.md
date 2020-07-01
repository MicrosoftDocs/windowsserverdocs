---
title: ftp rename
description: Reference article for the ftp rename command, which renames remote files.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 977b7c95-6428-4980-80ec-79c3ae7e8c4d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ftp rename

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](https://docs.microsoft.com/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
