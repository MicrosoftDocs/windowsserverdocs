---
title: Hyper-V Memory Performance
description: Memory considerations in performance tuning Hyper-V
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: Asmahi; SandySp; JoPoulso
author: phstee
ms.date: 10/16/2017
---

# Hyper-V Memory Performance


The hypervisor virtualizes the guest physical memory to isolate virtual machines from each other and to provide a contiguous, zero-based memory space for each guest operating system, just as on non-virtualized systems.

## Correct memory sizing for child partitions

You should size virtual machine memory as you typically do for server applications on a physical computer. You must size it to reasonably handle the expected load at ordinary and peak times because insufficient memory can significantly increase response times and CPU or I/O usage.

You can enable Dynamic Memory to allow Windows to size virtual machine memory dynamically. With Dynamic Memory, if applications in the virtual machine experience problems making large sudden memory allocations, you can increase the page file size for the virtual machine to ensure temporary backing while Dynamic Memory responds to the memory pressure.

For more info on Dynamic Memory, see [Hyper-V Dynamic Memory Overview]( https://go.microsoft.com/fwlink/?linkid=834434) and [Hyper-V Dynamic Memory Configuration Guide](https://go.microsoft.com/fwlink/?linkid=834435).

When running Windows in the child partition, you can use the following performance counters within a child partition to identify whether the child partition is experiencing memory pressure and is likely to perform better with a higher virtual machine memory size.

| Performance counter                                                         | Suggested threshold value                                                                                                                                                           |
|-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Memory – Standby Cache Reserve Bytes                                        | Sum of Standby Cache Reserve Bytes and Free and Zero Page List Bytes should be 200 MB or more on systems with 1 GB, and 300 MB or more on systems with 2 GB or more of visible RAM. |
| Memory – Free & Zero Page List Bytes                                        | Sum of Standby Cache Reserve Bytes and Free and Zero Page List Bytes should be 200 MB or more on systems with 1 GB, and 300 MB or more on systems with 2 GB or more of visible RAM. |
| Memory – Pages Input/Sec                                                    | Average over a 1-hour period is less than 10.                                                                                                                                       | 

## Correct memory sizing for root partition

The root partition must have sufficient memory to provide services such as I/O virtualization, virtual machine snapshot, and management to support the child partitions.

Hyper-V in Windows Server 2016 monitors the runtime health of the root partition's management operating system to determine how much memory can safely be allocated to child partitions, while still ensuring high performance and reliability of the root partition.

## See also

-   [Hyper-V terminology](terminology.md)

-   [Hyper-V architecture](architecture.md)

-   [Hyper-V server configuration](configuration.md)

-   [Hyper-V processor performance](processor-performance.md)

-   [Hyper-V storage I/O performance](storage-io-performance.md)

-   [Hyper-V network I/O performance](network-io-performance.md)

-   [Detecting bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

-   [Linux Virtual Machines](linux-virtual-machine-considerations.md)
