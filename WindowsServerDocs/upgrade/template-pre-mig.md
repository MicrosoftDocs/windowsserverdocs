---
title: Upgrade content - Windows Server
description: Upgrade content
services: windows-server
author: ChJenk

ms.service: server-general
ms.topic: upgrade
ms.date: 06/20/2019
ms.author: v-chjenk
---

# Pre-Migrating Steps

Applies To: Windows Server 2016

This topic includes information about upgrading to Windows Server® 2016 from a variety of previous operating systems using a variety of methods.

The process of moving to Windows Server 2016 might vary greatly depending on which operating system you are starting with and the pathway you take. We use the following terms to distinguish among different actions, any of which could be involved in a new Windows Server 2016 deployment.

- **Installation** is the basic concept of getting the new operating system on your hardware. Specifically, a **clean installation** requires deleting the previous operating system. For information about installing Windows Server 2016, see [System Requirements and Installation Information for Windows Server 2016](https://technet.microsoft.com/windows-server-docs/get-started/system-requirements--and-installation). For information about installing other versions of Windows Server, see [Windows Server Installation and Upgrade](https://technet.microsoft.com//windowsserver/dn527667).
- **Migration** means moving from your existing operating system to Windows Server 2016 by transferring to a different set of hardware or virtual machine. Migration, which might vary considerably depending on the server roles you have installed, is discussed in detail at [Windows Server Installation, Upgrade,and Migration](https://technet.microsoft.com/windowsserver/dn458795).
- **Cluster OS Rolling Upgrade** is a new feature in Windows Server 2016 that enables an administrator to upgrade the operating system of the cluster nodes from Windows Server 2012 R2 to Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. This feature allows you to avoid downtime which could impact Service Level Agreements. This new feature is discussed in more detail at [Cluster operating system rolling upgrade](https://technet.microsoft.com/windows-server-docs/failover-clustering/cluster-operating-system-rolling-upgrade).
- **License conversion** In some operating system releases, you can convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key. We call this “license conversion.” For example, if you are running Windows Server 2016 Standard, you can convert it to Windows Server 2016 Datacenter.
- **Upgrade** means moving from your existing operating system release to a more recent release while staying on the same hardware. (This is sometimes called "in-place" upgrade.) For example, if your server is running Windows Server 2012, or Windows Server 2012 R2, you can upgrade it to Windows Server 2016. You can upgrade from an evaluation version of the operating system to a retail version, from an older retail version to a newer version, or, in some cases, from a volume-licensed edition of the operating system to an ordinary retail edition.

> [!IMPORTANT]  
> Upgrade works best in virtual machines where specific OEM hardware drivers are not needed for a successful upgrade.  

> [!IMPORTANT]  

> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, **you can only perform conversion from evaluation to retail** with Windows Server 2016 that has been installed by using the Desktop Experience option (not the Server Core option). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.

> [!IMPORTANT]  
> If your server uses NIC Teaming, disable NIC Teaming prior to upgrade, and then re-enable it after upgrade is complete. See [NIC Teaming Overview](https://technet.microsoft.com/library/hh831648(v=ws.11).aspx) for details.

## Upgrading previous retail versions of Windows Server to Windows Server 2016

The table below briefly summarizes which **already licensed** (that is, not evaluation) Windows operating systems can be upgraded to which editions of Windows Server 2016.

Note the following general guidelines for supported paths:

- Upgrades from 32-bit to 64-bit architectures are not supported. All editions of Windows Server 2016 are 64-bit only.
- Upgrades from one language to another are not supported.
- If the server is a domain controller, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](https://technet.microsoft.com/library/hh994618.aspx) for important information.
- Upgrades from pre-release versions (previews) of Windows Server 2016 are not supported. Perform a clean installation to Windows Server 2016.
- Upgrades that switch from a Server Core installation to a Server with a Desktop installation (or vice versa) are not supported.
- Upgrades from a previous Windows Server installation to an evaluation copy of Windows Server are not supported. Evaluation versions should be installed as a clean installation.

If you do not see your current version in the left column, upgrading to this release of Windows Server 2016 is not supported.

If you see more than one edition in the right column, upgrading to **either** edition from the same starting version is supported.

| If you are running this edition: | You can upgrade to these editions: |  
|-------------------|----------|  
| Windows Server 2012 Standard | Windows Server 2016 Standard or Datacenter |
| Windows Server 2012 Datacenter | Windows Server 2016 Datacenter |
| Windows Server 2012 R2 Standard | Windows Server 2016 Standard or Datacenter |
| Windows Server 2012 R2 Datacenter | Windows Server 2016 Datacenter |
| Windows Server 2012 R2 Essentials | Windows Server 2016 Essentials |
| Windows Storage Server 2012 Standard | Windows Storage Server 2016 Standard |
| Windows Storage Server 2012 Workgroup | Windows Storage Server 2016 Workgroup |
| Windows Storage Server 2012 R2 Standard | Windows Storage Server 2016 Standard |
| Windows Storage Server 2012 R2 Workgroup | Windows Storage Server 2016 Workgroup |

## Per-server-role considerations for upgrading

Even in supported upgrade paths from previous retail versions to Windows Server 2016, certain server roles that are already installed might require additional preparation or actions for the role to continue functioning after the upgrade. Consult the specific TechNet Library topics for each server role you intend to upgrade for details of additional steps that might be required.
