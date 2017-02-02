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
   > Do not distribute drives with pool data from one server into multiple other servers. For example, if one server with ten drives fails (because its motherboard or boot drive failed, for instance), you can move those ten drives into a new server, but you absolutely should not move each of them separately into different other servers.

## Remove server and remove drives

If you want to permanently scale in, you can remove the server from the cluster *and* remove its drives from the storage pool.

Use the optional **-CleanUpDisks** flag in PowerShell:

```PowerShell
Get-ClusterNode <Name> | Remove-ClusterNode -CleanUpDisks
```

This cmdlet may take a long time (up to many hours) to run because it moves all data away from the server's drives. When it completes, the drives will be removed and "forgotten" by the storage pool, and all volumes will be healthy.

   >[!TIP]
   > For this cmdlet to succeed, you must have enough capacity in the remaining servers to accomodate all your data. For example, if you have four servers with 10 TB each, you have 40 TB of physical storage capacity. After removing one server, you will only have (40 TB - 10 TB) = 30 TB. If you have more than 30 TB of data, this cmdlet will fail immediately, before it begins any data movement.

## See also

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
