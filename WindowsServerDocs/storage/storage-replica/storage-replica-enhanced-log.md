---
title: Use Enhanced Log in Storage Replica
description: Learn how to use Enhanced Log in Storage Replica and about the performance improvements it delivers to your replication groups.
author: robinharwood
ms.topic: how-to
ms.author: roharwoo
ms.date: 5/13/2025
---

# Use Enhanced Log in Storage Replica

Storage Replica in Windows Server uses a general-purpose logging service to replicate I/O to the secondary volume in any replication group. Beginning in Windows Server 2025, users can opt in to a higher performance logging service called *Enhanced Log*. To differentiate this redesigned logging service, we refer to the original logging service as *Traditional Log*.

## Enhanced Log vs. Traditional Log

Traditional Log is based on the [Common Log File System (CLFS)](/windows-hardware/drivers/kernel/introduction-to-the-common-log-file-system).

Enhanced Log avoids file system abstractions and their performance costs by using a raw format for logging I/O that needs to be replicated. Enhanced Log introduces an architecture that allows multiple I/O data records to be concurrently written to the secondary volume in a replication group, improving overall workload performance.

> [!IMPORTANT]
> There's no migration path from Storage Replica Traditional Log to Enhanced Log or vice versa. You must declare the log format when you create the Storage Replica partnership.

## Enhanced Log deployment steps

To deploy a Storage Replica partnership that uses Enhanced Log:

1. Create standard new CSV_ReFS formatted volumes for Storage Replica data/data replication on each site's storage pool:

    ```powershell
    New-Volume -FriendlyName south-data -StoragePoolFriendlyName "Pool for Site South" -Size 1tb -FileSystem CSVFS_ReFS
    ```
  
    ```powershell
    New-Volume -FriendlyName north-data -StoragePoolFriendlyName "Pool for Site North" -Size 1tb -FileSystem CSVFS_ReFS
    ```

1. Create a new virtual disk for Storage Replica logs and initialize the partition for each site:

    ```powershell
    New-VirtualDisk -FriendlyName south-log -StoragePoolFriendlyName "Pool for Site South" -Size 16gb
    ```

    ```powershell
    New-VirtualDisk -FriendlyName north-log -StoragePoolFriendlyName "Pool for Site North" -Size 16gb
    ```

1. Identify the disk number of the partitions you initialized in Step 2 so you can assign a drive letter:

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

1. Create the new Storage Replica partnership by using the `-LogType Raw` parameter to access Enhanced Log functionality:

    ```powershell
    New-SRPartnership -SourceComputerName <Source Computer Hostname> -SourceRGName <Source Replication Group Name> -SourceVolumeName 'C:\ClusterStorage\south-data\' -SourceLogVolumeName e: -DestinationComputerName <Destination Computer Name> -DestinationRGName <Destination Replication Group Name> -DestinationVolumeName 'C:\ClusterStorage\north-data\' -DestinationLogVolumeName f: -LogType Raw -EnableCompression
    ```

    > [!NOTE]
    > The `-EnableCompression` parameter is needed only if you intend to use Server Message Block (SMB) compression for Storage Replica traffic.

You can use `-LogType FileBased` to deploy the Storage Replica partnership by using the Traditional Log format.

## Related content

* [Stretch cluster replication by using Shared Storage](stretch-cluster-replication-using-shared-storage.md)
* [Server-to-server storage replication](server-to-server-storage-replication.md)
* [Cluster-to-cluster storage replication](cluster-to-cluster-storage-replication.md)
* [Storage Replica: Known issues](storage-replica-known-issues.md)
* [Storage Replica: FAQ](storage-replica-frequently-asked-questions.yml)
* [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md)
* [Windows IT Pro Support](https://www.microsoft.com/itpro/windows/support)


