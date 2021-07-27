---
title: Install, upgrade, or migrate to Windows Server 2019
description: How to clean install, in-place upgrade or migrate to, Windows Server
ms.topic: article
ms.assetid: 99f7daa4-30ce-4d13-be65-0a4e99cca754
author: jasongerend
ms.author: jgerend
manager: jasgroce
ms.localizationpriority: medium
ms.date: 09/17/2020
---

# Install, upgrade, or migrate to Windows Server

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

> [!IMPORTANT]
> Extended support for Windows Server 2008 R2 and Windows Server 2008 ends in January 2020. [Learn about your upgrade options](../upgrade/upgrade-overview.md). To download Windows Server 2019, see [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019).

Is it time to move to a newer version of Windows Server? Depending on what you're running now, you have lots of options to get there.

## Clean install

The simplest way to install Windows Server is to perform a clean installation, where you install on a blank server or overwrite an existing operating system. That is the simplest way, but you will need to back up your data first and plan to reinstall your applications. There are a few things to be aware of, such as system requirements, so be sure to check the details for [Windows Server 2019](./rel-notes-19.md), [Windows Server 2016](../get-started/windows-server-2016-ga-release-notes.md), [Windows Server 2012 R2](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn303418(v=ws.11)), and [Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134246(v=ws.11)).

## In-place upgrade

If you want to keep the same hardware and all the server roles you have set up without flattening the server, you'll want to do an  **In-place Upgrade**, by which you go from an older operating system to a newer one, keeping your settings, server roles, and data intact. For example, if your server is running Windows Server 2012 R2, you can upgrade it to Windows Server 2016 or Windows Server 2019. However, not every older operating system has a pathway to every newer one.

For step-by-step guidance on upgrading, review the [Windows Server upgrade content](../upgrade/upgrade-overview.md).

## Cluster OS rolling upgrade

Cluster OS Rolling Upgrade enables an administrator to upgrade the operating system of the cluster nodes from Windows Server 2012 R2 and Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. This feature allows you to avoid downtime which could impact Service Level Agreements. This new feature is discussed in more detail at [Cluster operating system rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).

## Migration

Windows Server migration is when you move one role or feature at a time from a source computer that is running Windows Server to another destination computer that is running Windows Server, either the same or a newer version. For these purposes, migration is defined as moving one role or feature and its data to a different computer, not upgrading the feature on the same computer.

## License conversion

In some operating system releases, you can convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key. This is called **license conversion**. For example, if your server is running Windows Server 2016 Standard, you can convert it to Windows Server 2016 Datacenter. Keep in mind that while you can move up from Server 2016 Standard to Server 2016 Datacenter, you are unable to reverse the process and go from Datacenter to Standard. In some releases of Windows Server, you can also freely convert among OEM, volume-licensed, and retail versions with the same command and the appropriate key.
