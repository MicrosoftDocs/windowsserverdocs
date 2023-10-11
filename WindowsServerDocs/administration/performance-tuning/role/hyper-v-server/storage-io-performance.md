---
title: Hyper-V storage I/O performance
description: Learn about storage I/O performance considerations in Hyper-V performance tuning, including advantages, limitations, and recommendations.
ms.topic: article
ms.author: wscontent
author: phstee
ms.date: 06/02/2023
---

# Hyper-V storage I/O performance

This article explores different options and considerations for tuning storage input/output (I/O) performance in a virtual machine (VM). The storage I/O path extends across four successive stages:

1. Guest storage stack
1. Host virtualization layer
1. Host storage stack
1. Physical disk

The following sections describe the optimizations possible for each stage.

## Virtual controllers

Hyper-V offers three types of virtual controllers:

- Integrated Drive Electronics (IDE)

- Small computer system interface (SCSI)

- Virtual Fibre Channel host bus adapters (HBAs)

### IDE

IDE controllers are emulatee controllers that expose IDE disks to the VM. This type of controller is the only option for guest VMs running earlier versions of Windows without [Hyper-V VM integration services](/virtualization/hyper-v-on-windows/reference/integration-services). The IDE filter driver that integration services provides can perform disk I/O much better than the emulated IDE controller.

We recommend that you only use IDE disks for OS disks. OS disks have performance limitations based on the maximum I/O size for their devices.

### SCSI (SAS controller)

SCSI controllers are virtual controllers that expose SCSI disks to the VM. Each SCSI controller supports up to 64 devices. The SCSI path isn't emulated, which makes it the preferred controller for any disk other than the OS disk. SCSI controllers are supported by Windows Server 2012 R2 and later, but only in scenarios where you report the controller as a Serial Attached SCSI (SAS) for supporting a shared virtual hard disk (VHDX).

For best performance, we recommend you attach multiple disks to a single virtual SCSI controller. You should only crate more controllers if you have no other options for scaling how many disks are connected to the VM.

### Virtual Fibre Channel HBAs

Configure Virtual Fibre Channel HBAs to allow VMs to directly access Fibre Channel and Fibre Channel over Ethernet (FCoE) logical unit numbers (LUNs). Virtual Fibre Channel disks bypass the NTFS file system in the root partition, which reduces storage I/O central processing unit (CPU) usage. Virtual Fibre Channel disks are great for large data drives and drives shared between multiple VMs in guest clustering scenarios.

To use Virtual Fibre Channel disks, you must install one or more Fibre Channel HBAs on the host machine. Each host HBA must use HBA drivers that support Windows Server 2016 Virtual Fibre Channel or N_Port ID Virtualization (NPIV) capabilities. The Storage Area Network (SAN) fabric should also support NPIV, and you should configure the HBA ports for the Fibre Channel in a Fiber Channel topology that supports NPIV.

To maximize throughput on hosts with more than one HBA, we recommend you configure many virtual HBAs inside the Hyper-V VM. You can configure up to four HBAs for each VM. Hyper-V automatically balances virtual HBAs to host HBAs accessing the same virtual SAN.

## Virtual disks

Virtual disks are exposed to the VMs by virtual controllers and can be virtual hard disks or pass-through disks on the host.

Virtual disks come in VHD or VHDX formats. Each format supports three types of virtual hard disk files.

