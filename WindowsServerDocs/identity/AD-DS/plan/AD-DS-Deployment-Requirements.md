---
title: AD DS Deployment Requirements
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: 8758beb3-8c6e-4ff0-9f6e-953512e0fbae
author: Femila
---
# AD DS Deployment Requirements
The structure of your existing environment determines your strategy for deploying [!INCLUDE[nextref_longhorn]()] Active Directory Domain Services \(AD DS\). If you are creating an AD DS environment and you do not have an existing domain structure, complete your AD DS design before you begin creating your AD DS environment. Then, you can deploy a new forest root domain and deploy the rest of your domain structure according to your design.  
  
Also, as part of your AD DS deployment, you might decide to upgrade and restructure your environment. For example, if your organization has an existing Windows 2000 domain structure, you might perform an in\-place upgrade of some domains and restructure others. In addition, you might decide to reduce the complexity of your environment by either restructuring domains between forests or restructuring domains within a forest after you deploy AD DS.  
  
## Deploying a Windows Server 2008 forest root domain  
The forest root domain provides the foundation for your AD DS forest infrastructure. To deploy AD DS, you must first deploy a forest root domain. To do this, you must review your AD DS design; configure the DNS service for the forest root domain; create the forest root domain, which consists of deploying forest root domain controllers, configuring the site topology for the forest root domain, and configuring operations master roles \(also known as flexible single master operations or FSMO\); and raise the forest and domain functional levels. The following illustration shows the overall process of deploying a forest root domain.  
  
![](../../media/AD-DS-Deployment-Requirements/033aad0b-25ff-4793-8825-88a6daa01a55.gif)  
  
For more information, see [Deploying a Windows Server 2008 Forest Root Domain](Deploying-a-Windows-Server-2008-Forest-Root-Domain.md).  
  
## Deploying Windows Server 2008 regional domains  
After you complete the deployment of the forest root domain, you are ready to deploy any new [!INCLUDE[nextref_longhorn]()] regional domains that are specified by your design. To do this, you must deploy domain controllers for each regional domain. The following illustration shows the process of deploying regional domains.  
  
![](../../media/AD-DS-Deployment-Requirements/89a878c8-9a94-4180-ad43-ca75316a6318.gif)  
  
For more information, see [Deploying Windows Server 2008 Regional Domains](Deploying-Windows-Server-2008-Regional-Domains.md).  
  
## Upgrading Active Directory domains to Windows Server 2008  
Upgrading your Windows 2000 or Windows Server 2003 domains to [!INCLUDE[nextref_longhorn]()] domains is an efficient, straightforward way to take advantage of additional [!INCLUDE[nextref_longhorn]()] features and functionality. You can upgrade domains to maintain your current network and domain configuration while improving the security, scalability, and manageability of your network infrastructure. Upgrading from Windows 2000 or Windows Server 2003 to [!INCLUDE[nextref_longhorn]()] requires minimal network configuration. Upgrading also has little impact on user operations. For more information, see [Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains]().  
  
## Restructuring AD DS domains  
When you restructure domains between [!INCLUDE[nextref_longhorn]()] forests \(interforest restructure\), you can reduce the number of domains in your environment and therefore reduce administrative complexity and overhead. When you migrate objects between forests as part of this restructuring process, both the source domain and target domain environments exist simultaneously. This makes it possible for you to roll back to the source environment during the migration, if necessary.  
  
When you restructure [!INCLUDE[nextref_longhorn]()] domains within a [!INCLUDE[nextref_longhorn]()] forest \(intraforest restructure\), you can consolidate your domain structure and therefore reduce administrative complexity and overhead. When you restructure domains within a forest, the migrated accounts no longer exist in the source domain.  
  
For more information about how to use the Active Directory Migration Tool \(ADMT\) version 3.1 \(ADMT v3.1\) to restructure domains, see ADMT v3.1 Migration Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93678](http://go.microsoft.com/fwlink/?LinkId=93678)\).  
  

