---
title: Performance history for Storage Spaces Direct
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 02/09/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---
# Performance history for Storage Spaces Direct

> Applies To: Windows Server Insider Preview build 17093 and later

Performance history is a new feature that gives [Storage Spaces Direct](storage-spaces-direct-overview.md) administrators easy access to historical compute, memory, network, and storage measurements across host servers, drives, volumes, virtual machines, and more. Performance history is collected automatically and stored on the cluster for up to one year.

   > [!IMPORTANT]
   > This feature is new in Windows Server Insider Preview build 17093 and later. It is not available in Windows Server 2016.

(PLACEHOLDER FOR OVERVIEW VIDEO)

## Get started

Performance history is collected by default. You do not need to install, configure, or start anything. An external database is not required. An Internet connection is not required. System Center is not required.

To see your cluster's performance history, use [Project Honolulu (Technical Preview)](/../manage/honolulu/honolulu), the next-generation in-box management tool for Windows Server, or the new `Get-ClusterPerformanceHistory` cmdlet. See [Usage in PowerShell](#usage-in-powershell) for details.

(PLACEHOLDER FOR TUTORIAL VIDEO)

## How it works

![How it works](media/performance-history/how-it-works.png)

1. When Storage Spaces Direct is enabled, the [Health Service](../../failover-clustering/health-service-overview.md) creates an approximately 10 GB three-way mirror volume named ClusterPerformanceHistory and provisions an instance of the Extensible Storage Engine (also known as Microsoft JET) there. This lightweight database stores the performance history.

2. The Health Service automatically discovers relevant objects, such as virtual machines, anywhere in the cluster and begins streaming their performance counters. The counters are aggregated, synchronized, and inserted into the database. Streaming runs continuously and is optimized for minimal system impact.

3. You can see performance history in Project Honolulu (Technical Preview) or in PowerShell. Performance history is stored for up to one year, with diminishing granularity. Queries are served directly from the database for consistent, snappy performance and to minimize system impact.

## What's collected

### Objects

Performance history is collected for 7 types of objects: drives, network adapters, servers, virtual machines, virtual hard disk files, volumes, and the overall cluster. In many cases, history is aggregated across peer objects to their parent: for example, `networkadapter.bytes.inbound` is collected for each network adapter separately, and also aggregated to the overall server; likewise, `node.cpu.usage` is collected for each server separately, and also aggregated to the overall cluster; and so on.

![Types of objects](media/performance-history/types-of-object.png)

### Series

#### Drives

See [Performance history for drives](performance-history-for-drives.md).

#### Network adapters

See [Performance history for network adapters](performance-history-for-network-adapters.md).

#### Servers

See [Performance history for servers](performance-history-for-servers.md).

#### Virtual hard disks

See [Performance history for virtual hard disks](performance-history-for-vhds.md).

#### Virtual machines

See [Performance history for virtual machines](performance-history-for-vms.md).

#### Volumes

See [Performance history for volumes](performance-history-for-volumes.md).

#### Clusters

See [Performance history for clusters](performance-history-for-clusters.md).

### Timeframes

Performance history is stored for up to one year, with diminishing granularity. For the most recent hour, measurements are available every ten seconds. Thereafter, they are intelligently merged (by averaging or summing, as appropriate) into less granular series that span more time. For the most recent day, measurements are available every five minutes; for the most recent week, every fifteen minutes; and so on.

In Project Honolulu, you can select the timeframe in the upper-right above the chart.

![Timeframes in Honolulu](media/performance-history/timeframes-in-honolulu.png)

In PowerShell, use the `-TimeFrame` parameter.

Here are the available timeframes:

| Timeframe  | Measurement frequency | Retained for |
|------------|-----------------------|--------------|
| Last hour  | Every 10 secs         | 1 hour       |
| Last day   | Every 5 minutes       | 25 hours     |
| Last week  | Every 15 minutes      | 8 days       |
| Last month | Every 1 hour          | 35 days      |
| Last year  | Every Daily           | 400 days     |

## Usage in PowerShell

See performance history in PowerShell with the `Get-ClusterPerformanceHistory` cmdlet.

```PowerShell
Get-ClusterPerformanceHistory
```

   > [!TIP]
   > Use the **Get-ClusterPerf** alias to save some keystrokes.

### Specify the object

You can specify an object you want by the pipeline. This works with 7 types of objects:

