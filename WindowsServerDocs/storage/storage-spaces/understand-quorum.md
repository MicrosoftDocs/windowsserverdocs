---
title: Understanding Quorum in Storage Spaces Direct
ms.assetid: 
ms.prod: 
ms.author: 
ms.manager: 
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 
ms.localizationpriority: 
---
# Understanding Quorum in Storage Spaces Direct

>Applies To: Windows Server 2016

[Windows Server Failover Clustering](../../failover-clustering\failover-clustering-overview.md) provides high availability for workloads. These resources are considered highly available if the nodes that host resources are up; however, the cluster generally requires more than half the nodes to be running, which is known as having *quorum*.

Quorum is designed to prevent *split-brain* scenarios which can happen when there is a partition in the network and subsets of nodes cannot communicate with each other. This can cause both subsets of nodes to try to own the workload and write to the same disk which can lead to numerous problems. However, this is prevented with Failover Clustering’s concept of quorum which forces only one of these groups to of nodes to continue running, so only one of these groups will stay online.

Quorum determines the number of failures that the cluster can sustain while still remaining online. If an additional failure occurs beyond this threshold, the cluster will stop running. A common perception is that the reason why the cluster will stop running if too many failures occur is to prevent the remaining nodes from taking on too many workloads and having the hosts be overcommitted. In reality, the cluster does not know your capacity limitations or whether you would be willing to take a performance hit in order to keep it online. Rather quorum is designed to handle the scenario when there is a problem with communication between subsets of cluster nodes, so that multiple servers do not try to simultaneously host a resource group and write to the same disk at the same time. Again, this is known as a *split brain* where nodes are functioning independent of each other and we want to prevent this to avoid any potential corruption to a disk by having two simultaneous group owners. By having this concept of quorum, the cluster will force the cluster service to stop in one of the subsets of nodes to ensure that there is only one true owner of a particular resource group. Once nodes which have been stopped can once again communicate with the main group of nodes, they will automatically rejoin the cluster and start their cluster service.

### In Windows Server 2016, there are 2 components of the system that have their own quorum mechanisms on an Storage Spaces Direct (S2D) cluster:

- <strong>Cluster Quorum</strong>: This operates at the cluster level (i.e. you can lose nodes and have the cluster stay up)
- <strong>Pool Quorum</strong>: This operates on the pool level (i.e. you can lose nodes and drives and have the pool stay up)

## Cluster Quorum Overview

The table below gives an overview of the Cluster Quorum outcomes per scenario:

<table class="tg">
  <tr>
    <th class="tg-9hbo">Scenario</th>
    <th class="tg-9hbo">Can survive one node failure</th>
    <th class="tg-9hbo">Can survive one node failure, then another</th>
    <th class="tg-9hbo">Can survive two simultaneous node failures</th>
  </tr>
  <tr>
    <td class="tg-9hbo">2</td>
    <td class="tg-9hbo">50/50</td>
    <td class="tg-9hbo">No</td>
    <td class="tg-9hbo">No</td>
  </tr>
  <tr>
    <td class="tg-9hbo">2 + Witness</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">No</td>
    <td class="tg-9hbo">No</td>
  </tr>
  <tr>
    <td class="tg-9hbo">3</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">50/50</td>
    <td class="tg-9hbo">No</td>
  </tr>
  <tr>
    <td class="tg-9hbo">3 + Witness</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">No</td>
  </tr>
  <tr>
    <td class="tg-9hbo">4</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">50/50</td>
  </tr>
  <tr>
    <td class="tg-9hbo">4 + Witness</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">Yes</td>
  </tr>
  <tr>
    <td class="tg-9hbo">5 ...</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">Yes</td>
  </tr>
</table>

### Therefore, our guidance is:

- If you have 2 nodes, a witness is <strong>REQUIRED</strong>!
- If you have 3 or 4 nodes, witness is <strong>STRONGLY recommended</strong>!
- If you have internet access, use a [cloud witness](../../failover-clustering\deploy-cloud-witness.md)
- If you’re in an IT environment with other machines and file shares, use a file share witness

## How Cluster Quorum Works

When nodes fail, or when some subset of nodes loses contact with another subset, surviving nodes need to verify that they constitute the *majority* of the cluster to remain online. If they can’t verify that, they’ll go offline.

But the concept of *majority* only works cleanly when the total number of nodes in the cluster is odd (for example, 3 nodes in a 5-node cluster). So, what about clusters with an even number of nodes (say, a 4-node cluster)?

There are two tricks the cluster can use to make the *total number of votes* odd:

1. First, it can go *up* one by adding a *witness* with an extra vote. This requires user set-up.
2.	Or, it can go *down* one by zeroing one unlucky node’s vote (happens automatically as needed).

Whenever surviving nodes successfully verify they are the *majority*, the definition of *majority* is updated to be among just the survivors. This allows the cluster to lose one node, then another, then another, and so forth. This concept of the *total number of votes* adapting after successive failures is known as <strong>*Dynamic Quorum*</strong>, which is enabled by default in Windows Server 2016.  

### Dynamic Quorum Behavior

- If you have an <strong>even</strong> number of nodes and no witness, *one node gets its vote zeroed*. For example, only 3 of the 4 nodes get votes, such that the *total number of votes* is considered 3, and 2 survivors with votes are considered a majority.
- If you have an <strong>odd</strong> number of nodes and no witness, *they all get votes*.
- If you have an <strong>even</strong> number of nodes plus witness, *the witness votes*, so the total is odd.
- If you have an <strong>odd</strong> number of nodes plus witness, *the witness does not vote*.

Dynamic Quorum enables the ability to assign a vote to a node dynamically to avoid losing the majority of votes and to allow the cluster to run with one node (known as last-man standing). Let’s take a four-node cluster as an example. Assume that quorum requires 3 votes. 

### Example:

Without dynamic quorum, the cluster will go down if you lose two nodes.

![Normal 4-node case](media/understand-quorum/dynamic-quorum-base-case.png)

With Dynamic Quorum enabled, you are better off. The *total number of votes* required for quorum is now determined based on the number of nodes available. So, with dynamic quorum, the cluster will stay up even if you lose three nodes.

![Dynamic Quorum Step Through](media/understand-quorum/dynamic-quorum-step-through.png)

Now that we understand how dynamic quorum works, let's look at the types of quorum witnesses.

### Quorum Witness Types

Failover Clustering in Windows Server 2016 supports three types of Quorum Witnesses:

- <strong>[Cloud Witness](../../failover-clustering\deploy-cloud-witness.md)</strong> - Blob storage in Azure accessible by all nodes of the cluster. It maintains clustering information in a witness.log file, but does not store a copy of the cluster database.
- <strong>File Share Witness</strong> – A SMB file share that is configured on a file server running Windows Server. It maintains clustering information in a witness.log file, but does not store a copy of the cluster database.
- <strong>Disk Witness</strong> - A small clustered disk which is in the Cluster Available Storage group. This disk is highly-available and can failover between nodes. It contains a copy of the cluster database.  <strong>*A Disk Witness is not supported with Storage Spaces Direct*</strong>.
























To use higher-endurance drives to cache for lower-endurance drives of the same type, you can specify which drive model to use with the **-CacheDeviceModel** parameter of the **Enable-ClusterS2D** cmdlet. Once Storage Spaces Direct is enabled, all drives of that model will be used for caching.

   >[!TIP]
   > Be sure to match the model string exactly as it appears in the output of **Get-PhysicalDisk**.

####  Example

```
PS C:\> Get-PhysicalDisk | Group Model -NoElement

Count Name
----- ----
    8 FABRIKAM NVME-1710
   16 CONTOSO NVME-1520

PS C:\> Enable-ClusterS2D -CacheDeviceModel "FABRIKAM NVME-1710"
```

You can verify that the drives you intended are being used for caching by running **Get-PhysicalDisk** in PowerShell and verifying that their **Usage** property says **"Journal"**.

### Manual deployment possibilities

Manual configuration enables the following deployment possibilities:

![Exotic-Deployment-Possibilities](media/understand-the-cache/Exotic-Deployment-Possibilities.png)

### Set cache behavior

It is possible to override the default behavior of the cache. For example, you can set it to cache reads even in an all-flash deployment. We discourage modifying the behavior unless you are certain the default does not suit your workload.

To override the behavior, use **Set-ClusterS2D** cmdlet and its **-CacheModeSSD** and **-CacheModeHDD** parameters. The **CacheModeSSD** parameter sets the cache behavior when caching for solid-state drives. The **CacheModeHDD** parameter sets cache behavior when caching for hard disk drives. This can be done at any time after Storage Spaces Direct is enabled.

You can use **Get-ClusterS2D** to verify the behavior is set.

#### Example

```
PS C:\> Get-ClusterS2D

CacheModeHDD : ReadWrite
CacheModeSSD : WriteOnly
...

PS C:\> Set-ClusterS2D -CacheModeSSD ReadWrite

PS C:\> Get-ClusterS2D

CacheModeHDD : ReadWrite
CacheModeSSD : ReadWrite
...
```