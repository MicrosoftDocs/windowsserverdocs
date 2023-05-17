---
title: Hotpatch for Windows Server Azure Edition
description: 'Learn how hotpatch for Windows Server Datacenter: Azure Edition works and how to enable it'
author: robinharwood
ms.topic: conceptual
ms.date: 05/16/2023
ms.author: wscontent
---

# Hotpatch for new virtual machines

Hotpatching is a new way to install updates on supported _Windows Server Datacenter: Azure Edition_ virtual machines (VMs) that doesn’t require a reboot after installation. It works by patching the in-memory code of running processes without the need to restart the process. This article covers information about hotpatch for supported VMs, which has the following benefits:

- Lower workload impact with less reboots
- Faster deployment of updates as the packages are smaller, install faster, and have easier patch orchestration with Azure Update Manager
- Better protection, as the hotpatch update packages are scoped to Windows security updates that install faster without rebooting

## Supported platforms

> [!IMPORTANT]
> Hotpatch is currently in PREVIEW for certain platforms in the following table.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

| Operating system | Azure | Azure Stack HCI |
|--|--|--|
| Windows Server 2022 Datacenter: Azure Edition Server Core | Generally available (GA) | Public preview |
| Windows Server 2022 Datacenter: Azure Edition with Desktop Experience | Public preview | Public preview |

## How Hotpatch works

Hotpatch works by first establishing a baseline with a Windows Update Latest Cumulative Update. Hotpatches are periodically released (for example, on the second Tuesday of the month) that builds on that baseline. Hotpatches contains updates that don't require a reboot. Because Hotpatch patches the in-memory code of running processes without the need to restart the process, your applications are unaffected by the patching process. This action is separate from any potential performance and functionality implications of the patch itself. Periodically (starting at every three months), the baseline is refreshed with a new Latest Cumulative Update.

The following image is an example of an annual three-month schedule (including example unplanned baselines due to zero-day fixes).

:::image type="content" source="media\hotpatch\hotpatch-sample-schedule.png" alt-text="Hotpatch Sample Schedule.":::

There are two types of baselines: **Planned baselines** and **Unplanned baselines**.

- **Planned baselines** are released on a regular cadence, with hotpatch releases in between. Planned baselines include all the updates in a comparable _Latest Cumulative Update_ for that month, and require a reboot.

  - The sample schedule illustrates four planned baseline releases in a calendar year (five total in the diagram), and eight hotpatch releases.

