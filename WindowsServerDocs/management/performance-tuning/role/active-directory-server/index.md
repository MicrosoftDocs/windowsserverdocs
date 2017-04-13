---
title: Performance Tuning Active Directory Servers
description: Performance Tuning for Active Directory Servers
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: landing-page
ms.author: TimWi; ChrisRob; HerbertM; KenBrumf;  MLeary; ShawnRab
author: phstee
ms.date: 04/24/2017
---
# Performance tuning Active Directory Servers

Performance tuning Active Directory is focused on two goals:
- Active Directory is optimally configured to service the load in the most efficient manner possible
- Workloads submitted to Active Directory should be as efficient as possible

This requires proper attention to three separate areas:
- Proper capacity planning – ensuring sufficient hardware is in place to support existing load
- Server side tuning – configuring domain controllers to handle the load as efficiently as possible
- Active Directory client/application tuning – ensuring that clients and applications are using Active Directory in an optimal fashion

## Start with capacity planning
Properly deploying a sufficient number of domain controllers, in the right domain, in the right locales, and to accommodate redundancy is critical to ensuring servicing client requests in a timely fashion. This is an in-depth topic and outside of the scope of this guide. Readers readers are encouraged start to their Active Directory performance tuning by reading and undestanding the recommendations and guidance found in [Capacity Planning for Active Directory Domain Services](http://go.microsoft.com/fwlink/?LinkId=324566).

>[!Important]
> Proper configuration and sizing of Active Directory has a significant potential impact on overall system and workload performance. Readers are highly encouraged to start by reading [Capacity Planning for Active Directory Domain Services](http://go.microsoft.com/fwlink/?LinkId=324566).

## See also
- [Hardware considerations](hardware-considerations.md)
- [Site definition considerations](site-definition-considerations.md)
- [LDAP considerations](ldap-considerations.md)
- [Capacity Planning for Active Directory Domain Services](http://go.microsoft.com/fwlink/?LinkId=324566)