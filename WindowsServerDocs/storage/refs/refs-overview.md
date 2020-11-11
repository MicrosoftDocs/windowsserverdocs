---
title: Resilient File System (ReFS) overview
ms.author: gawatu
manager: mchad
ms.topic: article
author: gawatu
ms.date: 06/29/2019
---
# Resilient File System (ReFS) overview

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server (Semi-Annual Channel)

The Resilient File System (ReFS) is Microsoft's newest file system, designed to maximize data availability, scale efficiently to large data sets across diverse workloads, and provide data integrity by means of resiliency to corruption. It seeks to address an expanding set of storage scenarios and establish a foundation for future innovations.

## Key benefits

### Resiliency

ReFS introduces new features that can precisely detect corruptions and also fix those corruptions while remaining online, helping provide increased integrity and availability for your data:

- **Integrity-streams** - ReFS uses checksums for metadata and optionally for file data, giving ReFS the ability to reliably detect corruptions.
- **Storage Spaces integration** - When used in conjunction with a mirror or parity space, ReFS can automatically repair detected corruptions using the alternate copy of the data provided by Storage Spaces. Repair processes are both localized to the area of corruption and performed online, requiring no volume downtime.
- **Salvaging data** - If a volume becomes corrupted and an alternate copy of the corrupted data doesn't exist, ReFS removes the corrupt data from the namespace. ReFS keeps the volume online while it handles most non-correctable corruptions, but there are rare cases that require ReFS to take the volume offline.
- **Proactive error correction** - In addition to validating data before reads and writes, ReFS introduces a data integrity scanner, known as a <i>scrubber</i>. This scrubber periodically scans the volume, identifying latent corruptions and proactively triggering a repair of corrupt data.

### Performance

In addition to providing resiliency improvements, ReFS introduces new features for performance-sensitive and virtualized workloads. Real-time tier optimization, block cloning, and sparse VDL are good examples of the evolving capabilities of ReFS, which are designed to support dynamic and diverse workloads:

- **[Mirror-accelerated parity](./mirror-accelerated-parity.md)** - Mirror-accelerated parity delivers both high performance and also capacity efficient storage for your data.

    - To deliver both high performance and capacity efficient storage, ReFS divides a volume into two logical storage groups, known as tiers. These tiers can have their own drive and resiliency types, allowing each tier to optimize for either performance or capacity. Some example configurations include:

      | Performance tier | Capacity tier |
      | ---------------- | ----------------- |
      | Mirrored SSD | Mirrored HDD |
      | Mirrored SSD | Parity SSD |
      | Mirrored SSD | Parity HDD |

    - Once these tiers are configured, ReFS use them to deliver fast storage for hot data and capacity-efficient storage for cold data:
        - All writes will occur in the performance tier, and large chunks of data that remain in the performance tier will be efficiently moved to the capacity tier in real-time.
        - If using a hybrid deployment (mixing flash and HDD drives), [the cache in Storage Spaces Direct](../storage-spaces/understand-the-cache.md) helps accelerate reads, reducing the effect of data fragmentation characteristic of virtualized workloads. Otherwise, if using an all-flash deployment, reads also occur in the performance tier.

> [!NOTE]
> For Server deployments, mirror-accelerated parity is only supported on [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md). We recommend using mirror-accelerated parity with archival and backup workloads only. For virtualized and other high performance random workloads, we recommend using three-way mirrors for better performance.

- **Accelerated VM operations** - ReFS introduces new functionality specifically targeted to improve the performance of virtualized workloads:
    - [Block cloning](./block-cloning.md) - Block cloning accelerates copy operations, enabling quick, low-impact VM checkpoint merge operations.
    - Sparse VDL - Sparse VDL allows ReFS to zero files rapidly, reducing the time needed to create fixed VHDs from 10s of minutes to mere seconds.

- **Variable cluster sizes** - ReFS supports both 4K and 64K cluster sizes. 4K is the recommended cluster size for most deployments, but 64K clusters are appropriate for large, sequential IO workloads.

### Scalability

ReFS is designed to support extremely large data sets--millions of terabytes--without negatively impacting performance, achieving greater scale than prior file systems.

## Supported deployments

Microsoft has developed NTFS specifically for general-purpose use with a wide range of configurations and workloads, however for customers specially requiring the availability, resiliency, and/or scale that ReFS provides, Microsoft supports ReFS for use under the following configurations and scenarios.

