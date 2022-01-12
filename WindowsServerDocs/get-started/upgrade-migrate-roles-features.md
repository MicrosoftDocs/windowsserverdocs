---
title: Migrating roles and features in Windows Server
description: Information on how to migrate roles and features to a later version of Windows Server.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 11/22/2021
ms.prod: windows-server
ms.assetid: 0f78ef4c-dd12-4b1b-8c6e-251dd803c5d1
---

# Upgrade and migrate roles and features in Windows Server

You can update roles and features to later versions of Windows Server by migrating to a new server,  or many also support in-place upgrade where you install the new version of Windows Server over the top of the current one. This article contains links to migration guides as well a table with migration and in-place upgrade information to help you decide which method to use.

You can migrate many roles and features by using Windows Server Migration Tools, a feature built in to Windows Server for migrating roles and features, whereas file servers and storage can be migrated using [Storage Migration Service](../storage/storage-migration-service/overview.md).

The migration guides support migrations of specified roles and features from one server to another (not in-place upgrades). Unless otherwise noted in the guides, migrations are supported between physical and virtual computers, and between installation options of Windows Server with either Server with Desktop Experience or Server Core.

> [!IMPORTANT]
> Before you begin migrating roles and features, verify that both source and destination servers are running the most current updates that are available for their operating systems.
>
> Whenever you migrate or upgrade to any version of Windows Server, you should review and understand the [support lifecycle policy](https://support.microsoft.com/lifecycle) and time frame for that version and plan accordingly. You can [search for the lifecycle information](https://support.microsoft.com/lifecycle) for the particular Windows Server release that you are interested in.

## Windows Server Migration Tools

Windows Server Migration Tools enables you to migrate server roles, features, operating system settings, and other data and shares to servers, including later versions of Windows Server. It is a feature of Windows Server and so it is easily installed using the Add Roles and Features wizard, or PowerShell. Learn more about how to [install, use, and remove Windows Server Migration Tools](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11)).

> [!NOTE]
> Cross-subnet migrations using Windows Server Migration Tools is available with Windows Server 2012 and later releases. Previous versions of Windows Server Migration Tools only support migrations in the same subnet.

## Migration guides

Below you can find links to migration guides for specific Windows Roles and Features.

### Active Directory

- [Active Directory Certificate Services Migration Guide for Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486797(v=ws.11))
- [Active Directory Certificate Services Migration Guide for Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee126170(v=ws.10))
- [Migrate Active Directory Federation Services Role Service to Windows Server 2012 R2](../identity/ad-fs/deployment/migrate-ad-fs-service-role-to-windows-server-r2.md)
- [Migrate Active Directory Federation Services Role Services to Windows Server 2012](../identity/ad-fs/deployment/migrate-ad-fs-role-services-to-windows-server-2012.md)
- [Active Directory Rights Management Services Migration and Upgrade Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754277(v=ws.10))
- [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](../identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012.md)
- [Active Directory Domain Services and Domain Name System (DNS) Server Migration Guide for Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379558(v=ws.10))

### BranchCache

- [BranchCache Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd548365(v=ws.10))

### DHCP

- [Migrate DHCP Server to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn495425(v=ws.11))
- [Dynamic Host Configuration Protocol (DHCP) Server Migration Guide for Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379535(v=ws.10))

### Failover Clustering

- [Migrate Cluster Roles to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn530779(v=ws.11))
- [Migrate Clustered Services and Applications to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486790(v=ws.11))

### File and Storage Services

- [Storage Migration Service](../storage/storage-migration-service/overview.md)
- [Migrate File and Storage Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn479292(v=ws.11))

### Hyper-V

- [Migrate Hyper-V to Windows Server 2012 R2 from Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486799(v=ws.11))
- [Migrate Hyper-V to Windows Server 2012 from Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj574113(v=ws.11))

### Network Policy Server

- [Migrate Network Policy Server to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831652(v=ws.11))
- [Migrate Health Registration Authority to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831513(v=ws.11))

### Print and Document Services

- [Migrate Print and Document Services to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134150(v=ws.11))

### Remote Access

- [Migrate Remote Access to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831423(v=ws.11))

### Remote Desktop Services

- [Migrate Remote Desktop Services](../remote/remote-desktop-services/migrate-rds-role-services.md)
- [Migrate Remote Desktop Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn479239(v=ws.11))
- [Migrate MultiPoint Services](../remote/multipoint-services/multipoint-services-migrate.md)

### Routing and Remote Access

- [RRAS Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee822825(v=ws.10))

### Web Server (IIS)

- [Web Server (IIS)](https://www.iis.net/downloads/microsoft/web-deploy)

### Windows Server Update Services

- [Migrate Windows Server Update Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh852339(v=ws.11))

## Other Windows migration guides

- [Local User and Group Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379531(v=ws.10))
- [IP Configuration Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd379537(v=ws.10))

## Upgrade and migration matrix

|Server Role|Upgradeable in-place?|Migration Supported?|Can migration be completed without downtime?|
|-------------------|----------|--------------|----------|
|Active Directory Certificate Services|    Yes|    Yes|    No|
|Active Directory Domain Services|    Yes|    Yes|    Yes|
|Active Directory Federation Services|    No|    Yes|    No (new nodes need to be added to the farm)|
|Active Directory Lightweight Directory Services|    Yes|    Yes|    Yes|
|Active Directory Rights Management Services|    Yes|    Yes|    No|
|DHCP Server|    Yes|    Yes|    Yes|
|DNS Server|    Yes|    Yes|    No|
|Failover Clustering|Yes with [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) process (Windows Server 2012 R2 and later) or when the server is removed by the cluster for upgrade and then added to a different cluster.|Yes|Yes for Failover Clusters with Hyper-V VMs or Failover Clusters running the Scale-out File Server role. See [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) (Windows Server 2012 R2 and later).|
|File and Storage Services|    Yes|    Varies by subfeature|    No|
|Hyper-V| Yes with [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) process (Windows Server 2012 R2 and later)|   Yes|Yes for Failover Clusters with Hyper-V VMs or Failover Clusters running the Scale-out File Server role. See [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) (Windows Server 2012 R2 and later).|
|Print and Fax Services|    No|    Yes (using Printbrm.exe)|    No|
|Remote Desktop Services|    Yes, for all subroles, but mixed mode farm is not supported|    Yes|    No|
|Web Server (IIS)|    Yes|    Yes|    No|
|Windows Server Essentials Experience|    Yes|    Yes|    No|
|Windows Server Update Services|    Yes|    Yes|    No|
|Work Folders|    Yes|    Yes|    Yes with [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) process (Windows Server 2012 R2 and later).|
