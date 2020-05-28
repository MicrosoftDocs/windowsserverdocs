---
title: Remove node from active failover cluster membership
description: This article addresses the issue of finding nodes removed from active failover cluster membership.
ms.prod: windows-server
ms.technology: server-general
ms.date: 05/28/2020
author: James.Burrage-msft
ms.author: James.Burrage
---
# Nodes being removed from Failover Cluster membership on VMWare ESX

Welcome to the AskCore blog. Today, we're going to talk about nodes being removed from active Failover Cluster membership when the nodes are hosted on VMWare ESX. I have documented node membership problems in a previous blog. For more information, see [Having a problem with nodes being removed from active Failover Cluster membership](/archive/blogs/askcore/having-a-problem-with-nodes-being-removed-from-active-failover-cluster-membership).

Here is a sample of the event, you will see in the System Event Log of the Event Viewer:

:::image type="content" source="media/nodes-failover-cluster-vmware/1135.png" alt-text="Event 1135" border="false":::

One specific problem that I have seen a few times lately is with the VMXNET3 adapters dropping inbound network packets because the inbound buffer is set too low to handle large amounts of traffic. We can easily find out if this is a problem by using Performance Monitor to look at the “Network Interface\Packets Received Discarded” counter.

:::image type="content" source="media/nodes-failover-cluster-vmware/0527.png" alt-text="Add Counters" border="false":::

Once you have added this counter, look at the Average, Minimum, and Maximum numbers and if they are any value higher than zero, then the receive buffer needs to be adjusted up for the adapter. This problem is documented in VMWare’s Knowledge Base: [Large packet loss at the guest OS level on the VMXNET3 vNIC in ESXi 5.x / 4.x](https://kb.vmware.com/s/article/2039495).
