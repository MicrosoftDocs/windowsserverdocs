---
title: Install Server with Desktop Experience
description: "Explains how to obtain and install a Server with Desktop Experience installation " 
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.date: 01/18/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5b38b8a0-4dfc-4130-be00-fc58bba99595
author: jaimeo
ms.author: jaimeo
manager: dongill
ms.localizationpriority: medium
---
# Install Server with Desktop Experience
> Applies To: Windows Server 2016
  

When you install Windows Server 2016 using the Setup wizard, you can choose between **Windows Server 2016** and **Windows Server (Server with Desktop Experience)**. The Server with Desktop Experience option is the Windows Server 2016 equivalent of the Full installation option available in Windows Server 2012 R2 with the Desktop Experience feature installed. If you do not make a choice in the Setup wizard, **Windows Server 2016** is installed; this is the **Server Core** installation option.

The Server with Desktop Experience option installs the standard user interface and all tools, including client experience features that required a separate installation in Windows Server 2012 R2. Server roles and features are installed with Server Manager or by other methods. Compared with the Server Core option, it requires more space on disk,and has higher servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option. If you feel you can work without the additional elements, see [Install Server Core](Getting-Started-with-Server-Core.md). For an even more lightweight option, see [Install Nano Server](Getting-Started-with-Nano-Server.md).

> [!NOTE]
>
> Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. If you install Server with Desktop Experience and later decide to use Server Core, you should do a fresh installation.

**User interface:** standard graphical user interface ("Server Graphical Shell"). The Server Graphical Shell includes the new Windows 10 shell. The specific Windows features installed by default with this option are User-Interfaces-Infra, Server-GUI-Shell, Server-GUI-Mgmt-Infra, InkAndHandwritingServices, ServerMediaFoundation and Desktop Experience. While these features do appear in Server Manager in this release, uninstalling them is not supported and they will not be available in future releases.

**Install, configure, uninstall server roles locally:** with Server Manager or with Windows PowerShell

**Install, configure, uninstall server roles remotely:** with Server Manager, Remote Server, RSAT, or Windows PowerShell

**Microsoft Management Console: installed**

## Installation scenarios

### Evaluation
You can obtain a 180-day-licensed evaluation copy of Windows Server from [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016). Choose the **Windows Server 2016 | 64-bit ISO option** to download, or you can visit the **Windows Server 2016 | Virtual Lab**.

> [!IMPORTANT]  
> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, you can only perform this conversion from evaluation to retail with Windows Server 2016 that has been installed by using the Desktop Experience option (not the Server Core option). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.


### Clean installation

To install the Server with Desktop Experience installation option from the media, insert the media in a drive, restart the computer, and run Setup.exe. In the wizard that opens, select **Windows Server (Server with Desktop Experience)** (Standard or Datacenter), and then complete the wizard.

### Upgrade
**Upgrade** means moving from your existing operating system release to a more recent release while staying on the same hardware.

If you already have a Full installation of the appropriate Windows Server product, you can upgrade it to a Server with Desktop Experience installation of the appropriate edition of Windows Server 2016, as indicated below.

> [!IMPORTANT]  
> In this release, upgrade works best in virtual machines where specific OEM hardware drivers are not needed for a successful upgrade. Otherwise, migration is the recommended option.  

