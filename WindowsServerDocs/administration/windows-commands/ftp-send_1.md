---
title: ftp send
description: Reference article for the ftp send command, which copies a local file to the remote computer using the current file transfer type.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# ftp send



Copies a local file to the remote computer using the current file transfer type.

> [!NOTE]
> This command is the same as the [ftp put command](ftp-put.md).

## Syntax

```
send <localfile> [<remotefile>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<localfile>` | Specifies the local file to copy. |
| `<remotefile>` | Specifies the name to use on the remote computer. If you don't specify a *remotefile*, the file will get the *localfile* name. |

### Examples

To copy the local file *test.txt* and name it *test1.txt* on the remote computer, type:

```
send test.txt test1.txt
```

To copy the local file *program.exe* to the remote computer, type:

```
send program.exe
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
