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

The Resilient File System (ReFS) is Microsoft's newest file system, designed to maximize data availibility, scale efficiently to large data sets across diverse workloads, and provide data integrity by means of resiliency to corruption. It seeks to address an expanding set of storage scenarios and establish a foundation for future innovations. 

## Key benefits

### **Resiliency**
ReFS introduces new features that can precisely detect corruptions and also fix those corruptions while remaining online, helping provide increased integrity and availibility for your data: 

- **Online repair** - Repair processes are both localized to the area of corruption and performed online, requiring no volume downtime. 
- **Storage spaces integration** - When used in conjunction with a mirror or parity space, ReFS can automatically repair detected corruptions using the alternate copy of the data provided by Storage Spaces. 
- **Salvaging data** - If a volume becomes corrupted and an alternate copy of the corrupted data doesn't exist, ReFS removes the corrupt data from the namespace on a live volume. In other words, ReFS keeps the volume online while it handles non-correctable corruptions.
- **Integrity-streams** - ReFS introduces checksums for metadata and optionally for file data, giving ReFS the ability to reliably detect corruptions. 
- **Proactive error correction** - In addition to validating data before reads and writes, ReFS introduces a data integrity scanner, known as a <i>scrubber</i>. This scrubber periodically scans the volume, identifying latent corruptions and proactively triggering a repair of corrupt data. 

### **Performance**
In addition to providing resiliency improvements, ReFS introduces new features for performance-sensitive and virtualized workloads. Real-time tiering, block cloning, and sparse VDL are good examples of the evolving capabilities of ReFS, which are designed to support dynamic and diverse workloads:

- **Real-time tiering** - Real-time tiering enables ReFS to deliver both high performance and also capacity efficient storage for your data.
    - Multiresiliency tiers - ReFS allows the performance tier and the capacity tier to have different resiliency schemes: for example, the performance tier and the capacity tier can use mirror and parity resiliency schemes respectively, helping to deliver fast and capacity-efficient storage. 
    - All writes will occur on the performance tier, and large chunks of cold data in the performance tier will be efficiently moved to the capacity tier.  
    - Reads of hot data will occur on [the cache created in Storage Spaces Direct](https://technet.microsoft.com/en-us/windows-server-docs/storage/storage-spaces/understand-the-cache), helping accelerate fragmented reads that are often characteristic of virtualized workloads. 

- **Block cloning** - Block cloning is central to accelerating VM operations, such as quick, low-impact VM checkpoint merge operations.  

- **Sparse VDL** - Sparse VDL also improves the efficiency of VM operations, reducing the time needed to create fixed VHDs from 10s of minutes to mere seconds. 

### **Scalability**
ReFS is designed to support extremely large data sets--petabytes and larger--without negatively impacting performance, achieving greater scale than prior file systems. 

## Supported deployments

**ReFS on Storage Spaces Direct** <br>
Deploying ReFS on Storage Spaces Direct is the recommended setup for virtualized workloads: 
- Real-time tiering and the Storage Spaces Direct read cache deliver high performance and capacity-efficient storage. 
- The introduction of block clone and sparse VDL dramatically accelerates .vhdx file operations, such as creation, merge, and expansion.
- Built-in checksums, online repair, and alternate data copies enable ReFS and Storage Spaces Direct to jointly to detect and correct corruptions within both metadata and data. 
- ReFS provides the functionality to efficiently scale and support massive data sets. 

**ReFS on Classic Storage Spaces** <br>
Deploying ReFS on Classic Storage Spaces is suitable for hosting archival data and storing user documents:
- Built-in checksums, online repair, and alternate data copies enable ReFS and Classic Storage Spaces to jointly to detect and correct corruptions within both metadata and data. 
- ReFS provides the functionality to efficiently scale and support massive data sets. 
- Data will be stored on a non-tiered volume. 


**ReFS on plain disks** <br>
Deploying ReFS on plain disks is suitable for applications that provide their own resiliency and availibility solutions. 
- For example, Exchange and SQL both introduce their own concepts of resiliency and availability suited for their specific workloads, and they can leverage the scalability offered in ReFS. 

## Feature comparison

### Limits

| Feature       | ReFS                                        | NTFS |
|----------------|------------------------------------------------|-----------------------|
| Maximum file name length | 32K Unicode characters  | 32K Unicode characters               |
| Maximum path name length |32K Unicode characters | 32K Unicode characters                |
| Maximum file size | 2<sup>64</sup> - 1 bytes  | 2<sup>64</sup> - 1 bytes                |
| Maximum volume size | 4.7 ZB (zettabytes)                           | 256 TB                |


### Functionality

| Functionality       | ReFS                                        | NTFS |
|---------------------------|------------------|-----------------------|
| Object IDs | No | Yes |
| File system compression | No | Yes |
| File system encryption | No | Yes |
| Bitlocker encryption | Yes | Yes |
| Transactions | No | Yes |
| Hard links | No | Yes |
| Soft links | Yes | Yes |
| Short names | No | Yes |
| Extended attributes | No | Yes |
| Quota | No | Yes |
| Bootable | No | Yes |
| Supported on removable media | No | Yes |
| NTFS tiering | No | Yes |
| Deduplication | No | Yes |
| Failover cluster support | Yes | Yes |
| CSV support | Yes | Yes |
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
| Block clone | Yes | No |
| Sparse VDL | Yes | No |
| ReFS real-time tiering | Yes | No |

 

