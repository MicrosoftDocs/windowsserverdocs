---
title: Performance history for servers
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/01/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for servers

> Applies To: Windows Server Insider Preview build 17090 and later

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for servers. Performance history is available for every server in the cluster.

   > [!NOTE]
   > Performance history cannot be collected for a server that is down. Collection will resume automatically when the server comes back up.

## Series names and units

These series are collected for every eligible server:

| Series                    | Unit    |
|---------------------------|---------|
| `node.cpu.usage`          | percent |
| `node.cpu.usage.guest`    | percent |
| `node.cpu.usage.host`     | percent |
| `node.memory.total`       | bytes   |
| `node.memory.available`   | bytes   |
| `node.memory.usage`       | bytes   |
| `node.memory.usage.guest` | bytes   |
| `node.memory.usage.host`  | bytes   |

In addition, drive series such as `physicaldisk.size.total` are aggregated for all eligible drives attached to the server, and network adapter series such as `networkadapter.bytes.total` are aggregated for all eligible network adapters attached to the server.

## How to interpret

| Series                    | How to interpret                                                      |
|---------------------------|-----------------------------------------------------------------------|
| `node.cpu.usage`          | Percentage of processor time that is not idle.                        |
| `node.cpu.usage.guest`    | Percentage of processor time used for guest (virtual machine) demand. |
| `node.cpu.usage.host`     | Percentage of processor time used for host demand.                    |
| `node.memory.total`       | The total physical memory of the server.                              |
| `node.memory.available`   | The available memory of the server.                                   |
| `node.memory.usage`       | The allocated (not available) memory of the server.                   |
| `node.memory.usage.guest` | The memory allocated to guest (virtual machine) demand.               |
| `node.memory.usage.host`  | The memory allocated to host demand.                                  |

## Where they come from

The `cpu.*` series are collected from different performance counters depending on whether or not Hyper-V is enabled.

If Hyper-V is enabled:

| Series                    | Source counter |
|---------------------------|----------------|
| `node.cpu.usage`          | `Hyper-V Hypervisor Logical Processor` > `_Total` > `% Total Run Time`      |
| `node.cpu.usage.guest`    | `Hyper-V Hypervisor Root Virtual Processor` > `_Total` > `% Total Run Time` |
| `node.cpu.usage.host`     | `Hyper-V Hypervisor Virtual Processor` > `_Total` > `% Total Run Time`      |

Using the `% Total Run Time` counters ensures that performance history attributes all usage, including any hypervisor overhead.

If Hyper-V is NOT enabled:

| Series                    | Source counter |
|---------------------------|----------------|
| `node.cpu.usage`          | `Processor` > `_Total` > `% Processor Time` |
| `node.cpu.usage.guest`    | *zero* |
| `node.cpu.usage.host`     | *same as total usage* |

Notwithstanding imperfect synchronization, `node.cpu.usage` is always `node.cpu.usage.host` plus `node.cpu.usage.guest`.

With the same caveat, `node.cpu.usage.guest` is always the sum of `virtualmachine.cpu.usage` for all virtual machines on the host server.

The `memory.*` series are (COMING SOON).

  > [!NOTE]
  > Counters are measured over the entire interval, not sampled. For example, if the server is idle for 9 seconds but spikes to 100% CPU in the 10th second, its `node.cpu.usage` will be recorded as 10% on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
