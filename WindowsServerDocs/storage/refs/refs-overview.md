---
title: Resilient File System (ReFS) overview
ms.prod: windows-server-threshold
ms.author: gawatu
ms.manager: dmoss
ms.technology: storage-file-systems
ms.topic: article
author: gawatu
ms.date: 1/3/2016
ms.assetid:
---

# Resilient File System (ReFS) overview
>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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

>[!NOTE]
>For Server deployments, mirror-accelerated parity is only supported on [Storage Spaces Direct](../storage-spaces/storage-spaces-direct-overview.md).

To deliver both high performance and capacity efficient storage, ReFS divides a volume into two logical storage groups, known as tiers. These tiers can have their own drive and resiliency types, allowing each tier to optimize for either performance or capacity. Some example configurations include: 
    | Performance tier | Capacity tier |
    |----------------|-----------------|
     Mirrored SSD | Mirrored HDD |
     Mirrored SSD | Parity SSD |
     Mirrored SSD | Parity HDD |   
            
    - Once these tiers are configured, ReFS use them to deliver fast storage for hot data and capacity-efficient storage for cold data:
        - All writes will occur in the performance tier, and large chunks of data that remain in the performance tier will be efficiently moved to the capacity tier in real-time.
        - If using a [hybrid deployment](../storage-spaces/choosing-drives.md) (mixing flash and HDD drives), [the cache in Storage Spaces Direct](../storage-spaces/understand-the-cache.md) will help accelerate reads, reducing the effect of data fragmentation characteristic of virtualized workloads. Otherwise, if using an all-flash deployment, reads will also occur in the performance tier. 

- **Accelerated VM operations** - ReFS introduces new functionality specifically targeted to improve the performance of virtualized workloads:
    - [Block cloning](./block-cloning.md) - Block cloning accelerates copy operations, enabling quick, low-impact VM checkpoint merge operations. 
    - Sparse VDL - Sparse VDL allows ReFS to zero files rapidly, reducing the time needed to create fixed VHDs from 10s of minutes to mere seconds.


- **Variable cluster sizes** - ReFS supports both 4K and 64K cluster sizes. 4K is the recommended cluster size for most deployments, but 64K clusters are appropriate for large, sequential IO workloads.
    
    
### **Scalability**
ReFS is designed to support extremely large data sets--millions of terabytes--without negatively impacting performance, achieving greater scale than prior file systems. 

## Supported deployments

### Storage Spaces Direct ###

Deploying ReFS on Storage Spaces Direct is recommended for virtualized workloads or network-attached storage: 
- Mirror-accelerated parity and [the cache in Storage Spaces Direct](../storage-spaces/understand-the-cache.md) deliver high performance and capacity-efficient storage. 
- The introduction of block clone and sparse VDL dramatically accelerates .vhdx file operations, such as creation, merge, and expansion.
- Built-in checksums, online repair, and alternate data copies enable ReFS and Storage Spaces Direct to jointly to detect and correct corruptions within both metadata and data. 
- ReFS provides the functionality to efficiently scale and support massive data sets. 

### Storage Spaces with SAS drive enclosures ###
Deploying ReFS on Storage Spaces with shared SAS enclosures is suitable for hosting archival data and storing user documents:
- Built-in checksums, online repair, and alternate data copies enable ReFS and Classic Storage Spaces to jointly to detect and correct corruptions within both metadata and data. 
- ReFS provides the functionality to efficiently scale and support massive data sets. 

### Basic disks ###
Deploying ReFS on basic disks is best suited for applications that provide their own resiliency and availibility solutions. 
- Applications that introduce their own concepts of resiliency and availability, which are suited for their own workloads, can leverage the scalability offered in ReFS. 


## Feature comparison

### Limits

| Feature       | ReFS                                        | NTFS |
|----------------|------------------------------------------------|-----------------------|
| Maximum file name length | 255 Unicode characters  | 255 Unicode characters               |
| Maximum path name length |32K Unicode characters | 32K Unicode characters                |
| Maximum file size | 18 EB (exabytes)  | 18 EB (exabytes)                |
| Maximum volume size | 4.7 ZB (zettabytes)                           | 256 TB                |


### Functionality

#### The following features are available on ReFS and NTFS:

| Functionality       | ReFS                                        | NTFS |
|---------------------------|------------------|-----------------------|
| BitLocker encryption | Yes | Yes |
| Cluster Shared Volume (CSV) support | Yes | Yes |
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
| Data Deduplication | No | Yes |
| Transactions | No | Yes |
| Hard links | No | Yes |
| Object IDs | No | Yes |
| Short names | No | Yes |
| Extended attributes | No | Yes |
| Disk quotas | No | Yes |
| Bootable | No | Yes |
| Supported on removable media | No | Yes |
| NTFS storage tiers | No | Yes |


## See also

-   [ReFS block cloning](block-cloning.md)
-   [ReFS integrity streams](integrity-streams.md)
-   [Storage Spaces Direct overview](../storage-spaces/storage-spaces-direct-overview.md)
