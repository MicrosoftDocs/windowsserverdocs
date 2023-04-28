---
title: Remove node from active failover cluster membership
ms.topic: troubleshooting
description: This article addresses the issue of finding nodes removed from active failover cluster membership.
author: Deland-Han
ms.author: delhan
ms.date: 01/06/2023
---
# Nodes being removed from Failover Cluster membership on VMware ESX

Applies to Windows Server (All supported versions)

This article addresses the issue of finding nodes removed from active failover cluster membership when the nodes are hosted on VMware ESX.

## Symptom

You see the following event in the System Event Log of the Event Viewer when this issue occurs:

![Event 1135](media/nodes-failover-cluster-vmware/1135.png)

## Resolution

One specific problem is with the VMXNET3 adapters dropping inbound network packets because the inbound buffer is set too low to handle large amounts of traffic. You easily can find out if packets are being drop by using Performance Monitor to look at the “Network Interface\Packets Received Discarded” counter.

![Add Counters](media/nodes-failover-cluster-vmware/0527.png)

After you've added this counter, look at the Average, Minimum, and Maximum numbers. If the values are higher than zero, then the receive buffer needs to be adjusted upward for the adapter. This problem is documented in VMware’s Knowledge Base: [Large packet loss at the guest OS level on the VMXNET3 vNIC in ESXi 5.x / 4.x](https://kb.vmware.com/s/article/2039495).
