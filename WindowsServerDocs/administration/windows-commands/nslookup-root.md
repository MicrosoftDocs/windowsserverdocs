---
title: nslookup root
description: Reference article for the nslookup root command, which changes the default server to the server for the root of the Domain Name System (DNS) domain name space.
ms.topic: reference
ms.assetid: 9c29edc3-ec49-43f2-bc49-86bf0612d816
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup root

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the default server to the server for the root of the Domain Name System (DNS) domain name space. Currently, the ns.nic.ddn.mil name server is used. You can change the name of the root server using the [nslookup set root](nslookup-set-root.md) command.

> [!NOTE]
> This command is the same as `lserver ns.nic.ddn.mil`.

## Syntax

```
root
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup set root](nslookup-set-root.md)
