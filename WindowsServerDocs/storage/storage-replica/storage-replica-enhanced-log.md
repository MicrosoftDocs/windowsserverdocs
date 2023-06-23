---
description: Learn about Storage Replica Enhanced Log and the performance improvements it delivers your replication groups
title: Storage Replica Enhanced Log
manager: candyc
ms.author: billy
ms.topic: troubleshooting
author: wbsmolen
ms.date: 06/23/2023
---

# Deploying Storage Replica Enhanced Log

>Applies to: Azure Stack HCI 23H2

Storage Replica leverages a general-purpose logging service for replicating IO to the secondary volume in any replication group. Starting with Azure Stack HCI 23H2, users can opt-in to a more performant logging service, **Enhanced Log**. To differentiate this redesigned logging service, we refer to the original logging service as **Traditional Log**.

Follow the steps below to deploy Storage Replica.

## Enhanced Log for Stretched Clusters

### Step 1

Create standard new CSV_ReFS formatted volumes for Storage Replica data/data replication on each site's storage pool:

```powershell
New-Volume -FriendlyName south-data -StoragePoolFriendlyName "Pool for Site South" -Size 1tb -FileSystem CSVFS_ReFS
```

```powershell
New-Volume -FriendlyName north-data -StoragePoolFriendlyName "Pool for Site North" -Size 1tb -FileSystem CSVFS_ReFS
```

### Step 2

Createa a new virtual disk for Storage Replica logs and initialize the partition for each site:

```powershell
New-VirtualDisk -FriendlyName south-log -StoragePoolFriendlyName "Pool for Site South" -Size 16gb
```

```powershell
New-VirtualDisk -FriendlyName north-log -StoragePoolFriendlyName "Pool for Site North" -Size 16gb
```

### Step 3

Identify the disk number of the partitions you initialized in Step 2 so you can assign a drive letter:

```powershell
Get-Disk
```

On site 1:

```powershell
New-Partition -DiskNumber <Disk Number> -DriveLetter 'e' -UseMaximumSize
```

On site 2:

```powershell
New-Partition -DiskNumber <Disk Number> -DriveLetter 'f' -UseMaximumSize
```

### Step 4

Create the new Storage Replica Partnership using the `-LogType Raw` parameter to specify the new logging service:

```powershell
New-SRPartnership -SourceComputerName <Source Computer Hostname> -SourceRGName <Source Replication Group Name> -SourceVolumeName 'C:\ClusterStorage\south-data\' -SourceLogVolumeName e: -DestinationComputerName <Destination Computer Name> -DestinationRGName <Destination Replication Group Name> -DestinationVolumeName 'C:\ClusterStorage\north-data\' -DestinationLogVolumeName f: -LogType Raw -EnableCompression
```

> [!NOTE]
> `-EnableCompression` is only needed if you intend to use SMB Compression for Storage Replica traffic.
