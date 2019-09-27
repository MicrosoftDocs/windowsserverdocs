---
title: Windows Server 2016 Performance Tuning Guidelines
description: Performance tuning guidelines for Windows Server 2016
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: landing-page
ms.author: phstee
author: phstee
ms.date: 10/16/2017
---

# Performance Tuning Guidelines for Windows Server 2016

When you run a server system in your organization, you might have business needs not met using default server settings. For example, you might need the lowest possible energy consumption, or the lowest possible latency, or the maximum possible throughput on your server. This guide provides a set of guidelines that you can use to tune the server settings in Windows Server 2016 and obtain incremental performance or energy efficiency gains, especially when the nature of the workload varies little over time.

It is important that your tuning changes consider the hardware, the workload, the power budgets, and the performance goals of your server. This guide describes each setting and its potential effect to help you make an informed decision about its relevance to your system, workload, performance, and energy usage goals.

> [!warning]
> Registry settings and tuning parameters changed significantly between versions of Windows Server. Be sure to use the latest tuning guidelines to avoid unexpected results.

## In this guide
This guide organizes performance and tuning guidance for Windows Server 2016 across three tuning categories:

|Server Hardware | Server Role | Server Subsystem |
|:---:|:---:|:---:|
|[Hardware performance considerations](hardware/index.md) |[Active Directory Servers](role/active-directory-server/index.md) |[Cache and memory management](subsystem/cache-memory-management/index.md)|
|[Hardware power considerations](hardware/power.md)|[File Servers](role/file-server/index.md)|[Networking subsystem](../../networking/technologies/network-subsystem/net-sub-performance-top.md)|
||[Hyper-V Servers](role/hyper-v-server/index.md)|[Storage Spaces Direct](subsystem/storage-spaces-direct/index.md)|
||[Remote Desktop Services](role/remote-desktop/session-hosts.md)|[Software Defined Networking (SDN)](subsystem/software-defined-networking/index.md)|
||[Web Servers](role/web-server/index.md)||
||[Windows Server Containers](role/windows-server-container/index.md)||


## Changes in this version

### Sections added
- [Nano Server installation-type configuration considerations](../../get-started/getting-started-with-nano-server.md)


- [Software Defined Networking](subsystem/software-defined-networking/index.md), including [HNV](subsystem/software-defined-networking/hnv-gateway-performance.md) and [SLB gateway configuration guidance](subsystem/software-defined-networking/slb-gateway-performance.md)

- [Storage Spaces Direct](subsystem/storage-spaces-direct/index.md)

- [HTTP1.1 and HTTP2](role/web-server/http-performance.md)

- [Windows Server Containers](role/windows-server-container/index.md)

### Sections changed

- Updates to [Active Directory guidance](role/active-directory-server/index.md) section

- Updates to [File Server guidance](role/file-server/index.md) section

- Updates to [Web Server guidance](role/web-server/index.md) section

- Updates to [Hardware Power guidance](hardware/power.md) section

- Updates to [PowerShell tuning guidance](powershell/index.md) section

- Significant updates to the [Hyper-V guidance](role/hyper-v-server/index.md) section

- *Performance Tuning for Workloads removed*, pointers to relevant resources added to [Additional Tuning Resources article](additional-resources.md)

- *Removal of dedicated storage sections*, in favor of new [Storage Spaces Direct](subsystem/storage-spaces-direct/index.md) section and canonical Technet content

- *Removal of dedicated networking section*, in favor of canonical Technet content  
