---
title: Add resources in Windows Admin Center Virtualization Mode (preview)
description: Learn how to add Hyper-V hosts, create resource groups, and configure networking, storage, and compute settings in Windows Admin Center Virtualization Mode.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 04/30/2026
ai-usage: ai-assisted
#customer intent: As an infrastructure operator, I want to organize virtualization assets into Resource Groups and add Hyper-V hosts, so that I can manage compute resources consistently and prepare for future storage/network expansion.
---

# Add resources in Windows Admin Center Virtualization Mode (preview)

> [!IMPORTANT]
> Windows Admin Center Virtualization Mode is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Windows Admin Center Virtualization Mode (preview) lets you group virtualization assets for consistent management. This article explains how to create resource groups, add Hyper-V hosts or clusters, configure networking intents, storage, and compute settings, monitor deployment status, and remove resources safely.

Virtualization Mode focuses on virtualization infrastructure and presents resources through a navigation hierarchy. Before managing virtual machines (VMs), ensure you install Virtualization Mode and add at least one Hyper-V host as a compute resource in a resource group. For more information about Windows Admin Center Virtualization Mode concepts, see [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md).

## Prerequisites

Before you can add resources in Windows Admin Center Virtualization Mode (preview), ensure the following prerequisites are met:

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

- Each host isn't already managed by another Virtualization Mode instance. If a host has an existing Virtualization Mode agent, either remove the resource from the other Virtualization Mode system or uninstall the agent from **Installed apps** on the host before adding it.

## Create a resource group

To create a resource group, follow these steps:

1. From a web browser, open the Windows Admin Center Virtualization Mode gateway site and sign in.

1. In the resource pane, select the ellipsis (...) next to the Virtualization Mode host, then choose **Add Resource Group**. If you haven't added any resource groups yet, you can also select the **Create your first Resource Group** tile in the resource pane.

   :::image type="content" source="media/add-virtualization-mode-resources/create-resource-group.PNG" alt-text="Screenshot of the Virtualization Mode resource pane with the ellipsis menu open on the host showing the Add Resource Group action.":::

1. Enter a unique name for the resource group and a descriptive environment or service name. Select **Create** to confirm.

1. The new resource group appears in the navigation hierarchy with no resources. You can also select the notification bell icon to access recent actions and confirm creation.

   :::image type="content" source="media/add-virtualization-mode-resources/resource-group-created.PNG" alt-text="Screenshot of the Virtualization Mode navigation pane displaying the new empty resource group and a notification confirming creation.":::

## Enable host Windows Firewall rules

Before you can add a resource, you need to enable the following firewall inbound rules:

- **File and Printer Sharing (SMB-In)**: only required for the agent installation and can be disabled after the resource is added.
- **Windows Remote Management**: used by the Virtualization Mode gateway to communicate with the host after the agent is installed.

You can enable the rules by using your preferred method of managing the Windows Firewall. For example, centrally using Group Policy, or locally on each node by using the Windows Firewall with Advanced Security console or PowerShell. For more information about managing the Windows Firewall and how-to guides, see [Windows Firewall tools](/windows/security/operating-system-security/network-security/windows-firewall/tools).

## Add resources

To add a resource to a resource group, follow these steps:

1. In the resource pane, select the ellipsis (...) next to the resource group, then choose **Add Host**.

### Getting started

The Getting started tab is where you select a host profile and specify the servers or clusters to onboard. To configure the Getting started tab, follow these steps:

1. For the **Getting started** tab, complete the following information, then select **Next** to continue:

   1. **Host profile**: Select the profile for the hosts you're adding. For Hyper-V hosts, select **Compute**. For storage systems, select **Storage**.

   1. **Enter server or cluster names**: Enter the fully qualified domain name (FQDN) of the server or cluster you want to add (for example: `hv01.contoso.com`). Select **Validate** to verify the host, then select **Add** to add it to the list.

      When you add a cluster name, the wizard automatically detects and adds all member nodes in that cluster. The server list displays the number of clusters, nodes, and associated cluster node names.

      When you add standalone servers, a **Clustered** toggle appears with a **Create a new cluster** option. Enable this toggle to create a new failover cluster from the standalone nodes during onboarding.

   :::image type="content" source="media/add-virtualization-mode-resources/add-resource-getting-started.PNG" alt-text="Screenshot of the Virtualization Mode Add Resource wizard Getting started tab with Host FQDN field entered and Host Profile set to Compute.":::

