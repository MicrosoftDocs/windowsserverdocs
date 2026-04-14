---
title: ftp lcd
description: Reference article for the ftp lcd command, which changes the working directory on the local computer.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# ftp lcd



Changes the working directory on the local computer. By default, the working directory is the directory in which the **ftp** command was started.

## Syntax

```
lcd [<directory>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[<directory>]` | Specifies the directory on the local computer to which to change. If *directory* isn't specified, the current working directory is changed to the default directory. |

### Examples

To change the working directory on the local computer to *c:\dir1*, type:

```
lcd c:\dir1
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
