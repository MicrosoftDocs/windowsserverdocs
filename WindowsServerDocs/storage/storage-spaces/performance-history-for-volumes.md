---
title: Performance history for volumes
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/09/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for volumes

> Applies to: Windows Server 2019

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for volumes. Performance history is available for every Cluster Shared Volume (CSV) in the cluster. However, it is not available for OS boot volumes nor any other non-CSV storage.

   > [!NOTE]
   > It may take several minutes for collection to begin for newly created or renamed volumes.

## Series names and units

These series are collected for every eligible volume:

| Series                    | Unit             |
|---------------------------|------------------|
| `volume.iops.read`        | per second       |
| `volume.iops.write`       | per second       |
| `volume.iops.total`       | per second       |
| `volume.throughput.read`  | bytes per second |
| `volume.throughput.write` | bytes per second |
| `volume.throughput.total` | bytes per second |
| `volume.latency.read`     | seconds          |
| `volume.latency.write`    | seconds          |
| `volume.latency.average`  | seconds          |
| `volume.size.total`       | bytes            |
| `volume.size.available`   | bytes            |

## How to interpret

| Series                    | How to interpret                                                              |
|---------------------------|-------------------------------------------------------------------------------|
| `volume.iops.read`        | Number of read operations per second completed by this volume.                |
| `volume.iops.write`       | Number of write operations per second completed by this volume.               |
| `volume.iops.total`       | Total number of read or write operations per second completed by this volume. |
| `volume.throughput.read`  | Quantity of data read from this volume per second.                            |
| `volume.throughput.write` | Quantity of data written to this volume per second.                           |
| `volume.throughput.total` | Total quantity of data read from or written to this volume per second.        |
| `volume.latency.read`     | Average latency of read operations from this volume.                          |
| `volume.latency.write`    | Average latency of write operations to this volume.                           |
| `volume.latency.average`  | Average latency of all operations to or from this volume.                     |
| `volume.size.total`       | The total storage capacity of the volume.                                     |
| `volume.size.available`   | The available storage capacity of the volume.                                 |

## Where they come from

The `iops.*`, `throughput.*`, and `latency.*` series are collected from the `Cluster CSVFS` performance counter set. Every server in the cluster has an instance for every CSV volume, regardless of ownership. The performance history recorded for volume `MyVolume` is the aggregate of the `MyVolume` instances on every server in the cluster.

| Series                    | Source counter         |
|---------------------------|------------------------|
| `volume.iops.read`        | `Reads/sec`            |
| `volume.iops.write`       | `Writes/sec`           |
| `volume.iops.total`       | *sum of the above*     |
| `volume.throughput.read`  | `Read bytes/sec`       |
| `volume.throughput.write` | `Write bytes/sec`      |
| `volume.throughput.total` | *sum of the above*     |
| `volume.latency.read`     | `Avg. sec/Read`        |
| `volume.latency.write`    | `Avg. sec/Write`       |
| `volume.latency.average`  | *average of the above* |

   > [!NOTE]
   > Counters are measured over the entire interval, not sampled. For example, if the volume is idle for 9 seconds but completes 30 IOs in the 10th second, its `volume.iops.total` will be recorded as 3 IOs per second on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

   > [!TIP]
   > These are the same counters used by the popular [VM Fleet](https://github.com/Microsoft/diskspd/blob/master/Frameworks/VMFleet/watch-cluster.ps1) benchmark framework.

The `size.*` series are collected from the `MSFT_Volume` class in WMI, one instance per volume.

| Series                    | Source property |
|---------------------------|-----------------|
| `volume.size.total`       | `Size`          |
| `volume.size.available`   | `SizeRemaining` |

## Usage in PowerShell

Use the [Get-Volume](https://docs.microsoft.com/powershell/module/storage/get-volume) cmdlet:

```PowerShell
Get-Volume -FriendlyName <FriendlyName> | Get-ClusterPerf
```

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
