---
title: Checklist: Reconfiguring the DNS Server Service
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 209aa0ba-0f19-4705-8511-4ec4aedaa290
author: Femila
---
# Checklist: Reconfiguring the DNS Server Service
Complete the tasks in this checklist in the order in which they are presented. If a reference link takes you to a conceptual topic, return to this checklist after you review the conceptual topic so that you can proceed with the remaining tasks.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Reconfiguring the DNS Server service**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Enable aging and scavenging on two [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based domain controllers running the Domain Name System \(DNS\) Server service. **Note:** We recommend that you complete this step for any forest root domain controller that has the DNS Server service installed.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Enable Aging and Scavenging for DNS](../Topic/Enable-Aging-and-Scavenging-for-DNS.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Configure the DNS Client service settings for the first domain controller and any additional domain controllers. **Note:** This step is optional, if you installed the DNS Client service when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configure the DNS Client Service Settings for the First and Subsequent Domain Controllers](../Topic/Configure-the-DNS-Client-Service-Settings-for-the-First-and-Subsequent-Domain-Controllers.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|If you deploy additional domain controllers that you did not previously create resource records for, update the DNS delegation. **Note:** This step is optional, if you installed the DNS Client service when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Update the DNS Delegation for the Regional Domain](../Topic/Update-the-DNS-Delegation-for-the-Regional-Domain.md)|  
  
