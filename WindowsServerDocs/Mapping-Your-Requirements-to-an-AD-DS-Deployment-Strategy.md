---
title: Mapping Your Requirements to an AD DS Deployment Strategy
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: bf5da04d-c247-40cc-a77d-95a41343a7a8
---
# Mapping Your Requirements to an AD DS Deployment Strategy
After you finish reviewing and identifying the Active Directory Domain Services \(AD DS\) design and deployment requirements and you determine which of them are related to your specific deployment, you can map those requirements to a specific AD DS deployment strategy.

Use the following table to determine which AD DS deployment strategy maps to the appropriate combination of AD DS design and deployment requirements for your organization. \("Yes" means that a specific requirement is necessary for your deployment strategy; "No" means that a specific requirement is not necessary for your deployment strategy.\)

This table refers only to the three primary AD DS deployment strategies as described in this guide:

-   [Deploying AD DS in a New Organization](Deploying-AD-DS-in-a-New-Organization.md)

-   [Deploying AD DS in a Windows Server 2003 Organization](Deploying-AD-DS-in-a-Windows-Server-2003-Organization.md)

-   [Deploying AD DS in a Windows 2000 Organization](Deploying-AD-DS-in-a-Windows-2000-Organization.md)

However, you can create a hybrid or custom AD DS deployment strategy by using any combination of the AD DS design and deployment requirements to meet the needs of your organization.

|AD DS design and deployment requirements|Deploying AD DS in a New Organization|Deploying AD DS in a Windows Server 2003 Organization|Deploying AD DS in a Windows 2000 Organization|
|--------------------------------------------|-----------------------------------------|---------------------------------------------------------|--------------------------------------------------|
|[Designing the Logical Structure for Windows Server 2008 AD DS](Designing-the-Logical-Structure-for-Windows-Server-2008-AD-DS.md)|Yes|Yes|Yes|
|[Designing the Site Topology for Windows Server 2008 AD DS](Designing-the-Site-Topology-for-Windows-Server-2008-AD-DS.md)|Yes|Yes|Yes|
|Planning Domain Controller Capacity|Yes|Yes|Yes|
|[Deploying a Windows Server 2008 Forest Root Domain](Deploying-a-Windows-Server-2008-Forest-Root-Domain.md)|Yes|No|No|
|[Deploying Windows Server 2008 Regional Domains](Deploying-Windows-Server-2008-Regional-Domains.md)|Yes|Yes|Yes|
|[Enabling Advanced Features for AD DS](Enabling-Advanced-Features-for-AD-DS.md)|Yes|Yes, but all domain controllers in the environment must run [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] before you set the domain or forest functional level to [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)].|Yes, but all domain controllers in the environment must run [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)] before you set the domain or forest functional level to [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)].|
|[Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](Upgrading-Active-Directory-Domains-to-Windows-Server-2008-and-Windows-Server-2008-R2-AD-DS-Domains.md)|No|Yes|Yes|
|Restructuring AD DS Domains Between Forests \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93678](http://go.microsoft.com/fwlink/?LinkId=93678)\)|Yes, if you want to migrate a pilot domain into your production environment, merge with another organization and consolidate the two information technology \(IT\) infrastructures, or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments.|Yes, if you want to merge with another organization and consolidate the two IT infrastructures or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments.|Yes, if you want to merge with another organization and consolidate the two IT infrastructures or consolidate resource and account domains that you upgraded in place from Windows 2000 or Windows Server 2003 environments.|
|Restructuring AD DS Domains Within Forests \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=82740](http://go.microsoft.com/fwlink/?LinkId=82740)\)|No|Yes, if you need to reduce the number of domains, reduce replication traffic and the amount of required user and group administration, or simplify the administration of Group Policy.|Yes, if you need to reduce the number of domains, reduce replication traffic and the amount of required user and group administration, or simplify the administration of Group Policy.|


