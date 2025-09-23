---
description: "Learn about nested resiliency for Storage Spaces Direct"
title: Nested resiliency for Storage Spaces Direct
ms.author: roharwoo
ms.topic: concept-article
author: robinharwood
ms.date: 11/25/2024
appliesto: [
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
            "✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
           ]
---

# Nested resiliency for Storage Spaces Direct

Nested resiliency is a capability of [Storage Spaces Direct](storage-spaces-direct-overview.md) in Azure Local and Windows Server. It enables a two-server cluster to withstand multiple hardware failures at the same time without loss of storage availability, so users, apps, and virtual machines continue to run without disruption. This article explains how nested resiliency works, provides step-by-step instructions to get started, and answers the most frequently asked questions.

## Before you begin

**Consider nested resiliency if:**

- Your cluster runs one of these operating systems: Azure Local, version 22H2 or later, Windows Server 2019 or later; **and**
- Your cluster has exactly two server nodes.

**You can't use nested resiliency if:**

- Your cluster runs Windows Server 2016; or
- Your cluster has only a single server node or has three or more server nodes.

## Why nested resiliency

Volumes that use nested resiliency can stay online and accessible even if multiple hardware failures happen at the same time, unlike classic [two-way mirroring](fault-tolerance.md) resiliency. For example, if two drives fail at the same time, or if a server goes down and a drive fails, volumes that use nested resiliency stay online and accessible. For hyper-converged infrastructure, this increases uptime for apps and virtual machines; for file server workloads, this means users have uninterrupted access to their files.

:::image type="content" source="media/nested-resiliency/storage-availability.png" alt-text="Diagram that shows storage availability." lightbox="media/nested-resiliency/storage-availability.png":::

