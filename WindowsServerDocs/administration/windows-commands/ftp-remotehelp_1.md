---
title: ftp remotehelp
description: Reference article for the ftp remotehelp command, which displays help for remote commands.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---

# ftp remotehelp



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
