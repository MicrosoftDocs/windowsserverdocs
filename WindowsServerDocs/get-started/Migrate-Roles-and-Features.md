--- 
title: Migrating Roles and Features
description: Info on how to migrate roles and features to a newer version of Windows Server.
ms.prod: windows-server
ms.date: 08/28/2019
ms.technology: server-general
ms.topic: article
ms.assetid: 0f78ef4c-dd12-4b1b-8c6e-251dd803c5d1
author: jasongerend
ms.author: jgerend
manager: dougkim
ms.localizationpriority: medium
---
# Migrating roles and features in Windows Server

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This page contains links to information and tools that help guide you through the process of migrating roles and features to a newer version of Windows Server. You can migrate file servers and storage using [Storage Migration Service](../storage/storage-migration-service/overview.md), while many other roles and features can be migrated by using the Windows Server Migration Tools, a set of PowerShell cmdlets that were introduced in Windows Server 2008 R2 for migrating roles and features.

The migration guides support migrations of specified roles and features from one server to another (not in-place upgrades). Unless otherwise noted in the guides, migrations are supported between physical and virtual computers, and between full installation options of Windows Server and servers that are running the Server Core installation option.

## Before you begin

Before you begin migrating roles and features, verify that both source and destination servers are running the most current service packs that are available for their operating systems. 

