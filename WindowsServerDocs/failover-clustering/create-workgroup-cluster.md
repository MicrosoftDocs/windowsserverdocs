---
title: Create a workgroup cluster
description: This article describes creating a Failover Cluster without Active Directory.
manager: femila
ms.topic: how-to
ms.author: wscontent
author: meaghanlewis
ms.date: 04/09/2024
---
# Create a workgroup cluster

>Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In this article, learn about and create a workgroup cluster. First, you'll understand what workgroup clusters are and how they differ from traditional failover clusters. Then, create a workgroup cluster either using the Failover Cluster Manager or Windows PowerShell.

## Understand workgroup clusters

A workgroup cluster is a specific type of failover cluster configuration. With workgroup clusters, two or more nodes are joined as member servers. They don't use an on-premise domain controller or Active Directory forest. They aren't domain joined, and instead are joined by a workgroup.

The goal of removing the dependency on Active Directory requirements from failover clustering is to reduce the cost of hardware, maintanence, security, and other operational overhead. Traditionally, Active Directory has been necessary to maintain highly available domain controllers, and store identity, however, there are other technologies we can use now for the same purpose outside of Active Directory.

Workgroup clusters offer the same centralized identiy and high security, focusing on keeping your applications highly available. And by not using AD, your business will still achieve the most availability at the lowest cost.

## Prerequisites 

You must meet the following prerequisites for your workgroup cluster to meet the criteria for an officially supported deployment:

- Make sure that all servers that you want to add as cluster nodes are running the same version of Windows Server.
- Make sure that all servers must have the Failover Clustering feature installed. 
- Make sure that all servers have a common primary DNS suffix.
- Make sure that each server is added as trusted hosts. 
- Create a local user account on each node that will be in the cluster. The username and password of the account must all be the same.
- Confirm that the fully configured solution (servers, network, and storage) passes all tests in the validation workflow, which is included with the failover cluster snap-in.
- Confirm the storage requirements
  - Either Storage Spaces Direct or SAN storage is required. If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).
  - To add clustered storage during cluster creation, make sure that all servers can access the storage. (You can also add clustered storage after you create the cluster.)
- COnfirm the quorum configuration
  - Quorom should be configured for a cluster. Either a Cloud Witness or Disk Witness can be used. A File Share Witness is not currently supported. For more details, see [configure and manage quorom](/windows-server/failover-clustering/manage-cluster-quorum)

## Cluster workloads

This section describes various workloads and whether they support workgroup clusters. The following workloads are recommended:

