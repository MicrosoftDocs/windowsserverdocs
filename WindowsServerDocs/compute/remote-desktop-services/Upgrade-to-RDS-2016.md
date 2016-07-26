---
title: Upgrading your Remote Desktop Services deployments to Windows Server 2016 
description: This article describes how to upgrade your existing Remote Desktop Services deployments to Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: [GET ONE FROM guidgenerator.com]
author: spatnaik
manager: scottman
notes: http://social.technet.microsoft.com/wiki/contents/articles/22069.remote-desktop-services-upgrade-guidelines-for-windows-server-2012-r2.aspx

---
# Upgrading your Remote Desktop Services deployments to Windows Server 2016

>Applies To: Windows Server Technical Preview

## Supported OS upgrades with RDS role installed

RDS roles upgrades to Windows Server 2016 are supported only from Windows Server 2012 R2 and Windows Server 2016 TP5.

## Flow for Deployment upgrades

In order to keep the down-time to a minimum, it is best to follow the steps below:

1. **RD Connection Broker servers** should be the first to be upgraded. If there is active/active setup in the deployment - all servers should be upgraded in the same time. 
The deployment will not be available during RD Connection Broker servers upgrade.

   > [!NOTE] 
   > It is mandatory to upgrade RD Connection Broker servers. We do not support Windows Server 2012 R2 RD Connection Broker servers in a mixed deployment with Windows Server 2016 servers. Once the RD Connection Broker server(s) are running Windows Server 2016 the deployment will be functional, even if the rest of the servers in the deployment are still running Windows Server 2012 R2.

2. **RD Session Host servers** can be upgraded next to avoid down time during upgrade the admin can split the servers to be upgraded in 2 steps detailed below. All will be functional after the upgrade. To upgrade, use the steps described in [Upgrading Remote Desktop Session Host servers to Windows Server 2016](https://daringfireball.net/projects/markdown/syntax).

3. **RD Virtualization Host servers** can be upgraded next. To upgrade, use the steps described in [Upgrading Remote Desktop Virtualization Host servers to Windows Server 2016](https://daringfireball.net/projects/markdown/syntax).

4. **RD Web Access servers** can be upgraded anytime. To upgrade, use the steps described in [Upgrading Remote Desktop Web Access servers to Windows Server 2016](https://daringfireball.net/projects/markdown/syntax).

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Web Access servers will work with Windows Server 2016 deployments.

5. **RD License servers** can be upgraded anytime. To upgrade, use the steps described in [Upgrading Remote Desktop License servers to Windows Server 2016](https://daringfireball.net/projects/markdown/syntax).

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD License servers will work with Windows Server 2016 deployments.

6. **RD Gateway servers** can be upgraded anytime. To upgrade, use the steps described in [Upgrading Remote Desktop Gateway servers to Windows Server 2016](https://daringfireball.net/projects/markdown/syntax).

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Gateway servers will work with Windows Server 2016 deployments.


## VDI deployment – supported guest OSs 

On Windows Server 2016 RD Virtualization Host servers we support the following guest OSs:

1. Windows 10 Enterprise
2. Windows 8.1 Enterprise 
3. Windows 8 Enterprise 
4. Windows 7 SP1 Enterprise 

The table below shows the supported RD Virtualization Hosts operating systems and guest operating system combinations:

| RDVH OS Version        | Guest OS Version           |
| ------------- |-------------|
| Windows Server 2016      | Windows 7 SP1, Windows 8, Windows 8.1, Windows 10 |
| Windows Server 2012 R2   | Windows 7 SP1, Windows 8, Windows 8.1 |
| Windows Server 2012      | Windows 7 SP1, Windows 8, Windows 8.1 |

> [!NOTE]  
> - We do not support heterogeneous collections. All VMs in a collection must be same OS version. 
> - We do support having separate homogeneous collections with different guest OS version on the same host. 
> - VM templates must be created on a Windows Server 2016 Hyper-V host to be able to use as guest OS on a Windows Server 2016 Hyper-V host.


## VDI deployment – supported guest OS upgrade

 
Administrators will have the following options to upgrade of VM collections:

### Upgrade Managed Shared VM collections 

Administrators will need to create VM templates with the desired OS version and use it to patch all the VMs in the pool. 

We support the following patching scenarios:
- Windows 7 SP1 can be patched to Windows 8 or Windows 8.1
- Windows 8 can be patched to Windows 8.1
- Windows 8.1 can be patched to Windows 10

### Upgrade Unmanaged Shared VM collections 

End users cannot upgrade their personal desktops. Administrators should perform the upgrade. The exact steps are still to be determined.
