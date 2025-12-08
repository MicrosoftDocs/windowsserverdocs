---
title: Cluster Shared Volumes overview
description: Understand Cluster Shared Volumes (CSV) in Windows Server failover clusters, including features, requirements, and best practices for deployment and management.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 07/08/2025
---

# Cluster Shared Volumes overview

A Cluster Shared Volume (CSV) enables multiple nodes in a Windows Server failover cluster or Azure Local to simultaneously have read-write access to the same LUN (disk) that is provisioned as an NTFS volume. The disk can be provisioned as Resilient File System (ReFS); however, the CSV drive is placed in *redirected mode*, meaning write access is sent to the coordinator node. With CSVs, clustered roles can fail over quickly from one node to another node without requiring a change in drive ownership, or dismounting and remounting a volume. CSVs also help simplify the management of a potentially large number of LUNs in a failover cluster.

CSV offers a clustered file system that operates on top of NTFS or ReFS. Typical uses for a CSV include:

- Clustered virtual hard disk (VHD/VHDX) files for a clustered Hyper-V virtual machine (VM).

- Distributed CSV ownership with improved diagnosability

- Increased resiliency through availability of the Server service

- Greater flexibility in the amount of physical memory that you can allocate to CSV cache

- Enhanced interoperability that includes support for ReFS and deduplication.

- Scale-out file shares to store application data for the Scale-Out File Server clustered role. Examples of the application data for this role include Hyper-V VM files and Microsoft SQL Server data. ReFS isn't supported for a Scale-Out File Server in Windows Server 2012 R2 and previous releases. For more information about Scale-Out File Server, see [Scale-Out File Server for Application Data](sofs-overview.md).

- Microsoft SQL Server 2014 (or higher) Failover Cluster Instance (FCI). CSVs don't support the Microsoft SQL Server clustered workload in SQL Server 2012 and earlier versions of SQL Server.

- Windows Server 2019 or higher Microsoft Distributed Transaction Control (MSDTC).

