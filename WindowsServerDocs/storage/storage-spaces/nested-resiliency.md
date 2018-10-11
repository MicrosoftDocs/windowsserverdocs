---
title: Nested resiliency for Storage Spaces Direct
ms.prod: windows-server-threshold
ms.author: jgerend
ms.manager: dansimp
ms.technology: storagespaces
ms.topic: article
author: cosmosdarwin
ms.date: 10/10/2018
---

# Nested resiliency for Storage Spaces Direct

> Applies to: Windows Server 2019

Nested resiliency is a new feature of [Storage Spaces Direct](storage-spaces-direct-overview.md) that enables a two-server cluster to withstand multiple hardware failures at the same time without loss of storage availability, so users, apps, and virtual machines continue to run like nothing happened. This topic explains how it works, provides step-by-step instructions to get started, and answers the most frequently asked questions.

## Prerequisites

### ![Green checkmark icon.](media/supported.png) Consider nested resiliency if:

- Your cluster runs Windows Server 2019; and
- Your cluster has exactly 2 server nodes

### ![Red X icon.](media/unsupported.png) You can't use nested resiliency if:

- Your cluster runs Windows Server 2016; or
- Your cluster has 3 or more server nodes

## Why nested resiliency

Volumes that use nested resiliency can **stay online and accessible even if multiple hardware failures happen at the same time**, unlike classic [two-way mirror](storage-spaces-fault-tolerance.md) resiliency. For example, if two drives fail at the same time, or if a server goes down and a drive fails, volumes that use nested resiliency stay online and accessible.

![Storage availability](media/storage-availability.png)

For hyper-converged infrastructure, this means apps and virtual machines continue to run because their storage is available. For file server workloads, this means users continue to access their files without disruption. This significantly increases the storage availability you can achieve with a two-server cluster compared to Windows Server 2016.

