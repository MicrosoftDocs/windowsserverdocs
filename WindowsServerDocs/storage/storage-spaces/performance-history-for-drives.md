---
title: Performance history for drives
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/01/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for drives in Storage Spaces Direct

> Applies To: Windows Server Insider Preview build 17090 and later

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for drives.

## Eligibility

Performance history is collected separately for every drive in the cluster storage subsystem. This excludes OS boot drives.

   > [!NOTE]
   > Performance history cannot be collected for drives in a server that is down. Collection resumes automatically when the server comes back up.

## Series names and units

These series are collected for every eligible drive:

| Series                        | Unit             |
|-------------------------------|------------------|
| physicaldisk.iops.read        | per second       |
| physicaldisk.iops.write       | per second       |
| physicaldisk.iops.total       | per second       |
| physicaldisk.throughput.read  | bytes per second |
| physicaldisk.throughput.write | bytes per second |
| physicaldisk.throughput.total | bytes per second |
| physicaldisk.latency.read     | seconds          |
| physicaldisk.latency.write    | seconds          |
| physicaldisk.latency.average  | seconds          |
| physicaldisk.size.total       | bytes            |
| physicaldisk.size.used        | bytes            |

## How to interpret

| Series                        | How to interpret                                                            |
|-------------------------------|-----------------------------------------------------------------------------|
| physicaldisk.iops.read        | Number of read operations per second completed by the drive.                |
| physicaldisk.iops.write       | Number of write operations per second completed by the drive.               |
| physicaldisk.iops.total       | Total number of read or write operations per second completed by the drive. |
| physicaldisk.throughput.read  | Quantity of data read from the drive per second.                            |
| physicaldisk.throughput.write | Quantity of data written to the drive per second.                           |
| physicaldisk.throughput.total | Total quantity of data read from or written to the drive per second.        |
| physicaldisk.latency.read     | Average latency of read operations from the drive.                          |
| physicaldisk.latency.write    | Average latency of write operations to the drive.                           |
| physicaldisk.latency.average  | Average latency of all operations to or from the drive.                     |
| physicaldisk.size.total       | The total storage capacity of the drive.                                    |
| physicaldisk.size.used        | The used storage capacity of the drive.                                     |

## Where they come from

The `iops.*`, `throughput.*`, and `latency.*` series are collected from the `Physical Disk` performance counter set on the server where the drive is connected, one instance per drive. These counters are measured by `partmgr.sys` and do not include much of the Windows software stack nor any network hops. They are representative of device hardware performance.

| Series                        | Source counter         |
|-------------------------------|------------------------|
| physicaldisk.iops.read        | Disk Reads/sec         |
| physicaldisk.iops.write       | Disk Writes/sec        |
| physicaldisk.iops.total       | Disk Transfers/sec     |
| physicaldisk.throughput.read  | Disk Read Bytes/sec    |
| physicaldisk.throughput.write | Disk Write Bytes/sec   |
| physicaldisk.throughput.total | Disk Bytes/sec         |
| physicaldisk.latency.read     | Avg. Disk sec/Read     |
| physicaldisk.latency.write    | Avg. Disk sec/Writes   |
| physicaldisk.latency.average  | Avg. Disk sec/Transfer |

The `size.*` series are collected from the `MSFT_PhysicalDisk` class in WMI, one instance per drive.

| Series                        | Source property |
|-------------------------------|-----------------|
| physicaldisk.size.total       | Size            |
| physicaldisk.size.used        | AllocatedSize   |

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
