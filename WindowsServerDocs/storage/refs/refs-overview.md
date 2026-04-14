---
description: "Learn more about: Resilient File System (ReFS) overview"
title: Resilient File System (ReFS) overview
ms.author: roharwoo
ms.topic: overview
author: robinharwood
ms.date: 07/22/2025
---
# Resilient File System (ReFS) overview

The Resilient File System (ReFS) is a modern file system developed by Microsoft to maximize data availability, scale efficiently to large data sets across diverse workloads, and provide data integrity with resiliency to corruption. ReFS seeks to address an expanding set of storage scenarios and establish a foundation for future innovations.

This overview explains how ReFS helps protect data from corruption, supports large-scale storage environments, and integrates with key Windows Server technologies. Use this guide to understand ReFS benefits, deployment scenarios, and feature comparisons with NTFS.

## Key benefits

Learn about the key benefits that ReFS provides, including: resiliency, performance, and scalability.

### Resiliency

ReFS has features that can precisely detect corruptions and also fix those corruptions while remaining online, helping provide increased integrity and availability for your data:

- **Integrity-streams** - ReFS uses checksums for metadata and optionally for file data, giving ReFS the ability to reliably detect corruptions.
- **Storage Spaces integration** - When used with a mirror or parity space, ReFS can automatically repair detected corruptions using the alternate copy of the data provided by Storage Spaces. Repair processes are both localized to the area of corruption and performed online, requiring no volume downtime.
- **Salvaging data** - If a volume becomes corrupted and an alternate copy of the corrupted data doesn't exist, ReFS removes the corrupt data from the namespace. ReFS keeps the volume online while it handles most non-correctable corruptions, but there are rare cases that require ReFS to take the volume offline.
- **Proactive error correction** - In addition to validating data before reads and writes, ReFS introduces a data integrity scanner, known as a *scrubber*. This scrubber periodically scans the volume, identifying latent corruptions and proactively triggering a repair of corrupt data.

### Performance

In addition to providing resiliency improvements, ReFS has features for performance-sensitive and virtualized workloads. Real-time tier optimization, block cloning, and sparse valid data length (VDL) are good examples of the evolving capabilities of ReFS, which are designed to support dynamic and diverse workloads:

- **[Mirror-accelerated parity](./mirror-accelerated-parity.md)** - Mirror-accelerated parity delivers both high performance and also capacity efficient storage for your data.

  To deliver both high performance and capacity efficient storage, ReFS divides a volume into two logical storage groups, known as tiers. These tiers can have their own drive and resiliency types, allowing each tier to optimize for either performance or capacity. Some example configurations include:

  | Performance tier | Capacity tier |
  |--|--|
  | Mirrored SSD | Mirrored HDD |
  | Mirrored SSD | Parity SSD |
  | Mirrored SSD | Parity HDD |

  Once these tiers are configured, ReFS uses them to deliver fast storage for hot data and capacity-efficient storage for cold data:
  
  - All writes occur in the performance tier, and large chunks of data that remain in the performance tier are efficiently moved to the capacity tier in real time.

  - If using a hybrid deployment (mixing flash and HDD drives), [the cache in Storage Spaces Direct](/azure/azure-local/concepts/cache?context=/windows-server/context/windows-server-storage) helps accelerate reads, reducing the effect of data fragmentation characteristic of virtualized workloads. Otherwise, if using an all-flash deployment, reads also occur in the performance tier.

  - For Windows Server deployments, mirror-accelerated parity is only supported on [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md). We recommend using mirror-accelerated parity with archival and backup workloads only. For virtualized and other high performance random workloads, we recommend using three-way mirrors for better performance.

- **Accelerated VM operations** - ReFS improves the performance of virtualized workloads:
  - [Block cloning](./block-cloning.md) - Block cloning accelerates copy operations, enabling quick, low-impact VM checkpoint merge operations.
  - Sparse VDL - Sparse VDL allows ReFS to zero files rapidly, reducing the time needed to create fixed VHDs from 10s of minutes to mere seconds.

- **Variable cluster sizes** - ReFS supports both 4K and 64K cluster sizes. 4K is the recommended cluster size for most deployments, but 64K clusters are appropriate for large, sequential IO workloads.

### Scalability

ReFS is designed to support extremely large data sets - millions of terabytes - without negatively impacting performance, achieving greater scale than prior file systems.

## Supported deployments

