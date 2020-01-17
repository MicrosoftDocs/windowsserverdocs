---
ms.assetid: 01c8cece-66ce-4a83-a81e-aa6cc98e51fc
title: Advanced Data Deduplication settings
ms.prod: windows-server
ms.technology: storage-deduplication
ms.topic: article
author: wmgries
manager: klaasl
ms.author: wgries
ms.date: 09/15/2016
---
# Advanced Data Deduplication settings

> Applies to Windows Server (Semi-Annual Channel), Windows Server 2016

This document describes how to modify advanced [Data Deduplication](overview.md) settings. For [recommended workloads](install-enable.md#enable-dedup-candidate-workloads), the default settings should be sufficient. The main reason to modify these settings is to improve Data Deduplication's performance with other kinds of workloads.

## <a id="modifying-job-schedules"></a>Modifying Data Deduplication job schedules
The [default Data Deduplication job schedules](understand.md#job-info) are designed to work well for recommended workloads and be as non-intrusive as possible (excluding the *Priority Optimization* job that is enabled for the [**Backup** usage type](understand.md#usage-type-backup)). When workloads have large resource requirements, it is possible to ensure that jobs run only during idle hours, or to reduce or increase the amount of system resources that a Data Deduplication job is allowed to consume.

### <a id="modifying-job-schedules-change-schedule"></a>Changing a Data Deduplication schedule
Data Deduplication jobs are scheduled via Windows Task Scheduler and can be viewed and edited there under the path Microsoft\Windows\Deduplication. Data Deduplication includes several cmdlets that make scheduling easy.
* [`Get-DedupSchedule`](https://technet.microsoft.com/library/hh848446.aspx) shows the current scheduled jobs.
* [`New-DedupSchedule`](https://technet.microsoft.com/library/hh848445.aspx) creates a new scheduled job.
* [`Set-DedupSchedule`](https://technet.microsoft.com/library/hh848447.aspx) modifies an existing scheduled job.
* [`Remove-DedupSchedule`](https://technet.microsoft.com/library/hh848451.aspx) removes a scheduled job.

The most common reason for changing when Data Deduplication jobs run is to ensure that jobs run during off hours. The following step-by-step example shows how to modify the Data Deduplication schedule for a *sunny day* scenario: a hyper-converged Hyper-V host that is idle on weekends and after 7:00 PM on weeknights. To change the schedule, run the following PowerShell cmdlets in an Administrator context.

1. Disable the scheduled hourly [Optimization](understand.md#job-info-optimization) jobs.  
	```PowerShell
	Set-DedupSchedule -Name BackgroundOptimization -Enabled $false
	Set-DedupSchedule -Name PriorityOptimization -Enabled $false
    ```

2. Remove the currently scheduled [Garbage Collection](understand.md#job-info-gc) and [Integrity Scrubbing](understand.md#job-info-scrubbing) jobs.
	```PowerShell
	Get-DedupSchedule -Type GarbageCollection | ForEach-Object { Remove-DedupSchedule -InputObject $_ }
	Get-DedupSchedule -Type Scrubbing | ForEach-Object { Remove-DedupSchedule -InputObject $_ }
    ```

3. Create a nightly Optimization job that runs at 7:00 PM with high priority and all the CPUs and memory available on the system.
	```PowerShell
	New-DedupSchedule -Name "NightlyOptimization" -Type Optimization -DurationHours 11 -Memory 100 -Cores 100 -Priority High -Days @(1,2,3,4,5) -Start (Get-Date "2016-08-08 19:00:00")
    ```

	>[!NOTE]  
	> The *date* part of the `System.Datetime` provided to `-Start` is irrelevant (as long as it's in the past), but the *time* part specifies when the job should start.
4. Create a weekly Garbage Collection job that runs on Saturday starting at 7:00 AM with high priority and all the CPUs and memory available on the system.
	```PowerShell
	New-DedupSchedule -Name "WeeklyGarbageCollection" -Type GarbageCollection -DurationHours 23 -Memory 100 -Cores 100 -Priority High -Days @(6) -Start (Get-Date "2016-08-13 07:00:00")
    ```

5. Create a weekly Integrity Scrubbing job that runs on Sunday starting at 7 AM with high priority and all the CPUs and memory available on the system.
	```PowerShell
	New-DedupSchedule -Name "WeeklyIntegrityScrubbing" -Type Scrubbing -DurationHours 23 -Memory 100 -Cores 100 -Priority High -Days @(0) -Start (Get-Date "2016-08-14 07:00:00")
    ```

### <a id="modifying-job-schedules-available-settings"></a>Available job-wide settings
You can toggle the following settings for new or scheduled Data Deduplication jobs:

<table>
	<thead>
		<tr>
			<th style="min-width:125px">Parameter name</th>
			<th>Definition</th>
			<th>Accepted values</th>
			<th>Why would you want to set this value?</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>Type</td>
			<td>The type of the job that should be scheduled</td>
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
			<td>The system priority of the scheduled job</td>
			<td>
				<ul>
					<li>High</li>
					<li>Medium</li>
					<li>Low</li>
				</ul>
			</td>
            <td>This value helps the system determine how to allocate CPU time. <em>High</em> will use more CPU time, <em>low</em> will use less.</td>
		</tr>
		<tr>
			<td>Days</td>
			<td>The days that the job is scheduled</td>
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
			<td>The percentage of cores on the system that a job should use</td>
			<td>Integers 0-100 (indicates a percentage)</td>
			<td>To control what level of impact a job will have on the compute resources on the system</td>
		</tr>
		<tr>
			<td>DurationHours</td>
			<td>The maximum number of hours a job should be allowed to run</td>
			<td>Positive integers</td>
            <td>To prevent a job for running into a workload&#39;s non-idle hours</td>
		</tr>
		<tr>
			<td>Enabled</td>
			<td>Whether the job will run</td>
			<td>True/false</td>
			<td>To disable a job without removing it</td>
		</tr>
		<tr>
			<td>Full</td>
			<td>For scheduling a full Garbage Collection job</td>
			<td>Switch (true/false)</td>
			<td>By default, every fourth job is a full Garbage Collection job. With this switch, you can schedule full Garbage Collection to run more frequently.</td>
		</tr>
		<tr>
			<td>InputOutputThrottle</td>
			<td>Specifies the amount of input/output throttling applied to the job</td>
			<td>Integers 0-100 (indicates a percentage)</td>
            <td>Throttling ensures that jobs don&#39;t interfere with other I/O-intensive processes.</td>
		</tr>
		<tr>
			<td>Memory</td>
			<td>The percentage of memory on the system that a job should use</td>
			<td>Integers 0-100 (indicates a percentage)</td>
			<td>To control what level of impact the job will have on the memory resources of the system</td>
		</tr>
		<tr>
			<td>Name</td>
			<td>The name of the scheduled job</td>
			<td>String</td>
			<td>A job must have a uniquely identifiable name.</td>
		</tr>
		<tr>
			<td>ReadOnly</td>
			<td>Indicates that the scrubbing job processes and reports on corruptions that it finds, but does not run any repair actions</td>
			<td>Switch (true/false)</td>
			<td>You want to manually restore files that sit on bad sections of the disk.</td>
		</tr>
		<tr>
			<td>Start</td>
			<td>Specifies the time a job should start</td>
            <td><code>System.DateTime</code></td>
            <td>The <em>date</em> part of the <code>System.Datetime</code> provided to <em>Start</em> is irrelevant (as long as it&#39;s in the past), but the <em>time</em> part specifies when the job should start.</td>
		</tr>
		<tr>
			<td>StopWhenSystemBusy</td>
			<td>Specifies whether Data Deduplication should stop if the system is busy</td>
			<td>Switch (True/False)</td>
			<td>This switch gives you the ability to control the behavior of Data Deduplication--this is especially important if you want to run Data Deduplication while your workload is not idle.</td>
		</tr>
	</tbody>
</table>

## <a id="modifying-volume-settings"></a>Modifying Data Deduplication volume-wide settings
### <a id="modifying-volume-settings-how-to-toggle"></a>Toggling volume settings
You can set the volume-wide default settings for Data Deduplication via the [usage type](understand.md#usage-type) that you select when you enable a deduplication for a volume. Data Deduplication includes cmdlets that make editing volume-wide settings easy:

* [`Get-DedupVolume`](https://technet.microsoft.com/library/hh848448.aspx)
* [`Set-DedupVolume`](https://technet.microsoft.com/library/hh848438.aspx)

The main reasons to modify the volume settings from the selected usage type are to improve read performance for specific files (such as multimedia or other file types that are already compressed) or to fine-tune Data Deduplication for better optimization for your specific workload. The following example shows how to modify the Data Deduplication volume settings for a workload that most closely resembles a general purpose file server workload, but uses large files that change frequently.

1. See the current volume settings for Cluster Shared Volume 1.
	```PowerShell
	Get-DedupVolume -Volume C:\ClusterStorage\Volume1 | Select *
    ```

2. Enable OptimizePartialFiles on Cluster Shared Volume 1 so that the MinimumFileAge policy applies to sections of the file rather than the whole file. This ensures that the majority of the file gets optimized even though sections of the file change regularly.
	```PowerShell
	Set-DedupVolume -Volume C:\ClusterStorage\Volume1 -OptimizePartialFiles
    ```

### <a id="modifying-volume-settings-available-settings"></a>Available volume-wide settings
<table>
	<thead>
		<tr>
			<th style="min-width:125px">Setting name</th>
			<th>Definition</th>
			<th>Accepted values</th>
			<th>Why would you want to modify this value?</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>ChunkRedundancyThreshold</td>
            <td>The number of times that a chunk is referenced before a chunk is duplicated into the hotspot section of the Chunk Store. The value of the hotspot section is that so-called &quot;hot&quot; chunks that are referenced frequently have multiple access paths to improve access time.</td>
			<td>Positive integers</td>
            <td>The main reason to modify this number is to increase the savings rate for volumes with high duplication. In general, the default value (100) is the recommended setting, and you shouldn&#39;t need to modify this.</td>
		</tr>
		<tr>
			<td>ExcludeFileType</td>
			<td>File types that are excluded from optimization</td>
			<td>Array of file extensions</td>
			<td>Some file types, particularly multimedia or files that are already compressed, do not benefit very much from being optimized. This setting allows you to configure which types are excluded.</td>
		</tr>
		<tr>
			<td>ExcludeFolder</td>
			<td>Specifies folder paths that should not be considered for optimization</td>
			<td>Array of folder paths</td>
			<td>If you want to improve performance or keep content in particular paths from being optimized, you can exclude certain paths on the volume from consideration for optimization.</td>
		</tr>
		<tr>
			<td>InputOutputScale</td>
			<td>Specifies the level of IO parallelization (IO queues) for Data Deduplication to use on a volume during a post-processing job</td>
			<td>Positive integers ranging 1-36</td>
            <td>The main reason to modify this value is to decrease the impact on the performance of a high IO workload by restricting the number of IO queues that Data Deduplication is allowed to use on a volume. Note that modifying this setting from the default may cause Data Deduplication&#39;s post-processing jobs to run slowly.</td>
		</tr>
		<tr>
			<td>MinimumFileAgeDays</td>
			<td>Number of days after the file is created before the file is considered to be in-policy for optimization.</td>
			<td>Positive integers (inclusive of zero)</td>
            <td>The <strong>Default</strong> and <strong>HyperV</strong> usage types set this value to 3 to maximize performance on hot or recently created files. You may want to modify this if you want Data Deduplication to be more aggressive or if you do not care about the extra latency associated with deduplication.</td>
		</tr>
		<tr>
			<td>MinimumFileSize</td>
			<td>Minimum file size that a file must have to be considered in-policy for optimization</td>
			<td>Positive integers (bytes) greater than 32 KB</td>
			<td>The main reason to change this value is to exclude small files that may have limited optimization value to conserve compute time.</td>
		</tr>
		<tr>
			<td>NoCompress</td>
			<td>Whether the chunks should be compressed before being put into the Chunk Store</td>
			<td>True/False</td>
			<td>Some types of files, particularly multimedia files and already compressed file types, may not compress well. This setting allows you to turn off compression for all files on the volume. This would be ideal if you are optimizing a dataset that has a lot of files that are already compressed.</td>
		</tr>
		<tr>
			<td>NoCompressionFileType</td>
			<td>File types whose chunks should not be compressed before going into the Chunk Store</td>
			<td>Array of file extensions</td>
			<td>Some types of files, particularly multimedia files and already compressed file types, may not compress well. This setting allows compression to be turned off for those files, saving CPU resources.</td>
		</tr>
		<tr>
			<td>OptimizeInUseFiles</td>
			<td>When enabled, files that have active handles against them will be considered as in-policy for optimization.</td>
			<td>True/false</td>
            <td>Enable this setting if your workload keeps files open for extended periods of time. If this setting is not enabled, a file would never get optimized if the workload has an open handle to it, even if it&#39;s only occasionally appending data at the end.</td>
		</tr>
		<tr>
			<td>OptimizePartialFiles</td>
			<td>When enabled, the MinimumFileAge value applies to segments of a file rather than to the whole file.</td>
			<td>True/false</td>
			<td>Enable this setting if your workload works with large, often edited files where most of the file content is untouched. If this setting is not enabled, these files would never get optimized because they keep getting changed, even though most of the file content is ready to be optimized.</td>
		</tr>
		<tr>
			<td>Verify</td>
			<td>When enabled, if the hash of a chunk matches a chunk we already have in our Chunk Store, the chunks are compared byte-by-byte to ensure they are identical.</td>
			<td>True/false</td>
			<td>This is an integrity feature that ensures that the hashing algorithm that compares chunks does not make a mistake by comparing two chunks of data that are actually different but have the same hash. In practice, it is extremely improbable that this would ever happen. Enabling the verification feature adds significant overhead to the optimization job.</td>
		</tr>
	</tbody>
</table>

## <a id="modifying-dedup-system-settings"></a>Modifying Data Deduplication system-wide settings
Data Deduplication has additional system-wide settings that can be configured via [the registry](https://technet.microsoft.com/library/cc755256(v=ws.11).aspx). These settings apply to all of the jobs and volumes that run on the system. Extra care must be given whenever editing the registry.

For example, you may want to disable full Garbage Collection. More information about why this may be useful for your scenario can be found in [Frequently asked questions](#faq-why-disable-full-gc). To edit the registry with PowerShell:

* If Data Deduplication is running in a cluster:
	```PowerShell
	Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\ddpsvc\Settings -Name DeepGCInterval -Type DWord -Value 0xFFFFFFFF
	Set-ItemProperty -Path HKLM:\CLUSTER\Dedup -Name DeepGCInterval -Type DWord -Value 0xFFFFFFFF
    ```

* If Data Deduplication is not running in a cluster:
	```PowerShell
	Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\ddpsvc\Settings -Name DeepGCInterval -Type DWord -Value 0xFFFFFFFF
    ```

### <a id="modifying-dedup-system-settings-available-settings"></a>Available system-wide settings
<table>
	<thead>
		<tr>
			<th style="min-width:125px">Setting name</th>
			<th>Definition</th>
			<th>Accepted values</th>
			<th>Why would you want to change this?</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>WlmMemoryOverPercentThreshold</td>
			<td>This setting allows jobs to use more memory than Data Deduplication judges to actually be available. For example, a setting of 300 would mean that the job would have to use three times the assigned memory to get canceled.</td>
			<td>Positive integers (a value of 300 means 300% or 3 times)</td>
			<td>If you have another task that will stop if Data Deduplication takes more memory</td>
		</tr>
		<tr>
			<td>DeepGCInterval</td>
            <td>This setting configures the interval at which regular Garbage Collection jobs become <a href="advanced-settings.md#faq-full-v-regular-gc" data-raw-source="[full Garbage Collection jobs](advanced-settings.md#faq-full-v-regular-gc)">full Garbage Collection jobs</a>. A setting of n would mean that every n<sup>th</sup> job was a full Garbage Collection job. Note that full Garbage Collection is always disabled (regardless of the registry value) for volumes with the <a href="understand.md#usage-type-backup" data-raw-source="[Backup Usage Type](understand.md#usage-type-backup)">Backup Usage Type</a>. <code>Start-DedupJob -Type GarbageCollection -Full</code> may be used if full Garbage Collection is desired on a Backup volume.</td>
			<td>Integers (-1 indicates disabled)</td>
            <td>See <a href="advanced-settings.md#faq-why-disable-full-gc" data-raw-source="[this frequently asked question](advanced-settings.md#faq-why-disable-full-gc)">this frequently asked question</a></td>
		</tr>
	</tbody>
</table>

## <a id="faq"></a>Frequently asked questions
<a id="faq-use-responsibly"></a>**I changed a Data Deduplication setting, and now jobs are slow or don't finish, or my workload performance has decreased. Why?**  
These settings give you a lot of power to control how Data Deduplication runs. Use them responsibly, and [monitor performance](run.md#monitoring-dedup).

<a id="faq-running-dedup-jobs-manually"></a>**I want to run a Data Deduplication job right now, but I don't want to create a new schedule--can I do this?**  
Yes, [all jobs can be run manually](run.md#running-dedup-jobs-manually).

<a id="faq-full-v-regular-gc"></a>**What is the difference between full and regular Garbage Collection?**  
There are two types of [Garbage Collection](understand.md#job-info-gc):

- *Regular Garbage Collection* uses a statistical algorithm to find large unreferenced chunks that meet a certain criteria (low in memory and IOPs). Regular Garbage Collection compacts a chunk store container only if a minimum percentage of the chunks are unreferenced. This type of Garbage Collection runs much faster and uses fewer resources than full Garbage Collection. The default schedule of the regular Garbage Collection job is to run once a week.
- *Full Garbage Collection* does a much more thorough job of finding unreferenced chunks and freeing more disk space. Full Garbage Collection compacts every container even if just a single chunk in the container is unreferenced. Full Garbage Collection will also free space that may have been in use if there was a crash or power failure during an Optimization job. Full Garbage Collection jobs will recover 100 percent of the available space that can be recovered on a deduplicated volume at the cost of requiring more time and system resources compared to a regular Garbage Collection job. The full Garbage Collection job will typically find and release up to 5 percent more of the unreferenced data than a regular Garbage Collection job. The default schedule of the full Garbage Collection job is to run every fourth time Garbage Collection is scheduled.

<a id="faq-why-disable-full-gc"></a>**Why would I want to disable full Garbage Collection?**  
- Garbage Collection could adversely affect the volume's lifetime shadow copies and the size of incremental backup. High churn or I/O-intensive workloads may see a degradation in performance by full Garbage Collection jobs.           
- You can manually run a full Garbage Collection job from PowerShell to clean up leaks if you know your system crashed.
