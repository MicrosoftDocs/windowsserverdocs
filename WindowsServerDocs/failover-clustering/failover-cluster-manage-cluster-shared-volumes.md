---
title: Manage Cluster Shared Volumes
description: Learn how to manage Cluster Shared Volumes (CSVs) in a failover cluster in Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 07/08/2025
---

# Manage Cluster Shared Volumes

Cluster Shared Volumes (CSVs) are a Windows Server and Azure Local feature that enables multiple nodes in a failover cluster to concurrently access the same NTFS or ReFS volume. This shared access is essential for high-availability workloads such as Hyper-V and Scale-Out File Server, allowing virtual machines and applications to move seamlessly between cluster nodes without requiring changes to drive letters or mount points. CSVs streamline storage management, enhance flexibility, and support continuous availability. You can manage CSVs using tools like Failover Cluster Manager and Windows PowerShell, which provide capabilities for adding disks, configuring caching, and performing backups.

## Prerequisites

To manage CSVs, ensure the following prerequisites are met:

- Your device must be running Windows Server 2012 or later and the **Failover Clustering** feature is installed on all nodes (servers) in the cluster. To learn more, see [Add or remove roles and features in Windows Server](/windows-server/administration/server-manager/add-remove-roles-features).

- You must be a member of the **Administrators**, **Domain Admins**, or **Cluster Administrators** group.

- Your cluster configuration must have at least two nodes configured in a failover cluster. All nodes must be joined to the same Active Directory (AD) domain.

- At least one shared disk (LUN) must be accessible by all cluster nodes and configured as a cluster disk using NTFS or ReFS. Format SAN volumes with NTFS and Storage Spaces Direct (S2D) volumes with ReFS for optimal performance. If you're using iSCSI or Fibre Channel for shared storage, ensure that multipath I/O (MPIO) is properly configured to provide redundancy and optimal performance.

- At least two network interfaces per node are recommended, one for cluster communication and one for client access. Ensure that the network settings allow for proper communication between nodes, including correct IP addresses and subnet configurations. Make sure firewalls are configured to permit necessary cluster traffic.

## Add a CSV to a failover cluster

