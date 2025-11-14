---
title: Failover Clustering Storage Architectures in Windows Server
ms.reviewer: robhind
description: Explore Windows Server Failover Clustering storage topologies like SAN, NAS, hyperconverged, disaggregated, and mixed topologies scale compute and storage efficiently.
#customer intent: As a systems architect, I want to learn how to scale compute and storage in a Windows Server Failover Cluster so that I can optimize resource allocation.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.review: robhind
ms.date: 11/17/2025
ai-usage: ai-assisted
---
# Failover clustering storage architectures

Windows Server Failover Clustering supports several storage architecture patterns that provide high availability and resiliency for clustered roles. This article covers storage architectures including SAN, NAS, hyperconverged, disaggregated Storage Spaces Direct, and mixed topologies.

The storage architectures covered here reflect how compute and storage components scale, and how Cluster Shared Volumes (CSV) or Storage Spaces Direct (S2D) are used. This article doesn't describe every possible storage architecture configuration or uncommon edge cases.

## Architecture comparison

| Architecture | Storage placement | Scaling characteristics |
|--------------|------------------|-------------------------|
| SAN or NAS storage | External shared storage (SAN, NAS, or SMB 3.0 file shares) accessed over the network by a compute cluster. | Compute and storage scale independently (add compute nodes without adding storage; storage growth is vendor-specific). |
| Hyperconverged | Local disks in each cluster node pooled by S2D; data replicated across nodes; CSVs present storage uniformly. | Symmetric scaling—each node adds both compute and storage; cluster supported up to documented node counts for S2D. |
| Hyperconverged with SAN storage | Local S2D pool (ReFS CSVs) plus external SAN volumes (NTFS CSVs) in same cluster; disk sets remain separate. | Dual scaling: add nodes (compute + S2D storage) or expand SAN independently. |
| Disaggregated Storage Spaces Direct | Separate compute cluster accesses storage provided by a distinct S2D storage cluster over the network. | Compute and storage scale independently (add only compute or only storage cluster nodes). |
| Mixed architecture support | Combination of disaggregated SAN/NAS storage and S2D-based storage consumed by the same compute cluster. | Flexible—mix independent and symmetric scaling strategies per workload. |

All architectures rely on cluster capabilities (quorum, health monitoring, failover) described in the overview. CSV usage details (metadata synchronization, redirected I/O) are available in the CSV overview. For SAN and NAS considerations (multipath, isolation), see the clustering hardware requirements. Scale-Out File Server active-active semantics are covered in its overview.

## SAN or NAS storage

Disaggregated SAN or NAS storage (including SMB 3.0 shares) places storage on a separate fabric. Cluster nodes access the storage over the network. Compute and storage scale independently.

The key characteristics of a disaggregated SAN or NAS model are:

- Supports failover for VMs, Scale-Out File Server data, SQL Server (on SMB), and other clustered apps.

- The SAN or NAS platform provides storage availability and resiliency. Use multipath I/O or NIC teaming to eliminate single points of failure (see [hardware requirements](clustering-requirements.md)).

- SMB shares can benefit from SMB Multichannel and SMB Direct for throughput and resiliency.

- Independent scaling: add compute (CPU/RAM) without storage, or expand storage alone.

- Clusters support up to 64 nodes.

Before deploying or expanding a SAN or NAS backed failover cluster, review the following planning considerations:

- Scaling and performance are vendor-specific. Consult your platform guidance.

- Keep firmware and drivers consistent for block protocols (Fibre Channel, iSCSI). Ensure network redundancy for SMB.

- Isolate storage traffic from client and management paths to reduce contention.

- Plan for network path availability and redundancy to match your storage platform's resiliency.

- Apply file share ACLs so only cluster nodes access shared resources.

Choose this model when storage lifecycle or growth differs from compute, or when centralized shared storage must serve multiple clusters. Storage cluster scaling is vendor-specific. Contact your vendors to understand how the storage solution they offer can scale.

## Hyperconverged

In this hyperconverged configuration, Storage Spaces Direct pools the local drives in each cluster node into a shared storage pool, presents volumes as Cluster Shared Volumes (CSV), and replicates data across cluster nodes for resiliency. Compute (CPU and RAM) and storage capacity grow together as you add cluster nodes.

