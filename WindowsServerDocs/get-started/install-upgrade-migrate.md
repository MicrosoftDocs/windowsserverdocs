---
title: Install, upgrade, or migrate to Windows Server
description: How to clean install, in-place upgrade or migrate to Windows Server.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 11/27/2023
ms.prod: windows-server
---

# Install, upgrade, or migrate to Windows Server

Is it time to move to a newer version of Windows Server? Depending on what you're running now, you have several options to get there.

> [!IMPORTANT]
> Extended support for Windows Server 2008 R2 and Windows Server 2008 ended in January 2020. Extended Security Updates (ESU) are available, with one option to migrate your on-premises servers to Azure, where you can continue to run them on virtual machines. To find out more, see [Extended Security Updates overview](extended-security-updates-overview.md).

> [!TIP]
> You can download and try Windows Server free of charge at [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2022).

## Clean install

A *clean install*, where you install a blank server or overwrite an existing operating system (OS), is the simplest way to install Windows Server. However, before you can do a clean install, you must back up your data and plan for how to reinstall your original applications. You should also make sure your system meets the [hardware requirements for Windows Server](hardware-requirements.md).

## In-place upgrade

*In-place upgrades* let you upgrade to a later version of Windows Server while keeping your original settings, server roles, features, and data. You can upgrade between up to two Server versions at a time. For more information, see [Which version of Windows Server should I upgrade to?](upgrade-overview.md#which-version-of-windows-server-should-i-upgrade-to). Keep in mind that some roles and features don't support in-place upgrades. In-place upgrades work best with virtual machines (VMs) that don't need specific Original Equipment Manufacturer (OEM) hardware drivers to upgrade successfully.

- For step-by-step instructions for how to perform an in-place upgrade, see [Perform an in-place upgrade](perform-in-place-upgrade.md).

- For more information about how upgrades work, see the [Windows Server upgrade overview](../get-started/upgrade-overview.md).

- For more detailed guides for how to upgrade for different versions of Windows Server, including information about which roles and features support in-place upgrades, see [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md).

## Cluster Operating System rolling upgrade

The *Cluster operating system rolling upgrade* gives an administrator the ability to upgrade the operating system of the cluster nodes without stopping the Hyper-V or the Scale-Out File Server workloads. For example, if nodes in your clusters are running an earlier version of Windows Server, your admin can use a rolling upgrade to install a later version on them without having to turn off the cluster, which would otherwise affect Service Level Agreements. For more information, see [Cluster OS rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).

## Migration

*Migration* is when you move roles or features from a source computer running Windows Server to a destination computer that's also running Windows Server. This process is gradual, moving one role or feature at a time, without upgrading them. You can migrate your system components to a new machine that's either running the same version of Windows Server as the source computer or a later version than the source computer.

## License conversion

*License conversion* converts a particular edition of a specific version of Windows Server to another edition of the same release. All you have to do is run a command and enter the appropriate license key for the edition you want to convert to. For example, if your server is running Windows Server Standard edition, you can convert it to Windows Server Datacenter edition. However, when you convert your edition from Standard to Datacenter, there's no way to reverse the process to return to Standard edition. In some releases of Windows Server, you can also freely convert between original equipment manufacturer (OEM), volume-licensed, and retail versions with the same command and the appropriate license key.
