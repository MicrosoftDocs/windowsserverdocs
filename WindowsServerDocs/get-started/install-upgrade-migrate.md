---
title: Feature update, clean install, or migrate to Windows Server
description: Important information when performing a feature update, clean install, or a migration to Windows Server.
ms.topic: upgrade-and-migration-article
author: robinharwood
ms.author: roharwoo
ms.date: 03/03/2025
---

# Feature update, clean install, or migrate to Windows Server

Is it time to move to a newer version of Windows Server? Depending on what you're running now, you have several options to get there. For example, you can perform an in-place operating system (OS) upgrade (feature update) to a newer version of Windows Server, a clean install of a newer version Windows Server, or even migrate your existing system to Windows Server.

> [!IMPORTANT]
>
> - We highly recommend that you always make a backup of your system and other important files before performing an in-place OS feature upgrade, a clean install, or a system migration to a later version of Windows Server.
>
> - Extended support for Windows Server 2012 and Windows Server 2012 R2 ended October 10, 2023. Extended Security Updates (ESU) are available, with one option to migrate your on-premises servers to Azure, where you can continue to run them on virtual machines. To find out more, see [Extended Security Updates overview](extended-security-updates-overview.md).

You can download and try the latest version of Windows Server free of charge at [Windows Server Evaluations](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2025).

## In-place OS upgrade (feature update)

An in-place OS upgrade (feature update) performs a feature update of your Windows Server installation. You can upgrade to a later version of Windows Server while keeping your original settings, server roles, features, and data. For non-clustered systems, an in-place feature update lets you jump ahead multiple versions. This method is the quickest way to move to a later version of Windows Server. For more information about OS upgrade paths, see [Which version of Windows Server should I upgrade to?](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to). Keep in mind that some roles and features don't support in-place feature upgrades. In-place feature upgrades work best with virtual machines (VMs) that don't need specific Original Equipment Manufacturer (OEM) hardware drivers to upgrade successfully.

You can perform an in-place upgrade from media. Upgrading your installation using media involves downloading and preparing media such as an ISO, USB, or DVD disk.

For step-by-step instructions for how to perform an in-place upgrade, see [Perform an in-place upgrade of Windows Server](perform-in-place-upgrade.md).

## Cluster operating system rolling upgrade (feature update)

The Cluster operating system rolling upgrade (feature update) gives an administrator the ability to upgrade the operating system of the cluster nodes without stopping the Hyper-V or the Scale-Out File Server workloads. For example, if nodes in your clusters are running an earlier version of Windows Server, your admin can use a feature update to install a later version on them without having to turn off the cluster, which would otherwise affect Service Level Agreements (SLA). Cluster-Aware Updating (CAU) is a feature that automates the software updating process on clustered servers while maintaining availability. Clusters can only upgrade one version at a time. For more information about updating your clusters, see [Cluster-Aware Updating overview](../failover-clustering/cluster-aware-updating.md) and [Cluster operating system rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).

If you're running VMs on an Azure Stack hyperconverged infrastructure (HCI) solution, we recommend you use the Life Cycle Manager (LCM) to perform your feature update. For more information, see [About Azure Local upgrades](/azure/azure-local/upgrade/about-upgrades-23h2) for more information.

## Clean operating system install

A clean OS install of Windows Server is when you install Windows Server on a brand-new server or overwrite an existing OS. This method is the simplest way to install Windows Server. However, before you can do a clean install, you must back up your data and plan for how to reinstall your existing applications once the installation is complete. You should also make sure your system meets the [hardware requirements for Windows Server](hardware-requirements.md).

## Migration

Migration is when you move roles or features from a source computer running Windows Server to a destination computer that's also running Windows Server. This process is gradual, moving one role or feature at a time, without upgrading the features. You can migrate your system components to a machine that's running either the same version of Windows Server as the source computer or a later version.

## License conversion

License conversion converts a particular edition of a specific version of Windows Server to another edition of the same release. All you have to do is run a command and enter the appropriate license key for the edition you want to convert to. For example, if your server is running Windows Server Standard edition, you can convert it to Windows Server Datacenter edition. However, when you convert your edition from Standard to Datacenter, there's no way to reverse the process to return to Standard edition. In some releases of Windows Server, you also can freely convert between original equipment manufacturer (OEM), volume-licensed, and retail versions with the same command and the appropriate license key.

## Related content

- [Cluster OS rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md)