- **Unplanned baselines** are released when an important update (such as a zero-day fix) is released, and that particular update can't be released as a hotpatch. When unplanned baselines are released, a hotpatch release is replaced with an unplanned baseline in that month. Unplanned baselines also include all the updates in a comparable _Latest Cumulative Update_ for that month, and also require a reboot.

  - The sample schedule illustrates two unplanned baselines that would replace the hotpatch releases for those months (the actual number of unplanned baselines in a year isn't known in advance).

### Supported updates

Hotpatch covers Windows Security updates and maintains parity with the content of security updates issued to in the regular (nonhotpatch) Windows update channel.

There are some important considerations to running a supported _Windows Server Azure Edition_ VM with hotpatch enabled. Reboots are still required to install updates that aren't included in the hotpatch program. Reboots are also required periodically after a new baseline has been installed. Reboots keep the VM in sync with nonsecurity patches included in the latest cumulative update.

- Patches that are currently not included in the hotpatch program include nonsecurity updates released for Windows, and non-Windows updates (such as .NET patches).  These types of patches need to be installed during a baseline month, and require a reboot.

## How to get started

FIXME: is there any point in this section? If so it could be another article.

> [!NOTE]
> You can preview onboarding Automanage machine best practices during VM creation in the Azure portal using [this link](https://aka.ms/AzureEdition).

To start using hotpatch on a new VM, follow these steps:

1. Start creating a new VM from the Azure portal

    - You can preview onboarding Automanage machine best practices during VM creation in the Azure portal by visiting the [Azure Marketplace](https://aka.ms/AzureEdition).

1. Supply details during VM creation

    - Ensure that a supported _Windows Server Azure Edition_ image is selected in the Image dropdown. See [Getting started with Windows Server Datacenter: Azure Edition](azure-edition.md#getting-started-with-windows-server-datacenter-azure-edition) to determine which images are supported.

    - On the Management tab under section ‘Guest OS updates’, the checkbox for 'Enable hotpatch' is selected by default. Patch orchestration options are set to 'Azure-orchestrated'.

    - If you create a VM by visiting the [Azure Marketplace](https://aka.ms/AzureEdition), on the Management tab under section 'Azure Automanage', select 'Dev/Test' or 'Production' for 'Azure Automanage environment' to evaluate Automanage machine best practices while in preview.

1. Create your new VM

<!--
## Enabling preview access

### REST API

The following example describes how to enable the preview for your subscription:

```
POST on `/subscriptions/{subscriptionId}/providers/Microsoft.Features/providers/Microsoft.Compute/features/InGuestHotPatchVMPreview/register?api-version=2015-12-01`
POST on `/subscriptions/{subscriptionId}/providers/Microsoft.Features/providers/Microsoft.Compute/features/InGuestAutoPatchVMPreview/register?api-version=2015-12-01`
POST on `/subscriptions/{subscriptionId}/providers/Microsoft.Features/providers/Microsoft.Compute/features/InGuestPatchVMPreview/register?api-version=2015-12-01`
```

Feature registration can take up to 15 minutes. To check the registration status:

```
GET on `/subscriptions/{subscriptionId}/providers/Microsoft.Features/providers/Microsoft.Compute/features/InGuestHotPatchVMPreview?api-version=2015-12-01`
GET on `/subscriptions/{subscriptionId}/providers/Microsoft.Features/providers/Microsoft.Compute/features/InGuestAutoPatchVMPreview?api-version=2015-12-01`
GET on `/subscriptions/{subscriptionId}/providers/Microsoft.Features/providers/Microsoft.Compute/features/InGuestPatchVMPreview?api-version=2015-12-01`
```

Once the feature has been registered for your subscription, complete the opt-in process by propagating the change into the Compute resource provider.

```
POST on `/subscriptions/{subscriptionId}/providers/Microsoft.Compute/register?api-version=2019-12-01`
```

### Azure PowerShell

Use the ```Register-AzProviderFeature``` cmdlet to enable the preview for your subscription.

``` PowerShell
Register-AzProviderFeature -FeatureName InGuestHotPatchVMPreview -ProviderNamespace Microsoft.Compute
Register-AzProviderFeature -FeatureName InGuestAutoPatchVMPreview -ProviderNamespace Microsoft.Compute
Register-AzProviderFeature -FeatureName InGuestPatchVMPreview -ProviderNamespace Microsoft.Compute
```

Feature registration can take up to 15 minutes. To check the registration status:

``` PowerShell
Get-AzProviderFeature -FeatureName InGuestHotPatchVMPreview -ProviderNamespace Microsoft.Compute
Get-AzProviderFeature -FeatureName InGuestAutoPatchVMPreview -ProviderNamespace Microsoft.Compute
Get-AzProviderFeature -FeatureName InGuestPatchVMPreview -ProviderNamespace Microsoft.Compute
```

Once the feature has been registered for your subscription, complete the opt-in process by propagating the change into the Compute resource provider.

``` PowerShell
Register-AzResourceProvider -ProviderNamespace Microsoft.Compute
```

### Azure CLI

Use ```az feature register``` to enable the preview for your subscription.

```
az feature register --namespace Microsoft.Compute --name InGuestHotPatchVMPreview
az feature register --namespace Microsoft.Compute --name InGuestAutoPatchVMPreview
az feature register --namespace Microsoft.Compute --name InGuestPatchVMPreview
```

Feature registration can take up to 15 minutes. To check the registration status:
```
az feature show --namespace Microsoft.Compute --name InGuestHotPatchVMPreview
az feature show --namespace Microsoft.Compute --name InGuestAutoPatchVMPreview
az feature show --namespace Microsoft.Compute --name InGuestPatchVMPreview
```

Once the feature has been registered for your subscription, complete the opt-in process by propagating the change into the Compute resource provider.

```
az provider register --namespace Microsoft.Compute
```
-->

## Patch installation

Virtual machines created in Azure is enabled for [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching) by default with a supported _Windows Server Azure Edition_ image. With automatic VM guest patching enabled:

- Patches classified as Critical or Security are automatically downloaded and applied on the VM.

- Patches are applied during off-peak hours in the VM's time zone.

- Patch orchestration is managed by Azure and patches are applied following [availability-first principles](/azure/virtual-machines/automatic-vm-guest-patching#availability-first-updates).

- Virtual machine health, as determined through platform health signals, is monitored to detect patching failures.

When using Azure Stack HCI updates are orchestrated either by the operating system using Windows Updates, using Windows Server Update Services (WSUS), or manually by an administration. To learn more about using WSUS to manage and distribute updates, see [Windows Server Update Services (WSUS)](../administration/windows-server-update-services/get-started/windows-server-update-services-wsus.md).

## Understanding the patch status for your VM in Azure

To view the patch status for your VM, navigate to the **Guest + host updates** section for your VM in the Azure portal. Under the **Guest OS updates** section, select ‘Go to Hotpatch (Preview)’ to view the latest patch status for your VM.

On this screen, you see the hotpatch status for your VM. You can also review if there any available patches for your VM that haven't been installed. As described in the ‘Patch installation’ previous section, all security and critical updates are automatically installed on your VM using [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching) and no extra actions are required. Patches with other update classifications aren't automatically installed. Instead, they're viewable in the list of available patches under the ‘Update compliance’ tab. You can also view the history of update deployments on your VM through the ‘Update history’. Update history from the past 30 days is displayed, along with patch installation details.

:::image type="content" source="media\hotpatch\hotpatch-management-ui.png" alt-text="Hotpatch Management.":::

With automatic VM guest patching, your VM is periodically and automatically assessed for available updates. These periodic assessments ensure that available patches are detected. You can view the results of the assessment on the Updates screen above, including the time of the last assessment. You can also choose to trigger an on-demand patch assessment for your VM at any time using the ‘Assess now’ option and review the results after assessment completes.

Similar to on-demand assessment, you can also install patches on-demand for your VM using the ‘Install updates now’ option. Here you can choose to install all updates under specific patch classifications. You can also specify updates to include or exclude by providing a list of individual knowledge base articles. Patches installed on-demand aren't installed using availability-first principles and may require more reboots and VM downtime for update installation.

## Next steps

- [Azure Update Management](/azure/automation/update-management/overview)
- [Automatic VM Guest Patching](/azure/virtual-machines/automatic-vm-guest-patching)
- [Enable Hotpatch for Azure Edition virtual machines built from ISO (preview)](enable-hotpatch-azure-edition.md)
