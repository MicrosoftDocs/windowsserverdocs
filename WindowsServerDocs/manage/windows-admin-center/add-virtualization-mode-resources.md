---
title: Add resources in Windows Admin Center Virtualization Mode (preview)
description: Learn how to create resource groups, add Hyper-V hosts with profiles, monitor deployment status, and safely remove resources in Windows Admin Center Virtualization Mode.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/17/2025
ai-usage: ai-assisted
#customer intent: As an infrastructure operator, I want to organize virtualization assets into Resource Groups and add Hyper-V hosts, so that I can manage compute resources consistently and prepare for future storage/network expansion.
---

# Add resources in Windows Admin Center Virtualization Mode

> [!IMPORTANT]
> Windows Admin Center Virtualization Mode is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Windows Admin Center Virtualization Mode lets you group virtualization assets for consistent management. This article explains how to create resource groups, add Hyper-V hosts or clusters with a compute profile, monitor deployment status, and remove resources safely.

Virtualization Mode focuses on virtualization infrastructure and presents resources through a navigation hierarchy. Before managing virtual machines (VMs), ensure you install Virtualization Mode and add at least one Hyper-V host as a compute resource in a resource group. For more information about Windows Admin Center Virtualization Mode concepts, see [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md).

## Prerequisites

Before you can add resources in Windows Admin Center Virtualization Mode, ensure the following prerequisites are met:

- Windows Admin Center Virtualization Mode is installed and available. For more information about installing Windows Admin Center Virtualization Mode, see [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md).

- You're accessing the Virtualization Mode gateway site using an account that has the _Gateway Administrator_ role or equivalent permissions.

- You have at least one host ready to add with the following prerequisites:

  - A minimum of 4 virtual CPUs (or equivalent physical cores), at least 8GB of RAM, and 10GB of free disk space.

  - Windows Server 2025 or later, Datacenter edition only.

  - Your server is domain-joined and has DNS resolution by using Fully Qualified Domain Name (FQDN). Hyper-V hosts you plan to manage are also on the same domain as the Virtualization Mode gateway.

  - Each host has the following Windows Server features installed:

    - Network ATC. For deployment guidance, see [Deploy host networking with Network ATC](../../networking/network-atc/network-atc.md).

    - Data Center Bridging. Included in the Network ATC guidance.

    - Hyper-V. For deployment guidance, see [Install Hyper-V](../../virtualization/hyper-v/get-started/Install-Hyper-V.md).

    - Failover Clustering. For more information about creating a cluster, see [Create a failover cluster](../../failover-clustering/create-failover-cluster.md).

- The signed-in user is a local Administrator on each Hyper-V host you plan to add.

## Create a resource group

To create a resource group, follow these steps:

1. From a web browser, open the Windows Admin Center Virtualization Mode gateway site and sign in.

1. In the resource pane, select the ellipsis (...) next to the Virtualization Mode host, then choose **Add Resource Group**. If you haven't added any resource groups yet, you can also select the **Create your first Resource Group** tile in the resource pane.

   :::image type="content" source="media/add-virtualization-mode-resources/create-resource-group.PNG" alt-text="Screenshot of the resource pane with the ellipsis menu open on the host showing the Add Resource Group action before any groups exist.":::

1. Enter a unique name for the resource group and a descriptive environment or service name. Select **Create** to confirm.

1. The new resource group appears in the navigation hierarchy with no resources. You can also select the notification bell icon to access recent actions and confirm creation.

   :::image type="content" source="media/add-virtualization-mode-resources/resource-group-created.PNG" alt-text="Screenshot of navigation after creation displaying the new empty Resource Group and a notification confirming successful addition.":::

## Enable host Windows Firewall rules

Before you can add a resource, you need to enable the following firewall inbound rules:

- **File and Printer Sharing (SMB-In)**:  only required for the agent installation and can be disabled after the resource is added.
- **Windows Remote Management**: used by the Virtualization Mode gateway to communicate with the host after the agent is installed.

You can enable the rules by using your preferred method of managing the Windows Firewall. For example, centrally using Group Policy, or locally on each node by using the Windows Firewall with Advanced Security console or PowerShell. For more information about managing the Windows Firewall and how-to guides, see [Windows Firewall tools](/windows/security/operating-system-security/network-security/windows-firewall/tools).

## Add resources

To add a resource to a resource group, follow these steps:

1. In the resource pane, select the ellipsis (...) next to the resource group, then choose **Add Host**.

1. For the **Getting started** tab, complete the following information, then select **Next** to continue:

   1. **Host Profile**: Select **Compute** for Hyper-V hosts.

   1. **Enter server or cluster names**: Enter the fully qualified domain name of the Hyper-V cluster you want to add (for example: `hv01.contoso.com`). Select **Add** to continue.

   :::image type="content" source="media/add-virtualization-mode-resources/add-resource-getting-started.PNG" alt-text="Screenshot of the Add Host wizard Getting started tab with Host FQDN field entered and Host Profile selection set to Compute.":::

1. For the **Networking** tab, complete one of the following steps, then select **Next** to continue. If you already have Network ATC intents configured on the host, they appear in the list.

   - To create a Network ATC intent, select a template from the **network intent template** dropdown and select a network interface on the host to bind the intent to. Once you have at least one management, one compute, and one storage intent configured, select **Add** to continue.

   Or

   - To create a new network intent template, follow these steps:

      1. Select **Network intent template**.
      1. From the **Add new network intent template** window, enter a **Network intent name**, then select the **Network intent type** from the dropdown.
      1. Change the advanced configuration to align with your network design as needed, then select **Create network intent** to add the new template.
      1. Select the newly created template from the **network intent template** dropdown and select a network interface on the host to bind the intent to. Once you have at least one management, one compute, and one storage intent configured, select **Add** to continue.

1. For the **Clustering** tab, leave the default settings and select **Next** to continue.

1. For the **Storage** tab, select **Use existing storage already configured on the system**, then select **Next** to continue.

   :::image type="content" source="media/add-virtualization-mode-resources/add-resource-storage-list.PNG" alt-text="Screenshot of the Add Host wizard Storage tab with Use existing storage already configured on the system option selected.":::

1. For the **Compute** tab, leave the default settings and select **Next** to continue.

When adding a resource, you can monitor its deployment status by using the _Workflow status_ icon at the top right of the Virtualization Mode site. The workflow status provides real-time updates on deployment progress, including agent installation and configuration steps.

:::image type="content" source="media/add-virtualization-mode-resources/add-resource-workflow-complete.PNG" alt-text="Screenshot of the workflow status panel showing deployment steps for the added host marked complete in the progress timeline.":::

## Remove a resource

To remove a resource from a resource group, follow these steps:

1. From the resource pane, select the ellipsis (...) next to the resource, then choose **Remove Host**.

1. When prompted to confirm the removal, select **Remove**.

1. Monitor the progress from the Workflow status icon.

## Remove a resource group

Before deleting a resource group, ensure it contains no hosts. To remove an empty resource group, follow these steps:

1. From the resource pane, select the ellipsis (...) next to the resource group, then choose **Delete Resource Group**.

1. When prompted to confirm deletion, select **Delete resource group**.

1. You receive a notification confirming the resource group removal.

## Next steps

> [!div class="nextstepaction"]
> [Manage virtual machines in Windows Admin Center Virtualization Mode](manage-virtualization-mode-virtual-machines.md)