To learn more about CSV functionality introduced in previous versions, see [What's New in Failover Clustering in Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265972(v%3dws.11)).

For information about using data deduplication on CSVs for Virtual Desktop Infrastructure (VDI) scenarios, see blog posts [Deploying Data Deduplication for VDI storage in Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/storage-at-microsoft/deploying-data-deduplication-for-vdi-storage-in-windows-server/ba-p/424777) and [Extending Data Deduplication to new workloads in Windows Server 2012 R2](https://techcommunity.microsoft.com/t5/storage-at-microsoft/extending-data-deduplication-to-new-workloads-in-windows-server/ba-p/424787).

## Requirements and considerations for using CSV in a failover cluster

Before using a CSV in a failover cluster, review the network, storage, and other requirements and considerations in the following sections. To learn more about network adapters and storage options, see [Failover Clustering Hardware Requirements and Storage Options](clustering-requirements.md).

### Node requirements

- **Drive letter of system disk**: On all nodes, the drive letter for the system disk must be the same.

- **Authentication protocol**: The NTLM protocol must be enabled on all nodes. This is enabled by default. Beginning with Windows Server 2019 and Azure Local, NTLM dependencies were removed as it uses certificates for authentication.

### Storage and disk configuration requirements

- **File system format**

  In Windows Server 2012, a disk or storage space for a CSV must be a basic disk that is partitioned with NTFS. In Windows Server 2012 R2, a disk or storage space for a CSV must be a basic disk that is partitioned with NTFS or ReFS. In Windows Server 2016 and later, and Azure Local, a disk or storage space for a CSV must be either a basic disk or GUID Partition Table (GPT) disk that is partitioned with NTFS or ReFS. A best practice is to also review the guidelines that are provided by your storage vendor.

  For optimal performance and functionality, use the following file system guidelines when formatting disks before adding them to CSV:

  - **SAN volumes**: Format with NTFS before adding to CSV. NTFS enables Direct I/O mode for SAN-attached storage, which provides better performance. CSVs formatted with ReFS on SANs operate in redirected I/O mode.
  - **Storage Spaces Direct (S2D) volumes**: Format with ReFS before adding to CSV. ReFS provides data integrity features, block cloning, and optimizations specifically designed for Storage Spaces Direct workloads.

  - In Windows Server 2012, you can't use a disk as a CSV formatted as FAT, FAT32, or ReFS.

  - In Windows Server 2012 R2 and later, you can't use a disk as a CSV formatted as FAT or FAT32.

  - A CSV can't be used as a quorum witness disk. For more information about the cluster quorum, see [Understanding Quorum in Storage Spaces Direct](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering).

  - After you add a disk as a CSV, it's designated in the CSV File System (CSVFS) format. This allows the cluster and other software to differentiate the CSV storage from other NTFS or ReFS storage. Generally, CSVFS supports the same functionality as NTFS and ReFS. However, certain features aren't supported. For example, in Windows Server 2012 R2, you can't enable compression on a CSV. In Windows Server 2012, you can't enable data deduplication or compression on a CSV.

- **Resource type in the cluster**

  A CSV must be used as the Physical Disk resource type. By default, a disk or storage space that is added to a cluster storage is automatically configured in this way.

- **Choice of CSV disks or other disks in cluster storage**

  When choosing one or more disks for a clustered VM, consider how each disk is used. If a disk is used to store files created by Hyper-V, such as VHD/VHDX files or configuration files, you can choose from the CSV disks or the other available disks in cluster storage. If a disk is a physical disk that is directly attached to the VM (also called a pass-through disk), you can't choose a CSV disk, and you must choose from the other available disks in cluster storage.

- **Path name for identifying disks**

  Disks in CSVs are accessed using a path that appears as a numbered volume under the **\\ClusterStorage** folder on the system drive. This path is consistent across all nodes in the cluster. You can rename these volumes if needed, but it's best to do so before installing any VMs or applications like SQL Server. Renaming isn't possible if there are open handles, such as when a VM is running or is in a saved state.

### Arrangement of LUNs, volumes, and VHD files

To make the best use of a CSV to provide storage for clustered VMs, it's helpful to review how you would arrange the LUNs (disks) when you configure physical servers. When you configure the corresponding VMs, try to arrange the VHD files in a similar way.

Consider a physical server for which you would organize the disks and files as follows:

- System files, including a page file, on one physical disk

- Data files on another physical disk

For an equivalent clustered VM, you should organize the volumes and files in a similar way:

- System files, including a page file, in a VHD file on one CSV

- Data files in a VHD file on another CSV

If you add another VM, where possible, you should keep the same arrangement for the VHDs on that VM.

### Number and size of LUNs and volumes

When you plan the storage configuration for a failover cluster that uses CSVs, consider the following recommendations:

- To decide how many LUNs to configure, consult your storage vendor. For example, your storage vendor may recommend that you configure each LUN with one partition and place one CSV on it.

- Create at least one CSV per node.

- There are no limitations for the number of VMs that can be supported on a single CSV. However, you should consider the number of VMs that you plan to have in the cluster and the workload (I/O operations per second) for each VM. For example:

  - One organization deploying VMs that support a virtual desktop infrastructure (VDI), which is a relatively light workload. The cluster uses high-performance storage. The cluster administrator, after consulting with the storage vendor, decides to place a relatively large number of VMs per CSV.

  - Another organization is deploying a large number of VMs that support a heavily used database application, which is a heavier workload. The cluster uses lower-performing storage. The cluster administrator, after consulting with the storage vendor, decides to place a relatively small number of VMs per CSV.

- When you plan the storage configuration for a particular VM, consider the disk requirements of the service, application, or role that the VM supports. Understanding these requirements helps to avoid disk contention that can result in poor performance. The storage configuration for the VM should closely resemble the storage configuration that you would use for a physical server that is running the same service, application, or role. You can also mitigate disk contention by having storage with a large number of independent physical hard disks. Choose your storage hardware accordingly, and consult with your vendor to optimize the performance of your storage.

- Depending on your cluster workloads and their need for I/O operations, you can consider configuring only a percentage of the VMs to access each LUN, while other VMs don't have connectivity and are instead dedicated to compute operations.

### Network configuration considerations

Consider the following when you configure the networks that support CSVs.

- **Multiple networks and multiple network adapters**

  To enable fault tolerance if a network failure occurs, we recommend that multiple cluster networks carry CSV traffic or that you configure teamed network adapters. If the cluster nodes are connected to networks that shouldn't be used by the cluster, you should disable them. For example, we recommend that you disable iSCSI networks for cluster use to prevent CSV traffic on those networks. To disable a network, in Failover Cluster Manager, select **Networks**, select the network, select the **Properties** action, and then select **Do not allow cluster network communication on this network**. Alternatively, you can configure the **Role** property of the network by using the [Get-ClusterNetwork](/powershell/module/failoverclusters/get-clusternetwork) cmdlet.

- **Network adapter properties**

  In the properties for all adapters that carry cluster communication, make sure that the following settings are enabled:

  - **Client for Microsoft Networks** and **File and Printer Sharing for Microsoft Networks**. These settings support Server Message Block (SMB) 3.0, which is used by default to carry CSV traffic between nodes. To enable SMB, ensure that the Server service and the Workstation service are running and that they're configured to start automatically on each cluster node.

    > [!NOTE]
    > In Windows Server 2012 R2 and later, there are multiple Server service instances per failover cluster node. There's the default instance that handles incoming traffic from SMB clients that access regular file shares, and a second CSV instance that handles only inter-node CSV traffic. Also, if the Server service on a node becomes unhealthy, CSV ownership automatically transitions to another node.

    SMB 3.0 includes the SMB Multichannel and SMB Direct features, which enable CSV traffic to stream across multiple networks in the cluster and to leverage network adapters that support Remote Direct Memory Access (RDMA). By default, SMB Multichannel is used for CSV traffic. For more information, see [Server Message Block overview](../storage/file-server/file-server-smb-overview.md).

  - **Microsoft Failover Cluster Virtual Adapter Performance Filter**

    This setting enhances the nodes' capability to perform I/O redirection when necessary to access CSVs. This situation arises, for example, when a connectivity failure prevents a node from directly connecting to the CSV disk. The NetFT Virtual Adapter Performance Filter is disabled by default in all versions except Windows Server 2012 R2. It remains disabled because it may cause issues in Hyper-V clusters that have a guest cluster running inside VMs hosted on them. There are instances where the NetFT Virtual Adapter Performance Filter on the host mistakenly routes NetFT traffic intended for a guest VM to the host instead. This misrouting can lead to communication problems with the guest cluster within the VM. However, if you're deploying any workload **other than** Hyper-V with guest clusters, enabling the NetFT Virtual Adapter Performance Filter can optimize and improve cluster performance.

- **Cluster network prioritization**

  It's recommended that you don't change the cluster-configured preferences for the networks.

- **IP subnet configuration**

  No specific subnet configuration is required for nodes in a network that uses CSVs. CSVs can support multi-subnet stretch clusters.

- **Policy-based Quality of Service (QoS)**

  We recommend that you configure a QoS priority policy and a minimum bandwidth policy for network traffic to each node when you use a CSV. For more information, see [Quality of Service (QoS)](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831679(v%3dws.11)).

- **Storage network**

  For storage network recommendations, review the guidelines that are provided by your storage vendor.

### About I/O synchronization and I/O redirection in CSV communication

- **I/O synchronization**

  CSVs enable multiple nodes to have simultaneous read-write access to the same shared storage. When a node performs disk input/output (I/O) on a CSV, the node communicates directly with the storage, for example, through a storage area network (SAN). However, at any time, a single node (called the coordinator node) "owns" the physical disk resource that is associated with the LUN. The coordinator node for a CSV is displayed in Failover Cluster Manager as **Owner Node** under **Disks**. It also appears in the output of the [Get-ClusterSharedVolume](/powershell/module/failoverclusters/get-clustersharedvolume) cmdlet.

  > [!NOTE]
  > Beginning in Windows Server 2012 R2, CSV ownership is evenly distributed across the failover cluster nodes based on the number of CSVs that each node owns. Additionally, ownership is automatically rebalanced when there are conditions such as CSV failover, a node rejoins the cluster, you add a new node to the cluster, you restart a cluster node, or you start the failover cluster after it was shut down.

  When certain small changes occur in the file system on a CSV, this metadata must be synchronized on each of the physical nodes that access the LUN, not only on the single coordinator node. For example, when a VM on a CSV is started, created, or deleted, or when a VM is migrated, this information needs to be synchronized on each of the physical nodes that access the VM. These metadata update operations occur in parallel across the cluster networks by using SMB 3.0. These operations don't require all the physical nodes to communicate with the shared storage.

- **I/O redirection**

  Storage connectivity failures and certain storage operations can prevent a given node from communicating directly with the storage. To maintain function while the node isn't communicating with the storage, the node redirects the disk I/O through a cluster network to the coordinator node where the disk is currently mounted. If the current coordinator node experiences a storage connectivity failure, all disk I/O operations are queued temporarily while a new node is established as a coordinator node. You should plan your cluster networks to allow for the potential increase in network traffic to the coordinator node during I/O redirection. Because of the integration of CSVs with SMB 3.0 features, such as SMB Multichannel and SMB Direct, redirected I/O traffic can stream across multiple cluster networks.

  > [!IMPORTANT]
  > CSVs pre-formatted with ReFS used on top of SANs **won't use** Direct I/O, regardless of all other requirements for Direct I/O being met. If you plan to use CSV in junction with SAN (FrontEnd) attached disks, format drives with NTFS before converting them to a CSV to leverage the performance benefits of Direct I/O.

The server uses one of the following I/O redirection modes, depending on the situation:

- **File system redirection**: Redirection is per volume. For example, when CSV snapshots are taken by a backup application when a CSV is manually placed in redirected I/O mode.

- **Block redirection**: Redirection is at the file-block level. For example, when storage connectivity is lost to a volume. Block redirection is faster than file system redirection.

In Windows Server 2012 R2 and later, you can view the state of a CSV on a per node basis. For example, you can see whether I/O is direct, redirected, or whether the CSV is unavailable. If a CSV is in I/O redirected mode, you can also view the reason. To view this information, you can run the [Get-ClusterSharedVolumeState](/powershell/module/failoverclusters/get-clustersharedvolumestate?view=windowsserver2022-ps&preserve-view=true) cmdlet.

## See also

- [Failover Clustering overview](failover-clustering-overview.md)

- [What's New in Failover Clustering](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265972(v%3dws.11))

- [Manage Cluster Shared Volumes](failover-cluster-manage-cluster-shared-volumes.md)

- [Deploy Clustered Storage Spaces](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11))

