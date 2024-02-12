---
title: nslookup set type
description: Reference article for the nslookup set type command, which changes the resource record type for the query.
ms.topic: reference
ms.assetid: 5248e314-fac1-413e-81dc-bbe0a0873ba5
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup set type

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes the resource record type for the query. For information about resource record types, see [Request for Comment (Rfc) 1035](https://tools.ietf.org/html/rfc1035).

> [!NOTE]
> This command is the same as the [nslookup set querytype](nslookup-set-querytype.md) command.

## Syntax

```
set type=<resourcerecordtype>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<resourcerecordtype>` | Specifies a DNS resource record type. The default resource record type is **A**, but you can use any of the following values:<ul><li>**A:** Specifies a computer's IP address.</li><li>**ANY:** Specifies a computer's IP address.</li><li>**CNAME:** Specifies a canonical name for an alias.</li><li>**GID** Specifies a group identifier of a group name.</li><li>**HINFO:** Specifies a computer's CPU and type of operating system.</li><li>**MB:** Specifies a mailbox domain name.</li><li>**MG:** Specifies a mail group member.</li><li>**MINFO:** Specifies mailbox or mail list information.</li><li>**MR:** Specifies the mail rename domain name.</li><li>**MX:** Specifies the mail exchanger.</li><li>**NS:** Specifies a DNS name server for the named zone.</li><li>**PTR:** Specifies a computer name if the query is an IP address; otherwise, specifies the pointer to other information.</li><li>**SOA:** Specifies the start-of-authority for a DNS zone.</li><li>**TXT:** Specifies the text information.</li><li>**UID:** Specifies the user identifier.</li><li>**UINFO:** Specifies the user information.</li><li>**WKS:** Describes a well-known service.</li></ul> |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [nslookup set type](nslookup-set-querytype.md)
