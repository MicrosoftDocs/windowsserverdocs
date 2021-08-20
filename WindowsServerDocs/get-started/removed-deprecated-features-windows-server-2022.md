---
title: Features removed or no longer developed starting with Windows Server 2022
description: Learn about the features and functionalities removed or no longer developed starting with Windows Server 2022.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 6/24/2021
ms.prod: windows-server
---

# Features removed or no longer developed starting with Windows Server 2022

Each release of Windows Server adds new features and functionality; we also occasionally remove features and functionality, usually because we've added a better option. Here are the details about the features and functionalities that we removed in Windows Server 2022.

> [!TIP]
>
> - You can get early access to Windows Server builds by joining the [Windows Insider Program for Business](https://insider.windows.com/for-business) - this is a great way to test feature changes.

**The list is subject to change and might not include every affected feature or functionality.**

## Semi-Annual Channel

As part of our customer-centric approach, we’ll move to the Long-Term Servicing Channel (LTSC) as our primary release channel. Current Semi-Annual Channel (SAC) releases will continue through their mainstream support end dates, which are May 10, 2022 for Windows Server version 20H2 and December 14, 2021 for Windows Server version 2004

The focus on container and microservice innovation previously released in the Semi-Annual Channel will now continue with [Azure Kubernetes Service (AKS)](/azure/aks/), [AKS on Azure Stack HCI](/azure-stack/aks-hci/), and other platform improvements made in collaboration with the Kubernetes community. And with the Long-Term Servicing Channel, a major new version of Windows Server will be released every 2-3 years, so customers can expect both container host and container images to align with that cadence.

## Features we've removed in this release

We're removing the following features and functionalities from the installed product image in Windows Server 2022. Applications or code that depend on these features won't function in this release unless you use an alternate method.

| Feature | Explanation |
|--|--|
| Internet Storage Name Service (iSNS) Server service | The iSNS Server service has now been removed from Windows Server 2022 after it was considered for removal in Windows Server, version 1709. You can still connect to iSNS servers or add iSCSI targets individually. |

## Features we're no longer developing

We're no longer actively developing these features and may remove them from a future update. Some features have been replaced with other features or functionality, while others are now available from different sources.

| Feature | Explanation |
|--|--|
| Guarded Fabric and Shielded Virtual Machines (VMs) | Windows Server and Azure Stack HCI are aligning with Azure to take advantage of continuing enhancements to [Azure Confidential Computing](/azure/confidential-computing/) and [Azure Security Center](/azure/security-center/). Having this alignment translates to more cloud security offerings being extended to customer data centers (on-premises).<br/><br/>Microsoft will continue to provide support for these features, but there will be no further development. On client versions of Windows the Remote Server Administration Tools (RSAT): Shielded VM Tools feature will be removed. |
| Launching SConfig from a command prompt (CMD) window by running `sconfig.cmd` | Starting with Windows Server 2022, [SConfig is launched **by default** when you sign in](/windows-server/windows-server-2022/get-started/sconfig-on-ws2022) to a server running Server Core installation option. Moreover, PowerShell is now the default shell on Server Core. If you exit SConfig, you get to a regular interactive PowerShell window. Similarly, you can opt out from SConfig autolaunch. In this case, you will get a PowerShell window at sign-in. In either scenario, you can launch SConfig from PowerShell by simply running `SConfig`. If needed, you can launch the legacy command prompt (CMD) from PowerShell as well. But to simplify different transition options, we're going to remove `sconfig.cmd` from the next version of the operating system. If you need to start SConfig from a CMD window, you will have to launch PowerShell first. |
| Windows Deployment Services (WDS) boot.wim image deployment | The operating system deployment functionality of WDS is being partially deprecated. Workflows that rely on boot.wim from Windows Server 2022 installation media will show a non-blocking deprecation notice, but the workflows will otherwise not be impacted.<br><br>Windows 11 workflows and workflows for future versions of Windows Server that rely on boot.wim from installation media will be blocked.<br><br>Alternatives to WDS, such as [Microsoft Endpoint Configuration Manager](/mem/configmgr/) or the [Microsoft Deployment Toolkit](/windows/deployment/deploy-windows-mdt/get-started-with-the-microsoft-deployment-toolkit) (MDT), provide a better, more flexible, and feature-rich experience for deploying Windows images. You are advised to move to one of these solutions instead.<br><br>WDS PXE boot is not affected. You can still use WDS to PXE boot devices to custom boot images. You can also still [run setup from a network share](/windows-hardware/manufacture/desktop/deploy-a-custom-image). Workflows that use custom boot.wim images, such as with Configuration Manager or MDT, will also not be impacted by this change. |
