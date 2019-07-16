---
title: Understand and Deploy Persistent Memory
description: Detailed info on what persistent memory is and how to set it up with storage spaces direct in Windows Server 2019.
keywords: Storage Spaces Direct,persistent memory,pmem, storage, S2D
ms.assetid: 
ms.prod: 
ms.author: adagashe
ms.technology: storage-spaces
ms.topic: article
author: adagashe
ms.date: 3/26/2019 
ms.localizationpriority: 
---
---
# Understand and deploy persistent memory

>Applies to: Windows Server 2019

Persistent Memory (or PMem) is a new type of memory technology that delivers a unique combination of affordable large capacity and persistence. This topic provides background on PMem and the steps to deploy it with Windows Server 2019 with Storage Spaces Direct.

## Background

PMem is a type of non-volatile DRAM (NVDIMM) that has the speed of DRAM, but retains its memory content through power cycles (the memory contents remain even when system power goes down in the event of an unexpected power loss, user initiated shutdown, system crash, etc.). Because of this, resuming from where you left off is significantly faster, since the content of your RAM doesn't need to be reloaded. Another unique characteristic is that PMem is byte addressable, which means you can also use it as storage (which is why you may hear PMem being referred to as storage-class memory).


To see some of these benefits, let's look at the this demo from Microsoft Ignite 2018:

[![Microsoft Ignite 2018 Pmem demo](http://img.youtube.com/vi/8WMXkMLJORc/0.jpg)](http://www.youtube.com/watch?v=8WMXkMLJORc)

Any storage system that provides fault tolerance necessarily makes distributed copies of writes, which must traverse the network and incurs backend write amplification. For this reason, the absolute largest IOPS benchmark numbers are typically achieved with reads only, especially if the storage system has common-sense optimizations to read from the local copy whenever possible, which Storage Spaces Direct does.

**With 100% reads, the cluster delivers 13,798,674 IOPS.**

![13.7m IOPS record screenshot](media/deploy-pmem/iops-record.png)

If you watch the video closely, you'll notice thatwhat’s even more jaw-dropping is the latency: even at over 13.7 M IOPS, the filesystem in Windows is reporting latency that’s consistently less than 40 µs! (That’s the symbol for microseconds, one-millionth of a second.) This is an order of magnitude faster than what typical all-flash vendors proudly advertise today.

Together, Storage Spaces Direct in Windows Server 2019 and Intel® Optane™ DC persistent memory deliver breakthrough performance. This industry-leading HCI benchmark of over 13.7M IOPS, with predictable and extremely low latency, is more than double our previous industry-leading benchmark of 6.7M IOPS. What’s more, this time we needed just 12 server nodes, 25% fewer than two years ago.

![IOPS gains](media/deploy-pmem/iops-gains.png)

The hardware used was a 12-server cluster using three-way mirroring and delimited ReFS volumes, **12** x Intel® S2600WFT, **384 GiB** memory, 2 x 28-core “CascadeLake”, **1.5 TB** Intel® Optane™ DC persistent memory as cache, **32 TB** NVMe (4 x 8TB Intel® DC P4510) as capacity, **2** x Mellanox ConnectX-4 25 Gbps

The table below has the full performance numbers: 

| Benchmark                   | Performance         |
|-----------------------------|---------------------|
| 4K 100% Random Read         | 13.8 Million IOPS   |
| 4K 90/10% Random Read/Write | 9.45 million IOPS   |
| 2MB Sequential Read         | 549 GB/s Throughput |

### Supported Hardware

The table below shows supported persistent memory hardware for Windows Server 2019 and Windows Server 2016. Note that Intel Optane specifically supports both memory mode and app-direct mode. Windows Server 2019 supports mixed-mode operations.

| Persistent Memory Technology                                      | Windows Server 2016 | Windows Server 2019 |
|-------------------------------------------------------------------|--------------------------|--------------------------|
| **NVDIMM-N** in App-Direct Mode                                       | Supported                | Supported                |
| **Intel Optane™ DC Persistent Memory** in App-Direct Mode             | Not Supported            | Supported                |
| **Intel Optane™ DC Persistent Memory** in Two-Level-Memory Mode (2LM) | Not Supported            | Supported                |

Now, let's dive into how you configure persistent memory.

## Interleave sets

### Understanding interleave sets

Recall that the NVDIMM-N resides in a standard DIMM (memory) slot, placing data closer to the processor (thus, reducing the latency and fetching better performance). To build on this, an interleave set is when two or more NVDIMMs create an N-Way interleave set to provide stripes read/write operations for increased throughput. The most common setups are 2-Way or 4-Way interleaving.

Interleaved sets can often be created in a platform's BIOS to make multiple persistent memory devices appear as a single logical disk to Windows Server. Each persistent memory logical disk contains an interleaved set of physical devices by running:

```PowerShell
Get-PmemDisk
```

An example output is shown below:

```
DiskNumber Size   HealthStatus AtomicityType CanBeRemoved PhysicalDeviceIds UnsafeShutdownCount
---------- ----   ------------ ------------- ------------ ----------------- -------------------
2          252 GB Healthy      None          True         {20, 120}         0
3          252 GB Healthy      None          True         {1020, 1120}      0
```

We can see that the logical pmem disk #2 has physical devices of Id20 and Id120 and logical pmem disk #3 has physical devices of Id1020 and Id1120. We can also feed a specific pmem disk to Get-PmemPhysicalDevice to get all its physical NVDIMMs in the interleave set as below.


```PowerShell
(Get-PmemDisk)[0] | Get-PmemPhysicalDevice
```

An example output is shown below:

```
DeviceId DeviceType           HealthStatus OperationalStatus PhysicalLocation FirmwareRevision Persistent memory size Volatile memory size
-------- ----------           ------------ ----------------- ---------------- ---------------- ---------------------- --------------------
20       Intel INVDIMM device Healthy      {Ok}              CPU1_DIMM_C1     102005310        126 GB                 0 GB
120      Intel INVDIMM device Healthy      {Ok}              CPU1_DIMM_F1     102005310        126 GB                 0 GB
```

### Configuring interleave sets

To configure an interleave set, run the following PowerShell cmdlet:

```PowerShell
Get-PmemUnusedRegion

RegionId TotalSizeInBytes DeviceId
-------- ---------------- --------
       1     270582939648 {20, 120}
       3     270582939648 {1020, 1120}
```

This shows all the persistent memory region(s) not assigned to a logical persistent memory disk on the system.

To see all of the persistent memory devices information in the system, including device type, location, health and operational status, etc. you can run the following cmdlet on the local server:

```PowerShell
Get-PmemPhysicalDevice

DeviceId DeviceType           HealthStatus OperationalStatus PhysicalLocation FirmwareRevision Persistent memory size Volatile
                                                                                                                      memory size
-------- ----------           ------------ ----------------- ---------------- ---------------- ---------------------- --------------
1020     Intel INVDIMM device Healthy      {Ok}              CPU2_DIMM_C1     102005310        126 GB                 0 GB
1120     Intel INVDIMM device Healthy      {Ok}              CPU2_DIMM_F1     102005310        126 GB                 0 GB
120      Intel INVDIMM device Healthy      {Ok}              CPU1_DIMM_F1     102005310        126 GB                 0 GB
20       Intel INVDIMM device Healthy      {Ok}              CPU1_DIMM_C1     102005310        126 GB                 0 GB
```

Since we have available unused pmem region, we can create new persistent memory disks. We can create multiple persistent memory disks using the unused regions by:

```PowerShell
Get-PmemUnusedRegion | New-PmemDisk
Creating new persistent memory disk. This may take a few moments.
```

Ater this is done, we can see the results by running:

```PowerShell
Get-PmemDisk

DiskNumber Size   HealthStatus AtomicityType CanBeRemoved PhysicalDeviceIds UnsafeShutdownCount
---------- ----   ------------ ------------- ------------ ----------------- -------------------
2          252 GB Healthy      None          True         {20, 120}         0
3          252 GB Healthy      None          True         {1020, 1120}      0
```

It is worth noting that we could have run **Get-PhysicalDisk | Where MediaType -Eq SCM** instead of **Get-PmemDisk** to get the same results. The newly created persistent memory disk corresponds 1:1 to drives that appear in PowerShell and Windows Admin Center.

### Using persistent memory for cache or capacity

Storage Spaces Direct on Windows Server 2019 supports using persistent memory as either a cache or capacity drive. See this [documentation](understand-the-cache.md) for more details on setting up cache and capacity drives.

## Creating a DAX Volume

### Understanding DAX

There are two methods for accessing persistent memory. They are:

1. **Direct access (DAX)**, which operates like memory to get the lowest latency. The app directly modifies the persistent memory, bypassing the stack. Note that this can only be used with NTFS.
2. **Block access**, which operates like storage for app compatibility. The data flows through the stack in this setup, and this can be used with NTFS and ReFS.

An example of this can be seen below:

![DAX stack](media/deploy-pmem/dax.png)

### Configuring DAX

We will need to use PowerShell cmdlets to create a DAX volume on a persistent memory. By using the **-IsDax** switch, we can format a volume to be DAX enabled.

```PowerShell
Format-Volume -IsDax:$true
```

The following code snippet will help you create a DAX volume on a persistent memory disk.

```PowerShell
# Here we use the first pmem disk to create the volume as an example
$disk = (Get-PmemDisk)[0] | Get-PhysicalDisk | Get-Disk
# Initialize the disk to GPT if it is not initialized
If ($disk.partitionstyle -eq "RAW") {$disk | Initialize-Disk -PartitionStyle GPT}
# Create a partition with drive letter 'S' (can use any available drive letter)
$disk | New-Partition -DriveLetter S -UseMaximumSize


   DiskPath: \\?\scmld#ven_8980&dev_097a&subsys_89804151&rev_0018#3&1b1819f6&0&03018089fb63494db728d8418b3cbbf549997891#{53f56307-b6
bf-11d0-94f2-00a0c91efb8b}

PartitionNumber  DriveLetter Offset                                               Size Type
---------------  ----------- ------                                               ---- ----
2                S           16777216                                        251.98 GB Basic

# Format the volume with drive letter 'S' to DAX Volume
Format-Volume -FileSystem NTFS -IsDax:$true -DriveLetter S

DriveLetter FriendlyName FileSystemType DriveType HealthStatus OperationalStatus SizeRemaining      Size
----------- ------------ -------------- --------- ------------ ----------------- -------------      ----
S                        NTFS           Fixed     Healthy      OK                    251.91 GB 251.98 GB

# Verify the volume is DAX enabled
Get-Partition -DriveLetter S | fl


UniqueId             : {00000000-0000-0000-0000-000100000000}SCMLD\VEN_8980&DEV_097A&SUBSYS_89804151&REV_0018\3&1B1819F6&0&03018089F
                       B63494DB728D8418B3CBBF549997891:WIN-8KGI228ULGA
AccessPaths          : {S:\, \\?\Volume{cf468ffa-ae17-4139-a575-717547d4df09}\}
DiskNumber           : 2
DiskPath             : \\?\scmld#ven_8980&dev_097a&subsys_89804151&rev_0018#3&1b1819f6&0&03018089fb63494db728d8418b3cbbf549997891#{5
                       3f56307-b6bf-11d0-94f2-00a0c91efb8b}
DriveLetter          : S
Guid                 : {cf468ffa-ae17-4139-a575-717547d4df09}
IsActive             : False
IsBoot               : False
IsHidden             : False
IsOffline            : False
IsReadOnly           : False
IsShadowCopy         : False
IsDAX                : True                   # <- True: DAX enabled
IsSystem             : False
NoDefaultDriveLetter : False
Offset               : 16777216
OperationalStatus    : Online
PartitionNumber      : 2
Size                 : 251.98 GB
Type                 : Basic
```

## Monitoring Health

When you use persistent memory, there are a few differences in the monitoring experience:

1. Persistent memory doesn't create Physical Disk performance counters, so you won't see if appear on charts in Windows Admin Center.
2. Persistent memory doesn't create Storport 505 data, so you won't get proactive outlier detection.

Apart from that, the monitoring experience is the same as any other physical disk. You can query for the health of a persistent memory disk by running:

```PowerShell
Get-PmemDisk

DiskNumber Size   HealthStatus AtomicityType CanBeRemoved PhysicalDeviceIds UnsafeShutdownCount
---------- ----   ------------ ------------- ------------ ----------------- -------------------
2          252 GB Unhealthy    None          True         {20, 120}         2
3          252 GB Healthy      None          True         {1020, 1120}      0

Get-PmemDisk | Get-PhysicalDisk | select SerialNumber, HealthStatus, OperationalStatus, OperationalDetails

SerialNumber               HealthStatus OperationalStatus  OperationalDetails
------------               ------------ ------------------ ------------------
802c-01-1602-117cb5fc      Healthy      OK
802c-01-1602-117cb64f      Warning      Predictive Failure {Threshold Exceeded,NVDIMM_N Error}
```

**HealthStatus** shows if the persistent memory disk is healthy or not. The **UnsafeshutdownCount** tracks the number of shutdowns that may cause data loss on this logical disk. It is the sum of the unsafe shutdown counts of all the underlying persistent memory devices of this disk. We can also use the below commands to query health info. The **OperationalStatus** and **OperationalDetails** provide more information about the health status.

To query the health of persistent memory device:

```PowerShell
Get-PmemPhysicalDevice

DeviceId DeviceType           HealthStatus OperationalStatus PhysicalLocation FirmwareRevision Persistent memory size Volatile memory size
-------- ----------           ------------ ----------------- ---------------- ---------------- ---------------------- --------------------
1020     Intel INVDIMM device Healthy      {Ok}              CPU2_DIMM_C1     102005310        126 GB                 0 GB
1120     Intel INVDIMM device Healthy      {Ok}              CPU2_DIMM_F1     102005310        126 GB                 0 GB
120      Intel INVDIMM device Healthy      {Ok}              CPU1_DIMM_F1     102005310        126 GB                 0 GB
20       Intel INVDIMM device Unhealthy    {HardwareError}   CPU1_DIMM_C1     102005310        126 GB                 0 GB
```

This shows which persistent memory device is unhealthy. The unhealthy device (**DeviceId**) 20 matches the case in the above example. The **PhysicalLocation** from BIOS can help identify which persistent memory device is in faulty state.

## Replacing persistent memory

Above we described how to view the health status of your persistent memory. If you need to replace a failed module, you will need to re-provision the persistent memory disk (refer to the steps we outlined above).

When troubleshooting, you may need to use **Remove-PmemDisk**, which removes a specific persistent memory disk. We can remove all current persistent disks by:

```PowerShell
Get-PmemDisk | Remove-PmemDisk

cmdlet Remove-PmemDisk at command pipeline position 1
Supply values for the following parameters:
DiskNumber: 2

This will remove the persistent memory disk(s) from the system and will result in data loss.
Remove the persistent memory disk(s)?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
Removing the persistent memory disk. This may take a few moments.
```

It is important to note that removing a persistent memory disk will result in data loss on that disk.

Another cmdlet you may need is **Initialize-PmemPhysicalDevice**, which will initialize the label storage area on the physical persistent memory devices. This can be used to clear corrupted label storage info on the persistent memory devices.

```PowerShell
Get-PmemPhysicalDevice | Initialize-PmemPhysicalDevice

This will initialize the label storage area on the physical persistent memory device(s) and will result in data loss.
Initializes the physical persistent memory device(s)?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A
Initializing the physical persistent memory device. This may take a few moments.
Initializing the physical persistent memory device. This may take a few moments.
Initializing the physical persistent memory device. This may take a few moments.
Initializing the physical persistent memory device. This may take a few moments.
```

It is important to note that this command should be used as a last resort to fix persistent memory related issues. It will result in data loss to the persistent memory.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
- [Storage-class Memory (NVDIMM-N) Health Management in Windows](storage-class-memory-health.md)
- [Understand the cache](understand-the-cache.md)