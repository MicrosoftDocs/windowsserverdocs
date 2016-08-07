### <a name="gc"></a>Garbage Collection Job
Garbage Collection (GC) is one the regularly scheduled jobs used by Windows Server Deduplication to maintain the optimized data. GC is responsible for reclaiming disk space by removing unnecessary chunks that are no longer being referenced by files that have been recently modified or deleted.

There are two types of Garbage Collection:

- **Regular GC** uses a statistical algorithm to find large unreferenced dedup chunks that meet a certain criteria (low in memory and IOPs). GC compacts a chunk-store container only if a minimum percentage of the chunks are unreferenced. This type of GC runs much faster and uses much less resources than Full GC. The default schedule of the Regular GC job is to run once a week.
- **Full GC** does a much more thorough job finding unreferenced dedup chunks and freeing more disk space. Full GC compacts every container even if just a single chunk in the container is unreferenced. Full GC will also free space that may have been in use if there was a crash or power failure during an optimization job. Full GC jobs will recover 100% of the available space that can be recovered on a deduplicated volume at the cost of requiring more time and system resources compared to a Regular GC job. The Full GC job will typically find and release up to ~5% more of the unreferenced data than a Regular GC job. The default schedule of the Full GC job is to run every 4th time Garbage Collection is scheduled.

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


### Interacting with Dedup jobs
#### Checking on the status of a running job

#### Running a job on-demand
It is possible to run any Dedup job on-demand with `Start-DedupJob`. Running a job on-demand is useful if a job failed to run 

#### Canceling a job

#### Modifying the Default Job Schedules
#### Why would you want to do this?

#### How do you do this?