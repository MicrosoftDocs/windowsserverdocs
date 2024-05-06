---
title: 32k pages in Active Directory Domain Services
description: Learn about 32k page feature in Active Directory Domain Services
author: gswashington
ms.author: robinharwood
ms.date: 05/25/2024
ms.topic: conceptual
---

# 32K pages in Active Directory Domain Services

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

As part of ongoing efforts in scalability improvements, Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) feature a range of new functionalities and capabilities aimed at optimizing domain management experience. Included is the 32k database page size optional feature - Active Directory uses an Extensible Storage Engine (ESE) database that uses an 8k database page size. The 8k architectural design imposed limitations throughout Active Directory. See [Active Directory Maximum Limits Scalability]() for more information. An example of this limitation is a single record Active Directory object, which can't exceed 8k bytes in size. Moving to a 32k database page format offers a huge improvement in areas affected by legacy restrictions, including multi-valued attributes being able to hold up to approximately 3,200 values, an increase by a factor of 2.6.

New domain controllers in Active Directory that enjoy 32k pages more values, including LVID (long-value IDs). This helps with 64-bit long value ID storage ... (NEED MORE DETAIL HERE)

The 32k database page size is an optional feature in Active Directory; it is not enabled by default in Windows Server. The exception is in Windows Server 2025 (preview) domains and forests, where the 32k database page size feature is enabled by default.

There are some requirements but for the most part enabling 32k pages is straightforward and easy. All Domain Controllers must be upgraded to Windows Server 2025 (preview). And domain and forest functional levels must be upgraded accordingly. All your applications and services that interact with Active Directory must also be compatible with the 32K pages feature. Also, keep in mind that increased memory usage due to larger page sizes can impact server performance.

Moving to 32k database pages is done on a forest-wide basis and requires that all domain controllers in the forest have a 32k page-capable database.

## Related reading

- [Enable 32k pages in Active Directory Domain Services](/enable-32K-pages-active-directory-domain-services.md)

- [What's new in Windows Server 2025 (preview)](https://learn.microsoft.com/windows-server/get-started/whats-new-windows-server-2025#active-directory-domain-services)
