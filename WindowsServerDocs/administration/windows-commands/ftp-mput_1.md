---
title: ftp mput
description: Reference article for the ftp mput command, which copies local files to the remote computer using the current file transfer type.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# ftp mput



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

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp ascii command](ftp-ascii.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
