---
description: "Learn more about: Performance history for clusters"
title: Performance history for clusters
ms.author: cosdar
manager: eldenc
ms.topic: article
author: cosmosdarwin
ms.date: 02/02/2018
---

# Performance history for clusters

>Applies to: Windows Server 2022, Windows Server 2019

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes the performance history collected for clusters.

There are no series that originate at the cluster level. Instead, server series, such as `clusternode.cpu.usage`, are aggregated for all servers in the cluster. Volume series, such as `volume.iops.total`, are aggregated for all volumes in the cluster. And drive series, such as `physicaldisk.size.total`, are aggregated for all drives in the cluster.

## Usage in PowerShell

Use the [Get-Cluster](/powershell/module/failoverclusters/get-cluster) cmdlet:

```PowerShell
Get-Cluster | Get-ClusterPerf
```

## Additional References

- [Performance history for Storage Spaces Direct](performance-history.md)
