---
title: What is a failover cluster quorum witness in Windows Server?
description: Learn more about failover cluster quorum cloud witness, disk witness, and file share witness on maintaining high cluster availability.
ms.author: alalve
author: xelu86
ms.topic: conceptual
ms.date: 03/19/2025
---

# What is a quorum witness?

In a failover cluster, a quorum witness is a component that helps maintain the high availability of the cluster by participating in the quorum voting process. The quorum is a concept used to determine the number of failures that the cluster can sustain while still remaining operational.

In a cluster, each node gets a vote, and the quorum witness can also have a vote. The total number of votes determines the quorum. For the cluster to be operational, more than half of the votes must be active. If the number of votes falls below this threshold, the cluster stops running to avoid split-brain scenarios, where two parts of the cluster think they're the active part, leading to data corruption.

The role of the quorum witness is to provide an additional vote to achieve or maintain a majority when there's an even number of nodes, or if certain nodes fail. If the active vote count drops below the required majority, the cluster ceases operations to prevent 'split-brain' conditions. Split-brain is a scenario where when separate sections of the cluster each believe they're functioning independently, which can result in data inconsistencies or corruption.

## Quorum witness types

There are three distinct types of quorum witnesses that can be configured to maintain high availability and prevent split-brain conditions. Each serves as an impartial vote in the cluster's quorum health.

- **Cloud witness** - A cloud-based service like Azure Blob Storage
- **Disk witness** - A shared disk accessible by all nodes
- **File share witness** - A shared folder accessible by all nodes

To ensure continuous operation and data integrity, these quorum witnesses each offering a unique method to achieve a majority vote for cluster operations.

### Cloud witness

Cloud witness is different from traditional cluster quorum witness configurations because it uses an Azure Virtual Machine (VM) in the cloud as the quorum witness instead of a physical datacenter. Cloud witness uses Azure Blob Storage to read and write a blob file that the system uses as the deciding vote to achieve quorum. The following diagram shows an example configuration that uses cloud witness.

:::image type="content" source="media/deploy-failover-cluster-quorum-witness/quorum-cloud-witness.png" alt-text="A diagram depicting a failover cluster with Cloud Witness connected to site one and site two.":::

Cloud witness configurations don't require a third separate datacenter and gets an extra vote to prevent total shutdowns if one of the other datacenters turns off. It doesn't need an extra site for storing the quorum witness and also doesn't need the regular physical maintenance required for an on-site datacenter.

Along with redundancy, there are other benefits to using the Cloud Witness feature:

- Using Azure Blob Storage removes extra maintenance overhead normally required for hosting VMs in the public cloud.

- You can use the same Azure Storage account for multiple clusters. The only requirements are that you use only one blob per cluster and name the blob file name after the cluster's unique ID.

- Lower ongoing costs to your storage account because the blob file doesn't need much data and updates only when the cluster node state changes.

- Azure comes with a built-in cloud witness resource type.

### Disk witness

A disk witness is a type of quorum witness used in a failover cluster to help maintain the high availability of the cluster. A disk witness is a shared disk that all nodes in the cluster have access to. The disk witness contains a small amount of storage space that is used to store the cluster configuration database. This storage space includes important information about the cluster, such as the state of each node and the ownership of cluster resources. Here's how it works:

- The disk witness is configured as a shared storage that all nodes can access, but only one node writes to at any given time.

- When the cluster service starts, each node communicates with the disk witness to read the latest cluster configuration.

- The disk witness participates in the quorum voting process. If a node fails, the disk witness provides an additional vote, which can help prevent a split-brain scenario.

- If there's a network partition, the side of the partition with access to the disk witness that has the most votes continues to run, maintaining the integrity of the cluster.

The disk witness is useful in clusters with an even number of nodes, where it can act as a tiebreaker to ensure there's always a majority vote. It's also helpful in scenarios where multiple nodes fail simultaneously, as the disk witness can help maintain quorum.

The key benefit of using a disk witness is that it provides a consistent and reliable method for all nodes to agree on the current state of the cluster, which is crucial for the proper functioning of a failover cluster. It's important to note that the disk witness doesn't store user or application data, it's solely for the cluster configuration database and quorum voting.

### File share witness

When a cluster contains an even number of voting nodes, you should configure a witness. Adding a witness vote enables the cluster to continue running if half the cluster nodes simultaneously go down or are disconnected. A file share witness is a type of quorum witness that uses a Server Message Block (SMB) file share to maintain cluster information in a log file. This file share can be hosted on a server, USB storage, or Network Attached Storage (NAS).

The file share witness is also beneficial for multisite clusters with replicated storage.

You might use a file share witness when:

- A Cloud Witness can't be used because your cluster nodes don't have a reliable internet connection or an internet connectivity.

- A disk witness can't be used because there aren't any shared drives to use for a disk witness. For example, a Storage Spaces Direct cluster, SQL Server Always On Availability Groups (AG), or Exchange Database Availability Group (DAG). None of these types of clusters use shared disks.

For information about quorum configuration options, see [Configure and manage quorum](manage-cluster-quorum.md).

:::image type="content" source="media/deploy-failover-cluster-quorum-witness/quorum-file-share-witness.png" alt-text="A diagram depicting a cluster quorum with a site labeled file share witness connected to site one and site two.":::

This example is a simplified configuration with two nodes in two on-site datacenters. In typical clusters, each node has one vote, a *file share witness*, that gives one extra vote to the quorum witness. This extra vote lets the cluster keep running even if one of the datacenters turns off. In the example, the cluster quorum has five possible votes, and only needs three votes to continue running.

However, you might notice that in addition to the two datacenters, there's also a third datacenter that acts as the *file share witness*. This datacenter is kept separate from the other two sites and hosts a file server that backs up the system file share. The file share witness functions as the quorum witness in this cluster quorum configuration, making sure the system still runs even if one of the datacenters unexpectedly shuts down.

Having a file share witness provides enough redundancy to keep your file server highly available. However, you should remember that hosting the file share witness on another server in a separate site requires setup, regular maintenance, and independent connectivity to the other sites.

## See also

- [Set up a cluster witness](/azure/azure-local/manage/witness?context=/windows-server/context/windows-server-failover-clustering) in Azure Local

- [Understanding cluster and pool quorum](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering)
