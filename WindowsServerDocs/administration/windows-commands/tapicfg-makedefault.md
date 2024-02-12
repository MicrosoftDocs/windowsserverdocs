---
title: tapicfg makedefault
description: Reference article for the tapicfg makedefault command, which sets the default TAPI application directory partition for the domain.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 09/29/2020
---

# tapicfg makedefault

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets the default TAPI application directory partition for the domain.

## Syntax

```
tapicfg makedefault /directory:<partitionname> [/domain:<domainname>]
```

### Parameters

| Parameter | Description |
|--|--|
| makedefault `/directory:<partitionname>` | Required. Specifies the DNS name of the TAPI application directory partition set as the default partition for the domain. This name must be a fully-qualified domain name. |
| /domain: `<domainname>` | Specifies the DNS name of the domain for which the TAPI application directory partition is set as the default. If the domain name is not specified, the name of the local domain is used. |
| /? | Displays help at the command prompt. |

#### Remarks

- This command-line tool can be run on any computer that is a member of the domain.

- User-supplied text (such as the names of TAPI application directory partitions, servers, and domains) with International or Unicode characters are only displayed correctly if appropriate fonts and language support are installed.

- You can still use Internet Locator Service (ILS) servers in your organization, if ILS is needed to support certain applications, because TAPI clients running Windows XP or a Windows Server 2003 operating system can query either ILS servers or TAPI application directory partitions.

- You can use **tapicfg** to create or remove service connection points. If the TAPI application directory partition is renamed for any reason (for example, if you rename the domain in which it resides), you must remove the existing service connection point and create a new one that contains the new DNS name of the TAPI application directory partition to be published. Otherwise, TAPI clients are unable to locate and access the TAPI application directory partition. You can also remove a service connection point for maintenance or security purposes (for example, if you do not want to expose TAPI data on a specific TAPI application directory partition).

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [tapicfg install](tapicfg-install.md)

- [tapicfg remove](tapicfg-remove.md)

- [tapicfg publishscp](tapicfg-publishscp.md)

- [tapicfg removescp](tapicfg-removescp.md)

- [tapicfg show](tapicfg-show.md)
