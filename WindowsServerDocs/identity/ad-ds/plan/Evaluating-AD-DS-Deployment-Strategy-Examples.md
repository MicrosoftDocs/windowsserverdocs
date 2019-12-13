---
ms.assetid: 4f835b82-67b9-428c-b634-ce133cca5113
title: Evaluating AD DS Deployment Strategy Examples
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Evaluating AD DS Deployment Strategy Examples

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Consider the following example of a fictitious company, Contoso Pharmaceuticals, which is deploying Active Directory Domain Services (AD DS) in its environment. The Contoso environment consists of four domains. The forest functional level is Windows Server 2003. The following illustration shows the current domain structure for the Contoso organization.  
  
![AD DS deployment strategy](media/Evaluating-AD-DS-Deployment-Strategy-Examples/3dd79e00-48f8-4927-989c-c55a79caf1be.gif)  
  
After reviewing its existing environment and identifying its deployment goals, Contoso established the following AD DS deployment strategy:  
  
-   Upgrade Windows Server 2003 domains to  Windows Server 2008  domains.  
  
-   Enable advanced AD DS features by raising the domain and forest functional levels to  Windows Server 2008 .  
  
-   Restructure the africa.concorp.contoso.com domain within the forest to consolidate that domain with the emea.concorp.contoso.con domain.  
  
Raising the forest functional level to Windows Server 2008 will enable Contoso to take full advantage of the new AD DS features. Restructuring the domains within the forest, as shown in the following illustration, will reduce the amount of administration that is necessary for managing the domains.  
  
![AD DS deployment strategy](media/Evaluating-AD-DS-Deployment-Strategy-Examples/1c061755-413d-452d-b121-6910f8555327.gif)  
  


