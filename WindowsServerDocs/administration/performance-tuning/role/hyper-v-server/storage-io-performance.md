---
title: Hyper-V storage I/O performance
description: Learn about storage I/O performance considerations in Hyper-V performance tuning, including advantages, limitations, and recommendations.
ms.topic: article
ms.author: wscontent
author: phstee
ms.date: 12/14/2023
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

We recommend that you only use IDE disks for OS disks. OS disks have performance limitations based on the maximum I/O size for their devices.

IDE controllers are emulated controllers that expose IDE disks to the VM. This type of controller is the only option for guest VMs running earlier versions of Windows without [Hyper-V VM integration services](/virtualization/hyper-v-on-windows/reference/integration-services). The IDE filter driver that integration services provides can perform disk I/O better than the emulated IDE controller.

### SCSI (SAS controller)

Virtual SCSI controllers expose SCSI disks to the VM. Each SCSI controller supports up to 64 devices. The SCSI path isn't emulated, which makes it the preferred controller for any disk other than the OS disk. Windows Server 2012 R2 and later support SCSI controllers, but only in scenarios where you report the controller as a Serial Attached SCSI (SAS) for supporting a shared virtual hard disk (VHDX).

For best performance, we recommend you attach multiple disks to a single virtual SCSI controller. You should only create more controllers if you have no other options for scaling how many disks are connected to the VM.

### Virtual Fibre Channel HBAs

Configure Virtual Fibre Channel HBAs to allow VMs to directly access Fibre Channel and Fibre Channel over Ethernet (FCoE) logical unit numbers (LUNs). Virtual Fibre Channel disks bypass the NTFS file system in the root partition, which reduces storage I/O central processing unit (CPU) usage. Virtual Fibre Channel disks are great for large data drives and drives shared between multiple VMs in guest clustering scenarios.

To use Virtual Fibre Channel disks, you must install one or more Fibre Channel HBAs on the host machine. Each host HBA must use HBA drivers that support Windows Server 2016 Virtual Fibre Channel or N_Port ID Virtualization (NPIV) capabilities. The Storage Area Network (SAN) fabric should also support NPIV, and you should configure the HBA ports for the Fibre Channel in a Fiber Channel topology that supports NPIV.

To maximize throughput on hosts with more than one HBA, we recommend you configure many virtual HBAs inside the Hyper-V VM. You can configure up to four HBAs for each VM. Hyper-V automatically balances virtual HBAs to host HBAs accessing the same virtual SAN.

## Virtual disks

Virtual disks are exposed to the VMs by virtual controllers and can be virtual hard disks or pass-through disks on the host.

Virtual disks come in VHD or VHDX formats. Each format supports three types of virtual hard disk files.

