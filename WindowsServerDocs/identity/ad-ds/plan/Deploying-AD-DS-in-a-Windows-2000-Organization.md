---
description: "Learn more about: Deploying AD DS in a Windows 2000 Organization"
title: Deploying AD DS in a Windows 2000 Organization
author: robinharwood
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# Deploying AD DS in a Windows 2000 Organization

If your organization is currently running Windows 2000 Active Directory, you can deploy  Windows Server 2008  Active Directory Domain Services (AD DS) by either performing an in-place upgrade of some or all of your domain controllers' operating systems to  Windows Server 2008  or by introducing domain controllers running  Windows Server 2008  into your environment.

Before you can add a domain controller running  Windows Server 2008  to an existing Windows 2000 Active Directory domain, you must run **adprep**, a command-line tool. Adprep extends the AD DS schema, updates default security descriptors of selected objects, and adds new directory objects as required by some applications. Adprep is available on the  Windows Server 2008  installation disk (\sources\adprep\adprep.exe). For more information, see [Adprep](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731728(v=ws.11)).

> [!NOTE]
> If you want to perform an in-place upgrade of an existing Windows 2000 AD DS domain controller to  Windows Server 2008 , you must first upgrade the server to Windows Server 2003, and then upgrade it to  Windows Server 2008 .

The following illustration shows the steps for deploying the  Windows Server 2008  AD DS in a network environment that is currently running Windows 2000 Active Directory.

![deploying in a windows 2000 org](media/Deploying-AD-DS-in-a-Windows-2000-Organization/ee51218a-a858-49d9-8b99-9986679191c1.gif)

> [!NOTE]
> If you want to set the domain or forest functional level to  Windows Server 2008 , all domain controllers in your environment must run the  Windows Server 2008  operating system.

Consolidating resource and account domains that are upgraded in place from a Windows 2000 environment as part of your  Windows Server 2008  AD DS deployment may require interforest or intraforest domain restructuring. Restructuring AD DS domains between forests helps you reduce the complexity of your organization and the associated administrative costs. Restructuring AD DS domains within a forest helps you to decrease the administrative overhead for your organization by reducing replication traffic, reducing the amount of user and group administration that is required, and simplifying the administration of Group Policy. For more information, see [ADMT Guide: Migrating and Restructuring Active Directory Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc974332(v=ws.10)).

For a list of detailed tasks that you can use to plan and deploy AD DS in an organization that is currently running Windows 2000 Active Directory, see [Checklist: Deploying AD DS in a Windows 2000 Organization](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732737(v=ws.10)).
