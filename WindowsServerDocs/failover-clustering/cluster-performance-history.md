---
title: Cluster performance history
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 01/09/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---

# Cluster performance history

> Applies To: Windows Server Insider Preview

Cluster performance history is a new feature available for [Storage Spaces Direct](..\storage\storage-spaces\storage-spaces-direct-overview.md) that can collect, store, and provide cmdlets to query performance history.

   > [!IMPORTANT]
   > This feature is available in Windows Server Insider Preview only. It is not available in Windows Server 2016.

## Getting started

All you need is [Storage Spaces Direct](..\storage\storage-spaces\storage-spaces-direct-overview.md) in Windows Server Insider Preview build 123.456 or later. There is nothing additional to install, configure, or start.

To opt out, use the **-CollectPerformanceHistory** parameter of the **Enable-ClusterStorageSpacesDirect** cmdlet:

```PowerShell
Enable-ClusterS2D -CollectPerformanceHistory $False
```

## What's collected

### Objects

Performance history is collected for these 7 types of objects:

- Drive
- Network adapter
- Server
- Virtual machine
- Virtual hard disk
- Volume
- Cluster

### Timeframes

New measurements are taken every *interval* and stored for *retention* period. For example, one measurement every 10 seconds for 1 hour gives 360 total measurements in the *Last hour* timeframe.

| Timeframe  | Interval   | Retention | Total measurements |
|------------|------------|-----------|--------------------|
| Last hour  | 10 secs    | 1 hour    | 360                |
| Last day   | 5 minutes  | 25 hours  | 300                |
| Last week  | 15 minutes | 8 days    | 768                |
| Last month | 1 hour     | 35 days   | 840                |
| Last year  | Daily      | 400 days  | 400                |

### Series

Over 40 unique series provide broad and deep visibility into compute and memory usage, network activity, storage activity, storage capacity, and more. What's more, many series are aggregated to multiple scopes. For example, the **networkadapter.bytes.total** series is collected for each network adapter individually as well as aggregated to the overall server; likewise, the **node.cpu.usage** series is collected for each server individually as well as aggregated to the overall cluster; and so on.

#### Drive

The following series are collected for each drive:

| Series                        | Unit             | Description                                                                 |
|-------------------------------|------------------|-----------------------------------------------------------------------------|
| physicaldisk.iops.read        | per second       | Number of read operations per second completed by the drive.                |
| physicaldisk.iops.write       | per second       | Number of write operations per second completed by the drive.               |
| physicaldisk.iops.total       | per second       | Total number of read or write operations per second completed by the drive. |
| physicaldisk.throughput.read  | bytes per second | Quantity of data read from the drive per second.                            |
| physicaldisk.throughput.write | bytes per second | Quantity of data written to the drive per second.                           |
| physicaldisk.throughput.total | bytes per second | Total quantity of data read from or written to the drive per second.        |
| physicaldisk.latency.read     | seconds          | Average latency of read operations from the drive.                          |
| physicaldisk.latency.write    | seconds          | Average latency of write operations to the drive.                           |
| physicaldisk.latency.average  | seconds          | Average latency of all operations to or from the drive.                     |
| physicaldisk.size.total       | bytes            | The total storage capacity of the drive.                                    |
| physicaldisk.size.used        | bytes            | The used storage capacity of the drive.                                     |

   > [!NOTE]
   > Performance history is only collected for drives in the cluster storage subsystem. This excludes the OS boot drive in each server. Performance history cannot be collected for drives in a server that is down. Collection resumes automatically when the server comes back up.

#### Network adapter

The following series are collected for each network adapter:

