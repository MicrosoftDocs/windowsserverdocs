---
title: Use live migration with workgroup clusters in Windows Server
description: This article provides an overview of live migration functionality with workgroup clusters in Windows Server 2025.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 07/24/2024
---

# Use live migration with workgroup clusters

This article describes how to move a virtual machine by doing a live migration between hosts using workgroup clusters. Workgroup clusters are a type of Failover Cluster that doesn't use an on-premises domain controller or Active Directory forest. Instead, workgroup clusters are joined by workgroup. Workgroup clusters were introduced in Windows Server 2016. However, live migration for workgroup clusters wasn't supported until now, in Windows Server 2025. Benefit from the flexibility of live migration combined with the high availability of workgroup clusters.

Follow the steps in this article to perform your own live migration.

## Prerequisites

The following prerequisites must be met in order to do a live migration of hosts using workgroup clusters:

- A workgroup cluster with two or more nodes is up and running. To learn more about creating a
  workgroup cluster, see [Create a workgroup cluster](/windows-server/failover-clustering/create-workgroup-cluster).
- A local user account exists on each server node with an identical username and password.

## Consider options for authentication and performance

When setting up live migrations for workgroup clusters, it's important to consider how authentication and performance.

- **Authentication**: Local accounts with an identical username and password on each node are used to create and configure the workgroup cluster. The cluster uses self-signing PKU2U certificates to authenticate and be able to move a virtual machine from one host node to another host node without Kerberos. The local accounts on each node are the only way to successfully authenticate workgroup clusters and allow for live migration between source and destination servers.

- **Performance**: Configuring performance options can reduce network and CPU usage. Different options like simultaneous migrations can also make live migrations go faster. Consider your requirements and your infrastructure, and test different configurations to help you decide.


## Do a live migration with Hyper-V workgroup clusters

In the next sections, you'll complete the following steps:

- **Install the Hyper-V role and Hyper-V management tools.** Each virtual machine needs Hyper-V installed in order to be able to connect to other hosts and do a live migration.
- **Create a new virtual machine and add it to the workgroup cluster.** Add in a virtual machine role to facilitate the live migration.
- **Set up source and destination servers.** Set up each server node to enable live migrations.
- **Move a running virtual machine with live migration.** Complete a live migration by moving a running virtual machine between Hyper-V hosts without any noticeable downtime.

### Step 1: Install the Hyper-V role

The Hyper-V role must be installed on the source and destination servers and set up for live migrations. Install this role before continuing.

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

1. Repeat these steps on every server that is part of your workgroup cluster.

---

>[!NOTE]
>If you're unable to install the Hyper-V role, you might need to enable Nested Virtualization. See how to [enable Nested Virtualization](/virtualization/hyper-v-on-windows/user-guide/enable-nested-virtualization) to allow Hyper-V to run inside of a Hyper-V virtual machine.

### Step 2: Create a new virtual machine and add it to the workgroup cluster

Add a new Hyper-V virtual machine as a role to your workgroup cluster in order to do a live migration between hosts.

#### [PowerShell](#tab/powershell)

1. Connect to one of your server nodes.

1. Open a PowerShell session as an Administrator.

1. Run the following [New-VM](/powershell/module/hyper-v/new-vm) command to create a new virtual machine that has 10GB of memory and uses an existing VHDX image on the server node. Change the parameters and values as needed to customize your setup. 
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

1. Complete the steps in the **New Virtual Machine Wizard** to create a new virtual machine, using the appropriate settings for your setup.

1. Add in the virtual machine as a **Virtual Machine** role in the workgroup cluster using the Failover Cluster Manager.

---

### Step 3: Set up the source and destination computers for live migration

In this step, set up your source and host destination virtual machines to enable live migrations. Here, you can also specify live migration settings, such as how many live and storage migrations to allow at the same time.

#### [PowerShell](#tab/powershell)

1. Connect to one of your server nodes.

1. Open a PowerShell session as an Administrator.

1. First, use the [Enable-VMMigration](/powershell/module/hyper-v/enable-vmmigration) cmdlet to configure live migration on the Hyper-V virtual machine host.
    ```powershell
    Enable-VMMigration
    ```

1. Use the [Set-VMHost](/powershell/module/hyper-v/set-vmhost) cmdlet to configure the local Hyper-V host. The following command configures the virtual machine to allow 10 simultaneous live migrations and storage migrations. Change these values to the number of simultaneous live and storage migrations your setup allows. You might need to test different configurations to help you decide.
    ```powershell
    Set-VMHost -MaximumVirtualMachineMigrations 10 -MaximumStorageMigrations 10
    ```

    Set-VMHost also lets you specify a performance option, and other host settings. Consider using a parameter like `-VMMigrationPerformance` to choose more settings for your virtual machine.

1. Repeat the steps for the other server node.

#### [Server Manager](#tab/server-manager)

1. From Server Manager, open Hyper-V Manager.

1. Connect to whichever server you want to set up.

1. In the **Actions** pane, select **Hyper-V Settings...**, then **Live Migrations**.

1. In the **Live Migrations** pane, confirm that **Enable incoming and outgoing live migrations** is selected.

1. Under **Simultaneous live migrations**, specify a different number if you don't want to use the default of 1.

1. Under **Incoming live migrations**, if you want to use specific network connections to accept live migration traffic, select **Add** to type the IP address information. Otherwise, select **Use any available network for live migration**. Select **OK**.

1. Review the details. Apply any changes and select **OK**.

1. In the **Actions** pane, select **Hyper-V Settings...**, and then **Storage Migrations**.

1. Under **Simultaneous storage migrations**, specify the number of simultaneous storage migrations you'd like to enable, if you don't want to use the default of 2.

1. Apply any changes and select **OK**.

1. Repeat the steps to specify the number of live and storage migrations for the other server node.

---

### Step 4: Move a running virtual machine with live migration

Finally, do a live migration to move a running virtual machine.
 
1. Connect to the current owner node in your workgroup cluster.

1. Open Failover Cluster Manager.

1. In the **Roles** section, select the virtual machine role, and right-click.

1. Select **Move**, then **Live Migration**, and then **Best Possible Node**.

1. In the **Information** column, see a status appear with the message **Live Migrating, X% completed**.

1. Once complete, confirm that the Owner Node column updates with the other node in your workgroup cluster.

## Next steps

After completing a live migration, it's important to confirm that the migration works, and all virtual machines migrated were migrated successfully. If you notice any issues during or after a migration, it might be necessary to revisit the simultaneous migrations allowed or configure live migration performance options.

To learn more about Live Migration performance options, see
[Virtual Machine Live Migration Overview](live-migration-overview.md).

You can also read more about live migration performance in [Hyper-V Network I/O Performance](/windows-server/administration/performance-tuning/role/hyper-v-server/network-io-performance).
