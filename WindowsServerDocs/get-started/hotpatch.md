---
title: Hotpatch for Windows Server Azure Edition
description: 'Learn how hotpatch for Windows Server Datacenter: Azure Edition works and how to enable it'
author: robinharwood
ms.topic: conceptual
ms.date: 07/27/2023
ms.author: wscontent
---

# Hotpatch for virtual machines

Hotpatching is a way to install OS security updates on supported Windows Server Datacenter: Azure Edition virtual machines (VMs) that doesn’t require a reboot after installation. It works by patching the in-memory code of running processes without the need to restart the process. Hotpatching also provides the following benefits:

- Fewer binaries mean updates install faster and consume less disk and CPU resources.
- Lower workload impact with less need to restart your machine.
- Better protection, as the hotpatch update packages are scoped to Windows security updates that install faster without requiring you to restart your machine.
- Reduces the time exposed to security risks and change windows, and easier patch orchestration with Azure Update Manager.

>[!IMPORTANT]
>Hotpatch is available for a free trial period, but after the period ends, you must enter one of the following pricing plans: <!--Get links for pricing plans.--->

## Supported platforms

Hotpatch is supported only on VMs and Azure Stack HCI created from images with the exact combination of publisher, offer and sku from the below OS images list. Windows Server container base images or Custom images or any other publisher, offer, sku combinations aren't supported.

| Publisher               | OS Offer      |  SKU               |
|-------------------------|---------------|--------------------|
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Core |
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Core-smalldisk |
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Hotpatch |
| MicrosoftWindowsServer  | WindowsServer | 2022-Datacenter-Azure-Edition-Hotpatch-smalldisk |
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Azure-Edition-Core |
| MicrosoftWindowsServer | WindowsServer | 2025-Datacenter-Edition |
| MicrosoftWindowsServer | WindowsServer | 2025-Standard-Edition |

The Azure portal selects Hotpatch by default when you create an Azure VM. To start using Hotpatch, create an Azure or Azure Stack HCI VM using one of the following compatible images:

- Windows Server 2025: Azure Edition
- Windows Server 2025 Datacenter
- Windows Server 2025: Standard Edition
- Windows Server 2022 Datacenter: Azure Edition Hotpatch (Desktop Experience)
- Windows Server 2022 Datacenter: Azure Edition Core<sup>1</sup>

<sup>1</sup> Hotpatch is enabled by default on Server Core images.

