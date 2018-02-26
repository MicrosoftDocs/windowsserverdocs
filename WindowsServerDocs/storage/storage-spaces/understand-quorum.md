---
title: Understanding Quorum in Storage Spaces Direct
ms.assetid: 
ms.prod: 
ms.author: 
ms.manager: 
ms.technology: storage-spaces
ms.topic: article
author: adagashe
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
- If you have internet access, use a <strong>[cloud witness](../../failover-clustering\deploy-cloud-witness.md)</strong>
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

Without dynamic quorum, the cluster will go down if you lose two nodes.

![Normal 4-node case](media/understand-quorum/dynamic-quorum-base.png)

With Dynamic Quorum enabled, you are better off. The *total number of votes* required for quorum is now determined based on the number of nodes available. So, with dynamic quorum, the cluster will stay up even if you lose three nodes.

![Dynamic Quorum Step Through](media/understand-quorum/dynamic-quorum-step-through.png)

### Examples

1. <strong>2 NODES, NO WITNESS</strong>. One node’s vote is zeroed. The *majority* is out of <strong>/1</strong>. If the non-voting node goes down unexpectedly, the survivor has 1/1 and the cluster survives. If the voting node goes down unexpectedly, the survivor has 0/1 and the cluster goes down. If the voting node is gracefully powered down, the vote is transferred to the other node, and the cluster survives.

![Quorum 2 Node No Witness](media/understand-quorum/2-node-no-witness.png)

- Can survive one server failure: <strong>Fifty percent chance</strong>.
- Can survive one server failure, then another: <strong>No</strong>.
- Can survive two server failures at once: <strong>No</strong>. 

2. <strong>2 NODES PLUS WITNESS</strong>. Both nodes vote, plus the witness votes. The *majority* is out of <strong>/3</strong>. If either node goes down, the survivor has 2/3 and the cluster survives.