| Object from pipeline |             |
|----------------------|-------------|
| `Get-PhysicalDisk`   | [Example](performance-history-for-drives.md#usage-in-powershell)           |
| `Get-NetAdapter`     | [Example](performance-history-for-network-adapters.md#usage-in-powershell) |
| `Get-ClusterNode`    | [Example](performance-history-for-servers.md#usage-in-powershell)          |
| `Get-VHD`            | [Example](performance-history-for-vhds.md#usage-in-powershell)             |
| `Get-VM`             | [Example](performance-history-for-vms.md#usage-in-powershell)              |
| `Get-Volume`         | [Example](performance-history-for-volumes.md#usage-in-powershell)          |
| `Get-Cluster`        | [Example](performance-history-for-clusters.md#usage-in-powershell)         |

If you don't specify, performance history for the overall cluster is returned.

### Specify the timeframe

You can specify the timeframe of history you want with the `-TimeFrame` parameter:

| -TimeFrame   |
|--------------|
| `MostRecent` |
| `LastHour`   |
| `LastDay`    |
| `LastWeek`   |
| `LastMonth`  |
| `LastYear`   |

If you don't specify, the `MostRecent` measurement is returned.

   > [!TIP]
   > Consider specifying the series you want too.

### Specify the series

You can specify the series you want with these parameters, which support tab-completion for discoverability:

| Parameter                     |
|-------------------------------|
| `-PhysicalDiskSeriesName`     |
| `-NetworkAdapterSeriesName`   |
| `-ClusterNodeSeriesName`      |
| `-VHDSeriesName`              |
| `-VirtualMachineSeriesName`   |
| `-VolumeSeriesName`           |
| `-ClusterSeriesName`          |

If you don't specify, every series available for the specified object is returned.

### Example

To get the CPU usage of the virtual machine named *MyVM* for the last hour:

```PowerShell
Get-VM "MyVM" | Get-ClusterPerf -TimeFrame LastHour -VirtualMachineSeriesName "VirtualMachine.Cpu.Usage"
```

To print the series of measurements to the PowerShell console:

```PowerShell
$Measurements = Get-VM "MyVM" | Get-ClusterPerf -TimeFrame LastHour -VirtualMachineSeriesName "VirtualMachine.Cpu.Usage"
($Measurements).Group
```

To save the series of measurements to an output file:

```PowerShell
($Measurements).Group >> file.txt
```

## Frequently asked questions

### How are failures handled?

The Health Service, which collects measurements and inserts them into the database, is highly available. If the server where it is running fails, it will resume moments later on another server in the cluster. There will be a very brief lapse in performance history collection, but it's quick. Resiliency for the database storage is provided by three-way mirroring. The ClusterPerformanceHistory volume is repaired after drive or server failures just like any other volume in Storage Spaces Direct.

### How do I disable this feature?

If you have already enabled Storage Spaces Direct, there are two steps:

1. Remove the path to the volume. This prevents the Health Service from collecting new measurements.

```PowerShell
Get-StorageSubSystem Cluster* | Remove-StorageHealthSetting -Name "System.PerformanceHistory.Path"
```

2. Delete the volume to delete existing measurements.

```PowerShell
Remove-VirtualDisk "ClusterPerformanceHistory"
```

If you have not yet enabled Storage Spaces Direct, use the `-CollectPerformanceHistory` parameter of the `Enable-ClusterS2D` cmdlet. Set it to `$False`.

```PowerShell
Enable-ClusterS2D -CollectPerformanceHistory $False
```

### What extensibility is available?

We designed cluster performance history to be scripting-friendly. You can use PowerShell to pull any available history from the database to build automated reporting or alerting, export it for safekeeping, roll your own visualizations, and much more. However, it is not currently possible to collect history for additional objects, timeframes, or series.

## Troubleshooting

### The cmdlet doesn't work

An error message like "*The term 'Get-ClusterPerf' is not recognized as the name of a cmdlet*" means the feature is not available or installed. Verify that you have Windows Server Insider Preview build 17093 or later and that you're running Storage Spaces Direct.

   > [!NOTE]
   > This feature is not available on Windows Server 2016 or earlier. 

### The cmdlet works but does nothing

If the cmdlet doesn't return the latest measurement (within the last ten seconds), performance history collection may have lapsed or stopped. Collection is managed by the *Health* cluster resource. Verify that it is present and Online:

```PowerShell
Get-ClusterResource Health
```

If the cluster resource is stopped, start it:

```PowerShell
Start-ClusterResource Health
```

Measurements are stored on the volume name ClusterPerformanceHistory. Verify that it is present and OK:

```PowerShell
Get-Volume -FriendlyName "ClusterPerformanceHistory"
```

### The volume is deleted or missing

To provision the ClusterPerformanceHistory volume again:

1. Confirm the volume is deleted:

```PowerShell
Remove-VirtualDisk "ClusterPerformanceHistory"
```

2.	Remove the path to the volume:

```PowerShell
Get-StorageSubSystem Cluster* | Remove-StorageHealthSetting -Name "System.PerformanceHistory.Path"
```

3.	Set `AutoProvision` back to `True`:

```PowerShell
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name "System.PerformanceHistory.AutoProvision.Enabled" -Value "True"
```

It may take several minutes for the changes to take effect.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