For more information about the available images, see the [Windows Server 2022 Datacenter](https://aka.ms/hotpatchondesktopnewimage) on the Azure Marketplace.

## How Hotpatch works

Hotpatch first establishes a baseline with the current Cumulative Update for Windows Server. Every three months, the baseline periodically refreshes with the latest Cumulative Update. You then receive Hotpatch releases for the next two months after the Cumulative Update. For example, if January is
a Cumulative Update, February and March would have Hotpatch releases. For more information about the Hotpatch release schedule, see [Release notes for Hotpatch in Azure Automanage for Windows Server 2022](https://support.microsoft.com/topic/release-notes-for-hotpatch-in-azure-automanage-for-windows-server-2022-4e234525-5bd5-4171-9886-b475dabe0ce8).

The following diagram shows an example of an annual three-month schedule including hypothetical unplanned
baselines due to zero-day fixes.

:::image type="content" source="media\hotpatch\hotpatch-sample-schedule.png" alt-text="A diagram showing an example of a Hotpatch schedule.":::

<!--Needs clearer alt text-->

There are two types of baselines: **Planned baselines** and **Unplanned baselines**.

- **Planned baselines** are released on a regular cadence, with hotpatch releases in between. Planned baselines include all the updates in a comparable Latest Cumulative Update for that month and require you to restart your machine.

  - The example schedule in the previous diagram has four planned baseline releases in a calendar year and eight hotpatch releases.

- **Unplanned baselines** are released during an unplanned important update, such as a zero-day fix, when that particular update can't be released as a hotpatch. When unplanned baselines release, a hotpatch release is replaced with an unplanned baseline for that month. Unplanned baselines also include all the updates in a comparable Latest Cumulative Update for that month, and therefore require you to reqstart your machine.

  - The sample schedule illustrates two unplanned baselines that would replace the hotpatch releases
    for those months (the actual number of unplanned baselines in a year isn't known in advance).

Hotpatch updates don't require you to restart your machine. Because Hotpatches patch the in-memory code of running processes without needing to restart them, your applications aren't affected. This lack of restarting doesn't affect the performance or functionality implications of the patch itself.

### Supported updates

Hotpatch covers Windows Security updates and maintains parity with the content of security updates
issued to in the regular (nonhotpatch) Windows update channel.

There are some important considerations to running a supported _Windows Server Azure Edition_ VM
with hotpatch enabled. Reboots are still required to install updates that aren't included in the
hotpatch program. Reboots are also required periodically after a new baseline has been installed.
Reboots keep the VM in sync with nonsecurity patches included in the latest cumulative update.

- Patches that are currently not included in the hotpatch program include non security updates
  released for Windows, .NET updates and non-Windows updates (such as drivers, firmware update
  etc.). These types of patches may need a reboot during Hotpatch months.

## Patch orchestration process

Hotpatch is an extension of Windows Update and typical orchestration processes. Patch orchestration
tools vary depending on your platform. To orchestrate Hotpatch:

- **Azure:** Virtual machines created in Azure are enabled for
  [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching) by default with
  a supported _Windows Server Datacenter: Azure Edition_ image. Automatic VM guest patching in
  Azure:

  - Patches classified as Critical or Security are automatically downloaded and applied on the VM.

  - Patches are applied during off-peak hours in the VM's time zone.

  - Azure manages patch orchestration and patches are applied following
    [availability-first principles](/azure/virtual-machines/automatic-vm-guest-patching#availability-first-updates).

  - Virtual machine health, as determined through platform health signals, is monitored to detect
    patching failures.

  > [!NOTE]
  > You can't create VM scale sets (VMSS) with Uniform orchestration on Azure Edition images with Hotpatch. To learn more about which features are supported by Uniform orchestration for scale sets, see [A comparison of Flexible, Uniform, and availability sets](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-orchestration-modes).

- **Azure Stack HCI:** Hotpatch updates for virtual machines created on Azure Stack HCI are
  orchestrated using:

  - Group Policy to configure the Windows Update client settings.

  - Configuring Windows Update client settings, or SCONFIG for Server Core.

  - A third-party patch management solution.

- **Windows Server 2025 (preview):** Hotpatch updates for the preview build of Windows Server 2025 are orchestrated using:

  - An Azure Arc-enabled VM created using the Windows Server 2025 Preview ISO image from the Evaluation Center.

  - Configuring Windows Update client settings for the Azure Arc-enabled Windows Server 2925 Preview VM.

### Understand the patch status for your VM in Azure

To view the patch status for your VM, browse to the VM Overview in the Azure portal, under
Operations, select **Updates**. Under the **Recommended updates** section, you can view the latest
patches and Hotpatch status for your VM.

On this screen, you see the hotpatch status for your VM. You can also review if there any available
patches for your VM that haven't been installed. As described in the ‘Patch installation’ previous
section, all security and critical updates are automatically installed on your VM using
[Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching) and no extra
actions are required. Patches with other update classifications aren't automatically installed.
Instead, they're viewable in the list of available patches under the **Update compliance** tab. You
can also view the history of update deployments on your VM through the **Update history**. Update
history from the past 30 days is displayed, along with patch installation details.

:::image type="content" source="media\hotpatch\hotpatch-management-ui.png" alt-text="A screenshot showing Hotpatch management from the Azure portal.":::

With automatic VM guest patching, your VM is periodically and automatically assessed for available
updates. These periodic assessments ensure that available patches are detected. You can view the
results of the assessment on the Updates screen in the previous image, including the time of the
last assessment. You can also choose to trigger an on-demand patch assessment for your VM at any
time using the ‘Assess now’ option and review the results after assessment completes.

Similar to on-demand assessment, you can also install patches on-demand for your VM using the
‘Install updates now’ option. Here you can choose to install all updates under specific patch
classifications. You can also specify updates to include or exclude by providing a list of
individual knowledge base articles. Patches installed on-demand aren't installed using
availability-first principles and may require more reboots and VM downtime for update installation.

You can also view the installed patches using the
[Get-HotFix](/powershell/module/microsoft.powershell.management/get-hotfix) PowerShell command or
using the Settings app when using the Desktop Experience.

## Rollback support on Hotpatching

The installation of Hotpatch or Baseline updates doesn't support automatic rollback. If a VM
experiences an issue during or after an update, you'll have to uninstall the latest update and
install the last known good baseline update. You'll need to reboot the VM after rollback.

## Next steps

- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)
- [Enable Hotpatch for Azure Edition virtual machines built from ISO](enable-hotpatch-azure-edition.md)
- [Azure Update Management](/azure/automation/update-management/overview)
- [How to preview Azure Arc-connected Hotpatching for WIndows Server 2025](https://techcommunity.microsoft.com/t5/windows-server-news-and-best/how-to-preview-azure-arc-connected-hotpatching-for-windows/ba-p/4246895)