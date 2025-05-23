---
description: Learn more about Simplified SMB Multichannel and Multi-NIC Cluster Networks.
ms.assetid: a6343f1c-e9dd-4a02-91ad-39bd519d66cd
title: Simplified SMB Multichannel and Multi-NIC Cluster Networks
ms.topic: article
author: meaghanlewis
ms.author: mosagie
ms.date: 01/24/2025
---

# Simplified SMB Multichannel and Multi-NIC Cluster Networks

Simplified SMB Multichannel and Multi-Network Interface Card (NIC) Cluster Networks is a feature that enables the use of multiple NICs on the same cluster network subnet, and automatically enables SMB Multichannel.

Simplified SMB Multichannel and Multi-NIC Cluster Networks provide the following benefits:

- Failover Clustering automatically recognizes all NICs on nodes that are using the same switch / same subnet - no extra configuration needed.
- SMB Multichannel is enabled automatically.
- Networks that only have IPv6 Link Local (fe80) IP Addresses resources are recognized on cluster-only (private) networks.
- A single IP Address resource is configured on each Cluster Access Point (CAP) Network Name (NN) by default.
- Cluster validation no longer issues warning messages when multiple NICs are found on the same subnet.

## Prerequisites

- Multiple NICs per server, using the same switch / subnet.

## How to take advantage of multi-NIC clusters networks and simplified SMB multichannel

This section describes how to take advantage of the new multi-NIC clusters networks and simplified SMB multichannel features.

### Use at least two networks for Failover Clustering

Although it's rare, network switches can fail - it's still best practice to use at least two networks for Failover Clustering. All networks that are found are used for cluster heartbeats. Avoid using a single network for your Failover Cluster in order to avoid a single point of failure. Ideally, there are multiple physical communication paths between the nodes in the cluster, and no single point of failure.

![Illustration of two networks for Failover Clustering.](media/Simplified-SMB-Multichannel-and-Multi-NIC-Cluster-Networks/Clustering_MulitNIC_Fig1.png)

**Figure 1: Use at least two networks for Failover Clustering**

### Use Multiple NICs across clusters

Maximum benefit of the simplified SMB multichannel is achieved when multiple NICs are used across clusters - in both storage and storage workload clusters. This allows the workload clusters (Hyper-V, SQL Server Failover Cluster Instance, Storage Replica, etc.) to use SMB multichannel and results in more efficient use of the network. In a converged (also known as disaggregated) cluster configuration where a Scale-out File Server cluster is used for storing workload data for a Hyper-V or SQL Server Failover Cluster Instance cluster, this network is often called "the North-South subnet" / network. Many customers maximize throughput of this network by investing in RDMA capable NIC cards and switches.

![Illustration of a North-South SMB Subnet.](media/Simplified-SMB-Multichannel-and-Multi-NIC-Cluster-Networks/Clustering_MulitNIC_Fig2.png)

**Figure 2: To achieve maximum network throughput, use multiple NICs on both the Scale-out File Server cluster and the Hyper-V or SQL Server Failover Cluster Instance cluster - which share the North-South subnet**

![Screenshot of two clusters using multiple NICs in the same subnet to leverage SMB multichannel.](media/Simplified-SMB-Multichannel-and-Multi-NIC-Cluster-Networks/Clustering_MulitNIC_Fig3.png)

**Figure 3: Two clusters (Scale-out File Server for storage, SQL Server Failover Clustering Instance (FCI) for workload) both use multiple NICs in the same subnet to leverage SMB Multichannel and achieve better network throughput.**

## Automatic recognition of IPv6 Link Local private networks

When using more than one private (cluster only) network, check the IPv6 routing configuration to ensure that routing isn't configured to cross subnets, since this reduces network performance.

When using more than one private (cluster only) network, check the IPv6 routing configuration to ensure that routing isn't configured to cross subnets, since this reduces network performance.

![Screenshot of automatic network configuration in the Failover Cluster Manager UI.](media/Simplified-SMB-Multichannel-and-Multi-NIC-Cluster-Networks/Clustering_MulitNIC_Fig4.png)

**Figure 4: Automatic IPv6 Link Local (fe80) Address resource configuration**

## Throughput and Fault Tolerance

Windows Server 2016 and later automatically detect NIC capabilities and attempt to use each NIC in the fastest possible configuration. NICs that are teamed, NICs using RSS, and NICs with RDMA capability can all be used. The table below summarizes the trade-offs when using these technologies. Maximum throughput is achieved when using multiple RDMA capable NICs. For more information, see [The basics of SMB multichannel](/archive/blogs/josebda/the-basics-of-smb-multichannel-a-feature-of-windows-server-2012-and-smb-3-0).

![An illustration of throughput and fault tolerance for various NIC configurations.](media/Simplified-SMB-Multichannel-and-Multi-NIC-Cluster-Networks/Clustering_MulitNIC_Fig5.png)

**Figure 5: Throughput and fault tolerance for various NIC configurations**

## Frequently asked questions

**Are all NICs in a multi-NIC network used for cluster heart beating?**
    Either configuration works - all cluster network roles work on a multi-NIC network.

**Can a multi-NIC network be used for cluster communication only? Or can it only be used for client and cluster communication?**
    Yes, by default all cluster and CSV traffic use available multi-NIC networks. Administrators can use the Failover Clustering PowerShell cmdlets or Failover Cluster Manager UI to change the network role.

**Is SMB Multichannel also used for CSV and cluster traffic?**
    Yes, by default all cluster and CSV traffic use available multi-NIC networks. Administrators can use the Failover Clustering PowerShell cmdlets or Failover Cluster Manager UI to change the network role.

**How can I see the SMB Multichannel settings?**
    Use the **Get-SMBServerConfiguration** cmdlet, look for the value of the EnableMultiChannel property.

**Is the cluster common property PlumbAllCrossSubnetRoutes respected on a multi-NIC network?**
     Yes.
