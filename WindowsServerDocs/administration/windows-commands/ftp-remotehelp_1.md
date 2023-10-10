---
title: ftp remotehelp
description: Reference article for the ftp remotehelp command, which displays help for remote commands.
ms.topic: reference
ms.assetid: ef23adf3-ead4-44c8-ac1d-c8a6f4b2bf73
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp remotehelp

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays help for remote commands.

## Syntax

```
remotehelp [<command>]
```

### Parameters

| Parameter | Description |
| ------- | -------- |
| `[<command>]` | Specifies the name of the command about which you want help. If `<command>` isn't specified, this command displays a list of all remote commands. You can also run remote commands using [ftp quote](ftp-quote.md) or [ftp literal](ftp-literal_1.md). |

### Examples

To display a list of remote commands, type:

```
remotehelp
```

To display the syntax for the *feat* remote command, type:

```
remotehelp feat
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ftp quote](ftp-quote.md)

- [ftp literal](ftp-literal_1.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
