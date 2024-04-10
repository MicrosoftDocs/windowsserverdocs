---
title: Create a workgroup cluster
description: This article describes creating a Failover Cluster without Active Directory.
manager: femila
ms.topic: article
ms.author: wscontent
author: meaghanlewis
ms.date: 04/09/2024
---
# Create a workgroup cluster

>Applies to: Windows Server 2025, Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In this article, learn about and create a failover cluster without Active Directory. First, you'll understand what workgroup clusters are and how they differ from a traditional failover cluster. Then, create a workgroup cluster either using the Failover Cluster Manager or Windows PowerShell.

## Understand workgroup clusters

A workgroup cluster is a specific type of failover cluster configuration. With workgroup clusters, two or more nodes are joined as member servers. They do not needs to be joined to a domain and have no requirements to use Active Directory (AD).

The goal of removing AD requirements from failover clustering is to reduce the cost of hardware, maintanence, monitoring, security, and other operational overhead. At the same time, workgroup clusters offer the same centralized identiy and high security without traditional AD infrastructure.

## Prerequisites 

You must meet the following prerequisites for your workgroup cluster to meet the criteria for an officially supported deployment:

- Make sure that all servers that you want to add as cluster nodes are running the same version of Windows Server.
- Make sure that all servers must have the Failover Clustering feature installed. 
- Create a local user account on each node that will be in the cluster. The username and password of the account must all be the same.
- Make sure that each server is added as trusted hosts. 
- Make sure that all servers have a common primary DNS suffix.
- Confirm that the fully configured solution (servers, network, and storage) passes all tests in the validation workflow, which is included with the failover cluster snap-in.
- Confirm the storage requirements
  - Either Storage Spaces Direct or SAN storage is required. If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).
  - To add clustered storage during cluster creation, make sure that all servers can access the storage. (You can also add clustered storage after you create the cluster.)
- COnfirm the quorum configuration
  - Quorom should be configured for a cluster. Either a Cloud Witness or Disk Witness can be used. A File Share Witness is not currently supported. For more details, see [configure and manage quorom](/windows-server/failover-clustering/manage-cluster-quorum)

## Cluster workloads

This section describes various workloads and whether they support workgroup clusters. The following workloads are recommended:

- **Hyper-V VMs.** Supported cluster workload
- **SQL Server Availability Groups.** SQL Server is a supported workload. If this is the workload you want to deploy, follow the instructions to create a [domain independent availability group](/sql/database-engine/availability-groups/windows/domain-independent-availability-groups?view=sql-server-ver16#create-a-domain-independent-availability-group-1)

Workgroup clusters are not recommended for:

- **File Servers.**
- **SQL Server FCI.**

## Create a two-node workgroup cluster

Follow the directions in the next sections to create a two-node, Hyper-V VM workgroup cluster, with Storage Spaces Direct storage.

### Step 1: Prepare your servers

To get started, you'll need to configure your servers. This will include creating an identical user in each node, and adding your servers as trusted hosts with one another, and ensure that each server has a common primary DNS suffix. Follow these steps on each node that will be part of the cluster.

1. Create a consistent admin user account on all nodes of the cluster. The username and password of these accounts must be the same on all the nodes and the account must also be added to the local Administrators group. If the non-builtin administrator account is not used, then you need to set the LocalAccountTokenFilterPolicy in the registry. This can be done in PowerShell with the following command:
`New-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System –Name LocalAccountTokenFilterPolicy -Value 1​`
1. Add each server node as a trusted host. This can be done in PowerShell with the following command:
`Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force`
1. Navigate to System Properties and then in the Computer Name tab, select Change..., then More..., and then enter a Primary DNS suffix on this computer. 

### Step 2: Install the necessary features

[Install the Failover Clustering feature](/windows-server/failover-clustering/create-failover-cluster#install-the-failover-clustering-feature) if you haven't already.

### Step 3: Create the workgroup cluster

Now you're ready to create a workgroup cluster with the server nodes you just prepared. You may use either the [Failover Cluster Manager](/windows-server/failover-clustering/create-failover-cluster#validate-the-configuration) or [Microsoft PowerShell](/windows-server/failover-clustering/create-failover-cluster#create-a-failover-cluster-by-using-windows-powershell).

#### Using Failover Cluster Manager 

DO WE WANT TO RECOMMEND THIS???
  Q: When I create a workgroup cluster in the UI, it always fails due to active directory. Is that expected?
1. [Validate the configuration](/windows-server/failover-clustering/create-failover-cluster#validate-the-configuration.)
1. After validation passes, [create the workgroup cluster](/windows-server/failover-clustering/create-failover-cluster#create-the-failover-cluster). Make sure to add in the storage.
1. Confirm that the Cluster was successfully created. 
1. Finally, [create clustered roles](/windows-server/failover-clustering/create-failover-cluster#create-clustered-roles).

#### Using PowerShell 

 
1. First, validate the configuration using the following command: `Test-Cluster -Node server1, server2`
1. After validation passes, create the workgroup cluster using the following command: `New-Cluster –Name MyCluster -Node server1, server2 -AdministrativeAccessPoint DNS`
1. After the cluster has been successfully created, add in the storage.