Key characteristics of a hyperconverged model:

- Supports clustered workloads such as virtual machines, Scale-Out File Server application data, SQL Server databases (on SMB and CSV), and containerized applications.

- Cluster failover allows VMs and other clustered roles to move or restart on any node in the cluster.

- Local NVMe, SSD, and HDD devices are pooled, and volumes are exposed as CSVs for a uniform namespace.

- Data resiliency uses mirroring, parity, or nested resiliency, and data is replicated to other nodes. For more information about fault tolerance for Storage Space Direct, see [Fault tolerance and storage efficiency](../storage/storage-spaces/fault-tolerance.md).

- Symmetric scaling, meaning each added node contributes both compute and storage.

- Clusters support between 1 and 16 nodes using Storage Spaces Direct.

- Low-latency east-west networking and, where configured, RDMA (RoCE or iWARP) improves throughput and reduces CPU overhead.

Planning considerations before deploying or expanding hyperconverged clusters:

- Keep firmware and driver versions consistent across storage adapters and drives.

- Validate network configuration (QoS, RDMA priority, and flow control) to avoid congestion and ensure predictable latency.

- Size cache and capacity tiers (NVMe, SSD, and HDD) by using published guidance to maintain recommended ratios for performance.

- Reserve rebuild capacity so the cluster can safely tolerate drive or node failures and avoid running at near 100% utilization.

- Monitor drive, enclosure, and replication health proactively.

:::image type="content" source="media/storage-architectures/hyperconverged-storage.png" alt-text="Diagram of a basic hyperconverged Storage Spaces Direct cluster with compute hosts and pooled local disks." lightbox="media/storage-architectures/hyperconverged-storage.png":::

## Disaggregated Storage Spaces Direct

Disaggregated Storage Spaces Direct separates compute and storage into distinct clusters. A compute cluster (running workloads such as VMs, Scale-Out File Server roles, SQL Server databases, or containerized applications) accesses storage provided by a separate Storage Spaces Direct cluster over SMB 3.0.

Key characteristics of a disaggregated Storage Spaces Direct architecture:

- Independent scaling: add only compute nodes for more CPU and RAM resources or add only storage nodes for capacity and performance. Growth rates can diverge.

- Supports the same clustered workloads as hyperconverged models when exposed via SMB or CSV-backed shares.

- Storage cluster uses mirroring, parity, or nested resiliency and data is replicated to other nodes. To learn more about fault tolerance for Storage Space Direct, see [Fault tolerance and storage efficiency](../storage/storage-spaces/fault-tolerance.md).

- Maintenance isolation: you can patch or reboot storage nodes separately from compute nodes.

- Multiple compute clusters can consume shares from one storage cluster (subject to capacity and performance planning).

- Compute clusters support between 1 and 64 nodes.

- Storage clusters support between 1 and 16 nodes.

- Requires reliable low-latency east-west networking (optionally RDMA) between clusters for predictable performance.

Planning considerations before deploying or expanding disaggregated Storage Spaces Direct:

- Align firmware, drivers, and OS update cadences across storage nodes. Avoid mixed driver versions.

- Validate network configuration (QoS, RDMA priority, and flow control) to avoid congestion and ensure predictable latency.

- Forecast divergent growth (CPU, RAM, capacity, and IOPS) and set thresholds for when to scale each cluster independently.

- Apply least-privilege access. Restrict administrative access between compute and storage clusters, using file share ACLs to required cluster nodes.

- Monitor drive, enclosure, and replication health proactively in the storage cluster so independent compute isn't affected by storage availability.

The following diagram shows a disaggregated deployment with one compute cluster and one storage cluster.

:::image type="content" source="media/storage-architectures/hyperconverged-basic-example.png" alt-text="Diagram of disaggregated architecture: one compute cluster accessing a separate Storage Spaces Direct cluster." lightbox="media/storage-architectures/hyperconverged-basic-example.png":::

When you add more compute resources, you can either add a new node to the existing compute cluster or add a new cluster. The following diagram shows what happens to the simple deployment if you add a new cluster to it without adding more storage.

:::image type="content" source="media/storage-architectures/hyperconverged-basic-compute.png" alt-text="Diagram showing disaggregated model after adding a second compute cluster (compute scale only)." lightbox="media/storage-architectures/hyperconverged-basic-compute.png":::

