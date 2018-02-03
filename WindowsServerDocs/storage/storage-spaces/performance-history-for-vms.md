---
title: Performance history for virtual machines
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/02/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Performance history for virtual machines

> Applies To: Windows Server Insider Preview

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for virtual machines (VM). Performance history is available for every running, clustered VM.

## Series names and units

These series are collected for every eligible VM:

| Series                                 | Unit             |
|----------------------------------------|------------------|
| `virtualmachine.cpu.usage`             | percent          |
| `virtualmachine.memory.assigned`       | bytes            |
| `virtualmachine.memory.available`      | bytes            |
| `virtualmachine.memory.maximum`        | bytes            |
| `virtualmachine.memory.minimum`        | bytes            |
| `virtualmachine.memory.pressure`       | -                |
| `virtualmachine.memory.startup`        | bytes            |
| `virtualmachine.memory.total`          | bytes            |
| `virtualnetworkadapter.bytes.inbound`  | bytes per second |
| `virtualnetworkadapter.bytes.outbound` | bytes per second |
| `virtualnetworkadapter.bytes.total`    | bytes per second |

In addition, all virtual hard disk (VHD) series, such as `vhd.iops.total`, are aggregated for every VHD attached to the VM.

## How to interpret

| Series                                 | Description                                                                                                  |
|----------------------------------------|--------------------------------------------------------------------------------------------------------------|
| `virtualmachine.cpu.usage`             | Percentage the virtual machine is using of its host server's processor(s).                                   |
| `virtualmachine.memory.assigned`       | The quantity of memory assigned to the virtual machine.                                                      |
| `virtualmachine.memory.available`      | The quantity of memory that remains available, of the amount assigned.                                       |
| `virtualmachine.memory.maximum`        | If using dynamic memory, this is the maximum quantity of memory that may be assigned to the virtual machine. |
| `virtualmachine.memory.minimum`        | If using dynamic memory, this is the minimum quantity of memory that may be assigned to the virtual machine. |
| `virtualmachine.memory.pressure`       | The ratio of memory demanded by the virtual machine over memory allocated to the virtual machine.            |
| `virtualmachine.memory.startup`        | The quantity of memory required for the virtual machine to start.                                            |
| `virtualmachine.memory.total`          | Total memory. |
| `virtualnetworkadapter.bytes.inbound`  | Rate of data received by the virtual machine across all its virtual network adapters.                        |
| `virtualnetworkadapter.bytes.outbound` | Rate of data sent by the virtual machine across all its virtual network adapters.                            |
| `virtualnetworkadapter.bytes.total`    | Total rate of data received or sent by the virtual machine across all its virtual network adapters.          |

## See also

- [Performance history for Storage Spaces Direct](performance-history.md)
