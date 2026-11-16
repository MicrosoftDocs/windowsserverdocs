---
title: telnet open
description: Reference article for the telnet open command, which connects to a telnet server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 11/11/2026
---

# telnet: open

> [!IMPORTANT]
> Telnet Client is deprecated and will be removed from Windows in a future release.

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
