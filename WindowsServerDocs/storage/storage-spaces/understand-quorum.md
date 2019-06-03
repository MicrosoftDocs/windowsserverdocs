---
title: Understanding cluster and pool quorum
description: Understanding Cluster and Pool Quorum, with specific examples to go over the intricacies.
keywords: Storage Spaces Direct,Quorum,Witness,S2D,Cluster Quorum,Pool Quorum,Cluster,Pool
ms.prod: windows-server-threshold
ms.author: adagashe
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: adagashe
ms.date: 01/18/2019
ms.localizationpriority: medium
---
# Understanding cluster and pool quorum

>Applies to: Windows Server 2019, Windows Server 2016

[Windows Server Failover Clustering](../../failover-clustering/failover-clustering-overview.md) provides high availability for workloads. These resources are considered highly available if the nodes that host resources are up; however, the cluster generally requires more than half the nodes to be running, which is known as having *quorum*.

Quorum is designed to prevent *split-brain* scenarios which can happen when there is a partition in the network and subsets of nodes cannot communicate with each other. This can cause both subsets of nodes to try to own the workload and write to the same disk which can lead to numerous problems. However, this is prevented with Failover Clustering’s concept of quorum which forces only one of these groups of nodes to continue running, so only one of these groups will stay online.

Quorum determines the number of failures that the cluster can sustain while still remaining online. Quorum is designed to handle the scenario when there is a problem with communication between subsets of cluster nodes, so that multiple servers don't try to simultaneously host a resource group and write to the same disk at the same time. By having this concept of quorum, the cluster will force the cluster service to stop in one of the subsets of nodes to ensure that there is only one true owner of a particular resource group. Once nodes which have been stopped can once again communicate with the main group of nodes, they will automatically rejoin the cluster and start their cluster service.

In Windows Server 2019 and Windows Server 2016, there are two components of the system that have their own quorum mechanisms:

- **Cluster Quorum**: This operates at the cluster level (i.e. you can lose nodes and have the cluster stay up)
- **Pool Quorum**: This operates on the pool level when Storage Spaces Direct is enabled (i.e. you can lose nodes and drives and have the pool stay up). Storage pools were designed to be used in both clustered and non-clustered scenarios, which is why they have a different quorum mechanism.

## Cluster quorum overview

The table below gives an overview of the Cluster Quorum outcomes per scenario:

| Server nodes | Can survive one server node failure | Can survive one server node failure, then another | Can survive two simultaneous server node failures |
|--------------|-------------------------------------|---------------------------------------------------|----------------------------------------------------|
| 2            | 50/50                               | No                                                | No                                                 |
| 2 + Witness  | Yes                                 | No                                                | No                                                 |
| 3            | Yes                                 | 50/50                                             | No                                                 |
| 3 + Witness  | Yes                                 | Yes                                               | No                                                 |
| 4            | Yes                                 | Yes                                               | 50/50                                              |
| 4 + Witness  | Yes                                 | Yes                                               | Yes                                                |
| 5 and above  | Yes                                 | Yes                                               | Yes                                                |

### Cluster quorum recommendations

- If you have two nodes, a witness is **required**.
- If you have three or four nodes, witness is **strongly recommended**.
- If you have Internet access, use a **[cloud witness](../../failover-clustering/deploy-cloud-witness.md)**
- If you’re in an IT environment with other machines and file shares, use a file share witness

## How cluster quorum works

When nodes fail, or when some subset of nodes loses contact with another subset, surviving nodes need to verify that they constitute the *majority* of the cluster to remain online. If they can’t verify that, they’ll go offline.

But the concept of *majority* only works cleanly when the total number of nodes in the cluster is odd (for example, three nodes in a five node cluster). So, what about clusters with an even number of nodes (say, a four node cluster)?

There are two ways the cluster can make the *total number of votes* odd:

1. First, it can go *up* one by adding a *witness* with an extra vote. This requires user set-up.
2.	Or, it can go *down* one by zeroing one unlucky node’s vote (happens automatically as needed).

Whenever surviving nodes successfully verify they are the *majority*, the definition of *majority* is updated to be among just the survivors. This allows the cluster to lose one node, then another, then another, and so forth. This concept of the *total number of votes* adapting after successive failures is known as ***Dynamic quorum***.  

### Dynamic witness

Dynamic witness toggles the vote of the witness to make sure that the *total number of votes* is odd. If there are an odd number of votes, the witness doesn't have a vote. If there is an even number of votes, the witness has a vote. Dynamic witness significantly reduces the risk that the cluster will go down because of witness failure. The cluster decides whether to use the witness vote based on the number of voting nodes that are available in the cluster.

