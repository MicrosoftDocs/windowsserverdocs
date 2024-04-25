---
title: Create a workgroup cluster in Windows Server
description: Learn how-to create Failover Cluster without Active Directory using the Failover Cluster Manager or PowerShell.
manager: femila
ms.topic: how-to
ms.author: wscontent
author: meaghanlewis
ms.date: 04/09/2024
---
# Create a workgroup cluster

>Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In this article, learn about and create a workgroup cluster. First, understand what workgroup clusters are and how they differ from traditional failover clusters. Then, create a workgroup cluster either using the Failover Cluster Manager or Windows PowerShell.

## Understand workgroup clusters

A workgroup cluster is a specific type of failover cluster configuration. With workgroup clusters, two or more nodes are joined as member servers. They don't use an on-premises domain controller or Active Directory forest. Workgroup clusters aren't domain joined, and instead are workgroup joined. They still require use of a Domain Name System (DNS).

Typically, Failover Cluster are part of an Active Directory Domain Services domain to provide identity services and management at scale. However, in some scenarios you might want to run a Failover Cluster without Active Directory to reduce the cost of hardware, maintenance, and other operational overheads. 

Workgroup clusters offer a centralized identity and the same high security, to keep your applications highly available. And by not using Active Directory, customers can still achieve the high availability at a lower cost.

## Prerequisites 

The following prerequisites must be met for your workgroup cluster to meet the criteria for an officially supported deployment:

- All servers to be used as cluster nodes are running the same version of Windows Server. 
- Your cluster must have one of the following storage technologies configured and available to all cluster nodes. To learn more about Failover Clustering storage requirements, see [Failover clustering storage requirements](/windows-server/failover-clustering/clustering-requirements#storage).
  - Storage Spaces Direct (S2D). If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).
  - SAN attached storage.
  - NAS using SMB 3.0 or later.
  - Either Storage Spaces Direct (S2D), SAN, or NAS is required. If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).
  - To add clustered storage during cluster creation, make sure that all servers can access the storage. You can also add clustered storage after you create the cluster.
- Review [Quorum should be configured for a cluster](/windows-server/failover-clustering/manage-cluster-quorum) to determine the quorum type most suitable for your requirements. Either a Cloud Witness or Disk Witness can be used. A File Share Witness isn't currently supported.

## Cluster workloads

Workgroup clusters support several workload, workgroup clusters are recommended for:

- **Hyper-V VMs.** Supported cluster workload.
- **SQL Server Availability Groups.** SQL Server is a supported workload. To deploy a SQL Server workload, follow the instructions to create a [domain independent availability group](/sql/database-engine/availability-groups/windows/domain-independent-availability-groups#create-a-domain-independent-availability-group-1)

Workgroup clusters aren't recommended for:

- **File Servers.** Not supported because of authentication issues.
- **SQL Server FCI.** Not supported.

## Create a two-node workgroup cluster

In the following sections you create two-node workgroup cluster with Storage Spaces Direct storage that is capability of hosting Hyper-V virtual machines. The process is composed of the following steps:

1. Prepare you servers. Each server must have identical users accounts, the Windows Remote Management (WinRM) Trust Host list populated, and a common primary DNS suff.
1. Etc. etc.

### Step 1: Prepare your servers

To get started, you need to configure your servers. This includes creating an identical user account in each server node, adding the servers as trusted hosts, and ensuring that each server has a common primary DNS suffix. Follow these steps on each node of the cluster.

1. Create a consistent admin user account on each node. The username and password of these accounts must be the same on all the nodes and the account must also be added to the local Administrators group. If the non-builtin administrator account isn't used, then you need to set the LocalAccountTokenFilterPolicy in the registry. The policy can be done in PowerShell with the following command:
`New-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System –Name LocalAccountTokenFilterPolicy -Value 1​`
1. Add each server node as a trusted host. To do that, modify the `TrustedHosts` file by adding an entry for each server that will be allowed to connect to the local machine. There are many ways to add trusted hosts, including by hostname, by domain name, or by IP address. The following PowerShell command allows each hostname specified to access the local machine:
`Set-Item WSMan:\localhost\Client\TrustedHosts -Value "server1,server2"`
1. Set a primary DNS suffix on each server node. To do so, navigate to **System Properties** and in the Computer Name tab, select **Change...**. In the Computer Name/Domain Changes dialog, confirm that the Member of option selected is **Workgroup**. Then select **More...**. In the DNS Suffix and NetBIOS Computer Name dialog, enter a **Primary DNS suffix of this computer** of your choice. 

### Step 2: Install the Failover Clustering feature

[Install the Failover Clustering feature](/windows-server/failover-clustering/create-failover-cluster#install-the-failover-clustering-feature) if you haven't already. 

#### [Server Manager](#tab/server-manager)

The following steps show how to install this feature in the Server Manager.

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

### Step 3: Create the workgroup cluster

Now you're ready to create a workgroup cluster with the server nodes you prepared. You may use either the [Failover Cluster Manager](/windows-server/failover-clustering/create-failover-cluster#validate-the-configuration) or [Microsoft PowerShell](/windows-server/failover-clustering/create-failover-cluster#create-a-failover-cluster-by-using-windows-powershell).

#### Using Failover Cluster Manager 

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft supports a cluster solution only if the complete configuration passes all validation tests and if all hardware is certified for the version of Windows Server that the cluster nodes are running.

> [!NOTE]
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests do not run.

##### Run cluster validation tests

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. To do this on a server, start Server Manager and then on the **Tools** menu, select **Failover Cluster Manager**.
1. In the **Failover Cluster Manager** pane under **Management**, select **Validate Configuration**.
1. On the **Before You Begin** page, select **Next**.
1. On the **Select Servers or a Cluster** page in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format `server1.contoso.com, server2.contoso.com`. When you're finished, select **Next**.
1. On the **Testing Options** page, select **Run all tests (recommended)** and then select **Next**.
1. On the **Confirmation** page, select **Next**. The Validating page displays the status of the running tests.
1. On the **Summary** page, do either of the following:
    - If the results indicate that the tests completed successfully and the configuration is suited for clustering and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected and then select **Finish**. Then, continue to step 4 of the [Create the workgroup cluster](#create-the-workgroup-cluster) procedure.
    - If the results indicate that there were warnings or failures, select **View Report** to view the details and determine which issues must be corrected. Realize that a warning for a particular validation test indicates that this aspect of the failover cluster can be supported but might not meet the recommended best practices.

##### Create the workgroup cluster

After validation passes, you may now create the workgroup cluster.

> [!IMPORTANT]
> Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, complete the Validate a Configuration Wizard as described in [Run cluster validation tests](#run-cluster-validation-tests).

To create a new cluster, follow the steps below.

1. Start Server Manager.
1. On the **Tools** menu, select **Failover Cluster Manager**.
1. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**. The Create Cluster Wizard opens.
1. On the **Before You Begin** page, select **Next**.
1. If the **Select Servers** page appears, in the **Enter name** box enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you're finished, select **Next**.
    > [!NOTE]
    > If you chose to create the cluster immediately after running validation, you won't see the **Select Servers** page. The nodes that were validated are automatically added to the Create Cluster Wizard so that you don't have to enter them again.
1. If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, select **Yes**, and then select **Next**. Complete the Validate a Configuration Wizard as described in [Run cluster validation tests](#run-cluster-validation-tests).
1. On the **Access Point for Administering the Cluster** page, enter the **Cluster Name** that you want to use to administer the cluster.
1. If the server doesn't have a network adapter that is configured to use DHCP, you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. Select the **Address** field next to a selected network and then enter the IP address that you want to assign to the cluster. This IP address (or addresses) will be associated with the cluster name in Domain Name System (DNS).
1. When you're finished, select **Next**.
1. On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to configure storage later.
1. Select **Next** to create the failover cluster.
1. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or select **View Report** to view the full report. Select **Finish**.
11. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name and then select items under **Nodes**, **Storage**, or **Networks** to view the associated resources.

After the cluster is created, you can do things such as verify cluster [quorum configuration](/azure-stack/hci/concepts/quorum), [create clustered roles](/windows-server/failover-clustering/create-failover-cluster#create-clustered-roles), and optionally, create [Cluster Shared Volumes (CSV)](failover-cluster-csvs.md).

#### Using PowerShell 

If you prefer to create a workgroup cluster using PowerShell, follow these steps.

1. Validate the configuration before creating the workgroup cluster using the following command: `Test-Cluster -Node server1, server2`
1. After validation passes, create the workgroup cluster using the following command: `New-Cluster –Name MyCluster -Node server1, server2 -AdministrativeAccessPoint DNS`
1. After the cluster has been successfully created, you can do things such as verify cluster [quorum configuration](/azure-stack/hci/concepts/quorum), [create clustered roles](/windows-server/failover-clustering/create-failover-cluster#create-clustered-roles), and optionally, create [Cluster Shared Volumes (CSV)](failover-cluster-csvs.md).
