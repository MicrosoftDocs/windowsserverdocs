---
ms.assetid: f6e76ef0-2217-4cdb-980f-22a780a85ebb
title: AD DS Design Requirements
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# AD DS Design Requirements

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

  
## Designing the Active Directory logical structure  
Before you deploy  Windows Server 2008  Active Directory Domain Services (AD DS), you must plan for and design the AD DS logical structure for your environment. The AD DS logical structure determines how your directory objects are organized, and it provides an effective method for managing your network accounts and shared resources. When you design your AD DS logical structure, you define a significant part of the network infrastructure of your organization.  
  
To design the AD DS logical structure, determine the number of forests that your organization requires, and then create designs for domains, Domain Name System (DNS) infrastructure, and organizational units (OUs). The following illustration shows the process for designing the logical structure.  
  
![AD DS design requirements](media/AD-DS-Design-Requirements/d5cebae6-a752-4063-a98f-473799c251bd.gif)  
  
For more information, see [Designing the Logical Structure for Windows Server 2008 AD DS](Designing-the-Logical-Structure.md).  
  
## Designing the site topology  
After you design the logical structure for your AD DS infrastructure, you must design the site topology for your network. The site topology is a logical representation of your physical network. It contains information about the location of AD DS sites, the AD DS domain controllers within each site, and the site links and site link bridges that support AD DS replication between sites. The following illustration shows the site topology design process.  
  
![AD DS design requirements](media/AD-DS-Design-Requirements/d34d43c0-437f-47cb-9b64-09c0f9ce6479.gif)  
  
For more information, see [Designing the Site Topology for Windows Server 2008 AD DS](Designing-the-Site-Topology.md).  
  
## Planning domain controller capacity  
To ensure efficient AD DS performance, you must determine the appropriate number of domain controllers for each site and verify that they meet the hardware requirements for  Windows Server 2008 . Careful capacity planning for your domain controllers ensures that you do not underestimate hardware requirements, which can cause poor domain controller performance and application response time. The following illustration shows the process of domain controller capacity planning.  
  
![AD DS design requirements](media/AD-DS-Design-Requirements/fff6ef22-5c7b-4478-ad76-42b296dcf769.gif)  
  
## Enabling Windows Server 2008 advanced AD DS features  
You can use  Windows Server 2008  AD DS to introduce advanced features into your environment by raising the domain or forest functional level. You can raise the functional level to  Windows Server 2008  when all domain controllers in the domain or forest are running  Windows Server 2008 .  
  
For more information, see [Enabling Advanced Features for AD DS](../../ad-ds/plan/Enabling-Advanced-Features-for-AD-DS.md).  
  