| Series                             | Unit             | Description                                                                                        |
|------------------------------------|------------------|----------------------------------------------------------------------------------------------------|
| networkadapter.bytes.inbound       | bytes per second | Rate of data received by the network adapter.                                                      |
| networkadapter.bytes.outbound      | bytes per second | Rate of data sent by the network adapter.                                                          |
| networkadapter.bytes.total         | bytes per second | Total rate of data received or sent by the network adapter.                                        |
| networkadapter.bytes.rdma.inbound  | bytes per second | Rate of data received via remote direct memory access (RDMA) by the network adapter.               |
| networkadapter.bytes.rdma.outbound | bytes per second | Rate of data sent via remote direct memory access (RDMA) by the network adapter.                   |
| networkadapter.bytes.rdma.total    | bytes per second | Total rate of data received or sent via remote direct memory access (RDMA) by the network adapter. |

   > [!NOTE]
   > Network adapter performance history is only collected for physical network adapters. Remote Direct Memory Access (RDMA) performance history is only collected for network adapters with RDMA enabled.

   > [!NOTE]
   > Network adapter performance history is recorded in bytes per second, not bits per second. One 10 GbE network adapter can send and receive approximately 1,000,000,000 bits = 125,000,000 bytes = 1.25 GB per second at its theoretical maximum.

#### Server

All network adapter series, such as **networkadapter.bytes.total**, are aggregated for all network adapters attached to the server. Drive capacity series, such as **physicaldisk.size.total**, are aggregated for all drives attached to the server.  In addition, the following series are collected for each server:

| Series                  | Unit    | Description                                                           |
|-------------------------|---------|-----------------------------------------------------------------------|
| node.cpu.usage          | percent | Percentage of processor time that is not idle.                        |
| node.cpu.usage.guest    | percent | Percentage of processor time used for guest (virtual machine) demand. |
| node.cpu.usage.host     | percent | Percentage of processor time used for host demand.                    |
| node.memory.total       | bytes   | The total physical memory of the server.                              |
| node.memory.available   | bytes   | The available memory of the server.                                   |
| node.memory.usage       | bytes   | The allocated (not available) memory of the server.                   |
| node.memory.usage.guest | bytes   | The memory allocated to guest (virtual machine) demand.               |
| node.memory.usage.host  | bytes   | The memory allocated to host demand.                                  |

   > [!NOTE]
   > Performance history cannot be collected for a server that is down. Collection resumes automatically when the server comes back up.

#### Virtual hard disk (VHD)

The following series are collected for each virtual hard disk file:

| Series                  | Unit             | Description                                                                                                      |
|-------------------------|------------------|------------------------------------------------------------------------------------------------------------------|
| vhd.iops.read           | per second       | Number of read operations per second completed by the virtual hard disk.                                         |
| vhd.iops.write          | per second       | Number of write operations per second completed by the virtual hard disk.                                        |
| vhd.iops.total          | per second       | Total number of read or write operations per second completed by the virtual hard disk.                          |
| vhd.throughput.read     | bytes per second | Quantity of data read from the virtual hard disk per second.                                                     |
| vhd.throughput.write    | bytes per second | Quantity of data written to the virtual hard disk per second.                                                    |
| vhd.throughput.total    | bytes per second | Total quantity of data read from or written to the virtual hard disk per second.                                 |
| vhd.latency.average     | seconds          | Average latency of all operations to or from the virtual hard disk.                                              |
| vhd.size.current        | bytes            | The current file size of the virtual hard disk, if dynamically expanding. If fixed, the series is not collected. |
| vhd.size.maximum        | bytes            | The maximum size of the virtual hard disk, if dynamically expanding. If fixed, the is the size.                  |

   > [!NOTE]
   > Virtual hard disk performance history is only collected for VHDs attached to running, clustered virtual machines. Although performance history is collected for both VHD and VHDX formats, it is not collected for shared VHDX files – yet.

#### Virtual machine (VM)

All virtual hard disk series, such as **vhd.iops.total**, are aggregated for all VHDs attached to the virtual machine. In addition, the following series are collected for each virtual machine:

