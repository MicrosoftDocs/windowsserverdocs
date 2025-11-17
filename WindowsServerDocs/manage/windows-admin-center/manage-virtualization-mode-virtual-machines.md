---
title: Manage virtual machines in Windows Admin Center Virtualization Mode (preview)
description: Learn how to create, locate, view, power on, and live migrate virtual machines across Hyper-V hosts in Windows Admin Center Virtualization Mode.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/17/2025
ai-usage: ai-assisted
#customer intent: As a virtualization operator, I want to create, locate, and manage virtual machines (including power changes and live migration) within Virtualization Mode, so that I can efficiently administer distributed Hyper-V resources at scale.
---

# Manage virtual machines in Windows Admin Center Virtualization Mode

> [!IMPORTANT]
> Windows Admin Center Virtualization Mode is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article shows you how to perform foundational virtual machine (VM) lifecycle tasks in Windows Admin Center Virtualization Mode. For example, you can create single or multihost VMs, locate VMs with global search, view VM details and state, start (power on) a VM, and live migrate a VM between standalone Hyper-V hosts.

Virtualization Mode focuses on virtualization infrastructure and presents resources through a navigation hierarchy. Before managing VMs, ensure you install Virtualization Mode and add at least one Hyper-V host as a Compute resource in a Resource Group. For more information about Windows Admin Center Virtualization Mode concepts, see [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md).

## Prerequisites

Before you can add resources in Windows Admin Center Virtualization Mode, ensure the following prerequisites are met:

- At least one Resource Group exists and contains one or more Hyper-V hosts added with the **Compute** profile. For more information about adding resources, see [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

- You're accessing the Virtualization Mode gateway site using an account that has the _Gateway Administrator_ role or equivalent permissions and have local Administrator rights on each Hyper-V host.

- To create a virtual machine, use any guest operating system that your Hyper-V host supports. For more information about the supported guest operating systems, see [Supported Windows guest operating systems for Hyper-V](../../virtualization/hyper-v/Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows.md) and [Supported Linux and FreeBSD virtual machines](../../virtualization/hyper-v/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).

## Create virtual machines on one or multiple hosts

You can create a VM on a single host or a cluster. To create a VM, follow these steps:

1. In the resource pane, expand the resource group and select the target Hyper-V host or cluster.

1. Select **Virtual Machines** from the tools pane for the host or cluster.

1. To create a VM, select the **Add** button at the top of the Virtual Machines tool pane, then choose **New**.

1. For the **New virtual machine** panel, complete the following information:

   | Setting | Guidance |
   |---------|----------|
   | Name | Enter a VM name following organizational naming conventions. |
   | Generation | Select Generation 1 or Generation 2. |
   | Host | For clustered VMs, select the target host from the Host dropdown. |
   | Path | Choose the storage location for VM files from the populated dropdown. |
   | Virtual processors | Specify number of virtual processors. |
   | Enable nested virtualization | Select this option if the VM runs Hyper-V or other hypervisors. |
   | Processor compatibility | Select this option to enable live migration across different CPU versions. |
   | Startup memory (MB) | Specify the startup memory in MB. |
   | Use Dynamic Memory | Select this option to enable dynamic memory allocation. |
   | Virtual switch | Select the virtual switch for network connectivity. |

1. To add a virtual hard disk and boot image, select **Add** under the Storage section, then complete the following information:

      | Setting | Guidance |
      |---------|----------|
      | New disk | Choose to create a new virtual hard disk or use an existing one. Specify size and location as needed. |
      | Operating system | Select from installing an operating system later, or specify an ISO image. The ISO image must be located on your Hyper-V host. |

1. Select **Create** to begin creating the VM.

## View virtual machine details and state

Virtualization Mode supports up to 1,000 hosts and 25,000 virtual machines per instance. Search in Virtualization Mode lets you locate virtualization resources across the resource hierarchy using the following criteria:

- Search queries resolve against virtualization resources, such as hosts, resource groups, and VMs.
- Use plain-text search with wildcards. For example, entering `web-0*` returns `web-01` and `web-02` if they exist.
- Only resources in the resource hierarchy are searchable. Deleted resources, attributes, or attached objects, such as virtual hard disks, aren't searchable.

When you select a VM, you see its overview page with identity, current power state, and available actions. You can perform connection, power, and management actions from this page. To locate a VM by using search:

1. From the search bar at the top of the Virtualization Mode gateway site, type the leading portion of the VM name (for example, `web-0`).

1. Select the VM from results to go directly to the VM overview.

1. Review the VM overview page for details:

   - Confirm displayed name and current power state (for example, Off).
   - Review available actions (start, migrate) presented for the VM.

From the VM overview, you can perform common connection, power, and management actions. The following image is an example of the VM overview page. You can also manage the VM settings such as memory or processors, as shown in the following screenshot:

:::image type="content" source="media/manage-virtualization-mode-virtual-machines/change-virtual-machine-settings.png" alt-text="Screenshot of VM overview page showing identity, power state, and editable settings for memory, processors, and network switch.":::

## Start and connect to a virtual machine

To start and connect to a VM, follow these steps:

1. From the resource pane, select the VM to go to the VM overview page.

1. From the VM overview, select **Power**, then choose **Start**.

1. When the VM is running, select **Connect**, then choose **Connect**.

1. If this is your first time connecting to a VM on this host, you're prompted to enable Remote Desktop connections in the host server settings. Select **Go to settings**.

   :::image type="content" source="media/manage-virtualization-mode-virtual-machines/connect-settings.png" alt-text="Screenshot of Server settings panel with Remote Desktop section highlighting Allow remote connections and Save button enabled.":::

1. From the **Server settings** page, under **Remote Desktop**, select **Allow remote connections to this server**, keep the default option for Network Level Authentication, then select **Save**.

1. Go back to the VM overview page, and repeat the **Connect** action to open a Remote Desktop session to the VM.

## Live migrate a virtual machine

Live migration moves a running VM from one standalone Hyper-V host to another without planned downtime. To live migrate a VM:

1. Select the running VM on the source host.

1. From the VM overview, select **Manage**, then choose **Move**.

   :::image type="content" source="media/manage-virtualization-mode-virtual-machines/move-virtual-machine.png" alt-text="Screenshot of VM overview Manage menu expanded with Move option selected for initiating a live migration operation.":::

1. For the **Move a virtual machine** panel, complete one of the following steps:

   1. Select the **Destination type** as **Failover Cluster**. Select the **Cluster** if necessary, then **Member server** as the destination host.

   Or

   1. Select the **Destination type** as **Server**, then select the **Server** as the destination host.

   :::image type="content" source="media/manage-virtualization-mode-virtual-machines/move-virtual-machine-destination.png" alt-text="Screenshot of Move virtual machine panel with Destination type selection for Failover Cluster or Server and host dropdown fields.":::

1. Verify the VM moves to the destination host in the resources pane.
