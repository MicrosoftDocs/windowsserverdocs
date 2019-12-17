---
title: Hyper-V terminology
description: Hyper-v terminology useful in Hyper-V performance tuning 
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: Asmahi; SandySp; JoPoulso
author: phstee
ms.date: 10/16/2017
---

# Hyper-V Terminology
This section summarizes key terminology specific to virtual machine technology that is used throughout this performance tuning topic:

| Term        | Definition           |
| ------------- |:------------|
|*child partition* | Any virtual machine that is created by the root partition.|
|*device virtualization* | A mechanism that lets a hardware resource be abstracted and shared among multiple consumers.|
|*emulated device*|A virtualized device that mimics an actual physical hardware device so that guests can use the typical drivers for that hardware device.|
|*enlightenment*|An optimization to a guest operating system to make it aware of virtual machine environments and tune its behavior for virtual machines.|
|*guest*|Software that is running in a partition. It can be a full-featured operating system or a small, special-purpose kernel. The hypervisor is guest-agnostic.|
|*hypervisor*|A layer of software that sits above the hardware and below one or more operating systems. Its primary job is to provide isolated execution environments called partitions. Each partition has its own set of virtualized hardware resources (central processing unit or CPU, memory, and devices). The hypervisor controls and arbitrates access to the underlying hardware.|
|*logical processor*| A processing unit that handles one thread of execution (instruction stream). There can be one or more logical processors per processor core and one or more cores per processor socket.|
| *passthrough disk access*|A representation of an entire physical disk as a virtual disk within the guest. The data and commands are passed through to the physical disk (through the root partition's native storage stack) with no intervening processing by the virtual stack.|
|*root partition*|The root partition that is created first and owns all the resources that the hypervisor does not, including most devices and system memory. The root partition hosts the virtualization stack and creates and manages the child partitions.|
|*Hyper-V-specific device*|A virtualized device with no physical hardware analog, so guests may need a driver (virtualization service client) to that Hyper-V-specific device. The driver can use virtual machine bus (VMBus) to communicate with the virtualized device software in the root partition.|
|*virtual machine*|A virtual computer that was created by software emulation and has the same characteristics as a real computer.|
| *virtual network switch*|(also referred to as a virtual switch) A virtual version of a physical network switch. A virtual network can be configured to provide access to local or external network resources for one or more virtual machines.|
|*virtual processor*|A virtual abstraction of a processor that is scheduled to run on a logical processor. A virtual machine can have one or more virtual processors.|
|*virtualization service client (VSC)*|A software module that a guest loads to consume a resource or service. For I/O devices, the virtualization service client can be a device driver that the operating system kernel loads.|
| *virtualization service provider (VSP)*|  A provider exposed by the virtualization stack in the root partition that provides resources or services such as I/O to a child partition.|
| *virtualization stack*|A collection of software components in the root partition that work together to support virtual machines. The virtualization stack works with and sits above the hypervisor. It also provides management capabilities.|
|*VMBus*|Channel-based communication mechanism used for inter-partition communication and device enumeration on systems with multiple active virtualized partitions. The VMBus is installed with Hyper-V Integration Services.|

## See also

-   [Hyper-V architecture](architecture.md)

-   [Hyper-V server configuration](configuration.md)

-   [Hyper-V processor performance](processor-performance.md)

-   [Hyper-V memory performance](memory-performance.md)

-   [Hyper-V storage I/O performance](storage-io-performance.md)

-   [Hyper-V network I/O performance](network-io-performance.md)

-   [Detecting bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

-   [Linux Virtual Machines](linux-virtual-machine-considerations.md)
