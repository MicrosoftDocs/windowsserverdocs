---
title: Storage Replica Overview
description: Get an overview of Storage Replica in Windows Server.
ms.author: roharwoo
ms.topic: overview
author: robinharwood
ms.date: 08/22/2025
---
# Storage Replica overview

Storage Replica in Windows Server protects your critical data by replicating volumes between servers or clusters for disaster recovery. Whether you're safeguarding against hardware failures, natural disasters, or planned maintenance, Storage Replica ensures zero data loss with the ability to create stretch failover clusters that span multiple sites while keeping all nodes synchronized.

Storage Replica supports synchronous and asynchronous replication:

* **Synchronous replication** mirrors data within a low-latency network site with crash-consistent volumes to ensure zero data loss at the file system level during a failure.
* **Asynchronous replication** mirrors data across sites beyond metropolitan ranges over network links with higher latencies, but without a guarantee that both sites have identical copies of the data at the time of a potential failure.

## Why use Storage Replica?

Storage Replica offers disaster recovery and preparedness capabilities in Windows Server. Storage Replica in Windows Server offers the peace of mind of zero data loss, with the ability to synchronously protect data on different racks, floors, buildings, campuses, counties, and cities. After a disaster strikes, all data exists elsewhere without any possibility of loss. The same applies *before* a disaster. Storage Replica can help you switch workloads to safe locations with no data loss before a catastrophe when you have a few moments warning.

Use Storage Replica for a more efficient use of multiple datacenters. By stretching or replicating clusters, you can run workloads in multiple datacenters for quicker data access by close-proximity users and applications. You also get better load distribution and use of compute resources. If a disaster takes one datacenter offline, you can temporarily move its typical workloads to the other site.

When you implement Storage Replica, you might be able to decommission existing file replication systems, like DFS Replication, that were pressed into duty as low-end disaster recovery solutions. Although DFS Replication works well over low-bandwidth networks, its latency is high. Latency in that scenario often is measured in hours or days. The high latency is due to its requirement that files close and to its artificial throttles, which are meant to prevent network congestion. With those design characteristics, the newest and hottest files in a DFS Replication replica are the least likely to replicate.

Storage Replica operates below the file level and has none of these restrictions.

Storage Replica also supports asynchronous replication for longer ranges and higher-latency networks. Because it isn't checkpoint-based, and instead, it continuously replicates, the delta of changes tends to be far lower than snapshot-based products.

Storage Replica operates at the partition layer and therefore replicates all Volume Shadow Copy Service (VSS) snapshots that Windows Server or backup software creates. By using VSS snapshots, you can get application-consistent data snapshots for point-in-time recovery, especially for unstructured user data that replicates asynchronously.

## Supported configurations

You can deploy Storage Replica in a stretch cluster, from cluster to cluster, and in a server-to-server configuration.

### Stretch cluster replication

Use *stretch cluster replication* to replicate data between computers and storage in a single cluster. In this scenario, some nodes share a set of asymmetric storage and some nodes share another set of storage. Then, they synchronously or asynchronously replicate with site awareness.

In Storage Replica stretch cluster replication, you can use Storage Spaces with shared Serial Attached SCSI (SAS) storage, Storage Area Network (SAN) Logical Unit Numbers (LUNs), and iSCSI-attached LUNs.

You manage a stretch cluster configuration by using PowerShell and the Failover Cluster Manager graphical tool. The scenario supports automated workload failover.

The following figure depicts storage replication in a stretch cluster by using Storage Replica:

![Diagram showing two cluster nodes in New York that use Storage Replica to replicate its storage with two nodes in New Jersey](./media/Storage-Replica-Overview/Storage_SR_StretchCluster.png)

### Cluster-to-cluster replication

In *cluster-to-cluster replication*, one cluster synchronously or asynchronously replicates with another cluster.

In Storage Replica cluster-to-cluster replication, you can use Storage Spaces Direct, Storage Spaces with shared SAS storage, SAN LUNs, and iSCSI-attached LUNs.

You manage a cluster-to-cluster configuration by using Windows Admin Center and PowerShell. The configuration requires manual intervention for failover.

The following figure depicts cluster-to-cluster storage replication by using Storage Replica:

![Diagram showing a cluster in Los Angeles using Storage Replica to replicate its storage with a different cluster in Las Vegas](./media/Storage-Replica-Overview/Storage_SR_ClustertoCluster.png)

