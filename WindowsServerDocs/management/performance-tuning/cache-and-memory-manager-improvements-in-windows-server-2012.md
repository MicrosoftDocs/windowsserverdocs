---
title: Cache and Memory Manager Improvements in Windows Server 2012
description: Cache and Memory Manager Improvements in Windows Server 2012
---

# Cache and Memory Manager Improvements in Windows Server 2012


This topic describes Cache Manager and Memory Manager improvements in Windows Server 2012.

**In this topic:**

-   [Cache Manager improvements](#cache-manager-improvements)

-   [Memory Manager improvements](#memory-manager-improvements)

## Cache Manager improvements

In addition to Cache Manager enhancements to read ahead logic for sequential workloads, a new API [CcSetReadAheadGranularityEx](http://msdn.microsoft.com/library/windows/hardware/hh406341.aspx) was added to let file system drivers, such as SMB, change their read ahead parameters. It allows better throughput for remote file scenarios by sending multiple small-sized read ahead requests instead of sending a single large read ahead request. Only kernel components, such as file system drivers, can programmatically configure these values on a per-file basis. This API was added in Windows Server 2012.

## Memory Manager improvements

Enabling page combining may reduce memory usage on servers which have a lot of private, pageable pages with identical contents. For example, servers running multiple instances of the same memory-intensive app, or a single app that works with highly repetitive data, might be good candidates to try page combining. The downside of enabling page combining is increased CPU usage.

Here are some examples of server roles where page combining is unlikely to give much benefit:

-   File servers (most of the memory is consumed by file pages which are not private and therefore not combinable)

-   Microsoft SQL Servers that are configured to use AWE or large pages (most of the memory is private but non-pageable)

Page combining is disabled by default but can be enabled by using the [Enable-MMAgent](http://technet.microsoft.com/library/jj658954.aspx) Windows PowerShell cmdlet. Page combining was added in Windows Server 2012.

## Related topics


[Performance Tuning for Cache and Memory Manager Subsystems](performance-tuning-for-cache-and-memory-manager-subsystems.md)
