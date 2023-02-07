---
title: Troubleshoot Cache and Memory Manager Performance Issues
description: Troubleshoot Cache and Memory Manager Performance Issues on Windows Server 2016
ms.topic: article
ms.author: pavel
author: phstee
ms.date: 02/07/2023
---

# Troubleshoot Cache and Memory Manager Performance Issues

Before Windows Server 2012, two primary potential issues caused system file cache to grow until available memory was almost depleted under certain workloads. When this situation results in the system being sluggish, you can determine whether the server is facing one of these issues.

## Counters to monitor

-   Memory\\Long-Term Average Standby Cache Lifetime (s) &lt; 1800 seconds

-   Memory\\Available (in Bytes, KBytes, or MBytes)

-   Memory\\System Cache Resident Bytes

If Memory\\Available Mbytes is low and at the same time Memory\\System Cache Resident Bytes is consuming significant part of the physical memory, you can use [RAMMAP](/sysinternals/downloads/rammap) to find out what the cache is being used for.

## System file cache contains NTFS metafile data structures

This problem is indicated by a high number of active Metafile pages in RAMMAP output, as shown in the following figure. This problem might have been observed on busy servers with millions of files being accessed, thereby resulting in caching NTFS metafile data not being released from the cache.

![rammap view](../../media/perftune-guide-rammap.png)

The problem used to be mitigated by *DynCache* tool. In Windows Server 2012+, the architecture has been redesigned and this problem should no longer exist.

## System file cache contains memory mapped files

This problem is indicated by a high number of active Mapped file pages in RAMMAP output. This usually indicates that some application on the server is opening numerous large files using [CreateFile](/windows/win32/api/fileapi/nf-fileapi-createfilea) API with FILE\_FLAG\_RANDOM\_ACCESS flag set.

This issue is described in detail in KB article [2549369](https://support.microsoft.com/default.aspx?scid=kb;en-US;2549369). FILE\_FLAG\_RANDOM\_ACCESS flag is a hint for Cache Manager to keep mapped views of the file in memory as long as possible (until Memory Manager doesn't signal low memory condition). At the same time, this flag instructs Cache Manager to disable prefetching of file data.

This situation has been mitigated to some extent by working set trimming improvements in Windows Server 2012+, but the issue itself needs to be primarily addressed by the application vendor by not using FILE\_FLAG\_RANDOM\_ACCESS. An alternative solution for the app vendor might be to use low memory priority when accessing the files. This can be achieved using the [SetThreadInformation](/windows/win32/api/processthreadsapi/nf-processthreadsapi-setthreadinformation) API. Pages that are accessed at low memory priority are removed from the working set more aggressively.

Cache Manager, starting in Windows Server 2016 further mitigates this by ignoring FILE_FLAG_RANDOM_ACCESS when making trimming decisions, so it is treated just like any other file opened without the FILE_FLAG_RANDOM_ACCESS flag (Cache Manager still honors this flag to disable prefetching of file data). You can still cause system cache bloat if you have large number of files opened with this flag and accessed in truly random fashion. It is highly recommended that FILE_FLAG_RANDOM_ACCESS not be used by applications.

## Remote file dirty page threshold is consistently exceeded

This problem is indicated if a system experiences occasional slowdowns during writes from a remote client. This issue may occur when a large amount of data is written from a fast remote client to a slow server destination.

Prior to Windows Server 2016, in such a scenario, if the dirty page threshold in the cache is reached, further writes will behave as if there were write-through. This can cause a flush of a large amount of data to the disk, which can lead to long delays if the storage is slow, resulting in timeouts for the remote connection.

In Window Server 2016 and forward, a mitigation is put in place to reduce the likelihood of timeouts. A separate dirty page threshold for remote writes is implemented, and an inline flush will be performed when it is exceeded. This can result on occasional slowdowns during heavy write activity, but eliminates the risk of a timeout in most cases. This remote dirty page threshold is **5 GB per file** by default. For some configurations and workloads, a different number will perform better.

This threshold can be controlled with the following regkey: HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\RemoteFileDirtyPageThreshold. If the default size of 5 GB does not work well for your configuration, it is recommended to try increasing the limit in 256-MB increments until performance is satisfactory. Be aware of the following:

-   A reboot is required for changes to this regkey to take effect.

-   The units of RemoteFileDirtyPageThreshold are **number of pages** (with page size as managed by Cache Manager). This means it should be set to the desired size in bytes, divided by 4096.

-   Recommended values are 128 MB <= N <= 50% of available memory.

-   This threshold can be disabled completely by setting it to -1. **This is not recommended** as it can result in timeouts for remote connections.