- **Hyper-V VMs.** Supported cluster workload.
- **SQL Server Availability Groups.** SQL Server is a supported workload. If this is the workload you want to deploy, follow the instructions to create a [domain independent availability group](/sql/database-engine/availability-groups/windows/domain-independent-availability-groups?view=sql-server-ver16#create-a-domain-independent-availability-group-1)

Workgroup clusters are not recommended for:

- **File Servers.**
- **SQL Server FCI.**

## Create a two-node workgroup cluster

Follow the directions in the next sections to create a two-node, Hyper-V VM workgroup cluster, with Storage Spaces Direct storage.

### Step 1: Prepare your servers

To get started, you'll need to configure your servers. This will include creating an identical user in each node, adding your servers as trusted hosts with each other, and ensuring that each server has a common primary DNS suffix. Follow these steps on each node that will be part of the cluster.

1. Create a consistent admin user account on each node. The username and password of these accounts must be the same on all the nodes and the account must also be added to the local Administrators group. If the non-builtin administrator account is not used, then you need to set the LocalAccountTokenFilterPolicy in the registry. This can be done in PowerShell with the following command:
`New-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System –Name LocalAccountTokenFilterPolicy -Value 1​`
1. Add each server node as a trusted host. To do that, modify the `TrustedHosts` file by adding a value for each server that will be allowed to connect to the local machine. Choose to allow: all computers access, by hostname,  by domain name, or by IP address. The following PowerShell command will allow each hostname specified to access the local machine:
`Set-Item WSMan:\localhost\Client\TrustedHosts -Value "server1,server2"`
1. Set a primary DNS suffix on each node. To do so, navigate to **System Properties** and in the Computer Name tab, select **Change...**. In the Computer Name/Domain Changes dialog, confirm that the Member of option selected is `Workgroup`. Then select **More...**. In the DNS Suffix and NetBIOS Computer Name dialog, enter a **Primary DNS suffix of this computer** of your choice. 

### Step 2: Install the necessary features

[Install the Failover Clustering feature](/windows-server/failover-clustering/create-failover-cluster#install-the-failover-clustering-feature) if you haven't already. This feature can be installed in the Server Manager.

1. Start Server Manager.
1. On the **Manage** menu, select **Add Roles and Features**.
1. On the **Before you begin** page, select **Next**.
1. On the **Select installation type** page, select **Role-based or feature-based installation** and then select **Next**.
1. On the **Select destination server** page, select the server where you want to install the feature and then select **Next**.
1. On the **Select server roles** page, select **Next**.
1. On the **Select features** page, select the **Failover Clustering** check box.
1. To install the failover cluster management tools, select **Add Features** and then select **Next**.
1. On the **Confirm installation selections** page, select **Install**. Note: A server restart is not required for the Failover Clustering feature.
1. When the installation is completed, select **Close**.
1. Repeat this procedure on every server that you want to add as a failover cluster node.

### Step 3: Create the workgroup cluster

Now you're ready to create a workgroup cluster with the server nodes you just prepared. You may use either the [Failover Cluster Manager](/windows-server/failover-clustering/create-failover-cluster#validate-the-configuration) or [Microsoft PowerShell](/windows-server/failover-clustering/create-failover-cluster#create-a-failover-cluster-by-using-windows-powershell).

#### Using Failover Cluster Manager 

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft supports a cluster solution only if the complete configuration passes all validation tests and if all hardware is certified for the version of Windows Server that the cluster nodes are running.

> [!NOTE]
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests do not run.

##### Run cluster validation tests

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. To do this on a server, start Server Manager and then on the **Tools** menu, select **Failover Cluster Manager**.
1. In the **Failover Cluster Manager** pane under **Management**, select **Validate Configuration**.
1. On the **Before You Begin** page, select **Next**.
1. On the **Select Servers or a Cluster** page in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format `server1.contoso.com, server2.contoso.com`. When you are finished, select **Next**.
1. On the **Testing Options** page, select **Run all tests (recommended)** and then select **Next**.
1. On the **Confirmation** page, select **Next**. The Validating page displays the status of the running tests.
1. On the **Summary** page, do either of the following:
    - If the results indicate that the tests completed successfully and the configuration is suited for clustering and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected and then select **Finish**. Then, continue to step 4 of the [Create the wprkgroup cluster](#create-the-workgroup-cluster) procedure.
    - If the results indicate that there were warnings or failures, select **View Report** to view the details and determine which issues must be corrected. Realize that a warning for a particular validation test indicates that this aspect of the failover cluster can be supported but might not meet the recommended best practices.

##### Create the workgroup cluster

After validation passes, you may now create the workgroup cluster.

1. Start Server Manager.
1. On the **Tools** menu, select **Failover Cluster Manager**.
1. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**. The Create Cluster Wizard opens.
1. On the **Before You Begin** page, select **Next**.
1. If the **Select Servers** page appears, in the **Enter name** box enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you are finished, select **Next**.
    > [!NOTE]
    > If you chose to create the cluster immediately after running validation in the [configuration validating procedure](#validate-the-configuration), you will not see the **Select Servers** page. The nodes that were validated are automatically added to the Create Cluster Wizard so that you do not have to enter them again.
1. If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, select **Yes**, and then select **Next**. Complete the Validate a Configuration Wizard as described in [Run cluster validation tests](#run-cluster-validation-tests).
1. On the **Access Point for Administering the Cluster** page, enter the **Cluster Name** that you want to use to administer the cluster.
1. If the server does not have a network adapter that is configured to use DHCP, you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. Select the **Address** field next to a selected network and then enter the IP address that you want to assign to the cluster. This IP address (or addresses) will be associated with the cluster name in Domain Name System (DNS).
1. When you are finished, select **Next**.
1. On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to configure storage later.
1. Select **Next** to create the failover cluster.
1. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or select **View Report** to view the full report. Select **Finish**.
11. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name and then select items under **Nodes**, **Storage** or **Networks** to view the associated resources.

After the cluster is created, you can do things such as verify cluster quorum configuration, and optionally, create Cluster Shared Volumes (CSV). For more information, see [Understanding Quorum in Storage Spaces Direct](/azure-stack/hci/concepts/quorum) and [Use Cluster Shared Volumes in a failover cluster](failover-cluster-csvs.md).

DO WE WANT TO RECOMMEND THIS???
  Q: When I create a workgroup cluster in the UI, it always fails due to active directory. Is that expected?
1. [Validate the configuration](/windows-server/failover-clustering/create-failover-cluster#validate-the-configuration.)
1. After validation passes, [create the workgroup cluster](/windows-server/failover-clustering/create-failover-cluster#create-the-failover-cluster). Make sure to add in the storage.
1. Confirm that the Cluster was successfully created. 
1. Finally, [create clustered roles](/windows-server/failover-clustering/create-failover-cluster#create-clustered-roles).

#### Using PowerShell 

If you prefer to create a workgroup cluster using PowerShell, follow these steps.

1. First, confirm that the Failover Clustering feature is installed on each node. If you didn't previously install the feature using Server Manager, you can install it with the PowerShell command:
`Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools`
1. Validate the configuration before creating the workgroup cluster using the following command: `Test-Cluster -Node server1, server2`
1. After validation passes, create the workgroup cluster using the following command: `New-Cluster –Name MyCluster -Node server1, server2 -AdministrativeAccessPoint DNS`
1. After the cluster has been successfully created, add in the storage and any clustered roles.



