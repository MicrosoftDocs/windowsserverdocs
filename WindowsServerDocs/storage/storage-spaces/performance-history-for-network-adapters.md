---
title: Performance history for network adapters
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/02/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for network adapters

> Applies to: Windows Server 2019

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for network adapters. Network adapter performance history is available for every physical network adapter in every server in the cluster. Remote Direct Memory Access (RDMA) performance history is available for every physical network adapter with RDMA enabled.

   > [!NOTE]
   > Performance history cannot be collected for network adapters in a server that is down. Collection will resume automatically when the server comes back up.

## Series names and units

These series are collected for every eligible network adapter:

| Series                               | Unit            |
|--------------------------------------|-----------------|
| `netadapter.bandwidth.inbound`       | bits per second |
| `netadapter.bandwidth.outbound`      | bits per second |
| `netadapter.bandwidth.total`         | bits per second |
| `netadapter.bandwidth.rdma.inbound`  | bits per second |
| `netadapter.bandwidth.rdma.outbound` | bits per second |
| `netadapter.bandwidth.rdma.total`    | bits per second |

   > [!NOTE]
   > Network adapter performance history is recorded in **bits** per second, not bytes per second. One 10 GbE network adapter can send and receive approximately 1,000,000,000 bits = 125,000,000 bytes = 1.25 GB per second at its theoretical maximum.

## How to interpret

| Series                               | How to interpret                                                      |
|--------------------------------------|-----------------------------------------------------------------------|
| `netadapter.bandwidth.inbound`       | Rate of data received by the network adapter.                         |
| `netadapter.bandwidth.outbound`      | Rate of data sent by the network adapter.                             |
| `netadapter.bandwidth.total`         | Total rate of data received or sent by the network adapter.           |
| `netadapter.bandwidth.rdma.inbound`  | Rate of data received over RDMA by the network adapter.               |
| `netadapter.bandwidth.rdma.outbound` | Rate of data sent over RDMA by the network adapter.                   |
| `netadapter.bandwidth.rdma.total`    | Total rate of data received or sent over RDMA by the network adapter. |

## Where they come from

The `bytes.*` series are collected from the `Network Adapter` performance counter set on the server where the network adapter is installed, one instance per network adapter.

| Series                           | Source counter           |
|----------------------------------|--------------------------|
| `netadapter.bandwidth.inbound`   | 8 × `Bytes Received/sec` |
| `netadapter.bandwidth.outbound`  | 8 × `Bytes Sent/sec`     |
| `netadapter.bandwidth.total`     | 8 × `Bytes Total/sec`    |

The `rdma.*` series are collected from the `RDMA Activity` performance counter set on the server where the network adapter is installed, one instance per network adapter with RDMA enabled.

| Series                               | Source counter           |
|--------------------------------------|--------------------------|
| `netadapter.bandwidth.rdma.inbound`  | 8 × `Inbound bytes/sec`  |
| `netadapter.bandwidth.rdma.outbound` | 8 × `Outbound bytes/sec` |
| `netadapter.bandwidth.rdma.total`    | 8 × *sum of the above*   |

   > [!NOTE]
   > Counters are measured over the entire interval, not sampled. For example, if the network adapter is idle for 9 seconds but transfers 200 bits in the 10th second, its `netadapter.bandwidth.total` will be recorded as 20 bits per second on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

## Usage in PowerShell

Use the [Get-NetAdapter](https://docs.microsoft.com/powershell/module/netadapter/get-netadapter) cmdlet:

```PowerShell
Get-NetAdapter <Name> | Get-ClusterPerf
```

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
