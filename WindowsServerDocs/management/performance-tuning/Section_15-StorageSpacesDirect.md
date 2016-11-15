---
title: Performance Tuning for Storage Spaces Direct
description: Performance Tuning for Storage Spaces Direct
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 15a519fa-37cc-4d84-a9fe-097d33bb71ea
author: phstee
ms.author: Vshankar; DanLo; clausjor;StevenEk
ms.date: 10/31/2016
---

# Performance Tuning for Storage Spaces Direct

New to Windows Server 2016, Storage Spaces Direct (S2D) offers a software-defined
storage solution for creating resilient, highly-available storage clusters without requiring the separate storage interconnect as in shared-storage Storage Spaces.
A Storage Spaces Direct cluster can be either a classic storage-only cluster or hyper-converged, offering combined storage and compute services.

For an introduction to Storage Spaces Direct, please see
[Storage Spaces Direct in Windows Server 2016](https://technet.microsoft.com/en-us/windows-server-docs/storage/storage-spaces/storage-spaces-direct-overview).

Storage Spaces Direct has been engineered to largely eliminate the tuning needed
for conventional storage subsystems, including Storage Spaces as used in single-system or shared-storage configurations.

Unlike Storage Spaces in its other personalities, the Storage Spaces Direct Software Storage Bus Cache will automatically configure based on the types of storage present in the system. Three types recognized: **HDD**, **SSD** and **NVMe**. Based on the combination the cache will claim the fastest storage as cache and configure itself for read and/or write caching, as appropriate.

The following table summarizes the defaults:

<table>
  <colgroup>
    <col width="25%" />
    <col width="75%" />
  </colgroup>
<thead>
  <tr class="header">
    <th>Storage Types</th>
    <th>Cache Configuration</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>Any Single Type</td>
    <td>If there is only one type of storage present, the Software Storage Bus is not configured.</td>
  </tr>
  <tr>
    <td>SSD+HDD or NVMe+HDD</td>
    <td>The fast storage is configured as the cache layer and will cache both reads and writes.</td>
  </tr>
  <tr>
    <td>SSD+SSD or NVMe+NVMe</td>
    <td><p>These fast+fast options are targeted to combinations of higher and lower endurance storage, for instance 10DWPD NAND flash SSD for cache and 1.5DWPD NAND flash SSD for capacity. They are enabled by giving Storage Spaces Direct a set of Model strings to identify cache devices with. For more information see the [Enable-StorageSpacesDirect](https://technet.microsoft.com/en-us/library/mt589697.aspx) cmdlet reference (`CacheDeviceModel`).</p>
    <p>In a fast+fast system, only writes are cached. Reads are not cached.</p>
  </tr>
  <tr>
    <td>NVME+SSD+HDD</td>
    <td><p>The NVMe storage is configured as the cache layer. It will cache both reads and writes for the HDD, but will only cache writes for the SSD.</p>
    <p>These "three-tier" configurations are most suitable for Multi-Resilient Volumes, which blend mirror and parity. Mirror is allocated from SSD and parity from HDD. Caution should be used in sizing since SSD capacity is fixed.
  </tr>
</tbody>
</table>

Note that caching over an SSD or NVMe device defaults to write caching, only. The intention is that since the capacity device is fast, there is limited value in moving read content to the cache devices. There are cases where this may not hold, though care should be taken since enabling read cache may unnecessarily consume cache device endurance for no increase in performance. Examples may include:

* **NVme+SSD** <p>Enabling read cache will allow read IO to take advantage of the PCIe connectivity and/or higher IOPS performance of the NVMe devices as compared to the aggregated SSD.</p><p>This _may_ be true for bandwidth-oriented scenarios due to the relative bandwidth capabilities of the NVMe devices vs. the HBA connecting to the SSD. It _may not_ be true for IOPS-oriented scenarios where CPU costs of IOPS may limit systems before the increased performance can be realized.</p>
* **NVMe+NVMe** <p>Similarly, if the read capability of the cache NVMe are greater than the combined capacity NVMe, there may be value in enabling read cache.</p><p>Good cases for read cache in these configurations are expected to be unusual.

To view and alter the cache configuration, use the [Get-ClusterStorageSpacesDirect](https://technet.microsoft.com/en-us/library/mt634616.aspx) and [Set-ClusterStorageSpacesDirect](https://technet.microsoft.com/en-us/library/mt763265.aspx) cmdlets. The `CacheModeHDD` and `CacheModeSSD` properties define how the cache operates on capacity media of the indicated type.
