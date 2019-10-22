---
title: Performance Tuning Web Servers
description: Performance tuning recommendations for Web Servers on Windows Server 16
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: landing-page
ms.author: DavSo; Ericam; YaShi
author: phstee
ms.date: 10/16/2017
---

# Performance Tuning Web Servers


This topic describes performance tuning methods and recommendations for Windows Server 2016 web servers.


## Selecting the proper hardware for performance


It is important to select the proper hardware to satisfy the expected web load, considering average load, peak load, capacity, growth plans, and response times. Hardware bottlenecks limit the effectiveness of software tuning.

[Performance Tuning for Server Hardware](../../hardware/index.md) provides recommendations for hardware to avoid the following performance constraints:

-   Slow CPUs offer limited processing power for CPU intensive workloads such as ASP, ASP.NET, and TLS scenarios.

-   A small L2 or L3/LLC processor cache might adversely affect performance.

-   A limited amount of memory affects the number of sites that can be hosted, how many dynamic content scripts (such as ASP.NET) can be stored, and the number of application pools or worker processes.

-   Networking becomes a bottleneck because of an inefficient network adapter.

-   The file system becomes a bottleneck because of an inefficient disk subsystem or storage adapter.

## Operating system best practices


If possible, start with a clean installation of the operating system. Upgrading the software can leave outdated, unwanted, or suboptimal registry settings and previously installed services and applications that consume resources if they are started automatically. If another operating system is installed and you must keep it, you should install the new operating system on a different partition. Otherwise, the new installation overwrites the settings under %Program Files%\\Common Files.

To reduce disk access interference, place the system page file, operating system, web data, ASP template cache, and the Internet Information Services (IIS) log on separate physical disks, if possible.

To reduce contention for system resources, install Microsoft SQL Server and IIS on different servers, if possible.

Avoid installing non-essential services and applications. In some cases, it might be worthwhile to disable services that are not required on a system.

## NTFS file system settings

The system-global switch **NtfsDisableLastAccessUpdate** (REG\_DWORD) 1 is located under **HKLM\\System\\CurrentControlSet\\Control\\FileSystem** and is set by default to 1. This switch reduces disk I/O load and latencies by disabling date and time stamp updating for the last file or directory access. Clean installations of Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 enable this setting by default, and you do not need to adjust it. Earlier versions of Windows did not set this key. If your server is running an earlier version of Windows, or it was upgraded to Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008, you should enable this setting.

Disabling the updates is effective when you are using large data sets (or many hosts) that contain thousands of directories. We recommend that you use IIS logging instead if you maintain this information only for Web administration.

>[!Warning]
> Some applications, such as incremental backup utilities, rely on this update information, and they do not function correctly without it.

## See also
- [IIS 10.0 performance tuning](tuning-iis-10.md)
- [HTTP 1.1/2 tuning](http-performance.md)


