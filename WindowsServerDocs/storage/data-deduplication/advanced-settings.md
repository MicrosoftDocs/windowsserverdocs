---
title:"Advanced Data Deduplication Settings"  
description:"Learn how to modify advanced Data Deduplication (Dedup) settings."  
author:"wmgries"    
ms.author:"wgries"   
manager:"eldenc"  
ms.date:"08/19/2016"   
ms.topic:"get-started-article"  
ms.prod:"windows-server-threshold"  
ms.service:"na"  
ms.technology:
- techgroup-storage
- dedup
---

# Advanced Data Deduplication Settings

> Applies to Windows Server 2016

This document describes how to modify advanced [Data Deduplication](overview.md), or Dedup, settings. The default settings should be sufficient for ['Always' workloads](install-enable.md#enable-dedup-candidate-workloads); the main reason to modify these settings is to improve Dedup's performance with 'Sometimes' workloads.

## <a id="modifying-job-schedules"></a>Modifying Dedup Job Schedules
The default Dedup job schedules are designed to (1) work well for 'Always' workloads, and (2) be as non-intrusive as possible (excluding the 'Priority Optimization' job that is enabled for the [Backup Usage Type](understand.md#usage-type-backup)). More information about the default schedules can be found [here](understand.md#job-info). Because 'Sometimes' workloads often have greater demands on the system, it is possible to ensure that jobs only run during idle hours and/or to reduce/increase the amount of system resources that a Dedup job is allowed to consume.

### <a id="modifying-job-schedules-change-schedule"></a>Changing a Dedup Schedule
Dedup jobs are scheduled via the Windows Task Scheduler, and can be viewed and edited there under the path Microsoft\Windows\Deduplication. Dedup includes several cmdlets however that make scheduling easy:
* [`Get-DedupSchedule`](https://technet.microsoft.com/en-us/library/hh848446.aspx) which shows the current scheduled jobs
* [`New-DedupSchedule`](https://technet.microsoft.com/en-us/library/hh848445.aspx) which creates a new scheduled job
* [`Set-DedupSchedule`](https://technet.microsoft.com/en-us/library/hh848447.aspx) which modifies an existing scheduled job
* [`Remove-DedupSchedule`](https://technet.microsoft.com/en-us/library/hh848451.aspx) which removes a scheduled job.

The most common reason for changing when the Dedup jobs run is to ensure that jobs run during off hours. The following step-by-step example shows how to modify the Dedup schedule for a 'sunny day' scenario: a hyper-converged Hyper-V host that is idle on weeknights starting at 7 PM and on weekends. To change the schedule, run the following PowerShell cmdlets in an Administrator context:

1. Disable the scheduled hourly [Optimization](understand.md#job-info-optimization) jobs:  
	```PowerShell
	Set-DedupSchedule -Name BackgroundOptimization -Enabled $false
	Set-DedupSchedule -Name PriorityOptimization -Enabled $false
	```

2. Remove the currently scheduled [Garbage Collection](understand.md#job-info-gc) and [Integrity Scrubbing](understand.md#job-info-scrubbing) jobs:
	```PowerShell
	Get-DedupSchedule -Type GarbageCollection | ForEach-Object { Remove-DedupSchedule -InputObject $_ }
	Get-DedupSchedule -Type Scrubbing | ForEach-Object { Remove-DedupSchedule -InputObject $_ }
	```

3. Create a nightly Optimization job that runs at 7 PM with high priority and all the CPUs and Memory available on the system:
	```PowerShell
	New-DedupSchedule -Name "NightlyOptimization" -Type Optimization -DurationHours 11 -Memory 100 -Cores 100 -Priority High -Days @(1,2,3,4,5) -Start (Get-Date "2016-08-08 19:00:00")
	```

	> [!Note]  
	> The 'date' part of the `System.Datetime` provided to 'Start' is irrelevant (as long as its in the past), but the 'time' part specifies when the job should start.
4. Create a Weekly Garbage Collection job that runs on Saturday starting at 7 AM with high priority and all the CPUs and Memory available on the system:
	```PowerShell
	New-DedupSchedule -Name "WeeklyGarbageCollection" -Type GarbageCollection -DurationHours 23 -Memory 100 -Cores 100 -Priority High -Days @(6) -Start (Get-Date "2016-08-13 07:00:00")
	```
	
5. Create a Weekly Integrity Scrubbing job that runs on Sunday starting at 7 AM with high priority and all the CPUs and memory available on the system:
	```PowerShell
	New-DedupSchedule -Name "WeeklyIntegrityScrubbing" -Type Scrubbing -DurationHours 23 -Memory 100 -Cores 100 -Priority High -Days @(0) -Start (Get-Date "2016-08-14 07:00:00")
	```

### <a id="modifying-job-schedules-available-settings"></a>Available Job-wide Settings
The following settings can be toggled for new or scheduled Dedup jobs:

<table>
	<thead>
		<tr>
			<th style="min-width:125px">Parameter Name</th>
			<th style="min-width:125px">Definition</th>
			<th style="min-width:125px">Accepted Values</th>
			<th style="min-width:125px">Why would you want to set this value?</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Type</td>
			<td>The type of the job that should be scheduled.</td>
			<td>
				<ul>
					<li>Optimization</li>
					<li>GarbageCollection</li>
					<li>Scrubbing</li>
				</ul>
			</td>
			<td>This value is required because it is the type of job that you want to have be scheduled. This value cannot be changed after the task has been scheduled.</td>
		</tr>
		<tr>
			<td>Priority</td>
			<td>The system priority of the scheduled job.</td>
			<td>
				<ul>
					<li>High</li>
					<li>Medium</li>
					<li>Low</li>
				</ul>
			</td>
			<td>This value helps the system determine how to appropriate allocate CPU time. 'High' will use more CPU time, 'Low' will use less.</td>
		</tr>
		<tr>
			<td>Days</td>
			<td>The days that the job is to be scheduled.</td>
			<td>An array of integers 0-6 representing the days of the week:<ul>
				<li>0 = Sunday</li>
				<li>1 = Monday</li>
				<li>2 = Tuesday</li>
				<li>3 = Wednesday</li>
				<li>4 = Thursday</li>
				<li>5 = Friday</li>
				<li>6 = Saturday</li>
			</ul></td>
			<td>Scheduled tasks have to run on at least one day.</td>
		</tr>
		<tr>
			<td>Cores</td>
			<td>The percentage of cores on the system that Dedup jobs should use.</td>
			<td>Integers 0-100 (indicates a percentage)</td>
			<td>To control what level of impact Dedup will have on the compute resources on the system.</td>
		</tr>
		<tr>
			<td>DurationHours</td>
			<td>The maximum amount of hours a Dedup job should be allowed to run.</td>
			<td>Positive integers</td>
			<td>To prevent a job for running into a workload's non-idle hours.</td>
		</tr>
		<tr>
			<td>Enabled</td>
			<td>Whether or not the job will run.</td>
			<td>True/False</td>
			<td>To disable a job without removing it.</td>
		</tr>
		<tr>
			<td>Full</td>
			<td>For scheduling full Garbage Collection job.</td>
			<td>Switch (True/False)</td>
			<td>By default, only every fourth job is a full garbage collection job. This switch allows Full GC to be scheduled to run more frequently.</td>
		</tr>
		<tr>
			<td>InputOutputThrottle</td>
			<td>Specifies the amount of input/output throttling applied to the deduplication job. </td>
			<td>Integers 0-100 (indicates a percentage)</td>
			<td>Throttling ensures that deduplication does not interfere with other I/O intensive processes.</td>
		</tr>
		<tr>
			<td>Memory</td>
			<td>The percentage of Memory on the system that Dedup jobs should use.</td>
			<td>Integers 0-100 (indicates a percentage)</td>
			<td>To control what level of impact Dedup will have on the memory resources of the system.</td>
		</tr>
		<tr>
			<td>Name</td>
			<td>The name of the scheduled Dedup job.</td>
			<td>String</td>
			<td>A job must have a uniquely identifable name.</td>
		</tr>
		<tr>
			<td>ReadOnly</td>
			<td>Indicates that the scrubbing job processes and reports on corruptions that it finds but does not run any repair actions.</td>
			<td>Switch (True/False)</td>
			<td>You would like to manually restore (like from backup) files which sit on bad sections of the disk.</td>
		</tr>
		<tr>
			<td>Start</td>
			<td>Specifies the time a job should start.</td>
			<td>`System.DateTime`</td>
			<td>The 'date' part of the `System.Datetime` provided to 'Start' is irrelevant (as long as its in the past), but the 'time' part specifies when the job should start.</td>
		</tr>
		<tr>
			<td>StopWhenSystemBusy</td>
			<td>Specifies whether or not Dedup should back off if the system is busy.</td>
			<td>Switch (True/False)</td>
			<td>This switch gives you the desire to control Dedup's behavior - this is especially important if you desire to run Dedup while your workload is not idle.</td>
		</tr>
	</tbody>
</table>

## <a id="modifying-volume-settings"></a>Modifying Dedup Volume-wide Settings
### <a id="modifying-volume-settings-how-to-toggle"></a>Toggling Volume Settings
Dedup's volume-wide default settings are set via the [Usage Type](understanding-dedup.md#usage-type) that you select when you enable a Dedup for a volume. Dedup includes several cmdlets that make editing volume-wide settings easy:

* `Get-DedupVolume`
* `Set-DedupVolume`

The main reasons to modify the volume settings from the selected Usage Type are (1) to improve read performance for specific files (such as multimedia or other already compressed file types) and/or (2) to tune Dedup for better optimization for your specific workload. The following example shows how to modify the Dedup volume settings for a workload that most closely resembles a general purpose file server workload, but uses large files which change frequently:

1. See what the current volume settings are for Cluster Shared Volume 1 are:
	```PowerShell
	Get-DedupVolume -Volume C:\ClusterStorage\Volume1 | Select *
	```

2. Enable OptimizePartialFiles on Cluster Shared Volume 1, so that the MinimumFileAge policy applies to sections of the file rather than the whole file. This is done to make sure that the majority of the file gets optimized, even though sections of the file change regularly:
	```PowerShell
	Set-DedupVolume -Volume C:\ClusterStorage\Volume1 -OptimizePartialFiles
	```

### <a id="modifying-volume-settings-available-settings"></a>Available Volume-Wide Settings
<table>
	<thead>
		<tr>
			<th style="min-width:125px">Setting Name</th>
			<th style="min-width:125px">Definition</th>
			<th style="min-width:125px">Accepted Values</th>
			<th style="min-width:125px">Why would you want to modify this value?</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>ChunkRedundancyThreshold</td>
			<td>The number of times that a chunk is referenced before a chunk is duplicated into the "Hotspot" section of the Chunk Store. The value of the "Hotspot" section is that so-called "hot" chunks that are referenced a lot have multiple access paths to improve access time.</td>
			<td>Positive integers</td>
			<td>The main reason to modify this number is to increase the savings rate for volumes with high duplication. In general, the default value (100) is the recommended setting, and you shouldn't need to modify this.</td>
		</tr>
		<tr>
			<td>ExcludeFileType</td>
			<td>File types which are excluded from optimization.</td>
			<td>Array of file extensions</td>
			<td>Some file types, particularly multimedia or already compressed files, do not benefit very much from being optimized. This setting allows you to configure which types are excluded.</td>
		</tr>
		<tr>
			<td>ExcludeFolder</td>
			<td>Specifies folder paths which should not be considered for optimization.</td>
			<td>Array of folder paths</td>
			<td>It may be desirable, for performance, or because the content in particular paths does not benefit much from optimization, to exclude certain paths on the volume from consideration for optimization.</td>
		</tr>
		<tr>
			<td>InputOutputScale</td>
			<td>Specifies the level of IO parallelization (IO queues) for Dedup to use on a volume during a post-processing job.</td>
			<td>Positive integers ranging 1-36</td>
			<td>The main reason to modify this value is to decrease the impact on the performance of a 'high' IO workload by restricting the number of IO queues that Dedup is allowed to use on a volume. Note that modifying this setting from the default may cause Dedup's post-processing jobs to run slowly.</td>
		</tr>
		<tr>
			<td>MinimumFileAgeDays</td>
			<td>Number of days after the file is created before the file is considered to be 'in-policy' for optimization.</td>
			<td>Positive integers (inclusive of zero)</td>
			<td>The 'Default' and 'HyperV' usage types by set this value to 3 days, which is meant to maximize performance on "hot" files, or recently created files. You may want to modify this if you want Dedup to be more aggressive ('I need all the space savings I can get') or if you do not care about the extra latency associated with Dedup ('I'm on an all flash storage array').</td>
		</tr>
		<tr>
			<td>MinimumFileSize</td>
			<td>Minimum file size that a file must have to be considered 'in-policy' for optimization.</td>
			<td>Positive integers (bytes) greater than 32 KiB</td>
			<td>The main reason to change this value would be to exclude small files which may have limited optimization value in the name of conserving compute time.</td>
		</tr>
		<tr>
			<td>NoCompress</td>
			<td>Whether the Chunks should be compressed before being put into the Chunk Store.</td>
			<td>True/False</td>
			<td>Some types of files, particularly multimedia files and already compressed file types, may not compress well. This setting allows you to turn off compression for all files on the volume. This would be ideal if you are optimizing a dataset that has a lot of already compressed files, allowing you to saving the extra CPU used to compress/decompress chunks.</td>
		</tr>
		<tr>
			<td>NoCompressionFileType</td>
			<td>File types whose chunks should not be compressed before going into the Chunk Store.</td>
			<td>Array of file extensions</td>
			<td>Some types of files, particularly multimedia files and already compressed file types, may not compress well. This settings allows compression to be turned off of those files, saving the CPU resource for those file types.</td>
		</tr>
		<tr>
			<td>OptimizeInUseFiles</td>
			<td>When enabled, files which have active handles against them will be considered as 'in-policy' for optimization.</td>
			<td>True/False</td>
			<td>The main reason to enable this setting is if your workload keeps files open for extended period of times. In this scenario, without this setting enabled, a file would never get optimized if the workload has an open handle to it even if it's only occasionally appending data at the end.</td>
		</tr>
		<tr>
			<td>OptimizePartialFiles</td>
			<td>When enabled, the MinimumFileAge value applies to segments of a file rather than to the whole file.</td>
			<td>True/False</td>
			<td>The main reason to enable this setting is if your workload works with large, often edited files where most of the file content is untouched. In this scenario, without this setting enabled, this file would never get optimized because it kept getting changed, even though most of the file content is ready to be optimized.</td>
		</tr>
		<tr>
			<td>Verify</td>
			<td>When enabled, if the hash of a chunk matches a chunk we already have in our Chunk Store, the chunks is byte-by-byte compared to ensure they are identical.</td>
			<td>True/False</td>
			<td>This is an integrity feature which ensures that the hashing algorithm we use to compare chunks does not make a mistake by comparing two chunks of data which are actually different but which have the same hash. In practice, it is extremely improbable that this would ever happen. Enabling the verification feature adds significant overhead to the optimization job.</td>
		</tr>
	</tbody>
</table>

## <a id="modifying-dedup-system-settings"></a>Modifying Dedup System-wide Settings
Dedup has a few additional, system-wide settings that can be configured via [the Registry](https://technet.microsoft.com/en-us/library/cc755256(v=ws.11).aspx). These settings apply to all of the jobs that run on the system and all of the volumes that run on the system. Extra care must be given whenever editing the Registry. 

For example, you may wish to disable Full Garbage Collection. More information about why this may be useful for your scenario can be found [below](#faq-why-disable-full-gc). To edit the registry with PowerShell:

* If Dedup is running in a Cluster:
	```PowerShell
	Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\ddpsvc\Settings -Name DeepGCInterval -Type DWord -Value 0
	Set-ItemProperty -Path HKLM:\CLUSTER\Dedup -Name DeepGCInterval -Type DWord -Value 0
	```

* If Dedup is not running in a Cluster:
	```PowerShell
	Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\ddpsvc\Settings -Name DeepGCInterval -Type DWord -Value 0
	```

### <a id="modifying-dedup-system-settings-available-settings"></a>Available System-wide Settings
<table>
	<thead>
		<tr>
			<th style="min-width:125px">Setting Name</th>
			<th style="min-width:125px">Definition</th>
			<th style="min-width:125px">Accepted Values</th>
			<th style="min-width:125px">Why would you want to change this?</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>WlmMemoryOverPercentThreshold</td>
			<td>This settings allows Dedup to use more memory than Dedup judges to be available. For example, setting to 300 would mean that the job would have to use 3x the assigned memory to get canceled.</td>
			<td>Positive integers (a value of 300 means 300% or 3x)</td>
			<td>If you have another task that will back off if Dedup starts taking more memory.</td>
		</tr>
		<tr>
			<td>DeepGCInterval</td>
			<td>This setting configures the interval at which Garbage Collection jobs become [Full Garbage Collection jobs](advanced-settings.md#faq-full-v-regular-gc). A setting of n (for example 2) would mean that every n<sup>th</sup> job was a Full Garbage Collection job.</td>
			<td>Positive Integers (inclusive of zero)</td>
			<td>See [this frequently asked question](advanced-settings.md#faq-why-disable-full-gc)</td>
		</tr>
	</tbody>
</table>

## <a id="faq"></a>Frequently Asked Questions
<a id="faq-use-responsibly"></a>**I changed a Dedup setting and now Dedup jobs are slow or don't finish, or my workload performance has decreased. Why!?**  
These Dedup settings give you a lot of power to control how Dedup runs. Use it responsibly, and [monitor performance](run.md#monitoring-dedup).

<a id="faq-running-dedup-jobs-manually"></a>**I want to run a Dedup job right now, but I don't want to create a new schedule - how can I do this?**  
All Dedup jobs can be run manually with [`Start-DedupJob`](https://technet.microsoft.com/en-us/library/hh848442.aspx). Learn more [here](run.md#running-dedup-jobs-manually).

<a id="faq-full-v-regular-gc"></a>**What is the difference between *Full* and *Regular* Garbage Collection?** 
There are two types of [Garbage Collection](understand.md#job-info-gc):

- *Regular Garbage Collection* uses a statistical algorithm to find large unreferenced chunks that meet a certain criteria (low in memory and IOPs). Regular Garbage Collection compacts a chunk store container only if a minimum percentage of the chunks are unreferenced. This type of Garbage Collection runs much faster and uses much less resources than Full Garbage Collection. The default schedule of the Regular Garbage Collection job is to run once a week.
- *Full Garbage Collection* does a much more thorough job finding unreferenced Dedup chunks and freeing more disk space. Full Garbage Collection compacts every container even if just a single chunk in the container is unreferenced. Full Garbage Collection will also free space that may have been in use if there was a crash or power failure during an optimization job. Full Garbage Collection jobs will recover 100% of the available space that can be recovered on a deduplicated volume at the cost of requiring more time and system resources compared to a Regular Garbage Collection job. The Full Garbage Collection job will typically find and release up to ~5% more of the unreferenced data than a Regular GC job. The default schedule of the Full GC job is to run every 4th time Garbage Collection is scheduled.

<a id="faq-why-disable-full-gc"></a>**Why would I want to disable Full Garbage Collection?**  
Reasons to avoid running a regular scheduled Full GC job:

- Because Full GC creates more churn, this could adversely impact the volume’s shadow copies life-time and the size of incremental backup. High churn or I/O intensive deduplication workloads may see large degradation in performance by Full GC jobs.
- A Full Garbage Collection job can be always run manually from PowerShell to clean up leaks if you know your system crashed.