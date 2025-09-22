---
description: "Learn more about: Mapping Your Requirements to an AD DS Deployment Strategy"
title: Mapping Your Requirements to an AD DS Deployment Strategy
author: robinharwood
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# Mapping Your Requirements to an AD DS Deployment Strategy

After you finish reviewing and identifying the Active Directory Domain Services (AD DS) design and deployment requirements and you determine which of them are related to your specific deployment, you can map those requirements to a specific AD DS deployment strategy.

Use the following table to determine which AD DS deployment strategy maps to the appropriate combination of AD DS design and deployment requirements for your organization. ("Yes" means that a specific requirement is necessary for your deployment strategy; "No" means that a specific requirement is not necessary for your deployment strategy.)

This table refers only to the three primary AD DS deployment strategies as described in this guide:

-   [Deploying AD DS in a New Organization](../../ad-ds/plan/Deploying-AD-DS-in-a-New-Organization.md)

-   [Deploying AD DS in a Windows Server 2003 Organization](../../ad-ds/plan/Deploying-AD-DS-in-a-Windows-Server-2003-Organization.md)

-   [Deploying AD DS in a Windows 2000 Organization](../../ad-ds/plan/Deploying-AD-DS-in-a-Windows-2000-Organization.md)

However, you can create a hybrid or custom AD DS deployment strategy by using any combination of the AD DS design and deployment requirements to meet the needs of your organization.

| AD DS design and deployment requirements | Deploying AD DS in a New Organization | Deploying AD DS in a Windows Server 2003 Organization | Deploying AD DS in a Windows 2000 Organization |
| ---------------------------------------- | ------------------------------------- | ----------------------------------------------------- |----------------------------------------------- |
| [Designing the Logical Structure for Windows Server 2008 AD DS](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc770806(v=ws.10)) | Yes | Yes | Yes |
| [Designing the Site Topology for Windows Server 2008 AD DS](Designing-the-Site-Topology.md) | Yes | Yes | Yes |
| Planning Domain Controller Capacity | Yes | Yes | Yes |
| [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)) | Yes | No | No |
| [Deploying Windows Server 2008 Regional Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc755118(v=ws.10)) | Yes | Yes | Yes |
| [Enabling Advanced Features for AD DS](../../ad-ds/plan/Enabling-Advanced-Features-for-AD-DS.md) | Yes |Yes, but all domain controllers in the environment must run Windows Server 2008 before you set the domain or forest functional level to  Windows Server 2008. | Yes, but all domain controllers in the environment must run  Windows Server 2008  before you set the domain or forest functional level to Windows Server 2008. |
| [Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731188(v=ws.10)) | No | Yes | Yes |
| [ADMT Guide: Migrating and Restructuring Active Directory Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc974332(v=ws.10)) | Yes, if you want to migrate a pilot domain into your production environment, merge with another organization and consolidate the two information technology (IT) infrastructures, or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments. | Yes, if you want to merge with another organization and consolidate the two IT infrastructures or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments. | Yes, if you want to merge with another organization and consolidate the two IT infrastructures or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments. |
| [ADMT Guide: Migrating and Restructuring Active Directory Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc974332(v=ws.10)) | No | Yes, if you need to reduce the number of domains, reduce replication traffic and the amount of required user and group administration, or simplify the administration of Group Policy. | Yes, if you need to reduce the number of domains, reduce replication traffic and the amount of required user and group administration, or simplify the administration of Group Policy. |
