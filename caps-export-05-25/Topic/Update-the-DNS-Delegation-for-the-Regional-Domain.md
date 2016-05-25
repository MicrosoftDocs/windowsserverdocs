---
title: Update the DNS Delegation for the Regional Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7e8535cb-8fd8-4410-baf4-740364064f67
author: Femila
---
# Update the DNS Delegation for the Regional Domain
  
> [!IMPORTANT]  
> We recommend that you install Domain Name System \(DNS\) when you run the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\). If you do this, the wizard creates and updates the DNS zone delegations automatically when you add additional domain controllers to the domain. The information in this section describes how to delegate the DNS zone for the regional domains manually.  
  
Before you deploy the first regional domain controller, the DNS administrator delegates the DNS domain for the new regional domain. During that process, the DNS administrator adds name server \(NS\) and host \(A or AAAA\) resource records to the parent DNS zone for each domain controller that is specified in your organization's design. If you later deploy additional domain controllers that have no resource records, you must update the DNS delegation.  
  
You can use the DNS Manager snap\-in to update the DNS delegation on any forest root domain controller, as described in [Delegating the DNS Domain for the New Regional Domain](../Topic/Delegating-the-DNS-Domain-for-the-New-Regional-Domain.md) earlier in this guide.  
  
