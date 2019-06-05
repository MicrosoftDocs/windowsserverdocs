---
ms.assetid: f0d4cecc-5a03-448c-bef9-86c4730b4eb0
title: Virtual Machine Load Balancing overview
ms.prod: windows-server-threshold
ms.technology: storage-failover-clustering
ms.topic: article
author: bhattacharyaz
manager: eldenc 
ms.author: subhatt 
ms.date: 09/19/2016 
---
# Virtual Machine Load Balancing overview

> Applies to: Windows Server 2019, Windows Server 2016

A key consideration for private cloud deployments is the capital expenditure (<abbr title="capital expenditure">CapEx</abbr>) required to go into production. It is very common to add redundancy to private cloud deployments to avoid under-capacity during peak traffic in production, but this increases <abbr title="capital expenditure">CapEx</abbr>. The need for redundancy is driven by unbalanced private clouds where some nodes are hosting more Virtual Machines (<abbr title="virtual machines">VMs</abbr>) and others are underutilized (such as a freshly rebooted server).

<strong>Quick Video Overview</strong><br>(6 minutes)<br>
> [!VIDEO https://channel9.msdn.com/Blogs/windowsserver/Virtual-Machine-Load-Balancing-in-Windows-Server-2016/player]

## <a id="what-is-vm-load-balancing"></a>What is Virtual Machine Load Balancing?
<abbr title="Virtual machine">VM</abbr> Load Balancing is an in-box feature in Windows Server 2019 and Windows Server 2016 that allows you to optimize the utilization of nodes in a Failover Cluster. It identifies over-committed nodes and re-distributes <abbr title="virtual machines">VMs</abbr> from those nodes to under-committed nodes. Some of the salient aspects of this feature are as follows:

* *It is a zero-downtime solution*: <abbr title="Virtual machines">VMs</abbr> are live-migrated to idle nodes.
* *Seamless integration with your existing cluster environment*: Failure policies such as anti-affinity, fault domains and possible owners are honored.
* *Heuristics for balancing*: <abbr title="Virtual machine">VM</abbr> memory pressure and CPU utilization of the node.
* *Granular control*: Enabled by default. Can be activated on-demand or at a periodic interval.
* *Aggressiveness thresholds*: Three thresholds available based on the characteristics of your deployment.

## <a id="feature-in-action"></a>The feature in action
### <a id="new-node-added"></a>A new node is added to your Failover Cluster
![Graphic of a new node being added to your Failover Cluster](media/vm-load-balancing/overview-VM-load-balancing-1.png)

When you add new capacity to your Failover Cluster, the <abbr title="virtual machine">VM</abbr> Load Balancing feature automatically balances capacity from the existing nodes, to the newly added node in the following order:

1. The pressure is evaluated on the existing nodes in the Failover Cluster.
2. All nodes exceeding threshold are identified.
3. The nodes with the highest pressure are identified to determine priority of balancing.
4. <abbr title="Virtual machines">VMs</abbr> are Live Migrated (with no down time) from a node exceeding threshold to a newly added node in the Failover Cluster.

### <a id="recurring-load-balancing"></a>Recurring load balancing
![Graphic of a recurring VM load balancing](media/vm-load-balancing/overview-VM-load-balancing-2.png)

When configured for periodic balancing, the pressure on the cluster nodes is evaluated for balancing every 30 minutes. Alternately, the pressure can be evaluated on-demand. Here is the flow of the steps:

1. The pressure is evaluated on all nodes in the private cloud.
2. All nodes exceeding threshold and those below threshold are identified.
3. The nodes with the highest pressure are identified to determine priority of balancing.
4. <abbr title="Virtual machines">VMs</abbr> are Live Migrated (with no down time) from a node exceeding the threshold to node under minimum threshold.

## See Also
* [Virtual Machine Load Balancing Deep-Dive](vm-load-balancing-deep-dive.md)
* [Failover Clustering](failover-clustering-overview.md)
* [Hyper-V Overview](../virtualization/hyper-v/Hyper-V-on-Windows-Server.md)