### Server-to-server replication

*Server-to-server replication* is synchronous and asynchronous replication between two standalone servers.

In this scenario, you can use Storage Spaces with shared SAS storage, SAN LUNs, iSCSI-attached LUNs, and local drives.

You manage a server-to-server configuration by using Windows Admin Center and PowerShell. The configuration requires manual intervention for failover.

The following figure depicts server-to-server storage replication by using Storage Replica:

![Diagram showing a server in Building 5 replicating with a server in Building 9.](./media/Storage-Replica-Overview/Storage_SR_ServertoServer.png)

> [!NOTE]
> You can also configure server-to-self replication by using four separate volumes on one computer. However, this article doesn't cover this scenario.

## Storage Replica features

Storage Replica in Windows Server offers the following features:

* *Zero data loss and block-level replication*. With synchronous replication, there's no possibility of data loss. With block-level replication, there's no possibility of file locking.

* *Simple deployment and management*. Storage Replica has a design mandate for ease of use. You can use Windows Admin Center to create a replication partnership between two servers. Use an intuitive wizard in the familiar Failover Cluster Manager tool to deploy stretch clusters.

* *Guest and host*. All capabilities of Storage Replica are exposed in both virtualized guest and host-based deployments. Guests can replicate their data volumes even if running on non-Windows virtualization platforms or in public clouds if Windows Server is in the guest environment.

* *SMB 3-based*. Storage Replica uses the proven and mature technology of Server Message Block (SMB) 3, first released in Windows Server 2012. All SMB advanced characteristics, including multichannel and SMB direct support on RoCE, iWARP, and InfiniBand RDMA network cards, are available to Storage Replica.

* *Security*. Unlike many vendor products, Storage Replica has industry-leading security technology baked in. It includes packet signing, AES-128-GCM full data encryption, support for Intel AES-NI encryption acceleration, and preauthentication integrity man-in-the-middle attack prevention. Storage Replica uses Kerberos AES256 for all authentication between nodes.

* *High-performance initial sync*. Storage Replica supports seeded initial sync, where a subset of data already exists on a target from older copies, backups, or shipped drives. Initial replication copies only the differing blocks, potentially shortening initial sync time and preventing data from using up limited bandwidth. Block checksum calculation and aggregation in Storage Replica means that initial sync performance is limited only by the speed of the storage and the network.

* *Consistency groups*. Write ordering guarantees that applications like SQL Server can write to multiple replicated volumes and the data is written on the destination server sequentially.

* *User delegation*. Users can be granted permissions to manage replication without being a member of the built-in Administrators group on the replicated nodes. The advantage is that their access to unrelated areas is limited.

* *Network constraint*. You can limit Storage Replica to individual networks by server and by replicated volumes to provide application, backup, and management software bandwidth.

* *Thin provisioning*. Thin provisioning in Storage Spaces and SAN devices is supported to provide near-instantaneous initial replication times under many circumstances. After initial replication is initiated, you can't shrink or trim the volume.

