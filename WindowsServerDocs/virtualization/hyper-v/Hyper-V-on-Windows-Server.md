---
title: Hyper-V on Windows Server
description: "Provides links to key articles about trying out, planning, deploying, and managing Hyper-V"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0baef6b8-598c-4fe0-9f31-5869fc4e0f69
author: KBDAzure
ms.author: kathydav
ms.date: 10/07/2016
---
# Hyper-V on Windows Server

>Applies To: Windows Server 2016, Windows Server 2019

The Hyper-V role in Windows Server lets you create a virtualized computing environment where you can create and manage virtual machines. You can run multiple operating systems on one physical computer and isolate the operating systems from each other. With this technology, you can improve the efficiency of your computing resources and free up your hardware resources.

See the topics in the following table to learn more about Hyper-V on Windows Server.

## Hyper-V resources for IT Pros

|Task |Resources|
|---|---|
|![Check mark and document icon to show requirements are met](media/All_Symbols_MeetsRequirements.png)|**Evaluate Hyper-V**<br /><br />- [Hyper-V Technology Overview](Hyper-V-Technology-Overview.md)<br />- [What's new in Hyper-V on Windows Server](What-s-new-in-Hyper-V-on-Windows.md)<br />- [System requirements for Hyper-V on Windows Server](System-requirements-for-Hyper-V-on-Windows.md)<br />- [Supported Windows guest operating systems for Hyper-V](Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows.md) <br />- [Supported Linux and FreeBSD virtual machines](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)<br />- [Feature compatibility by generation and guest](Hyper-V-feature-compatibility-by-generation-and-guest.md) <br /><br />**Plan for Hyper-V**<br /><br />- [Should I create a generation 1 or 2 virtual machine in Hyper-V?](plan/Should-I-create-a-generation-1-or-2-virtual-machine-in-Hyper-V.md) <br />- [Plan for Hyper-V scalability in Windows Server](plan/plan-hyper-v-scalability-in-windows-server.md) <br />- [Plan for Hyper-V networking in Windows Server](plan/plan-hyper-v-networking-in-windows-server.md) <br />- [Plan for Hyper-V security in Windows Server](plan/plan-hyper-v-security-in-windows-server.md)|
|![Cursor and sunburst icon](media/All_Symbols_GetStarted.png)|**Get started with Hyper-V**<br /><br />- [Download and install Windows Server 2019](https://www.microsoft.com/evalcenter/evaluate-windows-server-2019)<br /><br />**Server Core or GUI installation option of Windows Server 2019 as virtual machine host**<br /><br />- [Install the Hyper-V role on Windows Server](get-started/Install-the-Hyper-V-role-on-Windows-Server.md)<br />- [Create a virtual switch for Hyper-V virtual machines](get-started/Create-a-virtual-switch-for-Hyper-V-virtual-machines.md)<br />- [Create a virtual machine in Hyper-V](get-started/Create-a-virtual-machine-in-Hyper-V.md)|
|![Person and tools icon](media/All_Symbols_Administrator.png)|**Upgrade Hyper-V hosts and virtual machines**<br /><br />- [Upgrade Windows Server cluster nodes](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md)<br />- [Upgrade virtual machine version](deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md)<br /><br />**Configure and manage Hyper-V**<br /><br />- [Set up hosts for live migration without Failover Clustering](deploy/Set-up-hosts-for-live-migration-without-Failover-Clustering.md)<br />- [Managing Nano Server remotely](../../get-started/manage-nano-server.md)<br />- [Choose between standard or production checkpoints](manage/Choose-between-standard-or-production-checkpoints-in-Hyper-V.md)<br />- [Enable or disable checkpoints](manage/Enable-or-disable-checkpoints-in-Hyper-V.md)<br />- [Manage Windows virtual machines with PowerShell Direct](manage/Manage-Windows-virtual-machines-with-PowerShell-Direct.md)<br />- [Set up Hyper-V Replica](manage/Set-up-Hyper-V-Replica.md)|
|![Conversation bubbles icon](media/All_Symbols_Chat.png)|**Blogs**<br /><br />Check out the latest posts from Program Managers, Product Managers, Developers and Testers in the Microsoft Virtualization and Hyper-V teams.<br /><br />- [Virtualization Blog](https://blogs.technet.com/b/virtualization/)<br />- [Windows Server Blog](https://blogs.technet.com/b/windowsserver/)<br />- [Ben Armstrong's Virtualization Blog](https://blogs.msdn.com/b/virtual_pc_guy/) (archived)|
|![User group icon](media/All_Symbols_Users_Group.png)|**Forum and newsgroups**<br /><br />Got questions? Talk to your peers, MVPs, and the Hyper-V product team.<br /><br />- [Windows Server Community](https://techcommunity.microsoft.com/t5/Windows-Server/ct-p/Windows-Server)<br />- [Windows Server Hyper-V TechNet forum](https://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserverhyperv)|

## Related technologies

The following table lists technologies that you might want to use in your virtualization computing environment.

|Technology|Description|
|--------------|---------------|
|[Client Hyper-V](https://docs.microsoft.com/virtualization/hyper-v-on-windows/index)|Virtualization technology included with Windows 8, Windows 8.1 and Windows 10 that you can install through **Programs and Features** in the **Control Panel**.|
|[Failover Clustering](https://docs.microsoft.com/windows-server/failover-clustering/whats-new-in-failover-clustering)|Windows Server feature that provides high availability for Hyper-V hosts and virtual machines.|
|[Virtual Machine Manager](https://docs.microsoft.com/system-center/vmm/overview)|System Center component that provides a management solution for the virtualized datacenter. You can configure and manage your virtualization hosts, networks, and storage resources so you can create and deploy virtual machines and services to private clouds that you've created.|
|[Windows Containers](https://docs.microsoft.com/virtualization/windowscontainers/)|Use Windows Server and Hyper-V containers to provide standardized environments for development, test, and production teams.|