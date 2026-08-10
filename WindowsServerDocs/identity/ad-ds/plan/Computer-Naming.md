---
description: "Learn more about: Computer Naming"
title: Computer Naming
author: robinharwood
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# Computer Naming

When a computer running the Windows 2000, Windows XP, Windows Server 2003,  Windows Server 2008 , or Windows Vista operating system joins a domain, by default the computer assigns itself a name. The name it assigns itself comprises the host name of the computer (that is, Computer Name in System Properties) and the Domain Name System (DNS) name of the Active Directory domain that the computer joined (that is, Primary DNS Suffix in System Properties). The concatenation of the host name and the DNS name of the domain is known as the fully qualified domain name (FQDN). For example, if a computer with host name Server1 joins the domain corp.contoso.com, the FQDN of the computer is server1.corp.contoso.com.

If a computer already has a different DNS domain name that was statically entered into a DNS zone or registered by an integrated DNS/Dynamic Host Configuration Protocol (DHCP) Server service, the FQDN of the computer is distinct from the name that was registered previously. The computer can be referenced by either name.

For more information about naming conventions in Active Directory Domain Services (AD DS), see [Naming conventions in Active Directory for computers, domains, sites, and OUs](https://support.microsoft.com/help/909264/).
