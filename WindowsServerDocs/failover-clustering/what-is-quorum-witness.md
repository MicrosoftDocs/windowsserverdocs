---
title: What is a failover cluster quorum witness in Windows Server?
description: Learn more about failover cluster quorum cloud witness, disk witness, and file share witness on maintaining high cluster availability.
ms.author: daknappe
author: dknappettmsft
ms.topic: concept-article
ms.date: 03/28/2025
---

# What is a quorum witness?

In a failover cluster, a quorum witness is a component that helps maintain the high availability of the cluster by participating in the quorum voting process. The quorum is a concept used to determine the number of failures that the cluster can sustain while still remaining operational.

In a cluster, each node gets a vote, and the quorum witness can also have a vote. The total number of votes determines the quorum. For the cluster to be operational, more than half of the votes must be active. If the number of votes falls below this threshold, the cluster stops running to avoid split-brain scenarios, where two parts of the cluster think they're the active part, leading to data corruption.

The role of the quorum witness is to provide an extra vote to achieve or maintain a majority when there's an even number of nodes, or if certain nodes fail. If the active vote count drops below the required majority, the cluster ceases operations to prevent 'split-brain' conditions. Split-brain is a scenario where when separate sections of the cluster each believe they're functioning independently, which can result in data inconsistencies or corruption.

## Quorum witness types

There are three distinct types of quorum witnesses that can be configured to maintain high availability and prevent split-brain conditions. Each serves as an impartial vote in the cluster's quorum health.

- **Cloud witness** - A cloud-based service like Azure Blob Storage
- **Disk witness** - A shared disk accessible by all nodes
- **File share witness** - A shared folder accessible by all nodes

To ensure continuous operation and data integrity, these quorum witnesses each offer a unique method to achieve a majority vote for cluster operations. As a best practice, configure the quorum to have an odd number of voting elements. If the cluster has an even number of voting nodes, add a disk witness or a file share witness. This configuration allows the cluster to tolerate one extra node failure. Moreover, adding a witness vote ensures the cluster can continue operating even if half of the cluster nodes fail or lose connectivity simultaneously. Depending on the quorum configuration you choose, the cluster is configured in one of the following quorum modes:

| Mode | Description |
|--|--|
| Node majority (no witness) | Only nodes have votes. No quorum witness is configured. The cluster quorum depends on the majority votes from the active cluster nodes. |
| Node majority with witness (disk or file share) | Nodes have votes. In addition, a quorum witness has a vote. The cluster quorum relies on the majority votes from the active cluster nodes, including any witness votes. A quorum witness can be a designated disk witness or a designated file share witness. |
| No majority (disk witness only) | No nodes have votes. Only a disk witness has a vote. <br><br>The cluster quorum relies on the state of the disk witness. Generally, this mode isn't recommended, and it shouldn't be selected because it creates a single point of failure for the cluster. |

> [!NOTE]
> If you're using a file share witness or a cloud witness, don't forget to restart the cluster service on the last active node before shutting down all cluster nodes for maintenance. This ensures the cluster can resume operations smoothly when brought back online. Witness types like these don't store the latest cluster database, which can lead to errors during device startup. To learn more, see [Event 1561](/previous-versions/troubleshoot/windows-server/failover-clustering-system-log-events#event-1561-service_nonstorage_witness_better_tag).

> [!TIP]
> You can verify the dynamic vote assigned to a node by checking the **DynamicWeight** property of the cluster node using the [Get-ClusterNode](/powershell/module/failoverclusters/get-clusternode) cmdlet. A **DynamicWeight** value of **0** means the node doesn't have a quorum vote, while a value of **1** indicates that the node has a quorum vote.

### Cloud witness

Cloud witness is different from traditional cluster quorum witness configurations because it uses an Azure Virtual Machine (VM) in the cloud as the quorum witness instead of a physical datacenter. Cloud witness uses Azure Blob Storage to read and write a blob file that the system uses as the deciding vote to achieve quorum. The following diagram shows an example configuration that uses cloud witness.

