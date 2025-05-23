---
title: Cache and Memory Manager Improvements
description: Cache and Memory Manager Improvements in Windows Server 2016
ms.topic: whats-new
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# Cache and Memory Manager Improvements

This topic describes Cache Manager and Memory Manager improvements in Windows Server 2012 and 2016.

## Cache Manager improvements in Windows Server 2022
Cache manager is now NUMA aware, which ensures the system is better at avoiding data movement across NUMA boundaries. Avoiding accesses from a NUMA node to memory and other kernel resources on another NUMA node adds a lot of overhead. By making Cache manager NUMA aware, we have eliminated such cross-NUMA hops, thus optimizing cached IO workloads running on multi node configurations.

## Cache Manager improvements in Windows Server 2019
We added Zero-Copy support for Persistent Memory (PMEM) Storage.  For more information on persistent memory, see [Understand and deploy persistent memory](/azure/azure-local/concepts/deploy-persistent-memory).
In Direct Access (DAX) mode, PMEM operates like memory to get the lowest latency, wherein we eliminate an extra copy of data and bypass a lot of overhead from Filesystem Mini-Filters and the storage stack. This mode only works with NTFS as a filesystem.

## Cache Manager improvements in Windows Server 2016
Cache Manager also added support for true Asynchronous Cached Reads.
This could potentially improve the performance of an application if it relies heavily on asynchronous cached reads.  While most in-box filesystems have supported async-cached reads for a while, there were often performance limitations due to various design choices related to handling of thread-pools and filesystems' internal work queues.  With support from kernel-proper, Cache Manager now hides all the thread-pool and work queue management complexities from filesystems making it more efficient at handling asynchronous cached reads. Cache Manager has one set of control data structures for each of (system supported maximum) VHD-nesting levels to maximize parallelism.


## Cache Manager improvements in Windows Server 2012
In addition to Cache Manager enhancements to read ahead logic for sequential workloads, a new API [CcSetReadAheadGranularityEx](/windows-hardware/drivers/ifs/ccsetreadaheadgranularityex) was added to let file system drivers, such as SMB, change their read ahead parameters. It allows better throughput for remote file scenarios by sending multiple small-sized read ahead requests instead of sending a single large read ahead request. Only kernel components, such as file system drivers, can programmatically configure these values on a per-file basis.

## Memory Manager improvements in Windows Server 2012
Enabling page combining may reduce memory usage on servers, which have a lot of private, pageable pages with identical contents. For example, servers running multiple instances of the same memory-intensive app, or a single app that works with highly repetitive data, might be good candidates to try page combining. The downside of enabling page combining is increased CPU usage.

Here are some examples of server roles where page combining is unlikely to give much benefit:

-   File servers (most of the memory is consumed by file pages which are not private and therefore not combinable)

-   Microsoft SQL Servers that are configured to use AWE or large pages (most of the memory is private but non-pageable)

Page combining is disabled by default but can be enabled by using the [Enable-MMAgent](/powershell/module/mmagent/enable-mmagent) Windows PowerShell cmdlet. Page combining was added in Windows Server 2012.
