---
title: Performance history for Storage Spaces Direct
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 05/17/2018
Keywords: Storage Spaces Direct
ms.localizationpriority: medium
---
# Performance history for Storage Spaces Direct

> Applies To: Windows Server Insider Preview build 17666 and later

Performance history is a new feature that gives [Storage Spaces Direct](storage-spaces-direct-overview.md) administrators easy access to historical compute, memory, network, and storage measurements across host servers, drives, volumes, virtual machines, and more. Performance history is collected automatically and stored on the cluster for up to one year.

   > [!IMPORTANT]
   > This feature is new in Windows Server Insider Preview. It is not available in Windows Server 2016.

## Get started

Performance history is collected by default. You do not need to install, configure, or start anything. An Internet connection is not required, System Center is not required, and an external database is not required.

To see your cluster's performance history graphically, use [Windows Admin Center](../../manage/windows-admin-center/overview.md), the next-generation in-box management tool for Windows Server. To query and process it programmatically, use the new `Get-ClusterPerformanceHistory` cmdlet – see [Usage in PowerShell](#usage-in-powershell) below.

## What's collected

Performance history is collected for 7 types of objects: drives, network adapters, servers, virtual machines, virtual hard disk files, volumes, and the overall cluster. In many cases, history is aggregated across peer objects to their parent: for example, `NetAdapter.Bytes.Inbound` is collected for each network adapter separately, and also aggregated to the overall server; likewise, `ClusterNode.Cpu.Usage` is collected for each server separately, and also aggregated to the overall cluster; and so on.

![Types of objects](media/performance-history/types-of-object.png)

#### Drives

See [Performance history for drives](performance-history-for-drives.md).

#### Network adapters

See [Performance history for network adapters](performance-history-for-network-adapters.md).

#### Servers

See [Performance history for servers](performance-history-for-servers.md).

#### Virtual hard disk (VHD) files

See [Performance history for virtual hard disks](performance-history-for-vhds.md).

#### Virtual machines (VM)

See [Performance history for virtual machines](performance-history-for-vms.md).

#### Volumes

See [Performance history for volumes](performance-history-for-volumes.md).

#### Clusters

See [Performance history for clusters](performance-history-for-clusters.md).

## Timeframes

Performance history is stored for up to one year, with diminishing granularity. For the most recent hour, measurements are available every ten seconds. Thereafter, they are intelligently merged (by averaging or summing, as appropriate) into less granular series that span more time. For the most recent day, measurements are available every five minutes; for the most recent week, every fifteen minutes; and so on.

In Windows Admin Center, you can select the timeframe in the upper-right above the chart.

![Timeframes in Windows Admin Center](media/performance-history/timeframes-in-honolulu.png)

In PowerShell, use the `-TimeFrame` parameter.

Here are the available timeframes:

| Timeframe   | Measurement frequency | Retained for |
|-------------|-----------------------|--------------|
| `LastHour`  | Every 10 secs         | 1 hour       |
| `LastDay`   | Every 5 minutes       | 25 hours     |
| `LastWeek`  | Every 15 minutes      | 8 days       |
| `LastMonth` | Every 1 hour          | 35 days      |
| `LastYear`  | Every 1 day           | 400 days     |

## Usage in PowerShell

Use the `Get-ClusterPerformanceHistory` cmdlet to query and process performance history in PowerShell. See the published [sample scripts](performance-history-scripting.md) for starter code to find peak values, calculate averages, plot trend lines, run outlier detection, and more.

```PowerShell
Get-ClusterPerformanceHistory
```

   > [!TIP]
   > Use the **Get-ClusterPerf** alias to save some keystrokes.

### Example

Get the CPU usage of virtual machine *MyVM* for the last hour:

```PowerShell
Get-VM "MyVM" | Get-ClusterPerf -VMSeriesName "VM.Cpu.Usage" -TimeFrame LastHour
```

### Specify the object

You can specify the object you want by the pipeline. This works with 7 types of objects:

| Object from pipeline | Example     |
|----------------------|-------------|
| `Get-PhysicalDisk`   | [Example](performance-history-for-drives.md#usage-in-powershell)           |
| `Get-NetAdapter`     | [Example](performance-history-for-network-adapters.md#usage-in-powershell) |
| `Get-ClusterNode`    | [Example](performance-history-for-servers.md#usage-in-powershell)          |
| `Get-VHD`            | [Example](performance-history-for-vhds.md#usage-in-powershell)             |
| `Get-VM`             | [Example](performance-history-for-vms.md#usage-in-powershell)              |
| `Get-Volume`         | [Example](performance-history-for-volumes.md#usage-in-powershell)          |
| `Get-Cluster`        | [Example](performance-history-for-clusters.md#usage-in-powershell)         |

If you don't specify, performance history for the overall cluster is returned.

   > [!TIP]
   > Consider specifying the series you want too.

### Specify the series

You can specify the series you want with these parameters, which support tab-completion for discoverability:

| Parameter                 | Values                                                                                      |
|---------------------------|---------------------------------------------------------------------------------------------|
| `-PhysicalDiskSeriesName` | See [Performance history for drives](performance-history-for-drives.md)                     |
| `-NetAdapterSeriesName`   | See [Performance history for network adapters](performance-history-for-network-adapters.md) |
| `-ClusterNodeSeriesName`  | See [Performance history for servers](performance-history-for-servers.md)                   |
| `-VHDSeriesName`          | See [Performance history for virtual hard disks](performance-history-for-vhds.md)           |
| `-VMSeriesName`           | See [Performance history for virtual machines](performance-history-for-vms.md)              |
| `-VolumeSeriesName`       | See [Performance history for volumes](performance-history-for-volumes.md)                   |
| `-ClusterSeriesName`      | See [Performance history for clusters](performance-history-for-clusters.md)                 |

If you don't specify, every series available for the specified object is returned.

### Specify the timeframe

You can specify the timeframe of history you want with the `-TimeFrame` parameter.

If you don't specify, the `MostRecent` measurement is returned.

## How it works

![How it works](media/performance-history/how-it-works.png)

1. When Storage Spaces Direct is enabled, the [Health Service](../../failover-clustering/health-service-overview.md) creates an approximately 10 GB three-way mirror volume named ClusterPerformanceHistory and provisions an instance of the Extensible Storage Engine (also known as Microsoft JET) there. This lightweight database stores the performance history.

2. The Health Service automatically discovers relevant objects, such as virtual machines, anywhere in the cluster and begins streaming their performance counters. The counters are aggregated, synchronized, and inserted into the database. Streaming runs continuously and is optimized for minimal system impact.

3. You can see performance history in Windows Admin Center or in PowerShell. Performance history is stored for up to one year, with diminishing granularity. Queries are served directly from the database for consistent, snappy performance and to minimize system impact.

## Frequently asked questions

### What extensibility is available?

We designed cluster performance history to be scripting-friendly. You can use PowerShell to pull any available history from the database. You can build automated reporting or alerting, export history for safekeeping, roll your own visualizations, and much more. However, it is not currently possible to collect history for additional objects, timeframes, or series.

### Can I change the measurement frequency and/or retention period?

No, measurement frequency and retention period are not currently configurable.

### How does this feature handle failures?

The Health Service, which collects measurements and inserts them into the database, is highly available. If the server where it is running goes down, it will resume moments later on another server in the cluster. Performance history collection may lapse briefly, but it will resume automatically. Resiliency for the database storage is provided by three-way mirroring. The ClusterPerformanceHistory volume is repaired after drive or server failures just like any other volume in Storage Spaces Direct.

### How are missing measurements handled?

When measurements are merged into less granular series that span more time, as described in [Timeframes](#Timeframes), periods of missing data are excluded. For example, if the server was down for 30 minutes, then running at 50% CPU for the next 30 minutes, the `ClusterNode.Cpu.Usage` average for the hour will be recorded as 50%.

### How do I disable this feature?

If you have not enabled Storage Spaces Direct yet, use the `-CollectPerformanceHistory` parameter of the `Enable-ClusterS2D` cmdlet. Set it to `$False`.

```PowerShell
Enable-ClusterS2D -CollectPerformanceHistory $False
```

If you have already enabled Storage Spaces Direct, an upcoming Insider Preview build will provide a cmdlet to stop the Health Service from collecting new measurements and delete existing measurements.

## Troubleshooting

### The cmdlet doesn't work

An error message like "*The term 'Get-ClusterPerf' is not recognized as the name of a cmdlet*" means the feature is not available or installed. Verify that you have Windows Server Insider Preview or later and that you're running Storage Spaces Direct.

   > [!NOTE]
   > This feature is not available on Windows Server 2016 or earlier. 

### The volume is deleted or missing

An upcoming Insider Preview build will provide a cmdlet to reprovision and start collecting new measurements.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
