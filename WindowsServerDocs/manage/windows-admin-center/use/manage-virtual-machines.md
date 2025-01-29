---
title: Manage Virtual Machines with Windows Admin Center
description: Lean how to manage Hyper-V hosts and virtual machines by using Windows Admin Center.
ms.topic: article
author: robinharwood
ms.author: roharwoo
ms.date: 01/28/2022
---

# Manage virtual machines by using Windows Admin Center

The Virtual Machines tool in Windows Admin Center is available in [server](manage-servers.md), [failover cluster](manage-failover-clusters.md), or [hyper-converged cluster](manage-hyper-converged.md) connections if the Hyper-V role is enabled on the server or cluster. You can use the Virtual Machines tool to manage Hyper-V hosts running Windows Server 2012 or later, either installed with Desktop Experience or installed as Server Core. Hyper-V Server 2012, 2016, 2019, and 2022 are also supported.

Highlights of the Virtual Machines tool in Windows Admin Center include:

- **High-level Hyper-V host resource monitoring**. View overall CPU and memory usage, I/O performance metrics, virtual machine (VM) health alerts and events for the Hyper-V host server or entire cluster in a single dashboard.
- **Unified experience bringing Hyper-V Manager and Failover Cluster Manager capabilities together**. View all the virtual machines across a cluster and drill down into a single virtual machine for advanced management and troubleshooting.
- **Simplified, yet powerful workflows for virtual machine management**. Use UI experiences that are tailored to IT administration scenarios to create, manage, and replicate virtual machines.

The following sections describe some of the Hyper-V tasks that you can do in Windows Admin Center.

## Monitor Hyper-V host resources and performance

![Screenshot of the Summary tab on the page for virtual machines in Windows Admin Center.](../media/manage-virtual-machines/virtual-machines-summary.png)

1. On the left pane, select **Virtual Machines**.

2. Use the **Summary** tab to get a holistic view of Hyper-V host resources and performance for the current server or the entire cluster. The information includes:

    - The number of VMs grouped by state: **Running**, **Off**, **Paused**, and **Saved**.
    - Recent health alerts or Hyper-V event log events. Alerts are available only for hyper-converged clusters running Windows Server 2016 or later.
    - CPU and memory usage with a breakdown of hosts versus guests.
    - VMs that consume the most CPU and memory resources.
    - Line charts for input/output per second (IOPS) and I/O throughput, for both live and historical data.

      Line charts for storage performance are available only for hyper-converged clusters running Windows Server 2016 or later. Historical data is available only for hyper-converged clusters running Windows Server 2019.

## View virtual machine inventory

![Screenshot of the Inventory tab on the page for virtual machines in Windows Admin Center.](../media/manage-virtual-machines/virtual-machines-inventory.png)

1. On the left pane, select **Virtual Machines**.