:::image type="content" source="media/deploy-failover-cluster-quorum-witness/quorum-cloud-witness.png" alt-text="A diagram depicting a failover cluster with Cloud Witness connected to site one and site two.":::

Cloud witness configurations don't require a third separate datacenter and gets an extra vote to prevent total shutdowns if one of the other datacenters turns off. It doesn't need an extra site for storing the quorum witness and also doesn't need the regular physical maintenance required for an on-site datacenter.

Along with redundancy, there are other benefits to using the cloud witness feature:

- Using Azure Blob Storage removes extra maintenance overhead normally required for hosting VMs in the public cloud.

- You can use the same Azure Storage account for multiple clusters. The only requirements are that you use only one blob per cluster and name the blob file name after the cluster's unique ID.

- Lower ongoing costs to your storage account because the blob file doesn't need much data and updates only when the cluster node state changes.

- Azure comes with a built-in cloud witness resource type.

- A cloud witness doesn't store a copy of the cluster database.

### Disk witness

A disk witness is a type of quorum witness used in a failover cluster to help maintain the high availability of the cluster. A disk witness is a shared disk that all nodes in the cluster have access to. The disk witness contains a small amount of storage space that is used to store the cluster configuration database. This storage space includes important information about the cluster, such as the state of each node and the ownership of cluster resources. Here's how it works:

- The disk witness is configured as a shared storage that all nodes can access, but only one node writes to at any given time.

- When the cluster service starts, each node communicates with the disk witness to read the latest cluster configuration.

- The disk witness participates in the quorum voting process. If a node fails, the disk witness provides an extra vote, which can help prevent a split-brain scenario.

- If there's a network partition, the side of the partition with access to the disk witness that has the most votes continues to run, maintaining the integrity of the cluster.

The disk witness is useful in clusters with an even number of nodes, where it can act as a tiebreaker to ensure there's always a majority vote. It's also helpful in scenarios where multiple nodes fail simultaneously, as the disk witness can help maintain quorum.

The key benefit of using a disk witness is that it provides a consistent and reliable method for all nodes to agree on the current state of the cluster. Consistency is crucial for ensuring the proper functioning of a failover cluster. It's important to note that the disk witness doesn't store user or application data, it's solely for the cluster configuration database and quorum voting.

### File share witness

When a cluster contains an even number of voting nodes, you should configure a witness. Adding a witness vote enables the cluster to continue running if half the cluster nodes simultaneously go down or are disconnected. A file share witness is a type of quorum witness that uses a Server Message Block (SMB) file share to maintain cluster information in a log file. This file share can be hosted on a server, USB storage, or Network Attached Storage (NAS).

The file share witness is also beneficial for multisite clusters with replicated storage. You might use a file share witness when:

- A cloud witness can't be used because your cluster nodes don't have a reliable internet connection or an internet connectivity.

- A disk witness can't be used because there aren't any shared drives to use for a disk witness. For example, a Storage Spaces Direct cluster, SQL Server Always On Availability Groups (AG), or Exchange Database Availability Group (DAG). None of these types of clusters use shared disks.

:::image type="content" source="media/deploy-failover-cluster-quorum-witness/quorum-file-share-witness.png" alt-text="A diagram depicting a cluster quorum with a site labeled file share witness connected to site one and site two.":::

This example is a simplified configuration with two nodes in two on-site datacenters. In typical clusters, each node has one vote, a *file share witness*, that gives one extra vote to the quorum witness. This extra vote lets the cluster keep running even if one of the datacenters turns off. In the example, the cluster quorum has five possible votes, and only needs three votes to continue running.

However, you might notice that in addition to the two datacenters, there's also a third datacenter that acts as the *file share witness*. This datacenter is kept separate from the other two sites and hosts a file server that backs up the system file share. The file share witness functions as the quorum witness in this cluster quorum configuration, making sure the system still runs even if one of the datacenters unexpectedly shuts down.

Having a file share witness provides enough redundancy to keep your file server highly available. However, you should remember that hosting the file share witness on another server in a separate site requires setup, regular maintenance, and independent connectivity to the other sites.

#### Witness configuration

