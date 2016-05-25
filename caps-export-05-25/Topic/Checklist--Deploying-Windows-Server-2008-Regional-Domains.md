---
title: Checklist: Deploying Windows Server 2008 Regional Domains
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e3f37750-84f8-40cf-9516-18f995c75d9a
author: Femila
---
# Checklist: Deploying Windows Server 2008 Regional Domains
After you complete the deployment of the Active Directory Domain Services \(AD DS\) forest root domain, you are ready to deploy any new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] regional domains that your design specifies.  
  
> [!NOTE]  
> This parent checklist contains links to subordinate checklists that you can use when you complete the tasks that are required to deploy [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] regional domains. Complete the tasks in this checklist in the order in which they are presented. When a reference link takes you to a conceptual topic, return to this checklist after you review the conceptual topic so that you can proceed with the remaining tasks.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist:**  
  
**Deploying** [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] **regional domains**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Review the AD DS regional domain design.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Reviewing the AD DS Regional Domain Design](../Topic/Reviewing-the-AD-DS-Regional-Domain-Design.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Delegate the DNS domain for the new regional domain. **Note:** This step is optional, if you installed the DNS Server service when you ran the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Delegating the DNS Domain for the New Regional Domain](../Topic/Delegating-the-DNS-Domain-for-the-New-Regional-Domain.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Deploy the first domain controller in a new regional domain.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Checklist: Deploying the First Domain Controller in a New Regional Domain](../Topic/Checklist--Deploying-the-First-Domain-Controller-in-a-New-Regional-Domain.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Deploy additional domain controllers in a new regional domain.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Checklist: Deploying Additional Domain Controllers in a New Regional Domain](../Topic/Checklist--Deploying-Additional-Domain-Controllers-in-a-New-Regional-Domain.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Reconfigure the DNS Server service.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Checklist: Reconfiguring the DNS Server Service](../Topic/Checklist--Reconfiguring-the-DNS-Server-Service.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Configure operations master roles.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configuring Operations Master Roles](../Topic/Configuring-Operations-Master-Roles.md)|  
  