If you upgrade your deployment to Windows Server 2106 or later, we recommend you convert all VHD files to VHDX format. For more information, see [VHDX format](#vhdx-format).

### VHD format

Windows Server 2012 and later support the VHD format. Earlier versions of Hyper-V only support VHD format. Later versions of Hyper-V include improvements to their VHD format that allows for better alignment. <!--Is this talking about VHDX?--> As a result, later versions of Hyper-V perform much better on large sector disks.

Any VHD you create in Windows Server 2012 or later has the optimal four-kilobyte alignment. This aligned format is fully compatible with earlier versions of WIndows Server. However, the alignment property doesn't support new allocations from parsers that aren't 4 KB alignment-aware, such as a parser from an earlier version of WIndows Server or a non-Microsoft parser.

#### Convert disk to VHD format

<!--Where I left off-->

When you move a VHD from an earlier release of Hyper-V or Windows Server to a later release, the system doesn't automatically convert the disk to the newer improved VHD format.

To convert an existing virtual disk to use the newer VHD format, you can use the `Convert-VHD` PowerShell command:

```powershell
Convert-VHD –Path E:\vms\testvhd\test.vhd –DestinationPath E:\vms\testvhd\test-converted.vhd
```

In this example, the source disk to convert is **test.vhd**, and the new (converted) disk is **test-converted.vhd**. When you run the command, update the `-Path` and `-DestinationPath` values as required for your disk conversion.

> [!NOTE]
> The new (converted) VHD is created with the data from the source VHD via the **Copy from Source** disk option. For more information, see the [Convert-VHD](/powershell/module/hyper-v/convert-vhd) command in the Window PowerShell Hyper-V reference.

#### Check disk alignment

You can check the `Alignment` property for the VHDs in your system. After you convert a disk, you can view the property to ensure the new disk uses the optimal 4-KB alignment. 

To check the alignment setting for a disk, you can use the `Get-VHD` PowerShell command. Run the command for the source disk, and then again for the converted disk. Compare the values for the `Alignment` property to ensure the new (converted) disk is 4 KB alignment-aware.

1. Run the `Get-VHD` command to view the alignment setting for the source disk. 

   ```powershell
   Get-VHD –Path E:\vms\testvhd\test.vhd
   ```

   In this example, the source disk is named **test.vhd**. When you run the command on your system, update the `-Path` value for your source disk.

1. In the output, notice the value for the `Alignment` property. In this example, the value is `0`, which means the disk isn't 4 KB alignment-aware.

   ```output
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

1. Run the  `Get-VHD` command again to get the details for the new (converted) disk. 

   ```powershell
   Get-VHD –Path E:\vms\testvhd\test-converted.vhd
   ```

   In this example, the new (converted) disk is named **test-converted.vhd**. When you run the command on your system, update the `-Path` value for your converted disk.

1. In the output, check the value for the `Alignment` property. The value should be `1`, which means the disk is successfully converted to the newer VHD format and is 4 KB alignment-aware.

   ```output
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

VHDX is a new virtual hard disk format introduced in Windows Server 2012. This format allows you to create resilient high-performance virtual disks up to 64 terabytes.

Here are some benefits of the VHDX format:

- Support for virtual hard disk storage capacity of up to 64 terabytes

- Protection against data corruption during power failures by logging updates to the VHDX metadata structures

- Ability to store custom metadata for a file that a user might want to record, such as the OS version or applied patches

The VHDX format also provides several performance features:

- Improved alignment of the virtual hard disk format to work well on large sector disks

- Larger block sizes for dynamic and differential disks to enable disks to adjust for workload requirements

- 4-KB logical sector virtual disk to support increased performance when used by applications and workloads designed for 4-KB sectors

- Efficiency in representing data to produce smaller file sizes and allow underlying physical storage device to reclaim unused space

   > [!NOTE]
   > Trimming requires pass-through or SCSI disks and trim-compatible hardware.

**Recommendation**: When you upgrade to Windows Server 2016, convert all VHD files to the VHDX format. Only maintain files in VHD format when the VM can potentially move to an earlier release of Hyper-V that doesn't support VHDX format.

## Virtual files

There are three types of VHD files: fixed, dynamic, and differencing. 

**Recommendation**: As you compare the VHD file types, consider the following recommendations.

| File type | Disk format | Recommendation |
| --- | --- | --- |
| **Fixed** | VHD | Use the fixed file type for optimal resiliency and performance. |
| **Fixed** | Any | Use the fixed file type when storage on the hosting volume isn't actively monitored. Ensure sufficient disk space is present when expanding the VHD file at run time. |
| **Dynamic** | VHDX | Use the dynamic file type for resiliency guarantees and to allocate disk space only as needed. |
| **Differencing** | Any | Keep VM snapshot chains short to maintain good disk I/O performance. |

### Fixed file type

Space for the VHD is first allocated when the VHD file is created. This type of VHD file is less likely to fragment, which reduces the I/O throughput when a single I/O is split into multiple I/Os. The fixed file type has the lowest CPU overhead of the three options because `Reads` and `Writes` don't need to look up the mapping of the block.

### Dynamic file type

Space for the VHD is allocated on demand. The blocks in the disk start as unallocated blocks. No actual space in the file backs the unallocated blocks. When a block receives the first Write, the virtualization stack must allocate space within the VHD file for the block, and then update the metadata. This action increases the number of necessary disk I/Os for the Write and increases CPU usage. `Reads` and `Writes` to existing blocks incur disk access and CPU overhead when looking up the blocks' mapping in the metadata.

### Differencing file type

Snapshots of a VM create a differencing VHD to store `Writes` to the disks. The VHD points to a parent VHD file. Any `Writes` to blocks without existing `Writes` cause space to be allocated in the VHD file, as with a dynamically expanding VHD. `Reads` are serviced from the VHD file if the block contains `Writes`. Otherwise, the blocks are serviced from the parent VHD file. In both cases, the metadata is read to determine the mapping of the block. `Reads` and `Writes` to this VHD can consume more CPU and result in more I/Os than a fixed VHD file.

When there are only a few snapshots, the CPU usage of storage I/Os can be elevated, but performance might not be noticeably affected except in highly I/O-intensive server workloads. Maintaining a large chain of snapshots can noticeably affect performance. Reading from the VHD can require checking for the requested blocks in many differencing VHDs. It's important to keep snapshot chains short to maintain good disk I/O performance.

## Size considerations

There are two size implementations to consider for disk optimization: blocks and sectors.

### Block size

Block size can significantly affect performance. The best approach is to match the block size to the allocation patterns of the workloads that use the disk. If an application allocates blocks in chunks of 16 MB, it's optimal to have a virtual hard disk block size of 16 MB. A block size larger than 2 MB is possible only on virtual hard disks with the VHDX format. When the block size is larger than the allocation pattern for a random I/O workload, you can significantly increase the space usage on the host.

**Recommendation**: Match the disk block size to the allocation patterns of the workloads that use the disk. 

### Sector size

Software organizations frequently depend on disk sectors of 512 bytes, but the industry standard is moving to 4-KB disk sectors. To reduce compatibility issues that can arise from changes in sector size, hard drive vendors are introducing a transitional size referred to as **512 emulation drives (512e)**.

Emulation drives offer some of the advantages provided by 4-KB disk sector native drives, such as improved format efficiency and an improved scheme for error correction codes (ECC). Emulation drives present fewer compatibility issues that can occur by exposing a 4-KB sector size at the disk interface.

**Recommendation**: To make full use of 4-KB sectors, use VHDX format rather than disk sectors of 512 bytes. To reduce compatibility issues between disk sizes, implement 512e drives for transitional sizing.

#### Support transitional size with 512e disks

A 512e disk can perform a Write only in terms of a physical sector. This type of disk can't directly write a 512-byte sector to which it's issued. The disk has an internal process that makes the `Write` operations possible. The process involves `Read-Modify-Write` (RMW) operations and implements the following steps:

1. The disk `Reads` the 4-KB physical sector to its internal cache. The cache contains the 512-byte logical sector referred to in the `Write` operation.

1. The disk `Modifies` the data in the 4-KB buffer to include the updated 512-byte sector.

1. The disk `Writes` the updated 4-KB buffer back to its physical sector on the disk.

The overall performance impact of the RMW process depends on the workloads. The RMW process causes performance degradation in virtual hard disks for the following reasons:

- Dynamic and differencing virtual hard disks have a 512-byte sector bitmap in front of their data payload. Footer, header, and parent locators align to a 512-byte sector. It's common for the virtual hard disk driver to execute 512-byte `Write` operations to update these structures, which result in the RMW process previously described.

- Applications commonly execute `Reads` and `Writes` in multiples of 4-KB sizes (the default cluster size of NTFS). Dynamic and differencing virtual hard disks have a 512-byte sector bitmap in front of the data payload block. This bitmap causes the 4-KB blocks to not align to the physical 4-KB boundary. The following figure shows a VHD 4-KB block (highlighted) that's not aligned with the physical 4-KB boundary.

   :::image type="content" source="../../media/perftune-guide-vhd-4kb-block.png" alt-text="Diagram of a VHD 4-KB block that's not aligned with the physical 4-KB boundary." border="false":::

Each 4-KB `Write` operation by the current parser to update the payload data results in two `Reads` for two blocks on the disk. The blocks are then updated and written back to the two disk blocks. Hyper-V in Windows Server 2016 mitigates some performance effects on 512e disks on the VHD stack. Hyper-V prepares the structures for alignment to 4-KB boundaries in the VHD format. The mitigation avoids the RMW effect on access to data within the virtual hard disk file and updates to the virtual hard disk metadata structures.

As previously mentioned, VHDs copied from earlier versions of Windows Server aren't automatically aligned to 4 KB. You can manually convert the disk to optimally align via the **Copy from Source** disk option with the `Convert-VHD` command.

By default, VHDs are exposed with a physical sector size of 512 bytes. This method ensures the physical-sector-size dependent applications aren't impacted when the application and VHDs are moved from an earlier version of Windows Server.

By default, disks with the VHDX format are created with the 4-KB physical sector size to optimize their performance profile on regular disks and larger sector disks. 

**Recommendation**: To reduce compatibility issues between disk sizes, implement 512e drives for transitional sizing. To make full use of 4-KB sectors, use VHDX format.

## Native 4-KB disks

Hyper-V in Windows Server 2012 R2 and later supports 4-KB native disks. You can also store VHD disk data on a 4-KB native disk by implementing a software RMW algorithm in the virtual storage stack layer. The algorithm converts 512-byte access and update requests to corresponding 4-KB accesses and updates.

Because VHD files can only expose as 512-byte logical-sector size disks, it's likely there are applications that issue 512-byte I/O requests. In such cases, the RMW algorithm in the storage stack layer satisfies the requests and causes performance degradation. The same result occurs for VHDX disks with a logical-sector size of 512 bytes.

It's possible to configure VHDX files to expose as a 4-KB logical-sector size disk. This implementation is an optimal configuration for performance for disks hosted on a 4-KB native physical device. However, be careful to ensure the 4-KB logical-sector size supports both the guest and application that use the virtual disk. The VHDX format works correctly on a 4-KB logical-sector size device.

**Recommendation**: Avoid using 4-KB native disks with VHD and VHDX files, which can cause degraded performance. When 4-KB native disks are required, the VHDX format works correctly on a 4-KB logical-sector size device.

## Pass-through disks

The VHD in a VM can be mapped directly to a physical disk or logical unit number (LUN), rather than a VHD file. The benefit of this approach is the ability to bypass the NTFS file system in the root partition, which reduces the CPU usage of storage I/O. However, the pass-through approach involves the risk that physical disks or LUNs can be more difficult to move between machines than VHD files.

**Recommendation**: Avoid using pass-through disks due to the limitations introduced with VM migration scenarios.

## Advanced storage features

There are a few more performance optimizations to consider for advanced storage features.

### Storage quality of service (QoS)

In Windows Server 2012 R2 and later, Hyper-V includes the ability to set certain quality-of-service (QoS) parameters for storage on VMs. You can implement these parameters to gain several benefits:

- Configure storage performance isolation in a multi-tenant environment

- Specify the maximum and minimum input/output operations per second (IOPS) for virtual hard disks

   Admins can throttle the storage I/O to prevent one tenant from consuming excessive storage resources that can affect other tenants. Set the minimum IOPS value and receive notifications when the threshold for optimal performance isn't met. The max/min IOPS values are specified in terms of normalized IOPS where every 8 KB of data is counted as an I/O.

- Receive notifications when storage I/O performance falls below defined thresholds to efficiently run VM workloads

- Access storage parameters for VM metrics infrastructure and enable admins to monitor performance and charge-back related parameters

Storage QoS also has some limitations:

- Only available for virtual disks

- Differencing disk can't have parent virtual disk on a different volume

- QoS for a replica site is configured separately from the primary site

- Shared VHDX isn't supported

For more information, see [Storage quality of service for Hyper-V](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282281(v=ws.11)).

**Recommendation**: Implement Storage QoS to access extra storage parameters, set max/min IOPS thresholds for virtual hard disks, and monitor disk performance. 

### NUMA I/O registry settings for large VMs

Windows Server 2012 and later supports projecting a virtual, nonuniform memory access (NUMA) topology into Hyper-V VMs. NUMA support helps to improve the performance of workloads running on VMs configured with large amounts of memory (or, _large VMs_). To enable this support, large VM configurations require scalability in terms of I/O throughput. An example of a large VM is Microsoft SQL Server running with 64 virtual processors.

The following Windows Server enhancements enable the I/O scalability requirements of large VMs:

- An increase in the number of communication channels created between guest devices and the host storage stack.

- A more efficient I/O completion mechanism involving interrupt distribution among the virtual processors to avoid expensive interprocessor interruptions.

#### Registry keys

To support the enhancements, a few registry entries were added or updated to allow the number of channels to be adjusted. The entries are located at:

```registry
HKLM\System\CurrentControlSet\Enum\VMBUS\<device id>\<instance id>\StorChannel
```

The `<device id>\<instance id>\` portion of the path corresponds to your configuration. The registry entries also align the virtual processors that handle the I/O completions to the virtual CPUs assigned by the application to be the I/O processors. The registry settings are configured on a per-adapter basis on the device's hardware key.

Here are two key settings to consider:

- **ChannelCount (DWORD)**: The total number of channels to use. The maximum value is 16. The channel count defaults to a ceiling, equal to the number of virtual processors divided by 16.

- **ChannelMask (QWORD)**: The processor affinity for the channels. If this key setting isn't specified or the value is 0, the channel mask defaults to the existing channel distribution algorithm for normal storage or networking channels. The default action ensures your storage channels don't conflict with your network channels.

**Recommendation**: Use the Windows Server NUMA registry key settings to improve the performance of workloads running on large VMs.

### Offloaded Data Transfer integration

Crucial maintenance tasks for VHDs, such as merge, move, and compact, involve copying large amounts of data. The current method of copying data requires data to be read in and written to different locations, which can be a time-consuming process. This method also uses CPU and memory resources on the host that could be used for other purposes, such as servicing VMs.

Storage area network (SAN) vendors are working to provide near-instantaneous copy operations of large amounts of data. This storage is designed to allow the system above the disks to specify the move of a specific data set from one location to another. This hardware feature is known as an _Offloaded Data Transfer_.

Hyper-V in Windows Server 2012 and later supports Offload Data Transfer (ODX) operations so the copied data can be passed from the guest OS to the host hardware. This method ensures the workload can use ODX-enabled storage similar to running in a nonvirtualized environment. The Hyper-V storage stack also issues ODX operations during maintenance operations for VHDs. Examples of maintenance operations include merging disks and storage migration meta-operations where large amounts of data are moved.

**Recommendation**: Implement ODX operations to ensure the VM workload can use ODX-enabled storage similar to running in a nonvirtualized environment. 

### Unmap notification integration

Virtual hard disk files exist as files on a storage volume, and they share available space with other files. Because the size of these files tends to be large, the space they consume can grow quickly. Demand for more physical storage affects the IT hardware budget. It's important to optimize the use of physical storage as much as possible.

Prior to Windows Server 2012, limitations in the Windows storage stack in the guest OS and the Hyper-V host had limitations. When applications deleted content within a virtual hard disk, the content's storage space was abandoned. The deleted information wasn't communicated to the virtual hard disk and the physical storage device. This behavior prevented the Hyper-V storage stack from optimizing the space usage by the VHD-based virtual disk files. It also prevented the underlying storage device from reclaiming the space that stored the deleted data.

In Windows Server 2012 and later, Hyper-V supports _unmap notifications_. This feature allows VHDX files to be more efficient in representing their contained data. This method produces smaller size files, and allows the underlying physical storage device to reclaim unused space.

Only Hyper-V-specific SCSI, enlightened IDE, and Virtual Fibre Channel controllers allow the `unmap` command from the guest OS to reach the host virtual storage stack. On the virtual hard disks, only virtual disks formatted as VHDX support `unmap` commands from the guest OS.

**Recommendation**: Integrate unmap notifications to improve the efficiency of VHDX files and enable the underlying physical storage device to reclaim unused space.

## Related links

- [Hyper-V terminology](terminology.md)

- [Hyper-V architecture](architecture.md)

- [Hyper-V server configuration](configuration.md)

- [Hyper-V processor performance](processor-performance.md)

- [Hyper-V memory performance](memory-performance.md)

- [Hyper-V network I/O performance](network-io-performance.md)

- [Detect bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

- [Linux virtual machines](linux-virtual-machine-considerations.md)
