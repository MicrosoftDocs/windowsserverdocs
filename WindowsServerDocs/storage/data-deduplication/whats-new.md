---
title:What's New in Data Deduplication  
description:Data Deduplication in Windows Server 2016 has been optimized to be highly performant, flexible, and manageable at Private Cloud scale.  
author:wmgries  
ms.author:wgries  
manager:eldenc  
ms.date:08/19/2016   
ms.topic:get-started-article  
ms.prod:windows-server-threshold  
ms.service:na  
ms.technology:
- techgroup-storage
- dedup
---

# What's New in Data Deduplication
> Applies to Windows Server 2016

[Data Deduplication](overview.md) in Windows Server 2016 has been optimized to be highly performant, flexible, and manageable at "Private Cloud" scale. For more information about the Software Defined Storage stack in Windows Server 2016, please see [What's New in Storage in Windows Server 2016](../whats-new-file-storage-services-windows-server-2016.md).

Data Deduplication has the following enhancements in Windows Server 2016: 

| Functionality | New or Updated | Description |
|---------------|----------------|-------------|
| [Support for Large Volumes](whats-new.md#large-volume-support) | Updated | Prior to Windows Server 2016, volumes had to be specifically sized for the expected churn, with volume sizes above 10 TB not being good candidates for Data Deduplication. In Windows Server 2016, Data Deduplication supports volume sizes **up to 64 TB**. |
| [Support for Large Files](whats-new.md#large-file-support) | Updated | Prior to Windows Server 2016, files approaching 1 TB in size were not good candidates for Data Deduplication. In Windows Server 2016, files **up to 1 TB** are fully supported. |
| [Support for Nano Server](whats-new.md#nano-server-support) | New | Data Deduplication is available and fully supported in the new Nano Server deployment option for Windows Server 2016. |
| [Simplified Backup Support](whats-new.md#simple-backup-support) | New | In Windows Server 2012 R2, Virtualized Backup Applications, such as Microsoft's [Data Protection Manager](https://technet.microsoft.com/library/hh758173.aspx), were supported through a series of manual configuration steps. In Windows Server 2016, a new default Usage Type "Backup", has been added for seamless deployment of Data Deduplication for Virtualized Backup Applications.|
| [Support for Cluster OS Rolling Upgrades](whats-new.md#cluster-upgrade-support) | New | Data Deduplication fully supports the new [Cluster OS Rolling Upgrade](../compute/failover-clustering/cluster-operating-system-rolling-upgrade.md) feature of Windows Server 2016. |

## <a name="large-volume-support"></a>Support for Large Volumes
**What value does this change add?**  
In Windows Server 2012 R2, in order to get the best performance out of Data Deduplication, volumes must be sized properly to ensure that the Optimization Job can keep up with the rate of data changes, or "churn". Typically, this means that Data Deduplication is only performant on volumes of 10 TB, or less, depending on the workload's write patterns.

In Windows Server 2016, Data Deduplication is highly performant on volumes up to 64 TB.

**What works differently?**  
In Windows Server 2012 R2, the Data Deduplication Job Pipeline uses a single-thread and I/O queue for each volume. In order to ensure that the Optimization Jobs do not fall behind, which would cause the overall savings rate for the volume to decrease, large datasets must be broken up into smaller volumes. The appropriate volume size depends on the expected churn for that volume, on average, something like a maximum of ~6-7 TB for high churn volumes and ~9-10 TB for low churn volumes. 

In Windows Server 2016, the Data Deduplication Job pipeline has been redesigned to run multiple threads in parallel using multiple I/O queues for each volume, resulting in performance that was only possible before by dividing up data into multiple, smaller volumes. This change can be visualized as such:

![A visualization comparing the Data Deduplication Job Pipeline in Windows Server 2012 R2 to Windows Server 2016](media/server-2016-dedup-job-pipeline.png)

These optimizations apply to [all Data Deduplication Jobs](understand.md#job-info), not just the Optimization Job.

## <a name="large-file-support"></a>Support for Large Files
**What value does this change add?**  
In Windows Server 2012 R2, very large files are not good candidates for Data Deduplication due to decreased performance of the Deduplication Processing Pipeline. In Windows Server 2016, Deduplication of files up to 1 TB is very performant, enabling administrators to apply deduplication savings to a larger range of workloads. For example, enabling deduplication of very large files normally associated with backup workloads.

**What works differently?**  
In Windows Server 2016, Data Deduplication makes use of new stream map structures and other "under-the-hood" improvements to increase optimization throughput and access performance. Additionally, the Deduplication Processing Pipeline can now resume optimization progress on a file (rather than restart) after a failover. These changes add up to Deduplication on files up to 1 TB being highly performant.

## <a name="nano-server-support"></a>Support for Nano Server
**What value does this change add?**  
Nano Server is a new headless deployment option in Windows Server 2016 that has a far small system resource footprint, starts up significantly faster, and requires fewer updates and restarts than the Windows Server Core deployment option. Data Deduplication is fully supported on Nano Server. For more information about Nano Server, see [Getting Started with Nano Server](../../compute/getting-started-with-nano-server.md).

## <a name="simple-backup-support">Simplified Configuration for Virtualized Backup Applications</a>
**What value does this change add?**  
While Deduplication for Virtualized Backup Applications is a supported scenario in Windows Server 2012 R2, it requires manually tuning the Deduplication settings. In Windows Server 2016, the configuration of Deduplication for Virtualized Backup Applications is drastically simplified by a predefined "Usage Type" option when enabling Deduplication for a volume, just like our options for General Purpose File Server and VDI.

## <a name="cluster-upgrade-support">Support for Cluster OS Rolling Upgrades</a>
**What value does this change add?**  
Windows Server Failover Clusters running Data Deduplication can have a mix of nodes running Windows Server 2012 R2 versions of deduplication alongside nodes running Windows Server 2016 versions of deduplication. This enhancement provides full data access to all deduplicated volumes during a cluster rolling upgrade, allowing for the gradual rollout of the new version of deduplication on an existing Windows Server 2012 R2 cluster without incurring downtime to upgrade all nodes at once.

**What works differently?**<br />
With previous versions of Windows Server, a Windows Server Failover Cluster required all nodes in the cluster to be at the exact same Windows Server version. Starting with the Windows Server 2016, the cluster rolling upgrade functionality allows a cluster to run in a mixed-mode. Deduplication supports this new mixed-mode cluster configuration to enable full data access during a cluster rolling upgrade.