### Clustering

The Clustering tab lets you configure failover cluster settings or create a new cluster from standalone nodes. To configure the Clustering tab, follow these steps:

1. For the **Clustering** tab, configure the cluster settings and then select **Next** to continue.

   If you're adding an existing cluster, leave the default settings and select **Next** to continue.

   If you're creating a new cluster, complete the following information:

   1. **Cluster name**: Enter a name for the new cluster. The wizard validates that the name is available.

   1. **IP address assignment**: Select one of the following options:

      - **Assign address dynamically with DHCP**: Use DHCP to automatically assign the cluster IP address.
      - **Specify one or more static addresses**: Enter a static IP address for the cluster. The wizard validates that the address is available. Select **Add IP address** to add more addresses if needed.

### Networking

The Networking tab is where you define Network ATC intent templates for management, compute, and storage traffic on your hosts. To configure the Networking tab, follow these steps:

1. For the **Networking** tab, configure Network ATC intent templates for your hosts, then select **Next** to continue. If you already have Network ATC intents configured on the host, they appear in the list.

   You need at least one management, one compute, and one storage intent configured before you can proceed.

   To apply an existing network intent template, select a template from the **network intent template** dropdown. Network intent templates you created in previous sessions are saved and available for reuse. Select a network interface on the host to bind the intent to, then select **Add**.

   To create a new network intent template, follow these steps. To learn more about network intent templates, see [Network intent templates](virtualization-mode-overview.md#network-intent-templates).

   1. Select **Network intent template** to open the **Add new network intent template** dialog.

   1. Enter the following required fields:

      - **Template name**: A name that identifies this template for reuse across onboarding sessions.
      - **Network intent name**: The name for the Network ATC intent.
      - **Network intent type**: Select the intent type from the dropdown (for example, **Compute, Management, Storage** or **Storage**).

   1. Optionally, expand the **Advanced configuration** section to customize override settings. The available overrides change dynamically based on the intent type you select. Defaults are prepopulated, and only values you change are submitted as overrides. Override sections include:

      - **Adapter advanced overrides**: Jumbo packet size, Network direct technology.
      - **QoS policy overrides**: Priority value 802.1 action (cluster), Priority value 802.1 action (SMB), Bandwidth percentage (SMB).
      - **Adapter storage overrides**: Enable automatic IP generation.

   1. Select **Create network intent template** to save the template.

   1. Select the newly created template from the **network intent template** dropdown and select a network interface on the host to bind the intent to, then select **Add**.

   The wizard displays all physical network adapters on your hosts, including disconnected adapters, so you can see your full hardware inventory before configuring intents. The wizard validates that the network intent is successfully applied before onboarding completes.

   > [!TIP]
   > You can also view and manage your network intent templates outside of the Add Resource wizard. Select the **Network** view in the top navigation bar to browse, create, edit, and delete network intent templates.

### Storage

The Storage tab lets you configure the storage that your hosts use for virtual machines. You can configure SAN storage, file server storage, or use storage already configured on the system. To configure the Storage tab, follow these steps:

1. For the **Storage** tab, select your storage configuration from the **Storage options** dropdown, then select **Next** to continue. You can select multiple storage options. The following options are available:

   - [**SAN storage**](#tab/san-storage): Configure Storage Area Network (SAN)-attached disks as Cluster Shared Volumes (CSVs).
   - **File server storage**: Configure Server Message Block (SMB) file shares for VM storage. For more information, see the [File server storage](#tab/file-server-storage) tab.
   - **Hyperconverged storage**: Not available in this preview release.
   - **Use existing storage already configured on the system**: Skip storage configuration if you already configured storage or plan to configure it later.

   To learn more about storage architectures, see [Storage architectures for failover clusters](../../failover-clustering/storage-architectures.md).

#### [SAN storage](#tab/san-storage)

When you select **SAN storage**, the wizard scans for available SAN disks on the cluster and sorts them into three categories:

- **Ready**: These disks are already configured as a CSV and ready for use. The table displays the **CSV** name, **Friendly Name**, **Serial Number**, **Storage Target**, **Status**, and **Partitioned** columns.

- **Auto configure**: These disks can be automatically set up as CSVs. Enter a **CSV** name for each disk you want to configure, and the wizard performs the following steps:

  1. Initializes and brings the disk online.
  1. Creates a GPT partition and formats it with NTFS.
  1. Adds the disk to the failover cluster.
  1. Adds the disk as a Cluster Shared Volume with the name you specify.
  1. Ensures the file system path matches the CSV name (for example, `C:\ClusterStorage\CSV01`).
  1. Configures the CSV Block Cache to the recommended value.

  If you don't want the wizard to configure a disk, leave the **CSV** name blank and the wizard skips it.

- **Manual configure**: These disks require manual intervention before they can be configured as CSVs. Hover over the information icon to see the reason, such as the disk not being available on every cluster node.

Select **Refresh** to rescan for disks. Expand the **More information on SAN storage** section at the bottom of the page for more details about disk requirements.

#### [File server storage](#tab/file-server-storage)

When you select **File server storage**, you configure SMB file shares for your VM storage:

1. Enter the SMB file share path. The wizard validates that the share exists and has access.

1. For Windows-based file servers, the Virtualization Mode agent is installed so you can manage the file server from the **Storage** view after the wizard completes.

1. Optionally, select whether you want Virtualization Mode to configure access permissions for the file share. When selected, permissions are updated to include all systems needed for live migration.

1. Optionally, select whether you want Virtualization Mode to enable SMB delegation. When selected, Virtualization Mode attempts to enable constrained delegation for live migration. If the necessary Active Directory permissions aren't available, the deployment status informs you so you can configure delegation manually.

> [!NOTE]
> For non-Windows-based file servers, the permissions and delegation options aren't available.

---

### Compute

The Compute tab lets you configure Hyper-V host settings that are applied consistently across all systems you're onboarding. To configure the Compute tab, follow these steps:

1. For the **Compute** tab, configure the following Hyper-V host settings for your systems, then select **Next** to continue.

   1. **Remove non-essential features**: Select this checkbox to remove unused Windows Server features from the hosts. Removing non-essential features reduces the system's attack surface and lowers patching and servicing overhead.

   1. **Enable enhanced session mode**: Select this checkbox to enable Enhanced Session Mode for both the user and computer configuration. Enhanced Session Mode provides a desktop-like experience when connecting to VMs through Virtual Machine Connection, including resizable windows, clipboard sharing, and device redirection.

   1. **Configure concurrent migrations**: Select the number of concurrent live migrations and storage migrations allowed (1, 2, or 4). Increasing concurrency reduces the total time to complete batch migrations but uses more CPU, storage, and network bandwidth.

   1. **Default virtual machine path**: Select the default storage location for virtual machines and virtual hard disks. The dropdown is populated based on the storage configuration you specified on the **Storage** tab. For example, if you configured a CSV, the dropdown shows the CSV name and the corresponding path (such as `C:\ClusterStorage\csv01\Virtual Machines\`).

### Review and deploy

The Review tab displays a summary of all your configuration choices before deployment begins. To review and deploy, follow these steps:

1. For the **Review** tab, verify your configuration settings and select **Submit** to begin the deployment.

When adding a resource, you can monitor its deployment status by using the _Workflow status_ icon at the top right of the Virtualization Mode site. The workflow status provides real-time updates on deployment progress, including agent installation and configuration steps.

During deployment, the wizard installs the required features on all compute hosts, including Hyper-V, Network ATC, Data Center Bridging, Failover Clustering, and AD RSAT PowerShell tools. If SAN storage was configured, Multipath I/O (MPIO) is also installed. Non-essential features are removed if you selected that option. This process requires a reboot. For existing clusters, the wizard performs a rolling reboot, draining VMs from each node first to avoid disruption.

:::image type="content" source="media/add-virtualization-mode-resources/add-resource-workflow-complete.PNG" alt-text="Screenshot of the Virtualization Mode workflow status panel showing deployment steps for the added host marked as complete.":::

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