The trade-off is that nested resiliency has lower capacity efficiency than classic two-way mirroring, meaning you get slightly less usable space. For details, see the [Capacity efficiency](#capacity-efficiency) following section.

## How it works

This section provides the background on nested resiliency for Storage Spaces Direct and describes the two new resiliency options and their capacity efficiency.

### Inspiration: RAID 5+1

RAID 5+1 is an established form of distributed storage resiliency that provides helpful background for understanding nested resiliency. In RAID 5+1, within each server, local resiliency is provided by RAID-5, or *single parity*, to protect against the loss of any single drive. Then, further resiliency is provided by RAID-1, or *two-way mirroring*, between the two servers to protect against the loss of either server.

:::image type="content" source="media/nested-resiliency/raid-51.png" alt-text="Diagram that shows RAID 5+1." lightbox="media/nested-resiliency/raid-51.png":::

### Resiliency options

Storage Spaces Direct in Azure Local and Windows Server offers two resiliency options implemented in software, without the need for specialized RAID hardware:

- **Nested two-way mirror.** Within each server, local resiliency is provided by two-way mirroring, and then further resiliency is provided by two-way mirroring between the two servers. It's essentially a four-way mirror, with two copies on each server that are located on different physical disks. Nested two-way mirroring provides uncompromising performance: writes go to all copies and reads come from any copy.

  :::image type="content" source="media/nested-resiliency/nested-two-way-mirror.png" alt-text="Diagram that shows nested two-way mirror." lightbox="media/nested-resiliency/nested-two-way-mirror.png":::

- **Nested mirror-accelerated parity.** Combine nested two-way mirroring, from the previous image, with nested parity. Within each server, local resiliency for most data is provided by single [bitwise parity arithmetic](fault-tolerance.md#parity), except new recent writes that use two-way mirroring. Then, further resiliency for all data is provided by two-way mirroring between the servers. New writes to the volume go to the mirror part with two copies on separate physical disks on each server. As the mirror part of the volume fills on each server, the oldest data is converted and saved to the parity part in the background. As a result, each server has the data for the volume either in two-way mirror or in a single parity structure. This is similar to how [mirror-accelerated parity](/windows-server/storage/refs/mirror-accelerated-parity) works—with the difference being that mirror-accelerated parity requires four servers in the cluster and storage pool, and uses a different parity algorithm.

  :::image type="content" source="media/nested-resiliency/nested-mirror-accelerated-parity.png" alt-text="Diagram that shows nested mirror-accelerated parity." lightbox="media/nested-resiliency/nested-mirror-accelerated-parity.png":::

### Capacity efficiency

Capacity efficiency is the ratio of usable space to [volume footprint](plan-volumes.md#choosing-the-size-of-volumes). It describes the capacity overhead attributable to resiliency, and depends on the resiliency option you choose. As a simple example, storing data without resiliency is 100% capacity efficient (1 TB of data takes up 1 TB of physical storage capacity), while two-way mirroring is 50% efficient (1 TB of data takes up 2 TB of physical storage capacity).

- **Nested two-way mirror** writes four copies of everything. This means that to store 1 TB of data, you need 4 TB of physical storage capacity. Although its simplicity is appealing, nested two-way mirror's capacity efficiency of 25% is the lowest of any resiliency option in Storage Spaces Direct.

- **Nested mirror-accelerated parity** achieves higher capacity efficiency, around 35%-40%, that depends on two factors: the number of capacity drives in each server, and the mix of mirror and parity you specify for the volume. This table provides a lookup for common configurations:

  | Capacity drives per server | 10% mirror | 20% mirror | 30% mirror |
  |----------------------------|------------|------------|------------|
  | 4                          | 35.7%      | 34.1%      | 32.6%      |
  | 5                          | 37.7%      | 35.7%      | 33.9%      |
  | 6                          | 39.1%      | 36.8%      | 34.7%      |
  | 7+                         | 40.0%      | 37.5%      | 35.3%      |

  The following is an example of the full math. Suppose we have six capacity drives in each of two servers, and we want to create one 100 GB volume comprised of 10 GB of mirror and 90 GB of parity. Server-local two-way mirror is 50.0% efficient, meaning the 10 GB of mirror data takes 20 GB to store on each server. Mirrored to both servers, its total footprint is 40 GB. Server-local single parity, in this case, is 5/6 = 83.3% efficient, meaning the 90 GB of parity data takes 108 GB to store on each server. Mirrored to both servers, its total footprint is 216 GB. The total footprint is thus [(10 GB / 50.0%) + (90 GB / 83.3%)] × 2 = 256 GB, for 39.1% overall capacity efficiency.

  Notice that the capacity efficiency of classic two-way mirroring (about 50%) and nested mirror-accelerated parity (up to 40%) aren't very different. Depending on your requirements, the slightly lower capacity efficiency may be well worth the significant increase in storage availability. You choose resiliency per-volume, so you can mix nested resiliency volumes and classic two-way mirror volumes within the same cluster.

  :::image type="content" source="media/nested-resiliency/tradeoff.png" alt-text="Diagram that shows the tradeoff between a two-way mirror and nested mirror-accelerated parity." lightbox="media/nested-resiliency/tradeoff.png":::

## Create nested resiliency volumes

[!INCLUDE [Create nested resiliency volumes](../../../includes/create-volumes-with-nested-resiliency.md)]

## Frequently asked questions

Find answers to frequently asked questions about nested resiliency.

### Can I convert an existing volume between two-way mirror and nested resiliency?

No, volumes can't be converted between resiliency types. For new deployments on Azure Local, Windows Server 2022, or Windows Server 2019, decide ahead of time which resiliency type best fits your needs. If you're upgrading from Windows Server 2016, you can create new volumes with nested resiliency, migrate your data, and then delete the older volumes.

### Can I use nested resiliency with multiple types of capacity drives?

Yes, just specify the `-MediaType` of each tier accordingly during [step 1](nested-resiliency.md#step-1-create-storage-tier-templates-windows-server-2019-only) above. For example, with NVMe, SSD, and HDD in the same cluster, the NVMe provides cache while the latter two provide capacity: set the `NestedMirror` tier to `-MediaType SSD` and the `NestedParity` tier to `-MediaType HDD`. In this case, the parity capacity efficiency depends on the number of HDD drives only, and you need at least 4 of them per server.

### Can I use nested resiliency with three or more servers?

No, only use nested resiliency if your cluster has exactly two servers.

### How many drives do I need to use nested resiliency?

The minimum number of drives required for Storage Spaces Direct is four capacity drives per server node, plus two cache drives per server node (if any). This is unchanged from Windows Server 2016. There's no other requirement for nested resiliency, and the recommendation for reserve capacity is unchanged too.

### Does nested resiliency change how drive replacement works?

No.

### Does nested resiliency change how server node replacement works?

No. To replace a server node and its drives, follow this order:

1. Retire the drives in the outgoing server
2. Add the new server, with its drives, to the cluster
3. The storage pool will rebalance
4. Remove the outgoing server and its drives

For details see the [Remove servers](/windows-server/storage/storage-spaces/remove-servers) article.

## Next steps

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
- [Understand fault tolerance in Storage Spaces Direct](fault-tolerance.md)
- [Plan volumes in Storage Spaces Direct](plan-volumes.md)
- [Create volumes in Storage Spaces Direct](create-volumes.md)