| Series                               | Unit             | Description                                                                                                  |
|--------------------------------------|------------------|--------------------------------------------------------------------------------------------------------------|
| virtualmachine.cpu.usage             | percent          | Percentage the virtual machine is using of its host server's processor(s).                                   |
| virtualmachine.memory.assigned       | bytes            | The quantity of memory assigned to the virtual machine.                                                      |
| virtualmachine.memory.available      | bytes            | The quantity of memory that remains available, of the amount assigned.                                       |
| virtualmachine.memory.maximum        | bytes            | If using dynamic memory, this is the maximum quantity of memory that may be assigned to the virtual machine. |
| virtualmachine.memory.minimum        | bytes            | If using dynamic memory, this is the minimum quantity of memory that may be assigned to the virtual machine. |
| virtualmachine.memory.pressure       | -                | The ratio of memory demanded by the virtual machine over memory allocated to the virtual machine.            |
| virtualmachine.memory.startup        | bytes            | The quantity of memory required for the virtual machine to start.                                            |
| virtualmachine.memory.total          | bytes            | Total memory. |
| virtualnetworkadapter.bytes.inbound  | bytes per second | Rate of data received by the virtual machine across all its virtual network adapters.                        |
| virtualnetworkadapter.bytes.outbound | bytes per second | Rate of data sent by the virtual machine across all its virtual network adapters.                            |
| virtualnetworkadapter.bytes.total    | bytes per second | Total rate of data received or sent by the virtual machine across all its virtual network adapters.          |

   > [!NOTE]
   > Virtual machine performance history is only collected for running, clustered virtual machines.

#### Volume

The following series are collected for each volume:

| Series                  | Unit             | Description                                                                   |
|-------------------------|------------------|-------------------------------------------------------------------------------|
| volume.iops.read        | per second       | Number of read operations per second completed by this volume.                |
| volume.iops.write       | per second       | Number of write operations per second completed by this volume.               |
| volume.iops.total       | per second       | Total number of read or write operations per second completed by this volume. |
| volume.throughput.read  | bytes per second | Quantity of data read from this volume per second.                            |
| volume.throughput.write | bytes per second | Quantity of data written to this volume per second.                           |
| volume.throughput.total | bytes per second | Total quantity of data read from or written to this volume per second.        |
| volume.latency.read     | seconds          | Average latency of read operations from this volume.                          |
| volume.latency.write    | seconds          | Average latency of write operations to this volume.                           |
| volume.latency.average  | seconds          | Average latency of all operations to or from this volume.                     |
| volume.size.total       | bytes            | The total storage capacity of the volume.                                     |
| volume.size.available   | bytes            | The available storage capacity of the volume.                                 |

   > [!NOTE]
   > Volume performance history is only collected for Cluster Shared Volume (CSV) instances. This excludes the OS boot volume in each server and any other non-CSV storage. It may take several minutes for collection to begin for newly created or renamed volumes.

#### Cluster

All server series, such as **node.cpu.usage**, are aggregated for all servers in the cluster. All volume series, such as **volume.iops.total**, are aggregated for all volumes in the cluster. And drive capacity series, such as **physicaldisk.size.total**, are aggregated for all drives in the cluster.

## Usage in PowerShell

See cluster performance history in PowerShell with the **Get-ClusterPerformanceHistory** cmdlet. Optionally, you can specify the object, timeframe, and/or series you want.

   > [!TIP]
   > Use the **Get-ClusterPerf** alias to save some keystrokes.

### Specify the object

Specify an object via the pipeline to see its performance history. This works with 7 object types:

#### Drive

