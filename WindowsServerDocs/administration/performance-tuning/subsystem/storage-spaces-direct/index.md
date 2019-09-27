---
title: Performance Tuning for Storage Spaces Direct
description: Storage Spaces Direct automatically tunes its performance based on the cache configuration of the hardware you use, as described in this topic.
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.assetid: 15a519fa-37cc-4d84-a9fe-097d33bb71ea
author: phstee
ms.author: Vshankar; DanLo; clausjor; StevenEk
ms.date: 4/14/2017
---
# Performance tuning for Storage Spaces Direct

Storage Spaces Direct, a Windows Server-based software-defined storage solution, automatically tunes its performance, obviating the need to manually specify column counts, the cache configuration of the hardware you use, and other factors that must be set manually with shared SAS storage solutions. For background info, see [Storage Spaces Direct in Windows Server 2016](../../../../storage/storage-spaces/storage-spaces-direct-overview.md).

The Storage Spaces Direct Software Storage Bus Cache is automatically configured based on the types of storage present in the system. Three types recognized: **HDD**, **SSD** and **NVMe**. The cache claims the fastest storage for read and/or write caching, as appropriate, and uses the slower storage for persistent storage of data.

The following table summarizes the defaults:

| Storage Types | Cache Configuration |
| --- | --- |
| Any Single Type | If there is only one type of storage present, the Software Storage Bus Cache isn't configured. |
| SSD+HDD or NVMe+HDD | The fastest storage is configured as the cache layer and caches both reads and writes. |
| SSD+SSD or NVMe+NVMe | These fast+fast options are targeted to combinations of higher and lower endurance storage, for instance 10 drive writes per day (DWPD) NAND flash SSD for cache and 1.5 DWPD NAND flash SSD for capacity. They're enabled by giving Storage Spaces Direct a set of Model strings to identify cache devices with. For more information see the [Enable-StorageSpacesDirect](https://technet.microsoft.com/library/mt589697.aspx) cmdlet reference (`CacheDeviceModel`). <br><br>In a fast+fast system, only writes are cached. Reads aren't cached. |

Note that caching over an SSD or NVMe device defaults to write caching, only. The intention is that since the capacity device is fast, there is limited value in moving read content to the cache devices. There are cases where this may not hold, though care should be taken since enabling read cache may unnecessarily consume cache device endurance for no increase in performance. Examples may include:

* **NVme+SSD** Enabling read cache will allow read IO to take advantage of the PCIe connectivity and/or higher IOPS performance of the NVMe devices as compared to the aggregated SSD. <br>This _may_ be true for bandwidth-oriented scenarios due to the relative bandwidth capabilities of the NVMe devices vs. the HBA connecting to the SSD. It _may not_ be true for IOPS-oriented scenarios where CPU costs of IOPS may limit systems before the increased performance can be realized.
* **NVMe+NVMe** Similarly, if the read capability of the cache NVMe are greater than the combined capacity NVMe, there may be value in enabling read cache. <br>Good cases for read cache in these configurations are expected to be unusual.

To view and alter the cache configuration, use the [Get-ClusterStorageSpacesDirect](https://technet.microsoft.com/library/mt634616.aspx) and [Set-ClusterStorageSpacesDirect](https://technet.microsoft.com/library/mt763265.aspx) cmdlets. The `CacheModeHDD` and `CacheModeSSD` properties define how the cache operates on capacity media of the indicated type.

## See also

- [Understanding Storage Spaces Direct](../../../../storage/storage-spaces/understand-storage-spaces-direct.md)
- [Planning Storage Spaces Direct](../../../../storage/storage-spaces/plan-storage-spaces-direct.md)
- [Performance tuning for file servers](../../role/file-server/index.md)
- [Software-Defined Storage Design Considerations Guide](https://technet.microsoft.com/library/mt243829.aspx) (for Windows Server 2012 R2 and shared SAS storage)