![Quorum 2 Node Witness](media/understand-quorum/2-node-witness.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>No</strong>.
- Can survive two server failures at once: <strong>No</strong>. 

3. <strong>3 NODES, NO WITNESS</strong>. All nodes vote. The *majority* is out of <strong>/3</strong>. If any node goes down, the survivors are 2/3 and the cluster survives. The cluster becomes 2 nodes, no witness – at that point, you’re in Scenario 1.

![Quorum 3 Node No Witness](media/understand-quorum/3-node-no-witness.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Fifty percent chance</strong>.
- Can survive two server failures at once: <strong>No</strong>. 

4. <strong>3 NODES PLUS WITNESS</strong>. All nodes vote, the witness does not initially vote. Majority is out of <strong>/3</strong>. After one failure, the cluster becomes 2 nodes plus witness – meaning Scenario 2. The witness thereafter votes.

![Quorum 3 Node Witness](media/understand-quorum/3-node-witness.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Yes</strong>.
- Can survive two server failures at once: <strong>No</strong>. 

5. <strong>4 NODES, NO WITNESS</strong>. One node’s vote is zeroed. Majority is out of <strong>/3</strong>. After one failure, the cluster becomes 3 nodes, and you’re in Scenario 3.

![Quorum 4 Node No Witness](media/understand-quorum/4-node-no-witness.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Yes</strong>.
- Can survive two server failures at once: <strong>Fifty percent chance</strong>. 

6. <strong>4 NODES PLUS WITNESS</strong>. All nodes votes, and the witness votes. Majority is out of <strong>/5</strong>. After one failure, you’re in Scenario 4. After two simultaneous failures, you skip down to Scenario 2.

![Quorum 4 Node Witness](media/understand-quorum/4-node-witness.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Yes</strong>.
- Can survive two server failures at once: <strong>Yes</strong>. 

7. <strong>5 NODES AND BEYOND</strong>. All nodes vote, or all but one vote, whatever makes the total odd. Storage Spaces Direct cannot handle more than 2 servers down anyway, so at this point, no witness is needed or useful.

![Quorum 5 Nodes and Beyond](media/understand-quorum/5-nodes.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Yes</strong>.
- Can survive two server failures at once: <strong>Yes</strong>. 

Now that we understand how quorum works, let's look at the types of quorum witnesses.

### Quorum Witness Types

Failover Clustering in Windows Server 2016 supports three types of Quorum Witnesses:

- <strong>[Cloud Witness](../../failover-clustering\deploy-cloud-witness.md)</strong> - Blob storage in Azure accessible by all nodes of the cluster. It maintains clustering information in a witness.log file, but does not store a copy of the cluster database.
- <strong>File Share Witness</strong> – A SMB file share that is configured on a file server running Windows Server. It maintains clustering information in a witness.log file, but does not store a copy of the cluster database.
- <strong>Disk Witness</strong> - A small clustered disk which is in the Cluster Available Storage group. This disk is highly-available and can failover between nodes. It contains a copy of the cluster database.  <strong>*A Disk Witness is not supported with Storage Spaces Direct*</strong>.

## Pool Quorum Overview

The table below gives an overview of the Pool Quorum outcomes per scenario:

<table class="tg">
  <tr>
    <th class="tg-9hbo">Scenario</th>
    <th class="tg-9hbo">Can survive one node failure</th>
    <th class="tg-9hbo">Can survive one node failure, then another</th>
    <th class="tg-9hbo">Can survive two simultaneous node failures</th>
  </tr>
  <tr>
    <td class="tg-9hbo">2</td>
    <td class="tg-9hbo">No</td>
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
    <td class="tg-9hbo">No</td>
    <td class="tg-9hbo">No</td>
  </tr>
  <tr>
    <td class="tg-9hbo">3 + Witness</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">No</td>
    <td class="tg-9hbo">No</td>
  </tr>
  <tr>
    <td class="tg-9hbo">4</td>
    <td class="tg-9hbo">Yes</td>
    <td class="tg-9hbo">No</td>
    <td class="tg-9hbo">No</td>
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

## How Pool Quorum Works

When drives fail, or when some subset of drives loses contact with another subset, surviving drives need to verify that they constitute the *majority* of the pool to remain online. If they can’t verify that, they’ll go offline. The pool is the entity that goes offline or stays online based on whether it has enough disks for quorum (50% + 1). The pool resource owner (active cluster node) can be the +1.

But pool quorum works differently from cluster quorum in the following ways:

- the pool uses one node in the cluster as a witness as a tie-breaker to survive half of drives gone (this node that is the pool resource owner)
- the pool does NOT have dynamic quorum
- the pool does NOT implement its own version of removing a vote

### Examples

1. <strong>4 NODES, SYMMETRICAL</strong>. Each of the 16 drives has one vote and node 2 also has one vote (since it is the pool resource owner). The *majority* is out of <strong>/16</strong>. If nodes 3 and 4 go down, the surviving subset has 8 drives and the pool resource owner, which is 9/16 votes. So, the pool survives.

![Pool Quorum 1](media/understand-quorum/pool-1.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Yes</strong>.
- Can survive two server failures at once: <strong>Yes</strong>. 

2. <strong>4 NODES, DRIVE FAILURE, SYMMETRICAL</strong>. Each of the 16 drives has one vote and node 2 also has one vote (since it is the pool resource owner). The *majority* is out of <strong>/16</strong>. First, drive 7 goes down. If nodes 3 and 4 go down, the surviving subset has 7 drives and the pool resource owner, which is 8/16 votes. So, the pool does not have majority and goes down.

![Pool Quorum 2](media/understand-quorum/pool-2.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>No</strong>.
- Can survive two server failures at once: <strong>No</strong>. 

3. <strong>4 NODES, NON-SYMMETRICAL</strong>. Each of the 24 drives has one vote and node 2 also has one vote (since it is the pool resource owner). The *majority* is out of <strong>/24</strong>. If nodes 3 and 4 go down, the surviving subset has 8 drives and the pool resource owner, which is 9/24 votes. So, the pool does not have majority and goes down.

![Pool Quorum 3](media/understand-quorum/pool-3.png)

- Can survive one server failure: <strong>Yes</strong>.
- Can survive one server failure, then another: <strong>Depends </strong>(cannot survive if both nodes 3 and 4 go down, but can survive all other scenarios.
- Can survive two server failures at once: <strong>Depends </strong>(cannot survive if both nodes 3 and 4 go down, but can survive all other scenarios.

### Therefore, our guidance is:

- Ensure that each node in your cluster is symmetrical (each node has the same number of drives)
- Enable 3-way mirror or dual parity so that you can tolerate a node failures and keep the virtual disks online. See our [volume guidance page](https://docs.microsoft.com/en-us/windows-server/storage/storage-spaces/plan-volumes) for more details.
- If more than 2 nodes are down, or 2 nodes and a disk on another node are down, volumes may not have access to all 3 copies of their data, and therefore be taken offline and be unavailable. It’s recommended to bring the servers back or replace the disks quickly to ensure the most resiliency for all the data in the volume.