Microsoft has developed NTFS specifically for general-purpose use with a wide range of configurations and workloads. All ReFS supported configurations must use [Windows Server Catalog](https://www.WindowsServerCatalog.com) certified hardware and meet application requirements.

For customers specially requiring the availability, resiliency, and/or scale that ReFS provides, Microsoft supports ReFS for use with the following configurations and scenarios:

> [!IMPORTANT]
> If you plan to use ReFS for Cluster Shared Volumes (CSVs), see [Use Cluster Shared Volumes in a failover cluster](../../failover-clustering/failover-cluster-csvs.md) for important information.

### Storage Spaces Direct

Deploying ReFS on [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md) is recommended for virtualized workloads or network-attached storage:

- Mirror-accelerated parity and [the cache in Storage Spaces Direct](/azure/azure-local/concepts/cache?context=/windows-server/context/windows-server-storage) deliver high performance and capacity-efficient storage.
- The introduction of block clone and sparse VDL dramatically accelerates .vhdx file operations, such as creation, merge, and expansion.
- Integrity-streams, online repair, and alternate data copies enable ReFS and Storage Spaces Direct to jointly detect and correct storage controller and storage media corruptions within both metadata and data.
- ReFS provides the functionality to scale and support large data sets.

### Storage Spaces

Deploying ReFS on Storage Spaces with shared SAS enclosures is suitable for hosting archival data and storing user documents:

- Integrity-streams, online repair, and alternate data copies enable ReFS and [Storage Spaces](../storage-spaces/overview.md) to jointly detect and correct storage controller and storage media corruptions within both metadata and data.
- Storage Spaces deployments can also utilize block-cloning and the scalability offered in ReFS.

Storage Spaces supports local non-removable direct-attached via BusTypes SATA, SAS, NVME, or attached via HBA  (also known as RAID controller in pass-through mode).

### Basic disks

Deploying ReFS on basic disks is best suited for applications that implement their own software resiliency and availability solutions:

- Applications that introduce their own resiliency and availability software solutions can use integrity-streams, block-cloning, and the ability to scale and support large data sets.

Basic disks include local non-removable direct-attached via BusTypes SATA, SAS, NVME, or RAID. Basic disks don't include Storage Spaces.

### Backup target

Deploying ReFS as a backup target is best suited for applications and hardware that implements its own resiliency and availability solutions:

- Applications that introduce their own resiliency and availability software solutions can use integrity-streams, block-cloning, and the ability to scale and support large data sets.

Contact application and storage array vendors for support details on Fiber Channel and iSCSI SANs. For SANs, if features such as thin provisioning, TRIM/UNMAP, or Offloaded Data Transfer (ODX) are required, NTFS must be used.

## Feature comparison

### Limits

| Feature | ReFS | NTFS |
|--|--|--|
| Maximum file name length | 255 Unicode characters | 255 Unicode characters |
| Maximum path name length |32K Unicode characters | 32K Unicode characters |
| Maximum file size | 35 PB (petabytes) | 256 TB |
| Maximum volume size | 35 PB | 256 TB |

### Functionality

#### Features available with ReFS and NTFS

| Feature | ReFS | NTFS |
|--|--|--|
| BitLocker encryption | ✅ | ✅ |
| Block system compression | ✅ | ✅ |
| Data Deduplication | ✅<sup>1</sup> | ✅ |
| Extended attributes | ✅ | ✅ |
| Cluster Shared Volume (CSV) support | ✅<sup>2</sup> | ✅ |
| Junctions/Soft links | ✅ | ✅ |
| Hard links | ✅ | ✅ |
| Failover cluster support | ✅ | ✅ |
| File system encryption | ✅<sup>3</sup> | ✅ |
| Access-control lists | ✅ | ✅ |
| USN journal | ✅ | ✅ |
| Changes notifications | ✅ | ✅ |
| Junction points | ✅ | ✅ |
| Mount points | ✅ | ✅ |
| Reparse points | ✅ | ✅ |
| Volume snapshots | ✅ | ✅ |
| File IDs | ✅ | ✅ |
| Oplocks | ✅ | ✅ |
| Sparse files | ✅ | ✅ |
| Named streams | ✅ | ✅ |
| Thin Provisioning | ✅<sup>4</sup> | ✅ |
| Trim/Unmap | ✅<sup>4</sup> | ✅ |
| Page file support | ✅ | ✅ |

1. Available on Windows Server, version 1709 and later, Windows Server 2019 (1809) LTSC or later.
2. ReFS-formatted CSVs don't use Direct I/O with Storage Spaces, Storage Spaces Direct (S2D), or SAN. For SAN storage, format CSVs with NTFS to use Direct I/O.
3. Available on Windows Server 2025 only.
4. Storage Spaces only.

#### Features only available with ReFS

| Functionality | ReFS | NTFS |
|--|--|--|
| Block clone | ✅ | ❌ |
| Sparse VDL | ✅ | ❌ |
| Mirror-accelerated parity | ✅ (on Storage Spaces Direct) | ❌ |
| File-level snapshots | ✅<sup>1</sup> | ❌ |

1. Available on Windows Server 2022 and later.

#### Features unavailable on ReFS

| Functionality | ReFS | NTFS |
|--|--|--|
| Transactions | ❌ | ✅ |
| Object IDs | ❌ | ✅ |
| Offloaded Data Transfer (ODX) | ❌ | ✅ |
| Short names | ❌<sup>1</sup> | ✅ |
| Disk quotas | ❌ | ✅ |
| Supported on removable media | ❌ | ✅ |
| Bootable | ❌ | ✅ |
| Shrinking | ❌ | ✅ |

1. Short names aren't officially supported, many short names are simulated through symlinks.

## Related content

- [Cluster size recommendations for ReFS and NTFS](https://techcommunity.microsoft.com/t5/Storage-at-Microsoft/Cluster-size-recommendations-for-ReFS-and-NTFS/ba-p/425960)
- [Storage Spaces Direct overview](../storage-spaces/storage-spaces-direct-overview.md)
- [ReFS block cloning](block-cloning.md)
- [ReFS integrity streams](integrity-streams.md)
- [Troubleshoot ReFS with ReFSUtil](../../administration/windows-commands/refsutil.md)
- [Use of ReFS with Cluster-Shared Volumes](../../failover-clustering/failover-cluster-csvs.md)
- [ReFS versions and compatibility matrix](https://gist.github.com/XenoPanther/15d8fad49fbd51c6bd946f2974084ef8)
