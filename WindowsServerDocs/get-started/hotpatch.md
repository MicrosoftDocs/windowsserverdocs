---
title: Hotpatch for Windows Server Azure Edition
description: 'Learn how Hotpatch for Windows Server Datacenter: Azure Edition works and how to enable it'
author: robinharwood
ms.topic: conceptual
ms.date: 10/14/2024
ms.author: wscontent
---

# Hotpatch for virtual machines

Hotpatching is a way to install OS security updates on Windows Server without having to restart your machine. Hotpatching patches the in-memory code of running processes without the need to restart the process. Hotpatching also provides the following benefits:

- Fewer binaries mean updates install faster and consume less disk and CPU resources.

- Lower workload impact with less need to restart your machine.

- Better protection, as the Hotpatch update packages are scoped to Windows security updates that install faster without requiring you to restart your machine.

- Reduces the time exposed to security risks and change windows, and easier patch orchestration with Azure Update Manager.

>[!IMPORTANT]
>Hotpatch for Azure-Arc enabled servers is available for a free trial period, but after the period ends, you must enter one of the following pricing plans: <!--Get links for pricing plans.--->

## Supported platforms

### Azure and Azure Stack HCI virtual machines

The following table lists the exact combinations of publisher, OS offer, and SKU that support Hotpatching for Windows Server 2022 and WIndwos Server 2025 on Azure. Guest virtual machines (VMs) you create on Azure Stack HCI using these combinations also support Hotpatching.

>[!NOTE]
>Windows Server container base images, custom images, or any other combination of publisher, offer, and SKU aren't supported.

| Publisher               | OS Offer      |  SKU               |
|-------------------------|---------------|--------------------|
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Core |
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Core-smalldisk |
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Hotpatch |
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Hotpatch-smalldisk |
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Azure-Edition |
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Azure-Edition-smalldisk |
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Azure-Edition-Core |
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Azure-Edition-Core-smalldisk |

The Azure portal selects Hotpatch by default when you create an Azure VM.

Hotpatching is available for Azure Arc-enabled machines running Windows Server 2025. The following images are compatible with Hotpatching:

- Windows Server 2025 Datacenter

- Windows Server 2025: Standard Edition

- Windows Server 2022 Datacenter Core

- Windows Server 2022 Standard Core

>[!NOTE]
>Hotpatch is enabled by default on Server Core images.

