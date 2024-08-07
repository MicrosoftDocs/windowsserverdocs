---
title: Feature Update, Clean Install, or Migrate to Windows Server
description: Important information when performing a feature upgrade, clean install, or a migration to Windows Server.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
ms.date: 08/27/2024
---

# Feature Update, Clean Install, or Migrate to Windows Server

Is it time to move to a newer version of Windows Server? Depending on what you're running now, you have several options to get there. Options include performing an in-place operating system (OS) upgrade (Feature Upgrade) to a newer version of Windows Server, performing a clean install of a newer version Windows Server, or even migrating your existing system to Windows Server.

> [!IMPORTANT]
> Regardless of whether you intend to perform an in-place OS Feature Upgrade, a Clean Install of Windows Server, or are planning a system migration to Windows Server, it's very important to create a backup of all your system and other files before you begin.
> [!IMPORTANT]
> Extended support for Windows Server 2008 R2 and Windows Server 2008 ended in January 2020. Extended Security Updates (ESU) are available, with one option to migrate your on-premises servers to Azure, where you can continue to run them on virtual machines. To find out more, see [Extended Security Updates overview](extended-security-updates-overview.md).
> [!TIP]
> You can download and try the latest version of Windows Server free of charge at [Windows Server Evaluations](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2025).

## In-place operating system Feature Upgrade

An in-place Feature Upgrade of your Windows Server installation preserves your original settings, server roles, applications, and data. In-place Feature Upgrade lets you jump ahead multiple versions. The in-place Feature Upgrade is the quickest method of moving to a newer version of Windows Server. For more information about OS upgrade paths, see [Which version of Windows Server should I upgrade to?](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to). Keep in mind that some roles and features don't support in-place Feature Upgrades. In-place Feature Upgrades work best with virtual machines (VMs) that don't need specific Original Equipment Manufacturer (OEM) hardware drivers to upgrade successfully.

- For step-by-step instructions for how to perform an in-place Feature Upgrade, see [Perform an in-place upgrade](perform-in-place-upgrade.md).

- For more information about how Feature Upgrades work, see the [Windows Server upgrade overview](../get-started/upgrade-overview.md).

- For more detailed guides for how to perform Feature Upgrades for different versions of Windows Server, including information about which roles and features support in-place Feature Upgrades, see [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md).

## Cluster Operating System rolling OS Feature Upgrade

The Cluster operating system rolling OS Feature Upgrade gives an administrator the ability to upgrade the operating system of the cluster nodes without stopping the Hyper-V or the Scale-Out File Server workloads. For example, if nodes in your clusters are running an earlier version of Windows Server, your admin can use a rolling OS Feature Upgrade to install a later version on them without having to turn off the cluster, which would otherwise affect Service Level Agreements (SLA). Cluster-Aware Updating (CAU) is a feature that automates the software updating process on clustered servers while maintaining availability. See [Cluster-Aware Updating overview](https://learn.microsoft.com/windows-server/failover-clustering/cluster-aware-updating).

If you are running virtual machines on a Azure Stack hyperconverged infrastructure (HCI) solution, it's suggested that you use the the Local Configuration Manager (LCM) to perform your OS Feature Upgrade. See [Upgrade on-premises infrastructure that supports Configuration Manager](https://learn.microsoft.com/en-us/mem/configmgr/core/servers/manage/upgrade-on-premises-infrastructure)for more information.

## Clean install

A clean OS install of Windows Server is installing Windows Server on a blank server or overwriting an existing operating system and is the simplest way to install Windows Server. However, before you can do a clean install, you must back up your data and plan for how to reinstall your existing applications. You should also make sure your system meets the [hardware requirements for Windows Server](hardware-requirements.md).

## Migration

Migration is when you move roles or features from a source computer running Windows Server to a destination computer that's also running Windows Server. This process is gradual, moving one role or feature at a time, without upgrading them. You can migrate your system components to a new machine that's either running the same version of Windows Server as the source computer or a later version than the source computer.

## License conversion

License conversion converts a particular edition of a specific version of Windows Server to another edition of the same release. All you have to do is run a command and enter the appropriate license key for the edition you want to convert to. For example, if your server is running Windows Server Standard edition, you can convert it to Windows Server Datacenter edition. However, when you convert your edition from Standard to Datacenter, there's no way to reverse the process to return to Standard edition. In some releases of Windows Server, you can also freely convert between original equipment manufacturer (OEM), volume-licensed, and retail versions with the same command and the appropriate license key.

## See also

- [Cluster OS rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md) for more details.