When you add more storage resources for hosting data without adding more compute resources, you can either add a new node to the existing storage cluster or add a new cluster. The following diagram shows what the simple deployment looks like when you add a new cluster without adding compute resources like CPU or RAM.

:::image type="content" source="media/storage-architectures/hyperconverged-basic-storage.png" alt-text="Diagram showing disaggregated model after adding a second storage cluster (storage scale only)." lightbox="media/storage-architectures/hyperconverged-basic-storage.png":::

## Hyperconverged with SAN storage

This architecture combines a hyperconverged Storage Spaces Direct cluster (local disks pooled and exposed as ReFS-backed CSVs) with external SAN storage presented to the same cluster and added as NTFS-backed CSVs. The two storage sources coexist but remain separate.

Key characteristics of a hyperconverged plus SAN model:

- Coexistence: S2D CSVs and SAN CSVs operate side by side in the same failover cluster.

- Strict separation: SAN disks must never be added to the Storage Spaces Direct pool and are managed independently.

- Formatting requirements:

  - Format SAN volumes as NTFS before converting them to Cluster Shared Volumes.

  - Format Storage Spaces Direct volumes as ReFS before converting them to Cluster Shared Volumes.

- Supported SAN connectivity includes Fibre Channel, iSCSI, and iSCSI Target.

- Workload placement flexibility: Place latency-sensitive or ReFS-optimized workloads (such as large VHDX sets or container layers) on S2D volumes. Place workloads
requiring specific NTFS features or existing SAN management tooling on SAN volumes.

- Independent capacity expansion: Add hyperconverged nodes (adds compute and storage) or expand SAN capacity (adds storage only) without affecting the other.

- Fault domains remain distinct: S2D handles drive and node failures via resiliency sets. SAN handles availability through its own controller, fabric, or multipath design.

- Storage Spaces Direct clusters support between 1 and 16 nodes.

Planning considerations before deploying or expanding a combined hyperconverged plus SAN architecture:

- SAN scaling and performance are vendor-specific—consult platform guidance.

- Don't attempt to add SAN-provided disks into S2D storage pools.

- Maintain consistent firmware and driver versions for both storage subsystems (S2D adapters and SAN HBAs/NICs).

- Establish workload placement guidelines (for example, high churn or dedup suitability) and document which CSV type to use.

- Monitor capacity trends separately: S2D pool utilization versus SAN array utilization to forecast upgrades.

- Align backup and disaster recovery strategies; SAN snapshots and S2D-based volume backups might follow different schedules and tooling.

- Verify performance isolation; heavy SAN I/O shouldn't congest east-west S2D replication traffic.

- You need to plan for SAN and network path availability and redundancy to match each storage platform's availability.

## Mixed architecture support

Hyper-V supports combining the following architectures in the same compute cluster:

- Hyper-V with Disaggregated Storage Spaces Direct

- Disaggregated Hyper-V with SAN

- Disaggregated Hyper-V with NAS

The following diagram shows an example of a deployment with a compute cluster containing a mix of disaggregated SAN and NAS storage.

:::image type="content" source="media/storage-architectures/hyperconverged-mixed-example.png" alt-text="A diagram that shows a deployment with a compute cluster containing a mix of disaggregated SAN and NAS storage." lightbox="media/storage-architectures/hyperconverged-mixed-example.png":::

### Network storage protocols

Windows Server supports the following network file storage protocols:

- [SMB over TCP](/troubleshoot/windows-server/networking/direct-hosting-of-smb-over-tcpip)

- [SMB over QUIC](../storage/file-server/smb-over-quic.md)

- [SMB over RDMA (SMB Direct)](../storage/file-server/smb-direct.md)

Windows Server also supports the following network block storage protocols:

- iSCSI

- Fibre Channel

- InfiniBand

>[!NOTE]
> Configuration specifics ultimately determine whether your deployment supports these protocols. For example, deployments that use the Hyper-V virtual switch don't support InfiniBand. However, they can support InfiniBand devices when they aren't bound to the virtual switch.

Microsoft also provides an in-box software-based iSCSI initiator for network block storage.

You can also use a storage vendor client for any device available in the Windows Server catalog.
