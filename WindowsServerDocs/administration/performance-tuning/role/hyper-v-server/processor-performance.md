---
title: Hyper-V processor performance
description: Learn about the processor performance considerations to use for tuning and improving Hyper-V performance.
ms.topic: article
ms.author: roharwoo
author: robinharwood
ms.date: 01/17/2025
---

# Hyper-V processor performance

Virtualization servers host multiple virtual machines (VMs) that are isolated from each other but share underlying hardware resources. The processors, memory, and I/O devices are virtualized. When you consolidate servers onto a single machine, virtualization improves resource usage, improves energy efficiency, and reduces the servers' operational and maintenance costs. This article helps you understand the processor performance considerations for fine-tuning and improving Hyper-V performance.

## Virtual machine integration services

The virtual machine (VM) integration services include enlightened drivers for the Hyper-V-specific I/O devices, which significantly reduce CPU overhead for I/O compared to emulated devices. Install the latest version of the VM integration services in every supported VM. The services decrease the CPU usage of the guests, from idle guests to heavy-use guests, and improves the I/O throughput. This step is the first one in tuning performance in a server running Hyper-V. For a list of supported guest operating systems, see [Hyper-V overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831531(v=ws.11)).

## Virtual processors

Assess your workload to determine the processor requirements to avoid under or over provisioning. Use the results of your assessment to configure number of virtual processors required. Increase the number of virtual processors if the VM requires more processing resources under peak load. To learn more about the maximum configurable components in Hyper-V, see [Plan for Hyper-V scalability in Windows Server](../../../../virtualization/hyper-v/plan/plan-hyper-v-scalability-in-windows-server.md).

When using Simultaneous multithreading (SMT), we recommended using virtual processors in multiples of two. Most modern AMD and Intel based systems have SMT enabled, where enabled we recommended configuring virtual machines to have an even number of virtual processors. To learn more about SMT, see [Manage Hyper-V hypervisor scheduler types](../../../../virtualization/hyper-v/manage/manage-hyper-v-scheduler-types.md).

## Background activity

Minimizing the background activity in idle VMs releases CPU cycles that other VMs use. Windows guests typically use less than one percent of a CPU when they're idle. The following are best practices to minimize background CPU usage of a VM:

- Install the latest version of the VM integration services.

- Remove the emulated network adapter through the VM settings dialog box (use the Microsoft Hyper-V-specific adapter).

- Remove unused devices such as the CD-ROM and COM port, or disconnect their media.

- Keep the Windows guest operating system on the sign-in screen when it isn't being used and disable the screen saver.

- Review the scheduled tasks and services that are enabled by default.

- Review the Event Tracing for Windows (ETW) trace providers that are on by default by running `logman.exe query -ets`.

- Improve server applications to reduce periodic activity (such as timers).

- Close Server Manager on both the host and guest operating systems.

- Don't leave Hyper-V Manager running since it constantly refreshes the VM's thumbnail.

The following are best practices for configuring a *client version* of Windows in a VM to reduce the overall CPU usage:

- Disable background services such as SuperFetch and Windows Search.

- Disable scheduled tasks such as scheduled defrag.

## Virtual NUMA

Hyper-V in Windows Server expands VM scale limits to enable virtualizing large scale-up workloads. When you create large VMs, memory from multiple NUMA nodes on the host system are typically used. In that type of VM configuration, if you don't allocate virtual processors and memory from the same NUMA node, workloads might have poor performance. Performance is negatively affected because workloads can't take advantage of the NUMA optimizations. To learn more about the maximum configurable components in Hyper-V, see [Plan for Hyper-V scalability in Windows Server](../../../../virtualization/hyper-v/plan/plan-hyper-v-scalability-in-windows-server.md).

In Windows Server, Hyper-V presents a Virtual NUMA topology to VMs. By default, this Virtual NUMA topology is optimized to match the NUMA topology of the underlying host computer. Exposing a Virtual NUMA topology into a VM lets the guest operating system, and any NUMA-aware applications running within it, take advantage of the NUMA performance optimizations, just as they would when running on a physical computer.

There's no distinction between a virtual and a physical NUMA from the workload's perspective. Inside a VM, when a workload allocates local memory for data, and accesses that data in the same NUMA node, fast local memory access results on the underlying physical system. Performance penalties due to remote memory access are successfully avoided. Only NUMA-aware applications can benefit from vNUMA.

Microsoft SQL Server is an example of NUMA-aware application. For more information, see [Understanding nonuniform memory access](/previous-versions/sql/sql-server-2008-r2/ms178144(v=sql.105)).

You can't use Virtual NUMA and dynamic memory features at the same time. A VM with dynamic memory enabled on it effectively has only one Virtual NUMA node. And no NUMA topology is presented to the VM regardless of the Virtual NUMA settings.

For more info on Virtual NUMA, see [Hyper-V Virtual NUMA overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282282(v=ws.11)).

## Related links

Here are some articles to help you learn more about Hyper-V.

- [Plan for Hyper-V scalability in Windows Server](../../../../virtualization/hyper-v/plan/plan-hyper-v-scalability-in-windows-server.md)

- [Hyper-V architecture](architecture.md)

- [Hyper-V server configuration](configuration.md)

- [Hyper-V memory performance](memory-performance.md)

- [Hyper-V storage I/O performance](storage-io-performance.md)

- [Hyper-V network I/O performance](network-io-performance.md)

- [Detecting bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

- [Linux VMs](linux-virtual-machine-considerations.md)
