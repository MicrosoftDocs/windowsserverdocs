---
title: Removing servers in Storage Spaces Direct
ms.prod: windows-server-threshold
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
ms.date: 2/2/2017
---

# Removing servers in Storage Spaces Direct

>Applies To: Windows Server 2016

This topic describes how to remove servers in [Storage Spaces Direct](storage-spaces-direct-overview.md) using PowerShell.

## Remove server but keep drives

If you intend to add the server back into the cluster soon, or if you intend to keep its drives by moving them to another server, you can remove the server from the cluster *without* removing its drives from the storage pool. This is the default behavior if you use Failover Cluster Manager to remove the server.

Use the **Remove-ClusterNode** cmdlet in PowerShell:

```PowerShell
Get-ClusterNode <Name> | Remove-ClusterNode
```

This cmdlet succeeds quickly, regardless of any capacity considerations, because the storage pool "remembers" the missing drives and expects them to come back. There is no data movement away from the missing drives. While they remain missing, their **OperationalStatus** will show as "Lost Communication", and your volumes will show "Incomplete".

When the drives come back, they are automatically detected and re-associated with the pool, even if they are now in a new server.

   >[!WARNING]
   > Do not distribute drives with pool data from one server into multiple other servers. For example, if one server with ten drives fails (because its motherboard or boot drive failed, for instance), you **can** move all ten drives into one new server, but you **cannot** move each of them separately into different other servers.

## Remove server and remove drives

If you want to scale-in permanently, you can remove the server from the cluster *and* remove its drives from the storage pool.

Use the **Remove-ClusterNode** cmdlet with the optional **-CleanUpDisks** flag:

```PowerShell
Get-ClusterNode <Name> | Remove-ClusterNode -CleanUpDisks
```

This cmdlet may take a long time (sometimes many hours) to run because it requires significant data movement: all data stored on all the drives in that server must be moved to other drives in other servers. Once this is complete, the drives will be removed and "forgotten" by the storage pool, and all volumes will be healthy.

### Requirements

To permanently scale-in (remove server *and* remove drives), your cluster must meet two requirements. If it does not, the **Remove-ClusterNode -CleanUpDisks** cmdlet will stop (fail) immediately, before it begins any data movement, to minimize disruption.

#### Enough capacity

First, you must have enough storage capacity in the remaining servers to accomodate all your volumes.

For example, if you have four servers, each with 10 x 1 TB drives, you have 40 TB of total physical storage capacity. After removing one server and all its drives, you will only have 30 TB of capacity. If the footprints of your volumes are more than 30 TB together, they will not fit in the remaining servers, and the cmdlet will fail.

#### Enough fault domains

Second, you must have enough fault domains (typically servers) to provide the resiliency of your volumes.

For example, if your volumes use three-way mirroring for resiliency, you must have at least three servers. If you have exactly three, and then you attempt to remove one and all its drives, the cmdlet will fail. Likewise, if your volumes use dual parity, which requires four servers, you cannot permanently scale-in to three servers.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
