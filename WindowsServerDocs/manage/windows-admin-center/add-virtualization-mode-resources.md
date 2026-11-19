---
title: Add Hyper-V Resources in Windows Admin Center
description: Learn how to add Hyper-V hosts and clusters, configure networking and storage, and monitor onboarding in Windows Admin Center Virtualization Mode.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/10/2026
ai-usage: ai-assisted
#customer intent: As an infrastructure operator, I want to add Hyper-V hosts and clusters to a resource group so that I can manage compute resources consistently.
---

# Add compute resources in Windows Admin Center Virtualization Mode

Windows Admin Center Virtualization Mode organizes Hyper-V hosts and clusters into resource groups for centralized compute management. Resource groups give you a consistent scope for networking, storage, and Hyper-V settings across the compute resources you manage. This procedure applies only to supported Standard and Datacenter editions of Windows Server 2025 and Windows Server 2022 with the March 2026 cumulative update or a later cumulative update.

In this article, you create a resource group and onboard standalone hosts or a cluster. After deployment finishes, Windows Admin Center Virtualization Mode configures the compute resources for management.

## Prerequisites

- Completion of [Install Windows Admin Center Virtualization Mode](deploy/install.md).
- An account with the **Fabric Manager** role in Virtualization Mode. For more information, see [Built-in roles in Windows Admin Center Virtualization Mode](virtualization-mode-authentication-access-control.md#built-in-roles-in-windows-admin-center-virtualization-mode).
- At least one host with a minimum of 4 virtual central processing units (CPUs) or equivalent physical cores, 8 GB of random access memory (RAM), and 10 GB of free disk space.
- A supported Standard or Datacenter edition of Windows Server 2025, or Windows Server 2022 with the March 2026 cumulative update or later, on each host.
- Ensure that each host joins the same domain as the Virtualization Mode gateway and that the Domain Name System (DNS) can resolve the host by its fully qualified domain name (FQDN).
- An account that is a member of the local **Administrators** group on each host.
- Network connectivity from the gateway to each host for Server Message Block (SMB), the `C$` administrative share, and Windows Remote Management (WinRM).
- Enable the **File and Printer Sharing (SMB-In)** and **Windows Remote Management** inbound firewall rules on each host. Keep SMB-In and access to `C$` available while Virtualization Mode manages the resource. The gateway uses these dependencies to deploy, update, or remove the agent and perform management operations. Enable the rules by using Group Policy, Windows Defender Firewall with Advanced Security, or PowerShell. For more information, see [Windows Firewall tools](/windows/security/operating-system-security/network-security/windows-firewall/tools).
- A host that no other Virtualization Mode instance manages. If the Virtualization Mode agent is already installed, remove the resource from its current Virtualization Mode instance or uninstall the agent from **Installed apps**.

## Create a resource group

Create a resource group to organize the hosts and clusters that you manage together. If you already have a resource group, continue to [Add compute resources](#add-compute-resources). For background information, see [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md)

1. Open the Windows Admin Center Virtualization Mode gateway site in a web browser, and then sign in.

1. In the **resource pane**, select the **ellipsis (...)** next to the Virtualization Mode gateway, and then select **Add resource group**.

   :::image type="content" source="media/add-virtualization-mode-resources/create-resource-group.png" alt-text="Screenshot of Windows Admin Center Virtualization Mode showing the Create a resource group tile in the resource pane.":::

1. Enter a unique resource group name. The name can contain letters, numbers, periods, underscores, and hyphens. Don't use spaces, other special characters, or a period at the beginning or end of the name.

1. Optionally, enter a description, and then select **Create resource group**.

1. Verify that the empty resource group appears in the **navigation hierarchy** and that the **notification pane** contains a **Group Created** notification.

   :::image type="content" source="media/add-virtualization-mode-resources/resource-group-created.png" alt-text="Screenshot of Windows Admin Center Virtualization Mode showing the Corp resource group and a Group Created notification marked Completed.":::

## Add compute resources

Use the **Add resource** wizard to add standalone Hyper-V hosts, an existing failover cluster, or standalone hosts that Virtualization Mode joins into a new cluster.

1. In the resource pane, select the ellipsis (...) next to the resource group, and then select **Add resource**.

1. On the **Getting started** tab, configure the resources and select the onboarding path:

   1. Configure the following fields:

      | Field | Description |
      |---|---|
      | **Host profile** | Select **Compute**. To add a storage resource instead, select **Storage** and follow [Add storage resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-storage-resources.md). You can see the **Networking** profile, but you can't select it. |
      | **Enter server or cluster names** | Enter the FQDN of a standalone server or cluster, such as `hv01.contoso.com`. You can't enter compute resources by IP address. |

   1. Select **Validate**. Validation checks the resource type, Windows Server version, DNS resolution, cluster membership, SMB connectivity, and whether another Virtualization Mode gateway manages the resource.

      You can't add the Virtualization Mode gateway itself. You also can't combine an existing cluster with standalone hosts or add more than one existing cluster in the same workflow.

   1. After validation succeeds, select **Add**.

   1. Select one of the following paths:

      If you add an existing cluster, continue with the discovered cluster. The wizard discovers its member nodes. The cluster must have an FQDN, member-node FQDNs, and at least one online Internet Protocol version 4 (IPv4) cluster address.

      If the validated standalone hosts should remain standalone, leave **Clustered** cleared.

      If you want to create a cluster from the validated standalone hosts, enable **Clustered**, and then select **Create a new cluster**.

      :::image type="content" source="media/add-virtualization-mode-resources/add-resource-getting-started.png" alt-text="Screenshot of Windows Admin Center Virtualization Mode Add resource wizard with Host profile and server name fields blank and Clustered cleared.":::

   1. Select **Next**.

1. On the **Clustering** tab, follow the path for the resources that you add:

   If you add an existing cluster, accept the displayed configuration, and then select **Next**.

   If you add standalone hosts that should remain standalone, accept the displayed configuration, and then select **Next**.

   If you create a new cluster from standalone Hyper-V hosts:

   1. Enter a cluster name of 15 characters or fewer.

      The name can contain letters, numbers, and hyphens. It must start and end with a letter or number, can't contain only numbers, and must not match a reserved Windows name.

   1. Wait for the wizard to confirm that the cluster name is available.

   1. Select an IP address assignment option:

      - **Assign address dynamically with DHCP**. This option uses Dynamic Host Configuration Protocol (DHCP).
      - **Specify one or more static addresses**.

   1. If you selected static addresses, enter an IPv4 address, select **Validate**, and then select **Add IP address**. Repeat this step for each address.

   1. Select **Next**.

      :::image type="content" source="media/add-virtualization-mode-resources/add-resource-clustering.png" alt-text="Screenshot of the Windows Admin Center Virtualization Mode Clustering tab showing Cluster01 and 10.0.0.42 available with static addressing selected.":::

1. On the **Networking** tab, configure Network ATC intents for hosts in a new or existing failover cluster. The wizard shows existing intents and their status. For an existing cluster, an existing intent satisfies a requirement only when its configuration is successful and symmetric across all selected cluster nodes.

   If you add standalone Hyper-V hosts that remain standalone, you don't need to configure Network ATC intents. The wizard leaves their existing network configuration unchanged. Select **Next**.

   Network intent requirements depend on the resource profile and resource type:

   | Resource profile | Required intent types |
   |---|---|
   | **Clustered Compute** | Management and Compute. One intent can include both types. |
   | **Windows Storage-only** | Management |
   | **Non-Windows Storage** | None |

   For clustered compute resources, verify that the configuration includes Management and Compute. Storage Spaces Direct and Ethernet-based storage such as SMB or iSCSI benefit from a Storage intent, but external SAN storage doesn't require one.

   1. If you create a new failover cluster from standalone Hyper-V hosts, delete every existing Network ATC intent from those hosts before cluster creation. You can delete each intent in the wizard.

      Alternatively, you can delete the intents directly from the hosts before you start onboarding. If you change networking directly on a host while the wizard is open, select **Refresh** to retrieve the current intents and adapters.

   1. Configure a Network ATC intent by applying an existing network intent template or by creating and applying a template:

      If you want to apply an existing network intent template:

      1. Under **Create network intents**, select a template from **Select network intent template**.

      1. Select one or more eligible adapters, and then close the adapter dropdown. Validation starts automatically.

      1. Resolve any errors or warnings. If you change the configuration after the initial validation, select **Revalidate**.

      1. After validation succeeds, select **Add intent**.

      If you want to create a template, see [Network intent templates](virtualization-mode-overview.md#network-intent-templates) for more information, and then follow these steps:

      1. Select **Create intent template**, and then enter:

         | Field | Description |
         |---|---|
         | **Network intent type** | One or more intent types. Management and Storage can each appear in only one intent per cluster. Compute can appear in multiple intents. |
         | **Template name** | A unique name for the reusable configuration. Virtualization Mode saves templates across sessions. |
         | **Network intent name** | The Network ATC intent name. If an existing cluster already has an intent with this name, Virtualization Mode creates the template, but the template doesn't appear in the **Select network intent template** dropdown. |

         Virtualization Mode stores templates as reusable configurations. Applying a template creates an intent on a host or cluster. Editing a template changes only future deployments that use it; it doesn't update an intent that you applied. The template name and network intent name can differ.

         Network ATC doesn't support renaming existing intents.

         If you want to change the applicable settings, expand **Advanced configuration**. The intent type that you select determines the available advanced options. The wizard prepopulates its shipped defaults and submits only values that you change as overrides.

         | Override section | Settings |
         |---|---|
         | **Adapter advanced overrides** | Jumbo packet size and Network Direct technology |
         | **QoS policy overrides** | Quality of Service (QoS) settings for cluster priority, Server Message Block (SMB) priority, and SMB bandwidth percentage |
         | **Adapter storage overrides** | Automatic IP generation and Storage virtual local area network (VLAN) identifiers |
         | **Switch configuration overrides** | I/O virtualization (IOV) and load-balancing algorithm |

         Storage VLAN settings appear under **Adapter storage overrides**, but they aren't Network ATC overrides.

      1. Select **Create intent template**.

         If the template is valid, Virtualization Mode automatically adds it to **Select network intent template** under **Create network intents**.

      1. Select one or more eligible adapters, and then close the adapter dropdown. Validation starts automatically.

      1. Resolve any errors or warnings. If you change the configuration after the initial validation, select **Revalidate**.

      1. After validation succeeds, select **Add intent**.

      Physical Ethernet adapters can appear in the inventory even when no cable connects them. To use an adapter in a new intent, its **Status** must be **Up**, it must report a link speed, no other intent can use it, and it must be symmetric across the selected nodes. It must also support the Network Direct technology that the template selects. For more information, see [Network ATC prerequisites](../../networking/network-atc/network-atc.md#prerequisites).

   1. Resolve any unhealthy or asymmetric existing intent configurations, and then select **Next**.

      Network changes can interrupt connectivity. Removing an intent doesn't necessarily remove underlying network objects, such as virtual switches, that can conflict with a new intent. Review the existing configuration before you continue.

      For a new cluster, onboarding creates and verifies the configured intents on each host before it creates the cluster, and then applies and verifies the intents at cluster scope. A host-level creation or verification failure stops the workflow before cluster creation. For an existing cluster, Virtualization Mode uses its successful, symmetric intents and applies the additional intents that you configure.

      > [!TIP]
      > You can manage network intent templates outside the **Add resource** wizard. Select the **Network** view in the top navigation bar to browse, create, edit, and delete network intent templates. Template changes apply only to future deployments that use the template.
      >
      > To manage Network ATC intents after deployment, use the Network ATC PowerShell cmdlets. For guidance on updating intent settings, changing assigned network adapters, or removing intents, see [Manage Network ATC](../../networking/network-atc/manage-network-atc.md).

1. On the **Storage** tab, configure storage access that the Compute profile uses for virtual machines. This configuration attaches or uses existing storage; it doesn't onboard the storage system as a managed resource. To onboard a storage system by using the **Storage** host profile, see [Add storage resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-storage-resources.md).

   1. Select one or more options:

      - **SAN storage**, which uses a storage area network (SAN).
      - **File server storage**
      - **Use existing storage already configured on the system**

      If you select **Use existing storage already configured on the system**, don't select either of the other options. **Hyperconverged storage** isn't available.

      <details>
      <summary>SAN storage configuration details</summary>

      When you select **SAN storage**, the wizard scans for available SAN disks on the cluster and sorts them into three categories:

      > [!WARNING]
      > Selecting a SAN disk for automatic configuration can result in data loss. Protect or back up any existing data that you need to keep before you select the disk.

      1. If you configure Internet Small Computer Systems Interface (iSCSI) SAN storage:

         1. Select **SAN storage**, and then review the disks in the following categories:

            - **Ready**: A standalone-host disk has a New Technology File System (NTFS) volume and drive letter. A clustered disk is already a Cluster Shared Volume (CSV).
            - **Auto configure**: Virtualization Mode can configure the disk automatically.
            - **Manual configure**: The disk doesn't meet the automatic-configuration requirements. Select its information icon to view the required remediation.

         1. For each **Auto configure** disk that you want to use, follow the applicable path:

            If you add a standalone host, select a drive letter.

            If you add or create a cluster, enter a unique CSV name.

            Leave the drive letter or CSV name blank to omit the disk from automatic configuration. Select **Refresh** after you change storage directly on a host.

            If you add or create a cluster, automatic configuration brings the disk online, initializes an unpartitioned disk as GPT, formats it with NTFS, adds it to the cluster and CSV, aligns the path with `C:\ClusterStorage\<CSVName>`, and sets the CSV Block Cache to at least 2,048 MB.

      </details>

      <details>
      <summary>File server storage configuration details</summary>

      When you select **File server storage**, you configure SMB file shares for your virtual machine (VM) storage:

      1. If you use SMB storage:

         1. Select **File server storage**, enter a Universal Naming Convention (UNC) share path, and then select **Add**.

            The wizard validates the path, your access, and the server type. A Windows file server must be part of a failover cluster, and all Windows shares in one workflow must belong to the same storage cluster. You must be an administrator on every storage-cluster node.

         1. If you use a Windows storage cluster, optionally select:

            - Configure SMB and NTFS permissions for the compute hosts.
            - Configure constrained delegation for live migration.

            If you use non-Windows storage, Virtualization Mode doesn't offer these options. If Virtualization Mode can't configure delegation automatically, workflow status identifies the manual action.

      </details>

   1. Select **Next**.

1. On the **Compute** tab, configure the Hyper-V settings that Virtualization Mode applies to each compute host:

   1. Configure the following settings:

      | Setting | Description |
      |---|---|
      | **Remove non-essential features** | Removes payloads for unused Windows Server features. |
      | **Enable enhanced session mode** | Configures the Hyper-V host setting for clipboard sharing, display resizing, and local device redirection. |
      | **Configure concurrent migrations** | Sets both the simultaneous virtual machine and storage migration limits. Select **None**, **1**, **2 (Default)**, or **4**. |
      | **Default virtual machine path** | Sets the default path for VM configuration and virtual hard disk files. Choose a path from the drive letters, CSVs, or SMB shares that you configured, or select **Custom**. |

   1. Select **Next**.

1. On the **Review** tab, review the configuration before Virtualization Mode starts the onboarding workflow:

   1. Verify the configuration.

   1. Select **Submit**.

1. Open **Workflow status** to monitor the deployment. Virtualization Mode polls active workflow status every five seconds and shows the current agent installation and configuration step.

   The resource appears in the navigation hierarchy while Virtualization Mode onboards it. Select the resource to view its workflow status.

   During onboarding, Virtualization Mode installs the applicable Windows Server features, updates, and related components, including Hyper-V, Network ATC, Data Center Bridging, Failover Clustering, and Multipath I/O. It restarts a standalone host only when installation or updates require a restart. For a cluster, Virtualization Mode drains and conditionally restarts affected nodes sequentially.

   Network intent verification allows its PowerShell check up to 15 minutes to finish. A 20-minute workflow guard stops the verification step if it doesn't finish.

1. If the workflow stops before completion, follow the applicable path:

   If an interrupted workflow offers **Resume**, select it to continue.

   If a failed workflow offers **Retry**, select it to rerun the failed step. Retry only safely rerunnable steps, up to three times.

   If network intent verification fails, review the failed step in **Workflow status**. Keep the intent names that you configured in the wizard if you repair an intent and retry verification in the same workflow. The Virtualization Mode Agent logs include Network ATC event logs. For more information, see [Common Network ATC error messages](../../networking/network-atc/network-atc.md#common-error-messages).

1. Verify that the workflow status is **Completed** and that the compute resource is available in the navigation hierarchy.

   :::image type="content" source="media/add-virtualization-mode-resources/add-resource-workflow-complete.png" alt-text="Screenshot of Windows Admin Center Virtualization Mode Workflow status pane showing all Add host steps complete for contosohv03.contoso.com.":::

## Remove compute resources and resource groups

Remove compute resources and resource groups you no longer want Virtualization Mode to manage.

### Remove a compute resource

Removal starts a workflow that uninstalls the Virtualization Mode agent, removes its certificates and deployment files, and unregisters the resource.

1. In the resource pane, select the **ellipsis (...)** next to the resource.

1. Select **Remove resource** for a standalone host or **Remove cluster** for a cluster.

1. Select **Remove** to confirm.

1. Monitor the removal from **Workflow status**.

### Remove a resource group

You must empty a resource group before you can delete it.

Remove all resources associated with the resource group from every Virtualization Mode view.

1. Remove every resource from the resource group.

1. Select the **ellipsis (...)** next to the resource group, and then select **Delete resource group**.

1. Select **Delete resource group** to confirm.

1. Verify that the notification pane contains the deletion notification.

## Manage virtual machines after adding compute resources

> [!div class="nextstepaction"]
> [Manage virtual machines in Windows Admin Center Virtualization Mode](manage-virtualization-mode-virtual-machines.md)