* *Compression*. Storage Replica offers compression for data transferred over the network between the source and destination servers. The Storage Replica Compression for Data Transfer feature is supported only in Windows Server Datacenter: Azure Edition beginning with OS build 20348.1070 and later ([KB5017381](https://support.microsoft.com/help/5017381)).

Storage Replica includes the following features:

| Feature | Details |
| ----------- | ----------- |
| Type | Host-based |
| Synchronous | Yes |
| Asynchronous | Yes |
| Storage hardware-agnostic | Yes |
| Replication unit | Volume (Partition) |
| Windows Server stretch cluster creation | Yes |
| Server to server replication | Yes |
| Cluster to cluster replication | Yes |
| Transport | SMB3 |
| Network | TCP/IP or RDMA |
| Network constraint support | Yes |
| Network compression | Yes\** |
| RDMA\* | iWARP, InfiniBand, RoCE v2 |
| Replication network port firewall requirements | Single IANA port (TCP 445 or 5445) |
| Multipath/Multichannel | Yes (SMB 3) |
| Kerberos support | Yes (SMB 3) |
| Over the wire encryption and signing|Yes (SMB 3) |
| Per-volume failovers allowed | Yes |
| Thin-provisioned storage support | Yes |
| Management UI in-box | PowerShell, Failover Cluster Manager |

\* Might require extra long-haul equipment and cabling.

\** When using Windows Server Datacenter: Azure Edition beginning with OS build 20348.1070.

## Storage Replica prerequisites

* Active Directory Domain Services forest.
* Storage Spaces with Serial Attached SCSI (SAS) "just a bunch of disk" enclosures (JBODs), Storage Spaces Direct, a Fibre Channel Storage Area Network (FC SAN), a shared Virtual Hard Disk v2 (VHDX), an Internet Small Computer Systems Interface (iSCSI) target, or local SAS, SCSI, or Serial Advanced Technology Attachment (SATA) storage. We recommend solid-state drive (SSD) or faster for replication log drives. We recommend that you use log storage that is faster than your data storage. Log volumes must never be used for other workloads.
* At least one Ethernet/TCP connection on each server for synchronous replication, but Remote Direct Memory Access (RDMA) is preferred.
* At least 2 GB of RAM and two cores per server.
* A network between servers with enough bandwidth to contain your input/output (I/O) write workload and an average of 5-ms roundtrip latency or less for synchronous replication. Asynchronous replication doesn't have a latency recommendation.
* Windows Server Datacenter or Windows Server Standard. Storage Replica running on Windows Server Standard has the following limitations:

  * You must use Windows Server 2019 or later.
  * Storage Replica replicates a single volume instead of an unlimited number of volumes.
  * Volumes can have a size of up to 2 TB instead of unlimited size.

## Background

This section includes information about high-level industry terms, synchronous and asynchronous replication, and key behaviors.

### High-level industry terms

*Disaster recovery* refers to a contingency plan for recovering from site catastrophes so that the business continues to operate. *Data disaster recovery* means that multiple copies of production data are stored in a separate physical location. An example is a stretch cluster, where half the nodes are in one site and half are in another. Disaster preparedness refers to a contingency plan for preemptively moving workloads to a different location before an oncoming disaster, such as a hurricane.

*Service-level agreements (SLAs)* define the availability of an organization's applications and their tolerance of downtime and data loss during planned and unplanned outages. *Recovery Time Objective (RTO)* defines how long the business can tolerate total inaccessibility of data. *Recovery Point Objective (RPO)* defines how much data the business can afford to lose.

### Synchronous replication

*Synchronous replication* guarantees that the application writes data to two locations at once before it completes the I/O operation. This replication is more suitable for mission-critical data because it requires network and storage investments, and it risks degraded application performance by performing writes in two locations.

When application writes occur on the source data copy, the originating storage doesn't acknowledge the I/O immediately. Instead, those data changes replicate to the remote destination copy and return an acknowledgment. Only then does the application receive the I/O acknowledgment. This sequence ensures constant synchronization of the remote site with the source site, in effect extending storage I/Os across the network. If a source site failure occurs, applications can fail over to the remote site and resume their operations with assurance of zero data loss.

| Mode | Diagram | Steps |
| -------- | ----------- | --------- |
| **Synchronous**<p>Zero data loss<p>RPO | ![Diagram showing how Storage Replica writes data in synchronous replication.](./media/Storage-Replica-Overview/Storage_SR_SynchronousV2.png) | 1. Application writes data.<br />2. Log data is written and the data is replicated to the remote site.<br />3. Log data is written at the remote site.<br />4. Acknowledgment is received from the remote site.<br />5. Application write is acknowledged.<p>t & t1 : Data flushed to the volume, logs always write through |

### Asynchronous replication

*Asynchronous replication* means that when the application writes data, the data replicates to the remote site without immediate acknowledgment guarantees. This mode allows faster response time to the application and a disaster recovery solution that works geographically.

When the application writes data, the replication engine captures the write and immediately acknowledges it to the application. The captured data then replicates to the remote location. The remote node processes the copy of the data and gradually acknowledges receipt back to the source copy. Because replication performance is no longer in the application I/O path, the remote site's responsiveness and distance are less important factors. There's risk of data loss if the source data is lost and the destination copy of the data was still in buffer mode without leaving the source.

With its higher-than-zero RPO, asynchronous replication is less suitable for high-availability solutions like failover clusters because they're designed for continuous operation with redundancy and no loss of data.

| Mode | Diagram | Steps |
| -------- | ----------- | --------- |
| **Asynchronous**<p>Near zero data loss<p>(depends on multiple factors)<p>RPO | ![Diagram showing how Storage Replica writes data in asynchronous replication.](./media/Storage-Replica-Overview/Storage_SR_AsynchronousV2.png)|1. Application writes data.<br />2. Log data is written.<br />3. Application write is acknowledged.<br />4. Data is replicated to the remote site.<br />5. Log data is written at the remote site.<br />6. Acknowledgment is received from the remote site.<p>t & t1 : Data flushed to the volume, logs always write through |

### Key evaluation points and behaviors

* Network bandwidth and latency with fastest storage. There are physical limitations in synchronous replication. Because Storage Replica implements an I/O filtering mechanism by using logs and requiring network round trips, synchronous replication is likely to make application writes slower. By using low-latency, high-bandwidth networks and high-throughput disk subsystems for the logs, you minimize performance overhead.

* The destination volume isn't accessible while replicating in Windows Server 2016. When you configure replication, the destination volume dismounts, making it inaccessible to any reads or writes by users. Its drive letter might be visible in common user interfaces like File Explorer, but an application can't actually access the volume. Block-level replication technologies are incompatible with allowing access to the destination target's mounted file system in a volume. New Technology File System (NTFS) and Resilient File System (ReFS) don't support users writing data to the volume while blocks change underneath them.

  The `Test-Failover` cmdlet debuted in Windows Server version 1709 and was also included in Windows Server 2019. The cmdlet now supports temporarily mounting a read-write snapshot of the destination volume for backups, testing, and so on. For more information, see the [Storage Replica FAQ](https://aka.ms/srfaq).

* The Microsoft implementation of asynchronous replication is different than most. Most industry implementations of asynchronous replication rely on snapshot-based replication, in which periodic differential transfers move to the other node and merge. Storage Replica asynchronous replication operates like synchronous replication, except that it removes the requirement for a serialized synchronous acknowledgment from the destination. Storage Replica theoretically has a lower RPO because it continuously replicates. However, it also means that it relies on internal application consistency guarantees rather than using snapshots to force consistency in application files. Storage Replica guarantees crash consistency in all replication modes.

* Many customers use DFS Replication as a disaster recovery solution, even though it's often impractical for that scenario. DFS Replication can't replicate open files and is designed to minimize bandwidth usage at the expense of performance, leading to large recovery point deltas. Storage Replica might allow you to retire DFS Replication from some of these types of disaster recovery duties.

* Storage Replica isn't a backup solution. Some IT environments deploy replication systems as backup solutions due to their zero data loss options compared to daily backups. Storage Replica replicates all changes to all blocks of data on the volume, regardless of the change type. If a user deletes all data from a volume, Storage Replica replicates the deletion instantly to the other volume, irrevocably removing the data from both servers. Don't use Storage Replica as a replacement for a point-in-time backup solution.

* Storage Replica isn't Hyper-V Replica or SQL Server Always On availability groups. Storage Replica is a general-purpose, storage-agnostic engine. By definition, it can't tailor its behavior as ideally as application-level replication. The design and purpose of Storage Replica might lead to specific feature gaps that encourage you to deploy or continue to use specific application replication technologies.

> [!NOTE]
> You can view a list of [known issues](storage-replica-known-issues.md) and expected behaviors and review the [Storage Replica FAQ](storage-replica-frequently-asked-questions.yml).

### Storage Replica terminology

Storage Replica articles frequently use the following terms:

* The *source* is a computer's volume that allows local writes and replicates outbound. Also known as *primary*.

* The *destination* is a computer's volume that doesn't allow local writes and replicates inbound. Also known as *secondary*.

* A *replication partnership* is the synchronization relationship between a source and destination computer for one or more volumes and uses a single log.

* A *replication group* is the organization of volumes and their replication configuration within a partnership, on a per-server basis. A group can contain one or more volumes.

## Related content

* [Stretch cluster replication by using shared storage](stretch-cluster-replication-using-shared-storage.md)
* [Server-to-server storage replication](server-to-server-storage-replication.md)
* [Cluster-to-cluster storage replication](cluster-to-cluster-storage-replication.md)
* [Storage Replica known issues](storage-replica-known-issues.md)
* [Storage Replica FAQ](storage-replica-frequently-asked-questions.yml)
* [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md)
* [Windows IT Pro Support](https://www.microsoft.com/itpro/windows/support)


