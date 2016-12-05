---
title: refs overview
ms.prod: windows-server-threshold
ms.author: gawatu
ms.manager: dmoss
ms.technology: refs
ms.topic: article
author: gawatu
ms.date: 11/23/2016
ms.assetid: 8bd0d09a-0421-40a4-b752-40ecb5350ffd
---
# Resilient File System
>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Resilient File System (ReFS) is Microsoft's newest file system, designed to maximize data availibility, scale efficiently to large data sets across diverse workloads, and provide data integrity by means of resiliency to corruption. It provides a similar API surface to previous Microsoft file systems, but it seeks to address an expanding set of storage scenarios and establish a foundation for future innovations. 

## Key benefits

### **Resiliency**
ReFS prioritizes the integrity and availability of data, minimizing volume downtime and improving the ability to detect and fix corruptions:

- **Inbuilt chkdsk** - ReFS includes inbuilt chkdsk, where repair processes are both localized to the area of corruption and performed online, requiring no volume downtime. 
- **Storage spaces integration** - When used in conjunction with a mirror or parity space, ReFS can automatically repair detected corruptions using the alternate copy of the data provided by Storage Spaces or Storage Spaces Direct. 
- **Salvaging data** - If a volume becomes corrupted and an alternate copy of the corrupted data doesn't exist, ReFS removes the corrupt data from the namespace on a live volume and ensures that good data is not adversely affected by nonrepairable corrupt data. 
- **Integrity-streams** - ReFS introduces checksums for metadata and optionally for file data, giving ReFS the ability to reliably detect corruptions. 
- **Proactive error correction** - In addition to validating data before reads and writes, ReFS introduces a data integrity scanner, known as a <i>scrubber</i>. This scrubber periodically scans the volume, identifying latent corruptions and proactively triggering a repair of corrupt data. 

### **Performance**
In addition to providing resiliency improvements, ReFS optimizes for performance-sensitive and virtualized workloads. Real-time tiering, block cloning, and sparse VDL are good examples of the evolving capabilities of ReFS, which are designed to support dynamic and diverse workloads:

- **Real-time tiering** - Real-time tiering enables ReFS to deliver both highly performant and also capacity efficient storage for your data. By rotating data between performance and capacity tiers in real-time, incoming read and writes can be serviced in the performance tier while the less-frequently accessed data can be stored in the capacity tier. 

- **Block cloning** - Block cloning performs copies of file data through inexpensive metadata operations, accelerating common .vhdx operations.  

- **Sparse VDL** - When setting the valid data length of a file, ReFS avoids expensive zeroing operations and performs these operations instantly in metadata. 

### **Scalability**
ReFS is designed to support extremely large data sets--petabytes and larger--without negatively impacting performance.

## Supported deployments

**ReFS on Storage Spaces Direct** <br>
Deploying ReFS on Storage Spaces Direct is the recommended setup for virtualization workloads: 
- The introduction of block clone and sparse VDL dramatically accelerates .vhdx file operations, such as creation, merge, and expansion.
- The use of real-time tiering rotates hot and cold data between performance and capacity tiers, delivering high performance without compromising storage efficiency. 
- The presence of a read cache in Storage Spaces Direct deployments boosts IO performance, helping mitigate the effect of data fragmentation that is often characteristic of virtualization workloads. 

**ReFS on Storage Spaces** <br>
Deploying ReFS on traditional Storage Spaces is suitable for hosting archival information and storing user documents:
- Built-in checksums, inline chkdsk, and alternate data copies enable ReFS and Storage Spaces to jointly to detect and correct corruptions within both metadata and data. 
- ReFS provides the functionality to efficiently scale and support massive data sets. 
- The lack of both a read cache and real-time tiering make ReFS on Storage Spaces unoptimal for performance-sensitive workloads. 

**ReFS on plain disks** <br>
Deploying ReFS on plain disks is suitable for applications with specific functionality requirements:
- Applications can leverage the scalibility offered in ReFS. 
- Applications can define their own resiliency and performance requirements they need at the application layer. 


## Feature comparison

### Limits

| Feature       | ReFS                                        | NTFS |
|----------------|------------------------------------------------|-----------------------|
| Maximum file name length | 32K Unicode characters  | 32K Unicode characters               |
| Maximum path name length |32K Unicode characters | 32K Unicode characters                |
| Maximum file size | 2<sup>64</sup> - 1 bytes  | 2<sup>64</sup> - 1 bytes                |
| Maximum volume size | 4.7 ZB (zettabytes)                           | 256 TB                |
| Maximum number of files in a directory | 2<sup>64</sup>|  No actual limit |
| Maximum number of directories in a volume | 2<sup>64</sup> | No actual limit |


### Functionality

| Functionality       | ReFS                                        | NTFS |
|---------------------------|------------------|-----------------------|
| Named streams | Yes | Yes |
| Object IDs | No | Yes |
| File system compression | No | Yes |
| File system encryption | No | Yes |
| Transactions | No | Yes |
| Hard links | No | Yes |
| Soft links | No | Yes |
| Short names | No | Yes |
| Extended attributes | No | Yes |
| Quota | No | Yes |
| Boot to file system | No | Yes |
| Supported on removable media | No | Yes |
| Deduplication | No | Yes |
| Failover cluster support | Yes | Yes |
| Bitlocker encryption | Yes | Yes |
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
| File level snapshots | Yes | No |
| Sparse VDL | Yes | No |
| Write Auto Tiering | Yes | No |

## See Also  