The CSV feature is enabled by default in Failover Clustering. To add a disk to a CSV, you must add a disk to the **Available Storage** group of the cluster (if it isn't already added), and then add the CSV on the cluster. When you add disks to a Windows Failover Cluster, they're typically placed in the **Available Storage** group if they aren't immediately assigned to any specific cluster roles or configurations. This placement acts as a holding area for disks that are recognized by the cluster but not yet designated for a specific use within the cluster.

You can use the Failover Cluster Manager or PowerShell to perform these procedures.

# [Failover Cluster Manager](#tab/fcm)

1. In **Server Manager**, select **Tools**, then select **Failover Cluster Manager**.

   Alternatively, select **Start**, type **cluadmin.msc**, and press **Enter**.

1. In the left pane under **Failover Cluster Manager**, expand your cluster, and then expand **Storage**.

1. Select **Disks**, then in the right pane, select **Add Disk**.

1. The wizard lists the available disks that can be added to the cluster. Select the disk you want to add and select **OK**.

1. The newly added disk is assigned to **Available Storage** under the **Assigned To** column. Right-click on the disk and select **Add to Cluster Shared Volumes**.

# [PowerShell](#tab/powershell)

1. Open PowerShell in an elevated window.

1. To view all available disks that can be added to your cluster, run the following command:

   ```powershell
   Get-ClusterAvailableDisk
   ```

1. To add all available disks to the **Available Storage** group, run the following command:

   ```powershell
   Add-ClusterDisk
   ```

   To add a specific disk, you can run the following command and filter based on properties like `Number`, `Name`, or `UniqueId`. This example uses the `Number` associated to `DiskNumber`:

   ```powershell
   $addClusterDisk = Get-ClusterAvailableDisk | Where-Object { $_.Number -eq <DiskNumber> }
   $addClusterDisk | Add-ClusterDisk
   ```

1. Once the disk is added to the cluster, run the following command to add the disk as a CSV:

   ```powershell
   Add-ClusterSharedVolume -Name "Cluster Disk Name"
   ```

1. To verify all available disks added as a CSV, run the following command:

   ```powershell
   Get-ClusterSharedVolume
   ```

---

> [!TIP]
> You can rename the CSV volumes in the `%SystemDrive%\ClusterStorage` folder.

## Enable the CSV cache for read-intensive workloads (optional)

The CSV cache enhances performance by using system memory (RAM) to cache block-level, read-only, unbuffered I/O operations. Since unbuffered I/O bypasses the standard cache manager, enabling the CSV cache is beneficial for workloads like Hyper-V, where virtual hard disks (VHDs) are accessed using unbuffered I/O. The CSV cache accelerates read operations but doesn't cache write operations. This feature is also valuable in Scale-Out File Server environments to improve read performance. It's recommended that you enable CSV cache for all clustered Hyper-V and Scale-Out File Server deployments.

> [!NOTE]
> In Windows Server 2016 and later versions, the CSV cache is enabled by default with 1 gibibyte (GiB) of memory allocated. In Windows Server 2012 R2, the cache is enabled by default, but you must manually specify the amount of memory to reserve for the block cache as it isn't preallocated. In Windows Server 2012, administrators must manually enable and configure the CSV cache as it's disabled by default.

The following table describes the two configuration settings that control the CSV cache.

| Windows Server 2012 R2 and later |  Windows Server 2012                 | Description |
| -------------------------------- | ------------------------------------ | ----------- |
| BlockCacheSize                   | SharedVolumeBlockCacheSizeInMB       | This is a cluster common property that allows you to define how much memory (in megabytes) to reserve for the CSV cache on each node in the cluster. For example, if a value of 512 is defined, then 512 MB of system memory is reserved on each node. In many clusters, 512 MB is a recommended value. The default setting is 0 (disabled). |
| EnableBlockCache                 | CsvEnableBlockCache                  | This is a private property of the cluster Physical Disk resource. It allows you to enable CSV cache on an individual disk that is added as a CSV. In Windows Server 2012, the default setting is 0 (disabled). To enable CSV cache on a disk, configure a value of 1. By default, in Windows Server 2012 R2, this setting is enabled. |

To enable the CSV cache on your CSV, open PowerShell in an elevated window and perform the following steps:

1. To view the current CSV cache setting, run the following command:

   ```powershell
   Get-ClusterSharedVolume | Select Name, BlockCacheSize
   ```

1. To set the amount of memory for the CSV cache to `512 MB` for Windows Server 2012 R2 and later, run the following command:

   ```powershell
   (Get-Cluster).BlockCacheSize = 512
   ```

   For Windows Server 2012, run the following command:

   ```powershell
   (Get-Cluster).SharedVolumeBlockCacheSizeInMB = 512
   ```

1. To enable the CSV cache in Windows Server 2012, run the following command replacing `Cluster Disk #` with your value:

    ```PowerShell
    Get-ClusterSharedVolume "Cluster Disk #" | Set-ClusterParameter CsvEnableBlockCache 1
    ```

## Monitor CSV cache

You can monitor the CSV cache using Performance Monitor. This tool helps administrators track cache usage, identify potential bottlenecks, and analyze cache efficiency. Monitoring metrics such as cache hits, misses, and memory usage enables proactive performance tuning and helps maintain optimal cluster reliability. To add this counter, follow these steps:

1. Select **Start**, type **perfmon**, then select **Performance Monitor**.

1. In the left pane, select **Performance Monitor**, then in the right pane, select the green **+** (plus sign) button.

1. In the **Add Counters** window, under **Select counters from computer**, choose from the list **Cluster CSV Volume Cache**.

1. Select **Add >>** then select **OK**.

> [!NOTE]
>
> - In Windows Server 2012, you can allocate only 20% of the total physical RAM to the CSV cache. In Windows Server 2012 R2 and later, you can allocate up to 80%. Because Scale-Out File Servers aren't typically memory constrained, you can accomplish large performance gains by using the extra memory for the CSV cache.
> - To avoid resource contention, you should restart each node in the cluster after you modify the memory that is allocated to the CSV cache. In Windows Server 2012 R2 and later, a restart isn't required.
> - After you enable or disable CSV cache on an individual disk, for the setting to take effect, you must take the physical disk resource offline and bring it back online.

## Backing up CSVs

There are multiple methods to back up data stored on CSVs in a failover cluster. You can use a Microsoft backup application or a non-Microsoft application. In general, backing up CSVs follows the same procedures and requirements as backing up other clustered storage volumes formatted with NTFS or ReFS. No extra or unique backup steps are required specifically for CSVs. CSV backups also don't disrupt other CSV storage operations.

Be sure to carefully review what data your backup application backs up and restores, which CSV features it supports, and the resource requirements for the application on each cluster node. You should consider the following factors when you select a backup application and backup schedule for your CSVs:

- You might need to provide administrative credentials when backing up a failover cluster.

- Volume-level backup of a CSV volume can be run from any node that connects to the CSV volume.

- Your backup application can use software snapshots or hardware snapshots. Depending on the ability of your backup application to support them, backups can use application-consistent and crash-consistent Volume Shadow Copy Service (VSS) snapshots.

- If you're backing up CSV that have multiple running virtual machines (VM), you should generally choose a management operating system-based backup method. If your backup application supports it, multiple virtual machines can be backed up simultaneously.

- CSVs support backup operations using Windows Server Backup. However, Windows Server Backup is a basic solution and may not meet the needs of larger clusters. It doesn't support application-consistent backups for VMs on CSVs, providing only crash-consistent volume-level backups. When you restore a crash-consistent backup, the VM is in the same state as if it had crashed at the time of backup. Although backing up a VM on a CSV volume completes successfully, an error event is logged to indicate that application-consistent backup isn't supported.

> [!WARNING]
> If you need to restore the backup data onto a CSV volume, be aware of the capabilities and limitations of the backup application to maintain and restore application-consistent data across the cluster nodes. For example, with some applications, if the CSV is restored on a node that is different from the node where the CSV volume was backed up, you might inadvertently overwrite important data about the application state on the node where the restore is taking place.

## See also

- [Cluster Shared Volumes overview](failover-cluster-csvs.md)

- [Understanding the state of your Cluster Shared Volumes](https://techcommunity.microsoft.com/t5/failover-clustering/understanding-the-state-of-your-cluster-shared-volumes/ba-p/371889)

- [Cluster Shared Volume Diagnostics](https://techcommunity.microsoft.com/t5/failover-clustering/cluster-shared-volume-diagnostics/ba-p/371908)

