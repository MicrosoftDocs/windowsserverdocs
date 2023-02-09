---
title: ftp lcd
description: Reference article for the ftp lcd command, which changes the working directory on the local computer.
ms.topic: reference
ms.assetid: 60a25808-6abb-408b-8373-0bbdcd0994b4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp lcd

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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