Dynamic quorum works with Dynamic witness in the way described below.

### Dynamic quorum behavior

- If you have an **even** number of nodes and no witness, *one node gets its vote zeroed*. For example, only three of the four nodes get votes, so the *total number of votes* is three, and two survivors with votes are considered a majority.
- If you have an **odd** number of nodes and no witness, *they all get votes*.
- If you have an **even** number of nodes plus witness, *the witness votes*, so the total is odd.
- If you have an **odd** number of nodes plus witness, *the witness doesn't vote*.

Dynamic quorum enables the ability to assign a vote to a node dynamically to avoid losing the majority of votes and to allow the cluster to run with one node (known as last-man standing). Let’s take a four-node cluster as an example. Assume that quorum requires 3 votes. 

In this case, the cluster would have gone down if you lost two nodes.

![Diagram showing four cluster nodes, each of which gets a vote](media/understand-quorum/dynamic-quorum-base.png)

However, dynamic quorum prevents this from happening. The *total number of votes* required for quorum is now determined based on the number of nodes available. So, with dynamic quorum, the cluster will stay up even if you lose three nodes.

![Diagram showing four cluster nodes, with nodes failing one at a time, and the number of required votes adjusting after each failure.](media/understand-quorum/dynamic-quorum-step-through.png)

The above scenario applies to a general cluster that doesn't have Storage Spaces Direct enabled. However, when Storage Spaces Direct is enabled, the cluster can only support two node failures. This is explained more in the [pool quorum section](#pool-quorum-overview).

### Examples

#### Two nodes without a witness. 
One node’s vote is zeroed, so the *majority* vote is determined out of a total of **1 vote**. If the non-voting node goes down unexpectedly, the survivor has 1/1 and the cluster survives. If the voting node goes down unexpectedly, the survivor has 0/1 and the cluster goes down. If the voting node is gracefully powered down, the vote is transferred to the other node, and the cluster survives. ***This is why it's critical to configure a witness.***

![Quorum explained in the case with two nodes without a witness](media/understand-quorum/2-node-no-witness.png)

- Can survive one server failure: **Fifty percent chance**.
- Can survive one server failure, then another: **No**.
- Can survive two server failures at once: **No**. 

#### Two nodes with a witness. 
Both nodes vote, plus the witness votes, so the *majority* is determined out of a total of **3 votes**. If either node goes down, the survivor has 2/3 and the cluster survives.

