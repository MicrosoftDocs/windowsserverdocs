---
title: Verify AD DS Installation on Additional Domain Controllers in a New Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ece9fccf-ab42-4a88-8e51-c8bf755bdd8d
author: Femila
---
# Verify AD DS Installation on Additional Domain Controllers in a New Regional Domain
To verify Active Directory Domain Services \(AD DS\) installation on additional domain controllers in a new regional domain, you complete the procedure that you used to verify AD DS installation on the first domain controller. For more information, see [Verify AD DS Installation on the First Domain Controller in a New Regional Domain](../Topic/Verify-AD-DS-Installation-on-the-First-Domain-Controller-in-a-New-Regional-Domain.md).  
  
If you installed the Domain Name System \(DNS\) Server service when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), you run the **repadmin \/showreps** command to verify that the ForestDnsZones and DomainDnsZones application partitions are replicated successfully.  
  
You can use the DNS Manager snap\-in to verify that DNS server recursive name resolution is configured according to your organization's design. For more information, see [Verify DNS Server Recursive Name Resolution on the First Domain Controller in a New Regional Domain](../Topic/Verify-DNS-Server-Recursive-Name-Resolution-on-the-First-Domain-Controller-in-a-New-Regional-Domain.md).  
  
