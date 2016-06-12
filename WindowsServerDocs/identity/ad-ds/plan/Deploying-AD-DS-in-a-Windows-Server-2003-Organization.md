---
title: Deploying AD DS in a Windows Server 2003 Organization
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: a78d16ff-1ede-4789-abe0-9a897cfa003f
author: Femila
---
# Deploying AD DS in a Windows Server 2003 Organization
If your organization is currently running Windows Server 2003 Active Directory, you can deploy  Windows Server 2008  Active Directory Domain Services \(AD DS\) by either performing an in\-place upgrade of some or all of your domain controllers' operating systems to  Windows Server 2008  or by introducing domain controllers running  Windows Server 2008  into your environment.  
  
Before you can add a domain controller running  Windows Server 2008  to an existing Windows Server 2003 Active Directory domain, you must run **adprep**, a command\-line tool. Adprep extends the AD DS schema, updates default security descriptors of selected objects, and adds new directory objects as required by some applications. Adprep is available on the  Windows Server 2008  installation disk \(\\sources\\adprep\\adprep.exe\). For more information, see Adprep \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=99215](http://go.microsoft.com/fwlink/?LinkId=99215)\).  
  
The following illustration shows the steps for deploying  Windows Server 2008  AD DS in a network environment that is currently running Windows Server 2003 Active Directory.  
  
![](media/900c4eee-1119-4a9a-9310-755597428b71.gif)  
  
> [!NOTE]  
> If you want to set the domain or forest functional level to  Windows Server 2008 , all domain controllers in your environment must run the  Windows Server 2008  operating system.  
  
Consolidating resource domains and account domains that are upgraded in place from a Windows Server 2003 environment as part of your  Windows Server 2008  AD DS deployment may require interforest or intraforest domain restructuring. Restructuring AD DS domains between forests helps you reduce the complexity of the representation of your organization in AD DS, and it helps reduce the associated administrative costs. Restructuring AD DS domains within a forest helps you decrease the administrative overhead for your organization by reducing replication traffic, reducing the amount of user and group administration that is required, and simplifying the administration of Group Policy. For more information, see ADMT v3.1 Migration Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93678](http://go.microsoft.com/fwlink/?LinkId=93678)\).  
  
For a list of detailed tasks that you can use to plan and deploy AD DS in an organization that is running Windows Server 2003 Active Directory, see [Checklist: Deploying AD DS in a Windows Server 2003 Organization](Checklist--Deploying-AD-DS-in-a-Windows-Server-2003-Organization.md).  
  

