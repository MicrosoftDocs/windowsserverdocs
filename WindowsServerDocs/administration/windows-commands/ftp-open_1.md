---
title: ftp open
description: Reference article for the ftp open command, which connects to the specified ftp server.
ms.topic: reference
ms.assetid: 4b61926a-dc60-4b4c-96d3-64e5c91c18ba
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ftp open

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Connects to the specified ftp server.

## Syntax

```
open <computer> [<port>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<computer>` | Specifies the remote computer to which you are trying to connect. You can use an IP address or computer name (in which case a DNS server or Hosts file must be available). |
| `[<port>]` | Specifies a TCP port number to use to connect to an ftp server. By default, TCP port 21 is used. |

### Examples

To connect to the ftp server at *ftp.microsoft.com*, type:

```
open ftp.microsoft.com
```

To connect to the ftp server at *ftp.microsoft.com* that is listening on TCP port *755*, type:

```
open ftp.microsoft.com 755
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Additional FTP guidance](/previous-versions/orphan-topics/ws.10/cc756013(v=ws.10))
