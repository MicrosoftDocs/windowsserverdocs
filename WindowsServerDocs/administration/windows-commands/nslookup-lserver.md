---
title: nslookup lserver
description: Reference article for the nslookup lserver command, which changes the initial server to the specified Domain Name System (DNS) domain.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# nslookup lserver



Changes the initial server to the specified Domain Name System (DNS) domain.

This command uses the initial server to look up the information about the specified DSN domain. If you want to lookup information using the current default server, use the [nslookup server](nslookup-server.md) command.

## Syntax

```
lserver <DNSdomain>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<DNSdomain>` | Specifies the DNS domain for the initial server. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup server](nslookup-server.md)
