---
title: Storage Spaces Direct in-memory read cache
ms.prod: windows-server-threshold
ms.author: eldenc
ms.manager: siroy
ms.technology: storage-spaces
ms.topic: article
author: eldenchristensen
ms.date: 02/05/2018
ms.localizationpriority: medium
---

# Storage Spaces Direct in-memory read cache

> Applies To: Windows Server 2016, Windows Server Insider Preview

This topic describes how to use system memory to boost the performance of [Storage Spaces Direct](storage-spaces-direct-overview.md).

Storage Spaces Direct is compatible with the Cluster Shared Volume (CSV) in-memory read cache. Using system memory to cache reads can significantly improve performance for applications like Hyper-V, which uses unbuffered I/O to access VHD or VHDX files. Unbuffered IOs are any operations that are not cached by the Windows Cache Manager.

Because the in-memory cache is server-local, it improves data locality for hyper-converged Storage Spaces Direct deployments: recent reads are cached in memory on the same host where the virtual machine is running, reducing how often reads go over the network. This results in lower latency and better storage performance.

## Planning considerations

The in-memory read cache is most effective for read-intensive workloads, such as Virtual Desktop Infrastructure (VDI). Conversely, if the workload is extremely write-intensive, the cache may introduce more overhead than value and should be disabled.

You can use up to 80% of total physical memory for the CSV in-memory read cache.

  > [!TIP]
  >  For hyper-converged deployments, where compute and storage run on the same servers, be careful to leave enough memory for your virtual machines. For converged Scale-Out File Server (SoFS) deployments, with less contention for memory, this doesn't apply.

## Configuring the in-memory read cache

In Windows Server 2016, the CSV in-memory read cache is off by default.

In Windows Server Insider Preview builds, it is on by default, with 1 GB allocated.

| OS version                     | Default CSV cache size |
|--------------------------------|------------------------|
| Windows Server 2016            | 0 (disabled)           |
| Windows Server Insider Preview | 1 GB                   |

To see how much memory is being used for CSV in-memory read cache using PowerShell, run:

```PowerShell
(Get-Cluster).BlockCacheSize
```

The value returned is in megabytes (MB) per server. For example, `1024` represents 1 gigabyte (GB).

To change how much memory, you can directly modify this value in PowerShell. For example, to set the CSV in-memory read cache to use 2 GB per server, run:

```PowerShell
(Get-Cluster).BlockCacheSize = 2048
```

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
