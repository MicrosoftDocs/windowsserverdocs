---
title: Install and Configure Data Deduplication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 333e7fe9-8f3b-4003-9dd6-bf58382ff5de
author: JasonGerend
---
# Install and Configure Data Deduplication
This document explains how to set up a server, enable data deduplication, optimize a volume, and carry out advanced deduplication operations.  
  
**In this document**  
  
-   [Prerequisites](../deduplication/../deduplication/Install-and-Configure-Data-Deduplication.md#Prereq)  
  
-   [Step 1: Set up the server](../deduplication/../deduplication/Install-and-Configure-Data-Deduplication.md#BKMK_OVER)  
  
-   [Step 2: Enable data deduplication](#BKMK_Enable)  
  
-   [Step 3: Set data deduplication jobs](#BKMK_JOBS)  
  
-   [Step 4: Set data deduplication schedules](#BkmkDedupSched)  
  
## <a name="Prereq"></a>Prerequisites  
Before installing and configuring Data Deduplication, review the following resources:  
  
-   [Plan to Deploy Data Deduplication](../deduplication/Plan-to-Deploy-Data-Deduplication.md)  
  
-   [Backup and Restore Considerations for Deduplicated Volumes](../deduplication/Backup-and-Restore-Considerations-for-Deduplicated-Volumes.md)  
  
-   [Data Deduplication Interoperability](../deduplication/Data-Deduplication-Interoperability.md)  
  
## <a name="BKMK_OVER"></a>Step 1: Set up the server  
  
#### To install deduplication components on the server by using Server Manager  
  
1.  From the Add Roles and Features Wizard, under Server Roles, select **File and Storage Services** \(if it has not already been installed\).  
  
2.  Select the **File Services** check box, and then select the **Data Deduplication** check box.  
  
3.  Click **Next** until the **Install** button is active, and then click **Install**.  
  
#### To install deduplication components on the server by using Windows PowerShell  
  
1.  Start Windows PowerShell. Right\-click the Windows PowerShell icon on the taskbar, and then click **Run as Administrator**.  
  
2.  Run the following Windows PowerShell commands:  
  
    ```powershell  
    Import-Module ServerManager  
    Add-WindowsFeature -name FS-Data-Deduplication  
    Import-Module Deduplication  
    ```  
  
## <a name="BKMK_Enable"></a>Step 2: Enable data deduplication  
  
#### To enable data deduplication by using Server Manager  
  
1.  From the Server Manager dashboard, right\-click a data volume and choose **Configure Data Deduplication**. The Deduplication Settings page appears.  
  
2.  Enable data Deduplication.  
  
    **On  Windows Server 2012 R2 :** In the **Data deduplication** box, select the workload you want to host on the volume. Select **General purpose file server** for general data files or **Virtual Desktop Infrastructure \(VDI\) server** when configuring storage for running virtual machines.  
  
    **On  Windows Server 2012 :** Select the **Enable data deduplication** check box  
  
3.  Enter the number of days that should elapse from the date of file creation until files are deduplicated, enter the extensions of any file types that should not be deduplicated, and then click **Add** to browse to any folders with files that should not be deduplicated.  
  
4.  Click **Apply** to apply these settings and return to the Server Manager dashboard, or click the **Set Deduplication Schedule** button to continue to set up a schedule for deduplication.  
  
#### To enable data deduplication by using Windows PowerShell  
  
1.  To enable deduplication on a volume, run the following Windows PowerShell command on the server. In this example deduplication is enabled on volume E.  
  
    **On  Windows Server 2012 R2 :**  
  
    ```powershell  
    Enable-DedupVolume E: -UsageType HyperV  
    Enable-DedupVolume E: -UsageType Default  
    ```  
  
    **On  Windows Server 2012 :**  
  
    ```powershell  
    Enable-DedupVolume E:  
    ```  
  
2.  Optionally, set the minimum number of days that must pass before a file is deduplicated by using the following command.  
  
    ```powershell  
    Set-Dedupvolume E: -MinimumFileAgeDays 20  
    ```  
  
    If you set MinimumFileAgeDays to 0, deduplication will process all files, regardless of their age. This is suitable for a test environment, where you want to exercise maximum deduplication. In a production environment, however, it is preferable to wait for a number of days \(the default is three days in  Windows Server 2012 R2  and five days in  Windows Server 2012 \), because files tend to change a lot for a brief period of time before the change rate slows. This allows for the most efficient use of your server resources.  
  
**To return a list of the volumes that have been enabled for data deduplication by using Windows PowerShell**  
  
Run the following Windows PowerShell commands on the server.  
  
```powershell  
Get-DedupVolume  
Get-DedupVolume | format-list  
```  
  
The first command returns summary information and the second returns details about the volume data deduplication settings.  
  
## <a name="BKMK_LINKS"></a>  
## <a name="BKMK_JOBS"></a>Step 3: Set data deduplication jobs  
Data deduplication jobs can be run on demand \(manually\) or scheduled. There are three types of jobs that you can perform on a volume: Optimization, Data Scrubbing, and Garbage Collection.  
  
### <a name="BkmkOptJobs"></a>Optimization jobs  
The Data Deduplication feature comes with built\-in jobs that will automatically launch and optimize the specified volume\(s\) on a regular basis. Optimization jobs deduplicate data and compress file chunks on a volume per the policy settings. After the initial optimization is complete, optimization jobs run on the files that are included in the policies, according to the job schedules that you have configured or the default job schedules that ship with the product.  
  
You can trigger an optimization job on demand in Windows PowerShell by using the **Start\-DedupJob** cmdlet. For example:  
  
```powershell  
Start-DedupJob –Volume E: –Type Optimization  
```  
  
This command returns immediately and the job is launched asynchronously. If you want the job to complete at a later time , add the –wait parameter, like this:  
  
```powershell  
Start-DedupJob E: –Type Optimization -Wait  
```  
  
You can query the progress of the job on the volume by using the **Get\-DedupJob** cmdlet:  
  
```powershell  
Get-DedupJob  
```  
  
The **Get\-DedupJob** command show current jobs that are running or are queued to run.  
  
You can query the key status statistics including the achieved savings on the volume by using the **Get\-DedupStatus** cmdlet:  
  
```powershell  
Get-DedupStatus | Format-List  
```  
  
The **Get\-DedupStatus** command shows the free space, space saved, optimized files, InPolicyfiles \(the number of files that fall within the volume deduplication policy, based on the defined file age, size, type, and location criteria\), and the associated drive identifier.  
  
> [!NOTE]  
> You can also view the deduplication savings in Server Manager on the Volumes page. From Server Manager, click **File Services**, and then click **Volumes**. Right\-click the column heading to add **Deduplication Savings**.  
  
**Optimization job queuing**  
  
Optimization jobs are started in the following order:  
  
1.  **Preemptive \(manually run jobs that are not scheduled\)**  
  
    Any manual jobs that include the **–Preempt** option will terminate any jobs that are currently running, and start immediately. \(Note that the **–Preempt** option is ignored in scheduled jobs.\)  
  
2.  **StopWhenSystemBusy parameter**  
  
    Jobs that contain this parameter will stop if resources are not available to run the job without interfering with the server’s workload.  
  
3.  **Priority**  
  
    Among jobs that do not have the same **StopWhenSystemBusy** setting, high priority jobs are queued first, normal jobs are queued second, and low priority job are queued last.  
  
4.  **Manual or scheduled**  
  
    Manual jobs are queued before scheduled jobs.  
  
Memory settings are not considered as part of the optimization job queue algorithm.  
  
**Optimization metadata**  
  
Metadata provides you with evidence about savings that you gleaned from using optimization. There are three cmdlets that output this metadata: **Update\-DedupStatus**, **Get\-DedupMetadata**, and **Measure\-DedupFileMetadata**. This metadata can help you assess the impact of some optimization configuration options.  
  
**Update\-DedupStatus** returns the following metadata:  
  
|Metadata|What it indicates|  
|------------|---------------------|  
|**DedupSavedSpace**|Difference between the logical size of the optimized files and the logical size of the store \(the deduplicated user data plus deduplication metadata\). This number changes continually.|  
|**DedupRate**|Ratio of DedupSavedSpace to the logical size of all of the files on the volume, and it is expressed as a percentage. This number changes continually.|  
|**OptimizedFilesCount**|Number of optimized files on the specified volume. Note that this number will remain steady \(instead of decrease\) as users delete files from or add files to the volume, until you run a Garbage Collection job. This count is most accurate after a full garbage collection job runs.|  
|**OptimizedFilesSize**|Aggregate size of all optimized files on the specified volume. Note that this number remains steady \(instead of decreasing\) as users delete files from or add new files to the volume, until you run a garbage collection job. This number is most accurate after a full garbage collection job runs.|  
|**InPolicyFilesCount**|Number of files that currently qualify for optimization. This number stays relatively constant between optimization jobs.|  
|**InPolicyFilesSize**|Aggregate size of all files that currently qualify for optimization. This number stays relatively constant between optimization jobs.|  
|**LastOptimizationTime**|Date and time when an optimization job was last run on the specified volume. This date and time stays constant between optimization jobs.|  
|**LastGarbageCollectionTime**|Date and time when a garbage collection job was run last on the specified volume. This date and time stays constant between optimization jobs.|  
|**LastScrubbingTime**|Date and time when a scrubbing job was run last on the specified volume. This date and time stays constant between optimization jobs.|  
  
**Get\-DedupMetadata** returns the following metadata:  
  
|Metadata|What it indicates|  
|------------|---------------------|  
|**DataChunkCount**|Number of data chunks on the volume.|  
|**DataContainerCount**|Number of containers in the data store.|  
|**DataChunkAverageSize**|Data store size \(not including chunk metadata\) divided by the total number of data chunks in the data store.|  
|**StreamMapCount**|Number of data streams on the volume.|  
|**StreamMapContainerCount**|Number of containers in the stream map store.|  
|**StreamMapAverageChunkCount**|Stream map store size divided by the total number of streams in the store.|  
|**HotspotCount**|Number of “hotspot” chunks on the volume. A hotspot is a chunk that is referenced over 100 times. All hotspot chunks are duplicated on the volume to provide automatic data corruption recovery in the event that corruption occurs on the disk and impacts one of these popular chunks.|  
|**HotspotContainerCount**|Number of hotspot containers.|  
|**CorruptionLogEntryCount**|Number of corrupted items on the volume.|  
  
### <a name="BkmkDataScrubJobs"></a>Data Scrubbing jobs  
Data Deduplication has built\-in data integrity features such as checksum validation and metadata consistency checking. It also has built\-in redundancy for critical metadata and the most popular data chunks. As data is accessed or jobs process data, these features may encounter corruption, and they will record the corruption in a log file. Scrubbing jobs use these features to analyze the chunk store corruption logs, and when possible, to make repairs. Possible repair operations include using three sources of redundant data:  
  
1.  Deduplication keeps backup copies of popular chunks when they are referenced over 100 times in an area called the hotspot. If the working copy is corrupted, deduplication will use the backup.  
  
2.  When using Storage Spaces in a mirrored configuration, deduplication can use the mirror image of the redundant chunk to serve the I\/O and fix the corruption.  
  
3.  If a file is processed with a chunk that is corrupted, the corrupted chunk is eliminated, and the new incoming chunk is used to fix the corruption.  
  
Scrubbing jobs output a summary report in the Windows event log located here:  
  
**Event Viewer\\Applications and Services Logs\\Microsoft\\Windows\\Deduplication\\Scrubbing**  
  
Data Deduplication defaults create a data integrity scrubbing job on a weekly basis, but you can also trigger one on demand by using the following command:  
  
```powershell  
Start-DedupJob E: –Type Scrubbing  
```  
  
This initiates a job that attempts to repair all corruptions that were logged in to the deduplication internal corruption log, during the I\/O to deduplication files. To check the data integrity of all the deduplicated data on the volume, use the **\-full** parameter:  
  
```powershell  
Start-DedupJob E: –Type Scrubbing -full  
```  
  
Also known as Deep Scrubbing, the **\-full** parameter will scrub the entire set of deduplicated data and look for all corruptions that are causing data access failures.  
  
### <a name="BkmkGarbageJobs"></a>Garbage Collection jobs  
Data Deduplication includes garbage collection jobs to process deleted or modified data on the volume so that any data chunks no longer referenced are cleaned up. Garbage collection jobs process previously deleted or logically overwritten optimized content to create usable volume free space. When an optimized file is deleted or overwritten by new data, the old data in the chunk store is not immediately deleted.  
  
> [!NOTE]  
> Garbage collection is a processing\-intensive operation, so you should allow the deletion load to reach a threshold and then manually run this job type, or schedule it for off hours.  
  
Garbage collection can also be triggered on demand. For example:  
  
```powershell  
Start-DedupJob E: –Type GarbageCollection  
```  
  
This command removes unreferenced chunks and compacts containers that have more than 5% unreferenced data. By adding the **–full** parameter, the job will compact all containers to the maximum extent possible. For example:  
  
```powershell  
Start-DedupJob E: –Type GarbageCollection -full  
```  
  
### <a name="BkmkDedupSched"></a>Step 4: Set data deduplication schedules  
Data Deduplication comes with three schedules that are set up immediately. Optimization runs every hour, and Garbage Collection and Scrubbing are set for once a week. You can view the schedules by using this Windows PowerShell command:  
  
```powershell  
Get-DedupSchedule  
```  
  
**Enabled    Type               StartTime              Days               Name\-\-\-\-\-\-\-    \-\-\-\-               \-\-\-\-\-\-\-\-\-              \-\-\-\-               \-\-\-\-True       Optimization                                                 BackgroundOptimizationTrue       GarbageCollection  2:45 AM                Saturday           WeeklyGarbageCollectionTrue       Scrubbing          3:45 AM                Saturday           WeeklyScrubbing**Two additional schedules can be used immediately to add jobs. These job schedules run on all volumes on the server. If you want to run a job only on a particular volume, you must create a new job. You can create, modify, or view job schedules from the **Deduplication Settings** page in Server Manager, or by using the following Windows PowerShell commands:  
  
```powershell  
Set-DedupSchedule <ScheduleName> <properties>  
Remove-DedupSchedule <ScheduleName>  
```  
  
> [!NOTE]  
> Deduplication only supports weekly job scheduling. If you want to create a schedule for a monthly job or any other time period, use Windows Task Scheduler. However, you will be unable to view custom job schedules that are created or modified with Task Scheduler by using the **Get\-DedupSchedule** cmdlet. Such schedules are not migrated with server upgrades.  
  
The built\-in job schedules that Data Deduplication handles are:  
  
-   **BackgroundModeOptimization** Use this job schedule to run an Optimization job with the following parameters:  
  
    |Parameter|Value|  
    |-------------|---------|  
    |Enabled|True|  
    |Priority|Low|  
    |Memory|25|  
    |ContinueWhenSystemBusy|False|  
    |ScheduledTask|Microsoft\\Windows\\Deduplication\\BackgroundModeOptimization|  
    |Start|00:00:00|  
    |Days|{Mon,Tues,Wed,Thurs,Fri,Sat,Sun}|  
    |Duration|0|  
    |Repeat|1|  
  
-   **ThroughputModeOptimization** Use this job schedule to run an Optimization job with the following parameters:  
  
    |Parameter|Value|  
    |-------------|---------|  
    |Enabled|False|  
    |Priority|Normal|  
    |Memory|50|  
    |ContinueWhenSystemBusy|False|  
    |ScheduledTask|Microsoft\\Windows\\Deduplication\\ThroughputModeOptimization|  
    |Start|00:00:00|  
    |Days|{Mon,Tues,Wed,Thurs,Fri,Sat,Sun}|  
    |Duration|4|  
    |Repeat|0|  
  
-   **ThroughputModeOptimization2**  Use this job schedule to run an Optimization job with the following parameters:  
  
    |Parameter|Value|  
    |-------------|---------|  
    |Enabled|False|  
    |Priority|Normal|  
    |Memory|50|  
    |ContinueWhenSystemBusy|False|  
    |ScheduledTask|Microsoft\\Windows\\Deduplication\\ThroughputModeOptimization|  
    |Start|00:00:00|  
    |Days|{Mon,Tues,Wed,Thurs,Fri,Sat,Sun}|  
    |Duration|4|  
    |Repeat|0|  
  
-   **WeeklyGarbageCollection** This default setting is scheduled to run a Garbage Collection job with the following parameters:  
  
    |Parameter|Value|  
    |-------------|---------|  
    |Enabled|True|  
    |Priority|Normal|  
    |Memory|50|  
    |ContinueWhenSystemBusy|False|  
    |ScheduledTask|Microsoft\\Windows\\Deduplication\\WeeklyGarbageCollection|  
    |Start|01:45:00|  
    |Days|{Sat}|  
    |Duration|0|  
    |Repeat|0|  
  
-   **WeeklyScrubbing** Use this job schedule to run a Scrubbing job with the following parameters:  
  
    |Parameter|Value|  
    |-------------|---------|  
    |Enabled|True|  
    |Priority|Normal|  
    |Memory|50|  
    |ContinueWhenSystemBusy|False|  
    |ScheduledTask|Microsoft\\Windows\\Deduplication\\WeeklyScrubbing|  
    |Start|02:45:00|  
    |Days|{Sat}|  
    |Duration|0|  
    |Repeat|0|  
  
**Operational considerations**  
  
Some files cannot be read when the free disk space on a deduplicated volume approaches zero. To resolve this issue, do one of the following:  
  
-   Run a Garbage Collection task to reclaim disk space.  
  
-   Copy files elsewhere \(if there is not a recent memory map of the files\).  
  
-   Run Robocopy.exe in non\-cached Read mode to copy files elsewhere \(if there is a recent memory map of the files\). For more information about using Robocopy, see [Robocopy \[LH\]](Robocopy.md).  
  
**Advanced deduplication policy considerations**  
  
With some server configurations, you may want to speed up deduplication. Here are some scenarios that might warrant additional job scheduling:  
  
|Condition|Action to consider|  
|-------------|----------------------|  
|Significant incoming data|Add additional throughput optimization jobs.|  
|More volumes than CPU core processors with significant incoming data|Add additional throughput optimization jobs.|  
|Data deletions exceed 50 GB per hour, and you want to get the free space back as quickly as possible.|Add additional garbage collection jobs to reclaim the free space.|  
  

