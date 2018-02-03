---
title: Performance history for virtual hard disks
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/01/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for virtual hard disks

> Applies To: Windows Server Insider Preview build 17090 and later

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for virtual hard disk (VHD) files. Performance history is available for every VHD attached to a running, clustered virtual machine. Performance history is available for both VHD and VHDX formats, however it is not available for Shared VHDX files.

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

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
