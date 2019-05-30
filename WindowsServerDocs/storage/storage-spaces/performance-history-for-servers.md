---
title: Performance history for servers
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/0s/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for servers

> Applies to: Windows Server 2019

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for servers. Performance history is available for every server in the cluster.

   > [!NOTE]
   > Performance history cannot be collected for a server that is down. Collection will resume automatically when the server comes back up.

## Series names and units

These series are collected for every eligible server:

| Series                           | Unit    |
|----------------------------------|---------|
| `clusternode.cpu.usage`          | percent |
| `clusternode.cpu.usage.guest`    | percent |
| `clusternode.cpu.usage.host`     | percent |
| `clusternode.memory.total`       | bytes   |
| `clusternode.memory.available`   | bytes   |
| `clusternode.memory.usage`       | bytes   |
| `clusternode.memory.usage.guest` | bytes   |
| `clusternode.memory.usage.host`  | bytes   |

In addition, drive series such as `physicaldisk.size.total` are aggregated for all eligible drives attached to the server, and network adapter series such as `networkadapter.bytes.total` are aggregated for all eligible network adapters attached to the server.

## How to interpret

| Series                           | How to interpret                                                      |
|----------------------------------|-----------------------------------------------------------------------|
| `clusternode.cpu.usage`          | Percentage of processor time that is not idle.                        |
| `clusternode.cpu.usage.guest`    | Percentage of processor time used for guest (virtual machine) demand. |
| `clusternode.cpu.usage.host`     | Percentage of processor time used for host demand.                    |
| `clusternode.memory.total`       | The total physical memory of the server.                              |
| `clusternode.memory.available`   | The available memory of the server.                                   |
| `clusternode.memory.usage`       | The allocated (not available) memory of the server.                   |
| `clusternode.memory.usage.guest` | The memory allocated to guest (virtual machine) demand.               |
| `clusternode.memory.usage.host`  | The memory allocated to host demand.                                  |

## Where they come from

The `cpu.*` series are collected from different performance counters depending on whether or not Hyper-V is enabled.

If Hyper-V is enabled:

| Series                           | Source counter |
|----------------------------------|----------------|
| `clusternode.cpu.usage`          | `Hyper-V Hypervisor Logical Processor` > `_Total` > `% Total Run Time`      |
| `clusternode.cpu.usage.guest`    | `Hyper-V Hypervisor Virtual Processor` > `_Total` > `% Total Run Time`      |
| `clusternode.cpu.usage.host`     | `Hyper-V Hypervisor Root Virtual Processor` > `_Total` > `% Total Run Time` |

Using the `% Total Run Time` counters ensures that performance history attributes all usage.

If Hyper-V is NOT enabled:

| Series                           | Source counter |
|----------------------------------|----------------|
| `clusternode.cpu.usage`          | `Processor` > `_Total` > `% Processor Time` |
| `clusternode.cpu.usage.guest`    | *zero* |
| `clusternode.cpu.usage.host`     | *same as total usage* |

Notwithstanding imperfect synchronization, `clusternode.cpu.usage` is always `clusternode.cpu.usage.host` plus `clusternode.cpu.usage.guest`.

With the same caveat, `clusternode.cpu.usage.guest` is always the sum of `vm.cpu.usage` for all virtual machines on the host server.

The `memory.*` series are (COMING SOON).

  > [!NOTE]
  > Counters are measured over the entire interval, not sampled. For example, if the server is idle for 9 seconds but spikes to 100% CPU in the 10th second, its `clusternode.cpu.usage` will be recorded as 10% on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

## Usage in PowerShell

Use the [Get-ClusterNode](https://docs.microsoft.com/powershell/module/failoverclusters/get-clusternode) cmdlet:

```PowerShell
Get-ClusterNode <Name> | Get-ClusterPerf
```

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