> [!NOTE]
> Whenever you migrate or upgrade to any version of Windows Server, you should review and understand the [support lifecycle policy](https://support.microsoft.com/lifecycle) and timeframe for that version and plan accordingly. You can [search for the lifecycle information](https://support.microsoft.com/lifecycle) for the particular Windows Server release that you are interested in.

## Windows Server 2019

To migrate file servers and storage to Windows Server 2019 or Windows Server 2016, we recommend using [Storage Migration Service](../storage/storage-migration-service/overview.md). To migrate other roles, refer to the guidance for Windows Server 2016 and Windows Server 2012 R2.

## Windows Server 2016

Here are the migration guides for Windows Server 2016. Note that in many cases you can also use the Windows Server 2012 R2 migration guides.

- [Remote Desktop Services](https://technet.microsoft.com/windows-server-docs/compute/remote-desktop-services/migrate-rds-role-services)
- [Web Server (IIS)](https://www.iis.net/downloads/microsoft/web-deploy)
- [Windows Server Update Services](https://technet.microsoft.com/library/hh852339.aspx)
- [MultiPoint Services](https://technet.microsoft.com/windows-server-docs/compute/remote-desktop-services/multipoint-services/multipoint-services-migrate)

To migrate file servers to Windows Server 2019 or Windows Server 2016, we recommend using [Storage Migration Service](../storage/storage-migration-service/overview.md).

## Windows Server 2012 R2

Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, or Windows Server 2012 R2 to Windows Server 2012 R2. Windows Server Migration Tools in Windows Server 2012 R2 supports cross-subnet migrations.

- [Install, Use, and Remove Windows Server Migration Tools](https://technet.microsoft.com/library/jj134202.aspx)
- [Active Directory Certificate Services Migration Guide for Windows Server 2012 R2](https://technet.microsoft.com/library/dn486797.aspx)
- [Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2](https://technet.microsoft.com/library/dn486815.aspx)
- [Active Directory Rights Management Services Migration and Upgrade Guide](https://technet.microsoft.com/library/cc754277.aspx)
- [Migrate File and Storage Services to Windows Server 2012 R2](https://technet.microsoft.com/library/dn479292.aspx)
- [Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012](https://technet.microsoft.com/library/dn486799.aspx)
- [Migrate Network Policy Server to Windows Server 2012](https://technet.microsoft.com/library/hh831652)
- [Migrate Remote Desktop Services to Windows Server 2012 R2](https://technet.microsoft.com/library/dn479239.aspx)
- [Migrate Windows Server Update Services to Windows Server 2012 R2](https://technet.microsoft.com/library/hh852339.aspx)
- [Migrate Cluster Roles to Windows Server 2012 R2](https://technet.microsoft.com/library/dn530779.aspx)
- [Migrate DHCP Server to Windows Server 2012 R2](https://technet.microsoft.com/library/dn495425.aspx)

An e-book of Windows Server 2012 R2 and Windows Server 2012 migration guides is now available. For more information, and to download the e-book, see the [E-Book Gallery for Microsoft Technologies](https://social.technet.microsoft.com/wiki/contents/articles/11608.e-book-gallery-for-microsoft-technologies.aspx#MigrateRoles).

## Windows Server 2012

Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 to Windows Server 2012. Windows Server Migration Tools in Windows Server 2012 supports cross-subnet migrations.

- [Install, Use, and Remove Windows Server Migration Tools](https://technet.microsoft.com/library/jj134202)
- [Migrate Active Directory Federation Services Role Services to Windows Server 2012](https://technet.microsoft.com/library/jj647765)
- [Migrate Health Registration Authority to Windows Server 2012](https://technet.microsoft.com/library/hh831513)
- [Migrate Hyper-V to Windows Server 2012 from Windows Server 2008 R2](https://technet.microsoft.com/library/jj574113)
- [Migrate IP Configuration to Windows Server 2012](https://technet.microsoft.com/library/jj574133)
- [Migrate Network Policy Server to Windows Server 2012](https://technet.microsoft.com/library/hh831652)
- [Migrate Print and Document Services to Windows Server 2012](https://technet.microsoft.com/library/jj134150)
- [Migrate Remote Access to Windows Server 2012](https://technet.microsoft.com/library/hh831423)
- [Migrate Windows Server Update Services to Windows Server 2012](https://technet.microsoft.com/library/hh852339)
- [Upgrade Active Directory Domain Controllers to Windows Server 2012](https://technet.microsoft.com/library/hh994618.aspx)
- [Migrating Clustered Services and Applications to Windows Server 2012](https://technet.microsoft.com/library/dn486790.aspx)
 

For additional migration resources, visit [Migrate Roles and Features to Windows Server 2012](https://technet.microsoft.com/library/jj134039).

## Windows Server 2008 R2

Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2 to Windows Server 2008 R2. Windows Server Migration Tools in Windows Server 2008 R2 does not support cross-subnet migrations.

- [Windows Server Migration Tools Installation, Access, and Removal](https://technet.microsoft.com/library/dd379545)
- [Active Directory Certificate Services Migration Guide](https://technet.microsoft.com/library/ee126170)
- [Active Directory Domain Services and Domain Name System (DNS) Server Migration Guide](https://technet.microsoft.com/library/dd379558)
- [BranchCache Migration Guide](https://technet.microsoft.com/library/dd548365)
- [Dynamic Host Configuration Protocol (DHCP) Server Migration Guide](https://technet.microsoft.com/library/dd379535)
- [File Services Migration Guide](https://technet.microsoft.com/library/dd379487)
- [HRA Migration Guide](https://technet.microsoft.com/library/ee791829)
- [Hyper-V Migration Guide](https://technet.microsoft.com/library/ee849855)
- [IP Configuration Migration Guide](https://technet.microsoft.com/library/dd379537)
- [Local User and Group Migration Guide](https://technet.microsoft.com/library/dd379531)
- [NPS Migration Guide](https://technet.microsoft.com/library/ee791849)
- [Print Services Migration Guide](https://technet.microsoft.com/library/dd379488)
- [Remote Desktop Services Migration Guide](https://technet.microsoft.com/library/ff849223)
- [RRAS Migration Guide](https://technet.microsoft.com/library/ee822825)
- [Windows Server Migration Common Tasks and Information](https://technet.microsoft.com/library/ff400258)
- [Windows Server Update Services 3.0 SP2 Migration Guide](https://technet.microsoft.com/library/ee822826)
 
For additional migration resources, visit [Migrate Roles and Features to Windows Server 2008 R2](https://technet.microsoft.com/library/dd365353).
