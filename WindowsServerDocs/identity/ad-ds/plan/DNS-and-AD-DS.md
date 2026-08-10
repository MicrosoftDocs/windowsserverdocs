---
description: "Learn more about: DNS and AD DS"
title: DNS and AD DS
ms.author: roharwoo
author: robinharwood
ms.date: 05/12/2025
ms.topic: concept-article
---

# DNS and AD DS

Active Directory Domain Services (AD DS) uses Domain Name System (DNS) name resolution services to make it possible for clients to locate domain controllers and for the domain controllers that host the directory service to communicate with each other.

AD DS enables easy integration of the Active Directory namespace into an existing DNS namespace. Features such as Active Directory-integrated DNS zones make it easier for you to deploy DNS by eliminating the need to set up secondary zones, and then configure zone transfers.

For information about how DNS supports AD DS, see the section [DNS Support for Active Directory Technical Reference](/previous-versions/windows/it-pro/windows-server-2003/cc781627(v=ws.10)).

> [!NOTE]
> If you implement a disjoint namespace in which the AD DS domain name differs from the primary DNS suffix that clients use, AD DS integration with DNS is more complex. For more information, see [Disjoint Namespace](Disjoint-Namespace.md).

## In this section

- [Domain Controller Location](Domain-Controller-Location.md)
- [Active Directory-Integrated DNS Zones](Active-Directory-Integrated-DNS-Zones.md)
- [Computer Naming](Computer-Naming.md)
- [Disjoint Namespace](Disjoint-Namespace.md)