As a best practice, configure the quorum to have an odd number of voting elements. If the cluster has an even number of voting nodes, add a disk witness or a file share witness to ensure high availability. This configuration allows the cluster to tolerate the failure of one extra node. Furthermore, adding a witness vote ensures the cluster can continue operating even if half of the cluster nodes fail or lose connectivity simultaneously.

A disk witness is typically recommended when all cluster nodes have access to the shared disk. On the other hand, a file share witness is preferred for multisite disaster recovery scenarios involving replicated storage. Configuring a disk witness with replicated storage is feasible only if the storage solution supports read-write access from all sites to the replicated storage. To learn more about witness configuration types, see [Deploy a quorum witness](deploy-quorum-witness.md).

## Node vote assignment

In advanced quorum configurations, you're able to assign or remove quorum votes for individual nodes. By default, every node in the cluster is assigned a vote. However, even if a node's vote is removed, it still participates in the cluster, receive updates to the cluster database, and remain capable of hosting applications.

In specific disaster recovery scenarios, you might consider removing votes from certain nodes. For instance, in a multisite cluster, you can remove votes from the nodes located in a backup site to prevent them from influencing quorum calculations. This approach is typically recommended only when planning for manual failover between sites. Node vote assignment isn't recommended to enforce an odd number of voting nodes. Instead, you should configure a disk witness or file share witness.

## Dynamic quorum management

Dynamic quorum management is an advanced configuration option that allows the cluster to adjust its quorum majority requirements dynamically. This feature enables the cluster to remain operational even as nodes are sequentially shut down, allowing the cluster to run on the last surviving node.

Dynamic quorum management provides enhanced flexibility and resilience for failover clusters, making it a valuable feature for maintaining high availability in dynamic environments. With dynamic quorum management enabled, the cluster can automatically adjust the votes assigned to nodes based on the current cluster state, ensuring that the cluster can sustain node failures or planned shutdowns while maintaining quorum. If dynamic quorum management is enabled, only the nodes that are configured to have node votes assigned can have their votes assigned or removed dynamically.

Key considerations:

- Dynamic quorum management doesn't allow the cluster to survive the simultaneous failure of most voting members. At the time of a node failure or shutdown, the cluster must still have a quorum majority to continue running.
- If a node's vote is explicitly removed, the cluster can't dynamically add or remove that vote.
- In clusters with **Storage Spaces Direct** enabled, the cluster can only tolerate up to two node failures.

## General recommendations for quorum configuration

The cluster software automatically determines the quorum configuration for a new cluster based on the number of nodes and the availability of shared storage. This default configuration is typically the most suitable for the cluster. We recommend you review the quorum settings after the cluster is created and before deploying it in a production environment.

To examine the detailed quorum configuration, you can use the **Validate a Configuration Wizard** or the [Test-Cluster](/powershell/module/failoverclusters/test-cluster) cmdlet to run the **Validate Quorum Configuration** test. In **Failover Cluster Manager**, the basic quorum configuration is displayed in the summary section for the selected cluster. Alternatively, you can retrieve detailed information about quorum resources by running the [Get-ClusterQuorum](/powershell/module/failoverclusters/get-clusterquorum) cmdlet.

At any time, you can run the **Validate Quorum Configuration** test to ensure the quorum settings are optimal for your cluster. The test results indicate whether a configuration change is recommended and provides the optimal settings. If adjustments are needed, you can apply the recommended changes using the **Configure Cluster Quorum Wizard**. Once the cluster is in production, avoid modifying the quorum configuration unless you thoroughly evaluate and confirm that the change is necessary for your cluster's specific requirements. You might want to consider changing the quorum configuration in the following situations:

- Adding or evicting nodes
- Adding or removing storage
- A long-term node or witness failure
- Recovering a cluster in a multisite disaster recovery scenario

## See also

- [Set up a cluster witness](/azure/azure-local/manage/witness?context=/windows-server/context/windows-server-failover-clustering) in Azure Local

- [Understanding cluster and pool quorum](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering)

- [Validate hardware for a failover cluster](/troubleshoot/windows-server/high-availability/validate-hardware-failover-cluster)

