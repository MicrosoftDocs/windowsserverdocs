---
title: tapicfg
description: Reference article for the tapicfg commands, which creates, removes, or displays a TAPI application directory partition, or sets a default TAPI application directory partition.
ms.topic: reference
ms.assetid: c0e642ce-5d98-4edb-9a65-1dff09aef4e1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# tapicfg

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates, removes, or displays a TAPI application directory partition, or sets a default TAPI application directory partition. TAPI 3.1 clients can use the information in this application directory partition with the directory service locator service to find and communicate with TAPI directories. You can also use **tapicfg** to create or remove service connection points, which enable TAPI clients to efficiently locate TAPI application directory partitions in a domain.

This command-line tool can be run on any computer that is a member of the domain.

## Syntax

```
tapicfg install
tapicfg remove
tapicfg publishscp
tapicfg removescp
tapicfg show
tapicfg makedefault
```

### Parameters

| Parameters | Description |
|--|--|
| [tapicfg install](tapicfg-install.md) | Creates a TAPI application directory partition. |
| [tapicfg remove](tapicfg-remove.md) | Removes a TAPI application directory partition.|
| [tapicfg publishscp](tapicfg-publishscp.md) | Creates a service connection point to publish a TAPI application directory partition. |
| [tapicfg removescp](tapicfg-removescp.md) | Removes a service connection point for a TAPI application directory partition. |
| [tapicfg show](tapicfg-show.md) | Displays the names and locations of the TAPI application directory partitions in the domain. |
| [tapicfg makedefault](tapicfg-makedefault.md) | Sets the default TAPI application directory partition for the domain. |

#### Remarks

- You must be a member of the **Enterprise Admins** group in Active Directory to run either **tapicfg install** (to create a TAPI application directory partition) or **tapicfg remove** (to remove a TAPI application directory partition).

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

- [tapicfg makedefault](tapicfg-makedefault.md)
