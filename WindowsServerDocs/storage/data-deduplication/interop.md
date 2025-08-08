---
description: "Discover supported and unsupported scenarios to ensure compatibility and avoid configuration issues in your Windows Server environment."
#customer intent: As an IT professional, I want to know the supported and unsupported scenarios for Data Deduplication so that I can avoid configuration issues.
title: Data Deduplication interoperability in Windows Server
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ms.date: 06/30/2025
---
# Data Deduplication interoperability

Data Deduplication is a Windows Server feature that helps optimize storage by identifying and removing duplicate data without affecting file access or integrity. This article describes how Data Deduplication interoperates with other Windows Server technologies, including supported and unsupported scenarios. Use this information to ensure compatibility and maintain optimal performance when deploying Data Deduplication in your environment.

## Supported scenarios

The following sections describe supported scenarios for Data Deduplication with other Windows Server features and technologies.

### ReFS

Data Deduplication is supported starting with Windows Server 2019.

### Failover Clustering

[Failover Clustering](../..//failover-clustering/failover-clustering-overview.md) is fully supported, when every node in the cluster has the [Data Deduplication feature installed](install-enable.md#install-dedup).

When you're using Data Deduplication with Failover Clustering, the following points must be considered.

- [Manually started Data Deduplication jobs](run.md#running-dedup-jobs-manually) must be run on the Owner node for the Cluster Shared Volume.

- Scheduled Data Deduplication jobs are stored in the cluster task scheduled. Meaning when another node takes over the deduplicated volume, the scheduled job is applied on the next scheduled interval.

- Data Deduplication fully interoperates with the [Cluster OS Rolling Upgrade](../..//failover-clustering/cluster-operating-system-rolling-upgrade.md) feature.

- Data Deduplication is fully supported on [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md) with ReFS or NTFS-formatted volumes (mirror or parity).

  - ReFS-formatted volumes are supported starting with Windows Server 2019.

  - Deduplication isn't supported on volumes with multiple storage tiers.

### Storage Replica

[Storage Replica](../storage-replica/storage-replica-overview.md) is fully supported. Data Deduplication should be configured to not run on the secondary copy.

### BranchCache

You can optimize data access over the network by enabling [BranchCache](../../networking/branchcache/branchcache.md) on servers and clients. When a BranchCache-enabled system communicates over a WAN with a remote file server that is running data deduplication, all of the deduplicated files are already indexed and hashed. Therefore, requests for data from a branch office are quickly computed. This is similar to preindexing or prehashing a BranchCache-enabled server.

### DFS Replication

Data Deduplication works with Distributed File System (DFS) Replication. Optimizing or unoptimizing a file doesn't trigger a replication because the file doesn't change. DFS Replication uses Remote Differential Compression (RDC), not the chunks in the chunk store, for over-the-wire savings. The files on the replica can also be optimized by using deduplication if the replica is using Data Deduplication.

### Quotas

Data Deduplication doesn't support creating a hard quota on a volume root folder that also has deduplication enabled. When a hard quota is present on a volume root, the actual free space on the volume and the quota-restricted space on the volume aren't the same. This difference in free space might cause deduplication optimization jobs to fail. However, you can create a soft quota on a volume root that has deduplication enabled.

When quota is enabled on a deduplicated volume, quota uses the logical size of the file rather than the physical size of the file. When deduplication processes a file, the quota usage (including any quota thresholds) doesn't change. All other quota functionality, including volume-root soft quotas and quotas on subfolders, works normally when using deduplication.

### Windows Server Backup

Windows Server Backup can back up an optimized volume as-is (that is, without removing deduplicated data). The following steps show how to back up a volume and how to restore a volume or selected files from a volume using Windows Server Backup with PowerShell.

1. Back up the E: volume to another volume by running the following command, substituting the correct volume names for your situation.

    ```PowerShell
    wbadmin start backup –include:E: -backuptarget:F: -quiet
    ```

1. Get the version ID of the backup you created.

    ```PowerShell
    wbadmin get versions
    ```

    This output version ID is a date and time string, for example: 08/18/2016-06:22.

1. Restore the entire volume.

    ```PowerShell
    wbadmin start recovery –version:02/16/2012-06:22 -itemtype:Volume  -items:E: -recoveryTarget:E:
    ```

    **--OR--**

    Restore a particular folder (in this case, the E:\Docs folder):

    ```PowerShell
    wbadmin start recovery –version:02/16/2012-06:22 -itemtype:File  -items:E:\Docs  -recursive
    ```

## Unsupported scenarios

The following sections describe scenarios that aren't supported with Data Deduplication.

### Nested Virtualization

Data Deduplication isn't supported in a nested virtualization scenario. This means that you can't run Data Deduplication inside a virtual machine that is running on a Hyper-V host that has nested virtualization enabled. For example, in Hyper-V VDI scenarios, enabling data deduplication on VM’s drive that hosts other VMs isn't supported.

### Windows 10 (client OS)

Data Deduplication isn't supported on Windows 10. Some community blog posts describe how to take the binaries from Windows Server 2016 and put them on Windows 10. This method isn't supported.

### Windows Search

Windows Search doesn't support Data Deduplication. Data Deduplication uses reparse points, which Windows Search can't index, so Windows Search skips all deduplicated files, excluding them from the index. As a result, search results might be incomplete for deduplicated volumes.

### Robocopy

Running Robocopy with Data Deduplication isn't recommended because certain Robocopy commands can corrupt the Chunk Store. The Chunk Store is stored in the System Volume Information folder for a volume. If you delete the System Volume Information folder, the optimized files (reparse points) copied from the source volume become corrupted. This happens because the data chunks aren't copied to the destination volume.
