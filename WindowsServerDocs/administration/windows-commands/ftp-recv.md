---
title: ftp recv
description: Reference article for the ftp recv command, which copies a remote file to the local computer using the current file transfer type.
ms.topic: reference
ms.assetid: f249ce61-247d-421b-9b93-48bce5108800
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp recv

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies a remote file to the local computer using the current file transfer type.

> [!NOTE]
> This command is the same as the [ftp get command](ftp-get.md).

## Syntax

```
recv <remotefile> [<localfile>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the remote file to copy. |
| `[<localfile>]` | Specifies the name of the file to use on the local computer. If *localfile* isn't specified, the file is given the name of the *remotefile*. |

### Examples

To copy *test.txt* to the local computer using the current file transfer, type:

```
recv test.txt
```

To copy *test.txt* to the local computer as *test1.txt* using the current file transfer, type:

```
recv test.txt test1.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp get command](ftp-get.md)

- [ftp ascii command](ftp-ascii.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
