---
title: How to get Extended Security Updates (ESU) for Windows Server 2008, 2008 R2, 2012, and 2012 R2
description: Learn how to get Extended Security Updates (ESU) for Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, and Windows Server 2012 R2 after the end of their support lifecycle.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
manager: femila
ms.date: 07/12/2023
ms.prod: windows-server
ms.mktglfcycl: manage
ms.custom: contperf-fy22q3
---

# How to get Extended Security Updates (ESU) for Windows Server

Extended Security Updates (ESU) for Windows Server include security updates and bulletins rated
*critical* and *important*. Before using ESU, you should read
[Extended Security Updates for Windows Server Overview](extended-security-updates-overview.md) to
understand what ESUs are, how long they're available for, and what your options are.

How you get ESUs depends on where your server is hosted. You can get access to
ESUs through the following options.

- **Azure virtual machines** - Applicable virtual machines (VMs) hosted in Azure are automatically
   enabled for ESUs and these updates are provided free of charge, there's no
   need to deploy a MAK key or take any other action. See
   [Extended Security Updates on Azure](#extended-security-updates-on-azure) to learn more.

- **Azure Arc-enabled servers** - If your servers are on-premises or in a hosted environment, you
   can enroll your Windows Server 2012 and 2012 R2 or SQL Server 2012 machines for Extended Security
   Updates via the Azure portal, connect through Azure Arc, and you'll be billed monthly via your
   Azure subscription. See
   [Extended Security Updates enabled by Azure Arc](#extended-security-updates-enabled-by-azure-arc)
   to learn more. <sup>1</sup>

- **Non-Azure physical and virtual machines** - If you can't connect using Azure Arc, use Extended
   Security Updates on non-Azure VMs, by using a Multiple Activation Key (MAK) and applying it to
   the relevant servers. This MAK key lets the Windows Update servers know that you can continue to
   receive security updates. See
   [Access your Multiple Activation Key from the Microsoft 365 Admin Center](#access-your-multiple-activation-key-from-the-microsoft-365-admin-center)
   to learn more. <sup>1</sup>

<sup>1</sup> When using Azure Arc-enabled servers and non-Azure machines you must purchase ESUs. In
order to purchase ESUs, you must have Software Assurance through Volume Licensing Programs such as
an Enterprise Agreement (EA), Enterprise Agreement Subscription (EAS), Enrollment for Education
Solutions (EES), or Server and Cloud Enrollment (SCE).

> [!NOTE]
> It may take 3-5 business days for your Multiple Activation Key to become available after
> purchasing ESUs for on-premises VMs or physical servers. Your organization may also require time
> to plan and deploy the new keys. Before purchasing ESUs, you should keep these timelines in mind.



## Extended Security Updates on Azure

Applicable virtual machines (VMs) hosted in Azure are automatically enabled for ESU and these
updates are provided free of charge. You don't need to configure anything, and there's no extra
charge for using ESUs with Azure VMs. ESUs are automatically delivered to Azure VMs if they're
configured to receive updates.

> [!NOTE]
> Extended Security Updates are also free of charge in other Azure products such as Azure Dedicated
> Host, Azure VMware Solution, Azure Nutanix Solution, and Azure Stack (Hub, Edge, and HCI), and
> might require additional configuration. Contact
> [Microsoft Support](https://support.microsoft.com/contactus?PID=17336) for more help.
>
> Azure Classic VMs (Microsoft.ClassicCompute) also require extra configuration to receive Extended
> Security Updates since they don't have access to the
> [Azure Instance Metadata Service](/azure/virtual-machines/windows/instance-metadata-service) that
> determines ESUs eligibility.

## Extended Security Updates enabled by Azure Arc

ESUs are automatically delivered to Azure Arc-enabled servers if they're connected and enrolled for
ESUs through Azure Arc. This can also apply to non-Azure servers connected to Azure Arc.

You can enroll in ESUs at scale by using Azure Policy or Azure portal, there's no upfront charge and
you'll be billed monthly via your Azure subscription. You also don't need to activate product keys.

Azure Arc-enabled servers also enable to you to use other Azure services, such as:

- Azure Update Manager.
- Microsoft Defender for Cloud.
- Azure Policy (Machine Configuration).
- Azure Monitor (VM Insights).

From September 2023, you're able to activate Windows Server 2012 and 2012 R2 ESUs through Azure Arc. You can connect Windows Server 2012 and 2012 R2 servers to Azure Arc today,
[Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

To prepare for activating Windows Server 2012 and 2012R2 ESUs on your Arc-enabled servers, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com/).

1. In the search bar, enter *Servers - Azure Arc* and select the matching service entry.

1. Add your existing Windows Server 2012 or 2012 R2 machine to Azure Arc. To learn about getting
   started with Azure Arc-enabled servers, see
   [Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

To learn more about ESUs with Azure Arc, see
[Prepare to deliver Extended Security Updates for Windows Server 2012](/azure/azure-arc/servers/prepare-extended-security-updates) and [Deliver Extended Security Updates for Windows 2012 and 2012 R2](/azure/azure-arc/servers/deliver-extended-security-updates).

## Access your Multiple Activation Key from the Microsoft 365 Admin Center

Customers who can't connect to Azure Arc to apply ESUs can use Multiple Activation Keys (MAK)
through Microsoft 365 Admin Center:

1. Sign in to the [Microsoft 365 Admin Center](https://admin.microsoft.com/).

1. Select **Your products > Volume licensing > View contracts**

1. Select your agreement number used to purchase ESUs, the three dots beside it (More Actions icon),
   then select **View product keys**. All the product keys available to the agreement shown on this
   page.

1. Once you have your MAK, install the new key on your eligible servers. To learn more about
   installing and activating your MAK, see our Tech Community blog post
   [Obtaining Extended Security Updates for eligible Windows devices](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/obtaining-extended-security-updates-for-eligible-windows-devices/ba-p/1167091).

## Download and installation of Extended Security Updates

Delivery, download, and application of ESUs for Windows Server is no different than other Windows Updates. The updates provided through ESUs are only *Security* updates.

Before you can download and install ESUs, you must have installed the latest Servicing Stack Update (SSU) and the Licensing Preparation Package. To learn more about the steps required to install the latest SSU and Licensing Preparation Package, see [KB5031043: Procedure to continue receiving security updates after extended support has ended on October 10, 2023](https://support.microsoft.com/help/5031043).

You can install the updates using whatever tools and processes you already have in place. The only difference is that the system must be registered using the key generated in the previous section for the updates to download and install.

For VMs hosted in Azure, the process of enabling the server for ESUs is automatically completed for you. Updates should download and install without extra configuration.
