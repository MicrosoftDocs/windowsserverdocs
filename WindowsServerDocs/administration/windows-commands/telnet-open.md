---
title: telnet open
description: Reference article for the telnet open command, which connects to a telnet server.
ms.topic: article
ms.assetid: e30ad68c-2366-4754-ac36-311a2392902a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# telnet: open

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Connects to a telnet server.

## Syntax

```
o[pen] <hostname> [<port>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<hostname>` | Specifies the computer name or IP address. |
| `[<port>]` | Specifies the TCP port that the telnet server is listening on. The default is TCP port 23. |

## Examples

To connect to a telnet server at *telnet.microsoft.com*, type:

```
o telnet.microsoft.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