For more information about the available images, see the [Windows Server](https://aka.ms/hotpatchondesktopnewimage) on the Azure Marketplace.

### Azure Arc-connected machines (preview)

> [!IMPORTANT]
> Azure Arc-enabled Hotpatch is currently in PREVIEW.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

<!-- Add some verbage here, as per GH comment -->

The following table lists the exact combinations of publisher, OS offer, and SKU that support Hotpatching for Windows Server 2025.

| Publisher               | OS Offer      |  SKU               |
|-------------------------|---------------|--------------------|
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Edition |
| MicrosoftWindowsServer | WindowsServer | 2025-Standard-Edition |

To start using Azure Arc-enabled Hotpatch, connect your Windows Server 2025 machine to Azure Arc using one of the following editions:

- Windows Server 2025 Datacenter

- Windows Server 2025 Standard

## How Hotpatch works

Hotpatch first establishes a baseline with the current Cumulative Update for Windows Server. Every three months, the baseline periodically refreshes with the latest Cumulative Update. You then receive Hotpatch releases for the next two months after the Cumulative Update. For example, if January is
a Cumulative Update, February and March would have Hotpatch releases. For more information about the Hotpatch release schedule, see [Release notes for Hotpatch in Azure Automanage for Windows Server 2022](https://support.microsoft.com/topic/release-notes-for-hotpatch-in-azure-automanage-for-windows-server-2022-4e234525-5bd5-4171-9886-b475dabe0ce8).

The following diagram shows an example of an annual three-month schedule including hypothetical unplanned
baselines due to zero-day fixes.

:::image type="complex" source="media\hotpatch\hotpatch-sample-schedule.png" alt-text="A diagram showing an example of a Hotpatch release schedule.":::
   A diagram showing an example of a Hotpatch schedule. The schedule is shown as a timeline extending from the January of the current year to the January of next year. On each month is a colored dot representing what kind of release happened during that month. The top row of red dots represents Hotpatch releases, the middle row of blue dots represents planned baselines, and the bottom row of blue dots on a red line represents unplanned baselines. In this diagram, January, April, July, October, and January of the next year are planned baselines. February, March, May, June, August, September, and November and December are Hotpatch releases. There were two unplanned baseline releases in March and August.
:::image-end:::

There are two types of baselines: **Planned baselines** and **Unplanned baselines**.

- **Planned baselines** are released on a regular cadence, with Hotpatch releases in between. Planned baselines include all the updates in a comparable Latest Cumulative Update for that month and require you to restart your machine.

  - The example schedule in the previous diagram has four planned baseline releases in a calendar year and eight Hotpatch releases.

- **Unplanned baselines** are released during an unplanned important update, such as a zero-day fix, when that particular update can't be released as a Hotpatch. When unplanned baselines release, a Hotpatch release is replaced with an unplanned baseline for that month. Unplanned baselines also include all the updates in a comparable Latest Cumulative Update for that month, and therefore require you to restart your machine.

  - The example schedule in the previous diagram shows two unplanned baselines that replaced Hotpatch releases for those months. Because these events are unplanned, in a real-life scenario, developers can't predict unplanned baselines in advance.

Hotpatch updates don't require you to restart your machine. Because Hotpatches patch the in-memory code of running processes without needing to restart them, your applications aren't affected. This lack of restarting doesn't affect the performance or functionality implications of the patch itself.

### Supported updates

Hotpatch covers Windows Security updates and maintains parity with the content of security updates issued to in the regular non-Hotpatch Windows update channel.

There are a few important things you need to consider when enabling Hotpatch on a supported version of Windows Server. You still need to restart your machine to install updates that aren't included in the Hotpatch program. You also need to periodically restart after installing a new baseline. Restarting keeps your VM in sync with non-security patches included in the latest cumulative updates.

The following patches currently aren't included in the Hotpatch program and require you to update your machine during Hotpatch release months:

- Non-security updates for Windows

- .NET updates

- Non-Windows updates, such as drivers, firmware updates, and so on.

## Patch orchestration process

Hotpatch is an extension of Windows Update and typical orchestration processes. However, the kinds of tools Hotpatch uses for patch orchestration
vary depending on which platform you're using.

### Azure

- VMs you create in Azure using a supported Windows Server image have [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching) enabled by default.

- Hotpatch automatically downloads and applies patches classified as Critical or Security to your VM.

- Hotpatch applies patches during off-peak hours in the VM time zone.

- Azure manages patch orchestration, applying patches according to [availability-first principles](/azure/virtual-machines/automatic-vm-guest-patching#availability-first-updates).

- Azure monitors VM health through platform health signals to detect patching failures.

> [!NOTE]
> You can't create VM scale sets (VMSS) with Uniform orchestration on Azure Edition images with Hotpatch. To learn more about which features are supported by Uniform orchestration for scale sets, see [A comparison of Flexible, Uniform, and availability sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes).

### Azure Stack HCI

Azure Stack HCI can orchestrate Hotpatch updates for VMs using the following tools:

- Group Policy configures Windows Update client settings.

- SCONFIG configures Windows Update client settings for Server Core.

- Third-party patch management solutions.

### Azure Arc-connected machines

Azure Arc-connected machines can consume Hotpatch updates using the following tools:

- Azure Update Manager

- Group Policy configures Windows Update client settings.

- SCONFIG configures Windows Update client settings for Server Core.

- Third-party patch management solutions.

You can orchestrate Hotpatching on a Windows Server 2025 VM using Azure Arc. For more information, see [How to preview: Azure Arc-connected Hotpatching for Windows Server 2025](https://techcommunity.microsoft.com/t5/windows-server-news-and-best/how-to-preview-azure-arc-connected-hotpatching-for-windows/ba-p/4246895).
<!---Check with Vishal about how to phrase this and if AUM link is ready.--->

### Understand the patch status for your VM in Azure

To view the patch status for your VM, open the Overview page for your VM in the Azure portal. From there, under **Operations**, select **Updates**. You should see the patch status and most recently installed patches under **Recommended updates**.

In the **Recommended updates** page, you can see the Hotpatch status of your VM and if there are any available patches for your VM. As we stated in [How Hotpatch works](#how-hotpatch-works), [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching) automatically installs all Critical and Security patches on your VM. 
Patches outside of those two categories aren't automatically installed, and are instead displayed in the **Update compliance** tab as a list of available patches. You can also check the **Update history** tab to view patch installation details for update deployments on your VM from the past 30 days.

:::image type="content" source="media\hotpatch\hotpatch-management-ui.png" alt-text="A screenshot showing Hotpatch management from the Azure portal.":::

Automatic VM Guest Patching regularly runs assessments of available patches, which you can view in the **Updates** tab. You can manually start an assessment by selecting the **Assess Now** button. You can also install patches on-demand by selecting the **Install updates now** button. This option lets you choose whether to install all updates under specific patch classifications or select individual updates to include or exclude by providing a list of knowledge base articles. However, keep in mind that patches you install manually don't follow availability-first principles and might require you to restart your VM.

You can also view installed patches by running the [Get-HotFix](/powershell/module/microsoft.powershell.management/get-hotfix) cmdlet in PowerShell or by viewing the **Settings** menu in Desktop Experience.

## Rollback support for Hotpatching

Hotpatch updates don't support automatic rollback. If you experience an issue during or after an update, you must uninstall the latest update and install the last functional baseline update. This process requires that you restart the VM.

## Next steps

- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)

- [Enable Hotpatch for Azure Edition virtual machines built from ISO](enable-hotpatch-azure-edition.md)

- [Azure Update Management](/azure/automation/update-management/overview)

- [How to preview Azure Arc-connected Hotpatching for WIndows Server 2025](https://techcommunity.microsoft.com/t5/windows-server-news-and-best/how-to-preview-azure-arc-connected-hotpatching-for-windows/ba-p/4246895)