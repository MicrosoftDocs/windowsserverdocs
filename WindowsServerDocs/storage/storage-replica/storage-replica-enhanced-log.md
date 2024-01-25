---
description: Learn about Storage Replica Enhanced Log and the performance improvements it delivers your replication groups
title: Storage Replica Enhanced Log
manager: candyc
ms.author: billy
ms.topic: how-to
author: wbsmolen
ms.date: 06/23/2023
---

# Storage Replica Enhanced Log

>Applies to: Azure Stack HCI 23H2, Windows Server Insiders

Storage Replica leverages a general-purpose logging service for replicating IO to the secondary volume in any replication group. Starting with Azure Stack HCI 23H2, users can opt in to a more performant logging service, **Enhanced Log**. To differentiate this redesigned logging service, we refer to the original logging service as **Traditional Log**.

> [!NOTE]
> Enhanced Log is generally available with Azure Stack HCI 23H2 and available in Public Preview on Windows Server Insiders.

## Enhanced vs. Traditional Log

Traditional Log is based on the [Common Log File System (CLFS)](/windows-hardware/drivers/kernel/introduction-to-the-common-log-file-system).

Enhanced Log avoids file system abstractions and their performance costs by leveraging a raw format for logging IO that needs to be replicated.  Enhanced Log introduces an architecture that allows for multiple IO data records to be concurrently written to the secondary volume in a replication group, greatly improving overall workload performance.

> [!IMPORTANT]
> There is no migration path from Storage Replica Traditional Log to Enhanced Log, nor vice versa. The Log Format must be declared when the Storage Replica partnership is created.

## Enhanced Log Deployment Steps

Follow the steps below to deploy a Storage Replica Partnership with Enhanced Log:

1. Create standard new CSV_ReFS formatted volumes for Storage Replica data/data replication on each site's storage pool:

    ```powershell
    New-Volume -FriendlyName south-data -StoragePoolFriendlyName "Pool for Site South" -Size 1tb -FileSystem CSVFS_ReFS
    ```
    
    ```powershell
    New-Volume -FriendlyName north-data -StoragePoolFriendlyName "Pool for Site North" -Size 1tb -FileSystem CSVFS_ReFS
    ```

2. Create a new virtual disk for Storage Replica logs and initialize the partition for each site:

    ```powershell
    New-VirtualDisk -FriendlyName south-log -StoragePoolFriendlyName "Pool for Site South" -Size 16gb
    ```
    
    ```powershell
    New-VirtualDisk -FriendlyName north-log -StoragePoolFriendlyName "Pool for Site North" -Size 16gb
    ```

3. Identify the disk number of the partitions you initialized in Step 2 so you can assign a drive letter:

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

4. Create the new Storage Replica Partnership using the `-LogType Raw` parameter to leverage Enhanced Log functionality:

    ```powershell
    New-SRPartnership -SourceComputerName <Source Computer Hostname> -SourceRGName <Source Replication Group Name> -SourceVolumeName 'C:\ClusterStorage\south-data\' -SourceLogVolumeName e: -DestinationComputerName <Destination Computer Name> -DestinationRGName <Destination Replication Group Name> -DestinationVolumeName 'C:\ClusterStorage\north-data\' -DestinationLogVolumeName f: -LogType Raw -EnableCompression
    ```
    
    > [!NOTE]
    > `-EnableCompression` is only needed if you intend to use SMB Compression for Storage Replica traffic.

You may use `-LogType FileBased` to deploy the Storage Replica Partnership using the Traditional Log format.

## More information

* [Stretch Cluster Replication Using Shared Storage](stretch-cluster-replication-using-shared-storage.md)
* [Server to Server Storage Replication](server-to-server-storage-replication.md)
* [Cluster to Cluster Storage Replication](cluster-to-cluster-storage-replication.md)
* [Storage Replica: Known Issues](storage-replica-known-issues.md)
* [Storage Replica: Frequently Asked Questions](storage-replica-frequently-asked-questions.yml)
* [Storage Spaces Direct](/azure-stack/hci/concepts/storage-spaces-direct-overview)
* [Windows IT Pro Support](https://www.microsoft.com/itpro/windows/support)
