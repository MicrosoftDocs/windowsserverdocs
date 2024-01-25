---
title: ftp get
description: Reference article for the ftp get command, which copies a remote file to the local computer using the current file transfer type.
ms.topic: reference
ms.assetid: d70355c4-58ef-43e0-916b-c7ecf77e6ee4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp get

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies a remote file to the local computer using the current file transfer type.

> [!NOTE]
> This command is the same as the [ftp recv command](ftp-recv.md).

## Syntax

```
get <remotefile> [<localfile>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<remotefile>` | Specifies the remote file to copy. |
| `[<localfile>]` | Specifies the name of the file to use on the local computer. If *localfile* isn't specified, the file is given the name of the *remotefile*. |

### Examples

To copy *test.txt* to the local computer using the current file transfer, type:

```
get test.txt
```

To copy *test.txt* to the local computer as *test1.txt* using the current file transfer, type:

```
get test.txt test1.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp recv command](ftp-recv.md)

- [ftp ascii command](ftp-ascii.md)

- [ftp binary command](ftp-binary.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
