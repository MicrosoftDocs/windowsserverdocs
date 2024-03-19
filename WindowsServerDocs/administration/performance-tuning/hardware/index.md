---
title: Server Hardware Performance Considerations
description: Server hardware performance considerations for Windows Server 2022
ms.topic: landing-page
ms.author: wscontent
author: robinharwood
ms.date: 11/14/2023
---

# Server hardware performance considerations

The following section lists important items that you should consider when you choose server hardware. Following these guidelines can help remove performance bottlenecks that might impede the server's performance.

## Processor recommendations

Choose 64-bit processors for servers. 64-bit processors have more address space, and are required for Windows Server 2022. No 32-bit editions of the operating system will be provided, but 32-bit applications will run on the 64-bit Windows Server 2022 operating system.

To increase the computing resources in a server, you can use a processor with higher-frequency cores, or you can increase the number of processor cores. If CPU is the limiting resource in the system, a core with 2x frequency typically provides a greater performance improvement than two cores with 1x frequency.

Multiple cores aren't expected to provide a perfect linear scaling, and the scaling factor can be even less if hyper-threading is enabled because hyper-threading relies on sharing resources of the same physical core.

>[!IMPORTANT]
> Match and scale the memory and I/O subsystem with the CPU performance, and vice versa.

Don't compare CPU frequencies across manufacturers and generations of processors because the comparison can be a misleading indicator of speed.

For Hyper-V, make sure that the processor supports SLAT (Second Level Address Translation). It's implemented as Extended Page Tables (EPT) by Intel and Nested Page Tables (NPT) by AMD. You can verify this feature is present by using SystemInfo.exe on your server.

## Cache recommendations

Choose large L2 or L3 processor caches. On newer architectures, such as Haswell or Skylake, there's a unified Last Level Cache (LLC) or an L4. The larger caches generally provide better performance, and they often play a bigger role than raw CPU frequency.

## Memory (RAM) and paging storage recommendations

>[!NOTE]
> Some systems may exhibit reduced storage performance when running a new install of Windows Server 2022 versus Windows Server 2012 R2. A number of changes were made during the development of Windows Server 2022 to improve security and reliability of the platform. Some of those changes, such as enabling Windows Defender by default, result in longer I/O paths that can reduce I/O performance in specific workloads and patterns. Microsoft does not recommend disabling Windows Defender as it is an important layer of protection for your systems.

Increase the RAM to match your memory needs. When your computer runs low on memory and it needs more immediately, Windows uses hard disk space to supplement system RAM through a procedure called paging. Too much paging degrades the overall system performance. You can optimize paging by using the following guidelines for page file placement:

- Isolate the page file on its own storage device, or at least make sure it doesn't share the same storage devices as other frequently accessed files. For example, place the page file and operating system files on separate physical disk drives.

- Place the page file on a drive that is fault-tolerant. If a non-fault-tolerant disk fails, a system crash is likely to occur. If you place the page file on a fault-tolerant drive, remember that fault-tolerant systems are often slower to write data because they write data to multiple locations.

- Use multiple disks or a disk array if you need additional disk bandwidth for paging. Don't place multiple page files on different partitions of the same physical disk drive.

## Peripheral bus recommendations

In Windows Server 2022, the primary storage and network interfaces should be PCI Express (PCIe) so servers with PCIe buses are recommended. To avoid bus speed limitations, use PCIe x8 and higher slots for 10+ GB Ethernet adapters.

## Disk recommendations

Choose disks with higher rotational speeds to reduce random request service times (~2 ms on average when you compare 7,200-RPM and 15,000-RPM drives) and to increase sequential request bandwidth. However, there are cost, power, and other considerations associated with disks that have high rotational speeds.

2.5-inch enterprise-class disks can service a larger number of random requests per second compared to equivalent 3.5-inch drives.

Store frequently accessed data, especially sequentially accessed data, near the beginning of a disk because this roughly corresponds to the outermost (fastest) tracks.

Consolidating small drives into fewer high-capacity drives can reduce overall storage performance. Fewer spindles mean reduced request service concurrency; and therefore, potentially lower throughput and longer response times (depending on the workload intensity).

The use of SSD and high speed flash disks is useful for read mostly disks with high I/O rates or latency sensitive I/O. Boot disks are good candidates for the use of SSD or high speed flash disks as they can improve boot times significantly.

## Network and Storage Adapter recommendations

NVMe SSDs offer superior performance with greater command queue depths, more efficient interrupt processing, and greater efficiency for 4KB commands. This particularly benefits scenarios that require heavy simultaneous I/O. PCI Gen 5 devices outperform the CPU and system bus, so the Windows Server OS can't optimize the IO mechanism for tools to display the peak performance accurately.

## Network and storage adapter recommendations

The following section lists the recommended characteristics for network and storage adapters for high-performance servers. These settings can help prevent your networking or storage hardware from being a bottleneck when they are under heavy load.

### Certified adapter usage

Use an adapter that has passed the Windows Hardware Certification test suite.

### 64-bit 

Adapters that are 64-bit-capable can perform direct memory access (DMA) operations to and from high physical memory locations (greater than 4 GB). If the driver doesn't support DMA greater than 4 GB, the system double-buffers the I/O to a physical address space of less than 4 GB.


### Copper and fiber adapters

Copper adapters generally have the same performance as their fiber counterparts, and both copper and fiber are available on some Fibre Channel adapters. Certain environments are better suited to copper adapters, whereas other environments are better suited to fiber adapters.

### Dual or quad-port adapters

Multiport adapters are useful for servers that have a limited number of PCI slots.

To address SCSI limitations on the number of disks that can be connected to a SCSI bus, some adapters provide two or four SCSI buses on a single adapter card. Fibre Channel adapters generally have no limits to the number of disks that are connected to an adapter unless they're hidden behind a SCSI interface.

Serial Attached SCSI (SAS) and Serial ATA (SATA) adapters also have a limited number of connections because of the serial nature of the protocols, but you can attach more disks by using switches.

Network adapters have this feature for load-balancing or failover scenarios. Using two single-port network adapters usually yields better performance than using a single dual-port network adapter for the same workload.

PCI bus limitation can be a major factor in limiting performance for multiport adapters. Therefore, it's important to consider placing them in a high-performing PCIe slot that provides enough bandwidth.

### Interrupt moderation

Some adapters can moderate how frequently they interrupt the host processors to indicate activity or its completion. Moderating interrupts can often result in reduced CPU load on the host, but, unless interrupt moderation is performed intelligently; the CPU savings might increase latency.

### Receive Side Scaling (RSS) support

RSS enables packet receive-processing to scale with the number of available computer processors. This is important with 10 GB Ethernet and faster.

### Offload capability and other advanced features such as message-signaled interrupt (MSI)-X

Offload-capable adapters offer CPU savings that yield improved performance.

### Dynamic interrupt and deferred procedure call (DPC) redirection

In Windows Server 2022, Numa I/O enables PCIe storage adapters to dynamically redirect interrupts and DPCs and can help any multiprocessor system by improving workload partitioning, cache hit rates, and on-board hardware interconnect usage for I/O-intensive workloads.

## See also

- [Server Hardware Power Considerations](power.md)
- [Overview about power and performance tuning for the Windows Server](power/power-performance-tuning.md)
- [Processor Power Management (PPM) tuning for the Windows Server balanced power plan](power/processor-power-management-tuning.md)
