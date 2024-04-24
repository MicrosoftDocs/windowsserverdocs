---
title: nslookup set timeout
description: Reference article for the nslookup set timeout command, which changes the initial number of seconds to wait for a reply to a lookup request.
ms.topic: reference
ms.assetid: 07afdaf4-ffec-496f-a188-4e91cf1a28f8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup set timeout

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the initial number of seconds to wait for a reply to a lookup request. If a reply isn't received within the specified amount of time, the time-out period is doubled, and the request is resent. Use the [nslookup set retry](nslookup-set-retry.md) command to determine the number of times to try to send the request.

## Syntax

```
set timeout=<number>
```

### Parameters

| Parameter | Description |
| ---------- | ---------- |
| `<number>` | Specifies the number of seconds to wait for a reply. The default number of seconds to wait is **5**. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

### Examples

To set the timeout for getting a response to 2 seconds:

```
set timeout=2
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup set retry](nslookup-set-retry.md)
