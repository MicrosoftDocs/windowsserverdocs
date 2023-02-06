---
title: Overview of Windows Server upgrades | Microsoft Docs
description: General Windows Server upgrade information, along with what to think through before you do the actual upgrade.
ms.topic: how-to
author: RobHindman
ms.author: robhind
ms.date: 05/24/2022
---

# Overview of Windows Server upgrades

The process of upgrading to a newer version of Windows Server can vary greatly, depending on which
operating system you are starting with and the pathway you take. We use the following terms to
distinguish between different actions, any of which could be involved in a new Windows Server
deployment.

- **Upgrade.** Also known as an "in-place upgrade". You move from an older version of the operating
  system to a newer version, while staying on the same physical hardware. **This is the method we
  will be covering in this section.**

    > [!Important]
    > In-place upgrades might also be supported by public or private cloud companies; however, you
    > must check with your cloud provider for the details. Additionally, you'll be unable to perform
    > an in-place upgrade on any Windows Server configured to **Boot from VHD**. An in-place upgrade
    > from Windows Storage Server Editions is not supported. You can perform either a **Migration**
    > or **Installation** instead.

- **Installation.** Also known as a "clean installation". You move from an older version of the
  operating system to a newer version, deleting the older operating system.

- **Migration.** You move from an older version of the operating system to a newer version of the
  operating system, by transferring to a different set of hardware or virtual machine.

- **Cluster OS Rolling Upgrade.** You upgrade the operating system of your cluster nodes without
  stopping the Hyper-V or the Scale-Out File Server workloads. This feature allows you to avoid
  downtime which could impact Service Level Agreements. For more information, see
  [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md)

- **License conversion.** Convert a particular edition of the release to another edition of the same
  release in a single step with a simple command and the appropriate license key. We call this
  "license conversion". For example, if your server is running Standard edition, you can convert it
  to Datacenter.

## Which version of Windows Server should I upgrade to?

We recommend upgrading to the latest version of Windows Server. Running the latest version of
Windows Server allows you to use the latest features – including the latest security features – and
delivers the best performance.

> [!TIP]
> You can upgrade to a newer version of Windows Server by up to two versions at a time. For example, Windows Server 2016 can be upgraded to Windows Server 2019 or Windows Server
> 2022. If you are using the
> [Cluster OS Rolling Upgrade feature](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md#requirements)
> you can only one version at at time.

In this table you can see the supported upgrade paths, based on the version you're currently on.

| Upgrade from / to | Windows   Server 2008 R2 | Windows   Server 2012 | Windows   Server 2012 R2 | Windows   Server 2016 | Windows   Server 2019 | Windows   Server 2022 |
|--|--|--|--|--|--|--|
| Windows   Server 2008 | Yes | Yes | - | - | - | - |
| Windows   Server 2008 R2 | - | Yes | Yes | - | - | - |
| Windows   Server 2012 | - | - | Yes | Yes | - | - |
| Windows   Server 2012 R2 | - | - | - | Yes | Yes | - |
| Windows   Server 2016 | - | - | - | - | Yes | Yes |
| Windows   Server 2019 | - | - | - | - | - | Yes |

You can also upgrade from an evaluation version of the operating system to a retail version, from an
older retail version to a newer version, or, in some cases, from a volume-licensed edition of the
operating system to an ordinary retail edition. For more information about upgrade options other
than in-place upgrade, see
[Upgrade and conversion options for Windows Server](../get-started/upgrade-conversion-options.md).

> [!NOTE]
> Support for [Windows Server 2008](/lifecycle/products/windows-server-2008) and
> [Windows Server 2008 R2](/lifecycle/products/windows-server-2008-r2) has ended. We recommend you
> update your version of Windows Server to a more recent version as soon as possible. Learn more
> about [Extended Security Updates (ESU)](extended-security-updates-overview.md) as a last resort.

## Next steps

Now that you've ready to upgrade Windows Server, here are some articles that might help you get
started:

- [Install, upgrade, or migrate to Windows Server](install-upgrade-migrate.md)
- [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md)
- [Upgrade and conversion options for Windows Server](upgrade-conversion-options.md)
- [Perform an in-place upgrade of Windows Server](perform-in-place-upgrade.md)
