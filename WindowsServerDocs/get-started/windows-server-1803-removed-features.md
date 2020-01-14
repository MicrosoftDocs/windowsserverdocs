---
title: Windows Server, version 1803 - Features that have been removed
description: Learn about features that will be removed or deprecated in Windows Server, version 1803, or a future release
ms.prod: windows-server
ms.mktglfcycl: plan
ms.localizationpriority: medium
ms.sitesec: library
author: jasongerend
ms.author: jgerend
ms.date: 10/22/2019
---
# Features removed or planned for replacement starting with Windows Server, version 1803

> Applies to: Windows Server, version 1803

Each release of Windows Server adds new features and functionality; we also occasionally remove features and functionality, usually because we've added a better option. Here are the details about the features and functionalities that we removed in Windows Server, version 1803.   

> [!TIP]
> - You can get early access to Windows Server builds by joining the [Windows Insider program](https://insider.windows.com) - this is a great way to test feature changes.
> - Have questions about other releases? Check out [Features removed or planned for replacement in Windows Server](../get-started-19/removed-features.md).

**The list is subject to change and might not include every affected feature or functionality.** 

## Features we removed in this release

We've removed the following features and functionalities from the installed product image in Windows Server, version 1803. Applications or code that depend on these features won't function in this release unless you use an alternate method.   

| Feature	 | Instead you can use... |
| ----------- | -------------------- |
| [File Replication Service](https://support.microsoft.com/help/4025991/windows-server-version-1709-no-longer-supports-frs)|File Replication Services, introduced in Windows Server 2003 R2, has been replaced by DFS Replication. You need to [migrate any domain controllers that user FRS to DFS Replication with SYSVOL](https://blogs.technet.microsoft.com/filecab/2014/06/25/streamlined-migration-of-frs-to-dfsr-sysvol/). |
| Hyper-V Network Virtualization (HNV)|[Network Virtualization](../networking/sdn/technologies/hyper-v-network-virtualization/whats-new-hyperv-network-virtualization-windows-server.md) is now included in Windows Server as part of the [Software Defined Networking](../networking/sdn/software-defined-networking.md) (SDN) solution, which also includes the Network Controller, Software Load Balancing, User-Defined Routing, and Access Control Lists. |

## Features we're no longer developing

We are no longer actively developing these features and may remove them from a future update. Some features have been replaced with other features or functionality, while others are now available from different sources. 

>[!NOTE]
> Please note that some of the features and roles described below are not included in the Server Core installation option, which is provided in Windows Server, version 1803. They *are* present in the Server with Desktop Experience installation option, which we last released with Windows Server 2016 and will release again in Windows Server 2019.

If you have feedback about the proposed replacement of any of these features, you can use the [Feedback Hub app](https://support.microsoft.com/help/4021566/windows-10-send-feedback-to-microsoft-with-feedback-hub-app). 

| Feature or role	 | Instead you can use... |
| ----------- | --------------------- |
| Business Scanning, also called Distributed Scan Management (DSM)|The [Scan Management functionality](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759124\(v%3dws.11\)) was introduced in Windows Server 2008 R2 and enabled secure scanning and the management of scanners in an enterprise. We're no longer investing in this feature, and there are no devices available that support it. |
| IPv4/6 Transition Technologies (6to4, ISATAP, and Direct Tunnels)|6to4 has been disabled by default since Windows 10, version 1607 (the Anniversary Update), ISATAP has been disabled by default since Windows 10, version 1703 (the Creators Update), and Direct Tunnels has always been disabled by default. Please use native IPv6 support instead. |
| [MultiPoint Services](../remote/multipoint-services/multipoint-services.md)|We're no longer developing the MultiPoint Services role as part of Windows Server. MultiPoint Connector services are available through [Feature on Demand](https://docs.microsoft.com/windows-hardware/manufacture/desktop/features-on-demand-v2--capabilities) for both Windows Server and Windows 10. You can use [Remote Desktop Services](../remote/remote-desktop-services/welcome-to-rds.md), in particular the Remote Desktop Services Session Host, to provide RDP connectivity. |
| [Offline symbol packages](https://docs.microsoft.com/windows-hardware/drivers/debugger/debugger-download-symbols) (Debug symbol MSIs)|We're no longer making the symbol packages available as a downloadable MSI. Instead, the [Microsoft Symbol Server is moving to be an Azure-based symbol store](https://blogs.msdn.microsoft.com/windbg/2017/10/18/update-on-microsofts-symbol-server/). If you need the Windows symbols, connect to the Microsoft Symbol Server to cache your symbols locally or use a manifest file with SymChk.exe on a computer with internet access. |
| [Remote Desktop Connection Broker and Remote Desktop Virtualization Host](../remote/remote-desktop-services/desktop-hosting-service.md) in a Server Core installation|Most Remote Desktop Services deployments have these roles co-located with the Remote Desktop Session Host (RDSH), which requires Server with Desktop Experience; to be consistent with RDSH we're changing these roles to also require Server with Desktop Experience. We're no longer developing these RDS roles for use in a [Server Core installation](../administration/server-core/what-is-server-core.md). If you need to [deploy these roles as part of your Remote Desktop infrastructure](../remote/remote-desktop-services/rds-deploy-infrastructure.md), you can [install them on Windows Server 2016 with Desktop Experience](getting-started-with-server-with-desktop-experience.md). <br/><br/>These roles are also included in the Desktop Experience installation option of Windows Server 2019. You can test them in the [Windows Insider build of Windows Server 2019](https://docs.microsoft.com/windows-insider/at-work/) – just be sure to choose the LTSC image. |
| [RemoteFX 3D Video Adapter (vGPU)](../remote/remote-desktop-services/rds-remotefx-vgpu.md)|We're developing new graphics acceleration options for virtualized environments. You can also use [Discrete Device Assignment (DDA)](../virtualization/hyper-v/plan/plan-for-deploying-devices-using-discrete-device-assignment.md) as an alternative. |
| [Software Restriction Policies](../identity/software-restriction-policies/software-restriction-policies.md) in Group Policy|Instead of using the Software Restriction Policies through Group Policy, you can use [AppLocker](https://docs.microsoft.com/windows/security/threat-protection/applocker/applocker-overview) or [Windows Defender Application Control](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control) to control which apps users can access and what code can run in the kernel. |
| Storage Spaces in a Shared configuration using a SAS fabric|Deploy [Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-overview.md) instead. Storage Spaces Direct supports the use of HLK-certified SAS enclosures, but in a non-shared configuration, as described in the [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md). |
| Windows Server Essentials Experience|We're no longer developing the Essentials Experience role for the Windows Server Standard or Windows Server Datacenter SKUs. If you need an easy-to-use server solution for small-to-medium businesses, check out our new [Microsoft 365 for business](https://www.microsoft.com/microsoft-365/business) solution, or use [Windows Server 2016 Essentials](https://docs.microsoft.com/windows-server-essentials/get-started/get-started). |

