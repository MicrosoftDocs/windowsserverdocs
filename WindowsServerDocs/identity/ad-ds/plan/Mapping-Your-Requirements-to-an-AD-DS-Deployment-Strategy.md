---
ms.assetid: ce3be131-06ad-41dc-a26b-1168fa68c8ed
title: Mapping Your Requirements to an AD DS Deployment Strategy
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Mapping Your Requirements to an AD DS Deployment Strategy

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

After you finish reviewing and identifying the Active Directory Domain Services (AD DS) design and deployment requirements and you determine which of them are related to your specific deployment, you can map those requirements to a specific AD DS deployment strategy.  
  
Use the following table to determine which AD DS deployment strategy maps to the appropriate combination of AD DS design and deployment requirements for your organization. ("Yes" means that a specific requirement is necessary for your deployment strategy; "No" means that a specific requirement is not necessary for your deployment strategy.)  
  
This table refers only to the three primary AD DS deployment strategies as described in this guide:  
  
-   [Deploying AD DS in a New Organization](../../ad-ds/plan/Deploying-AD-DS-in-a-New-Organization.md)  
  
-   [Deploying AD DS in a Windows Server 2003 Organization](../../ad-ds/plan/Deploying-AD-DS-in-a-Windows-Server-2003-Organization.md)  
  
-   [Deploying AD DS in a Windows 2000 Organization](../../ad-ds/plan/Deploying-AD-DS-in-a-Windows-2000-Organization.md)  
  
However, you can create a hybrid or custom AD DS deployment strategy by using any combination of the AD DS design and deployment requirements to meet the needs of your organization.  
  
|AD DS design and deployment requirements|Deploying AD DS in a New Organization|Deploying AD DS in a Windows Server 2003 Organization|Deploying AD DS in a Windows 2000 Organization|  
|--------------------------------------------|-----------------------------------------|---------------------------------------------------------|--------------------------------------------------|  
|[Designing the Logical Structure for Windows Server 2008 AD DS](https://technet.microsoft.com/library/cc770806.aspx)|Yes|Yes|Yes|  
|[Designing the Site Topology for Windows Server 2008 AD DS](Designing-the-Site-Topology.md)|Yes|Yes|Yes|  
|Planning Domain Controller Capacity|Yes|Yes|Yes|  
|[Deploying a Windows Server 2008 Forest Root Domain](https://technet.microsoft.com/library/cc731174.aspx)|Yes|No|No|  
|[Deploying Windows Server 2008 Regional Domains](https://technet.microsoft.com/library/cc755118.aspx)|Yes|Yes|Yes|  
|[Enabling Advanced Features for AD DS](../../ad-ds/plan/Enabling-Advanced-Features-for-AD-DS.md)|Yes|Yes, but all domain controllers in the environment must run  Windows Server 2008  before you set the domain or forest functional level to  Windows Server 2008 .|Yes, but all domain controllers in the environment must run  Windows Server 2008  before you set the domain or forest functional level to  Windows Server 2008 .|  
|[Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](https://technet.microsoft.com/library/cc731188.aspx)|No|Yes|Yes|  
|[Restructuring AD DS Domains Between Forests](https://go.microsoft.com/fwlink/?LinkId=93678)|Yes, if you want to migrate a pilot domain into your production environment, merge with another organization and consolidate the two information technology (IT) infrastructures, or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments.|Yes, if you want to merge with another organization and consolidate the two IT infrastructures or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments.|Yes, if you want to merge with another organization and consolidate the two IT infrastructures or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments.|  
|[Restructuring AD DS Domains Within Forests](https://go.microsoft.com/fwlink/?LinkId=82740))|No|Yes, if you need to reduce the number of domains, reduce replication traffic and the amount of required user and group administration, or simplify the administration of Group Policy.|Yes, if you need to reduce the number of domains, reduce replication traffic and the amount of required user and group administration, or simplify the administration of Group Policy.|  
  