2. Select the **Inventory** tab. This tab lists the virtual machines available on the current server or the entire cluster, and it provides commands to manage individual virtual machines. You can:

    - View a list of the virtual machines running on the current server or cluster.
    - View a virtual machine's state and host server if you're viewing virtual machines for a cluster. Also vew CPU and memory usage from the host perspective, including memory pressure, memory demand, and assigned memory
    - View a virtual machine's uptime, heartbeat status, and protection status using by Azure Site Recovery.
    - [Create a new virtual machine](#create-a-new-virtual-machine).
    - Delete, start, turn off, shut down, pause, resume, reset, or rename a virtual machine. Also save the virtual machine, delete a saved state, or create a checkpoint.
    - [Change settings for a virtual machine](#change-virtual-machine-settings).
    - Connect to a virtual machine console by using Virtual Machine Connection (VMConnect) via the Hyper-V host.
    - [Replicate a virtual machine by using Azure Site Recovery](#protect-virtual-machines-with-azure-site-recovery).
    - For operations that can be run on multiple VMs, such as Start, Shut down, Save, Pause, Delete, and Reset, you can select multiple VMs and run the operation on all of them at once.

> [!NOTE]
> If you're connected to a cluster, the Virtual Machine tool displays only clustered virtual machines.

## Create a new virtual machine

![Screenshot that shows the pane for creating a new virtual machine.](../media/manage-virtual-machines/new-vm.png)

1. On the left pane, select **Virtual Machines**.

2. Select the **Inventory** tab.

3. Select **Add** > **New**.

4. Enter the virtual machine name, and choose between generation 1 and generation 2 virtual machines.

5. If you're creating a virtual machine on a cluster, you can choose a host for the virtual machine. If you're running Windows Server 2016 or later, the tool provides a host recommendation for you.

6. Choose a path for the virtual machine files. Choose a volume from the dropdown list, or select **Browse** to choose a folder. The virtual machine configuration files and the virtual hard disk file will be saved in a single folder under the `\Hyper-V\\[virtual machine name]` path of the selected volume or path.

   > [!TIP]
   > You can browse to any available Server Message Block (SMB) share on the network by entering the path in the **Folder name** field as `\\server\share`. Using a network share for VM storage requires [CredSSP](../understand/faq.yml#does-windows-admin-center-use-credssp-).

7. Choose the number of virtual processors and whether you want nested virtualization enabled. Configure memory settings, network adapters, and virtual hard disks. Choose whether you want to install an operating system from an .iso image file or from the network.

8. Select **Create**.

9. After the virtual machine is created and appears in the list of virtual machines, start it.

10. Connect to the virtual machine's console via VMConnect to install the operating system. Select the virtual machine from the list, and then select **Connect** > **Download RDP file** to download the RDP file. Open the RDP file in the Remote Desktop Connection app. Because you're connecting to the virtual machine's console, you need to enter the Hyper-V host's admin credentials.

## Change virtual machine settings

![Screenshot that shows the pane for changing virtual machine settings.](../media/manage-virtual-machines/vm-settings.png)

1. On the left pane, select **Virtual Machines**.

2. Select the **Inventory** tab.

3. Choose a virtual machine from the list, and then select **Settings**.

4. For each of the **General**, **Memory**, **Processors**, **Disks**, **Networks**, **Boot order**, and **Checkpoints** tabs, configure the necessary settings, and then select **Save** to save the current tab's settings.

  The available settings vary, depending on the virtual machine's generation. Also, some settings can't be changed for running virtual machines. For those settings, you need to stop the virtual machine first.

## Live migrate a virtual machine to another cluster node

If you're connected to a cluster, you can live migrate a virtual machine to another cluster node.

1. Go to a failover cluster or hyper-converged cluster connection. On the left pane, select **Virtual Machines**.

2. Select the **Inventory** tab.

3. Choose a virtual machine from the list, and then select **Manage** > **Move**.

4. Choose a server from the list of available cluster nodes, and then select **Move**.

5. Notifications for the move progress appear in the upper-right corner of Windows Admin Center. If the move is successful, the host server name changes in the virtual machine list.

## Advanced management and troubleshooting for a single virtual machine

![Screenshot of the pane that shows details about a single virtual machine.](../media/manage-virtual-machines/vm-details.png)

You can view detailed information and performance charts for a single virtual machine.

1. On the left pane, select **Virtual Machines**.

2. Select the **Inventory** tab.

3. Choose a virtual machine from the list. In the view that opens, you can:

    - View detailed information for the virtual machine.
    - View line charts for IOPS and I/O throughput, for both live and historical data. Historical data is available only for hyper-converged clusters running Windows Server 2019 or later.
    - View, create, apply, rename, and delete checkpoints.
    - View details for the virtual machine's virtual hard disk (.vhd) files, network adapters, and host server.
    - Delete, start, turn off, shut down, pause, resume, reset, or rename the virtual machine. Also save the virtual machine, delete a saved state, or create a checkpoint.
    - [Change settings for the virtual machine](#change-virtual-machine-settings).
    - Connect to the virtual machine console by using VMConnect via the Hyper-V host.
    - [Replicate the virtual machine by using Azure Site Recovery](#protect-virtual-machines-with-azure-site-recovery).

## Manage a virtual machine through the Hyper-V host (VMConnect)

![Screenshot of the pane that shows VM Connect in web browser.](../media/manage-virtual-machines/vm-connect.png)

1. On the left pane, select **Virtual Machines**.

2. Select the **Inventory** tab.

3. Choose a virtual machine from the list, and then select one of these options:

   - **Connect**. Interact with the guest VM through the Remote Desktop web console, integrated into Windows Admin Center.
   - **Download RDP file**. Download an RDP file that you can open with the Remote Desktop Connection application (mstsc.exe).

   Both options use VMConnect to connect to the guest VM through the Hyper-V host. They both require you to enter administrator credentials for the Hyper-V host server.

## Change Hyper-V host settings

![Screenshot of the pane for changing Hyper-V host settings.](../media/manage-virtual-machines/host-settings.png)

1. On a server, hyper-converged cluster, or failover cluster connection, select **Settings** at the bottom of the left pane.

2. On a Hyper-V host server or cluster, the **Hyper-V Host Settings** group has the following sections:

    - **General**: Change virtual hard disks, virtual machine file path, and hypervisor schedule type (if supported).
    - **Enhanced Session Mode**
    - **NUMA Spanning**
    - **Live Migration**
    - **Storage Migration**
3. If you make any Hyper-V host setting changes in a Hyper-converged Cluster or Failover Cluster connection, the change will be applied to all cluster nodes.

## View Hyper-V event logs

You can view Hyper-V event logs directly from the Virtual Machines tool.

1. On the left pane, select **Virtual Machines**.

2. At the top of the Virtual Machines tool, choose the **Summary** tab. In the top-right Events section, select **View all events**.

3. The Event Viewer tool will show the Hyper-V event channels in the left pane. Choose a channel to view the events in the right pane. If you're managing a failover cluster or hyper-converged cluster, the event logs will display events for all cluster nodes, displaying the host server in the Machine column.

## Protect virtual machines with Azure Site Recovery

You can use Windows Admin Center to configure Azure Site Recovery and replicate your on-premises virtual machines to Azure. [Learn more](../azure/azure-site-recovery.md).
