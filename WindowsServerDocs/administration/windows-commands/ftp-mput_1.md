---
title: ftp mput
description: Reference topic for the ftp mput command, which copies local files to the remote computer using the current file transfer type.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 980f15e7-7cf1-4813-9946-a8cc4edfb198
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ftp mput

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies local files to the remote computer using the current file transfer type.

## Syntax

```
mput <localfile>[ ]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<localfile>` | Specifies the local file to copy to the remote computer. |

### Examples

To copy *Program1.exe* and *Program2.exe* to the remote computer using the current file transfer type, type:

```
mput Program1.exe Program2.exe
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp ascii command](ftp-ascii.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](https://docs.microsoft.com/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
