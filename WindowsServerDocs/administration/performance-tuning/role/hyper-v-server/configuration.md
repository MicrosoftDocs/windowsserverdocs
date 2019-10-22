---
title: Hyper-V Configuration
description: Hyper-V configuration considerations for performance tuning
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: Asmahi; SandySp; JoPoulso
author: phstee
ms.date: 10/16/2017
---

# Hyper-V Configuration

## Hardware selection

The hardware considerations for servers running Hyper-V generally resemble those of non-virtualized servers, but servers running Hyper-V can exhibit increased CPU usage, consume more memory, and need larger I/O bandwidth because of server consolidation.

-   **Processors**

    Hyper-V in Windows Server 2016 presents the logical processors as one or more virtual processors to each active virtual machine. Hyper-V now requires processors that support Second Level Address Translation (SLAT) technologies such as Extended Page Tables (EPT) or Nested Page Tables (NPT).

-   **Cache**

    Hyper-V can benefit from larger processor caches, especially for loads that have a large working set in memory and in virtual machine configurations in which the ratio of virtual processors to logical processors is high.

-   **Memory**

    The physical server requires sufficient memory for the both the root and child partitions. The root partition requires memory to efficiently perform I/Os on behalf of the virtual machines and operations such as a virtual machine snapshot. Hyper-V ensures that sufficient memory is available to the root partition, and allows remaining memory to be assigned to child partitions. Child partitions should be sized based on the needs of the expected load for each virtual machine.

-   **Storage**

    The storage hardware should have sufficient I/O bandwidth and capacity to meet the current and future needs of the virtual machines that the physical server hosts. Consider these requirements when you select storage controllers and disks and choose the RAID configuration. Placing virtual machines with highly disk-intensive workloads on different physical disks will likely improve overall performance. For example, if four virtual machines share a single disk and actively use it, each virtual machine can yield only 25 percent of the bandwidth of that disk.

## Power plan considerations

As a core technology, virtualization is a powerful tool useful in increasing server workload density, reducing the number of required physical servers in your datacenter, increasing operational efficiency and reducing power consumption costs. Power management is critical for cost management. 

In an ideal datacenter environment, power consumption is managed by consolidating work onto machines until they're mostly busy and then turning off idle machines. If this approach is not practical, administrators can leverage power plans on the physical hosts to ensure they do not consume more power than necessary. 

Server power management techniques come with a cost, particularly as tenant workloads are not trusted to dictate policy about the hoster's physical infrastructure. The host layer software is left to infer how to maximize throughput while minimizing power consumption. In mostly-idle machines, this can cause the physical infrastructure to conclude that moderate power draw is appropriate, resulting in individual tenant workloads running more slowly than they might otherwise.

Windows Server uses virtualization in a wide variety of scenarios. From a lightly loaded IIS Server to a moderately busy SQL Server, to a cloud host with Hyper-V running hundreds of virtual machines per server. Each of these scenarios may have unique hardware, software, and performance requirements. By default, Windows Server uses and recommends the **Balanced** power plan which enables power conservation by scaling the processor performance based on CPU utilization.

With the **Balanced** power plan, the highest power states (and lowest response latencies in tenant workloads) are applied only when the physical host is relatively busy. If you value deterministic, low-latency response for all tenant workloads, you should consider switching from the default **Balanced** power plan to the **High Performance** power plan. The **High Performance** power plan will run the processors at full speed all the time, effectively disabling Demand-Based Switching along with other power management techniques, and optimize for performance over power savings.

For customers, who are satisfied with the cost savings from reducing the number of physical servers and want to ensure they achieve maximum performance for their virtualized workloads, you should consider using the **High Performance** power plan.

For additional recommendations and insight on leveraging power plans to optimize your infrastructure, read [Recommended Balanced Power Plan Parameters for Quick Response Times](../../hardware/power/recommended-balanced-plan-parameters.md)



## Server Core installation option

Windows Server 2016 feature the Server Core installation option. Server Core offers a minimal environment for hosting a select set of server roles including Hyper-V. It features a smaller disk footprint for the host OS, and a smaller attack and servicing surface. Therefore, we highly recommend that Hyper-V virtualization servers use the Server Core installation option.

A Server Core installation offers a console window only when the user is logged on, but Hyper-V exposes remote management features including [Windows Powershell](https://technet.microsoft.com/library/hh848559.aspx) so administrators can manage it remotely.

## Dedicated server role

The root partition should be dedicated to Hyper-V. Running additional server roles on a server running Hyper-V can adversely affect the performance of the virtualization server, especially if they consume significant CPU, memory, or I/O bandwidth. Minimizing the server roles in the root partition has additional benefits such as reducing the attack surface.

System administrators should consider carefully what software is installed in the root partition because some software can adversely affect the overall performance of the server running Hyper-V.

## Guest operating systems

Hyper-V supports and has been tuned for a number of different guest operating systems. The number of virtual processors that are supported per guest depends on the guest operating system. For a list of the supported guest operating systems, see [Hyper-V Overview](https://technet.microsoft.com/library/hh831531.aspx).

## CPU statistics

Hyper-V publishes performance counters to help characterize the behavior of the virtualization server and report the resource usage. The standard set of tools for viewing performance counters in Windows includes Performance Monitor and Logman.exe, which can display and log the Hyper-V performance counters. The names of the relevant counter objects are prefixed with **Hyper-V**.

You should always measure the CPU usage of the physical system by using the Hyper-V Hypervisor Logical Processor performance counters. The CPU utilization counters that Task Manager and Performance Monitor report in the root and child partitions do not reflect the actual physical CPU usage. Use the following performance counters to monitor performance:

- **Hyper-V Hypervisor Logical Processor (\*)\\% Total Run Time** The total non-idle time of the logical processors

- **Hyper-V Hypervisor Logical Processor (\*)\\% Guest Run Time** The time spent running cycles within a guest or within the host

- **Hyper-V Hypervisor Logical Processor (\*)\\% Hypervisor Run Time** The time spent running within the hypervisor

- **Hyper-V Hypervisor Root Virtual Processor (\*)\\\\*** Measures the CPU usage of the root partition

- **Hyper-V Hypervisor Virtual Processor (\*)\\\\*** Measures the CPU usage of guest partitions


## See also

-   [Hyper-V terminology](terminology.md)

-   [Hyper-V architecture](architecture.md)

-   [Hyper-V processor performance](processor-performance.md)

-   [Hyper-V memory performance](memory-performance.md)

-   [Hyper-V storage I/O performance](storage-io-performance.md)

-   [Hyper-V network I/O performance](network-io-performance.md)

-   [Detecting bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

-   [Linux Virtual Machines](linux-virtual-machine-considerations.md)
