---
title: nslookup server
description: Reference article for the nslookup server command, which changes the default server to the specified Domain Name System (DNS) domain.
ms.topic: reference
ms.assetid: 608267f8-f7b4-412a-8dcd-e08b5ffc2085
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the default server to the specified Domain Name System (DNS) domain.

This command uses the current default server to look up the information about the specified DNS domain. If you want to lookup information using the initial server, use the [nslookup lserver](nslookup-lserver.md) command.

## Syntax

```
server <DNSdomain>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<DNSdomain>` | Specifies the DNS domain for the default server. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup lserver](nslookup-lserver.md)
