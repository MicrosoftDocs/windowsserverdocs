---
title: Plan Your Windows Server Upgrade Path
description: Explore Windows Server upgrade options including in-place upgrade, clean install, migration, and cluster rolling upgrade. Find supported upgrade paths.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 03/23/2026
# customer intent: As a server administrator, I want to understand my upgrade options and supported paths so I can plan the right approach for moving to a newer version of Windows Server.
---

# Plan your Windows Server upgrade

Windows Server supports several methods for moving to a newer version, including in-place upgrade, clean install, migration, cluster rolling upgrade, and edition conversion. Each method has different trade-offs for downtime, complexity, and hardware requirements. Upgrading keeps your servers secure, supported, and able to use the latest features and performance improvements.

This article explains the available upgrade methods, the supported in-place upgrade paths by version, and the restrictions that apply.

## Factors for choosing an upgrade method

The best method depends on your environment and requirements. Consider the following factors when planning your upgrade:

- **Downtime tolerance** — An in-place upgrade requires a reboot but keeps you on the same hardware. A cluster rolling upgrade maintains workload availability throughout the process. A clean install or migration might require more downtime but gives you a fresh environment.
- **Hardware constraints** — If you're staying on the same hardware, an in-place upgrade or clean install is appropriate. If you're moving to new hardware, migration is the better choice.
- **Roles and features** — Not all roles support in-place upgrade. Check the [role and feature migration matrix](upgrade-migrate-roles-features.md) to verify support for your configuration.
- **Version gap** — Starting with Windows Server 2025, nonclustered systems can upgrade up to four versions at a time. For Windows Server 2022 and earlier, nonclustered systems can upgrade up to two versions at a time. Cluster rolling upgrades can only advance one version at a time. See the [supported paths table](#supported-in-place-upgrade-paths-by-version) for details.
- **Licensing** — Before you upgrade, ensure you have a valid product key and activation method for the target version. Unlike Windows client, each Windows Server upgrade requires a separate license.

## Windows Server upgrade methods

Use the following table to decide which method fits your scenario.

> [!IMPORTANT]
> Always back up your system and important files before performing an in-place upgrade, clean install, or migration to a later version of Windows Server.

| Method | What it does | When to use it | More information |
|---|---|---|---|
| **In-place upgrade** | Installs a newer version of Windows Server over the existing one, keeping your settings, server roles, features, and data. You can perform an in-place upgrade by using installation media or receive it as a feature update through Windows Update. | You want the fastest path to a newer version on the same hardware, and your roles and features [support in-place upgrade](upgrade-migrate-roles-features.md). | [Perform an in-place upgrade](perform-in-place-upgrade.md) |
| **Clean install** | Installs Windows Server on a new server or overwrites the existing OS. | You want a fresh start, your hardware is new, or an in-place upgrade isn't supported for your current configuration. | [Install Windows Server](install-windows-server.md) |
| **Migration** | Moves roles or features from a source server to a different destination server running Windows Server. | You're moving to new hardware, or you need to migrate one role or feature at a time without upgrading the OS in-place. | [Upgrade and migrate roles and features](upgrade-migrate-roles-features.md) |
| **Cluster OS rolling upgrade** | Upgrades cluster node operating systems one at a time without stopping Hyper-V or Scale-Out File Server workloads. Clusters can only upgrade one version at a time. You can perform a rolling upgrade by using installation media or receive it as a feature update through Windows Update. For failover clusters running on Azure Local, use the [Lifecycle Manager (LCM)](/azure/azure-local/upgrade/about-upgrades-23h2) instead. | You're running a failover cluster and need to maintain availability during the upgrade. | [Cluster OS rolling upgrade](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) |
| **License conversion** | Converts one edition of Windows Server to another edition of the same release by using a command and a product key (for example, Standard to Datacenter). | You need to change your Windows Server edition or switch between retail, volume-licensed, and OEM licenses. | [Convert Windows Server editions and license types](upgrade-conversion-options.md) |

## Supported in-place upgrade paths by version

Upgrade to the latest version of Windows Server to get the latest features, security updates, and best performance.

Starting with Windows Server 2025, nonclustered systems can upgrade up to four versions at a time. You can upgrade directly to Windows Server 2025 from Windows Server 2012 R2 and later. For Windows Server 2022 and earlier, nonclustered systems can upgrade up to two versions at a time. If you're using a [Cluster OS rolling upgrade](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md), you can only upgrade one version at a time.

The following table shows the supported in-place upgrade paths based on your current version:

| Upgrade from / to | Windows Server 2012 R2 | Windows Server 2016 | Windows Server 2019 | Windows Server 2022 | Windows Server 2025 |
|--|--|--|--|--|--|
| **Windows Server 2012** | Yes | Yes | No | No | No |
| **Windows Server 2012 R2** | No | Yes | Yes | No | Yes |
| **Windows Server 2016** | No | No | Yes | Yes | Yes |
| **Windows Server 2019** | No | No | No | Yes | Yes |
| **Windows Server 2022** | No | No | No | No | Yes |
| **Windows Server 2025** | No | No | No | No | Yes |

## Upgrade restrictions for licensed versions of Windows Server

The following restrictions apply to in-place upgrades where Windows Server is already licensed (not an evaluation version):

- Upgrades from 32-bit to 64-bit architectures aren't supported. All releases since Windows Server 2008 R2 are 64-bit only.
- Upgrades from one language to another aren't supported.
- If the server is an Active Directory domain controller, you can't convert it to a retail version. See [Upgrade domain controllers to Windows Server](../identity/ad-ds/deploy/upgrade-domain-controllers.md) for important information.
- Upgrades from prerelease versions (previews) of Windows Server aren't supported. Perform a clean install instead.
- Switching from a Server Core installation to a Server with Desktop Experience installation (or vice versa) during an in-place upgrade isn't supported.
- Upgrades from a previous Windows Server installation to an evaluation copy aren't supported. Install evaluation versions as clean installs.
- By default, an upgrade retains the existing edition. For example, Standard upgrades to Standard and Datacenter upgrades to Datacenter.
- You can change from Standard to Datacenter or Datacenter: Azure Edition, or from Datacenter to Datacenter: Azure Edition, during an upgrade. You can't downgrade from Datacenter to Standard, or from Datacenter: Azure Edition to Standard or Datacenter.
- If your server uses NIC Teaming, disable NIC Teaming before the in-place upgrade. You can re-enable it when the in-place upgrade is complete. For more information, see [NIC Teaming overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831648(v=ws.11)).
- In-place upgrades on Windows Server configured to boot from VHD aren't supported.
- In-place upgrades from Windows Storage Server editions aren't supported.
- Some public and private cloud providers support in-place upgrades. Check with your cloud provider for details.

## End-of-support Windows Server versions

Support for [Windows Server 2012](/lifecycle/products/windows-server-2012) and [Windows Server 2012 R2](/lifecycle/products/windows-server-2012-r2) ended October 10, 2023. Extended Security Updates (ESU) are available, with one option to migrate your on-premises servers to Azure, where you can continue to run them on virtual machines. For more information, see [Extended Security Updates overview](extended-security-updates-overview.md).

## Related content

- [Perform an in-place upgrade of Windows Server](perform-in-place-upgrade.md)
- [Convert Windows Server editions and license types](upgrade-conversion-options.md)
- [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md)
- [Cluster OS rolling upgrade](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md)
- [Cluster-Aware Updating overview](../failover-clustering/cluster-aware-updating.md)