![Quorum explained in the case with two nodes with a witness](media/understand-quorum/2-node-witness.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **No**.
- Can survive two server failures at once: **No**. 

#### Three nodes without a witness.
All nodes vote, so the *majority* is determined out of a total of **3 votes**. If any node goes down, the survivors are 2/3 and the cluster survives. The cluster becomes two nodes without a witness – at that point, you’re in Scenario 1.

![Quorum explained in the case with three nodes without a witness](media/understand-quorum/3-node-no-witness.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Fifty percent chance**.
- Can survive two server failures at once: **No**. 

#### Three nodes with a witness.
All nodes vote, so the witness doesn't initially vote. The *majority* is determined out of a total of **3 votes**. After one failure, the cluster has two nodes with a witness – which is back to Scenario 2. So, now the two nodes and the witness vote.

![Quorum explained in the case with three nodes with a witness](media/understand-quorum/3-node-witness.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Yes**.
- Can survive two server failures at once: **No**. 

#### Four nodes without a witness
One node’s vote is zeroed, so the *majority* is determined out of a total of **3 votes**. After one failure, the cluster becomes three nodes, and you’re in Scenario 3.

![Quorum explained in the case with four nodes without a witness](media/understand-quorum/4-node-no-witness.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Yes**.
- Can survive two server failures at once: **Fifty percent chance**. 

#### Four nodes with a witness.
All nodes votes and the witness votes, so the *majority* is determined out of a total of **5 votes**. After one failure, you’re in Scenario 4. After two simultaneous failures, you skip down to Scenario 2.

![Quorum explained in the case with four nodes with a witness](media/understand-quorum/4-node-witness.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Yes**.
- Can survive two server failures at once: **Yes**. 

#### Five nodes and beyond.
All nodes vote, or all but one vote, whatever makes the total odd. Storage Spaces Direct cannot handle more than two nodes down anyway, so at this point, no witness is needed or useful.

![Quorum explained in the case with five nodes and beyond](media/understand-quorum/5-nodes.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Yes**.
- Can survive two server failures at once: **Yes**. 

Now that we understand how quorum works, let's look at the types of quorum witnesses.

### Quorum witness types

Failover Clustering supports three types of Quorum Witnesses:

- **[Cloud Witness](../../failover-clustering/deploy-cloud-witness.md)** - Blob storage in Azure accessible by all nodes of the cluster. It maintains clustering information in a witness.log file, but doesn't store a copy of the cluster database.
- **File Share Witness** – A SMB file share that is configured on a file server running Windows Server. It maintains clustering information in a witness.log file, but doesn't store a copy of the cluster database.
- **Disk Witness** - A small clustered disk which is in the Cluster Available Storage group. This disk is highly-available and can failover between nodes. It contains a copy of the cluster database.  ***A Disk Witness isn't supported with Storage Spaces Direct***.

## Pool quorum overview

We just talked about Cluster Quorum, which operates at the cluster level. Now, let's dive into Pool Quorum, which operates on the pool level (i.e. you can lose nodes and drives and have the pool stay up). Storage pools were designed to be used in both clustered and non-clustered scenarios, which is why they have a different quorum mechanism.

The table below gives an overview of the Pool Quorum outcomes per scenario:

| Server nodes | Can survive one server node failure | Can survive one server node failure, then another | Can survive two simultaneous server node failures |
|--------------|-------------------------------------|---------------------------------------------------|----------------------------------------------------|
| 2            | No                                  | No                                                | No                                                 |
| 2 + Witness  | Yes                                 | No                                                | No                                                 |
| 3            | Yes                                 | No                                                | No                                                 |
| 3 + Witness  | Yes                                 | No                                                | No                                                 |
| 4            | Yes                                 | No                                                | No                                                 |
| 4 + Witness  | Yes                                 | Yes                                               | Yes                                                |
| 5 and above  | Yes                                 | Yes                                               | Yes                                                |

## How pool quorum works

When drives fail, or when some subset of drives loses contact with another subset, surviving drives need to verify that they constitute the *majority* of the pool to remain online. If they can’t verify that, they’ll go offline. The pool is the entity that goes offline or stays online based on whether it has enough disks for quorum (50% + 1). The pool resource owner (active cluster node) can be the +1.

But pool quorum works differently from cluster quorum in the following ways:

- the pool uses one node in the cluster as a witness as a tie-breaker to survive half of drives gone (this node that is the pool resource owner)
- the pool does NOT have dynamic quorum
- the pool does NOT implement its own version of removing a vote

### Examples

#### Four nodes with a symmetrical layout. 
Each of the 16 drives has one vote and node two also has one vote (since it's the pool resource owner). The *majority* is determined out of a total of **16 votes**. If nodes three and four go down, the surviving subset has 8 drives and the pool resource owner, which is 9/16 votes. So, the pool survives.

![Pool Quorum 1](media/understand-quorum/pool-1.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Yes**.
- Can survive two server failures at once: **Yes**. 

#### Four nodes with a symmetrical layout and drive failure. 
Each of the 16 drives has one vote and node 2 also has one vote (since it's the pool resource owner). The *majority* is determined out of a total of **16 votes**. First, drive 7 goes down. If nodes three and four go down, the surviving subset has 7 drives and the pool resource owner, which is 8/16 votes. So, the pool doesn't have majority and goes down.

![Pool Quorum 2](media/understand-quorum/pool-2.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **No**.
- Can survive two server failures at once: **No**. 

#### Four nodes with a non-symmetrical layout. 
Each of the 24 drives has one vote and node two also has one vote (since it's the pool resource owner). The *majority* is determined out of a total of **24 votes**. If nodes three and four go down, the surviving subset has 8 drives and the pool resource owner, which is 9/24 votes. So, the pool doesn't have majority and goes down.

![Pool Quorum 3](media/understand-quorum/pool-3.png)

- Can survive one server failure: **Yes**.
- Can survive one server failure, then another: **Depends **(cannot survive if both nodes three and four go down, but can survive all other scenarios.
- Can survive two server failures at once: **Depends **(cannot survive if both nodes three and four go down, but can survive all other scenarios.

### Pool quorum recommendations

- Ensure that each node in your cluster is symmetrical (each node has the same number of drives)
- Enable three-way mirror or dual parity so that you can tolerate a node failures and keep the virtual disks online. See our [volume guidance page](plan-volumes.md) for more details.
- If more than two nodes are down, or two nodes and a disk on another node are down, volumes may not have access to all three copies of their data, and therefore be taken offline and be unavailable. It’s recommended to bring the servers back or replace the disks quickly to ensure the most resiliency for all the data in the volume.

## More information

- [Configure and manage quorum](../../failover-clustering/manage-cluster-quorum.md)
- [Deploy a cloud witness](../../failover-clustering/deploy-cloud-witness.md)
