---
title: Removing servers in Storage Spaces Direct
ms.assetid: 9d8499a7-1307-473d-9f00-8a051164fad2
ms.prod: windows-server-threshold
ms.author: cosdar
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: cosmosdarwin
description: How to remove servers from a Storage Spaces Direct cluster in Windows Server.
ms.date: 2/5/2017
ms.localizationpriority: medium
---

# Removing servers in Storage Spaces Direct

>Applies to: Windows Server 2019, Windows Server 2016

This topic describes how to remove servers in [Storage Spaces Direct](storage-spaces-direct-overview.md) using PowerShell.

## Remove a server but leave its drives

If you intend to add the server back into the cluster soon, or if you intend to keep its drives by moving them to another server, you can remove the server from the cluster *without* removing its drives from the storage pool. This is the default behavior if you use Failover Cluster Manager to remove the server.

Use the [Remove-ClusterNode](https://technet.microsoft.com/library/hh847251.aspx) cmdlet in PowerShell:

```PowerShell
Remove-ClusterNode <Name>
```

This cmdlet succeeds quickly, regardless of any capacity considerations, because the storage pool "remembers" the missing drives and expects them to come back. There is no data movement away from the missing drives. While they remain missing, their **OperationalStatus** will show as "Lost Communication", and your volumes will show "Incomplete".

When the drives come back, they are automatically detected and re-associated with the pool, even if they are now in a new server.

   >[!WARNING]
   > Do not distribute drives with pool data from one server into multiple other servers. For example, if one server with ten drives fails (because its motherboard or boot drive failed, for instance), you **can** move all ten drives into one new server, but you **cannot** move each of them separately into different other servers.

## Remove a server and its drives

If you want to permanently remove a server from the cluster (sometimes referred to as scaling-in), you can remove the server from the cluster *and* remove its drives from the storage pool.

Use the **Remove-ClusterNode** cmdlet with the optional **-CleanUpDisks** flag:

```PowerShell
Remove-ClusterNode <Name> -CleanUpDisks
```

This cmdlet might take a long time (sometimes many hours) to run because Windows must move all the data stored on that server to other servers in the cluster. Once this is complete, the drives are permanently removed from the storage pool, returning affected volumes to a healthy state.

### Requirements

To permanently scale-in (remove a server *and* its drives), your cluster must meet the following two requirements. If it doesn't, the **Remove-ClusterNode -CleanUpDisks** cmdlet will return an error immediately, before it begins any data movement, to minimize disruption.

#### Enough capacity

First, you must have enough storage capacity in the remaining servers to accommodate all your volumes.

For example, if you have four servers, each with 10 x 1 TB drives, you have 40 TB of total physical storage capacity. After removing one server and all its drives, you will have 30 TB of capacity left. If the footprints of your volumes are more than 30 TB together, they won't fit in the remaining servers, so the cmdlet will return an error and not move any data.

#### Enough fault domains

Second, you must have enough fault domains (typically servers) to provide the resiliency of your volumes.

For example, if your volumes use three-way mirroring at the server level for resiliency, they cannot be fully healthy unless you have at least three servers. If you have exactly three servers, and then attempt to remove one and all its drives, the cmdlet will return an error and not move any data.

This table shows the minimum number of fault domains required for each resiliency type.

|    Resiliency          |    Minimum required fault domains   |
|------------------------|-------------------------------------|
|    Two-way mirror      |    2                                |
|    Three-way mirror    |    3                                |
|    Dual parity         |    4                                |

   >[!NOTE]
   > It is okay to briefly have fewer servers, such as during failures or maintenance. However, in order for volumes to return to a fully healthy state, you must have the minimum number of servers listed above.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