If you upgrade your deployment to Windows Server 2016 or later, we recommend you convert all VHD files to VHDX format. For more information, see [VHDX format](#vhdx-format).

### VHD format

Later versions of Hyper-V include improvements to their VHD format that allow for better alignment. Hyper-V in Windows Server 2012 and later supports both VHDX and VHD formats, as opposed to earlier versions that only support VHD format. As a result, later versions of Hyper-V perform better on large sector disks.

Any VHD you create in Windows Server 2012 or later have the optimal 4 KB alignment. This aligned format is fully compatible with earlier versions of Windows Server. However, the alignment property doesn't support new allocations from parsers that aren't 4 KB alignment-aware, such as a parser from an earlier version of Windows Server or a non-Microsoft parser.

#### Convert disk to VHD format

When you migrate a VHD from an earlier version of Hyper-V or Windows Server to a later one, the system doesn't automatically convert the disk to VHD format.

You can convert an existing virtual disk to VHD by opening a PowerShell window and running the following command:

```powershell
Convert-VHD –Path <SourceDiskFilePath> –DestinationPath <ConvertedDiskFilePath>
```

For example, if you planned to convert a source disk named `test.vhd` in drive E to a renamed converted disk named `test-converted.vhd` in the same folder, you'd run this command:

```powershell
Convert-VHD –Path E:\vms\testvhd\test.vhd –DestinationPath E:\vms\testvhd\test-converted.vhd
```

> [!NOTE]
> When you convert a VHD, PowerShell uses the data from the source VHD based on the **Copy from Source** disk option. For more information, see [Convert-VHD](/powershell/module/hyper-v/convert-vhd).

#### Check disk alignment

After you convert a disk, you can check its *Alignment* variable to make sure it's using the optimal 4-KB alignment by running the `Get-VHD` command in PowerShell. Make sure to run the command for the source disk and the converted disk, then compare the values to make sure the converted disk is 4 KB alignment-aware.

To view the alignment of your disks:

1. Open a PowerShell window.

1. Run the `Get-VHD` command to view the alignment setting for the source disk.

   ```powershell
   Get-VHD –Path <SourceVHDFilePath>
   ```

1. In the output, notice the value for the `Alignment` property. In this example, the value is `0`, which means the disk isn't 4 KB alignment-aware.

   ```powershell
   Path                    : <SourceVHDFilePath>
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

1. Run the  `Get-VHD` command again, but this time use the file path for the converted disk.

   ```powershell
   Get-VHD –Path <ConvertedDiskFilePath>
   ```

1. In the output, check the value for the `Alignment` property. The value should be `1`, which means the disk is successfully converted to the newer VHD format and is 4 KB alignment-aware.

   ```output
   Path                    : <ConvertedDiskFilePath>
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
<!--What should the customer do if the value isn't 1?--->
### VHDX format

VHDX is an updated hard disk format introduced in Windows Server 2012. This format can create resilient, high-performance virtual disks with up to 64 terabytes of capacity.

If you're upgrading to Windows Server 2016 or later, we recommend you convert all VHD files to VHDX format. Only keep files in VHD format if you need to move the VM to an earlier Hyper-V release that doesn't support VHDX format.

Here are some benefits of the VHDX format:

- Support for virtual hard disk storage capacity of up to 64 terabytes

- Protection against data corruption during power failures by logging updates to the VHDX metadata structures

- Stores custom metadata for a file based on what the user configuring it wants to record, such as the OS version or applied patches

The VHDX format also provides several performance features:

- Improved alignment of the virtual hard disk format, improving performance on large sector disks

- Larger block sizes for dynamic and differential disks, which let disks adjust for workload requirements

- A 4-KB logical sector virtual disk to support increased performance when used by applications and workloads designed for 4-KB sectors

- Efficiency in representing data to produce smaller file sizes and allow underlying physical storage device to reclaim unused space

   > [!NOTE]
   > Trimming requires pass-through or SCSI disks and trim-compatible hardware.

## Virtual files

There are three types of VHD files:

- Fixed files are for improving resiliency and performance, and you should use them when storage on the hosting value isn't actively monitored. Make sure there's enough disk space when expanding the VHD file at runtime. You can use them on any disk format.

- Dynamic files are for resiliency guarantees and allocating disk space as the deployment needs it. You can only use them on VHDX.

- Differencing files keep VM snapshot chains short to maintain good disk I/O performance. You can use them on any disk format.

### Fixed file type

When you create a fixed VHD file, the system allocates space for it. Fixed files are less likely to fragment, reducing the I/O throughput when a single I/O splits into multiple ones. It also has the lowest CPU overhead of the three file options because read and write operations don't need to look up the mapping of the block.

We recommend you use the fixed file type when you need optimal resiliency and performance.

### Dynamic file type

When you create a dynamic VHD file, the system allocates space for it on-demand. Blocks in the file start as allocated blocks, and no space in the file backs the unallocated blocks. When a block receives its first write, the virtualization stack then must allocate space for the block in the VHD file, then update the metadata. This allocation increases the number of disk I/Os required for the write, increasing CPU usage. Reads and writes to existing blocks incur disk access and CPU overhead when looking up the blocks' mapping in the metadata.

If you're using a VHDX file, we recommend you use the dynamic file type when you aren't actively monitoring storage on the hosting volume. Make sure you have enough disk space when expanding the VHD file at runtime.

### Differencing file type

Differencing files are snapshots of a VM that store writes to the disks. If you write to a block without existing writes, the system allocates space in the VHD file just like a dynamically expanding VHD. The system services read operations from the VHD file if the block already contains writes. Otherwise, it services blocks from the parent VHD file. In both cases, the system reads metadata to determine the block mapping. Reads and writes to this VHD can consume more CPU and result in more I/Os than a fixed VHD file.

When there are only a few snapshots, storage I/Os can potentially use more CPU than normal, but it doesn't noticeably affect performance except in highly I/O-intensive server workloads. Creating and using a large chain of VM snapshots does cause performance issues. In differencing files, the system needs to check for the requested blocks in many different differencing VHDs just to read from the VHD. If you use differencing files, we recommend you should keep snapshot chains short to maintain good disk I/O performance.

## Size considerations

When you're planning for disk optimization, you should consider both block size and sector size. This section describes recommendations for sizing blocks and sectors.

### Block size

Because block size can significantly affect performance, we recommend you match block size to the allocation patterns of the workloads using the disk. If an application allocates blocks in chunks of 16 MB, then you should ideally use a VHD block size of 16 MB. Block sizes larger than 2 MB are only possible on VHDs using the VHDX file format. When block size is larger than the allocation pattern for a random I/O workload, it increases the amount of space the VHD uses on the host.

### Sector size

Software organizations frequently depend on disk sectors of 512 bytes, but the industry standard is moving to 4-KB disk sectors. To reduce compatibility issues that can arise from changes in sector size, hard drive vendors are introducing a transitional size referred to as *512 emulation drives (512e)*.

Emulation drives offer some of the advantages provided by 4-KB disk sector native drives, such as improved format efficiency and an improved scheme for error correction codes (ECC). Emulation drives present fewer compatibility issues when exposing a 4-KB sector size at the disk interface.

To make full use of 4-KB sectors, we recommend you use the VHDX format instead of disk sectors of 512 bytes. To reduce compatibility issues between disk sizes, implement 512e drives for transitional sizing.

#### Support transitional size with 512e disks

A 512e disk can perform a write operation only in terms of a physical sector. This type of disk can't directly write a 512-byte sector the system issues it to. The disk has an internal process that makes write operations possible, which involves Read-Modify-Write (RMW) operations in the following order:

- First, the disk reads the 4-KB physical sector to its internal cache. The cache contains the 512-byte logical sector referred to in the write operation.

- Next, the disk modifies the data in the 4-KB buffer to include the updated 512-byte sector.

- Finally, the disk writes the updated 4-KB buffer back to its physical sector on the disk.

The overall effect the RMW process has on performance depends on the workload. The RMW process can cause performance degradation in virtual hard disks for the following reasons:

- Dynamic and differencing VHDs have a 512-byte sector bitmap in front of their data payload. Footer, header, and parent locators align to a 512-byte sector. It's common for the virtual hard disk driver to execute 512-byte write operations to update these structures, which cause the disk to run the RMW process.

- Applications commonly execute read and write operations in multiples of 4-KB sizes, as 4 KB is the default cluster size of NTFS. Dynamic and differencing virtual hard disks have a 512-byte sector bitmap in front of the data payload block. This bitmap causes the 4-KB blocks to not align to the physical 4-KB boundary. The following diagram shows a highlighted VHD 4-KB block that isn't aligned with the physical 4-KB boundary.

   :::image type="content" source="../../media/perftune-guide-vhd-4kb-block.png" alt-text="Diagram of a VHD 4-KB block that's not aligned with the physical 4-KB boundary." border="false":::

Each 4-KB write operation by the current parser to update the payload data results in two reads for two blocks on the disk. The system then updates the blocks and writes them back to the two disk blocks. Hyper-V in Windows Server 2016 mitigates some performance effects on 512e disks on the VHD stack. Hyper-V prepares the structures for alignment to 4-KB boundaries in the VHD format. The mitigation avoids the RMW effect on access to data within the virtual hard disk file and updates to the virtual hard disk metadata structures.

As previously mentioned, VHDs copied from earlier versions of Windows Server aren't automatically aligned to 4 KB. You can manually convert the disk to optimally align by using the **Copy from Source** disk option with the `Convert-VHD` command.

By default, VHDs are exposed with a physical sector size of 512 bytes. This method ensures the physical-sector-size dependent applications aren't impacted when you migrate the application and VHDs from an earlier version of Windows Server.

By default, the system creates VHDX disks with a 4-KB physical sector size to optimize their performance profile on regular disks and larger sector disks.

To reduce compatibility issues between disk sizes, we recommend you implement 512e drives for transitional sizing. To make full use of 4-KB sectors, use VHDX format.

## Native 4-KB disks

Hyper-V in Windows Server 2012 R2 and later supports 4-KB native disks. You can also store VHD disk data on a 4-KB native disk by implementing a software RMW algorithm in the virtual storage stack layer. The algorithm converts 512-byte access and update requests to corresponding 4-KB accesses and updates.

Because VHD files can only expose as 512-byte logical-sector size disks, it's likely there are applications that issue 512-byte I/O requests. In such cases, the RMW algorithm in the storage stack layer satisfies the requests and causes performance degradation. The same result occurs for VHDX disks with a logical-sector size of 512 bytes.

You can configure VHDX files to expose as a 4-KB logical-sector size disk. This implementation is an optimal configuration for performance for disks hosted on a 4-KB native physical device. However, make sure the 4-KB logical-sector size supports both the guest and application that use the virtual disk. The VHDX format works correctly on a 4-KB logical-sector size device.

We recommend you avoid using 4-KB native disks with VHD and VHDX files, as it can cause performance degradation. When your scenario requires 4-KB native disks, you should use the VHDX format on a 4-KB logical-sector size device.

## Pass-through disks

We recommend you avoid using pass-through disks due to the limitations they introduce in VM migration scenarios.

Mapping a VHD in a VM directly to a physical disk or logical unit number (LUN) instead of a VHD file is called a *pass-through disk* Pass-through disks let you bypass the NTFS file system in the root partition, which reduces the CPU usage of storage I/O. However, using pass-through disks also involves a risk of physical disks or LUNs becoming more difficult to migrate between machines than VHD files.

## Advanced storage features

This section discusses some more performance optimizations you should consider for advanced storage features.

### Storage quality of service (QoS)

In Windows Server 2012 R2 and later, Hyper-V includes the ability to set certain quality-of-service (QoS) parameters for storage on VMs. We recommend you implement Storage QoS to access extra storage parameters, set maximum and minimum IOPS thresholds for virtual hard disks, and monitor disk performance. You can implement these parameters to gain the following benefits:

- Configure storage performance isolation in a multitenant environment

- Specify the maximum and minimum input/output operations per second (IOPS) for virtual hard disks

  - Admins can throttle the storage I/O to prevent one tenant from consuming excessive storage resources that can affect other tenants. Set the minimum IOPS value and receive notifications when the system doesn't meet the threshold for optimal performance. We specify the maximum or minimum IOPS values in terms of normalized IOPS where we every 8 KB of data as an I/O.

- Receive notifications when storage I/O performance falls below defined thresholds to efficiently run VM workloads

- Access storage parameters for VM metrics infrastructure and enable admins to monitor performance and charge-back related parameters

However, also keep in mind that Storage QoS has the following limitations:

- Only available for virtual disks

- Differencing disk can't have parent virtual disk on a different volume

- QoS for a replica site is configured separately from the primary site

- Storage QoS doesn't support shared VHDX

For more information, see [Storage quality of service for Hyper-V](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282281(v=ws.11)).

### NUMA I/O registry settings for large VMs

Windows Server 2012 and later supports projecting a virtual, nonuniform memory access (NUMA) topology into Hyper-V VMs. NUMA support improves performance of workloads running on VMs configured with large amounts of memory, or *large VMs*. To enable this support, large VM configurations require scalability in terms of I/O throughput. An example of a large VM is Microsoft SQL Server running with 64 virtual processors.

The following Windows Server enhancements meet the I/O scalability requirements of large VMs:

- Creating more communication channels between guest devices and the host storage stack.

- A more efficient I/O completion mechanism involving interrupt distribution among the virtual processors to avoid expensive interprocessor interruptions.

#### Registry keys

We recommend you use the Windows Server NUMA registry key settings to improve the performance of workloads running on large VMs.

We've added and updated some registry entries to support the enhancements in the previous section and allow you to adjust the number of channels. You can find the entries at `HKLM\System\CurrentControlSet\Enum\VMBUS\<device id>\<instance id>\StorChannel`.

The `<device id>\<instance id>\` portion of the path corresponds to the relevant values in your configuration. These registry entries align the virtual processors that handle the I/O completions to the virtual CPUs the application assigned to be the I/O processors. The system configures registry settings on a per-adapter basis on the device's hardware key.

Here are two key settings to consider:

- *ChannelCount (DWORD)* is the total number of communication channels your deployment can use. The maximum value is 16. The channel count defaults to a value equal to the number of virtual processors divided by 16.

- *ChannelMask (QWORD)* is the processor affinity for the channels. If you don't specify this key setting or set the value to 0, the channel mask defaults to the existing channel distribution algorithm for normal storage or networking channels. The default action ensures your storage channels don't conflict with your network channels.

### Offloaded Data Transfer integration

We recommend you use Offloaded Data Transfer (ODX) operations to ensure the VM workload can use ODX-enabled storage the way it can in a physical environment.

Crucial maintenance tasks for VHDs, such as merging, moving, and compacting, involve copying large amounts of data. The current method of copying data requires the system read and write data to different locations, which is time-consuming and uses CPU and memory resources that could have gone towards servicing VMs.

Storage area network (SAN) vendors can provide a hardware feature called ODX. This feature provides near-instantaneous copy operations for large amounts of data. ODX allows the system, not the disks, to specify how to move specific data sets from one location to another.

Hyper-V in Windows Server 2012 and later supports ODX operations to pass down copied data from the guest OS to the host hardware. The workload can use ODX-enabled storage just like it would in a non-virtualized environment. The Hyper-V storage stack can also issue ODX operations during maintenance operations for VHDs, such as merging disks and storing migration meta-operations during huge data migrations.

### Unmap notification integration

We recommend you use unmap notifications to make your VHDX files more efficient and let the underlying physical storage device reclaim unused space.

VHD files exist on a storage volume where they share available space with other files. Because their file size tends to be large, VHD files can take up a lot of space. Greater demand for storage space affects IT hardware budgets, which means you should optimize physical space usage wherever possible.

In versions of Windows Server earlier than Windows Server 2012, the Windows storage stack in the guest OS and the Hyper-V host had limitations that prevented them from optimizing storage space. When applications deleted content in a VHD, the storage space remained abandoned. The system doesn't notify the VHD or physical storage device about the deleted information, which prevented the Hyper-V storage stack from optimizing space for the VHD-based virtual disk files. As a result, the underlying storage device couldn't reclaim the now-unused space the deleted data used to occupy.

As of Windows Server 2012, Hyper-V supports *unmap notifications*. This feature lets VHDX files report deleted data to the storage stack, which maximizes efficiency by keeping file sizes trim and letting the stack reclaim unused storage space for other uses.

Only Hyper-V-specific SCSI, enlightened IDE, and Virtual Fibre Channel controllers allow the `unmap` command from the guest OS to reach the host virtual storage stack. On VHDs, only virtual disks formatted as VHDX support `unmap` commands from the guest OS.

## Related content

- [Hyper-V terminology](terminology.md)

- [Hyper-V architecture](architecture.md)

- [Hyper-V server configuration](configuration.md)

- [Hyper-V processor performance](processor-performance.md)

- [Hyper-V memory performance](memory-performance.md)

- [Hyper-V network I/O performance](network-io-performance.md)

- [Detect bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)

- [Linux virtual machines](linux-virtual-machine-considerations.md)
