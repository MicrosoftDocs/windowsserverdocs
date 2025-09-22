---
description: "Learn more about: Performance history for virtual machines"
title: Performance history for virtual machines
ms.author: roharwoo
ms.topic: concept-article
author: robinharwood
ms.date: 09/07/2018
appliesto: [
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
			"✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
		   ]
---

# Performance history for virtual machines

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes in detail the performance history collected for virtual machines (VM). Performance history is available for every running, clustered VM.

   > [!NOTE]
   > It may take several minutes for collection to begin for newly created or renamed VMs.

## Series names and units

These series are collected for every eligible VM:

| Series                            | Unit             |
|-----------------------------------|------------------|
| `vm.cpu.usage`                    | percent          |
| `vm.memory.assigned`              | bytes            |
| `vm.memory.available`             | bytes            |
| `vm.memory.maximum`               | bytes            |
| `vm.memory.minimum`               | bytes            |
| `vm.memory.pressure`              | -                |
| `vm.memory.startup`               | bytes            |
| `vm.memory.total`                 | bytes            |
| `vmnetworkadapter.bandwidth.inbound`  | bits per second |
| `vmnetworkadapter.bandwidth.outbound` | bits per second |
| `vmnetworkadapter.bandwidth.total`    | bits per second |

In addition, all virtual hard disk (VHD) series, such as `vhd.iops.total`, are aggregated for every VHD attached to the VM.

## How to interpret


| Series                            | Description                                                                                                  |
|-----------------------------------|--------------------------------------------------------------------------------------------------------------|
| `vm.cpu.usage`                    | Percentage the virtual machine is using of its host server's processor(s).                                   |
| `vm.memory.assigned`              | The quantity of memory assigned to the virtual machine.                                                      |
| `vm.memory.available`             | The quantity of memory that remains available, of the amount assigned.                                       |
| `vm.memory.maximum`               | If using dynamic memory, this is the maximum quantity of memory that may be assigned to the virtual machine. |
| `vm.memory.minimum`               | If using dynamic memory, this is the minimum quantity of memory that may be assigned to the virtual machine. |
| `vm.memory.pressure`              | The ratio of memory demanded by the virtual machine over memory allocated to the virtual machine.            |
| `vm.memory.startup`               | The quantity of memory required for the virtual machine to start.                                            |
| `vm.memory.total`                 | Total memory. |
| `vmnetworkadapter.bandwidth.inbound`  | Rate of data received by the virtual machine across all its virtual network adapters.                        |
| `vmnetworkadapter.bandwidth.outbound` | Rate of data sent by the virtual machine across all its virtual network adapters.                            |
| `vmnetworkadapter.bandwidth.total`    | Total rate of data received or sent by the virtual machine across all its virtual network adapters.          |

   > [!NOTE]
   > Counters are measured over the entire interval, not sampled. For example, if the VM is idle for 9 seconds but spikes to use 50% of host CPU in the 10th second, its `vm.cpu.usage` will be recorded as 5% on average during this 10-second interval. This ensures its performance history captures all activity and is robust to noise.

## Usage in PowerShell

Use the [Get-VM](/powershell/module/hyper-v/get-vm) cmdlet:

```PowerShell
Get-VM <Name> | Get-ClusterPerf
```

   > [!NOTE]
   > The Get-VM cmdlet only returns virtual machines on the local (or specified) server, not across the cluster.

## Additional References

- [Performance history for Storage Spaces Direct](performance-history.md)

