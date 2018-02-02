---
title: Performance history for network adapters
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/01/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for network adapters in Storage Spaces Direct

> Applies To: Windows Server Insider Preview build 17090 and later

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for network adapters. Network adapter performance history is available for every physical network adapter in every server in the cluster. Remote Direct Memory Access (RDMA) performance history is available for every physical network adapter with RDMA enabled.

   > [!NOTE]
   > Performance history cannot be collected for network adapters in a server that is down. Collection will resume automatically when the server comes back up.

## Series names and units

These series are collected for every eligible network adapter:

| Series                             | Unit             |
|------------------------------------|------------------|
| networkadapter.bytes.inbound       | bytes per second |
| networkadapter.bytes.outbound      | bytes per second |
| networkadapter.bytes.total         | bytes per second |
| networkadapter.bytes.rdma.inbound  | bytes per second |
| networkadapter.bytes.rdma.outbound | bytes per second |
| networkadapter.bytes.rdma.total    | bytes per second |

   > [!NOTE]
   > Network adapter performance history is recorded in bytes per second, not bits per second. One 10 GbE network adapter can send and receive approximately 1,000,000,000 bits = 125,000,000 bytes = 1.25 GB per second at its theoretical maximum.

## How to interpret

| Series                             | How to interpret                                                                                   |
|------------------------------------|----------------------------------------------------------------------------------------------------|
| networkadapter.bytes.inbound       | Rate of data received by the network adapter.                                                      |
| networkadapter.bytes.outbound      | Rate of data sent by the network adapter.                                                          |
| networkadapter.bytes.total         | Total rate of data received or sent by the network adapter.                                        |
| networkadapter.bytes.rdma.inbound  | Rate of data received via remote direct memory access (RDMA) by the network adapter.               |
| networkadapter.bytes.rdma.outbound | Rate of data sent via remote direct memory access (RDMA) by the network adapter.                   |
| networkadapter.bytes.rdma.total    | Total rate of data received or sent via remote direct memory access (RDMA) by the network adapter. |

## Where they come from

The `bytes.*` series are collected from the `Network Adapter` performance counter set on the server where the network adapter is installed, one instance per network adapter.

| Series                             | Source counter     |
|------------------------------------|--------------------|
| networkadapter.bytes.inbound       | Bytes Received/sec |
| networkadapter.bytes.outbound      | Bytes Sent/sec     |
| networkadapter.bytes.total         | Bytes Total/sec    |

The `rdma.*` series are collected from the `RDMA Activity` performance counter set on the server where the network adapter is installed, one instance per network adapter with RDMA enabled.

| Series                             | Source counter     |
|------------------------------------|--------------------|
| networkadapter.bytes.rdma.inbound  | Inbound bytes/sec  |
| networkadapter.bytes.rdma.outbound | Outbound bytes/sec |
| networkadapter.bytes.rdma.total    | *sum of the above* |

   > [!NOTE]
   > Counters are measured over the entire interval, not sampled. For example, if the network adapter is idle for 9 seconds but transfers 30 bytes in the 10th second, its `networkadapter.bytes.total` will be recorded as 3 bytes per second on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