- In-place upgrades from 32-bit to 64-bit architectures are not supported. All editions of Windows Server 2016 are 64-bit only.
- In-place upgrades from one language to another are not supported.
- If the server is a domain controller, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](https://technet.microsoft.com/library/hh994618.aspx) for important information.
- Upgrades from pre-release versions (previews) of Windows Server 2016 are not supported. Perform a clean installation to Windows Server 2016.
- Upgrades that switch from a Server Core installation to a Server with a Desktop installation (or vice versa) are not supported.

If you do not see your current version in the left column, upgrading to this release of Windows Server 2016 is not supported.

If you see more than one edition in the right column, upgrading to **either** edition from the same starting version is supported.

|If you are running this edition:|You can upgrade to these editions:|  
|-------------------|----------|  
|Windows Server 2012 Standard|Windows Server 2016 Standard or Datacenter|
|Windows Server 2012 Datacenter|Windows Server 2016 Datacenter|
|Windows Server 2012 R2 Standard|Windows Server 2016 Standard or Datacenter|
|Windows Server 2012 R2 Datacenter|Windows Server 2016 Datacenter|
|Windows Server 2012 R2 Essentials|Windows Server 2016 Essentials|
|Windows Storage Server 2012 Standard|Windows Storage Server 2016 Standard|
|Windows Storage Server 2012 Workgroup|Windows Storage Server 2016 Workgroup|
|Windows Storage Server 2012 R2 Standard|Windows Storage Server 2016 Standard|
|Windows Storage Server 2012 R2 Workgroup|Windows Storage Server 2016 Workgroup|

For many additional options for moving to Windows Server 2016, such as license conversion among volume licensed editions, evaluation editions, and others, see details at [Upgrade Options](Supported-Upgrade-Paths.md).

### Migration
**Migration** means moving from your existing operating system to Windows Server 2016 by performing a clean installation on a different set of hardware or virtual machine and then transferring the older server's workloads to the new server. Migration, which might vary considerably depending on the server roles you have installed, is discussed in detail at [Windows Server Installation, Upgrade,
and Migration](https://technet.microsoft.com/windowsserver/dn458795).

The ability to migrate varies among different server roles. The follwogin grid explains your server role upgrade and migration options specifically for moving to Windows Server 2016. For individual role migration guides, visit [Migrating Roles and Features in Windows Server](https://technet.microsoft.com/windowsserver/jj554790.aspx). For more information about installation and upgrades, see [Windows Server Installation, Upgrade, and Migration](https://technet.microsoft.com/windowsserver/dn458795).

|Server Role|Upgradeable from Windows Server 2012 R2?|Upgradeable from Windows Server 2012?|Migration Supported?|Can migration be completed without downtime?|  
|-------------------|----------|--------------|--------------|----------|  
|Active Directory Certificate Services|	Yes|	Yes|	Yes|	No|
|Active Directory Domain Services|	Yes|	Yes|	Yes|	Yes|
|Active Directory Federation Services|	No|	No|	Yes|	No (new nodes need to be added to the farm)|
|Active Directory Lightweight Directory Services|	Yes|	Yes|	Yes|	Yes|
|Active Directory Rights Management Services|	Yes|	Yes|	Yes|	No|
|Failover Cluster|Yes with [Cluster OS Rolling Upgrade](https://technet.microsoft.com/windows-server-docs/failover-clustering/cluster-operating-system-rolling-upgrade) process which includes node Pause-Drain, Evict, upgrade to Windows Server 2016 and rejoin the original cluster. Yes, when the server is removed by the cluster for upgrade and then added to a different cluster.|Not while the server is part of a cluster. Yes, when the server is removed by the cluster for upgrade and then added to a different cluster.	|Yes|No for Windows Server 2012 Failover Clusters. Yes for Windows Server 2012 R2 Failover Clusters with Hyper-V VMs or Windows Server 2012 R2 Failover Clusters running the Scale-out File Server role. See [Cluster OS Rolling Upgrade](https://technet.microsoft.com/windows-server-docs/failover-clustering/cluster-operating-system-rolling-upgrade).|
|File and Storage Services|	Yes|	Yes|	Varies by sub-feature|	No|
|Print and Fax Services|	No|	No|	Yes (Printbrm.exe)|	No|
|Remote Desktop Services|	Yes, for all sub-roles, but mixed mode farm is not supported|	Yes, for all sub-roles, but mixed mode farm is not supported|	Yes|	No|
|Web Server (IIS)|	Yes|	Yes|	Yes|	No|
|Windows Server Essentials Experience|	Yes|	N/A – new feature|	Yes|	No|
|Windows Server Update Services|	Yes|	Yes|	Yes|	No|
|Work Folders|	Yes|	Yes|	Yes|	Yes from WS 2012 R2 cluster when using [Cluster OS Rolling Upgrade](https://technet.microsoft.com/windows-server-docs/failover-clustering/cluster-operating-system-rolling-upgrade).|

> [!IMPORTANT]  
> Once Setup has completed and immediately after you have installed all of the server roles and features you need, check for and install updates available for Windows Server 2016 by using Windows Update or other update methods.

---------------------------------------
If you need a different installation option, or if you've completed installation and are ready to deploy specific workloads, you can head [back to the main Windows Server 2016 page](Windows-Server-2016.md).