> [!NOTE]
> All ReFS supported configurations must use [Windows Server Catalog](https://www.WindowsServerCatalog.com) certified hardware and meet application requirements.

### Storage Spaces Direct

Deploying ReFS on Storage Spaces Direct is recommended for virtualized workloads or network-attached storage:
- Mirror-accelerated parity and [the cache in Storage Spaces Direct](../storage-spaces/understand-the-cache.md) deliver high performance and capacity-efficient storage.
- The introduction of block clone and sparse VDL dramatically accelerates .vhdx file operations, such as creation, merge, and expansion.
- Integrity-streams, online repair, and alternate data copies enable ReFS and Storage Spaces Direct to jointly to detect and correct storage controller and storage media corruptions within both metadata and data.
- ReFS provides the functionality to scale and support large data sets.

### Storage Spaces

- Integrity-streams, online repair, and alternate data copies enable ReFS and [Storage Spaces](../storage-spaces/overview.md) to jointly to detect and correct storage controller and storage media corruptions within both metadata and data.
- Storage Spaces deployments can also utilize block-cloning and the scalability offered in ReFS.
- Deploying ReFS on Storage Spaces with shared SAS enclosures is suitable for hosting archival data and storing user documents.

> [!NOTE]
> Storage Spaces **supports** *local non-removable direct-attached* via BusTypes SATA, SAS, NVME, or attached via HBA (aka RAID controller in pass-through mode).
> Please consider **limitations** on Cluster Shared Volumes in general, or CSVs used on Storage Spaces or Storage Spaces Direct (S2D). Refer to the functionality chapter.

### Basic disks

Deploying ReFS on basic disks is best suited for applications that implement their own software resiliency and availability solutions.
- Applications that introduce their own resiliency and availability software solutions can leverage integrity-streams, block-cloning, and the ability to scale and support large data sets.

> [!IMPORTANT]
> If you plan to use ReFS for CSV (Cluster Shared Volumes), please consider the limitations to pre-format your later CSV volumes with ReFS.
> For CSV: NTFS should be used for traditional SANs. ReFS should be used on top of S2D. Refer to the functionality chapter.

> [!NOTE]
> Basic disks include local non-removable direct-attached via BusTypes SATA, SAS, NVME, or RAID. Basic disks do not include Storage Spaces.

### Backup target

Deploying ReFS as a backup target is best suited for applications and hardware that implement their own resiliency and availability solutions.
- Applications that introduce their own resiliency and availability software solutions can leverage integrity-streams, block-cloning, and the ability to scale and support large data sets.

> [!NOTE]
> Backup targets include the above supported configurations. Please contact application and storage array vendors for support details on Fiber Channel and iSCSI SANs. For SANs, if features such as thin provisioning, TRIM/UNMAP, or Offloaded Data Transfer (ODX) are required, NTFS must be used.

### Performance considerations

Pro:
ReFS is a superior filesystem to NTFS in many ways. It can greatly improve the performance in read / write operation scenarios. This is especially the case when comparing operations like creating Hyper-V virtual disks, snapshots or merging them. These performance benefits are not limited to Hyper-V though. 

Based on real world applications, this also applies for other containered data structures that are similar to the technology of VHDX, such as Storage Spaces, especially when mirrored, or S2D which uses mirroring as per concept, as well as FSLogix containers. This also applies to Citrix PVS images, to name a 3rd party application scenario.

Con:
While **supported**, scenarios exist where ReFS performance may not meet the expectations, compared to NTFS formatted volumes.
This mostly applies to Basic Disks and volumes using ReFS without Storage Spaces / S2D, where volumes contain a high number of **small files and fast changing files**.
This is by design and is caused by the need for metadata handling and scrubbing. The performance in these scenarios *can* cause slow application responsiveness or even timeouts from time sensitive applications. Example: Lotus Notes .ini file(s). Other results may be unexpected low read and write speeds for random I/Os compared to NTFS in the same software and hardware configuration.

Typical scenarios that may apply, based on the underlying hardware configuration, are typically Windows User Profiles, Temporary Folders of browsers in high-density or multi-user environments, such as Microsoft Remote Desktop Host (RDSH), Windows Virtual Desktop (WVD), or 3rd party applications like Citrix User Profile Management (UPM).

In such scenarios, please plan and test your workloads when considering usage of ReFS on Basic Disks or volumes or alternatively rely on NTFS, which, due to the non-existent scrubbing and less metadata overhead, is not prone for such possible impacts. As per design, in such scenarios, the VM or Host RAM usage can be higher compared to NTFS.

## Feature comparison

### Limits

| Feature       | ReFS                                        | NTFS |
|----------------|------------------------------------------------|-----------------------|
| Maximum file name length | 255 Unicode characters  | 255 Unicode characters               |
| Maximum path name length |32K Unicode characters | 32K Unicode characters                |
| Maximum file size | 35 PB (petabytes)  | 256 TB               |
| Maximum volume size | 35 PB                           | 256 TB                |

### Functionality

#### The following features are available on ReFS and NTFS:

| Functionality       | ReFS                                        | NTFS |
|---------------------------|------------------|-----------------------|
| BitLocker encryption | Yes | Yes |
| Data Deduplication | Yes<sup>1</sup> | Yes |
| Cluster Shared Volume (CSV) support | Yes<sup>2</sup> <sup>4</sup> | Yes |
| Soft links | Yes | Yes |
| Failover cluster support | Yes | Yes |
| Access-control lists | Yes | Yes |
| USN journal | Yes | Yes |
| Changes notifications | Yes | Yes |
| Junction points | Yes | Yes |
| Mount points | Yes | Yes |
| Reparse points | Yes | Yes |
| Volume snapshots | Yes | Yes |
| File IDs | Yes | Yes |
| Oplocks | Yes | Yes |
| Sparse files | Yes | Yes |
| Named streams | Yes | Yes |
| Thin Provisioning | Yes<sup>3</sup> | Yes |
| Trim/Unmap | Yes<sup>3</sup> | Yes |
1. Available on Windows Server, version 1709 and later, Windows Server 2019 (1809) LTSC or later.
2. Available on Windows Server 2012 R2 and later.
3. Storage Spaces only
4. CSV will not use Direct I/O in junction with Storage Space, Storage Spaces Direct (S2D) or SAN

#### The following features are only available on ReFS:

| Functionality       | ReFS                                        | NTFS |
|---------------------------|------------------|-----------------------|
| Block clone | Yes | No |
| Sparse VDL | Yes | No |
| Mirror-accelerated parity| Yes (on Storage Spaces Direct) | No |

#### The following features are unavailable on ReFS at this time:

| Functionality       | ReFS                                        | NTFS |
|---------------------------|------------------|-----------------------|
| File system compression | No | Yes |
| File system encryption | No | Yes |
| Transactions | No | Yes |
| Hard links | Yes<sup>1</sup> | Yes |
| Object IDs | No | Yes |
| Offloaded Data Transfer (ODX) | No | Yes |
| Short names (SFN 8.3) | No | Yes |
| Extended attributes | No | Yes |
| Disk quotas | No | Yes |
| Bootable | No | Yes |
| Page file support | No | Yes |
| Supported on removable media | No | Yes |
1. This feature becomes available on **newly formatted ReFS 3.5 volumes only**
Prerequisites: Windows 10 Enterprise / Windows 10 for Workstations or Windows Server vNext, starting from build 19536 or later.
Disclaimer: Any in-place upgrade to this version will upgrade ReFS attached volumes to the latest version, but will unlock the use of hardlinks. 
Please refer to additional References, ReFS Version History for an unofficial ReFS upgrade and versioning matrix.
Windows 10 pro can only read and write ReFS volumes unrestricted, but not [format](https://support.microsoft.com/en-us/help/4034825) ReFS.


## Additional References

- [Cluster size recommendations for ReFS and NTFS](https://techcommunity.microsoft.com/t5/Storage-at-Microsoft/Cluster-size-recommendations-for-ReFS-and-NTFS/ba-p/425960)
- [Storage Spaces Direct overview](../storage-spaces/storage-spaces-direct-overview.md)
- [ReFS block cloning](block-cloning.md)
- [ReFS integrity streams](integrity-streams.md)
- [ReFS Version history (unofficial)](https://gist.github.com/0xbadfca11/da0598e47dd643d933dc#file-windows-refs-versions-en-md)
- [Troubleshoot ReFS with ReFSUtil](../../administration/windows-commands/refsutil.md)
- [Use of ReFS with Cluster-Shared Volumes](../../failover-clustering/failover-cluster-csvs.md)
- [ReFS versions and compatibility matrix](https://gist.github.com/0xbadfca11/da0598e47dd643d933dc)
