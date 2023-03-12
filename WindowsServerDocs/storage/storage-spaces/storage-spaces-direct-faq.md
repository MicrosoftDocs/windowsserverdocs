---
title: Storage Spaces Direct - Frequently asked questions
description: Learn how about Storage Spaces Direct
keywords: Storage Spaces
ms.prod: windows-server-threshold
ms.author: kaushik
ms.technology: storage-spaces
ms.topic: article
author: kaushika-msft
ms.date: 10/24/2018
ms.localizationpriority: medium 
---
# Storage Spaces Direct - Frequently asked questions (FAQ)

This article lists some common and frequently asked questions related to [Storage Spaces Direct](storage-spaces-direct-overview.md).

## When you use Storage Spaces Direct with 3 nodes, can you get both performance and capacity tiers?

Yes, you can get both a performance and capacity tier in a 2-node or 3-node Storage Spaces Direct configuration. However, you must make sure that you have 2 capacity devices. That means that you must use all the three types of devices: NVME, SSD, and HDD.
 
## Refs file system provides real-time tiaring with Storage Spaces Direct. Does REFS provides the same functionality with shared storage spaces in 2016?

No, you won’t get real-time tiering with shared storage spaces with 2016. This is only for Storage Spaces Direct. 
 
## Can I use an NTFS file system with Storage Spaces Direct?
  
Yes, you can use the NTFS file system with Storage Spaces Direct. However, REFS is recommended. NTFS does not provide real-time tiering. 
 
## I have configured 2 node Storage Spaces Direct clusters, where the virtual disk is configured as 2-way mirror resiliency. If I add a new fault domain, will the resiliency of the existing virtual disk change?

After you have added the new fault domain, the new virtual disks that you create will jump to 3-way mirror. However, the existing virtual disk will remain a 2-way mirrored disk. You can copy the data to the new virtual disks from the existing volumes to gain the benefits of the new resiliency.
 
## The Storage Spaces Direct was created using the autoconfig:0 switch and the pool created manually. When I try to query the Storage Spaces Direct pool to create a new volume, I get a message that says, “Enable-ClusterS2D again.“ What should I do?

By default, when you configure Storage Spaces Direct by using the enable-S2D cmdlet, the cmdlet does everything for you. It creates the pool and the tiers. When using autoconfig:0, everything must be done manually. If you created only the pool, the tier is not necessarily created. You will receive an 
“Enable-ClusterS2D again” error message if you have either not created Tiers at all or not created Tiers in a manner corresponding to the devices attached. We recommend that you do not use the autoconfig switch in a production environment. 
 
## Is it possible to add a spinning disk (HDD) to the Storage Spaces Direct pool after you have created Storage Spaces Direct with SSD devices?

No. By default, if you use the single device type to create the pool, it would not configure cache disks and all disks would be used for capacity. You can add NVME disks to the configuration, and NVME disks would be configured for cache.
 
## I have configured a 2-rack fault domain: RACK 1 has 2 fault domains, RACK 2 has 1 fault domain. Each server has 4 capacity 100 GB devices. Can I use all 1,200 GB of space from the pool?

No, you can use only 800 GB. In a rack fault domain, you must make sure that you have a 2-way mirror configuration so that each chuck and its duplicate land in a different rack.
 
## What should the cache size be when I am configuring Storage Spaces Direct?

The cache should be sized to accommodate the working set (the data that's being actively read or written at any given time) of your applications and workloads.

## How can I determine the size of cache that is being used by Storage Spaces Direct?

Use the built-in utility PerfMon to inspect the cache misses. Review the cache miss reads/sec from the Cluster Storage Hybrid Disk counter. Remember that if too many reads are missing the cache, your cache is undersized and you may want to expand it. 
 
## Is there a calculator that shows the exact size of the disks that are being set aside for cache, capacity, and resiliency that would enable me to plan better?

You can use the Storage Spaces Calculator to help with your planning. It is available at http://aka.ms/s2dcalc.
 
## What is the best configuration that you would recommend when configuring 6 servers and 3 racks?

Use 2 servers on each of the racks to get the virtual disk resiliency of a 3-way mirror. Remember that the rack configuration would work correctly only if you are providing the configuration to the OS in the manner it is placed on the rack. 
 
## Can I enable maintenance mode for a specific disk on a specific server in Storage Spaces Direct cluster?

Yes, you can enable storage maintenance mode on a specific disk and a specific fault domain. The Enable-StorageMaintenanceMode command is automatically invoked when you pause a node. You can enable it for a specific disk by running the following command:

```powershell
Get-PhysicalDisk -SerialNumber <SerialNumber> | Enable-StorageMaintenanceMode
```

## Is Storage Spaces Direct supported on my hardware?

We recommend that you contact your hardware vendor to verify support. Hardware vendors test the solution on their hardware and comment about whether it is supported or not. For example, at the time of this writing, servers such as R730 / R730xd / R630 that have more than 8 drive slots can support SES and are compatible with Storage Spaces Direct. Dell supports only the HBA330 with Storage Spaces Direct. R620 does not support SES and is not compatible with Storage Spaces Direct.

For more hardware support information, go to the following website:
Windows Server Catalog
 
## How does Storage Spaces Direct make use of SES?

Storage Spaces Direct uses SCSI Enclosure Services (SES) mapping to make sure that slabs of data and the metadata is spread across the fault domains in a resilient fashion. If the hardware does not support SES, there is no mapping of the enclosures, and the data placement is not resilient.
 
## What command can you use to check the physical extent for a virtual disk?
  
This one:

```powershell
get-virtualdisk -friendlyname “xyz” | get-physicalextent
```
