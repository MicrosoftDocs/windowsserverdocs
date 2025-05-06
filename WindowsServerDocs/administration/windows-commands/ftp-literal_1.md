---
title: ftp literal
description: Reference article for the ftp literal command, which sends verbatim arguments to the remote ftp server.
ms.topic: reference
ms.assetid: fb81aa2d-07fa-4e79-bf44-1fb5526fdf14
ms.author: alalve
author: xelu86
manager: mtillman
ms.date: 10/16/2017
---

# ftp literal



Sends verbatim arguments to the remote ftp server. A single ftp reply code is returned.

> [!NOTE]
> This command is the same as the [ftp quote command](ftp-quote.md).

## Syntax

```
literal <argument> [ ]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<argument>` | Specifies the argument to send to the ftp server. |

### Examples

To send a **quit** command to the remote ftp server, type:

```
literal quit
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp quote command](ftp-quote.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
