---
title: Install Server Core
description: "Explains how to obtain and install a Server Core installation " 
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 02/22/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d22818c-fbb7-487a-bb82-81ef0a3f7ede
author: jaimeo
ms.author: jaimeo
manager: elizapo
---
# Install Server Core
> Applies To: Windows Server 2016
  

When you install Windows Server 2016 using the Setup wizard, you can choose between **Windows Server 2016** and **Windows Server (Server with Desktop Experience)**. The Server with Desktop Experience option is the Windows Server 2016 equivalent of the Full installation option available in Windows Server 2012 R2 with the Desktop Experience feature installed. If you do not make a choice in the Setup wizard, **Windows Server 2016** is installed; this is the **Server Core** installation option.

The Server Core option reduces the space required on disk, the potential attack surface, and especially the servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option. If you do feel you need the additional user interface elements, see [Install Server with Desktop Experience](Getting-Started-with-Server-with-Desktop-Experience.md). For an even more lightweight option, see [Install Nano Server](Getting-Started-with-Nano-Server.md).

With the Server Core option, the standard user interface (the "Server Graphical Shell") is not installed; you manage the server using the command line, Windows PowerShell, or by remote methods.

>[!NOTE]
>
>Unlike some previous releases of Windows Server, you cannot convert between Server Core and Server with Desktop Experience after installation. If you install Server Core and later decide to use Server with Desktop Experience, you should do a fresh installation.

**User interface:** command prompt

**Install, configure, uninstall server roles locally:** at a command prompt with Windows PowerShell.

**Install, configure, uninstall server roles remotely:** with Server Manager, Remote Server Administration Tools (RSAT), or Windows PowerShell.

>[!NOTE]
>
>For RSAT, you must use the Windows 10 version.
>Microsoft Management Console is not available locally.

**Server roles available:**

- Active Directory Certificate Services

- Active Directory Domain Services

- DHCP Server

- DNS Server

- File Services (including File Server Resource Manager)

- Active Directory Lightweight Directory Services (AD LDS)

- Hyper-V

- Print and Document Services

- Streaming Media Services

- Web Server (including a subset of ASP.NET)

- Windows Server Update Server

- Active Directory Rights Management Server

- Routing and Remote Access Server and the following sub-roles:

- Remote Desktop Services Connection Broker

- Licensing

- Virtualization

- Volume Activation Services

## Installation scenarios

### Evaluation
You can obtain a 180-day-licensed evaluation copy of Windows Server from [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016). Choose the **Windows Server 2016 | 64-bit ISO option** to download, or you can visit the **Windows Server 2016 | Virtual Lab**.

> [!IMPORTANT]  
> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, you can only perform this conversion from evaluation to retail with Windows Server 2016 that has been installed by using the Desktop Experience option (not the Server Core option). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.

### Clean installation

To install the Server Core installation option from the media, insert the media in a drive, restart the computer, and run Setup.exe. In the wizard that opens, select **Windows Server 2016** (Standard or Datacenter), and then complete the wizard.

### Upgrade
**Upgrade** means moving from your existing operating system release to a more recent release while staying on the same hardware.

If you already have a Server Core installation of the appropriate Windows Server product, you can upgrade it to a Server Core installation of the appropriate edition of Windows Server 2016, as indicated below.

> [!NOTE]  
> If you are upgrading from Server Core installations of Windows Server 2012 or Windows Server 2012 R2, you must use the **/compat ingnorewarning flag**. Otherwise, the upgrade will stop because the upgrade attempts to open an Internet Explorer warning, but Internet Explorer is not available in Server Core installations.

> [!IMPORTANT]  
> In this release, upgrade works best in virtual machines where specific OEM hardware drivers are not needed for a successful upgrade. Otherwise, migration is the recommended option.  

- In-place upgrades from 32-bit to 64-bit architectures are not supported. All editions of Windows Server 2016 are 64-bit only.
- In-place upgrades from one language to another are not supported.
- If the server is a domain controller, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](http://technet.microsoft.com/library/hh994618.aspx) for important information.
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
and Migration](http://technet.microsoft.com/windowsserver/dn458795).

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

------------------------------------------
If you need a different installation option, or if you've completed installation and are ready to deploy specific workloads, you can head [back to the main Windows Server 2016 page](windows-server-2016.md).

