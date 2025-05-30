---
title: ftp mget
description: Reference article for the ftp mget command, which copies remote files to the local computer using the current file transfer type.
ms.topic: reference
ms.assetid: 6c85ae96-ec51-48a9-a227-7f02c7332c69
ms.author: alalve
author: xelu86
manager: mtillman
ms.date: 10/16/2017
---

# ftp mget



Copies remote files to the local computer using the current file transfer type.

## Syntax

```
mget <remotefile>[ ]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the remote files to copy to the local computer. |

### Examples

To copy remote files *a.exe* and *b.exe* to the local computer using the current file transfer type, type:

```
mget a.exe b.exe
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp ascii command](ftp-ascii.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
