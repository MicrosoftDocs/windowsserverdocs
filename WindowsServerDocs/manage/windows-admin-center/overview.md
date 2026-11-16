---
title: Windows Admin Center overview
description: Learn about Windows Admin Center and choose between Administration Mode for general administration and Virtualization Mode for virtualization infrastructure.
ms.topic: overview
author: davannaw-msft
ms.author: dawhite
ms.date: 08/22/2024
ai-usage: ai-assisted
---

# Windows Admin Center overview

Windows Admin Center is a browser-based management product for Windows Server infrastructure running in physical, virtual, on-premises, Azure, or hosted environments at no extra cost. It provides two management experiences: Administration Mode and Virtualization Mode.

To find out what's new, see [Release history](support/release-history.md).

## Choose a Windows Admin Center experience

Administration Mode and Virtualization Mode are part of the same Windows Admin Center product, but they serve different management scenarios. They're independent experiences that you install on separate systems, not modes that you switch between in a single deployment.

| Experience | Choose this experience when you need to |
|------------|------------------------------------------|
| **Administration Mode** | Perform general administration and troubleshooting for individual servers and clusters. This experience provides tools for areas such as events, certificates, devices, networking, registry, roles and features, storage, and updates. |
| **Virtualization Mode** | Centrally manage virtualization infrastructure across large-scale, distributed Hyper-V environments. This experience provides resource-focused views and parallel operations for hosts, clusters, virtual machines, storage, and networking. |