The downside is that nested resiliency has **lower capacity efficiency than classic two-way mirror**, meaning you get slightly less usable space. For details, see the [Capacity efficiency](#capacity-efficiency) section below.

## How it works

### Inspiration: RAID 5+1

To understand nested resiliency in Storage Spaces Direct, it's helpful to understand RAID 5+1, an established and widely accepted way to achieve distributed storage resiliency. Within each server, local resiliency is provided by RAID-5, or *single parity*, to protect against the loss of any single drive. Then, further resiliency is provided by RAID-1, or *two-way mirror*, between the two servers to protect against the loss of either server.

![RAID 5+1](media/raid-51.png)

### Two new resiliency options

Storage Spaces Direct in Windows Server 2019 introduces two new resiliency options inspired by RAID 5+1 but implemented in software, without the need for specialized hardware like RAID controllers.

- **Nested two-way mirror.** Within each server, local resiliency is provided by two-way mirror, and then further resiliency is provided two-way mirror between the two servers. It's essentially four-way mirror, with two copies in each server. Nested two-way mirror provides uncompromising performance: writes go to all copies, without any parity encoding, and reads are always local, without any parity decoding.

  ![Nested two-way mirror](media/nested-two-way-mirror.png)

- **Nested mirror-accelerated parity.** Combine nested two-way mirror, from above, with nested parity. Within each server, local resiliency for most data is provided by single [bitwise parity arithmetic](storage-spaces-fault-tolerance.md#parity), except new recent writes which use two-way mirror. Then, further resiliency for all data is provided by two-way mirror between the servers. Writes go to mirror and then get parity encoded later. Reads are always local and may come from mirror or parity. See the [mirror-accelerated parity]() topic for more detail.

  ![Nested mirror-accelerated parity](media/nested-mirror-accelerated-parity.png)

### Capacity efficiency

Capacity efficiency is the ratio of [usable space to footprint](plan-volumes.md#choosing-the-size-of-volumes) and depends on the resiliency option you chose.

- **Nested two-way mirror** writes four copies of everything, meaning to store 1 TB of data, you need 4 TB of physical storage capacity. Although appealing for its simplicity, nested two-way mirror's capacity efficiency of 25.0% is the lowest of any resiliency option in Storage Spaces Direct.

- **Nested mirror-accelerated parity** achieves higher capacity efficiency around 35%-40% depending on two factors: the number of capacity drives in each server, and the mix of mirror and parity you specify for the volume. This table provides a lookup for common configurations:

  | Capacity drives per server | 10% mirror | 20% mirror | 30% mirror |
  |----------------------------|------------|------------|------------|
  | 4                          | 35.7%      | 34.1%      | 32.6%      |
  | 5                          | 37.7%      | 35.7%      | 33.9%      |
  | 6                          | 39.1%      | 36.8%      | 34.7%      |
  | 7+                         | 40.0%      | 37.5%      | 35.3%      |

  > [!NOTE]
  > **If you're curious, here's an example of the full math.** Suppose we have six capacity drives in each of two servers, and we want to create one 100 GB volume comprised of 10 GB of mirror and 90 GB of parity. Server-local two-way mirror is 50.0% efficient, meaning the 10 GB of mirror data takes 20 GB to store on each server. Mirrored to both servers, its total footprint is 40 GB. Server-local single parity, in this case, is 5/6 = 83.3% efficient, meaning the 90 GB of parity data takes 108 GB to store on each server. Mirrored to both servers, its total footprint is 216 GB. The total footprint is thus [(10 GB / 50.0%) + (90 GB / 83.3%)] × 2 = 256 GB, for 39.1% capacity efficiency.

Notice that the capacity efficiency of classic two-way mirror (about 50%) and nested mirror-accelerated parity (up to 40%) are not *that* different. Depending on your requirements, the slightly lower capacity efficiency may be well worth the significant increase in storage availability.

![Tradeoff](media/tradeoff.png)

## Usage in PowerShell

Create volumes with nested resiliency using familiar storage cmdlets in PowerShell.

### Step 1: Create storage tier templates

First, create new storage tier templates using the `New-StorageTier` cmdlet. You only need to do this once, and then every new volume you create can reference these template. Specify the `-MediaType` of your capacity drives and, optionally, the `-FriendlyName` of your choice. Do not modify the other parameters.

If your capacity drives are hard disk drives (HDD), launch PowerShell as Administrator and run:

```PowerShell 
# For mirror
New-StorageTier -StoragePoolFriendlyName S2D* -FriendlyName NestedMirror -ResiliencySettingName Mirror -MediaType HDD -NumberOfDataCopies 4

# For parity
New-StorageTier -StoragePoolFriendlyName S2D* -FriendlyName NestedParity -ResiliencySettingName Parity -MediaType HDD -NumberOfDataCopies 2 -PhysicalDiskRedundancy 1 -NumberOfGroups 1 -FaultDomainAwareness StorageScaleUnit -ColumnIsolation PhysicalDisk 
``` 

If your capacity drives are solid-state drives (SSD), set the `-MediaType` to `SSD` instead. Do not modify the other parameters.

> [!TIP]
> Verify the tiers created successfully with `Get-StorageTier`.

### Step 2: Create volumes

Then, create new volumes using the `New-Volume` cmdlet.

#### Nested two-way mirror

To use nested two-way mirror, reference the `NestedMirror` tier template and specify the size. For example:

```PowerShell
New-Volume -FriendlyName Volume01 -StorageTierFriendlyNames NestedMirror -StorageTierSizes 500GB
```

#### Nested mirror-accelerated parity

To use nested mirror-accelerated parity, reference both the `NestedMirror` and `NestedParity` tier templates and specify two sizes, one for each part of the volume (mirror first, parity second). For example, to create one 500 GB volume that's 20% nested two-way mirror and 80% nested parity, run:

```PowerShell
New-Volume -FriendlyName Volume02 -StorageTierFriendlyNames NestedMirror, NestedParity -StorageTierSizes 100GB, 400GB
```

### Step 3: Continue in Windows Admin Center

Volumes that use nested resiliency appear in Windows Admin Center with clear labeling, as shown in the screenshot below. Once they're created, you can manage and monitor them using Windows Admin Center just like any other volume in Storage Spaces Direct.

![](media\windows-admin-center.png)

### Optional: Cache drives

With its default settings, nested resiliency protects against the loss of multiple capacity drives at the same time, or one server and one capacity drive at the same time. Because [cache drives](understand-the-cache.md) often provide read *and write* caching for *multiple* capacity drives, the only way to extend this protection and guarantee storage availability after losing one server and one cache drive is to not cache writes at all, but that impacts performance.

To address this scenario, Storage Spaces Direct offers the option to automatically disable write caching when one server in a two-server cluster is down, and then re-enable write caching once the server is back up. To allow routine restarts without performance impact, write caching isn't disabled until the server has been down for 30 minutes.

To set this behavior (optional), launch PowerShell as Administrator and run:

```PowerShell
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name "System.Storage.NestedResiliency.DisableWriteCacheOnNodeDown.Enabled" -Value "True"
```

Once set to `True`, the cache behavior is:

| Situation                       | Cache behavior                           | Can tolerate cache drive loss? |
|---------------------------------|------------------------------------------|--------------------------------|
| Both servers up                 | Cache reads and writes, full performance | Yes                            |
| Server down, first 30 minutes   | Cache reads and writes, full performance | No (temporarily)               |
| After first 30 minutes          | Cache reads only, performance degrades   | Yes                            |

## Frequently asked questions

### Can I convert an existing volume between two-way mirror and nested resiliency?

No, volumes cannot be converted between resiliency types. For new deployments on Windows Server 2019, decide ahead of time which resiliency type best fits your needs. If you're upgrading from Windows Server 2016, you can create new volumes with nested resiliency, migrate your data, and then delete the older volumes.

### Can I use nested resiliency with multiple types of capacity drives?

Yes, just specify the `-MediaType` of each tier accordingly during [Step 1](#step-1-create-storage-tier-templates) above. For example, with NVMe, SSD, and HDD in the same cluster, the NVMe provides cache while the latter two provide capacity. Set the `NestedMirror` tier to `-MediaType SSD` and the `NestedParity` tier to `-MediaType HDD`. In this case, parity capacity efficiency depends on the number of HDD drives only, and you need at least 4 of them per server.

### Can I use nested resiliency with 3 or more servers?

No, only use nested resiliency if your cluster has exactly 2 servers.

### How many drives do I need to use nested resiliency?

The minimum number of drives required for Storage Spaces Direct is 4 capacity drives and 2 cache drives (if any) per server. There is no additional requirement for nested resiliency, and the recommended reserve capacity is also unchanged.

### Does nested resiliency change how drive replacement works?

No.

### Does nested resiliency change how server node replacement works?

No. To replace a server node and its drives, follow this order:

1. Retire the drives in the outgoing server
2. Add the new server, with its drives, to the cluster
3. The storage pool will rebalance
4. Remove the outgoing server and its drives

For details see the [Remove servers](remove-servers.md) topic.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
- [Understand fault tolerance in Storage Spaces Direct](storage-spaces-fault-tolerance.md)
- [Plan volumes in Storage Spaces Direct](plan-volumes.md)
- [Create volumes in Storage Spaces Direct](create-volumes.md)