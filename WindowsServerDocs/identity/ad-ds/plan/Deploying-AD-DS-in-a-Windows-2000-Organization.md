---
title: Deploying AD DS in a Windows 2000 Organization
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: identity-adds
ms.author: markvi
  
ms.tgt_pltfrm: na
ms.assetid: ebb27121-a7cf-4ba8-9ce6-c6564062433d
author: Femila
---
# Deploying AD DS in a Windows 2000 Organization

>Applies To: Windows Server Technical Preview

If your organization is currently running Windows 2000 Active Directory, you can deploy  Windows Server 2008  Active Directory Domain Services (AD DS) by either performing an in-place upgrade of some or all of your domain controllers' operating systems to  Windows Server 2008  or by introducing domain controllers running  Windows Server 2008  into your environment.  
  
Before you can add a domain controller running  Windows Server 2008  to an existing Windows 2000 Active Directory domain, you must run **adprep**, a command-line tool. Adprep extends the AD DS schema, updates default security descriptors of selected objects, and adds new directory objects as required by some applications. Adprep is available on the  Windows Server 2008  installation disk (\sources\adprep\adprep.exe). For more information, see Adprep ([http://go.microsoft.com/fwlink/?LinkId=99215](http://go.microsoft.com/fwlink/?LinkId=99215)).  
  
> [!NOTE]  
> If you want to perform an in-place upgrade of an existing Windows 2000 AD DS domain controller to  Windows Server 2008 , you must first upgrade the server to Windows Server 2003, and then upgrade it to  Windows Server 2008 .  
  
The following illustration shows the steps for deploying the  Windows Server 2008  AD DS in a network environment that is currently running Windows 2000 Active Directory.  
  
![](media/Deploying-AD-DS-in-a-Windows-2000-Organization/ee51218a-a858-49d9-8b99-9986679191c1.gif)  
  
> [!NOTE]  
> If you want to set the domain or forest functional level to  Windows Server 2008 , all domain controllers in your environment must run the  Windows Server 2008  operating system.  
  
Consolidating resource and account domains that are upgraded in place from a Windows 2000 environment as part of your  Windows Server 2008  AD DS deployment may require interforest or intraforest domain restructuring. Restructuring AD DS domains between forests helps you reduce the complexity of your organization and the associated administrative costs. Restructuring AD DS domains within a forest helps you to decrease the administrative overhead for your organization by reducing replication traffic, reducing the amount of user and group administration that is required, and simplifying the administration of Group Policy. For more information, see ADMT v3.1 Migration Guide ([http://go.microsoft.com/fwlink/?LinkId=93678](http://go.microsoft.com/fwlink/?LinkId=93678)).  
  
For a list of detailed tasks that you can use to plan and deploy AD DS in an organization that is currently running Windows 2000 Active Directory, see [Checklist: Deploying AD DS in a Windows 2000 Organization](https://technet.microsoft.com/library/cc732737.aspx).  
  


