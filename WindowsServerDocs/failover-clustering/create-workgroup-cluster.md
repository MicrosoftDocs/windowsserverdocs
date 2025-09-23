---
title: Create a workgroup cluster in Windows Server
description: Learn how-to create Failover Clusters without Active Directory using the Failover Cluster Manager or PowerShell.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 01/29/2024
---
# Create a workgroup cluster

In this article, learn about and create a workgroup cluster. First, understand what workgroup clusters are and how they differ from traditional failover clusters. Then, create a workgroup cluster either using the Failover Cluster Manager or Windows PowerShell.

## Understand workgroup clusters

A workgroup cluster is a specific type of failover cluster configuration introduced in Windows Server 2016. With workgroup clusters, two or more nodes are joined as member servers. They don't use an on-premises domain controller or Active Directory forest. Workgroup clusters aren't domain joined, and instead are workgroup joined. They still require use of a Domain Name System (DNS).

Typically, failover clusters are part of an Active Directory Domain Services domain to provide identity services and management at scale. However, in some scenarios you might want to run a failover cluster without Active Directory to reduce the cost of hardware, maintenance, and other operational overheads. 

Workgroup clusters offer a centralized identity and the same high security, to keep your applications highly available. And by not using Active Directory, customers can still achieve the high availability at a lower cost.

## Prerequisites 

The following prerequisites must be met for your workgroup cluster to meet the criteria for an officially supported deployment:

- All servers to be used as workgroup cluster nodes are running the same version of Windows Server.
- All workgroup cluster nodes must be in a workgroup, and can't be joined to an Active Directory domain. Any nodes that were previously in an Active Directory domain must not only be moved to a workgroup, but must also be renamed to remove any Active Directory caching.
- Your cluster must have one of the following storage technologies configured and available to all cluster nodes. To learn more about Failover Clustering storage requirements, see [Failover clustering storage requirements](/windows-server/failover-clustering/clustering-requirements#storage).
  - Storage Spaces Direct (S2D). If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).
  - SAN attached storage.
  - NAS using SMB 3.0 or later.
- Review how [Quorum should be configured for a cluster](/windows-server/failover-clustering/manage-cluster-quorum) to determine the quorum type most suitable for your requirements. Either a Cloud Witness, Disk Witness, or USB Witness can be used.

## Cluster workloads

Workgroup clusters support several workloads. Workgroup clusters are recommended and supported for:

- **Hyper-V VMs.** Supported cluster workload starting in Windows Server 2025.
- **SQL Server Availability Groups.** SQL Server is a supported workload for Windows Server 2016 through Windows Server 2025. To deploy a SQL Server workload, follow the instructions to create a [domain independent availability group](/sql/database-engine/availability-groups/windows/domain-independent-availability-groups#create-a-domain-independent-availability-group-1).

Workgroup clusters aren't supported for:

- **File Servers.** Not supported because of authentication issues.
- **SQL Server FCI.** Not supported.

## Create a two-node workgroup cluster

In the following sections, you'll create two-node workgroup cluster with Storage Spaces Direct storage that is capable of hosting Hyper-V virtual machines. The process is composed of the following steps:

1. **Prepare your servers**. Each server must have identical users accounts, the Windows Remote Management (WinRM) Trust Host list populated, and a common primary DNS suffix.

1. **Install the Failover Clustering feature.** Each server must have the Failover Clustering feature installed.

1. **Validate your configuration.** Run validation tests to confirm each server node can support a workgroup cluster.

1. **Create the workgroup cluster.** Walk through the steps to create a workgroup cluster with the preconfigured server nodes.

### Step 1: Prepare your servers

To get started, you need to configure your servers. This includes creating an identical user account in each server node, adding the servers as trusted hosts, and ensuring that each server has a common primary DNS suffix. Follow these steps on each node of the cluster.

#### Create a consistent admin account on each node

A consistent administrator user account must be created on each node. The username and password of these accounts must be the same on all the nodes and the account must also be added to the local Administrators group.

##### [Desktop](#tab/desktop)

1. Create a new user account on each node with the same username and password.

1. If the nonbuiltin administrator account isn't used, then you need to set the LocalAccountTokenFilterPolicy in the registry. The following set of steps describes how to set the LocalAccountTokenFilterPolicy.

    > [!IMPORTANT]
    > This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type _regedit_, and then press ENTER.

1. Locate and then click the following registry subkey:
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`

1. If the **`LocalAccountTokenFilterPolicy`** registry entry doesn't exist, follow these steps:
    1. On the **Edit** menu, point to **New**, and then select **DWORD Value**.
    1. Type _LocalAccountTokenFilterPolicy_, and then press ENTER.

1. Right-click **LocalAccountTokenFilterPolicy**, and then select **Modify**.

1. In the **Value data** box, type _1_, and then select **OK**.

1. Exit Registry Editor.

##### [PowerShell](#tab/powershell)

1. Create a new user account on each node with the same username and password.

1. If the nonbuiltin administrator account isn't used, then you need to set the LocalAccountTokenFilterPolicy in the registry. The policy can be done in PowerShell with the following command:
    ```PowerShell
    New-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System –Name LocalAccountTokenFilterPolicy -Value 1​
    ```

---

#### Ensure nodes are trusted hosts for remote management

Each server node must be added to Windows Remote Management (WinRM) as a trusted host. To do that, modify the `TrustedHosts` file by adding an entry for each server that will connect to the local machine.

##### [Desktop](#tab/desktop)

1. From the start menu, enter: **gpedit.msc**. The Local Group Policy Editor dialog opens.

1. Navigate to **Local Computer Policy** > **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Windows Remote Management (WinRM)** > **WinRM Client** > **Trusted Hosts**.

1. In the Trusted Hosts dialog, select the **Enabled** radio button and then enter a comma separated list of trusted hosts by hostname.

1. Select **Apply** and then **OK**.

1. Complete this process on each server node.

##### [PowerShell](#tab/powershell)

1. Add each server node as a trusted host. To do that, modify the `TrustedHosts` file by adding an entry for each server that will connect to the local machine. There are many ways to add trusted hosts, including by hostname, by domain name, or by IP address. The following PowerShell command allows each hostname specified to access the local machine:
    ```PowerShell
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value "server1,server2"
    ```

1. Complete this process on each server node.

---


#### Set primary DNS Suffix

Set a primary DNS suffix on each server node with the following steps.

1. In the Search bar, enter **system properties** and select **View advanced system settings**. This opens the **System Properties** dialog. In the Computer Name tab, select the **Change...** button.

1. In the Computer Name/Domain Changes dialog, confirm that the Member of option selected is **Workgroup**. Then select the **More...** button.

1. In the DNS Suffix and NetBIOS Computer Name dialog, enter a **Primary DNS suffix of this computer** of your choice. The select **OK** to close the dialog window.

1. Select **OK** again to close the Computer Name/Domain Changes dialog, and then you're prompted to restart your computer to apply changes. Select **OK** to restart and follow the prompts to restart your computer now.


### Step 2: Install the Failover Clustering feature

[Install the Failover Clustering feature](/windows-server/failover-clustering/create-failover-cluster#install-the-failover-clustering-feature) if you haven't already. 

#### [Desktop](#tab/desktop)

The following steps show how to install the Failover Clustering feature in the Server Manager.

1. Start Server Manager.

1. On the **Manage** menu, select **Add Roles and Features**.

1. On the **Before you begin** page, select **Next**.

1. On the **Select installation type** page, select **Role-based or feature-based installation** and then select **Next**.

1. On the **Select destination server** page, select the server where you want to install the feature and then select **Next**.

1. On the **Select server roles** page, select **Next**.

1. On the **Select features** page, select the **Failover Clustering** check box.

1. To install the Failover Cluster management tools, select **Add Features** and then select **Next**.

1. On the **Confirm installation selections** page, select **Install**. A server restart isn't required for the Failover Clustering feature.

1. When the installation completes, select **Close**.

1. Repeat this procedure on every server that you want to add as a failover cluster node.

#### [PowerShell](#tab/powershell)

The following steps show how to install the Failover Clustering feature in PowerShell.

1. Open an administrative PowerShell session by right-clicking the **Start** button and  selecting **Windows PowerShell (Admin)**.

1. Run the PowerShell command:
    ```PowerShell
    Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
    ```

1. Once the installation process is done, verify installation was successful by running these commands:
   ```PowerShell
   Get-WindowsFeature -Name Failover-Clustering
   ```

1. Repeat this procedure on every server that you want to add as a failover cluster node.

---

### Step 3: Create the workgroup cluster

Now you're ready to create a workgroup cluster with the server nodes you prepared. You may use either the [Failover Cluster Manager](/windows-server/failover-clustering/create-failover-cluster#validate-the-configuration) or [Microsoft PowerShell](/windows-server/failover-clustering/create-failover-cluster#create-a-failover-cluster-by-using-windows-powershell).

#### [Desktop](#tab/desktop)

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft supports a cluster solution only if the complete configuration passes all validation tests and if all hardware is certified for the version of Windows Server that the cluster nodes are running.

> [!NOTE]
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests don't run.

#### Run cluster validation tests

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. To do this on a server, start Server Manager and then on the **Tools** menu, select **Failover Cluster Manager**.

1. In the **Failover Cluster Manager** pane under **Management**, select **Validate Configuration**.

1. On the **Before You Begin** page, select **Next**.

1. On the **Select Servers or a Cluster** page in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format `server1.contoso.com, server2.contoso.com`. When you finish, select **Next**.

1. On the **Testing Options** page, select **Run all tests (recommended)** and then select **Next**.

1. On the **Confirmation** page, select **Next**. The Validating page displays the status of the running tests.

1. On the **Summary** page, do either of the following:
    - If the results indicate that the tests completed successfully and the configuration is suited for clustering and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected and then select **Finish**. Then, continue to step 4 of the [Create the workgroup cluster](#create-the-workgroup-cluster) procedure.
    - If the results indicate that there were warnings or failures, select **View Report** to view the details and determine which issues must be corrected. Realize that a warning for a particular validation test indicates that this aspect of the failover cluster can be supported but might not meet the recommended best practices.

#### Create the workgroup cluster

After validation passes, you may now create the workgroup cluster.

> [!IMPORTANT]
> Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, complete the Validate a Configuration Wizard as described in [Run cluster validation tests](#run-cluster-validation-tests).

To create a new cluster, complete the following steps:

1. Start Server Manager.

1. On the **Tools** menu, select **Failover Cluster Manager**.

1. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**. The Create Cluster Wizard opens.

1. On the **Before You Begin** page, select **Next**.

1. If the **Select Servers** page appears, in the **Enter name** box enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you're finished, select **Next**.
The nodes that were validated are automatically added to the Create Cluster Wizard so that you don't have to enter them again.

1. If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. To run the validation tests, complete the Validate a Configuration Wizard as described in [Run cluster validation tests](#run-cluster-validation-tests).

1. On the **Access Point for Administering the Cluster** page, enter the **Cluster Name** that you want to use to administer the cluster.
   1. If the server doesn't have a network adapter that is configured to use DHCP, you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. In the **Address** field next to a selected network, enter the IP address that you want to assign to the cluster. This IP address (or addresses) is associated with the cluster name in Domain Name System (DNS).
   1. When you finish, select **Next**.

1. On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to configure storage later.

1. Select **Next** to create the failover cluster.

1. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or select **View Report** to view the full report. Select **Finish**.

1. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name and then select items under **Nodes**, **Storage**, or **Networks** to view the associated resources.

After the cluster is created, you can do things such as verify cluster [quorum configuration](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering), [create clustered roles](/windows-server/failover-clustering/create-failover-cluster#create-clustered-roles), and optionally, create [Cluster Shared Volumes (CSV)](failover-cluster-csvs.md).


#### [PowerShell](#tab/powershell)

If you prefer to create a workgroup cluster using PowerShell, follow these steps.

1. Validate the configuration before creating the workgroup cluster using the following command:
    ```PowerShell
    Test-Cluster -Node server1, server2
    ```

1. After validation passes, create the workgroup cluster using the following command:
    ```PowerShell
    New-Cluster –Name MyCluster -Node server1, server2 -AdministrativeAccessPoint DNS
    ```

1. After the cluster is successfully created, you can do things such as verify cluster [quorum configuration](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering), [create clustered roles](/windows-server/failover-clustering/create-failover-cluster#create-clustered-roles), and optionally, create [Cluster Shared Volumes (CSV)](failover-cluster-csvs.md).

---

## Related content

- [Create a failover cluster](./create-failover-cluster.md)


