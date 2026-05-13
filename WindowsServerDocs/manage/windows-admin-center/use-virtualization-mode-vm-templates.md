---
title: Use VM templates in Windows Admin Center Virtualization Mode (preview)
description: Learn how to convert VMs to templates, deploy new VMs from templates, and convert templates back to VMs in Windows Admin Center Virtualization Mode.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 05/13/2026
ai-usage: ai-assisted
#customer intent: As a Hyper-V administrator, I want to create and manage VM templates in Virtualization Mode so that I can standardize VM provisioning across my hosts.
---

# Use VM templates in Windows Admin Center Virtualization Mode (preview)

Virtual machine (VM) templates in Windows Admin Center Virtualization Mode let you save a configured VM as a reusable, read-only blueprint. Instead of manually creating each VM, you define a configuration once and deploy consistent VMs across your Hyper-V hosts.

This article walks you through converting a VM to a template, deploying new VMs from a template, and converting a template back to a regular VM.

> [!IMPORTANT]
> Windows Admin Center Virtualization Mode is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Prerequisites

- Windows Admin Center Virtualization Mode installed and available. For more information, see [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md).

- At least one resource group that contains one or more Hyper-V hosts that you added by using the **Compute** profile. For more information, see [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

- An account with the _Gateway Administrator_ role or equivalent permissions and local Administrator rights on each Hyper-V host.

- At least one existing VM on a managed Hyper-V host. The VM must be shut down before you can convert it to a template. For more information about creating VMs, see [Manage virtual machines in Windows Admin Center Virtualization Mode](manage-virtualization-mode-virtual-machines.md).

## Convert a VM to a template

When you convert a VM to a template, you make it read-only and a `{Template}{Read-only}` prefix is automatically added to its name in the resource pane. The original VM isn't available as a running VM after conversion.

> [!TIP]
> Before you convert a VM to a template, run sysprep on the VM to generalize it. Sysprep removes machine-specific information and prepares the VM for deployment as a template. For more information about sysprep, see [Sysprep (Generalize) a Windows installation](/windows-hardware/manufacture/desktop/sysprep--generalize--a-windows-installation).

To convert a VM to a template, follow these steps:

1. Open the Windows Admin Center Virtualization Mode gateway site, and then sign in with an account that has the _Gateway Administrator_ role or equivalent permissions.

1. In the resource pane, expand the resource group and host, and then locate the VM you want to convert.

1. Verify the VM is shut down. If the VM is running, power it off before continuing.

1. Select the ellipsis (**...**) next to the VM name or right-click the VM name, and then select **Convert to Template**.

1. A notification appears when conversion starts. To monitor progress, select the notification bell icon to open the **Workflow status** panel. The workflow validates VM eligibility, converts the VM, updates the database, and verifies template creation.

1. When the workflow completes, the VM appears in the resource pane with the `{Template}{Read-only}` prefix.

## Deploy a new VM from a template

When you deploy a VM from a template, you create a new VM based on the template's configuration. The template stays unchanged and is available for future deployments.

To deploy a new VM from a template, follow these steps:

1. In the **resource pane**, find the template you want to deploy. Templates display with the `{Template}{Read-only}` prefix.

1. Select the ellipsis (**...**) next to the template name or right-click the template, and then select **Deploy VM**.

1. In the **Deploy VM from template** panel, complete the following required fields:

   | Field | Description |
   |---|---|
   | **Virtual machine name** | Enter a name for the new VM. Use your organizational naming conventions. |
   | **Storage path** | Enter the storage path for the new VM files (for example, `C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines`). |

1. Select **Deploy** to start the deployment.

1. A notification confirms that the deployment starts. To monitor progress, select the notification bell icon to open the **Workflow status** panel. The workflow validates the template, exports it, imports a new VM, starts the VM, and restores the template.

1. When the workflow completes, the new VM appears in the resource pane under the host and starts automatically. Select the VM to view its properties, including state, generation, memory, and operating system details.

## Convert a template back to a VM

If you no longer need a template, you can convert it back to a regular VM. This action removes the read-only status and makes the VM editable again.

To convert a template back to a VM:

1. In the **resource pane**, locate the template you want to convert back. Templates display with the `{Template}{Read-only}` prefix.

1. Select the ellipsis (**...**) next to the template name, and then select **Convert to VM**.

1. In the **Convert to VM** confirmation dialog, review the template name, and then select **Convert** to confirm.

1. A notification confirms the conversion started. To monitor progress, select the notification bell icon to open the **Workflow status** panel.

1. When the workflow completes, the template is converted back to a regular VM and the `{Template}{Read-only}` prefix is removed from its name in the resource pane.

## Related content

- [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md)
- [Manage virtual machines in Windows Admin Center Virtualization Mode](manage-virtualization-mode-virtual-machines.md)
- [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md)
- [Known issues in Windows Admin Center Virtualization Mode](virtualization-mode-known-issues.md)
