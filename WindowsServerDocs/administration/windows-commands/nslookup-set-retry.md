---
title: nslookup set retry
description: Reference article for the nslookup set retry command, which sets the number of tries to get information from a specified server.
ms.topic: reference
ms.assetid: 615fdfa2-fa29-47a8-8c9e-a6c5b45b3b71
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# nslookup set retry



If a reply isn't received within a certain amount of time, the time-out period is doubled, and the request is resent. This command sets the number of times a request is resent to a server for information, before giving up.

> [!NOTE]
> To change the length of time before the request times out, use the [nslookup set timeout](nslookup-set-timeout.md) command.

## Syntax

```
set retry=<number>
```

### Parameters

| Parameter | Description |
| ---------- | ---------- |
| `<number>` | Specifies the new value for the number of retries. The default number of retries is **4**. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup set timeout](nslookup-set-timeout.md)
