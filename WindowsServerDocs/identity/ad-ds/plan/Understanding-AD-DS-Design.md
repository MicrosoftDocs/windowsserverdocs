---
title: Understanding AD DS Design
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: identity-adds
ms.author: markvi
  
ms.tgt_pltfrm: na
ms.assetid: 9ef87047-a095-4499-8e56-ee57f926b4a6
author: Femila
---
# Understanding AD DS Design

>Applies To: Windows Server Technical Preview

Organizations can use Active Directory Domain Services (AD DS) in  Windows Server 2008  to simplify user and resource management while creating scalable, secure, and manageable infrastructures. You can use AD DS to manage your network infrastructure, including branch office, Microsoft Exchange Server, and multiple forest environments.  
  
An AD DS deployment project involves three phases: a design phase, a deployment phase, and an operations phase. During the design phase, the design team creates a design for the AD DS logical structure that best meets the needs of each division in the organization that will use the directory service. After the design is approved, the deployment team tests the design in a lab environment and then implements the design in the production environment. Because testing is performed by the deployment team and it potentially affects the design phase, it is an interim activity that overlaps both design and deployment. When the deployment is complete, the operations team is responsible for maintaining the directory service.  
  
Although the  Windows Server 2008  AD DS design and deployment strategies that are presented in this guide are based on extensive lab and pilot-program testing and successful implementation in customer environments, you might have to customize your AD DS design and deployment to better suit specific, complex environments.  
  
-   For more information about deploying AD DS in a branch office environment, see the Read-Only Domain Controller (RODC) Branch Office Planning Guide ([http://go.microsoft.com/fwlink/?LinkId=100207](http://go.microsoft.com/fwlink/?LinkId=100207)).  
  
-   For more information about deploying AD DS in an Exchange environment, see Exchange 2007 - Planning Active Directory ([http://go.microsoft.com/fwlink/?LinkId=88904](http://go.microsoft.com/fwlink/?LinkId=88904)).  
  
-   For more information about deploying AD DS in a multiple forest environment, see Multiple Forest Considerations in Windows 2000 and Windows Server 2003 ([http://go.microsoft.com/fwlink/?LinkId=88905](http://go.microsoft.com/fwlink/?LinkId=88905)).  
  


