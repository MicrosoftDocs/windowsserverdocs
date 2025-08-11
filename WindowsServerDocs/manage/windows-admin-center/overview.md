---
title: Windows Admin Center overview
description: Learn how to manage Windows Server using Windows Admin Center (Project Honolulu).
ms.topic: overview
author: davannaw-msft
ms.author: dawhite
ms.date: 08/22/2024
---

# Windows Admin Center overview

Windows Admin Center is a remote management tool for Windows Server running anywhere&mdash;physical, virtual, on-premises, in Azure, or in a hosted environment&mdash;at no extra cost.

To find out what's new, see [Release history](support/release-history.md).

## Download now

**Download [Windows Admin Center](https://www.microsoft.com/evalcenter/download-windows-admin-center)** from the Microsoft Evaluation Center.

For installation help, see [Install](deploy/install.md). For tips on getting started with Windows Admin Center, see [Get started](use/get-started.md).

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually downloading and installing Windows Admin Center. Each non-preview version of Windows Admin Center is supported until 30 days after the next non-preview version is released. See our [support policy](support/index.md) for more info.

## Windows Admin Center scenarios

Here are a few things you can use Windows Admin Center for:

- **Simplify server management**: Manage your servers and clusters with modernized versions of familiar tools such as Server Manager. Install in under five minutes and manage servers in your environment immediately, no extra configuration required. For details, see [What is Windows Admin Center?](understand/what-is.md)

- **Work with hybrid solutions**: Integration with Azure helps you optionally connect your on-premises servers with relevant cloud services. For details, see [Azure hybrid services](azure/index.md).

- **Streamline hyperconverged management**: Streamline management of Azure Local or Windows Server hyperconverged clusters. Use simplified workloads to create and manage VMs, Storage Spaces Direct volumes, Software-Defined Networking and more. For details, see [Manage HCI](use/manage-hyper-converged.md).

Here's a video to give you an overview, followed by a poster giving more details:
> [!VIDEO https://www.youtube.com/embed/WCWxAp27ERk]

:::image type="content" source="media/WAC1910-poster-thumb-small.png" alt-text="Diagram that gives an overview of the Windows Admin Center." lightbox="media/WAC1910-poster-thumb-small.png":::

[Download the PDF of this poster](https://github.com/MicrosoftDocs/windowsserverdocs/raw/main/WindowsServerDocs/manage/windows-admin-center/media/WindowsAdminCenter1910Poster.pdf)

## Contents at a glance

| Understand | Plan |
|------------|------|
| - [What is Windows Admin Center?](understand/what-is.md) <br> - [Frequently asked questions](understand/faq.yml)<br> - [Case studies](understand/case-studies.md) <br> - [Related management products](understand/related-management.md) | - [What type of installation is right for you?](plan/installation-options.md) <br> - [User access options](plan/user-access-options.md) <br> |

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
| - [Overview of extensions](extend/extensibility-overview.md)<br>- [Understanding extensions](extend/understand-extensions.md)<br>- [Develop an extension](extend/developing-extensions.md)<br>- [Guides](extend/publish-extensions.md)<br>- [Publishing extensions](extend/publish-extensions.md) |

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

## Related products

Windows Admin Center is designed for managing a single server or cluster. It complements but doesn't replace existing Microsoft monitoring and management solutions, such as Remote Server Administration Tools (RSAT), System Center, Intune, or Azure Stack.

To learn how Windows Admin Center complements other Microsoft management solutions, see [Windows Admin Center and related management solutions from Microsoft](understand/related-management.md).

## Stay updated

- [Follow us on X (formerly Twitter)](https://twitter.com/servermgmt)
- [Read our blogs](https://techcommunity.microsoft.com/t5/windows-admin-center-blog/bg-p/Windows-Admin-Center-Blog)
