---
title: Windows Admin Center Overview
description: Learn how to manage Windows Server using Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 01/07/2020
ms.localizationpriority: high
ms.prod: windows-server
---
# Windows Admin Center

> Applies to: Windows Admin Center, Windows Admin Center Preview

Windows Admin Center is a locally deployed, browser-based app for managing Windows servers, clusters, hyper-converged infrastructure, as well as Windows 10 PCs. It comes at no additional cost beyond Windows and is ready to use in production.

To find out what's new, see [Release history](support/release-history.md).

## Download now

**Download [Windows Admin Center](https://www.microsoft.com/evalcenter/evaluate-windows-admin-center)** from the Microsoft Evaluation Center. Even though it says “Start your evaluation”, this is the generally available version for production use, included as part of your Windows or Windows Server license.

For help installing, see [Install](deploy/install.md). For tips on getting started with Windows Admin Center, see [Get started](use/get-started.md).

You can update non-preview versions of Windows Admin Center by using Microsoft Update or by manually downloading and installing Windows Admin Center. Each non-preview version of Windows Admin Center is supported until 30 days after the next non-preview version is released. See our [support policy](support/index.md) for more info.

## Windows Admin Center scenarios

Here are a few things you can use Windows Admin Center for:

|     |     |
| --- | --- |
| ![](media/simple-icon.png)| **Simplify server management** <br/> Manage your servers and clusters with modernized versions of familiar tools such as Server Manager. Install in under five minutes and manage servers in your environment immediately, no additional configuration required. For details, see [What is Windows Admin Center?](understand/what-is.md). |
| ![](media/future-icon.png)| **Work with hybrid solutions** <br/> Integration with Azure helps you optionally connect your on-premises servers with relevant cloud services. For details, see [Azure hybrid services](azure/index.md) |
| ![](media/secure-icon.png)| **Streamline hyperconverged management** <br/> Streamline management of Azure Stack HCI or Windows Server hyperconverged clusters. Use simplified workloads to create and manage VMs, Storage Spaces Direct volumes, Software-Defined Networking and more. For details, see [Manage Hyper-Converged Infrastructure with Windows Admin Center](use/manage-hyper-converged.md)|

Here's a video to give you an overview, followed by a poster giving more details:
>[!VIDEO https://www.youtube.com/embed/WCWxAp27ERk]

[![Windows Admin Center poster](media/WAC1910Poster_thumb_small.PNG)](media/WAC1910Poster_thumb.png)

[Download the PDF](https://github.com/MicrosoftDocs/windowsserverdocs/raw/master/WindowsServerDocs/manage/windows-admin-center/media/WindowsAdminCenter1910Poster.pdf)


## Contents at a glance

<table>
    <tr></tr>
    <tr>
        <td style="vertical-align: top;">
            <h3>Understand</h3>
            <ul>
            <li><a href="understand/what-is.md">What is Windows Admin Center?</a>
            <li><a href="understand/faq.md">FAQ</a>
            <li><a href="understand/case-studies.md">Case studies</a>
            <li><a href="understand/related-management.md">Related management products</a>
            </ul>
        </td>
        <td style="vertical-align: top;">
            <h3>Plan</h3>
            <ul>
            <li><a href="plan/installation-options.md">What type of installation is right for you?</a>
            <li><a href="plan/user-access-options.md">User access options</a>
            <br>
            </ul>
        </td>
    </tr>
    <tr>
        <td style="vertical-align: top;">
            <h3>Deploy</h3>
            <ul>
            <li><a href="deploy/prepare-environment.md">Prepare your environment</a>
            <li><a href="deploy/install.md">Install Windows Admin Center</a>
            <li><a href="deploy/high-availability.md">Enable high availability</a>
         </ul>
        </td>
        <td style="vertical-align: top;">
            <h3>Configure</h3>
            <ul>
            <li><a href="configure/settings.md">Windows Admin Center settings</a>
            <li><a href="configure/user-access-control.md">User access control and permissions</a>
            <li><a href="configure/shared-connections.md">Shared connections</a>
            <li><a href="configure/using-extensions.md">Extensions</a>
            <li><a href="configure/use-powershell.md">Automate with PowerShell</a>
            </ul>
        </td>
    </tr>
    <tr>
        <td style="vertical-align: top;">
            <h3>Use</h3>
            <ul>
            <li><a href="use/get-started.md">Launch & add connections</a>
            <li><a href="use/manage-servers.md">Manage servers</a>
            <li><a href="use/deploy-hyperconverged-infrastructure.md">Deploy hyperconverged infrastructure</a>
            <li><a href="use/manage-hyper-converged.md">Manage hyper-converged infrastructure</a>
            <li><a href="use/manage-failover-clusters.md">Manage failover clusters</a>
            <li><a href="use/manage-virtual-machines.md">Manage virtual machines</a>
            <li><a href="use/logging.md">Logging</a>
            </ul>
        </td>
        <td style="vertical-align: top;">
            <h3>Connect to Azure</h3>
            <ul>
            <li><a href="azure/index.md">Azure hybrid services</a></li>
            <li><a href="azure/azure-integration.md">Connect Windows 
Admin Center to Azure</a></li>
            <li><a href="azure/deploy-wac-in-azure.md">Deploy Windows Admin Center in Azure</a></li>
            <li><a href="azure/manage-azure-vms.md">Manage Azure VMs with Windows Admin Center</a></li>
            </ul>
        </td>
    </tr>
    <tr>
            <td style="vertical-align: top;">
            <h3>Support</h3>
            <ul>
            <li><a href="support/release-history.md">Release history</a>
            <li><a href="support/index.md">Support policy</a>
            <li><a href="support/troubleshooting.md">Common troubleshooting steps</a>
            <li><a href="support/known-issues.md">Known issues</a>
            </ul>
        </td>
            <td style="vertical-align: top;">
            <h3>Extend</h3>
            <ul>
            <li><a href="extend/extensibility-overview.md">Overview of extensions</a>
            <li><a href="extend/understand-extensions.md">Understanding extensions</a>
            <li><a href="extend/developing-extensions.md">Develop an extension</a>
            <li><a href="extend/publish-extensions.md">Guides</a>
            <li><a href="extend/publish-extensions.md">Publishing extensions</a>
            </ul>
        </td>
    </tr>

</table>

## Video-based learning

Here are some videos from Microsoft Ignite 2019 sessions:

- [Windows Admin Center: Unlock Azure Hybrid value](https://aka.ms/WAC-BRK3165)
- [Windows Admin Center: What’s new and what’s next](https://aka.ms/WAC-BRK2048)
- [Automatically monitor, secure and update your on-premises servers from Azure with Windows Admin Center](https://aka.ms/WAC-THR2146)
- [Get more done with Windows Admin Center third-party extensions](https://aka.ms/WAC-THR2140)
- [Be a Windows Admin Center expert: Best practices for deployment, configuration, and security](https://aka.ms/WAC-THR2135)
- [Windows Admin Center: Better together with System Center and Microsoft Azure](https://aka.ms/WAC-THR2176)
- [How to use Microsoft Azure hybrid services together with Windows Admin Center and Windows Server](https://aka.ms/WAC-THR2073)
- [Live Q&A: Manage your hybrid server environment with Windows Admin Center](https://aka.ms/WAC-MLS1055)
- [Learning Path: Hybrid management technologies](https://aka.ms/WAC-HybridMgmtTech)
- [Hands on Lab: Windows Admin Center and Hybrid](https://aka.ms/WAC-HOL2019)

Here are some videos from Windows Server Summit 2019 sessions:

- [Go hybrid with Windows Admin Center](https://aka.ms/WAC-WSS2019-GoHybridWAC)
- [What's new with Windows Admin Center v1904](https://aka.ms/WAC-WSS2019-WhatsNewv1904)

And here are a few additional resources:

- [Windows Admin Center server management reimagined](https://aka.ms/WAC-ServerMgmtReimagined)
- [Manage Servers and Virtual Machines Anywhere with Windows Admin Center](https://aka.ms/WAC-Webinar2019)
- [How to get started with Windows Admin Center](https://www.youtube.com/embed/PcQj6ZklmK0)

## See how customers are benefitting from Windows Admin Center

|     |
| --- |
| "[Windows Admin Center] has decreased our time/effort in managing the management system by over 75%."<br> *- Rand Morimoto, President, Convergent Computing* |
| "Thanks to [Windows Admin Center], we can manage our customers remotely from HTML5 portal without problem and with the full integration with Azure Active Directory, we are able to increase the security thanks to the Multi-Factor Authentication."<br/> *- Silvio Di Benedetto, Founder and Senior Consultant, Inside Technologies* |
| “We have been able to deploy [Server Core] SKUs in a more effective way, improving resource efficiency, security and automation while still achieving a good degree of productivity and reducing errors that can happen when relying on scripting only.” <br/> *- Guglielmo Mengora, Founder and CEO, VaiSulWeb* |
| “With [Windows Admin Center] customers especially in the SMB market now have an easy to use tool to manage their internal infrastructure. This minimizes administrative efforts and saves a lot of time. And the best of it: there are no additional license fees for [Windows Admin Center]!” <br/> *- Helmut Otto, Managing Director, SecureGUARD* |

[Read more about companies using Windows Admin Center in their production environments.](understand/case-studies.md)

## Related products

Windows Admin Center is designed for managing a single server or cluster. It complements but does not replace existing Microsoft monitoring and management solutions, such as Remote Server Administration Tools (RSAT), System Center, Intune, or Azure Stack.

[Learn how Windows Admin Center complements other Microsoft management solutions.](understand/related-management.md)

## Stay updated

![](//img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/REOolR)[Follow us on Twitter](https://twitter.com/servermgmt)

![](//img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/REOtyw)[Read our Blogs](https://blogs.technet.microsoft.com/servermanagement/)
