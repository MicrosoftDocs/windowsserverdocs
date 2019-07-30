---
title: Performance Tuning Active Directory Servers
description: Performance Tuning for Active Directory Servers
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: landing-page
ms.author: TimWi; ChrisRob; HerbertM; KenBrumf;  MLeary; ShawnRab; v-tea
author: phstee
ms.date: 10/16/2017
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
Properly deploying a sufficient number of domain controllers, in the right domain, in the right locales, and to accommodate redundancy is critical to ensuring servicing client requests in a timely fashion. This is an in-depth topic and outside of the scope of this guide. Readers readers are encouraged start to their Active Directory performance tuning by reading and undestanding the recommendations and guidance found in [Capacity planning for Active Directory Domain Services](capacity-planning-for-active-directory-domain-services.md).

>[!Important]
> Proper configuration and sizing of Active Directory has a significant potential impact on overall system and workload performance. Readers are highly encouraged to start by reading [Capacity planning for Active Directory Domain Services](capacity-planning-for-active-directory-domain-services.md).

## Updates and evolving recommendations

Massive improvements in both Active Directory and client performance optimizations have occurred over the last several generations of the operating system and these efforts continue. We recommend that the most current versions of the platform be deployed to get the benefits, including:

- Increased reliability
- Better performance
- Better logging and tools to troubleshoot

However, we realize that this takes time and many environments are running in a scenario where 100% adoption of the most current platform is impossible. Some improvements have been added to older versions of the platform and we’ll continue to add more.

We encourage you to stay up to date on the latest news, guidance and best practices for managing ADDS by following our team blog, ["Ask the Directory Services Team"](https://techcommunity.microsoft.com/t5/Ask-the-Directory-Services-Team/bg-p/AskDS).

## See also

- [Capacity planning for AD DS](capacity-planning-for-active-directory-domain-services.md)
- [Hardware considerations](hardware-considerations.md)
- [Memory usage considerations](memory-usage-considerations.md)
- [LDAP considerations](ldap-considerations.md)
- [Proper placement of domain controllers and site considerations](site-definition-considerations.md)
- [Troubleshooting AD DS performance](troubleshoot.md)  
  