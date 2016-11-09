---
title: Fault Tolerance and Storage Efficiency in Storage Spaces Direct
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dongill
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
manager: eldenc
ms.date: 11/09/2016
ms.assetid: 5e1d7ecc-e22e-467f-8142-bad6d82fc5d0
---
# Fault Tolerance and Storage Efficiency in Storage Spaces Direct
>Applies To: Windows Server 2016

This topic introduces the resiliency options available in Storage Spaces Direct and outlines the scale requirements, storage efficiency, and general advantages and tradeoffs of each. It also presents some usage instructions to get you started, and references some great papers, blogs, and additional content where you can learn more.
If you are already familiar with Storage Spaces, you may want to skip to the Summary section.

## Overview

At its heart, Storage Spaces is about providing fault tolerance, often called ‘resiliency’, for your data. Its implementation is similar to RAID, except distributed across servers and implemented in software.
As with RAID, there are a few different ways Storage Spaces can do this, which make different tradeoffs between fault tolerance, storage efficiency, and compute complexity. These broadly fall into two categories: ‘mirroring’ and ‘parity’, the latter sometimes called ‘erasure coding’.

## Mirroring

Mirroring provides fault tolerance by keeping multiple copies of all data. This most closely resembles RAID-1. How that data is striped and placed is non-trivial, but it is absolutely true to say that any data stored using mirroring is written, in its entirety, multiple times. Each copy is written to different physical hardware (different drives in different servers) which are assumed to fail independently.
In Windows Server 2016, Storage Spaces offers two flavors of mirroring – ‘two-way’ and ‘three-way’.

### Two-way mirror

