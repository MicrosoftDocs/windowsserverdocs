---
title: Upgrade and migrate roles and features in Windows Server
description: Upgrade Windows Server with confidence. Learn about supported upgrade paths, and migration tools for a smooth transition.
ms.topic: upgrade-and-migration-article
author: robinharwood
ms.author: roharwoo
ms.date: 05/23/2025
---

# Upgrade and migrate roles and features in Windows Server

Upgrading or migrating roles and features in Windows Server is essential for maintaining security, performance, and supportability. This article provides an overview which roles and features can be upgraded in-place or migrated to a new server. It also provides links to detailed migration guides for each role and feature, as well as information about the Windows Server Migration Tools and Storage Migration Service. Use this information to plan a smooth transition to newer versions of Windows Server, minimize downtime, and ensure continued reliability for your workloads.

You can update roles and features to later versions of Windows Server in two ways:

- **Migration:** Move roles and features to a new server running the newer version of Windows Server.
- **In-place upgrade:** Install the new version of Windows Server over the existing one, keeping roles and features in place.

Some roles and features support both methods, while others might only support migration.

You can migrate many roles and features by using Windows Server Migration Tools. This feature is built into Windows Server and helps you move roles and features to a new server. For file servers and storage, use the [Storage Migration Service](../storage/storage-migration-service/overview.md).

The migration guides support migrations of specified roles and features from one server to another (not in-place upgrades). Unless the guides say otherwise, you can migrate between physical and virtual computers. You can also migrate between Windows Server installations that use either Server with Desktop Experience or Server Core.

> [!IMPORTANT]
> Before you begin migrating roles and features, verify that both source and destination servers are running the most current updates that are available for their operating systems.

Before migrating or upgrading to a new version of Windows Server, review the [support lifecycle policy](https://support.microsoft.com/lifecycle) for that version. Make sure you understand how long it's supported. You can [search for lifecycle information](https://support.microsoft.com/lifecycle) for the specific Windows Server release you plan to use.

## Windows Server Migration Tools

Windows Server Migration Tools enables you to migrate server roles, features, operating system settings, and other data and shares to servers, including later versions of Windows Server. It's a feature of Windows Server and so it's easily installed using the Add Roles and Features wizard, or PowerShell. Learn more about how to [install, use, and remove Windows Server Migration Tools](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134202(v=ws.11)).

> [!NOTE]
> Cross-subnet migrations using Windows Server Migration Tools is available with Windows Server 2012 and later releases. Previous versions of Windows Server Migration Tools only support migrations in the same subnet.

## Upgrade and migration matrix

|Server Role|Upgradeable in-place?|Migration Supported?|Can migration be completed without downtime?|
|-------------------|----------|--------------|----------|
|Active Directory Certificate Services|    Yes|    [Yes](../identity/ad-cs/migrate-certification-authority.md)|    No|
|Active Directory Domain Services|    [Yes](/windows-server/identity/ad-ds/deploy/upgrade-domain-controllers)|    [Yes](/windows-server/identity/ad-ds/deploy/upgrade-domain-controllers)|    Yes|
|Active Directory Federation Services|    No|    Yes|    No (new nodes need to be added to the farm)|
|Active Directory Lightweight Directory Services|    Yes|    Yes|    Yes|
|Active Directory Rights Management Services|    Yes|    [Yes](../identity/ad-rms/adrms-deploy.md)|    No|
|DHCP Server|    Yes|    [Yes](#dhcp)|    Yes|
|DNS Server|    Yes|    Yes|    No|
|Failover Clustering|Yes with [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) or when the server is removed by the cluster for upgrade and then added to a different cluster.|Yes|Yes for Failover Clusters with Hyper-V VMs or Failover Clusters running the Scale-out File Server role. See [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).|
|File and Storage Services|    Yes|    [Varies by subfeature](#file-and-storage-services)|    No|
|Hyper-V| Yes with [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) process|   Yes|Yes for Failover Clusters with Hyper-V VMs or Failover Clusters running the Scale-out File Server role. See [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).|
|Print and Fax Services|    No|    Yes (using `Printbrm.exe`)|    No|
|Remote Desktop Services|    Yes, for all subroles, but mixed mode farm isn't supported|    [Yes](../remote/remote-desktop-services/migrate-rds-role-services.md)|    No|
|Web Server (IIS)|    Yes|    Yes|    No|
|Windows Server Essentials Experience|    Yes|    Yes|    No|
|Windows Server Update Services|    Yes|    [Yes](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh852339(v=ws.11))|    No|
|Work Folders|    Yes|    Yes|    Yes with [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) process.|

## Migration guides

Below you can find links to migration guides for specific Windows Roles and Features.

### Active Directory

- [Migrate the Certification Authority](../identity/ad-cs/migrate-certification-authority.md)
- [Migrate Active Directory Federation Services Role Service](/previous-versions/windows-server/it-pro/windows-server-2012/identity/ad-fs/deployment/migrate-ad-fs-service-role-to-windows-server-r2)
- [Upgrading AD RMS to Windows Server 2016](../identity/ad-rms/adrms-deploy.md)
- [Upgrade domain controllers to a newer version of Windows Server](/windows-server/identity/ad-ds/deploy/upgrade-domain-controllers)
- [Active Directory Domain Services and Domain Name System (DNS) Server Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379558(v=ws.10))

### BranchCache

- [BranchCache Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd548365(v=ws.10))

### DHCP

- [Migrate DHCP Server](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn495425(v=ws.11))
- [Migrate existing DHCP failover deployment](../networking/technologies/dhcp/migrate-existing-dhcp-failover.md)

### Failover Clustering

- [Upgrade a Windows Server failover cluster with a cluster OS rolling upgrade](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md)
- [Upgrading Failover Clusters on the same hardware](../failover-clustering/Upgrade-Option-Same-Hardware.md)
- [Migrate Cluster Roles](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn530779(v=ws.11))
- [Migrate Clustered Services and Applications to Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486790(v=ws.11))

### File and Storage Services

- [Storage Migration Service](../storage/storage-migration-service/overview.md)
- [Migrate File and Storage Services](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn479292(v=ws.11))
- [Upgrade a Storage Spaces Direct cluster](../storage/storage-spaces/upgrade-storage-spaces-direct.md)

### Hyper-V

- [Migrate Hyper-V](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486799(v=ws.11))
- [Upgrade virtual machine version in Hyper-V on Windows or Windows Server](../virtualization/hyper-v/deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md)

### Network Policy Server

- [Migrate Network Policy Server](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831652(v=ws.11))
- [Migrate Health Registration Authority](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831513(v=ws.11))

### Print and Document Services

- [Migrate Print and Document Services](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134150(v=ws.11))

### Remote Desktop Services

- [Migrate Remote Desktop Services](../remote/remote-desktop-services/migrate-rds-role-services.md)
- [Migrate your Remote Desktop Services Client Access Licenses (RDS CALs)](../remote/remote-desktop-services/migrate-rds-cals.md)

### Routing and Remote Access

- [Overview of the DirectAccess to Always On VPN migration](../remote/remote-access/da-always-on-vpn-migration/da-always-on-migration-overview.md)
- [RRAS Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee822825(v=ws.10))

### Web Server (IIS)

- [Web Server (IIS)](https://www.iis.net/downloads/microsoft/web-deploy)

### Windows Server Update Services

- [Migrate Windows Server Update Services to Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh852339(v=ws.11))

## Other Windows migration guides

- [Local User and Group Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd379531(v=ws.10))
- [IP Configuration Migration Guide](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd379537(v=ws.10))
