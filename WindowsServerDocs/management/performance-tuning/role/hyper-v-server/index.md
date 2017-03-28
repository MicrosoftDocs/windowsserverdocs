---
title: Performance Tuning for Hyper-V Servers
description: Performance Tuning for Hyper-V Servers
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a387861d-257a-4803-aa48-a1bb1b6c6cb6
author: phstee
ms.author: Asmahi; SandySp; JoPoulso;
ms.date: 10/31/2016
---

# Performance Tuning for Hyper-V Servers


Hyper-V is the virtualization server role in Windows Server 2016. Virtualization servers can host multiple virtual machines that are isolated from each other but share the underlying hardware resources by virtualizing the processors, memory, and I/O devices. By consolidating servers onto a single machine, virtualization can improve resource usage and energy efficiency and reduce the operational and maintenance costs of servers. In addition, virtual machines and the management APIs offer more flexibility for managing resources, balancing load, and provisioning systems.

**In this topic:**

-   [Hyper-V terminology](#terminology)

-   [Hyper-V architecture](#arch)

-   [Hyper-V server configuration](#serverconfig)

-   [Hyper-V processor performance](#cpu)

-   [Hyper-V memory performance](#memory)

-   [Hyper-V storage I/O performance](#storageio)

-   [Hyper-V network I/O performance](#netio)

-   [Detecting bottlenecks in a virtualized environment](#bottle)

-   [Linux Virtual Machines](#linux)


## <a href="" id="terminology"></a>Hyper-V terminology

This section summarizes key terminology specific to virtual machine technology that is used throughout this performance tuning topic:

-   **child partition**

    Any virtual machine that is created by the root partition.

-   **device virtualization**

    A mechanism that lets a hardware resource be abstracted and shared among multiple consumers.

-   **emulated device**

    A virtualized device that mimics an actual physical hardware device so that guests can use the typical drivers for that hardware device.

-   **enlightenment**

    An optimization to a guest operating system to make it aware of virtual machine environments and tune its behavior for virtual machines.

-   **guest**

    Software that is running in a partition. It can be a full-featured operating system or a small, special-purpose kernel. The hypervisor is guest-agnostic.

-   **hypervisor**

    A layer of software that sits above the hardware and below one or more operating systems. Its primary job is to provide isolated execution environments called partitions. Each partition has its own set of virtualized hardware resources (central processing unit or CPU, memory, and devices). The hypervisor controls and arbitrates access to the underlying hardware.

-   **logical processor**

    A processing unit that handles one thread of execution (instruction stream). There can be one or more logical processors per processor core and one or more cores per processor socket.

-   **passthrough disk access**

    A representation of an entire physical disk as a virtual disk within the guest. The data and commands are passed through to the physical disk (through the root partition’s native storage stack) with no intervening processing by the virtual stack.

-   **root partition**

    The root partition that is created first and owns all the resources that the hypervisor does not, including most devices and system memory. The root partition hosts the virtualization stack and creates and manages the child partitions.

-   **Hyper-V-specific device**

    A virtualized device with no physical hardware analog, so guests may need a driver (virtualization service client) to that Hyper-V-specific device. The driver can use virtual machine bus (VMBus) to communicate with the virtualized device software in the root partition.

-   **virtual machine**

    A virtual computer that was created by software emulation and has the same characteristics as a real computer.

-   **virtual network switch**

    (also referred to as a virtual switch) A virtual version of a physical network switch. A virtual network can be configured to provide access to local or external network resources for one or more virtual machines.

-   **virtual processor**

    A virtual abstraction of a processor that is scheduled to run on a logical processor. A virtual machine can have one or more virtual processors.

-   **virtualization service client (VSC)**

    A software module that a guest loads to consume a resource or service. For I/O devices, the virtualization service client can be a device driver that the operating system kernel loads.

-   **virtualization service provider (VSP)**

    A provider exposed by the virtualization stack in the root partition that provides resources or services such as I/O to a child partition.

-   **virtualization stack**

    A collection of software components in the root partition that work together to support virtual machines. The virtualization stack works with and sits above the hypervisor. It also provides management capabilities.

-   **VMBus**

    Channel-based communication mechanism used for inter-partition communication and device enumeration on systems with multiple active virtualized partitions. The VMBus is installed with Hyper-V Integration Services.

## <a href="" id="arch"></a>Hyper-V architecture


Hyper-V features a Type 1 hypervisor-based architecture. The hypervisor virtualizes processors and memory and provides mechanisms for the virtualization stack in the root partition to manage child partitions (virtual machines) and expose services such as I/O devices to the virtual machines.

The root partition owns and has direct access to the physical I/O devices. The virtualization stack in the root partition provides a memory manager for virtual machines, management APIs, and virtualized I/O devices. It also implements emulated devices such as the integrated device electronics (IDE) disk controller and PS/2 input device port, and it supports Hyper-V-specific synthetic devices for increased performance and reduced overhead.

![hyper-v hypervisor-based architecture](../../media/perftune-guide-hyperv-arch.png)

The Hyper-V-specific I/O architecture consists of virtualization service providers (VSPs) in the root partition and virtualization service clients (VSCs) in the child partition. Each service is exposed as a device over VMBus, which acts as an I/O bus and enables high-performance communication between virtual machines that use mechanisms such as shared memory. The guest operating system’s Plug and Play manager enumerates these devices, including VMBus, and loads the appropriate device drivers (virtual service clients). Services other than I/O are also exposed through this architecture.

Starting with Windows Server 2008, the operating system features enlightenments to optimize its behavior when it is running in virtual machines. The benefits include reducing the cost of memory virtualization, improving multicore scalability, and decreasing the background CPU usage of the guest operating system.

The following sections suggest best practices that yield increased performance on servers running Hyper-V role.

## <a href="" id="serverconfig"></a>Hyper-V server configuration


### Hardware selection

The hardware considerations for servers running Hyper-V generally resemble those of non-virtualized servers, but servers running Hyper-V can exhibit increased CPU usage, consume more memory, and need larger I/O bandwidth because of server consolidation.

-   **Processors**

    Hyper-V in Windows Server 2016 presents the logical processors as one or more virtual processors to each active virtual machine. Hyper-V now requires processors that support Second Level Address Translation (SLAT) technologies such as Extended Page Tables (EPT) or Nested Page Tables (NPT).

-   **Cache**

    Hyper-V can benefit from larger processor caches, especially for loads that have a large working set in memory and in virtual machine configurations in which the ratio of virtual processors to logical processors is high.

-   **Memory**

    The physical server requires sufficient memory for the both the root and child partitions. The root partition requires memory to efficiently perform I/Os on behalf of the virtual machines and operations such as a virtual machine snapshot. Hyper-V ensures that sufficient memory is available to the root partition, and allows remaining memory to be assigned to child partitions. Child partitions should be sized based on the needs of the expected load for each virtual machine.

-   **Storage**

    The storage hardware should have sufficient I/O bandwidth and capacity to meet the current and future needs of the virtual machines that the physical server hosts. Consider these requirements when you select storage controllers and disks and choose the RAID configuration. Placing virtual machines with highly disk-intensive workloads on different physical disks will likely improve overall performance. For example, if four virtual machines share a single disk and actively use it, each virtual machine can yield only 25 percent of the bandwidth of that disk.

### Server Core installation option

Windows Server 2016 feature the Server Core installation option. Server Core offers a minimal environment for hosting a select set of server roles including Hyper-V. It features a smaller disk footprint for the host OS, and a smaller attack and servicing surface. Therefore, we highly recommend that Hyper-V virtualization servers use the Server Core installation option.

A Server Core installation offers a console window only when the user is logged on, but Hyper-V exposes remote management features including [Windows Powershell](http://technet.microsoft.com/library/hh848559.aspx) so administrators can manage it remotely.

### Dedicated server role

The root partition should be dedicated to Hyper-V. Running additional server roles on a server running Hyper-V can adversely affect the performance of the virtualization server, especially if they consume significant CPU, memory, or I/O bandwidth. Minimizing the server roles in the root partition has additional benefits such as reducing the attack surface.

System administrators should consider carefully what software is installed in the root partition because some software can adversely affect the overall performance of the server running Hyper-V.

### Guest operating systems

Hyper-V supports and has been tuned for a number of different guest operating systems. The number of virtual processors that are supported per guest depends on the guest operating system. For a list of the supported guest operating systems, see [Hyper-V Overview](http://technet.microsoft.com/library/hh831531.aspx).

### CPU statistics

Hyper-V publishes performance counters to help characterize the behavior of the virtualization server and report the resource usage. The standard set of tools for viewing performance counters in Windows includes Performance Monitor and Logman.exe, which can display and log the Hyper-V performance counters. The names of the relevant counter objects are prefixed with **Hyper-V**.

You should always measure the CPU usage of the physical system by using the Hyper-V Hypervisor Logical Processor performance counters. The CPU utilization counters that Task Manager and Performance Monitor report in the root and child partitions do not reflect the actual physical CPU usage. Use the following performance counters to monitor performance:

-   **Hyper-V Hypervisor Logical Processor (\*)\\% Total Run Time** The total non-idle time of the logical processors

-   **Hyper-V Hypervisor Logical Processor (\*)\\% Guest Run Time** The time spent running cycles within a guest or within the host

-   **Hyper-V Hypervisor Logical Processor (\*)\\% Hypervisor Run Time** The time spent running within the hypervisor

-   **Hyper-V Hypervisor Root Virtual Processor (\*)\\\*** Measures the CPU usage of the root partition

-   **Hyper-V Hypervisor Virtual Processor (\*)\\\*** Measures the CPU usage of guest partitions

## <a href="" id="cpu"></a>Hyper-V processor performance


### Virtual machine integration services

The Virtual Machine Integration Services include enlightened drivers for the Hyper-V-specific I/O devices, which significantly reduces CPU overhead for I/O compared to emulated devices. You should install the latest version of the Virtual Machine Integration Services in every supported virtual machine. The services decrease the CPU usage of the guests, from idle guests to heavily used guests, and improves the I/O throughput. This is the first step in tuning performance in a server running Hyper-V. For a list of supported guest operating systems, see [Hyper-V Overview](http://technet.microsoft.com/library/hh831531.aspx).

### Virtual processors

Hyper-V in Windows Server 2016 supports a maximum of 240 virtual processors per virtual machine. Virtual machines that have loads that are not CPU intensive should be configured to use one virtual processor. This is because of the additional overhead that is associated with multiple virtual processors, such as additional synchronization costs in the guest operating system.

Increase the number of virtual processors if the virtual machine requires more than one CPU of processing under peak load.

### Background activity

Minimizing the background activity in idle virtual machines releases CPU cycles that can be used elsewhere by other virtual machines. Windows guests typically use less than one percent of one CPU when they are idle. The following are several best practices for minimizing the background CPU usage of a virtual machine:

-   Install the latest version of the Virtual Machine Integration Services.

-   Remove the emulated network adapter through the virtual machine settings dialog box (use the Microsoft Hyper-V-specific adapter).

-   Remove unused devices such as the CD-ROM and COM port, or disconnect their media.

-   Keep the Windows guest operating system on the sign-in screen when it is not being used and disable the screen saver.

-   Review the scheduled tasks and services that are enabled by default.

-   Review the ETW trace providers that are on by default by running **logman.exe query -ets**

-   Improve server applications to reduce periodic activity (such as timers).

-   Close Server Manager on both the host and guest operating systems.

-   Don’t leave Hyper-V Manager running since it constantly refreshes the virtual machine’s thumbnail.

The following are additional best practices for configuring a *client version* of Windows in a virtual machine to reduce the overall CPU usage:

-   Disable background services such as SuperFetch and Windows Search.

-   Disable scheduled tasks such as Scheduled Defrag.

### Virtual NUMA

To enable virtualizing large scale-up workloads, Hyper-V in Windows Server 2016 expanded virtual machine scale limits. A single virtual machine can be assigned up to 240 virtual processors and 12 TB of memory. When creating such large virtual machines, memory from multiple NUMA nodes on the host system will likely be utilized. In such virtual machine configuration, if virtual processors and memory are not allocated from the same NUMA node, workloads may have bad performance due to the inability to take advantage of NUMA optimizations.

In Windows Server 2016, Hyper-V presents a virtual NUMA topology to virtual machines. By default, this virtual NUMA topology is optimized to match the NUMA topology of the underlying host computer. Exposing a virtual NUMA topology into a virtual machine allows the guest operating system and any NUMA-aware applications running within it to take advantage of the NUMA performance optimizations, just as they would when running on a physical computer.

There is no distinction between a virtual and a physical NUMA from the workload’s perspective. Inside a virtual machine, when a workload allocates local memory for data, and accesses that data in the same NUMA node, fast local memory access results on the underlying physical system. Performance penalties due to remote memory access are successfully avoided. Only NUMA-aware applications can benefit of vNUMA.

Microsoft SQL Server is an example of NUMA aware application. For more info, see [Understanding Non-uniform Memory Access](http://technet.microsoft.com/library/ms178144.aspx).

Virtual NUMA and Dynamic Memory features cannot be used at the same time. A virtual machine that has Dynamic Memory enabled effectively has only one virtual NUMA node, and no NUMA topology is presented to the virtual machine regardless of the virtual NUMA settings.

For more info on Virtual NUMA, see [Hyper-V Virtual NUMA Overview](http://technet.microsoft.com/library/dn282282.aspx).

## <a href="" id="memory"></a>Hyper-V memory performance


The hypervisor virtualizes the guest physical memory to isolate virtual machines from each other and to provide a contiguous, zero-based memory space for each guest operating system, just as on non-virtualized systems.

### Correct memory sizing for child partitions

You should size virtual machine memory as you typically do for server applications on a physical computer. You must size it to reasonably handle the expected load at ordinary and peak times because insufficient memory can significantly increase response times and CPU or I/O usage.

You can enable Dynamic Memory to allow Windows to size virtual machine memory dynamically. With Dynamic Memory, if applications in the virtual machine experience problems making large sudden memory allocations, you can increase the page file size for the virtual machine to ensure temporary backing while Dynamic Memory responds to the memory pressure.

For more info on Dynamic Memory, see [Hyper-V Dynamic Memory Overview]( https://go.microsoft.com/fwlink/?linkid=834434) and [Hyper-V Dynamic Memory Configuration Guide](https://go.microsoft.com/fwlink/?linkid=834435).

When running Windows in the child partition, you can use the following performance counters within a child partition to identify whether the child partition is experiencing memory pressure and is likely to perform better with a higher virtual machine memory size.

| Performance counter                                                         | Suggested threshold value                                                                                                                                                           |
|-----------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Memory – Standby Cache Reserve Bytes                                        | Sum of Standby Cache Reserve Bytes and Free and Zero Page List Bytes should be 200 MB or more on systems with 1 GB, and 300 MB or more on systems with 2 GB or more of visible RAM. |
| Memory – Free & Zero Page List Bytes                                        | Sum of Standby Cache Reserve Bytes and Free and Zero Page List Bytes should be 200 MB or more on systems with 1 GB, and 300 MB or more on systems with 2 GB or more of visible RAM. |
| Memory – Pages Input/Sec                                                    | Average over a 1-hour period is less than 10.                                                                                                                                       | 

### Correct memory sizing for root partition

The root partition must have sufficient memory to provide services such as I/O virtualization, virtual machine snapshot, and management to support the child partitions.

Hyper-V in Windows Server 2016 monitors the runtime health of the root partition’s management operating system to determine how much memory can safely be allocated to child partitions, while still ensuring high performance and reliability of the root partition.

## <a href="" id="storageio"></a>Hyper-V storage I/O performance


This section describes the different options and considerations for tuning storage I/O performance in a virtual machine. The storage I/O path extends from the guest storage stack, through the host virtualization layer, to the host storage stack, and then to the physical disk. Following are explanations about how optimizations are possible at each of these stages.

### Virtual controllers

Hyper-V offers three types of virtual controllers: IDE, SCSI, and Virtual host bus adapters (HBAs).

### IDE

IDE controllers expose IDE disks to the virtual machine. The IDE controller is emulated, and it is the only controller that is available for guest VMs running older version of Windows without the Virtual Machine Integration Services. Disk I/O that is performed by using the IDE filter driver that is provided with the Virtual Machine Integration Services is significantly better than the disk I/O performance that is provided with the emulated IDE controller. We recommend that IDE disks be used only for the operating system disks because they have performance limitations due to the maximum I/O size that can be issued to these devices.

### SCSI (SAS controller)

SCSI controllers expose SCSI disks to the virtual machine, and each virtual SCSI controller can support up to 64 devices. For optimal performance, we recommend that you attach multiple disks to a single virtual SCSI controller and create additional controllers only as they are required to scale the number of disks connected to the virtual machine. SCSI path is not emulated which makes it the preferred controller for any disk other than the operating system disk. In fact with Generation 2 VMs, it is the only type of controller possible. Introduced in Windows Server 2012 R2, this controller is reported as SAS to support shared VHDX.

### Virtual Fibre Channel HBAs

Virtual Fibre Channel HBAs can be configured to allow direct access for virtual machines to Fibre Channel and Fibre Channel over Ethernet (FCoE) LUNs. Virtual Fibre Channel disks bypass the NTFS file system in the root partition, which reduces the CPU usage of storage I/O.

Large data drives and drives that are shared between multiple virtual machines (for guest clustering scenarios) are prime candidates for virtual Fibre Channel disks.

Virtual Fibre Channel disks require one or more Fibre Channel host bus adapters (HBAs) to be installed on the host. Each host HBA is required to use an HBA driver that supports the Windows Server 2016 Virtual Fibre Channel/NPIV capabilities. The SAN fabric should support NPIV, and the HBA port(s) that are used for the virtual Fibre Channel should be set up in a Fibre Channel topology that supports NPIV.

To maximize throughput on hosts that are installed with more than one HBA, we recommend that you configure multiple virtual HBAs inside the Hyper-V virtual machine (up to four HBAs can be configured for each virtual machine). Hyper-V will automatically make a best effort to balance virtual HBAs to host HBAs that access the same virtual SAN.

### Virtual disks

Disks can be exposed to the virtual machines through the virtual controllers. These disks could be virtual hard disks that are file abstractions of a disk or a pass-through disk on the host.

### Virtual hard disks

There are two virtual hard disk formats, VHD and VHDX. Each of these formats supports three types of virtual hard disk files.

### VHD format

The VHD format was the only virtual hard disk format that was supported by Hyper-V in past releases. Introduced in Windows Server 2012, the VHD format has been modified to allow better alignment, which results in significantly better performance on new large sector disks.

Any new VHD that is created on a Windows Server 2012 or newer has the optimal 4 KB alignment. This aligned format is completely compatible with previous Windows Server operating systems. However, the alignment property will be broken for new allocations from parsers that are not 4 KB alignment-aware (such as a VHD parser from a previous version of Windows Server or a non-Microsoft parser).

Any VHD that is moved from a previous release does not automatically get converted to this new improved VHD format.

To convert to new VHD format, run the following Windows PowerShell command:

``` syntax
Convert-VHD –Path E:\vms\testvhd\test.vhd –DestinationPath E:\vms\testvhd\test-converted.vhd
```

You can check the alignment property for all the VHDs on the system, and it should be converted to the optimal 4 KB alignment. You create a new VHD with the data from the original VHD by using the **Create-from-Source** option.

To check for alignment by using Windows Powershell, examine the Alignment line, as shown below:

``` syntax
Get-VHD –Path E:\vms\testvhd\test.vhd

Path                    : E:\vms\testvhd\test.vhd
VhdFormat               : VHD
VhdType                 : Dynamic
FileSize                : 69245440
Size                    : 10737418240
MinimumSize             : 10735321088
LogicalSectorSize       : 512
PhysicalSectorSize      : 512
BlockSize               : 2097152
ParentPath              :
FragmentationPercentage : 10
Alignment               : 0
Attached                : False
DiskNumber              :
IsDeleted               : False
Number                  :
```

To verify alignment by using Windows PowerShell, examine the Alignment line, as shown below:

``` syntax
Get-VHD –Path E:\vms\testvhd\test-converted.vhd

Path                    : E:\vms\testvhd\test-converted.vhd
VhdFormat               : VHD
VhdType                 : Dynamic
FileSize                : 69369856
Size                    : 10737418240
MinimumSize             : 10735321088
LogicalSectorSize       : 512
PhysicalSectorSize      : 512
BlockSize               : 2097152
ParentPath              :
FragmentationPercentage : 0
Alignment               : 1
Attached                : False
DiskNumber              :
IsDeleted               : False
Number                  :
```

### VHDX format

VHDX is a new virtual hard disk format introduced in Windows Server 2012, which allows you to create resilient high-performance virtual disks up to 64 terabytes. Benefits of this format include:

-   Support for virtual hard disk storage capacity of up to 64 terabytes.

-   Protection against data corruption during power failures by logging updates to the VHDX metadata structures.

-   Ability to store custom metadata about a file, which a user might want to record, such as operating system version or patches applied.

The VHDX format also provides the following performance benefits:

-   Improved alignment of the virtual hard disk format to work well on large sector disks.

-   Larger block sizes for dynamic and differential disks, which allows these disks to attune to the needs of the workload.

-   4 KB logical sector virtual disk that allows for increased performance when used by applications and workloads that are designed for 4 KB sectors.

-   Efficiency in representing data, which results in smaller file size and allows the underlying physical storage device to reclaim unused space. (Trim requires pass-through or SCSI disks and trim-compatible hardware.)

When you upgrade to Windows Server 2016, we recommend that you convert all VHD files to the VHDX format due to these benefits. The only scenario where it would make sense to keep the files in the VHD format is when a virtual machine has the potential to be moved to a previous release of Hyper-V that does not support the VHDX format.

### Types of virtual hard disk files

There are three types of VHD files. The following sections are the performance characteristics and trade-offs between the types.

The following recommendations should be taken into consideration with regards to selecting a VHD file type:

-   When using the VHD format, we recommend that you use the fixed type because it has better resiliency and performance characteristics compared to the other VHD file types.

-   When using the VHDX format, we recommend that you use the dynamic type because it offers resiliency guarantees in addition to space savings that are associated with allocating space only when there is a need to do so.

-   The fixed type is also recommended, irrespective of the format, when the storage on the hosting volume is not actively monitored to ensure that sufficient disk space is present when expanding the VHD file at run time.

-   Snapshots of a virtual machine create a differencing VHD to store writes to the disks. Having only a few snapshots can elevate the CPU usage of storage I/Os, but might not noticeably affect performance except in highly I/O-intensive server workloads. However, having a large chain of snapshots can noticeably affect performance because reading from the VHD can require checking for the requested blocks in many differencing VHDs. Keeping snapshot chains short is important for maintaining good disk I/O performance.

### Fixed virtual hard disk type

Space for the VHD is first allocated when the VHD file is created. This type of VHD file is less likely to fragment, which reduces the I/O throughput when a single I/O is split into multiple I/Os. It has the lowest CPU overhead of the three VHD file types because reads and writes do not need to look up the mapping of the block.

### Dynamic virtual hard disk type

Space for the VHD is allocated on demand. The blocks in the disk start as unallocated blocks and are not backed by any actual space in the file. When a block is first written to, the virtualization stack must allocate space within the VHD file for the block, and then update the metadata. This increases the number of necessary disk I/Os for the Write and increases CPU usage. Reads and writes to existing blocks incur disk access and CPU overhead when looking up the blocks’ mapping in the metadata.

### Differencing virtual hard disk type

The VHD points to a parent VHD file. Any writes to blocks not written to result in space being allocated in the VHD file, as with a dynamically expanding VHD. Reads are serviced from the VHD file if the block has been written to. Otherwise, they are serviced from the parent VHD file. In both cases, the metadata is read to determine the mapping of the block. Reads and Writes to this VHD can consume more CPU and result in more I/Os than a fixed VHD file.

### Block size considerations

Block size can significantly impact performance. It is optimal to match the block size to the allocation patterns of the workload that is using the disk. For example, if an application is allocating in chunks of 16 MB, it would be optimal to have a virtual hard disk block size of 16 MB. A block size of &gt;2 MB is possible only on virtual hard disks with the VHDX format. Having a larger block size than the allocation pattern for a random I/O workload will significantly increase the space usage on the host.

### Sector size implications

Most of the software industry has depended on disk sectors of 512 bytes, but the standard is moving to 4 KB disk sectors. To reduce compatibility issues that might arise from a change in sector size, hard drive vendors are introducing a transitional size referred to as 512 emulation drives (512e).

These emulation drives offer some of the advantages that are offered by 4 KB disk sector native drives, such as improved format efficiency and an improved scheme for error correction codes (ECC). They come with fewer compatibility issues that would occur by exposing a 4 KB sector size at the disk interface.

### Support for 512e disks

A 512e disk can perform a write only in terms of a physical sector—that is, it cannot directly write a 512byte sector that is issued to it. The internal process in the disk that makes these writes possible follows these steps:

-   The disk reads the 4 KB physical sector to its internal cache, which contains the 512-byte logical sector referred to in the write.

-   Data in the 4 KB buffer is modified to include the updated 512-byte sector.

-   The disk performs a write of the updated 4 KB buffer back to its physical sector on the disk.

This process is called read-modify-write (RMW). The overall performance impact of the RMW process depends on the workloads. The RMW process causes performance degradation in virtual hard disks for the following reasons:

-   Dynamic and differencing virtual hard disks have a 512-byte sector bitmap in front of their data payload. In addition, footer, header, and parent locators align to a 512-byte sector. It is common for the virtual hard disk driver to issue 512-byte write commands to update these structures, resulting in the RMW process described earlier.

-   Applications commonly issue reads and writes in multiples of 4 KB sizes (the default cluster size of NTFS). Because there is a 512-byte sector bitmap in front of the data payload block of dynamic and differencing virtual hard disks, the 4 KB blocks are not aligned to the physical 4 KB boundary. The following figure shows a VHD 4 KB block (highlighted) that is not aligned with physical 4 KB boundary.

![vhd 4 kb block](../../media/perftune-guide-vhd-4kb-block.png)

Each 4 KB write command that is issued by the current parser to update the payload data results in two reads for two blocks on the disk, which are then updated and subsequently written back to the two disk blocks. Hyper-V in Windows Server 2016 mitigates some of the performance effects on 512e disks on the VHD stack by preparing the previously mentioned structures for alignment to 4 KB boundaries in the VHD format. This avoids the RMW effect when accessing the data within the virtual hard disk file and when updating the virtual hard disk metadata structures.

As mentioned earlier, VHDs that are copied from previous versions of Windows Server will not automatically be aligned to 4 KB. You can manually convert them to optimally align by using the **Copy from Source** disk option that is available in the VHD interfaces.

By default, VHDs are exposed with a physical sector size of 512 bytes. This is done to ensure that physical sector size dependent applications are not impacted when the application and VHDs are moved from a previous version of Windows Server.

By default, disks with the VHDX format are created with the 4 KB physical sector size to optimize their performance profile regular disks and large sector disks. To make full use of 4 KB sectors it’s recommended to use VHDX format.

### Support for native 4 KB disks

Hyper-V in Windows Server 2012 R2 and beyond supports 4 KB native disks. But it is still possible to store VHD disk on 4 KB native disk. This is done by implementing a software RMW algorithm in the virtual storage stack layer that converts 512-byte access and update requests to corresponding 4 KB accesses and updates.

Because VHD file can only expose themselves as 512-byte logical sector size disks, it is very likely that there will be applications that issue 512-byte I/O requests. In these cases, the RMW layer will satisfy these requests and cause performance degradation. This is also true for a disk that is formatted with VHDX that has a logical sector size of 512 bytes.

It is possible to configure a VHDX file to be exposed as a 4 KB logical sector size disk, and this would be an optimal configuration for performance when the disk is hosted on a 4 KB native physical device. Care should be taken to ensure that the guest and the application that is using the virtual disk are backed by the 4 KB logical sector size. The VHDX formatting will work correctly on a 4 KB logical sector size device.

### Pass-through disks

The VHD in a virtual machine can be mapped directly to a physical disk or logical unit number (LUN), instead of to a VHD file. The benefit is that this configuration bypasses the NTFS file system in the root partition, which reduces the CPU usage of storage I/O. The risk is that physical disks or LUNs can be more difficult to move between machines than VHD files.

Pass-through disks should be avoided due to the limitations introduced with virtual machine migration scenarios.

### Advanced storage features

### Storage Quality of Service (QoS)

Starting in Windows Server 2012 R2, Hyper-V includes the ability to set certain quality-of-service (QoS) parameters for storage on the virtual machines. Storage QoS provides storage performance isolation in a multitenant environment and mechanisms to notify you when the storage I/O performance does not meet the defined threshold to efficiently run your virtual machine workloads.

Storage QoS provides the ability to specify a maximum input/output operations per second (IOPS) value for your virtual hard disk. An administrator can throttle the storage I/O to stop a tenant from consuming excessive storage resources that may impact another tenant.

You can also set a minimum IOPS value. They will be notified when the IOPS to a specified virtual hard disk is below a threshold that is needed for its optimal performance.

The virtual machine metrics infrastructure is also updated, with storage related parameters to allow the administrator to monitor the performance and chargeback related parameters.

Maximum and minimum values are specified in terms of normalized IOPS where every 8 KB of data is counted as an I/O.

Some of the limitations are as follows:

-   Only for virtual disks

-   Differencing disk cannot have parent virtual disk on a different volume

-   Replica - QoS for replica site configured separately from primary site

-   Shared VHDX is not supported

For more info on Storage Quality of Service, see [Storage Quality of Service for Hyper-V](http://technet.microsoft.com/library/dn282281.aspx).

### NUMA I/O

Windows Server 2012 and beyond supports large virtual machines, and any large virtual machine configuration (for example, a configuration with Microsoft SQL Server running with 64 virtual processors) will also need scalability in terms of I/O throughput.

The following key improvements first introduced in the Windows Server 2012 storage stack and Hyper-V provide the I/O scalability needs of large virtual machines:

-   An increase in the number of communication channels created between the guest devices and host storage stack.

-   A more efficient I/O completion mechanism involving interrupt distribution amongst the virtual processors to avoid expensive interprocessor interruptions.

Introduced in Windows Server 2012, there are a few registry entries, located at HKLM\\System\\CurrentControlSet\\Enum\\VMBUS\\{device id}\\{instance id}\\StorChannel, that allow the number of channels to be adjusted. They also align the virtual processors that handle the I/O completions to the virtual CPUs that are assigned by the application to be the I/O processors. The registry settings are configured on a per-adapter basis on the device’s hardware key.

-   **ChannelCount (DWORD)** The total number of channels to use, with a maximum of 16. It defaults to a ceiling, which is the number of virtual processors/16.

-   **ChannelMask (QWORD)** The processor affinity for the channels. If it is not set or is set to 0, it defaults to the existing channel distribution algorithm that you use for normal storage or for networking channels. This ensures that your storage channels won’t conflict with your network channels.

### Offloaded Data Transfer integration

Crucial maintenance tasks for VHDs, such as merge, move, and compact, depend copying large amounts of data. The current method of copying data requires data to be read in and written to different locations, which can be a time-consuming process. It also uses CPU and memory resources on the host, which could have been used to service virtual machines.

Storage area network (SAN) vendors are working to provide near-instantaneous copy operations of large amounts of data. This storage is designed to allow the system above the disks to specify the move of a specific data set from one location to another. This hardware feature is known as an Offloaded Data Transfer.

Hyper-V in Windows Server 2012 and beyond supports Offload Data Transfer (ODX) operations so that these operations can be passed from the guest operating system to the host hardware. This ensures that the workload can use ODX-enabled storage as it would if it were running in a non-virtualized environment. The Hyper-V storage stack also issues ODX operations during maintenance operations for VHDs such as merging disks and storage migration meta-operations where large amounts of data are moved.

### Unmap integration

Virtual hard disk files exist as files on a storage volume, and they share available space with other files. Because the size of these files tends to be large, the space that they consume can grow quickly. Demand for more physical storage affects the IT hardware budget. It’s important to optimize the use of physical storage as much as possible.

Before Windows Server 2012, when applications delete content within a virtual hard disk, which effectively abandoned the content’s storage space, the Windows storage stack in the guest operating system and the Hyper-V host had limitations that prevented this information from being communicated to the virtual hard disk and the physical storage device. This prevented the Hyper-V storage stack from optimizing the space usage by the VHD-based virtual disk files. It also prevented the underlying storage device from reclaiming the space that was previously occupied by the deleted data.

Starting from Windows Server 2012, Hyper-V supports unmap notifications, which allow VHDX files to be more efficient in representing that data within it. This results in smaller files size, and it allows the underlying physical storage device to reclaim unused space.

Only Hyper-V-specific SCSI, enlightened IDE, and Virtual Fibre Channel controllers allow the unmap command from the guest to reach the host virtual storage stack. On the virtual hard disks, only virtual disks formatted as VHDX support unmap commands from the guest.

For these reasons, we recommend that you use VHDX files attached to a SCSI controller when not using Virtual Fibre Channel disks.


## <a href="" id="netio"></a>Hyper-V network I/O performance

Server 2016 contains several improvements and new functionality to optimize network performance under Hyper-V.  Documentation on how to optimize network performance will be included in a future version of this article.

### Live Migration

Live Migration lets you to transparently move running virtual machines from one node of a failover cluster to another node in the same cluster without a dropped network connection or perceived downtime.

**Note**  
Failover Clustering requires shared storage for the cluster nodes.

 

The process of moving a running virtual machine can be divided into two major phases. The first phase copies the memory of the virtual machine from the current host to the new host. The second phase transfers the virtual machine state from the current host to the new host. The durations of both phases is greatly determined by the speed at which data can be transferred from the current host to the new host.

Providing a dedicated network for live migration traffic helps minimize the time that is required to complete a live migration, and it ensures consistent migration times.

![example hyper-v live migration configuration](../../media/perftune-guide-live-migration.png)

Additionally, increasing the number of send and receive buffers on each network adapter that is involved in the migration can improve migration performance.

Windows Server 2012 R2 introduced an option to speed up Live Migration by compressing memory before transferring over the network or use Remote Direct Memory Access (RDMA), if your hardware supports it.

## <a href="" id="bottle"></a>Detecting bottlenecks in a virtualized environment


This section should give you some hints on what to monitor by using Performance Monitor and how to identify where the problem might be when either the host or some of the virtual machines do not perform as you would have expected.

### Processor bottlenecks

Here are some common scenarios that could cause processor bottlenecks:

-   One or more logical processors are loaded

-   One or more virtual processors are loaded

You can use the following performance counters from the host:

-   Logical Processor Utilization - \\Hyper-V Hypervisor Logical Processor(\*)\\% Total Run Time

-   Virtual Processor Utilization - \\Hyper-V Hypervisor Virtual Processor(\*)\\% Total Run Time

-   Root Virtual Processor Utilization - \\Hyper-V Hypervisor Root Virtual Processor(\*)\\% Total Run Time

If the **Hyper-V Hypervisor Logical Processor(\_Total)\\% Total Runtime** counter is over 90%, the host is overloaded. You should add more processing power or move some virtual machines to a different host.

If the **Hyper-V Hypervisor Virtual Processor(VM Name:VP x)\\% Total Runtime** counter is over 90% for all virtual processors, you should do the following:

-   Verify that the host is not overloaded

-   Find out if the workload can leverage more virtual processors

-   Assign more virtual processors to the virtual machine

If **Hyper-V Hypervisor Virtual Processor(VM Name:VP x)\\% Total Runtime** counter is over 90% for some, but not all, of the virtual processors, you should do the following:

-   If your workload is receive network-intensive, you should consider using vRSS.

-   If the virtual machines are not running Windows Server 2012 R2, you should add more network adapters.

-   If your workload is storage-intensive, you should enable virtual NUMA and add more virtual disks.

If the **Hyper-V Hypervisor Root Virtual Processor (Root VP x)\\% Total Runtime** counter is over 90% for some, but not all, virtual processors and the **Processor (x)\\% Interrupt Time and Processor (x)\\% DPC Time** counter approximately adds up to the value for the **Root Virtual Processor(Root VP x)\\% Total Runtime** counter, you should ensure enable VMQ on the network adapters.

### Memory bottlenecks

Here are some common scenarios that could cause memory bottlenecks:

-   The host is not responsive.

-   Virtual machines cannot be started.

-   Virtual machines run out of memory.

You can use the following performance counters from the host:

-   Memory\\Available Mbytes

-   Hyper-V Dynamic Memory Balancer (\*)\\Available Memory

You can use the following performance counters from the virtual machine:

-   Memory\\Available Mbytes

If the **Memory\\Available Mbytes** and **Hyper-V Dynamic Memory Balancer (\*)\\Available Memory** counters are low on the host, you should stop non-essential services and migrate one or more virtual machines to another host.

If the **Memory\\Available Mbytes** counter is low in the virtual machine, you should assign more memory to the virtual machine. If you are using Dynamic Memory, you should increase the maximum memory setting.

### Network bottlenecks

Here are some common scenarios that could cause network bottlenecks:

-   The host is network bound.

-   The virtual machine is network bound.

You can use the following performance counters from the host:

-   Network Interface(*network adapter name*)\\Bytes/sec

You can use the following performance counters from the virtual machine:

-   Hyper-V Virtual Network Adapter (*virtual machine name name&lt;GUID&gt;*)\\Bytes/sec

If the **Physical NIC Bytes/sec** counter is greater than or equal to 90% of capacity, you should add additional network adapters, migrate virtual machines to another host, and configure Network QoS.

If the **Hyper-V Virtual Network Adapter Bytes/sec** counter is greater than or equal to 250 MBps, you should add additional teamed network adapters in the virtual machine, enable vRSS, and use SR-IOV.

If your workloads can’t meet their network latency, enable SR-IOV to present physical network adapter resources to the virtual machine.

### Storage bottlenecks

Here are some common scenarios that could cause storage bottlenecks:

-   The host and virtual machine operations are slow or time out.

-   The virtual machine is sluggish.

You can use the following performance counters from the host:

-   Physical Disk(*disk letter*)\\Avg. disk sec/Read

-   Physical Disk(*disk letter*)\\Avg. disk sec/Write

-   Physical Disk(*disk letter*)\\Avg. disk read queue length

-   Physical Disk(*disk letter*)\\Avg. disk write queue length

If latencies are consistently greater than 50ms, you should do the following:

-   Spread virtual machines across additional storage

-   Consider purchasing faster storage

-   Consider Tiered Storage Spaces, which was introduced in Windows Server 2012 R2

-   Consider using Storage QoS, which was introduced in Windows Server 2012 R2

-   Use VHDX

## <a href="" id="linux"></a>Linux Virtual Machines

Linux and BSD virtual machines have additional considerations compared to Windows virtual machines in Hyper-V.

The first consideration is whether Integration Services are present or if the VM is running merely on emulated hardware with no enlightenment. A table of Linux and BSD releases that have built-in or downloadable Integration Services is available in [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](https://technet.microsoft.com/en-us/windows-server-docs/compute/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows). These pages have grids of available Hyper-V features available to Linux distribution releases, and notes on those features where applicable.

Even when the guest is running Integration Services, it can be configured with legacy hardware which does not exhibit the best performance. For example, configure and use a virtual ethernet adapter for the guest instead of using a legacy network adapter. With Windows Server 2016, advanced networking like SR-IOV are available as well.

### Linux Network Performance

Linux by default enables hardware acceleration and offloads by default. If vRSS is enabled in the properties of a NIC on the host and the Linux guest has the capability to use vRSS the capability will be enabled. In Powershell this same parameter can be changed with the <pre>EnableNetAdapterRSS</pre> command.

Similarly, the VMMQ (Virtual Switch RSS) feature can be enabled on the physical NIC used by the guest "Properties" > "Configure..." > "Advanced" Tab > set "Virtual Switch RSS" to "Enabled" or enable VMMQ in Powershell: <pre>Set-VMNetworkAdapter -VMName **$VMName** -VmmqEnabled $True</pre>

In the guest additional TCP tuning can be performed by increasing limits. For the best performance sprading workload over multiple CPUs and having deep workloads produces the best throughput, as virtualized workloads will have higher latency than "bare metal" ones.

Some example tuning paramters that have been useful in network benchmarks include:

```
net.core.netdev_max_backlog = 30000
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_wmem = 4096 12582912 33554432
net.ipv4.tcp_rmem = 4096 12582912 33554432
net.ipv4.tcp_max_syn_backlog = 80960
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 10240 65535
net.ipv4.tcp_abort_on_overflow = 1
```

A useful tool for network microbenchmarks is ntttcp, which is available on both Linux and Windows. The Linux version is open source and available from [ntttcp-for-linux on github.com](https://github.com/Microsoft/ntttcp-for-linux). The Windows version can be found in the [download center](https://gallery.technet.microsoft.com/NTttcp-Version-528-Now-f8b12769). When tuning workloads it is best to use as many streams as necessary to get the best throughput. Using ntttcp to model traffic, the <pre>-P</pre> parameter sets the number of parallel connections used.

### Linux Storage Performance

Some best practices, like the following, are listed on [Best Practices for Running Linux on Hyper-V](https://technet.microsoft.com/en-us/windows-server-docs/compute/hyper-v/best-practices-for-running-linux-on-hyper-v). The Linux kernel has different I/O schedulers to reorder requests with different algorithms. NOOP is a first-in first-out queue that passes the schedule decision to be made by the hypervisor. It is recommended to use NOOP as the scheduler when running Linux virtual machine on Hyper-V. To change the scheduler for a specific device, in the boot loader's configuration (/etc/grub.conf, for example), add <pre>elevator=noop</pre> to the kernel parameters, and then restart.

Similar to networking, Linux guest performance with storage benefits the most from multiple queues with enough depth to keep the host busy. Microbenchmarking storage performance is probably best with the fio benchmark tool with the libaio engine.