Two-way mirroring writes two copies of everything. Its storage efficiency is 50% – to write 1 TB of data, you need at least 2 TB of physical storage capacity. Likewise, you need at least two [hardware ‘fault domains’](https://technet.microsoft.com/en-us/windows-server-docs/failover-clustering/fault-domains) – with Storage Spaces Direct, that means two servers.

![two-way-mirror](../media/Storage-Spaces-Fault-Tolerance/two-way-mirror.png)

   >[!NOTE]
   > Tip: We discourage using single parity. It can only safely tolerate one hardware failure at a time. If you’re rebooting one server, and a drive fails in another server, you will experience downtime. If you only have three servers, we recommend using three-way mirroring. If you have four or more, see the next section.

### Three-way mirror

Three-way mirroring writes three copies of everything. Its storage efficiency is 33.3% – to write 1 TB of data, you need at least 3 TB of physical storage capacity. Likewise, you need at least three hardware fault domains – with Storage Spaces Direct, that means three servers.

![three-way-mirror](../media/Storage-Spaces-Fault-Tolerance/two-way-mirror.png)

### When to use mirroring

Mirroring, of either flavor, provides the fastest possible reads and writes, with the least complexity, meaning the least latency and compute overhead. It is the best option for acutely performance-sensitive workloads or when vast amounts of data are being actively, randomly written, so-called "hot" data. The downside is its lesser storage efficiency.

## Parity

Parity encoding, often called ‘erasure coding’, provides fault tolerance using bitwise arithmetic, which can get [remarkably complicated](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/LRC12-cheng20webpage.pdf). The way this works is less obvious than mirroring, and there are many great online resources (for example, this third-party [Dummies Guide to Erasure Coding](http://smahesh.com/blog/2012/07/01/dummies-guide-to-erasure-coding/)) that can help you get the idea. Sufficed to say it provides better storage efficiency without compromising fault tolerance.
In Windows Server 2016, Storage Spaces offers two flavors of parity – ‘single’ parity and ‘dual’ parity, the latter employing an advanced technique called ‘local reconstruction codes’ at larger scales.

### Single parity
Single parity keeps only one bitwise parity symbol, which provides fault tolerance against only one failure at a time. It most closely resembles RAID-5. To use single parity, you need at least three hardware fault domains – with Storage Spaces Direct, that means three servers. Because three-way mirroring provides more fault tolerance at the same scale, we discourage using single parity. But, it’s there if you insist on using it, and it is fully supported.

   >[!NOTE]
   > Tip: Unless you have only two servers, we discourage using two-way mirroring. It can only safely tolerate one hardware failure at a time. If you’re rebooting one server, and a drive fails in another server, you will experience downtime. Stuff happens – keep three copies.

### Dual parity

Dual parity implements Reed-Solomon error-correcting codes to keep two bitwise parity symbols, thereby providing the same fault tolerance as three-way mirroring (i.e. up to two failures at once), but with better storage efficiency. It most closely resembles RAID-6. To use dual parity, you need at least four hardware fault domains – with Storage Spaces Direct, that means four servers. At that scale, the storage efficiency is 50% – to store 2 TB of data, you need 4 TB of physical storage capacity.

![dual-parity](../media/Storage-Spaces-Fault-Tolerance/dual-parity.png)

The storage efficiency of dual parity increases the more hardware fault domains you have, from 50% up to 80%. For example, at seven (with Storage Spaces Direct, that means seven servers) the efficiency jumps to 66.7% – to store 4 TB of data, you need just 6 TB of physical storage capacity.

![dual-parity](../media/Storage-Spaces-Fault-Tolerance/dual-parity-wide.png)

See Table 3 for the efficiency of dual party and local reconstruction codes at every scale.

### Local reconstruction codes

Storage Spaces in Windows Server 2016 introduces an advanced technique developed by Microsoft Research called ‘local reconstruction codes’, or LRC. At large scale, dual parity uses LRC to split its encoding/decoding into a few smaller groups, to reduce the overhead required to make writes or recover from failures.

With hard disk drives (HDD) the group size is four symbols; with solid-state drives (SSD), the group size is six symbols. For example, here’s what the layout looks like with hard disk drives and 12 hardware fault domains (i.e. 12 servers) – there are two groups of four data symbols. It achieves 72.7% storage efficiency.

![local-reconstruction-codes](../media/Storage-Spaces-Fault-Tolerance/local-reconstruction-codes.png)

We recommend this in-depth yet eminently readable walkthrough of [how local reconstruction codes handle various failure scenarios, and why they’re appealing](https://blogs.technet.microsoft.com/filecab/2016/09/06/volume-resiliency-and-efficiency-in-storage-spaces-direct/), by our very own [Claus Joergensen](https://twitter.com/clausjor).

### When to use parity

Although parity can achieve far better storage efficiency than mirroring, this comes at the expense of complexity and compute overhead. To recover from failures, or even simply to write any data at all, incurs encoding/decoding operations. Parity is best for infrequently written, so-called "cold" data, and data which is written in bulk, such as archival or backup workloads.

## Mixed resiliency

Beginning in Windows Server 2016, one Storage Spaces Direct volume can be part mirror and part parity. Based on read/write activity, the new Resilient File System (ReFS) intelligently moves data between the two resiliency types in real-time to keep the most active data in the mirror part. Effectively, this is [using mirroring to accelerate erasure coding](https://blogs.technet.microsoft.com/filecab/2016/09/06/volume-resiliency-and-efficiency-in-storage-spaces-direct/), giving the best of both: fast, cheap writes of hot data, and better storage efficiency for cooler data.
To mix three-way mirror and dual parity, you need at least four fault domains, meaning four servers.

### Storage efficiency
The storage efficiency of mixed resiliency is in between what you’d get from using all mirror or all parity, and depends on the proportions you choose. For example, the demo at the 37-minute mark of this presentation shows [various mixes achieving 46%, 54%, and 65% efficiency](https://www.youtube.com/watch?v=-LK2ViRGbWs&t=36m55s) with 12 servers.
Try our online [capacity calculator web app](http://aka.ms/s2dcalc) to see how different configurations and mixes affects your available capacity and storage efficiency.

### When to use mixed resiliency

Consider using mixed resiliency when most of your data is "cold" data, but you still expect some sustained write activity to some data.

## Summary

**Table 1** Shows each resiliency type, the number of failures it can safely tolerate at once, and its storage efficiency.

   >[!NOTE]
   > Tip: In the table below, "Failure tolerance" refers to the number of hardware fault domains which can experience failure(s) AT ANY ONE TIME. For example, a failure tolerance of 2 means that all data remains safe and continuously accessible even if 2 drives fail simultaneously, or if 2 nodes go down simultaneously, or if 1 drive fails and 1 node goes down. Over its lifetime, Storage Spaces can tolerate any number of failures, because it restores to full resiliency after each one.

|    Resiliency          |    Failure tolerance       |    Storage efficiency      |
|------------------------|----------------------------|----------------------------|
|    Two-way mirror      |    1                       |    50.0%                   |
|    Three-way mirror    |    2                       |    33.3%                   |
|    Single parity       |    1                       |    66.7% - 87.5%           |
|    Dual parity         |    2                       |    50.0% - 80.0%           |
|    Mixed               |    2                       |    33.3% - 80.0%           |

   >[!NOTE]
   > Tip: We recommend using three-way mirroring, dual parity, or mixing the two.

**Table 2** Shows the minimum number of hardware fault domains (with Storage Spaces Direct, that means minimum number of servers) required to use each resiliency type.

|    Fault domains    |    Two-way mirror    |    Three-way mirror    |    Single parity    |    Dual parity    |    Mixed    |
|---------------------|----------------------|------------------------|---------------------|-------------------|-------------|
|    2                |    •                 |                        |                     |                   |             |
|    3                |    •                 |    •                   |    •                |                   |             |
|    4                |    •                 |    •                   |    •                |    •              |    •        |
|    5                |    •                 |    •                   |    •                |    •              |    •        |
|    …                |    •                 |    •                   |    •                |    •              |    •        |
|    15               |    •                 |    •                   |    •                |    •              |    •        |
|    16               |    •                 |    •                   |    •                |    •              |    •        |

**Table 3** Shows the storage efficiency of dual parity and local reconstruction codes at each scale.

|    Fault domains      |    SSD + HDD                          |    All SSD                             |
|-----------------------|---------------------|-----------------|----------------------|-----------------|
|                       |    Layout           |    Efficiency   |    Layout            |    Efficiency   |
|    2                  |    –                |    –            |    –                 |    –            |
|    3                  |    –                |    –            |    –                 |    –            |
|    4                  |    RS 2+2           |    50.0%        |    RS 2+2            |    50.0%        |
|    5                  |    RS 2+2           |    50.0%        |    RS 2+2            |    50.0%        |
|    6                  |    RS 2+2           |    50.0%        |    RS 2+2            |    50.0%        |
|    7                  |    RS 4+2           |    66.7%        |    RS 4+2            |    66.7%        |
|    8                  |    RS 4+2           |    66.7%        |    RS 4+2            |    66.7%        |
|    9                  |    RS 4+2           |    66.7%        |    RS 6+2            |    75.0%        |
|    10                 |    RS 4+2           |    66.7%        |    RS 6+2            |    75.0%        |
|    11                 |    RS 4+2           |    66.7%        |    RS 6+2            |    75.0%        |
|    12                 |    LRC (8, 2, 1)    |    72.7%        |    RS 6+2            |    75.0%        |
|    13                 |    LRC (8, 2, 1)    |    72.7%        |    RS 6+2            |    75.0%        |
|    14                 |    LRC (8, 2, 1)    |    72.7%        |    RS 6+2            |    75.0%        |
|    15                 |    LRC (8, 2, 1)    |    72.7%        |    LRC (12, 2, 1)    |    80.0%        |

## Usage in PowerShell

When you create volumes ("Storage Spaces"), you can specify which resiliency type to use. In PowerShell, you can use the the New-Volume cmdlet and its ResiliencySettingName and PhysicalDiskRedundancy parameters.
Each of the following four cmdlets creates one volume. Mirror 1 uses two-way mirror; Mirror 2 uses three-way mirror; Parity 1 uses single parity; and Parity 2 uses dual parity. So long as you have the minimum number of fault domains required for each, these cmdlets individually are the most prescriptive and surefire way to create exactly what you want. Remember to specify whatever FriendlyName and Size you want.

```
New-Volume -FriendlyName "Mirror 1" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 1TB -ResiliencySettingName Mirror -PhysicalDiskRedundancy 1
New-Volume -FriendlyName "Mirror 2" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 1TB -ResiliencySettingName Mirror -PhysicalDiskRedundancy 2
New-Volume -FriendlyName "Parity 1" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 1TB -ResiliencySettingName Parity -PhysicalDiskRedundancy 1
New-Volume -FriendlyName "Parity 2” -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 1TB -ResiliencySettingName Parity -PhysicalDiskRedundancy 2
```

To make things easier, if your deployment uses Storage Spaces Direct with only two or three servers, you can omit the ResiliencySettingName and PhysicalDiskRedundancy parameters altogether, and Storage Spaces will automatically use the most fault tolerant mirroring option. Easy!

```
New-Volume -FriendlyName "Bill Gates" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -Size 1TB
```

If your deployment uses Storage Spaces Direct with four or more servers, ‘tier templates’ are automatically created, called Performance and Capacity. They encapsulate definitions for three-way mirroring (Performance) and the best dual parity layout at your scale (Capacity). If you’re curious, you can see them by running the following cmdlets.

```
Get-StorageTier | Select FriendlyName, ResiliencySettingName, PhysicalDiskRedundancy
```

![storage-tiers-screenshot](../media/Storage-Spaces-Fault-Tolerance/storage-tiers-screenshot.png)

To create volumes, and especially mixed resiliency volumes, reference these tier templates using the StorageTierFriendlyNames and StorageTierSizes parameters. The following cmdlet creates a 1 TB mixed volume, split 30% three-way mirror and 70% dual parity.

```
New-Volume -FriendlyName "Mixed" -FileSystem CSVFS_ReFS -StoragePoolFriendlyName S2D* -StorageTierFriendlyNames Performance, Capacity -StorageTierSizes 300GB, 700GB
```

We recommend this blog about [how volumes are represented in the Storage Management API](https://blogs.technet.microsoft.com/filecab/2016/08/29/deep-dive-volumes-in-spaces-direct/), by our very own Cosmos Darwin, which includes guidance and scripting samples on how best to inspect them in PowerShell.

## Related Topics  
-   [Storage Spaces Direct in Windows Server 2016](storage-spaces-direct-overview.md)
-   [Fault Domain Awareness in Windows Server 2016](../../failover-clustering/fault-domains.md)

## See Also

Every link below is inline somewhere in the body of this topic.

- [Erasure Coding in Windows Azure by Microsoft Research ](https://www.microsoft.com/en-us/research/publication/erasure-coding-in-windows-azure-storage/)
- [Local Reconstruction Codes and Accelerating Parity Volumes](https://blogs.technet.microsoft.com/filecab/2016/09/06/volume-resiliency-and-efficiency-in-storage-spaces-direct/)
- [Volumes in the Storage Management API](https://blogs.technet.microsoft.com/filecab/2016/08/29/deep-dive-volumes-in-spaces-direct/)
- [Storage Efficiency Demo at Microsoft Ignite 2016](https://www.youtube.com/watch?v=-LK2ViRGbWs&t=36m55s)
- [Capacity Calculator for Storage Spaces Direct](http://aka.ms/s2dcalc)
