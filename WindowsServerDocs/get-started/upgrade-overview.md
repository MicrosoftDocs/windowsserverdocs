---
title: Overview of Windows Server upgrades | Microsoft Docs
description: General Windows Server upgrade information, along with what to think through before you do the actual upgrade.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 05/23/2025
---

# Overview of Windows Server upgrades

The process of upgrading to a newer version of Windows Server can vary greatly, depending on which
operating system you're starting with and the pathway you take. We use the following terms to
distinguish between different actions, any of which could be involved in a new Windows Server
deployment.

- **Upgrade.** Also known as an "in-place upgrade". For nonclustered systems, you move from an
  older version of the operating system to a newer version, while staying on the same physical
  hardware. **This is the method we will be covering in this section.**

    > [!Important]
    > In-place upgrades might also be supported by public or private cloud companies; however, you
    > must check with your cloud provider for the details. Additionally, you'll be unable to perform
    > an in-place upgrade on any Windows Server configured to **Boot from VHD**. An in-place upgrade
    > from Windows Storage Server Editions is not supported. You can perform either a **Migration**
    > or **Installation** instead.

- **Installation.** Also known as a "clean installation". You move from an older version of the
  operating system to a newer version, deleting the older operating system.

- **Migration.** Move to a newer version of the operating system on different hardware or a virtual machine.

- **Cluster OS Rolling Upgrade.** You upgrade the operating system of your cluster nodes without
  stopping the Hyper-V or the Scale-Out File Server workloads. Clusters can only upgrade one version
  at a time. This feature allows you to avoid downtime which could impact Service Level Agreements.
  For more information, see
  [Cluster OS Rolling Upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md)

- **License conversion.** Convert one edition of Windows Server to another edition using a simple command and the appropriate license key.  We call this "license conversion". For example, if your server is running Standard edition, you can convert it to Datacenter.

## Which version of Windows Server should I upgrade to?

We recommend upgrading to the latest version of Windows Server. Running the latest version of
Windows Server allows you to use the latest features – including the latest security features – and
delivers the best performance.

Beginning with Windows Server 2025, nonclustered systems can upgrade up to four versions at a time.
Meaning you can upgrade directly to Windows Server 2025 from Windows Server 2012 R2 and later.

With Windows Server 2022 and earlier, nonclustered systems can upgrade to a newer version of
Windows Server by up to two versions at a time. For example, Windows Server 2016 can be upgraded to
Windows Server 2019 or Windows Server 2022. If you're using the
[Cluster OS Rolling Upgrade feature](../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md),
you can only upgrade one version at a time.

In this table you can see the supported upgrade paths, based on the version you're currently on.

| Upgrade from / to | Windows   Server 2012 R2 | Windows   Server 2016 | Windows   Server 2019 | Windows   Server 2022 | Windows   Server 2025|
|--|--|--|--|--|--|
| Windows   Server 2012 | Yes | Yes | - | - | - |
| Windows   Server 2012 R2 | - | Yes | Yes | - | - |
| Windows   Server 2016 | - | - | Yes | Yes | - |
| Windows   Server 2019 | - | - | - | Yes | Yes |
| Windows   Server 2022 | - | - | - | - | Yes |
| Windows   Server 2025 | - | - | - | - | - |

You can upgrade in several ways:

- From an evaluation version to a retail version.
- From an older retail version to a newer retail version.
- From a volume-licensed edition to a retail edition.

For more information about upgrade options other
than in-place upgrade, see
[Upgrade and conversion options for Windows Server](../get-started/upgrade-conversion-options.md).

> [!IMPORTANT]
> Support for [Windows Server 2012](/lifecycle/products/windows-server-2012) and
> [Windows Server 2012 R2](/lifecycle/products/windows-server-2012-r2) has ended. We recommend you
> update your version of Windows Server to a more recent version as soon as possible. Learn more
> about [Extended Security Updates (ESU)](extended-security-updates-overview.md) as a last resort.

## Next steps

Now that you're ready to upgrade Windows Server, here are some articles that might help you get
started:

- [Install, upgrade, or migrate to Windows Server](install-upgrade-migrate.md)
- [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md)
- [Upgrade and conversion options for Windows Server](upgrade-conversion-options.md)
- [Perform an in-place upgrade of Windows Server](perform-in-place-upgrade.md)

