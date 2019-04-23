---
title: Performance history for virtual hard disks
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/09/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for virtual hard disks

> Applies to: Windows Server 2019

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for virtual hard disk (VHD) files. Performance history is available for every VHD attached to a running, clustered virtual machine. Performance history is available for both VHD and VHDX formats, however it is not available for Shared VHDX files.

   > [!NOTE]
   > It may take several minutes for collection to begin for newly created or moved VHD files.

## Series names and units

These series are collected for every eligible virtual hard disk:

| Series                    | Unit             |
|---------------------------|------------------|
| `vhd.iops.read`           | per second       |
| `vhd.iops.write`          | per second       |
| `vhd.iops.total`          | per second       |
| `vhd.throughput.read`     | bytes per second |
| `vhd.throughput.write`    | bytes per second |
| `vhd.throughput.total`    | bytes per second |
| `vhd.latency.average`     | seconds          |
| `vhd.size.current`        | bytes            |
| `vhd.size.maximum`        | bytes            |

## How to interpret

| Series                    | How to interpret                                                                                                 |
|---------------------------|------------------------------------------------------------------------------------------------------------------|
| `vhd.iops.read`           | Number of read operations per second completed by the virtual hard disk.                                         |
| `vhd.iops.write`          | Number of write operations per second completed by the virtual hard disk.                                        |
| `vhd.iops.total`          | Total number of read or write operations per second completed by the virtual hard disk.                          |
| `vhd.throughput.read`     | Quantity of data read from the virtual hard disk per second.                                                     |
| `vhd.throughput.write`    | Quantity of data written to the virtual hard disk per second.                                                    |
| `vhd.throughput.total`    | Total quantity of data read from or written to the virtual hard disk per second.                                 |
| `vhd.latency.average`     | Average latency of all operations to or from the virtual hard disk.                                              |
| `vhd.size.current`        | The current file size of the virtual hard disk, if dynamically expanding. If fixed, the series is not collected. |
| `vhd.size.maximum`        | The maximum size of the virtual hard disk, if dynamically expanding. If fixed, the is the size.                  |

## Where they come from

The `iops.*`, `throughput.*`, and `latency.*` series are collected from the `Hyper-V Virtual Storage Device` performance counter set on the server where the virtual machine is running, one instance per VHD or VHDX.

| Series                    | Source counter         |
|---------------------------|------------------------|
| `vhd.iops.read`           | `Read Operations/Sec`  |
| `vhd.iops.write`          | `Write Operations/Sec` |
| `vhd.iops.total`          | *sum of the above*     |
| `vhd.throughput.read`     | `Read Bytes/sec`       |
| `vhd.throughput.write`    | `Write Bytes/sec`      |
| `vhd.throughput.total`    | *sum of the above*     |
| `vhd.latency.average`     | `Latency`              |

   > [!NOTE]
   > Counters are measured over the entire interval, not sampled. For example, if the VHD is inactive for 9 seconds but completes 30 IOs in the 10th second, its `vhd.iops.total` will be recorded as 3 IOs per second on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

## Usage in PowerShell

Use the [Get-VHD](https://docs.microsoft.com/powershell/module/hyper-v/get-vhd) cmdlet:

```PowerShell
Get-VHD <Path> | Get-ClusterPerf
```

To get the path of every VHD from the virtual machine:

```PowerShell
(Get-VM <Name>).HardDrives | Select Path
```

   > [!NOTE]
   > The Get-VHD cmdlet requires a file path to be provided. It does not support enumeration.

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