Use the [Get-PhysicalDisk](https://docs.microsoft.com/powershell/module/storage/get-physicaldisk) cmdlet:

```PowerShell
Get-PhysicalDisk -SerialNumber <SerialNumber> | Get-ClusterPerf
```

#### Network adapter

Use the [Get-NetAdapter](https://docs.microsoft.com/powershell/module/netadapter/get-netadapter) cmdlet:

```PowerShell
Get-NetAdapter <Name> | Get-ClusterPerf
```

#### Server

Use the [Get-ClusterNode](https://docs.microsoft.com/powershell/module/failoverclusters/get-clusternode) cmdlet:

```PowerShell
Get-ClusterNode <Name> | Get-ClusterPerf
```

#### Virtual hard disk (VHD)

Use the [Get-VHD](https://docs.microsoft.com/powershell/module/hyper-v/get-vhd) cmdlet:

```PowerShell
Get-VHD <Path> | Get-ClusterPerf
```

To get the path of every virtual hard disk from the virtual machine:

```PowerShell
(Get-VM <Name>).HardDrives | Select Path
```

   > [!NOTE]
   > The Get-VHD cmdlet requires a file path to be provided.

#### Virtual machine (VM)

Use the [Get-VM](https://docs.microsoft.com/powershell/module/hyper-v/get-vm) cmdlet:

```PowerShell
Get-VM <Name> | Get-ClusterPerf
```

   > [!NOTE]
   > The Get-VM cmdlet only returns virtual machines on the local (or specified) server, not across the cluster.

#### Volume

Use the [Get-Volume](https://docs.microsoft.com/powershell/module/storage/get-volume) cmdlet:

```PowerShell
Get-Volume -FriendlyName <FriendlyName> | Get-ClusterPerf
```

#### Server

Use the [Get-Cluster](https://docs.microsoft.com/powershell/module/failoverclusters/get-cluster) cmdlet:

```PowerShell
Get-Cluster | Get-ClusterPerf
```

### Specify the timeframe

Specify the timeframe of history you want with the **-TimeFrame** parameter. Possible values are **MostRecent** (default), **LastHour**, **LastDay**, **LastWeek**, **LastMonth**, and **LastYear**.

   > [!TIP]
   > Consider specifying the series you want too.

### Specify the series

Specify the series you want with the **PhysicalDiskSeriesName**, **NetAdapterSeriesName**, **ClusterNodeSeriesName**, **VHDSeriesName** ,**VirtualMachineSeriesName** ,**VolumeSeriesName**, or **ClusterSeriesName** parameters. See the cmdlet help, the documentation above, or use tab-completion to discover available series names.

For example, this cmdlet gets the CPU usage of the virtual machine named *MyVM* for the last hour.

```PowerShell
Get-VM "MyVM" | Get-ClusterPerf -TimeFrame LastHour -VirtualMachineSeriesName "VirtualMachine.Cpu.Usage"
```

To print the series of measurements to the PowerShell console, run:

```PowerShell
$Measurements = Get-VM "MyVM" | Get-ClusterPerf -TimeFrame LastHour -VirtualMachineSeriesName "VirtualMachine.Cpu.Usage"
($Measurements).Group
```

To save them to a text file, run:

```PowerShell
($Measurements).Group >> file.txt
```

## Troubleshooting

### Symptom: the cmdlet won't run

An error message like *The term 'Get-ClusterPerf' is not recognized as the name of a cmdlet* means the feature is not available or installed. Verify that you have Windows Server Insider Preview build 123.456 or later and that you're running [Storage Spaces Direct](..\storage\storage-spaces\storage-spaces-direct-overview.md).

   > [!NOTE]
   > This feature is not available on Windows Server 2016 or earlier.

### Symptom: the cmdlet works but returns nothing

If the cmdlet doesn't return the latest measurement (within the last ten seconds), performance history collection may have lapsed or stopped.

Collection is managed by the *Health* cluster resource. Verify that it is present and Online:

```PowerShell
Get-ClusterResource Health
```

If the cluster resource is stopped, start it:

```PowerShell
Start-ClusterResource Health
```

Measurements are stored on the *ClusterPerformanceHistory* volume. Verify that it is present and OK:

```PowerShell
Get-Volume -FriendlyName "ClusterPerformanceHistory"
```

If the volume is failed or missing, see below.

   > [!NOTE]
   > If the resource or volume fails over (moves to another cluster node), there may be a brief lapse in collection. It will resume automatically.

### Symptom: the volume is failed or missing

To provision the *ClusterPerformanceHistory* volume again:

1. Confirm the volume is deleted:

```PowerShell
Remove-VirtualDisk "ClusterPerformanceHistory"
```

2.	Clear its path as saved by the Health Service:

```PowerShell
Get-StorageSubSystem Cluster* | Remove-StorageHealthSetting -Name "System.PerformanceHistory.Path"
```

3.	Set the Health Service to provision the volume again:

```PowerShell
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name "System.PerformanceHistory.AutoProvision.Enabled" -Value "True"
```

It may take up to ten minutes for the Health Service to detect the settings change and re-provision the volume. It will then automatically resume collecting performance history, which may take up to (another) ten minutes.

## Extensibility

Cluster performance history cannot be extended to collect for additional objects, timeframes, or series - yet.

## See also

- [Storage Spaces Direct overview](..\storage\storage-spaces\storage-spaces-direct-overview.md)
