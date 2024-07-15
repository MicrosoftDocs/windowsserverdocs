---
title: Use live migration with workgroup clusters
description: This article provices an overview of live migration functionality with workgroup clusters in Windows Server 2025.
ms.topic: article
ms.author: mosagie
author: meaghanlewis
ms.date: 04/17/2024
---

# Use live migration with workgroup clusters

>Applies to: Windows Server 2025

This article describes how to move a virtual machine by doing a live migration between hosts using workgroup clusters. Workgroup clusters are a type of Failover Cluster that don't use an on-premises domain controller or Active Directory forest. Instead, workgroup clusters are joined by workgroup. Workgroup clusters were introduced in Windows Server 2016. However, live migration for workgroup clusters wasn't supported until now, in Windows Server 2025. Benefit from the flexibility of live migration combined with the high availability of workgroup clusters.

Follow the steps in this article to perform your own live migration.

## Prerequisites

The following prerequisites must be met in order to live migrate hosts using workgroup clusters:

- A workgroup cluster with two or more nodes is up and running.
- A local user account exists on each server node with an identical username and password.

## Do a live migration with Hyper-V workgroup clusters

In the next sections, you'll do the following:

- **Install the Hyper-V role and Hyper-V management tools.** Each virtual machine needs Hyper-V installed in order to be able to connect to other hosts and do a live migration.
- **Create a new virtual machine and add it to the workgroup cluster.** Add in a virtual machine role to facilitate the live migration.
- **Set up source and destination servers.** Set up each server node to enable live migrations.
- **Move a running virtual machine with live migration.** Complete a live migration by moving a running virtual machine between Hyper-V hosts without any noticeable downtime.

### Step 1: Install the Hyper-V role

The Hyper-V role must be installed on the source and destination servers and set up for live migrations. If you haven't installed this role, do it now before continuing.

#### 1.1 Enable Nested Virtualization on the source host.

Nested Virtualization allows you to run Hyper-V inside of a Hyper-V virtual machine. [Nested Virtualization must first be enabled](/virtualization/hyper-v-on-windows/user-guide/enable-nested-virtualization) before Hyper-V can be installed on a virtual machine.

To enable Nested Virtualization:

1. From the Hyper-V manager on the host machine, turn off the virtual machine you wish to enable nested virtualization for.

1. With the virtual machine turned off, open a PowerShell session as an administrator and run the following command.
    ```powershell
    Set-VMProcessor -VMName <VMName> -ExposeVirtualizationExtensions $true
    ```

1. Confirm that the command was successful and repeat the same process for the other virtual machines that are part of the workgroup cluster.

#### 1.2 Install the Hyper-V role

Hyper-V provides the services that you can use to create and manage virtual machines. [Hyper-V may be installed in many ways](/windows-server/virtualization/hyper-v/get-started/install-the-hyper-v-role-on-windows-server). This section describes how to install the role using either PowerShell or the Server Manager.

##### [PowerShell](#tab/powershell)

1. Open a PowerShell session as an Administrator.

1. Use the [Install-WindowsFeature cmdlet](/powershell/module/servermanager/install-windowsfeature) to install the Hyper-V role with the following command:
    ```powershell
    Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
    ```

1. Wait for the role to be installed, and then restart your virtual machine.

1. Repeat the installation for the other virtual machines in the cluster.

##### [Server Manager](#tab/server-manager)

1. Open Server Manager.

1. On the **Manage** menu, select **Add Roles and Features**.

1. On the **Before you begin** page, select **Next**.

1. On the **Select installation type** page, select **Role-based or feature-based installation** and then select **Next**.

1. On the **Select destination server** page, select the server where you want to install the feature and then select **Next**.

1. On the **Select server roles** page, select **Hyper-V**. And then select **Next**.

1. On the **Select features** page, select **Next**, and then select **Next** again.

1. On the **Create Virtual Switches** page, **Virtual Machine Migration** page, and **Default Stores** page, select the options that suit your specific environment.

1. On the **Confirm installation selections** page, select **Install**.

1. When the installation completes, select **Close**.

1. Repeat this procedure on every server that is part of your workgroup cluster.

---

### Step 2: Create a new virtual machine and add it to the workgroup cluster

Add a new Hyper-V virtual machine as a role to your workgroup cluster in order to do a live migration between hosts.

#### [PowerShell](#tab/powershell)

1. Connect to one of your server nodes.

1. Open a PowerShell session as an Administrator.

1. Run the following command to create a new virtual machine using an existing VHDX on the server node.
    ```powershell
    New-VM -Name "<VM_NAME>" -MemoryStartupBytes 10GB -VHDPath <PATH_TO_VHDX_FILE>
    ```

1. Add in the virtual machine as a **Virtual Machine** role in the workgroup cluster enable automatic failover.
    ```powershell
    Add-ClusterVirtualMachineRole -VirtualMachine <VM_NAME>
    ```

#### [Server Manager](#tab/server-manager)

1. Connect to one of your server nodes.

1. Open up Server Manager.

1. Select Tools, and then Hyper-V Manager.

1. In the Hyper-V Manager, select **New**, then  **Virtual Machine...**.

1. Complete the steps in the **New Virtual Machine Wizard** to create a new virtual machine.

1. Add in the virtual machine as a **Virtual Machine** role in the workgroup cluster using the Failover Cluster Manager.

---

### Step 3: Set up the source and destination computers for live migration

In this step, set up your source and host destination virtual machines to enable live migrations.

#### [PowerShell](#tab/powershell)

1. Connect to one of your server nodes.

1. Open a PowerShell session as an Administrator.

1. First, use the [Enable-VMMigration](/powershell/module/hyper-v/enable-vmmigration) cmdlet to configure live migration on the virtual machine host.
    ```powershell
    Enable-VMMigration
    ```

1. Next, use the [Set-VMMigrationNetwork](/powershell/module/hyper-v/set-vmmigrationnetwork) cmdlet to allow incoming migration traffic on a specific network.
    ```powershell
    Set-VMMigrationNetwork <IP_ADDRESS>
    ```

1. Finally, use the [Set-VMHost](/powershell/module/hyper-v/set-vmhost) cmdlet to configure a Hyper-V host.
    ```powershell
    Set-VMHost -ComputerName <HOSTNAME>
    ```

1. Repeat the steps for the other server node.

#### [Server Manager](#tab/server-manager)

1. From Server Manager, open Hyper-V Manager.

1. Connect to whichever server you want to set up.

1. In the **Actions** pane, select **Hyper-V Settings...**, then **Live Migrations**.

1. In the **Live Migrations** pane, confirm that **Enable incoming and outgoing live migrations** is selected.

1. Under **Simultaneous live migrations**, specify a different number if you don't want to use the default of 1.

1. Under **Incoming live migrations**, if you want to use specific network connections to accept live migration traffic, select **Add** to type the IP address information. Otherwise, select **Use any available network for live migration**. Select **OK**.

1. Review the details. Select **OK**.

1. Repeat the steps in the Hyper-V Manager for the other server node.

---

### Step 4: Move a running virtual machine with live migration

Finally, do a live migration to move a running virtual machine.
 
1. Connect to the current owner node in your workgroup cluster.

1. Open Failover Cluster Manager.

1. In the **Roles** section, select the virtual machine role, and right-click.

1. Select **Move**, then **Live Migration**, and then **Best Possible Node**.

1. In the **Information** column, see a status appear with the message **Live Migrating, X% completed**.

1. Once complete, confirm that the Owner Node column updates with the other node in your workgroup cluster.
