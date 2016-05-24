---
title: Creating the Forest Root Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a8558651-3a23-4779-9727-57acd79ca595
author: Femila
---
# Creating the Forest Root Domain
To create the Active Directory Domain Services \(AD DS\) forest root domain, complete the tasks in [Checklist: Creating the Forest Root Domain](../Topic/Checklist--Creating-the-Forest-Root-Domain.md).  
  
## About AD DS forest root domain  
The first domain that you create in your AD DS forest is automatically designated as the forest root domain. The forest root domain provides the foundation for your AD DS infrastructure. You must create the forest root domain before you create regional domains. In addition, services that run on forest root domain controllers, such as the Kerberos version 5 authentication protocol, must be highly available to ensure that users maintain access to resources throughout the forest. The forest owner is responsible for deploying the forest root domain.  
  
If your AD DS forest design requires only one domain, then the forest root domain will also contain all your users, groups, and resources. During deployment, you can create an organizational unit \(OU\) structure after the forest root domain deployment is complete.  
  
In a multiple AD DS domain design, the forest root domain can be a dedicated root used only for administration of the forest or it can contain users, groups, and resources in addition to the forest administration accounts. After you deploy the forest root domain, the forest owner will create one or more regional domains to complete the AD DS forest hierarchy.  
  
For more information about deploying additional regional domains, see [Deploying Windows Server 2008 Regional Domains](../Topic/Deploying-Windows-Server-2008-Regional-Domains.md).  
  
