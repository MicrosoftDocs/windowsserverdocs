---
description: "Learn more about: Performance history for clusters"
title: Performance history for clusters
ms.author: roharwoo
ms.topic: concept-article
author: robinharwood
ms.date: 02/02/2018
appliesto: [
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
			"✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
			"✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
		   ]
---

# Performance history for clusters

This sub-topic of [Performance history for Storage Spaces Direct](performance-history.md) describes the performance history collected for clusters.

There are no series that originate at the cluster level. Instead, server series, such as `clusternode.cpu.usage`, are aggregated for all servers in the cluster. Volume series, such as `volume.iops.total`, are aggregated for all volumes in the cluster. And drive series, such as `physicaldisk.size.total`, are aggregated for all drives in the cluster.

## Usage in PowerShell

Use the [Get-Cluster](/powershell/module/failoverclusters/get-cluster) cmdlet:

```PowerShell
Get-Cluster | Get-ClusterPerf
```

## Additional References

- [Performance history for Storage Spaces Direct](performance-history.md)

