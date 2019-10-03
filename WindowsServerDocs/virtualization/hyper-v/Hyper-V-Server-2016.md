---
title: Microsoft Hyper-V Server 2016
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: f815ada0-4c63-4e73-9c24-dc5eb21526c7
author: KBDAzure
ms.author: kathydav
ms.date: 07/26/2017
---
# Microsoft Hyper-V Server 2016

Microsoft Hyper-V Server 2016 is a stand\-alone product that contains only the Windows hypervisor, a Windows Server driver model, and virtualization components. It provides a simple and reliable virtualization solution to help you improve your server utilization and reduce costs.

The Windows hypervisor technology in Microsoft Hyper-V Server 2016 is the same as what's in the Hyper\-V role on Windows Server 2016. So, much of the content available for the Hyper\-V role on Windows Server 2016 also applies to Microsoft Hyper-V Server 2016.

## Hyper\-V Server resources for IT Pros

|Tasks|Resources|
|-|-|
|![Meets requirements symbol](media/All_Symbols_MeetsRequirements.png)|**Evaluate Hyper-V**<br /><br />-   [Hyper-V Technology Overview](hyper-v-technology-overview.md)<br />- [What's new in Hyper-V on Windows Server 2016](what-s-new-in-hyper-v-on-windows.md)<br />-   [System requirements for Hyper-V on Windows Server 2016](system-requirements-for-hyper-v-on-windows.md)<br />-   [Supported Windows guest operating systems for Hyper-V](supported-windows-guest-operating-systems-for-hyper-v-on-windows.md)<br />-   [Supported Linux and FreeBSD Virtual Machines](supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows.md)<br />-   [Feature compatibility by generation and guest](hyper-v-feature-compatibility-by-generation-and-guest.md)<br /><br />**Plan for Hyper-V**<br /><br />- Decide which [virtual machine generation](plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md)  meets your needs. <br/>- If you're moving or importing virtual machines, decide when to [upgrade the version](deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md). <br />- [Scalability](plan/plan-hyper-v-scalability-in-windows-server.md) <br />- [Networking](plan/plan-hyper-v-networking-in-windows-server.md) <br />- [Security](plan/plan-hyper-v-security-in-windows-server.md)|
|![Get started symbol](media/All_Symbols_GetStarted.png)|**Get started with Hyper-V Server**<br /><br />[Download and install Microsoft Hyper\-V Server 2016](https://www.microsoft.com/evalcenter/evaluate-hyper-v-server-2016). This installs the Windows hypervisor, a Windows Server driver model, and virtualization components. It's similar to running the Server Core installation option of Windows Server 2016 and the Hyper\-V role.|
|![Manage symbol](media/All_Symbols_Administrator.png)|**Configure and manage Hyper-V Server**<br /><br />Hyper\-V Server doesn't have a graphical user interface \(GUI\). You can use the following tools to configure and manage Hyper\-V Server.<br /><br />-   [Configure a Server Core installation of Windows Server 2016 with Sconfig.cmd](../../get-started/sconfig-on-ws2016.md) to update domain or workgroup settings, change Windows Update settings, enable remote management, and more.<br />-   Use an ordinary [command prompt](../../administration/windows-commands/windows-commands.md) for commands not available in Sconfig.<br />-   Use [Hyper\-V Manager](https://msdn.microsoft.com/virtualization/hyperv_on_windows/user_guide/remote_host_management) or [Virtual Machine Manager](https://docs.microsoft.com/system-center/vmm) to remotely manage  Hyper\-V Server. To use Hyper\-V Manager, [install the Hyper\-V role on Windows 10](https://docs.microsoft.com/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v) or [Windows Server 2016](get-started/install-the-hyper-v-role-on-windows-server.md).<br />-   See [Install Server Core](../../get-started/getting-started-with-server-core.md) for additional management options for basic server functions that aren't specific to Hyper\-V. Most of the management methods documented there also work with Hyper\-V Server.<br /><br />**Configure and manage Hyper\-V virtual machines**<br /><br />-   [Create a virtual switch for Hyper-V virtual machines](get-started/create-a-virtual-switch-for-hyper-v-virtual-machines.md)<br />-   [Create a virtual machine in Hyper-V](get-started/create-a-virtual-machine-in-hyper-v.md)<br />-   [Choose between standard or production checkpoints](manage/choose-between-standard-or-production-checkpoints-in-hyper-v.md)<br />-   [Enable or disable checkpoints](manage/enable-or-disable-checkpoints-in-hyper-v.md)<br />-   [Manage Windows virtual machines with PowerShell Direct](manage/manage-windows-virtual-machines-with-powershell-direct.md) <br /><br />**Deploy**<br /><br />-   [Set up hosts for live migration without Failover Clustering](deploy/set-up-hosts-for-live-migration-without-failover-clustering.md)<br />- [Upgrade Windows Server cluster nodes](../../failover-clustering/cluster-operating-system-rolling-upgrade.md)<br />- [Upgrade virtual machine version](deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md)<br />|