You can use both experiences in the same environment. To compare their architecture, scale, and capabilities, see [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md#operational-modes)

## Download now

**Download** [Windows Admin Center](https://www.microsoft.com/evalcenter/download-windows-admin-center) from the Microsoft Evaluation Center.

For help installing Administration Mode, see [Install Windows Admin Center](deploy/install.md). For help installing Virtualization Mode, see [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md). For tips on getting started, see [Get started](use/get-started.md).

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually downloading and installing Windows Admin Center. Each non-preview version is supported until 30 days after the next non-preview version is released. For more information, see the [Windows Admin Center support policy](support/index.md).

## Windows Admin Center scenarios

Here are a few things you can use Windows Admin Center for:

- **Simplify server management**: Manage your servers and clusters with modernized versions of familiar tools such as Server Manager. Install in under five minutes and manage servers in your environment immediately, no extra configuration required. For details, see [What is Windows Admin Center?](understand/what-is.md)

- **Work with hybrid solutions**: Integration with Azure helps you optionally connect your on-premises servers with relevant cloud services. For details, see [Azure hybrid services](azure/index.md).

- **Manage virtualization infrastructure**: Use Administration Mode to deploy and manage Windows Server hyperconverged clusters. For more information, see [Manage HCI](use/manage-hyper-converged.md). Use Virtualization Mode to centrally manage large-scale, distributed Hyper-V resources. For Azure Local management, see the [Azure Local documentation](/azure/azure-local/overview).

Here's a video to give you an overview, followed by a poster giving more details:
> [!VIDEO https://www.youtube.com/embed/WCWxAp27ERk]

:::image type="content" source="media/WAC1910-poster-thumb-small.png" alt-text="Diagram that gives an overview of the Windows Admin Center." lightbox="media/WAC1910-poster-thumb-small.png":::



## Windows Admin Center documentation at a glance

| Understand | Plan |
|------------|------|
| - [What is Windows Admin Center?](understand/what-is.md) <br> - [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md) <br> - [Frequently asked questions](understand/faq.yml)<br> - [Case studies](understand/case-studies.md) <br> - [Related management products](understand/related-management.md) | - [What type of installation is right for you?](plan/installation-options.md) <br> - [User access options](plan/user-access-options.md) <br> |

| Deploy | Configure |
|--------|-----------|
| - [Prepare your environment](deploy/prepare-environment.md) <br> - [Install Windows Admin Center](deploy/install.md) <br> - [Enable high availability](deploy/high-availability.md)  <br><br> | - [Windows Admin Center settings](configure/settings.md) <br> - [User access control and permissions](configure/user-access-control.md) <br> - [Shared connections](configure/shared-connections.md) <br> - [Extensions](configure/using-extensions.md) <br> - [Automate with PowerShell](configure/use-powershell.md) |

| Use | Connect to Azure |
|-----|------------------|
| - [Launch & add connections](use/get-started.md) <br> - [Manage servers](use/manage-servers.md) <br> - [Deploy hyperconverged infrastructure](use/deploy-hyperconverged-infrastructure.md) <br> - [Manage hyperconverged infrastructure](use/manage-hyper-converged.md) <br> - [Manage failover clusters](use/manage-failover-clusters.md) <br> - [Manage virtual machines](use/manage-virtual-machines.md) <br> - [Logging](use/logging.md) | - [Azure hybrid services](azure/index.md) <br> - [Connect Windows Admin Center to Azure](azure/azure-integration.md) <br> - [Deploy Windows Admin Center in Azure](azure/deploy-wac-in-azure.md) <br> - [Manage Azure VMs with Windows Admin Center](azure/manage-azure-vms.md) <br><br> |

| Windows Admin Center in Azure | Support |
|-----------------------|-----------------|
| - [Manage a Windows Server IaaS VMs](azure/manage-vm.md) <br> - [Manage Azure Arc-enabled Servers (preview)](azure/manage-arc-hybrid-machines.md) <br> - [Manage Azure Local clusters (preview)](azure/manage-hci-clusters.md) | - [Release history](support/release-history.md) <br> - [Support policy](support/index.md) <br> - [Common troubleshooting steps](support/troubleshooting.md) <br> - [Known issues](support/known-issues.md) |

| Extend |
|--------|
| - [Overview of extensions](extend/extensibility-overview.md)<br>- [Understanding extensions](extend/understand-extensions.md)<br>- [Develop an extension](extend/developing-extensions.md)<br>- [Guides](extend/guides.md)<br>- [Publishing extensions](extend/publish-extensions.md) |

## See how customers benefit from Windows Admin Center

- "[Windows Admin Center] has decreased our time/effort in managing the management system by over 75%."

   *- Rand Morimoto, President, Convergent Computing*

- "Thanks to [Windows Admin Center], we can manage our customers remotely from HTML5 portal without problem and with the full integration with Microsoft Entra ID, we're able to increase the security thanks to the multifactor authentication."

   *- Silvio Di Benedetto, Founder and Senior Consultant, Inside Technologies*

- "We have been able to deploy [Server Core] SKUs in a more effective way, improving resource efficiency, security, and automation while still achieving a good degree of productivity and reducing errors that can happen when relying on scripting only."

   *- Guglielmo Mengora, Founder and CEO, VaiSulWeb*

- "With [Windows Admin Center] customers especially in the SMB market now have an easy to use tool to manage their internal infrastructure. This minimizes administrative efforts and saves a lot of time. And the best of it: there are no additional license fees for [Windows Admin Center]!"

   *- Helmut Otto, Managing Director, SecureGUARD*

To read more about companies using Windows Admin Center in their production environments, see [Windows Admin Center Case Studies](understand/case-studies.md).

## Related Windows Admin Center management products

Windows Admin Center is designed for managing a single server or cluster. It complements but doesn't replace existing Microsoft monitoring and management solutions, such as Remote Server Administration Tools (RSAT), System Center, Intune, or Azure Stack.

To learn how Windows Admin Center complements other Microsoft management solutions, see [Windows Admin Center and related management solutions from Microsoft](understand/related-management.md).

## Stay updated on Windows Admin Center

- [Follow us on X (formerly Twitter)](https://twitter.com/servermgmt)
- [Windows Admin Center blog](https://aka.ms/wacblog)
