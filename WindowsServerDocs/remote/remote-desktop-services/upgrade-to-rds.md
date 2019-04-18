---
title: Upgrading your Remote Desktop Services deployments to Windows Server 2016 
description: This article describes how to upgrade your existing Remote Desktop Services deployments to Windows Server 2016.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: spatnaik
ms.date: 03/20/2018
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f7b1f1f6-57c8-40ab-a235-e36240dcc1f8
author: spatnaik
manager: scottman
notes: https://social.technet.microsoft.com/wiki/contents/articles/22069.remote-desktop-services-upgrade-guidelines-for-windows-server-2012-r2.aspx
---
# Upgrading your Remote Desktop Services deployments to Windows Server 2016

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

## Supported OS upgrades with RDS role installed
Upgrades to Windows Server 2016 are supported only from Windows Server 2012 R2 and Windows Server 2016.

## Flow for deployment upgrades
In order to keep the down-time to a minimum, it is best to follow the steps below:

1. **RD Connection Broker servers** should be the first to be upgraded. If there is active/active setup in the deployment, remove all but one server from the deployment and perform an in-place upgrade. Perform upgrades on the remaining RD Connection Broker servers offline and then re-add them to the deployment. The deployment will not be available during RD Connection Broker servers upgrade.

   > [!NOTE] 
   > It is mandatory to upgrade RD Connection Broker servers. We do not support Windows Server 2012 R2 RD Connection Broker servers in a mixed deployment with Windows Server 2016 servers. Once the RD Connection Broker server(s) are running Windows Server 2016 the deployment will be functional, even if the rest of the servers in the deployment are still running Windows Server 2012 R2.

2. **RD License servers** should be upgraded before you upgrade your RD Session Host servers.
   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD license servers will work with Windows Server 2016 deployments, but they can only process CALs from Windows Server 2012 R2 and older. They cannot use Windows Server 2016 CALs. See [License your RDS deployment with client access licenses (CALs)](rds-client-access-license.md) for more information about RD license servers.

3. **RD Session Host servers** can be upgraded next. To avoid down time during upgrade the admin can split the servers to be upgraded in 2 steps as detailed below. All will be functional after the upgrade. To upgrade, use the steps described in [Upgrading Remote Desktop Session Host servers to Windows Server 2016](upgrade-to-rdsh.md).

4. **RD Virtualization Host servers** can be upgraded next. To upgrade, use the steps described in [Upgrading Remote Desktop Virtualization Host servers to Windows Server 2016](upgrade-to-rdvh.md).

5. **RD Web Access servers** can be upgraded anytime.
   > [!NOTE]
   > Upgrading RD Web may reset IIS properties (such as any configuration files). To not lose your changes, make notes or copies of customizations done to the RD Web site in IIS.

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Web Access servers will work with Windows Server 2016 deployments.

6. **RD Gateway servers** can be upgraded anytime.
   > [!NOTE]
   > Windows Server 2016 does not include Network Access Protection (NAP) policies - they will have to be removed. The easiest way to remove the correct policies is by running the upgrade wizard. If there are any NAP policies you must delete, the upgrade will block and create a text file on the desktop that includes the specific policies. To manage NAP policies, open the Network Policy Server tool. After deleting them, click **Refresh** in the Setup tool to continue with the upgrade process. 

   > [!NOTE] 
   > Windows Server 2012 and 2012 R2 RD Gateway servers will work with Windows Server 2016 deployments.

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