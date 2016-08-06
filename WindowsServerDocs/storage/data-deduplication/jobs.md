# Data Deduplication Jobs
> Applies to Windows Server 2016

[Data Deduplication](data-deduplication.md), or Dedup, uses a post-processing strategy to optimize and maintain a volume's space efficiency. Dedup runs three jobs on a regular basis:

- [Optimization](data-deduplication-jobs.md#optimization) 
- [Garbage Collection](data-deduplication-jobs.md#gc)
- [Integrity Scrubbing](data-deduplication-jobs.md#scrubbing)

There is an additional job, called the [Unoptimization Job](data-deduplication-jobs.md#unoptimization), which will undo the optimizations performed by Dedup and disable Dedup on that volume.

Job settings 

## <a name="optimization">Optimization Job</a>


## <a name="gc">Garbage Collection Job</a>
Garbage Collection (GC) is one the regularly scheduled jobs used by Windows Server Deduplication to maintain the optimized data.  GC is responsible for reclaiming disk space by removing unnecessary chunks that are no longer being referenced by files that have been recently modified or deleted.

There are two types of Garbage Collection:

- **Regular GC** uses a statistical algorithm to find large unreferenced dedup chunks that meet a certain criteria (low in memory and IOPs).  GC compacts a chunk-store container only if a minimum percentage of the chunks  are unreferenced.  This type of GC runs much faster and uses much less resources than Full GC. The default schedule of the Regular GC job is to run once a week.
- **Full GC** does a much more thorough job finding unreferenced dedup chunks and freeing more disk space.   Full GC compacts every container even if just a single chunk in the container is unreferenced.  Full GC will also free space that may have been in use if there was a crash or power failure during an optimization job.  Full GC jobs will recover 100% of the available space that can be recovered on a deduplicated volume at the cost of requiring more time and system resources compared to a Regular GC job. The Full GC job will typically find and release up to ~5% more of the unreferenced data than a Regular GC job.

When a GC job is started it runs as a Regular GC job and every 4th GC run becomes a Full GC job.  With the default schedule, this means Regular GC jobs are run weekly and Full GC jobs are run monthly by the system.

Users may want to disable the Full GC job from ever running depending on their needs:

Reasons to use a regularly scheduled Full GC job:

- To make sure that all free space is reclaimed (100% of it) consistently (the default is every 4 weeks)
- To make sure any storage space leaks are cleaned up if the machine had reliability issues – power failures, system crashes. This may potentially recover GBs of space.

Reasons to avoid running a regular scheduled Full GC job:

- Because Full GC creates more churn, this could adversely impact the volume’s shadow copies life-time and the size of incremental backup. High churn or I/O intensive deduplication workloads may see large degradation in performance by Full GC jobs. See this KB article This link is external to TechNet Wiki. It will open in a new window. for more details to mitigate these types of scenarios.           
- A Full Garbage Collection job can be always run manually from PowerShell to clean up leaks if you know your system crashed.

Full GC can be disabled via the registry with the following command:

`Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\ddpsvc\Settings -Name DeepGCInterval -Type DWord -Value 0`

## <a name="scrubbing">Integrity Scrubbing Job</a>

## <a name="unoptimization">Unoptimization Job</a>