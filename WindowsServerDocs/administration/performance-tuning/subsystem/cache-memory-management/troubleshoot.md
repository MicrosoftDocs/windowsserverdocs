---
title: Troubleshoot Cache and Memory Manager Performance Issues
description: Troubleshoot Cache and Memory Manager Performance Issues on Windows Server 16
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: Pavel; ATales
author: phstee
ms.date: 10/16/2017
---

# Troubleshoot Cache and Memory Manager Performance Issues

Before Windows Server 2012, two primary potential issues caused system file cache to grow until available memory was almost depleted under certain workloads. When this situation results in the system being sluggish, you can determine whether the server is facing one of these issues.


## Counters to monitor

-   Memory\\Long-Term Average Standby Cache Lifetime (s) &lt; 1800 seconds

-   Memory\\Available Mbytes is low

-   Memory\\System Cache Resident Bytes

If Memory\\Available Mbytes is low and at the same time Memory\\System Cache Resident Bytes is consuming significant part of the physical memory, you can use [RAMMAP](https://technet.microsoft.com/sysinternals/ff700229.aspx) to find out what the cache is being used for.

## System file cache contains NTFS metafile data structures


This problem is indicated by a very high number of active Metafile pages in RAMMAP output, as shown in the following figure. This problem might have been observed on busy servers with millions of files being accessed, thereby resulting in caching NTFS metafile data not being released from the cache.

![rammap view](../../media/perftune-guide-rammap.png)

The problem used to be mitigated by *DynCache* tool. In Windows Server 2012+, the architecture has been redesigned and this problem should no longer exist.

## System file cache contains memory mapped files


This problem is indicated by very high number of active Mapped file pages in RAMMAP output. This usually indicates that some application on the server is opening a lot of large files using [CreateFile](https://msdn.microsoft.com/library/windows/desktop/aa363858.aspx) API with FILE\_FLAG\_RANDOM\_ACCESS flag set.

This issue is described in detail in KB article [2549369](https://support.microsoft.com/default.aspx?scid=kb;en-US;2549369). FILE\_FLAG\_RANDOM\_ACCESS flag is a hint for Cache Manager to keep mapped views of the file in memory as long as possible (until Memory Manager doesn't signal low memory condition). At the same time, this flag instructs Cache Manager to disable prefetching of file data.

This situation has been mitigated to some extent by working set trimming improvements in Windows Server 2012+, but the issue itself needs to be primarily addressed by the application vendor by not using FILE\_FLAG\_RANDOM\_ACCESS. An alternative solution for the app vendor might be to use low memory priority when accessing the files. This can be achieved using the [SetThreadInformation](https://msdn.microsoft.com/library/windows/desktop/hh448390.aspx) API. Pages that are accessed at low memory priority are removed from the working set more aggressively.

Cache Manager, starting in Windows Server 2016 further mitigates this by ignoring FILE_FLAG_RANDOM_ACCESS when making trimming decisions, so it is treated just like any other file opened without the FILE_FLAG_RANDOM_ACCESS flag (Cache Manager still honors this flag to disable prefetching of file data). You can still cause system cache bloat if you have large number of files opened with this flag and accessed in truly random fashion. It is highly recommended that FILE_FLAG_RANDOM_ACCESS not be used by applications.
