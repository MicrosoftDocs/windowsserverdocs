---
title: Install, upgrade, or migrate to Windows Server
description: How to clean install, in-place upgrade or migrate to Windows Server.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 08/17/2021
ms.prod: windows-server
---

# Install, upgrade, or migrate to Windows Server

Is it time to move to a newer version of Windows Server? Depending on what you're running now, you have several options to get there.

> [!IMPORTANT]
> Extended support for Windows Server 2008 R2 and Windows Server 2008 ended in January 2020. Extended Security Updates (ESU) are available, with one option to migrate your on-premises servers to Azure, where you can continue to run them on virtual machines. To find out more, see [Extended Security Updates overview](extended-security-updates-overview.md).

> [!TIP]
> To download Windows Server 2022, see [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2022-preview).

## Clean install

The simplest way to install Windows Server is to perform a clean installation, where you install on a blank server or overwrite an existing operating system. That is the simplest way, but you will need to back up your data first and plan to reinstall your applications. There are a few things to be aware of, such as [hardware requirements](hardware-requirements.md), so be sure to check the details for Windows Server.

## In-place upgrade

If you want to keep the same hardware and all the server roles you have set up without wiping and reinstalling the operating system, you'll want to do an  **in-place Upgrade**, by which you go from an older operating system to a newer one, keeping your settings, server roles, and data intact. For example, if your server is running Windows Server 2019, you can upgrade it to Windows Server 2022. However, not every older operating system has a pathway to every newer one.

For step-by-step guidance on upgrading, review the [Windows Server upgrade content](../upgrade/upgrade-overview.md).

## Cluster Operating System Rolling Upgrade

Cluster Operating System (OS) Rolling Upgrade enables an administrator to upgrade the operating system of the cluster nodes without stopping the Hyper-V or the Scale-Out File Server workloads. For example, if nodes in your cluster are running Windows Server 2019 you can install Windows Server 2022 on them avoiding downtime to the cluster, which would otherwise impact Service Level Agreements. This feature is discussed in more detail at [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).

## Migration

Migration of Windows Server is when you move one role or feature at a time from a source computer that is running Windows Server to another destination computer that is running Windows Server, either the same or a newer version. For these purposes, migration is defined as moving one role or feature and its data to a different computer, not upgrading the feature on the same computer.

## License conversion

In some operating system releases, you can convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key. This is called **license conversion**. For example, if your server is running Windows Server 2022 Standard, you can convert it to Windows Server 2022 Datacenter. Keep in mind that while you can move up from Windows Server 2022 Standard to Windows Server 2022 Datacenter, you are unable to reverse the process and go from Datacenter to Standard. In some releases of Windows Server, you can also freely convert among OEM, volume-licensed, and retail versions with the same command and the appropriate key.
