---
title: Upgrading your Remote Desktop Services deployments to Windows Server 2016 
description: This article describes how to upgrade your existing Remote Desktop Services deployments to Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: spatnaik
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f7b1f1f6-57c8-40ab-a235-e36240dcc1f8
author: spatnaik
manager: scottman
notes: http://social.technet.microsoft.com/wiki/contents/articles/22069.remote-desktop-services-upgrade-guidelines-for-windows-server-2012-r2.aspx
---
# Upgrading your Remote Desktop Services deployments to Windows Server 2016

>Applies To: Windows Server 2016

## Supported OS upgrades with RDS role installed
Upgrades to Windows Server 2016 are supported only from Windows Server 2012 R2 and Windows Server 2016 Technical Preview 5.

## Flow for deployment upgrades
In order to keep the down-time to a minimum, it is best to follow the steps below:

1. **RD Connection Broker servers** should be the first to be upgraded. If there is active/active setup in the deployment, all servers should be upgraded in the same time. 
The deployment will not be available during RD Connection Broker servers upgrade.
   > [!NOTE] 
   > It is mandatory to upgrade RD Connection Broker servers. We do not support Windows Server 2012 R2 RD Connection Broker servers in a mixed deployment with Windows Server 2016 servers. Once the RD Connection Broker server(s) are running Windows Server 2016 the deployment will be functional, even if the rest of the servers in the deployment are still running Windows Server 2012 R2.

2. **RD Session Host servers** can be upgraded next. To avoid down time during upgrade the admin can split the servers to be upgraded in 2 steps as detailed below. All will be functional after the upgrade. To upgrade, use the steps described in [Upgrading Remote Desktop Session Host servers to Windows Server 2016](Upgrade-to-RDSH-2016.md).

3. **RD Virtualization Host servers** can be upgraded next. To upgrade, use the steps described in [Upgrading Remote Desktop Virtualization Host servers to Windows Server 2016](Upgrade-to-RDVH-2016.md).

4. **RD Web Access servers** can be upgraded anytime.
   > [!NOTE]
   > Upgrading RD Web may reset IIS properties (such as any configuration files). To not lose your changes, make notes or copies of customizations done to the RD Web site in IIS.

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Web Access servers will work with Windows Server 2016 deployments.

5. **RD Licensing servers** can be upgraded anytime.
   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Licensing servers will work with Windows Server 2016 deployments.

6. **RD Gateway servers** can be upgraded anytime.
   > [!NOTE]
   > Windows Server 2016 does not include Network Access Protection (NAP) policies - they will have to be removed. The easiest way to remove the correct policies is by running the upgrade wizard. If there are any NAP policies you must delete, the upgrade will block and create a text file on the desktop that includes the specific policies. To manage NAP policies, open the Network Policy Server tool. After deleting them, click **Refresh** in the Setup tool to continue with the upgrade process. 

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Gateway servers will work with Windows Server 2016 deployments.

## VDI deployment – supported guest OSs 
Windows Server 2016 RD Virtualization Host servers support the following guest OSs:

- Windows 10 Enterprise
- Windows 8.1 Enterprise 
- Windows 8 Enterprise 
- Windows 7 SP1 Enterprise 

The table below shows the supported RD Virtualization Hosts operating systems and guest operating system combinations:

| RDVH OS Version        | Guest OS Version           |
| ------------- |-------------|
| Windows Server 2016      | Windows 7 SP1, Windows 8, Windows 8.1, Windows 10 |
| Windows Server 2012 R2   | Windows 7 SP1, Windows 8, Windows 8.1 |
| Windows Server 2012      | Windows 7 SP1, Windows 8, Windows 8.1 |

> [!NOTE]  
> - Windows Server 2016 Remote Desktop Services does not support heterogeneous collections. All VMs in a collection must be same OS version. 
> - You can have separate homogeneous collections with different guest OS versions on the same host. 
> - VM templates must be created on a Windows Server 2016 Hyper-V host to used as guest OS on a Windows Server 2016 Hyper-V host.

## VDI deployment – supported guest OS upgrade
Administrators will have the following options to upgrade of VM collections:

### Upgrade Managed Shared VM collections 
Administrators will need to create VM templates with the desired OS version and use it to patch all the VMs in the pool. 

We support the following patching scenarios:
- Windows 7 SP1 can be patched to Windows 8 or Windows 8.1
- Windows 8 can be patched to Windows 8.1
- Windows 8.1 can be patched to Windows 10

### Upgrade unmanaged shared VM collections 
End users cannot upgrade their personal desktops. Administrators should perform the upgrade. The exact steps are still to be determined.