---
description: Learn about Storage Replica Enhanced Log and the performance improvements it delivers your replication groups
title: Storage Replica Enhanced Log
manager: candyc
ms.author: billy
ms.topic: troubleshooting
author: wbsmolen
ms.date: 06/19/2023
---

# Deploying Storage Replica Enhanced Log

>Applies to: Azure Stack HCI 23H2

Storage Replica leverages a general-purpose logging service for replicating IO to the secondary volume in any replication group. Starting with Azure Stack HCI 23H2, users can opt-in to a more performant logging service, **Enhanced Log**. To differentiate this redesigned logging service, we refer to the original logging service as **Traditional Log**.

Follow the steps below to deploy Storage Replica

## Enhanced Log for Stretched Clusters

### Step 1

Create standard new CSV_ReFS formatted volumes for Storage Replica data/data replication on each site's storage pool:

```PowerShell
New-Volume -FriendlyName south-data -StoragePoolFriendlyName "pool for site South" -Size 1tb -FileSystem CSVFS_ReFS
```

```PowerShell
New-Volume -FriendlyName north-data -StoragePoolFriendlyName "pool for site North" -Size 1tb -FileSystem CSVFS_ReFS
```

### Step 2

Createa a new virtual disk for Storage Replica Logs and initialize the partition for each site:

```PowerShell
New-VirtualDisk -FriendlyName south-log -StoragePoolFriendlyName "pool for site South" -Size 16gb
```

```PowerShell
New-VirtualDisk -FriendlyName north-log -StoragePoolFriendlyName "pool for site North" -Size 16gb
```

### Step 3

Identify the disk number of the partitions you initialized in Step 2 so you can assign a drive letter:

On site 1:

```Powershell
New-Partition -DiskNumber <disknumber> -DriveLetter 'e' -UseMaximumSize
```

On site 2:

```Powershell
New-Partition -DiskNumber <disknumber> -DriveLetter 'f' -UseMaximumSize
```

### Step 4

Create the new Storage Replica Partnership using the `-LogType RAW` parameter to specify the new logging service:

```Powershell
New-SRPartnership -SourceComputerName <computer name> -SourceRGName <source group name> -SourceVolumeName C:\ClusterStorage\south-data\ -SourceLogVolumeName e: -DestinationComputerName <source destination computer name> -DestinationRGName <destination resource group name> -DestinationVolumeName 'C:\ClusterStorage\north-data\' -DestinationLogVolumeName e: -LogType RAW -Enablecompression
```

> [!NOTE]
> `-Enablecompression` is only needed if its desired to use SMB compression for the storage replica traffic.
