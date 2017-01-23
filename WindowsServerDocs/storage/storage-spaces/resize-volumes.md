---
title: Resize volumes in Storage Spaces Direct
ms.prod: windows-server-threshold
ms.author: cosmosdarwin
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 01/23/2017
---

# Extending volumes in Storage Spaces Direct
> Applies To: Windows Server 2016

This topic provides instructions for resizing volumes in Storage Spaces Direct.

> [!TIP]
> If you just want the instructions, skip to [Suspend IO](...).

In Storage Spaces Direct, every "volume" is actually several stacked objects: the cluster shared volume is a volume; the volume sits on a partition; the partition sits on a disk; that disk is a virtual disk; that virtual disk may (or not) be comprised of storage tiers.

You can familiarize yourself with these objects in PowerShell by running:

```
Get-ClusterSharedVolume
Get-Volume
Get-Partition
Get-Disk
Get-VirtualDisk
Get-StorageTier
```

You can follow associations between each object in the stack by piping **Get-** cmdlets into one another.

For example, here’s how to get from a virtual disk up to its volume.

```
Get-VirtualDisk <FriendlyName> | Get-Disk | Get-Partition | Get-Volume 
```

To resize a volume, you need to resize several of these objects.

## Prerequisite capacity

Before you resize, make sure you have enough capacity in the storage pool to accommodate its new, larger footprint. For example, when extending a three-way mirror volume from 1 TB to 2 TB, its footprint will grow from 3 TB to 6 TB.

```
1 TB x 33.3% = 3 TB (original footprint)
2 TB x 33.3% = 6 TB (new footprint)
```

(IMAGE HERE)

```
(new - original) = 6 TB - 3 TB = +3 TB
```

In this example, for the resize to succeed you need at least another 3 TB unallocated in the storage pool.

You can check by viewing the **CapacityPhysicalPooledAvailable** in the output of this cmdlet.

```
Get-StorageSubSystem Cluster* | Get-StorageHealthReport
```

(IMAGE HERE)

## Suspend IO

Before you begin, we recommend temporarily suspending all IO to the volume.

Stop your workloads and then run:

```
Get-ClusterSharedVolume <FriendlyName> | Suspend-ClusterResource
```

## Step 1 – Resize virtual disk

The virtual disk may use storage tiers, or not, depending on how it was created.

To check, run the following cmdlet:

```
Get-VirtualDisk <FriendlyName> | Get-StorageTier 
```

If the cmdlet returns nothing, the virtual disk does not use storage tiers.

### No storage tiers

If the virtual disk has no storage tiers, you can resize it directly using the **Resize-VirtualDisk** cmdlet.

Provide the new size in the **-Size** parameter.

```
Get-VirtualDisk <FriendlyName> | Resize-VirtualDisk -Size <Size>
```

When you resize the VirtualDisk, the Disk follows automatically and is resized too.

(IMAGE HERE)

### With storage tiers

If the virtual disk uses storage tiers, you can resize each tier separately using the **Resize-StorageTier** cmdlet.

Get the names of the storage tiers by following the associations from the virtual disk.

```
Get-VirtualDisk <FriendlyName> | Get-StorageTier | Select FriendlyName
```

Then, for each tier, provide the new size in the **-Size** parameter.

```
Get-StorageTier <FriendlyName> | Resize-StorageTier -Size <Size>
```

> [!TIP]
> If your tiers are different physical media types (such as **MediaType = SSD** and **MediaType = HDD**) you need to ensure you have enough capacity of each media type in the storage pool to accommodate the new, larger footprint of each tier.

When you resize the StorageTier(s), the VirtualDisk and Disk follow automatically and are resized too.

## Step 2 – Resize partition

Next, resize the partition using the **Resize-Partition** cmdlet. The virtual disk is expected to have two partitions: the first is Reserved and should not be modified; the one you need to resize has **PartitionNumber = 2** and **Type = Basic**.

Provide the new size in the **-Size** parameter. We recommend using the maximum supported size, as shown below.

```
# Choose virtual disk
$VirtualDisk = Get-VirtualDisk <FriendlyName>

# Get its partition with PartitionNumber = 2
$Partition = $VirtualDisk | Get-Disk | Get-Partition | Where PartitionNumber -Eq 2

# Resize partition to its maximum supported size 
$Partition | Resize-Partition -Size ($Partition | Get-PartitionSupportedSize).SizeMax
```

When you resize the Partition, the Volume and ClusterSharedVolume follow automatically and are resized too.

(IMAGE HERE)

That’s it! You’re done!	

> [!TIP]
> You can verify the volume has the new size by running **Get-Volume**.

## Resume IO

Last, don’t forget to allow IO to the volume to resume, and then resume your workloads.

```
Get-ClusterSharedVolume <FriendlyName> | Resume-ClusterResource
```

## See also

- [Storage Spaces Direct in Windows Server 2016](storage-spaces-direct-overview.md)
