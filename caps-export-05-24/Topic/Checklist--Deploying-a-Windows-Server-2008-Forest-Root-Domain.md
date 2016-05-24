---
title: Checklist: Deploying a Windows Server 2008 Forest Root Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: e624a095-a76d-48d4-9a88-8a9423a25f34
author: Femila
---
# Checklist: Deploying a Windows Server 2008 Forest Root Domain
The first domain that you create in your Active Directory Domain Services \(AD DS\) forest is automatically designated as the forest root domain. The forest root domain provides the foundation for your Active Directory forest infrastructure. You must create the forest root domain before you create regional domains or upgrade other Active Directory domains to join them to an existing forest.  
  
> [!NOTE]  
> This parent checklist contains links to subordinate checklists that you can use when you complete the tasks that are required to deploy a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest root domain. Complete the tasks in this checklist in the order in which they are presented. When a reference link takes you to a conceptual topic, return to this checklist after you review the conceptual topic so that you can proceed with the remaining tasks.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist:**  
  
**Deploying** [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] **Forest Root Domain**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Review the AD DS logical structure design.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Reviewing the AD DS Design](../Topic/Reviewing-the-AD-DS-Design.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Configure the Domain Name System \(DNS\) for the forest root domain. **Note:** When no DNS infrastructure exists, skip this step in the forest root domain deployment process.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Configuring DNS for the Forest Root Domain](../Topic/Configuring-DNS-for-the-Forest-Root-Domain.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Create your forest root domain.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Checklist: Creating the Forest Root Domain](../Topic/Checklist--Creating-the-Forest-Root-Domain.md)|  
|![](../Image/4d269a30-a873-45c5-87de-30ee6558e7b0.gif)|Enable [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] AD DS advanced features by raising the forest and domain functional levels. **Note:** We recommend that you raise forest and domain functional levels while you run the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Raising the Functional Levels](../Topic/Raising-the-Functional-Levels.md)|  
  
