# What's New in Data Deduplication
> Applies to Windows Server 2016

[Data Deduplication](overview.md), or Dedup, in Windows Server 2016 has been optimized to be highly performant,  flexible, and manageable at "Private Cloud" scale. For more information about the Software Defined Storage stack in Windows Server 2016, please see [What's New in File and Storage Services in Windows Server 2016](../whats-new-file-storage-services-windows-server-2016).

Dedup has the following enhancements in Windows Server 2016: 

|Functionality|New or Updated|Description|  
|-----------------|------------------|---------------|  
|[Support for Large Volumes](data-deduplication/whats-new.md#large-volume-support)|Updated|Prior to Windows Server 2016, volumes had to specifically sized for the expected churn, with volume sizes above 10 TB not being good candidates for Dedup. In Windows Server 2016, Data Deduplication supports volume sizes **up to 64 TB**.|  
|[Support for Large Files](data-deduplication/whats-new.md#large-file-support)|Updated|Prior to Windows Server 2016, files approaching 1 TB in size were not good candidates for Dedup. In Windows Server 2016, files **up to 1 TB** are fully supported.|  
|[Support for Nano Server](data-deduplication/whats-new.md#nano-server-support)|New|Dedup is available and fully supported in the new Nano Server deployment option for Windows Server 2016.| 
|[Simplified Backup Support](data-deduplication/whats-new.md#simple-backup-support)|New|In Windows Server 2012 R2, Virtualized Backup Applications such as Microsoft's [Data Protection Manager](https://technet.microsoft.com/en-us/library/hh758173.aspx) were supported through a series of manual configuration steps. In Windows Server 2016, a new default Usage Type "Backup", has been added for seamless deployment of Dedup for Virtualized Backup Applications. |   
|[Support for Cluster OS Rolling Upgrades](data-deduplication/whats-new.md#cluster-upgrade-support)|New|Data Deduplication fully supports the new [Cluster OS Rolling Upgrade](../compute/cluster-operating-system-rolling-upgrade.md) feature of Windows Server 2016.|  

## <a name="large-volume-support">Support for Volume Sizes up to 64 TB</a>
**What value does this change add?**<br />
In Windows Server 2012 R2, in order to get the best performance out of Dedup, volumes must be sized properly to ensure that the Dedup Optimization Job can keep up with the rate of data changes, or "churn". Typically, this means that Dedup is only performant on volumes of 10 TB, or less, depending on the workload's write patterns.

In Windows Server 2016, Dedup is highly performant on volumes up to 64 TB.

**What works differently?**<br />
In Windows Server 2012 R2, the Dedup Job Pipeline uses a single-thread and I/O queue for each volume. In order to ensure that the Optimization Jobs do not fall behind (which would cause the overall savings rate for the volume to decrease), large datasets must be broken up into smaller volumes. The appropriate volume size depends on the expected churn for that volume, on average, something like a maximum of ~6-7 TB for high churn volumes and ~9-10 TB for low churn volumes. 

In Windows Server 2016, the Dedup Job pipeline has been redesigned to run multiple threads in parallel using multiple I/O queues for each volume, resulting in performance that was only possible before by dividing up data into multiple, smaller volumes. This change can be visualized as such:

<img src="media/server-2016-dedup-job-pipeline.png" alt="A visualization comparing the Dedup Job Pipeline in Windows Server 2012 R2 to Windows Server 2016" style="width:653px; height:367px; margin-left:auto; margin-right:auto;">

These optimizations apply to all Dedup Jobs, not just the Optimization Job. More information on Jobs Dedup runs can be found [here](jobs.md).

## <a name="large-file-support">Support for File Sizes up to 1 TB</a>
**What value does this change add?**<br />
In Windows Server 2012 R2, very large files are not good candidates for Data Deduplication due to decreased performance of the Deduplication Processing Pipeline. In Windows Server 2016, Deduplication of files up to 1 TB is very performant, enabling administrators to apply deduplication savings to a larger range of workloads. For example, enabling deduplication of very large files normally associated with backup workloads.

**What works differently?**<br />
In Windows Server 2016, Data Deduplication makes use of new stream map structures and other "under-the-hood" improvements to increase optimization throughput and access performance. Additionally, the Deduplication Processing Pipeline can now resume optimization progress on a file (rather than restart) after a failover. These changes add up to Deduplication on files up to 1 TB being highly performant.

## <a name="nano-server-support">Support for Nano Server</a>
**What value does this change add?**<br />
Nano Server is a new headless deployment option in Windows Server 2016 that has far small system resource footprint, starts up significantly faster, and requires fewer updates and restarts than the Windows Server Core deployment option. Data Deduplication is fully supported on Nano Server. For more information about Nano Server, see [Getting Started with Nano Server](../../compute/getting-started-with-nano-server).

## <a name="simple-backup-support">Simplified Configuration for Virtualized Backup Applications</a>
**What value does this change add?**<br />
While Deduplication for Virtualized Backup Applications is a supported scenario in Windows Server 2012 R2, it requires manually tuning the Deduplication settings. In Windows Server 2016, the configuration of Deduplication for Virtualized Backup Applications is drastically simplified by a predefined "Usage Type" option when enabling Deduplication for a volume, just like our options for General Purpose File Server and VDI.

## <a name="cluster-upgrade-support">Support for Cluster Rolling Upgrades</a>
**What value does this change add?**<br />
Windows Failover Clusters running Dedup can have a mix of nodes running Windows Server 2012 R2 versions of deduplication alongside nodes running Windows Server 2016 Technical Preview versions of deduplication. This enhancement provides full data access to all deduplicated volumes during a cluster rolling upgrade, allowing for the gradual rollout of the new version of deduplication on an existing Windows Server 2012 R2 cluster without incurring downtime to upgrade all nodes at once.

**What works differently?**<br />
With previous versions of Windows Server, a Windows Failover Cluster required all nodes in the cluster to be at the exact same Windows Server version. Starting with the Windows Server 2016 Technical Preview, the cluster rolling upgrade functionality allows a cluster to run in a mixed-mode. Deduplication supports this new mixed-mode cluster configuration to enable full data access during a cluster rolling upgrade.