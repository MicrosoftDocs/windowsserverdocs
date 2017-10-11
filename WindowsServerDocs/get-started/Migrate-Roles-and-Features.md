--- 
title: Migrating Roles and Features
description: 
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.date: 04/03/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0f78ef4c-dd12-4b1b-8c6e-251dd803c5d1
author: jaimeo
ms.author: jaimeo
manager: elizapo
---
# Migrating Roles and Features in Windows Server

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This page contains links to information and tools that help guide you through the process of migrating roles and features to Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012. Many roles and features can be migrated by using Windows Server Migration Tools, a set of five Windows PowerShell cmdlets that was introduced in Windows Server 2008 R2 for easily migrating role and feature elements and data.

The migration guides support migrations of specified roles and features from one server to another (not in-place upgrades). Unless otherwise noted in the guides, migrations are supported between physical and virtual computers, and between full installation options of Windows Server and servers that are running the Server Core installation option.  

## Before you begin

Before you begin migrating roles and features, verify that both source and destination servers are running the most current service packs that are available for their operating systems.
An e-book of Windows Server 2012 R2 and Windows Server 2012 migration guides is now available. For more information, and to download the e-book, see the [E-Book Gallery for Microsoft Technologies](https://social.technet.microsoft.com/wiki/contents/articles/11608.e-book-gallery-for-microsoft-technologies.aspx#MigrateRoles). Windows Server Migration Guides are also available as part of the PDF download, [Windows Server 2012 R2 and Windows Server 2012 TechNet Library Documentation](https://www.microsoft.com/download/details.aspx?id=41182), available on the Microsoft Download Center.

>[!NOTE]
>Whenever you migrate or upgrade to any version of Windows Server, you should review and understand the [support lifecycle policy](https://support.microsoft.com/lifecycle) and timeframe for that version and plan accordingly. You can [search for the lifecycle information](https://support.microsoft.com/lifecycle) for the particular Windows Server release that you are interested in.
 
## Windows Server 2016

### Migration Guides
Updated migration guides for Windows Server 2016 are under development. Check back at this location for updates as they become available. In many cases, the steps in the Windows Server 2012 R2 migration guides are still relevant for Windows Server 2016.

- [Remote Desktop Services](../remote/remote-desktop-services/migrate-rds-role-services.md)
- [Web Server (IIS)](https://iis.net/downloads/microsoft/web-deploy)
- [Windows Server Update Services](https://technet.microsoft.com/en-us/library/hh852339(v=ws.11).aspx)
- [MultiPoint Services](../remote/multipoint-services/multipoint-services-migrate.md)
 
## Windows Server 2012 R2

### Migration Guides
Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, or Windows Server 2012 R2 to Windows Server 2012 R2. Windows Server Migration Tools in Windows Server 2012 R2 supports cross-subnet migrations.

- [Install, Use, and Remove Windows Server Migration Tools](https://technet.microsoft.com/en-us/library/jj134202(v=ws.11).aspx)
- [Active Directory Certificate Services Migration Guide for Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn486797(v=ws.11).aspx)
- [Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn486815(v=ws.11).aspx)
- [Active Directory Rights Management Services Migration and Upgrade Guide](https://technet.microsoft.com/en-us/library/cc754277(v=ws.10).aspx)
- [Migrate File and Storage Services to Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn479292(v=ws.11).aspx)
- [Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012](https://technet.microsoft.com/en-us/library/dn486799(v=ws.11).aspx)
- [Migrate Network Policy Server to Windows Server 2012](https://technet.microsoft.com/en-us/library/hh831652(v=ws.11).aspx)
- [Migrate Remote Desktop Services to Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn479239(v=ws.11).aspx)
- [Migrate Windows Server Update Services to Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/hh852339(v=ws.11).aspx)
- [Migrate Cluster Roles to Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn530779(v=ws.11).aspx)
- [Migrate DHCP Server to Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn495425(v=ws.11).aspx)
 
## Windows Server 2012

### Migration Guides
Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 to Windows Server 2012. Windows Server Migration Tools in Windows Server 2012 supports cross-subnet migrations.

- [Install, Use, and Remove Windows Server Migration Tools](https://technet.microsoft.com/en-us/library/jj134202(v=ws.11).aspx)
- [Migrate Active Directory Federation Services Role Services to Windows Server 2012](../identity/ad-fs/deployment/migrate-ad-fs-role-services-to-windows-server-2012.md)
- [Migrate Health Registration Authority to Windows Server 2012](https://technet.microsoft.com/en-us/library/hh831513(v=ws.11).aspx)
- [Migrate Hyper-V to Windows Server 2012 from Windows Server 2008 R2](https://technet.microsoft.com/en-us/library/jj574113(v=ws.11).aspx)
- [Migrate IP Configuration to Windows Server 2012](https://technet.microsoft.com/en-us/library/jj574133(v=ws.11).aspx)
- [Migrate Network Policy Server to Windows Server 2012](https://technet.microsoft.com/en-us/library/hh831652(v=ws.11).aspx)
- [Migrate Print and Document Services to Windows Server 2012](https://technet.microsoft.com/en-us/library/jj134150(v=ws.11).aspx)
- [Migrate Remote Access to Windows Server 2012](https://technet.microsoft.com/en-us/library/hh831423(v=ws.11).aspx)
- [Migrate Windows Server Update Services to Windows Server 2012](https://technet.microsoft.com/en-us/library/hh852339(v=ws.11).aspx)
- [Upgrade Active Directory Domain Controllers to Windows Server 2012](../identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012.md)
- [Migrating Clustered Services and Applications to Windows Server 2012](https://technet.microsoft.com/en-us/library/dn486790(v=ws.11).aspx)
 

For additional migration resources, visit [Migrate Roles and Features to Windows Server 2012](https://technet.microsoft.com/en-us/library/jj134039(v=ws.11).aspx).

## Windows Server 2008 R2

### Migration Guides
Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2 to Windows Server 2008 R2. Windows Server Migration Tools in Windows Server 2008 R2 does not support cross-subnet migrations.

- [Windows Server Migration Tools Installation, Access, and Removal](https://technet.microsoft.com/en-us/library/dd379545(v=ws.10).aspx)
- [Active Directory Certificate Services Migration Guide](https://technet.microsoft.com/en-us/library/ee126170(v=ws.10).aspx)
- [Active Directory Domain Services and Domain Name System (DNS) Server Migration Guide](https://technet.microsoft.com/en-us/library/dd379558(v=ws.10).aspx)
- [BranchCache Migration Guide](https://technet.microsoft.com/en-us/library/dd548365(v=ws.10).aspx)
- [Dynamic Host Configuration Protocol (DHCP) Server Migration Guide](https://technet.microsoft.com/en-us/library/dd379535(v=ws.10).aspx)
- [File Services Migration Guide](https://technet.microsoft.com/en-us/library/dd379487(v=ws.10).aspx)
- [HRA Migration Guide](https://technet.microsoft.com/en-us/library/ee791829(v=ws.10).aspx)
- [Hyper-V Migration Guide](https://technet.microsoft.com/en-us/library/ee849855(v=ws.10).aspx)
- [IP Configuration Migration Guide](https://technet.microsoft.com/en-us/library/dd379537(v=ws.10).aspx)
- [Local User and Group Migration Guide](https://technet.microsoft.com/en-us/library/dd379531(v=ws.10).aspx)
- [NPS Migration Guide](https://technet.microsoft.com/en-us/library/ee791849(v=ws.10).aspx)
- [Print Services Migration Guide](https://technet.microsoft.com/en-us/library/dd379488(v=ws.10).aspx)
- [Remote Desktop Services Migration Guide](https://technet.microsoft.com/en-us/library/ff849223(v=ws.10).aspx)
- [RRAS Migration Guide](https://technet.microsoft.com/en-us/library/ee822825(v=ws.10).aspx)
- [Windows Server Migration Common Tasks and Information](https://technet.microsoft.com/en-us/library/ff400258(v=ws.10).aspx)
- [Windows Server Update Services 3.0 SP2 Migration Guide](https://technet.microsoft.com/en-us/library/ee822826(v=ws.10).aspx)
 
For additional migration resources, visit [Migrate Roles and Features to Windows Server 2008 R2](https://technet.microsoft.com/en-us/library/dd365353(v=ws.10).aspx).
