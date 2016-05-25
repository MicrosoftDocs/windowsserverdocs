---
title: Monitor Storage Tiers Performance in Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c8c07015-3e0e-48be-b4c4-e58dabf39553
author: JasonGerend
---
# Monitor Storage Tiers Performance in Windows Server 2012 R2
To make sure your storage tiers are optimizing performance of your storage spaces efficiently in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you should evaluate the performance of your storage configuration after a few days, when your workloads have run long enough to become established and predictable, and then check a few simple data points each week in a Storage Tier Optimization Report to make sure the storage tiers are performing optimally. Use performance counters for the Tier object to gather additional data about Reads and Writes to the tiers.  
  
## In this topic  
  
-   [How storage tiers optimize performance](#BKMK_HowTiersOptimizePerformance)  
  
-   [Leave room for tuning when you create storage spaces](#BKMK_LeaveRoomForTunning)  
  
-   [Recommended monitoring frequency](#BKMK_MonitoringFrequency)  
  
-   [What to use](#BKMK_WhatToUse)  
  
    -   [Save a report when Storage Tiers Optimization runs](#BKMK_HOW_SaveReport)  
  
    -   [Run Storage Tiers Optimization on demand](#BKMK_HOW_OptimizeOnDemand)  
  
-   [What to watch for](#BKMK_WhatToLookFor)  
  
    -   [Is the SSD tier capacity sufficient for my workload?](#BKMK_WatchSSDCapacity)  
  
    -   [Are storage tiers being optimized frequently enough for the workload?](#BKMK_IsOptimizationFrequentEnough)  
  
    -   [When should I consider pinning files to a storage tier?](#BKMK_WhenToPinFiles)  
  
-   [Use performance counters to monitor storage tiers](#BKMK_UsePerfCounters)  
  
-   [Additional resources](#BKMK_AdditionalResources)  
  
## <a name="BKMK_HowTiersOptimizePerformance"></a>How storage tiers optimize performance  
If you're using tiered storage spaces in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Windows is automatically optimizing your storage performance by transparently moving the data that's accessed most frequently to your faster solid\-state drives \(the *SSD tier*\) and switching out less active data to your less expensive hard disk drives \(the *HDD tier*\).  
  
Storage tiers optimization is a two\-part process, as shown below:  
  
-   Over the course of the day, Storage Spaces creates a heat map of the data based on how often each piece of data is accessed. **\(1\)**  
  
-   During its nightly run \(at 1:00 a.m., by default\), the Storage Tiers Optimization task moves the most frequently accessed \("hot"\) data to your faster solid\-state drives \(the SSD tier\) and the "cooler" data to the less expensive hard disk drives \(the HDD tier\). **\(2\)**  
  
![](../Image/STORAGETIERS05_TiersOptimizationProcess.jpg)  
  
**Optimization moves data, not files**—The data is mapped and moved at a sub\-file level. So if only 30 percent of the data on a virtual hard disk is "hot," only that 30 percent moves to your solid\-state drives.  
  
**A write\-back cache backed by SSDs minimizes the impact of random writes**—In addition, a 1 GB write\-back cache backed by SSDs reduces the latency of random writes, which increases the overall throughput performance of the storage.  
  
This typically delivers very efficient storage management with little or no intervention on your part. However, you might occasionally need to adjust the storage tiers configuration to get the performance you want for a specific workload.  
  
## <a name="BKMK_LeaveRoomForTunning"></a>Leave room for tuning when you create storage spaces  
When you create storage spaces, plan ahead, and give yourself room to fine\-tune the storage spaces after you observe your workloads in action. After a week or two of observing input\/output operations per second \(IOPS\) and latency, you'll be able to more accurately predict the storage requirements of each workload. [Designing your storage spaces](http://technet.microsoft.com/library/dn554250.aspx)  
  
-   **Don't allocate all available SSD capacity for your storage spaces immediately**—Keep some SSD capacity in the storage pool in reserve \(in addition to what you reserve for rebuilding failed disks\) so you'll be able to increase the size of an SSD tier when a workload needs it.  
  
-   **Don't pin files to storage tiers until you see how well Storage Tiers Optimization can optimize storage performance**—When a tenant or workload requires a particular level of performance, you can pin files to a storage tier to ensure that all I\/O activity is performed on that tier. The entire file is moved to the tier, and then is excluded from Storage Tiers Optimization. If Storage Tiers Optimization can efficiently move only the frequently accessed data to the SSD tier, you can avoid storing entire large files such as virtual hard disks on your more expensive solid\-state drives.  
  
-   **Do consider pinning the parent VHDX file to the SSD tier if you're providing pooled desktops through VDI**—If you're using Virtual Desktop Infrastructure \(VDI\) to provide pooled desktops for users \(you might know these as *non\-persistent desktops* or *dynamic desktops*\), consider pinning the master image that's used to clone users' desktops to the SSD tier if you have the needed SSD capacity. \(You might also need to [run Storage Tiers Optimization more than once a day](#BKMK_HOW_ChangeFrequency).\)  
  
## <a name="BKMK_MonitoringFrequency"></a>Recommended monitoring frequency  
  
-   After you observe your workloads for a few days, review a Storage Tier Optimization Report, and then fine\-tune the configuration of your storage spaces to meet workload requirements. To get a report, [run Storage Tiers Optimization on demand](#BKMK_HOW_OptimizeOnDemand).  
  
-   After that, review a history of storage tiers optimizations weekly in the Storage Tier Optimization Report. The easiest way to get a report is to [change the Storage Tiers Optimization scheduled task to save a report](#BKMK_HOW_SaveReport).  
  
-   If you're experiencing performance issues and want to optimize storage tiers outside the usual schedule, [run Storage Tiers Optimization on demand](#BKMK_HOW_OptimizeOnDemand).  
  
## <a name="BKMK_WhatToUse"></a>What to use  
Use the Storage Tier Optimization Report to check the performance of your storage tiers and identify changes that might optimize their performance.  
  
Be aware that when you request a Storage Tier Optimization Report, your storage tiers are optimized as part of the reporting process before the report is displayed. That can take several hours. That's why we recommend that you [save a report automatically when the Storage Tiers Optimization task runs](#BKMK_HOW_SaveReport). That requires changing the scheduled task, as described below. To keep a record of storage tiers performance over time, configure the task to append the new data to the end of the file instead of overwriting it.  
  
You can also [run Storage Tiers Optimization on demand](#BKMK_HOW_OptimizeOnDemand).  
  
### <a name="BKMK_HOW_SaveReport"></a>Save a report when Storage Tiers Optimization runs  
You can change the Storage Tiers Optimization task to save a report by using Task Scheduler in Server Manager or from the command line.  
  
##### To change the Storage Tiers Optimization task to save a report \(Task Scheduler\)  
  
1.  In Server Manager, open **Task Scheduler** \(on the **Tools** menu\).  
  
2.  In the Task Scheduler console tree, expand **Task Scheduler Library** > **Microsoft** > **Windows**, and click **Storage Tiers Management**.  
  
3.  Open the properties of the **Storage Tiers Optimization** task.  
  
4.  On the **Actions** tab, click **Start a program**, and then click **Edit**.  
  
5.  In **Add arguments**, add the instruction to save an output file to the default arguments:  
  
    ```  
    /c /h /g /# >> <path>\StorageTiersOutput.txt  
    ```  
  
    **Example entry:**  `/c /h /g /# >> C:\Windows\StorageReports\StorageTiersOutput.txt`  
  
    > [!NOTE]  
    > This string requires a literal path—you can't use environment variables such as %windir% to indicate the system folder.  
  
##### To change the Storage Tiers Optimization task to save a report \(command line\)  
  
-   Run the following command at an elevated command prompt:  
  
    ```  
    schtasks /change /tn "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization" /tr "cmd /c %windir%\System32\defrag.exe /c /h /g /# >> %windir%\StorageTiersOutput.txt"  
    ```  
  
    -   Run the example command as it is to save the data in a StorageTiersOutput.txt file in the Windows installation folder. You can substitute any path or filename.  
  
    -   The >> appends the latest data to the existing file so you can compare performance data over time. If you prefer to overwrite the previous data each time the task runs, use a single > instead.  
  
### <a name="BKMK_HOW_OptimizeOnDemand"></a>Run Storage Tiers Optimization on demand  
To perform Storage Tiers Optimization on demand, you can either run the Storage Tiers Optimization task—either in Task Scheduler or Windows PowerShell—or you can run defrag.exe with the appropriate parameters.  
  
> [!NOTE]  
> You can’t use some of the storage cmdlets with Windows PowerShell \(x86\) or Windows PowerShell ISE \(x86\). Instead, use the normal \(64\-bit\) Windows PowerShell or Windows PowerShell ISE.  
  
##### To run Storage Tiers Optimization on demand \(Task Scheduler\)  
  
1.  In the Task Scheduler console tree, expand **Task Scheduler Library** > **Microsoft** > **Windows**, and click **Storage Tiers Management**.  
  
2.  Right\-click the **Storage Tiers Optimization** task, and click **Run**.  
  
##### To run Storage Tiers Optimization on demand \(Windows PowerShell\)  
  
-   Open Windows PowerShell with administrator rights, and run this command. \(You'll only get a report if you've updated the task to save one.\)  
  
    ```powershell  
    Get-ScheduledTask -TaskName "Storage Tiers Optimization" | Start-ScheduledTask  
    ```  
  
##### To optimize storage tiers using Defrag.exe  
  
-   Enter the following command at an elevated command prompt:  
  
    ```  
    defrag <driveletter>: /g /h /#  
    ```  
  
    This command optimizes storage tiers \(`/g`\) on the volume, returning a Post Defragmentation Report and a Storage Tier Optimization Report. Include `/h` to process the job at normal priority instead of low priority \(the default\).  
  
## <a name="BKMK_WhatToLookFor"></a>What to watch for  
There are three things to monitor to ensure your storage tiers perform optimally for each workload:  
  
-   [Is the SSD tier capacity sufficient for my workload?](#BKMK_WatchSSDCapacity)  
  
-   [Are storage tiers being optimized frequently enough for the workload?](#BKMK_IsOptimizationFrequentEnough)  
  
-   [When should I consider pinning files to a storage tier?](#BKMK_WhenToPinFiles)  
  
### <a name="BKMK_WatchSSDCapacity"></a>Is the SSD tier capacity sufficient for my workload?  
A quick look at a Storage Tier Optimization Report can tell you whether you have provided sufficient SSD tier capacity to get the I\/O optimization—that is, the percentage of I\/O serviced by the SSD tier—that you want for the workloads in the storage space. The appropriate performance goal depends on the nature and requirements of a workload.  
  
**Detection**—If the percentage of I\/Os that your SSD tier is currently servicing \(at the bottom of the Storage Tier Optimization Report\) is lower than the percentage you want for the workloads, check the table at the top of the report to find out the SSD tier size that is required to reach the desired percentage based on current activity of your workloads.  
  
![](../Image/STORAGETIERS_MoreSSDNeeded.jpg)  
  
#### When  
  
-   You can increase the size of the SSD tier or move a workload to a different storage space \(to reduce the SSD capacity requirement of the current storage space\) at any time. Moving a workload typically involves moving virtual machine storage, which is performed as a background task.  
  
#### Provide additional SSD tier capacity for a workload  
If additional SSD capacity is available for the storage space, you can enlarge the SSD tier to meet the needs of a workload. After you resize the tier, you will need to extend the partition and volume for the storage space. You can do this in Server Manager or in Windows PowerShell.  
  
###### To add capacity to the SSD tier \(Server Manager\)  
  
1.  In Server Manager, open **File and Storage Services** \(on the **Tools** menu\).  
  
    > [!NOTE]  
    > If you're already working in Server Manager, refresh the display to make sure you're seeing any recent changes made in Windows PowerShell.  
  
2.  In the console tree, expand **Volumes**, and click **Storage Pools**.  
  
3.  Select the storage pool. Then, under **Virtual Disks**, right\-click the storage space and click **Extend virtual disk**. For a tiered storage pool, you extend individual tiers.  
  
4.  To extend a tier, click **Specify size**, and enter the total amount of space to allocate to the tier—that is, current size plus the additional space that is needed. Then click **OK**.  
  
    > [!IMPORTANT]  
    > Make sure the resized SSD tier will not encroach on the space that you reserved in the storage pool to support automatic rebuild when a physical disk fails. [Guidelines for allocating capacity for storage pools and storage spaces](http://technet.microsoft.com/library/dn554250.aspx)  
  
5.  Open the properties of the storage pool. Note **Allocated space** \(the sum of space allocated to both tiers\). You will need to extend the volume to accommodate the allocation.  
  
6.  To extend the volume \(this also extends the partition\):  
  
    1.  In the console tree, click **Volumes**.  
  
    2.  Under **Volumes**, right\-click the volume assigned to the storage space, and click **Extend volume**.  
  
    3.  In the Extend Volume dialog box, enter a larger size to enable use of the expanded tier capacity.  
  
        > [!IMPORTANT]  
        > Don't assign the maximum size. You need to reserve some space for the GPT partitioning scheme. We recommend leaving 256 MB \(0.25 GB\). That is, resize the partition for a 66GB storage space to 65.75GB.  
  
###### To add capacity to the SSD tier \(Windows PowerShell\)  
  
1.  Open Windows PowerShell as an administrator.  
  
2.  Before you resize the SSD tier, run the following commands to verify the health of the storage space, the current size of the tier you want to resize, and available capacity. Replace the $StorageSpaceName variable with the friendly name of the storage space.  
  
    > [!NOTE]  
    > Commands throughout this procedure use the $StorageSpaceName and $SSDtier variables, with the assumption that you will run all commands in the same Windows PowerShell session. If you open a new Windows PowerShell session, either define the variables again or substitute the friendly name of the storage space or SSD tier for the variable.  
  
    ```powershell  
    $StorageSpaceName = "<storagespacename>"  
    $SSDtier = Get-VirtualDisk -FriendlyName $StorageSpaceName | Get-StorageTier –mediatype “SSD”  
    Get-VirtualDisk $StorageSpaceName | Format-Table –AutoSize  
    Get-StorageTier -VirtualDisk (Get-VirtualDisk -FriendlyName $StorageSpaceName) | Format-Table -Property FriendlyName,MediaType,Size -AutoSize  
    Get-StorageTierSupportedSize –InputObject $SSDtier  
    Get-VirtualDisk $StorageSpaceName | Get-Disk | Format-Table –AutoSize  
    Get-VirtualDisk $StorageSpaceName | Get-Disk | Get-Partition | Format-Table –AutoSize  
    Get-VirtualDisk $StorageSpaceName | Get-Disk | Get-Partition | Get-Volume | Format-Table –AutoSize  
    ```  
  
    **Sample output**—Shows a tiered storage space, Space01, with:  
  
    -   64 GB capacity \(SSD tier \= 32 GB, HDD tier \= 32 GB\)  
  
    -   Volume \(D\) and partition size of 64.87 GB. Note that the volume and partition are slightly smaller than the storage space capacity. Remaining space is used for the GPT partitioning scheme.  
  
    -   Resiliency setting of Mirror  
  
**PS C:\\Windows\\system32> $StorageSpaceName \= "Space01"PS C:\\Windows\\system32> $SSDtier \= Get\-VirtualDisk \-FriendlyName $StorageSpaceName | Get\-StorageTier –mediatype “SSD”PS C:\\Windows\\system32> Get\-VirtualDisk $StorageSpaceName | FT \-AutoSizeFriendlyName       ResiliencySettingName OperationalStatus HealthStatus IsManualAttach  Size\-\-\-\-\-\-\-\-\-\-\-\-       \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-\-  \-\-\-\-Space01            Mirror                OK                Healthy      False          64 GBPS C:\\Windows\\system32> Get\-StorageTier \-VirtualDisk \(Get\-VirtualDisk \-FriendlyName $StorageSpaceName\) | Format\-Table \-Property FriendlyName,MediaType,Size \-AutoSizeFriendlyName                      Size\-\-\-\-\-\-\-\-\-\-\-\-                      \-\-\-\-Space01\_SSDtier                   34359738368Space01\_HDDtier                   34359738368PS C:\\Windows\\system32> Get\-StorageTierSupportedSize –\-InputObject $SSDtierSupportedSizes TierSizeMin   TierSizeMax TierSizeDivisor\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-   \-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-{}              2147483648 1020054732800      2147483648PS C:\\Windows\\system32> Get\-VirtualDisk $StorageSpaceName | Get\-Disk | FT \-AutoSizeNumber Friendly Name                  OperationalStatus Total Size Partition Style\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-                  \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-8      Microsoft Storage Space Device Online                 64 GB GPT            PS C:\\Windows\\system32> Get\-VirtualDisk $StorageSpaceName | Get\-Disk | Get\-Partition | Format\-Table –AutoSize   Disk Number: 8PartitionNumber DriveLetter Offset        Size Type    \-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-        \-\-\-\- \-\-\-\-    1                           24576       128 MB Reserved2               D           135266304 63.87 GB Basic   PS C:\\Windows\\system32> Get\-VirtualDisk $StorageSpaceName | Get\-Disk | Get\-Partition | Get\-Volume | Format\-Table –AutoSizeDriveLetter FileSystemLabel FileSystem DriveType HealthStatus SizeRemaining     Size\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-     \-\-\-\-D           New Volume      NTFS       Fixed     Healthy           61.77 GB 63.87 GB**  
  
3.  Add capacity to the SSD tier by running the following command. Enter the size in GBs, TBs, or MBs, using this format: `34GB`.  
  
    ```powershell  
    Resize-StorageTier Friendly-Name $SSDtier -Size <size>  
    ```  
  
    > [!IMPORTANT]  
    > Make sure the resized SSD tier will not encroach on the space that you reserved in the storage pool to support automatic rebuild when a physical disk fails. [Guidelines for allocating capacity for storage pools and storage spaces](http://technet.microsoft.com/library/dn554250.aspx)  
  
4.  Update the virtual disk to incorporate the additional tier size:  
  
    ```powershell  
    Get-VirtualDisk $StorageSpaceName | Get-Disk | Update-Disk  
    ```  
  
5.  Recheck the status of the storage space and its tiers by repeating the commands that you ran in Step 2, and note the size of the total allocated space \(the sum of allocated capacity for both tiers\).  
  
6.  Resize the partition for the storage space \(this also resizes the volume\). You'll have to make the partition slightly smaller than the storage space capacity to leave space for the GPT partitioning scheme. We recommend that you reserve 256 MB \(0.25 GB\) for this purpose. That is, resize the partition for a 66GB storage space to 65.75GB.  
  
    ```powershell  
    Resize-Partition -DriveLetter <driveletter> -Size <size>  
    ```  
  
7.  Verify the changes to the partition and volume by running the following commands:  
  
    ```powershell  
    Get-VirtualDisk $StorageSpaceName | Get-Disk | Get-Partition | Format-Table –AutoSize  
    Get-VirtualDisk $StorageSpaceName | Get-Disk | Get-Partition | Get-Volume | Format-Table –AutoSize  
    ```  
  
    **Sample output**—Shows a healthy volume and partition enlarged to 65.75 GB.  
  
**PS C:\\Windows\\system32> Get\-VirtualDisk $StorageSpaceName | Get\-Disk | Get\-Partition | FT –AutoSize   Disk Number: 8PartitionNumber DriveLetter Offset        Size Type    \-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-        \-\-\-\- \-\-\-\-    1                           24576       128 MB Reserved2               D           135266304 65.75 GB Basic   PS C:\\Windows\\system32> Get\-VirtualDisk $StorageSpaceName | Get\-Disk | Get\-Partition | Get\-Volume | FT –AutoSizeDriveLetter FileSystemLabel FileSystem DriveType HealthStatus SizeRemaining     Size\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\- \-\-\-\-\-\-\-\-\-\-\-\-\-     \-\-\-\-D           New Volume      NTFS       Fixed     Healthy           63.64 GB 65.75 GB**  
  
### <a name="BKMK_IsOptimizationFrequentEnough"></a>Are storage tiers being optimized frequently enough for the workload?  
By default, the Storage Tiers Optimization task runs daily at 1:00 a.m. For large, highly active workloads, more frequent volume optimization might be needed to maintain consistent storage performance throughout the day.  
  
**Detection**—In the Storage Tier Optimization Report, check whether the actual percentage of I\/Os being serviced by the SSD tier is about what's expected for your SSD tier size, as shown below. The expected percentage for each tier size is calculated based on the heat map for your storage space. If the actual percentage is a lot lower than expected, you should schedule additional runs of the Storage Tiers Optimization task.  
  
![](../Image/MorefrequentStorageTiersOptimizationsneeded.jpg)  
  
#### When  
  
-   If your workload is changing more frequently than the current Storage Tiers Optimization schedule supports, you can [increase the task frequency](#BKMK_HOW_ChangeFrequency) or [run Storage Tiers Optimization immediately](#BKMK_HOW_OptimizeOnDemand).  
  
-   **Recommended maximum frequency:** Every 6 hours  
  
#### <a name="BKMK_HOW_ChangeFrequency"></a>Change the task frequency for Storage Tiers Optimization  
  
###### To change task frequency for Storage Tiers Optimization \(command line\)  
  
-   At an elevated command prompt, enter the following command:  
  
    ```  
    schtasks /change /tn "\Microsoft\Windows\Storage Tiers Management\Storage Tiers Optimization" /ri 360  
    ```  
  
    The example sets the run interval to every 360 minutes \(6 hours\) \(`/ri 360`\). There's nothing to gain by running the task any more frequently.  
  
###### To change task frequency for Storage Tiers Optimization \(Task Scheduler\)  
  
1.  In Server Manager, open **Task Scheduler** \(on the **Tools** menu\).  
  
2.  In the Task Scheduler console tree, expand **Task Scheduler Library** > **Microsoft** > **Windows**, and click **Storage Tiers Management**.  
  
3.  Open properties for the **Storage Tiers Optimization** task.  
  
4.  On the **Triggers** tab, click **Daily**, and then click **Edit**.  
  
5.  Under **Advanced Settings**, select **Repeat task every**, and type in **6 hours** \(if you want to run Storage Tiers Optimization four times daily\). \(The trigger should remain **Daily**.\)  
  
### <a name="BKMK_WhenToPinFiles"></a>When should I consider pinning files to a storage tier?  
An administrator can override Storage Tiers Optimization by pinning files to a storage tier to ensure the files are always accessed on the preferred tier.  
  
That's useful in some circumstances, but we recommend that you pin files sparingly—and only after you observe your workloads to see whether Storage Tiers Optimization can accomplish your goals. Each pinned file on the SSD tier reduces the space that can be used for data placement based on the heat map—and the pinned file typically takes up more space on your more expensive solid\-state drives than the frequently accessed data that moves there during Storage Tiers Optimization.  
  
If you pin files to a storage tier, you should [monitor the effects of the pinned files on storage tier performance](#BKMK_MonitorEffectsOfPinnedFiles).  
  
When should you consider pinning files to a storage tier?  
  
-   **If you need to guarantee performance levels for workloads**—You can pin files to differentiate tenant virtual machines, and the underlying VHD files, based on service\-level agreements.  
  
-   **For workloads that require that certain files be pinned to a tier**—For example, for VDI pooled desktops, you should pin the parent VHDX file that is used to clone the desktops at startup to the SSD tier.  
  
-   **For workloads that frequently access different data at different times**—If a workload's active working set is not stable, you can get churn from data moving often between the SSD tier and the HDD tier.  
  
-   **To debug performance issues relating to a tier**  
  
-   **To remove streaming media from I\/O servicing on the SSD tier**—It can be useful to pin the VHDs that store videos and audio files to the HDD tier. These media are accessed sequentially, and can be handled fine by hard disk drives.  
  
**Detection**–Whether to pin a file to a storage tier is the administrator's choice based on the requirements and behavior of workloads. You should use pinning sparingly in situations like those noted earlier.  
  
#### When  
  
-   You can pin a file at any time with no immediate effect on storage performance. Storage Tiers Optimization attempts to move the file to the desired tier during its next run. If you decide to optimize tiers immediately, bear in mind the trade\-off between possibly reduced performance during the extra Storage Tiers Optimization run and the added benefit of immediate tier optimization.  
  
#### <a name="BKMK_PinAFileToaTier"></a>Pin a file to a storage tier  
Use Windows PowerShell to pin files to a storage tier. This feature is not available in Server Manager.  
  
> [!NOTE]  
> To be pinned a storage tier, a file must be on a volume that is hosted by the same tiered storage space.  
  
###### To pin a file to a storage tier \(Windows PowerShell\)  
  
1.  Open Windows PowerShell as an administrator.  
  
2.  To get the friendly name of the storage tier, run this:  
  
    ```powershell  
    Get-StorageTier <storagespacename>*| Format-Table FriendlyName, MediaType, Size –AutoSize  
    ```  
  
3.  To pin the file to the tier, run this:  
  
    ```powershell  
    Set-FileStorageTier -FilePath <filepath> -DesiredStorageTierFriendlyName <tierfriendlyname>  
    ```  
  
    This pins the file but doesn’t move it immediately. Storage Spaces will attempt to move the pinned files to the desired volumes during its next Storage Tiers Optimization run.  
  
4.  If you want to move the file now, perform Storage Tiers Optimization on demand:  
  
    In Windows PowerShell, run: `Get-ScheduledTask -TaskName "Storage Tiers Optimization" | Start-ScheduledTask`  
  
    \-Or\-  
  
    At an elevated command prompt, run: `defrag <driveletter>: /g /h /#`  
  
5.  To verify that a pinned file has been moved to the tier, run the following command in Windows PowerShell, and check the placement status and state of the file:  
  
    ```powershell  
    Get-FileStorageTier -VolumeDriveLetter <driveletter>  
    ```  
  
    **Sample output:**  
  
**PS C:\\Windows\\system32> Get\-FileStorageTier \-VolumeDriveLetter dFilePath                            DesiredStorageTierName            PlacementStatus                   State\-\-\-\-\-\-\-\-                            \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-            \-\-\-\-\-\-\-\-\-\-\-\-\-\-\-                   \-\-\-\-\-D:\\VMs\\ParentVM01.vhd...            Space01\_SSDtier                   Completely on tier                OKD:\\TrainingVideo01.mpv              Space01\_HDDtier                   Completely on tier                OK**  
  
#### <a name="BKMK_MonitorEffectsOfPinnedFiles"></a>Monitor the effects of pinned files on storage tiers performance  
If you pin files to your storage tiers, you should check the effects of the pinned files on I\/O servicing when you review the Storage Tier Optimization Report. At the bottom of the report, you'll see the total volume of pinned files on each tier, and the percentage of I\/O on the tier accounted for by pinned files.  
  
![](../Image/STORAGETIERS03_PinnedFilesUsage.jpg)  
  
How you interpret the data depends on why you pinned the files. For example, if you aren't getting the storage performance that you need for a workload, and pinned files account for a large percentage of I\/O serviced by the SSD tier, then it's a good idea to review a list of the pinned files to make sure they all need to be pinned.  
  
###### To view a list of files pinned to the storage tiers \(Windows PowerShell\)  
  
-   Open Windows PowerShell as an administrator, and run the following command:  
  
    ```powershell  
    Get-FileStorageTier -VolumeDriveLetter <driveletter>  
    ```  
  
## <a name="BKMK_UsePerfCounters"></a>Use performance counters to monitor storage tiers  
You can use the performance counters for the **Tier** object in Storage Spaces to get additional data that can help you evaluate the following aspects of storage tiers performance:  
  
-   **Check for bottlenecks on a tier**—Two performance counters—Tier Transfers\/Sec and Tier Queue Length—can probably give you a good idea of whether a bottleneck has developed on a tier.  
  
-   **Review Write latency**—Ideally, the SSD tier and the HDD tier have similar Write latency because all Writes to the HDD tier are being absorbed by the write\-back cache. A higher Write latency on the HDD tier can indicate a couple of things:  
  
    -   The write\-back cache is full and is throttling. Check Bytes Used for the Cache object.  
  
    -   The Writes are large enough to bypass the write\-back cache \(Writes larger than 256 KB are not written to the cache\). Compare Cache Writes\/sec \(Cache object\) with Tier Writes\/sec \(Tier object\).  
  
-   **Review Read performance**—Be aware that for Reads, especially in random I\/O, the HDD tier is expected to perform more slowly than the SSD tier.  
  
> [!NOTE]  
> To get these counters, install [KB 2980661: Update to add a new performance counter feature for Tiered Storage Spaces in Windows Server 2012 R2](http://support.microsoft.com/kb/2980661).  
  
### Counter descriptions: Tier object \(Storage Spaces\)  
  
|Counter Name|Description|  
|----------------|---------------|  
|Avg. Tier Bytes\/Transfer|The average size of individual Read and Write requests \(I\/O size\) to the storage tier for the capture interval.|  
|Tier Transfer Bytes\/sec|The transfer speed for Read and Write requests to the tier \(in bytes per second\).|  
|Avg. Tier Queue Length|Measures latency over time—the average number of outstanding Read and Write requests to the tier, including requests currently in service and those waiting for service.|  
|Avg. Tier sec\/Transfer|The average time it takes to complete a Read or Write operation on the tier.|  
|Tier Transfers\/sec|The number of transfers completed in the previous second—known as IOPS, or Inputs\/Outputs per second. If the capture interval in Performance Monitor is greater than 1 second, the average of the values captured is presented.|  
|Current Tier Queue Length|The number of outstanding Read and Write requests to the tier, including requests currently in service and requests waiting for service.|  
|Avg. Tier Bytes\/Write|The average size, including metadata, of individual Write requests that went to the storage tier during the capture interval.|  
|Tier Write Bytes\/sec|The average speed of Writes to the tier \(in bytes per second\).|  
|Avg. Tier Write Queue Length|The average number of outstanding Write requests to the tier, including requests currently in service and requests waiting for service.|  
|Avg. Tier sec\/Write|The average number of seconds required per Write on the tier.|  
|Tier Writes\/sec|Writes per second on the tier. If the capture interval in Performance Monitor is greater than 1 second, the average of the values captured is displayed.|  
|Avg. Tier Bytes\/Read|The average size of individual Read requests \(I\/O size\) on the storage tier for the capture interval \(in bytes\).|  
|Tier Read Bytes\/se|The average speed of Reads to the tier \(in Bytes per second\).|  
|Avg. Tier Read Queue Length|The average number of outstanding Read requests to the tier, including requests currently in service and requests waiting for service.|  
|Avg. Tier sec\/Read|Average seconds per Read on the tier.|  
|Tier Reads\/sec|Reads per second on the tier. If the capture interval in Performance Monitor is greater than 1 second, the average of the values captured is presented.|  
  
## <a name="BKMK_AdditionalResources"></a>Additional resources  
  
-   [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md)  
  
-   [What's New in Storage Spaces in Windows Server 2012 R2](assetId:///5de72fb5-e1e3-43a7-a176-d17cdf4d312e)  
  
-   [Best Practices for Deploying Tiered Storage Spaces in Windows Server 2012 R2](http://channel9.msdn.com/Events/TechEd/NorthAmerica/2014/DCIM-B346)  
  
-   [Test Storage Spaces Performance Using Synthetic Workloads in Windows Server](https://technet.microsoft.com/library/dn894707.aspx)  
  
-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](assetId:///e70fcb94-0576-4582-a1e0-8c41f8d745cc) \(overview\)  
  
-   [Planning and design guide: Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](http://technet.microsoft.com/library/dn554250.aspx) \(Guidance for designing storage pools and storage spaces\)  
  
-   [Step\-by\-Step for Storage Spaces Tiering in Windows Server 2012 R2](http://blogs.technet.com/b/josebda/archive/2013/08/28/step-by-step-for-storage-spaces-tiering-in-windows-server-2012-r2.aspx) \(Windows PowerShell\)  
  
