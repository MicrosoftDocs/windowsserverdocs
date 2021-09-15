---
title: Migrating Roles and Features
description: Info on how to migrate roles and features to a newer version of Windows Server.
ms.date: 08/28/2019
ms.topic: article
ms.assetid: 0f78ef4c-dd12-4b1b-8c6e-251dd803c5d1
author: jasongerend
ms.author: jgerend
manager: dougkim
ms.localizationpriority: medium
---
# Migrating roles and features in Windows Server

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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

- [Remote Desktop Services](../remote/remote-desktop-services/migrate-rds-role-services.md)
- [Web Server (IIS)](https://www.iis.net/downloads/microsoft/web-deploy)
- [Windows Server Update Services](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh852339(v=ws.11))
- [MultiPoint Services](../remote/multipoint-services/multipoint-services-migrate.md)

To migrate file servers to Windows Server 2019 or Windows Server 2016, we recommend using [Storage Migration Service](../storage/storage-migration-service/overview.md).

## Windows Server 2012 R2

Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, or Windows Server 2012 R2 to Windows Server 2012 R2. Windows Server Migration Tools in Windows Server 2012 R2 supports cross-subnet migrations.

- [Install, Use, and Remove Windows Server Migration Tools](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11))
- [Active Directory Certificate Services Migration Guide for Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486797(v=ws.11))
- [Migrating Active Directory Federation Services Role Service to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486815(v=ws.11))
- [Active Directory Rights Management Services Migration and Upgrade Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754277(v=ws.10))
- [Migrate File and Storage Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn479292(v=ws.11))
- [Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486799(v=ws.11))
- [Migrate Network Policy Server to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831652(v=ws.11))
- [Migrate Remote Desktop Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn479239(v=ws.11))
- [Migrate Windows Server Update Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh852339(v=ws.11))
- [Migrate Cluster Roles to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn530779(v=ws.11))
- [Migrate DHCP Server to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn495425(v=ws.11))

An e-book of Windows Server 2012 R2 and Windows Server 2012 migration guides is now available. For more information, and to download the e-book, see the [E-Book Gallery for Microsoft Technologies](https://download.microsoft.com/download/8/D/3/8D33661A-7E21-4FEE-9AAA-C17C3004B5AA/Windows-Migration-and-Upgrade-Guide.pdf).

## Windows Server 2012

Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, or Windows Server 2012 to Windows Server 2012. Windows Server Migration Tools in Windows Server 2012 supports cross-subnet migrations.

- [Install, Use, and Remove Windows Server Migration Tools](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11))
- [Migrate Active Directory Federation Services Role Services to Windows Server 2012](../identity/ad-fs/deployment/migrate-ad-fs-role-services-to-windows-server-2012.md)
- [Migrate Health Registration Authority to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831513(v=ws.11))
- [Migrate Hyper-V to Windows Server 2012 from Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574113(v=ws.11))
- [Migrate IP Configuration to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574133(v=ws.11))
- [Migrate Network Policy Server to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831652(v=ws.11))
- [Migrate Print and Document Services to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134150(v=ws.11))
- [Migrate Remote Access to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831423(v=ws.11))
- [Migrate Windows Server Update Services to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh852339(v=ws.11))
- [Upgrade Active Directory Domain Controllers to Windows Server 2012](../identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012.md)
- [Migrating Clustered Services and Applications to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486790(v=ws.11))


For additional migration resources, visit [Migrate Roles and Features to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134039(v=ws.11)).

## Windows Server 2008 R2

Follow the steps in these guides to migrate roles and features from servers that are running Windows Server 2003, Windows Server 2008, or Windows Server 2008 R2 to Windows Server 2008 R2. Windows Server Migration Tools in Windows Server 2008 R2 does not support cross-subnet migrations.

- [Windows Server Migration Tools Installation, Access, and Removal](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379545(v=ws.10))
- [Active Directory Certificate Services Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee126170(v=ws.10))
- [Active Directory Domain Services and Domain Name System (DNS) Server Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379558(v=ws.10))
- [BranchCache Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd548365(v=ws.10))
- [Dynamic Host Configuration Protocol (DHCP) Server Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379535(v=ws.10))
- [File Services Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379487(v=ws.10))
- [HRA Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791829(v=ws.10))
- [Hyper-V Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee849855(v=ws.10))
- [IP Configuration Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379537(v=ws.10))
- [Local User and Group Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379531(v=ws.10))
- [NPS Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee791849(v=ws.10))
- [Print Services Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379488(v=ws.10))
- [Remote Desktop Services Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff849223(v=ws.10))
- [RRAS Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee822825(v=ws.10))
- [Windows Server Migration Common Tasks and Information](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff400258(v=ws.10))
- [Windows Server Update Services 3.0 SP2 Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee822826(v=ws.10))

For additional migration resources, visit [Migrate Roles and Features to Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd365353(v=ws.10)).
