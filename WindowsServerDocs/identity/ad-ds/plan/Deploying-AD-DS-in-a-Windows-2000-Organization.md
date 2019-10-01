---
ms.assetid: 7530cafe-98d7-46c9-95d9-e49d39caa021
title: Deploying AD DS in a Windows 2000 Organization
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Deploying AD DS in a Windows 2000 Organization

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

If your organization is currently running Windows 2000 Active Directory, you can deploy  Windows Server 2008  Active Directory Domain Services (AD DS) by either performing an in-place upgrade of some or all of your domain controllers' operating systems to  Windows Server 2008  or by introducing domain controllers running  Windows Server 2008  into your environment.  
  
Before you can add a domain controller running  Windows Server 2008  to an existing Windows 2000 Active Directory domain, you must run **adprep**, a command-line tool. Adprep extends the AD DS schema, updates default security descriptors of selected objects, and adds new directory objects as required by some applications. Adprep is available on the  Windows Server 2008  installation disk (\sources\adprep\adprep.exe). For more information, see Adprep ([https://go.microsoft.com/fwlink/?LinkId=99215](https://go.microsoft.com/fwlink/?LinkId=99215)).  
  
> [!NOTE]  
> If you want to perform an in-place upgrade of an existing Windows 2000 AD DS domain controller to  Windows Server 2008 , you must first upgrade the server to Windows Server 2003, and then upgrade it to  Windows Server 2008 .  
  
The following illustration shows the steps for deploying the  Windows Server 2008  AD DS in a network environment that is currently running Windows 2000 Active Directory.  
  
![deploying in a windows 2000 org](media/Deploying-AD-DS-in-a-Windows-2000-Organization/ee51218a-a858-49d9-8b99-9986679191c1.gif)  
  
> [!NOTE]  
> If you want to set the domain or forest functional level to  Windows Server 2008 , all domain controllers in your environment must run the  Windows Server 2008  operating system.  
  
Consolidating resource and account domains that are upgraded in place from a Windows 2000 environment as part of your  Windows Server 2008  AD DS deployment may require interforest or intraforest domain restructuring. Restructuring AD DS domains between forests helps you reduce the complexity of your organization and the associated administrative costs. Restructuring AD DS domains within a forest helps you to decrease the administrative overhead for your organization by reducing replication traffic, reducing the amount of user and group administration that is required, and simplifying the administration of Group Policy. For more information, see ADMT v3.1 Migration Guide ([https://go.microsoft.com/fwlink/?LinkId=93678](https://go.microsoft.com/fwlink/?LinkId=93678)).  
  
For a list of detailed tasks that you can use to plan and deploy AD DS in an organization that is currently running Windows 2000 Active Directory, see [Checklist: Deploying AD DS in a Windows 2000 Organization](https://technet.microsoft.com/library/cc732737.aspx).  
  


