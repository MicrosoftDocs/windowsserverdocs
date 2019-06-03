---
ms.assetid: 60fca6b2-f1c0-451f-858f-2f6ab350d220
title: Data Deduplication interoperability
ms.technology: storage-deduplication
ms.prod: windows-server-threshold
ms.topic: article
author: wmgries
manager: klaasl
ms.author: wgries
ms.date: 09/16/2016
---
# Data Deduplication interoperability

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2019

## Supported

### ReFS
Data Deduplication is supported as of Windows Server 2019. 

### Failover Clustering

[Failover Clustering](../..//failover-clustering/failover-clustering-overview.md) is fully supported, if every node in the cluster has the [Data Deduplication feature installed](install-enable.md#install-dedup). Other important notes:

* [Manually started Data Deduplication jobs](run.md#running-dedup-jobs-manually) must be run on the Owner node for the Cluster Shared Volume.
* Scheduled Data Deduplication jobs are stored in the cluster task scheduled so that if a deduplicated volume is taken over by another node, the scheduled job will be applied on the next scheduled interval.
* Data Deduplication fully interoperates with the [Cluster OS Rolling Upgrade](../..//failover-clustering/cluster-operating-system-rolling-upgrade.md) feature.
* Data Deduplication is fully supported on [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md) NTFS-formatted volumes (mirror or parity). Deduplication is not supported on volumes with multiple tiers. See [Data Deduplication on ReFS](#unsupported) for more information.

### Storage Replica
[Storage Replica](../storage-replica/storage-replica-overview.md) is fully supported. Data Deduplication should be configured to not run on the secondary copy.

### BranchCache
You can optimize data access over the network by enabling [BranchCache](../../networking/branchcache/branchcache.md) on servers and clients. When a BranchCache-enabled system communicates over a WAN with a remote file server that is running data deduplication, all of the deduplicated files are already indexed and hashed. Therefore, requests for data from a branch office are quickly computed. This is similar to preindexing or prehashing a BranchCache-enabled server.

### DFS Replication
Data Deduplication works with Distributed File System (DFS) Replication. Optimizing or unoptimizing a file will not trigger a replication because the file does not change. DFS Replication uses Remote Differential Compression (RDC), not the chunks in the chunk store, for over-the-wire savings. The files on the replica can also be optimized by using deduplication if the replica is using Data Deduplication.

### Quotas
Data Deduplication does not support creating a hard quota on a volume root folder that also has deduplication enabled. When a hard quota is present on a volume root, the actual free space on the volume and the quota-restricted space on the volume are not the same. This may cause deduplication optimization jobs to fail. It is possible however to creating a soft quota on a volume root that has deduplication enabled. 

When quota is enabled on a deduplicated volume, quota uses the logical size of the file rather than the physical size of the file. Quota usage (including any quota thresholds) does not change when a file is processed by deduplication. All other quota functionality, including volume-root soft quotas and quotas on subfolders, works normally when using deduplication.

### Windows Server Backup
Windows Server Backup can back up an optimized volume as-is (that is, without removing deduplicated data). The following steps show how to back up a volume and how to restore a volume or selected files from a volume.
1. Install Windows Server Backup.  
    ```PowerShell
    Install-WindowsFeature -Name Windows-Server-Backup
    ```

2. Back up the E: volume to another volume by running the following command, substituting the correct volume names for your situation.  
    ```PowerShell
    wbadmin start backup –include:E: -backuptarget:F: -quiet
    ```
3. Get the version ID of the backup you just created.

    ```PowerShell
    wbadmin get versions
    ```

    This output version ID will be a date and time string, for example: 08/18/2016-06:22.

4. Restore the entire volume.
    ```PowerShell
    wbadmin start recovery –version:02/16/2012-06:22 -itemtype:Volume  -items:E: -recoveryTarget:E:
    ```

    **--OR--**  

    Restore a particular folder (in this case, the E:\Docs folder):
    ```PowerShell
    wbadmin start recovery –version:02/16/2012-06:22 -itemtype:File  -items:E:\Docs  -recursive
    ```

## Unsupported

### Windows 10 (client OS)
Data Deduplication is not supported on Windows 10. There are several popular blog posts in the Windows community describing how to remove the binaries from Windows Server 2016 and install on Windows 10, but this scenario has not been validated as part of the development of Data Deduplication. [Vote for this item for Windows 10 vNext on the Windows Server Storage UserVoice](https://windowsserver.uservoice.com/forums/295056-storage/suggestions/9011008-add-deduplication-support-to-client-os).

### Windows Search
Windows Search doesn't support Data Deduplication. Data Deduplication uses reparse points, which Windows Search can't index, so Windows Search skips all deduplicated files, excluding them from the index. As a result, search results might be incomplete for deduplicated volumes. [Vote for this item for Windows Server vNext on the Windows Server Storage UserVoice](https://windowsserver.uservoice.com/forums/295056-storage/suggestions/17888647-make-windows-search-service-work-with-data-dedupli).

### Robocopy
Running Robocopy with Data Deduplication is not recommended because certain Robocopy commands can corrupt the Chunk Store. The Chunk Store is stored in the System Volume Information folder for a volume. If the folder is deleted, the optimized files (reparse points) that are copied from the source volume become corrupted because the data chunks are not copied to the destination volume.
