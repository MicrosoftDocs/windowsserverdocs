---
title: Plan to Deploy Data Deduplication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aadedb74-6b07-4bd2-9b9b-144781e85c81
---
# Plan to Deploy Data Deduplication
This document explains how to plan for deploying Data Deduplication. To be safe, backup and restore a deduplicated volume to ensure that your deployment is covering the entire dataset.  
  
**In this document**  
  
1.  [Step 1: Target deployments](../Topic/Plan-to-Deploy-Data-Deduplication.md#BKMK_Target)  
  
2.  [Step 2: Determine which volumes are candidates for deduplication](../Topic/Plan-to-Deploy-Data-Deduplication.md#BKMK_Step1)  
  
3.  [Step 3: Evaluate savings with the Deduplication Evaluation Tool](../Topic/Plan-to-Deploy-Data-Deduplication.md#BKMK_Step2)  
  
4.  [Step 4: Plan the rollout, scalability, and deduplication policies](../Topic/Plan-to-Deploy-Data-Deduplication.md#BKMK_Step3)  
  
## <a name="BKMK_Target"></a>Step 1: Target deployments  
Data Deduplication is designed to be installed on primary data volumes without adding additional dedicated hardware. This means that you can install and use the feature without impacting the primary workload on the server. The default settings are nonintrusive because they allow data to age for five days before processing a particular file, and has a default minimum file size of 32 KB. The implementation is designed for low memory and CPU usage, and if memory utilization becomes high, deduplication will wait for available resources. Administrators can schedule more aggressive deduplication based on the type of data that is involved and the frequency and volume of changes that occur to the volume or particular file types.  
  
The ideal workloads for deduplication include:  
  
-   **General file shares**: Group content publication and sharing, user home folders, and Folder Redirection\/Offline Files  
  
-   **Software deployment shares**: Software binaries, images, and updates  
  
-   **VHD libraries**: Virtual hard disk \(VHD\) file storage for provisioning to hypervisors  
  
-   **VDI Deployments \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] only\)**: Virtual Desktop Infrastructure \(VDI\) deployments using Hyper\-V  
  
-   **Virtualized Backup \([!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] only\)**: Backup applications running as Hyper\-V guests saving backup data to mounted VHDs  
  
## <a name="BKMK_Step1"></a>Step 2: Determine which volumes are candidates for deduplication  
Deduplication can be very effective to optimize storage and reduce the amount of disk space consumed—50% to 90% when applied to the right data. Evaluate the following considerations when you select data for deduplication:  
  
1.  **Does the data have duplication within it?**  
  
    File shares or servers that host user documents, software deployment binaries, or virtual hard disk files tend to have plenty of duplication, and they will yield high savings from deduplication. The following table highlights typical deduplication savings for various content types. Results will vary by data type, mix, and size. It is best to run an evaluation on a data sample before you enable deduplication. For Details about using the DDPEval tool to evaluate deduplication savings see [Step 3: Evaluate savings with the Deduplication Evaluation Tool](../Topic/Plan-to-Deploy-Data-Deduplication.md#BKMK_Step2) later in this topic.  
  
    |Scenario|Content|Typical Space Savings|  
    |------------|-----------|-------------------------|  
    |User documents|Documents, photos, music, videos|30\-50%|  
    |Deployment shares|Software binaries, cab files, symbols files|70\-80%|  
    |Virtualization libraries|Virtual hard disk files|80\-95%|  
    |General file share|All of the above|50\-60%|  
  
2.  **Does the data access pattern allow for sufficient time for deduplication?**  
  
    Files that change often and are constantly accessed by users or applications are not good candidates for deduplication. The constant access and change to the data are likely to cancel any optimization gains made by deduplication, and deduplication may not be able  to process the files.  
  
    -   A good candidate for deduplication is a file share that hosts user documents, virtual files, or software deployment files that contain data that is modified infrequently and read frequently.  
  
    -   Poor candidates for deduplication are a constantly\-mounted SQL Server database that is running virtual machines, and live Exchange Server databases.  
  
    Good candidates allow time to deduplicate the files. File age policies can be applied to control when files are deduplicated to prevent early or frequent deduplication of files that are still likely to be modified significantly.  
  
3.  **Does the server have sufficient resources and time to run deduplication?**  
  
    Deduplication requires reading, processing, and writing large amounts of data. This consumes server resources and must be considered when planning a deployment. Servers typically have periods of high activity and times when there is low resource utilization. Deduplication can get the most work done when resources are available. If a server is always running at maximum capacity, it is probably not a good candidate for deduplication, even though the deduplication processes can optimize some files by using background optimization jobs.  
  
    Based on observed savings and typical resource usage, deployment candidates for deduplication are ranked as follows:  
  
    **Great candidates for deduplication:**  
  
    -   Folder redirection servers  
  
    -   Virtualization depot or provisioning library  
  
    -   Software deployment shares  
  
    -   SQL Server and Exchange Server backup volumes  
  
    -   VDI VHDs \(supported only on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\)  
  
    -   Virtualized backup VHDs \(supported only on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]\)  
  
    **Should be evaluated based on content:**  
  
    -   Line\-of\-business servers  
  
    -   Static content providers  
  
    -   Web servers  
  
    -   High\-performance computing \(HPC\)  
  
    **Not good candidates for deduplication:**  
  
    -   Hyper\-V hosts  \(running workloads other than VDI or virtualized backup\)  
  
    -   WSUS  
  
    -   Servers running SQL Server or Exchange Server  
  
    -   Files approaching or larger than 1 TB in size  
  
    -   VDI VHDs on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
    -   Virtualized backup VHDs on Windows Server 2012  
  
## Server and volume requirements for deduplication  
**Servers**  
  
See the following list for server requirements for deduplication:  
  
-   Server hardware should meet the minimum requirements for running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. The deduplication feature was designed to support minimal configurations such as a single processor system with 4 GB of RAM and one SATA hard disk drive.  
  
-   If you plan to support deduplication on multiple volumes on the same server, you need to plan an appropriately size for the system to ensure that it can process the data. The general rule is that the server needs 1 CPU\-core and 350 MB of free memory to run a deduplication job on a single volume, and that job can process about 100 GB per hour or around 2 TB per day. Deduplication scales with additional CPU core processors and available memory to enable parallel processing of multiple volumes.  
  
    **For example**: If you have a server with 16 CPU core processors and 16 GB of memory, deduplication uses 25% of the system memory in the default Background Processing mode, and in this case, that would be 4 GB. If you divide by 350 MB, you can calculate that the server could process about 11 volumes at a time. If you add 8 GB of memory, the system could process 17 volumes at a time. If you set an optimization job to run in Throughput mode, the system will use up to 50% of the system’s memory for the optimization job.  
  
-   Data Deduplication supports up to 90 volumes at a time; however, deduplication can simultaneously process one volume per physical CPU core processor plus one. Hyper\-threading does not impact this because only physical core processors can be used to process a volume. A system with 16 CPU core processors and 90 volumes will process 17 volumes at a time until all 90 volumes are done, if there is sufficient memory.  
  
-   Virtual server instances should follow the same guidance as physical hardware regarding server resources.  
  
**Volumes**  
  
Volumes that are candidates for deduplication must conform to the following requirements:  
  
-   Must not be a system or boot volume. Deduplication is not supported on operating system volumes.  
  
-   Can be partitioned as a master boot record \(MBR\) or a GUID Partition Table \(GPT\), and must be formatted using the NTFS file system.  
  
-   Can reside on shared storage, such as storage that uses a Fibre Channel or an SAS array, or when an iSCSI SAN and Windows Failover Clustering is fully supported.  
  
-   If you’re using Windows Server 2012, don’t deduplicate Cluster Shared Volumes \(CSVs\). You can access data if a deduplication\-enabled volume is converted to a CSV, but you cannot continue to process files for deduplication on Windows Server 2012.  
  
-   Do not rely on the Microsoft Resilient File System \(ReFS\).  
  
-   Can’t be larger than 64 TB in size.   For detailed guidance on determining the maximum volume size for your specific workload and system configuration, see [Sizing Volumes for Data Deduplication in Windows Server](http://blogs.technet.com/b/filecab/archive/2014/12/04/sizing-volumes-for-data-deduplication-in-windows-server.aspx).  
  
-   Must be exposed to the operating system as non\-removable drives. Remotely\-mapped drives are not supported.  
  
    > [!NOTE]  
    > Files with extended attributes, encrypted files, files smaller than 32 KB, and reparse point files are not processed by deduplication.  
  
## Support for limited hyper\-converged Hyper\-V configurations  
In general, enabling Windows Server Data Deduplication on data volumes that are directly mounted on a Hyper\-V compute server \(as opposed to mounted from a shared folder hosted on a separate file server\) is not supported. However, there is a useful limited configuration that is supported as an exception. This configuration is designed to avoid the occurrence of priority and\/or resource conflicts between the Hyper\-V guest workloads and data deduplication host partition processing by using appropriate scheduling.  
  
For this limited configuration, deduplication must be running in a supported scenario. In particular, open VHD files used for accessing storage in guest virtual machines are only supported for VDI and virtualized backup scenarios.  
  
This limited configuration consists of the following:  
  
-   A Hyper\-V compute server or cluster that is dedicated to running VDI or virtualized backup guest workloads.  
  
    -   All server nodes are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] with the November 2014 update rollup for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] \([KB 3000850](https://support.microsoft.com/en-us/kb/3000850)\) or later.  
  
-   Guest VHDs are stored in locally attached data volumes. In a cluster configuration, the volumes are mounted as Cluster Shared Volumes.  
  
-   Windows Server Data Deduplication is enabled on these locally attached data volumes.  
  
-   All deduplication tasks on a given server or cluster are scheduled to run in a limited **idle** timeframe when all VDI or virtualized backup workloads are idle.  
  
    -   It is not required to actively enforce a block on running VDI or virtualized backup workloads during this scheduled time. However, the system is required to be configured so that operation of VDI or virtualized backup is idle or paused during the scheduled deduplication processing window.  
  
-   For information about volume sizing and deduplication performance monitoring, see [Sizing Volumes for Data Deduplication in Windows Server](http://blogs.technet.com/b/filecab/archive/2014/12/04/sizing-volumes-for-data-deduplication-in-windows-server.aspx).  
  
    -   If deduplication processing is not able to keep up with the daily data churn, you must either extend the **downtime** deduplication processing window or you must configure fewer simultaneous active VDI or virtualized backup workloads on the node. Also, if additional system downtime is available on weekends, you can try to schedule the extended deduplication processing window to run during the  weekend.  
  
In addition to meeting the above requirements, the following steps are strongly recommended:  
  
-   For VDI workloads:  
  
    -   In order to validate the VDI workload capacity of this limited configuration, run a load test using the supported VDI guest images. Tools such as [LoginVSI](http://www.loginvsi.com/) or its equivalent, should be used to directly validate the configuration prior to its use in production.  
  
    -   Review the recommendations in the article [Deduplication Tuning for Deployments with High Saving Rates](http://social.technet.microsoft.com/wiki/contents/articles/32049.deduplication-tuning-for-deployments-with-high-saving-rates.aspx). If the savings rates measured in the VDI deployment fall in the range covered in this article, adjust the deduplication settings as instructed.  
  
-   For virtualized backup workloads, a full backup cycle should be validated with production\-equivalent workloads to ensure that the backup and deduplication jobs complete.  
  
-   An active [Microsoft Service Premier Support](https://www.microsoft.com/en-us/microsoftservices/support.aspx) contract is recommended to facilitate further communication, telemetry, and advice that can be useful when defining these configurations.  
  
## Unsupported configurations  
**Constantly open or changing files**  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], deduplication is not supported for files that are open and constantly changing for extended periods of time or that have high I\/O requirements, for example, running virtual machines on a Hyper\-V host, live SQL Server databases, or active VDI sessions.  
  
Beginning with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], deduplication adds support for running virtual machines in a VDI configuration or running virtualized backup applications that store backup date in VHDs. The VHDs used must be stored on a file server separate from the Hyper\-V host computer unless a limited **hyper\-converged** configuration is used as described in the preceding section.  
  
Deduplication optimization of open files is supported only for VDI scenarios with Hyper\-V using remote storage over SMB 3.0 or in a limited **hyper\-converged** configuration as described in the preceding section. Deduplication of open files has not been fully validated for general virtualization or other applications, and additional issues may be encountered.  
  
Deduplication can be set to process files that are 0 days old and the system will continue to function as expected, but it will not process files that are exclusively open. It is not a good use of server resources to deduplicate a file that is constantly being written to, or will be written to in the near future. If you adjust the default minimum file age setting to 0, test that deduplication is not constantly being undone by changes to the data.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], deduplication will not process files that are constantly and exclusively open for write operations. This means that you will not get any deduplication savings unless the file is closed when an optimization job attempts to process a file that meets your selected deduplication policy settings.  
  
Beginning with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the VHDs of running virtual machines deployed in a VDI configuration or the VHDs used for backup data by virtualized backup applications can be optimized. The deduplication process will optimize the parts of the VHD file that are older than the selected minimum days defined by the deduplication policy. Running virtual machine VHDs can realize considerable storage savings.  
  
**FSRM hard quotas**  
  
Setting a hard quota on a volume root folder that also has deduplication enabled is not supported. When a hard quota is present on a volume root, the actual free space on the volume and the quota\-restricted space on the volume are not the same. This may cause deduplication jobs to fail. Creating a soft quota on a volume root that has deduplication enabled is supported; however, when FSRM quotas encounter a deduplicated file, it  accounts for it based on the file’s logical size. Quota usage \(including any quota thresholds\) does not change when a file is processed by deduplication. All other FSRM quota functionality, including volume\-root soft quotas and quotas on subfolders, will work normally when using deduplication.  
  
## Deduplication considerations  
**Working with initial datasets**  
  
Volumes brought under deduplication control may be empty or they may already contain data. If the volume already has data, deduplication may take an extended amount of time to process the data for the first time. This is a normal condition and should be expected. Data Deduplication processes files when the server has available resources and will automatically resume processing. The rate of processing depends on the system specifications. Volume processing tests by Microsoft show about 20 MB per second or 2 TB per day. Administrators can monitor the progress of deduplication by using Windows PowerShell or in Server Manager. After the initial dataset is processed, deduplication has minimal impact on the server, and it does not require manual maintenance.  
  
**Write path for new files**  
  
Data deduplication allows new writing directly to an NTFS volume. Files on the volume are evaluated periodically and processed if they meet the deduplication policy criteria. Deduplication processes files inside an enabled volume once per hour in the background or on additional schedules that you specify by using Throughput mode optimization jobs.  
  
**Deduplication throughput**  
  
The deduplication feature can process roughly 2 TB of data per volume in a 24\-hour period \(100 GB per hour\) when running a throughput optimization job on a single volume. Multiple volumes can run in parallel if CPU core processors and memory are available. The actual speed of deduplication is dependent on CPU, disk I\/O, memory and available server resources at the time that deduplication is running. Deduplication is designed to pause if the server starts to run out of resources so it does not impact the server’s regular workload. The busier the server is, the longer it will take to process the data. If you have a data volume that is very busy, you might consider scheduling a regular throughput optimization job during off\-peak hours. For more information, see [Optimization jobs](../Topic/Install-and-Configure-Data-Deduplication.md#BkmkOptJobs).  
  
**Running low on disk space**  
  
Running very low on disk space on a deduplicated volume is not advisable because certain types of data access operations can fail unexpectedly. For example, memory\-mapped operations on deduplicated files can fail due to lack of disk space. This is because NTFS may reserve disk space in response to paging I\/O that is triggered through memory\-mapped or buffered operations. Notepad is an example of an application that accesses files by using memory\-mapped operations. If the volume is at or near zero free space, opening deduplicated files in Notepad may return an error message that says disk access has failed. Similar data\-access failures can occur on sparse or compressed files on a full volume without deduplication installed. We recommend keeping at least one gigabyte of free space on deduplicated volumes to avoid failures.  
  
If the volume is full and you encounter file access failures, consider one of the following options to work around the issue:  
  
-   Run a Garbage Collection job to reclaim disk space by using an elevated Windows PowerShell command prompt:  
  
    ```  
    PS C:\> Start-DedupJob E: –Type GarbageCollection -full  
    ```  
  
-   Copy the files elsewhere by using a tool that supports unbuffered I\/O mode, such as XCOPY with the \/J option or Robocopy with the \/J option.  
  
## <a name="BKMK_Step2"></a>Step 3: Evaluate savings with the Deduplication Evaluation Tool  
When the deduplication feature is installed, the Deduplication Evaluation Tool \(DDPEval.exe\) is automatically installed to the \\Windows\\System32\\ directory. This tool can be copied from any server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to systems running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008 R2, or Windows 7. You can use it to determine the expected savings that you would get if deduplication is enabled on a particular volume.  
  
DDPEval.exe supports local drives, and it supports evaluating mapped or unmapped remote shares. The following example shows running DDPEval.exe by using a command syntax:  
  
```  
DDPEval <VolumePath:>  
  
C:\> DDPEVAL.EXE \\Server\Testshare  
C:\> DDPEVAL.EXE E:\Test\  
C:\> DDPEVAL.EXE F:  
  
```  
  
This will produce output similar to the following:  
  
```  
Data Deduplication Savings Evaluation Tool  
Copyright 2011-2012 Microsoft Corporation.  All Rights Reserved.  
  
Evaluated folder: E:\Test  
Processed files: 34  
Processed files size: 12.03MB  
Optimized files size: 4.02MB  
Space savings: 8.01MB  
Space savings percent: 66  
Optimized files size (no compression): 11.47MB  
Space savings (no compression): 571.53KB  
Space savings percent (no compression): 4  
Files with duplication: 2  
Files excluded by policy: 20  
Files excluded by error: 0  
```  
  
When the space savings percent is calculated, you can make an informed decision to install deduplication or not.  
  
## <a name="BKMK_Step3a"></a>Determine potential space reclamation with the Measure\-DedupFileMetadata cmdlet  
By running the Windows PowerShell **Measure\-DedupFileMetadata** cmdlet, you can determine how much potential disk space can be reclaimed on a volume if you delete a group of folders, a single folder, or a single file, and then run a Garbage Collection job. Specifically, the DedupDistinctSize value will tell you how much space you would get back if you deleted those files. Files often have chunks that are shared across other folders, so the deduplication engine will calculate which chunks are unique and would be deleted after the Garbage Collection job.  
  
Here is an example:  
  
```  
PS C:\Windows\system32> Measure-DedupFileMetadata -path X:\A_Data,X:\Archive1  
  
Path                    : {X:\A_Data, X:\Archive1}  
Volume                  : X:  
VolumeId                : \\?\Volume{88f3b478-72e9-11e1-b0f1-806e6f6e6963}  
FilesCount              : 575  
OptimizedFilesCount     : 541  
Size                    : 713.46 MB  
SizeOnDisk              : 2.44 MB  
DedupSize               : 239.81 MB  
DedupChunkCount         : 5136  
DedupDistinctSize       : 700 KB  
DedupDistinctChunkCount : 11  
  
```  
  
In this example, 700 KB of space will be reclaimed if Garbage Collection is run with the **–full** parameter.  
  
## <a name="BKMK_Step3"></a>Step 4: Plan the rollout, scalability, and deduplication policies  
When appropriate servers and volumes have been identified, you can enable the feature on the server and assign volumes. For more information, see [Install and Configure Data Deduplication](../Topic/Install-and-Configure-Data-Deduplication.md).  
  
Deduplication can be enabled locally or remotely by using Windows PowerShell or Server Manager. When it is enabled, the default policies and schedules are created.  
  
The default policy settings for data deduplication include:  
  
-   Process files that have a minimum age of five days according to the Last Modified Time. If Last Access Time is enabled on the server \(this is not the default setting\), deduplication will use the Last Access Time.  
  
-   Process files in background mode every hour. In background mode, the system uses up to 25% of the system memory during optimization jobs, whereas manual Throughput jobs use up to 50% of the system memory.  
  
-   Do not exclude any directories or file types. The default setting is to process the entire volume.  
  
-   Run a garbage collection job every Saturday at 1:45 AM. Garbage collection reclaims space on a volume by deleting chunks from the chunk store that are no longer referenced. Garbage collection compacts a container only if approximately 50 MB of chunks exist that have no references. Every fourth run of garbage collection incorporates the **\-full** parameter, which instructs the job to reclaim all available space and maximize all container compaction.  
  
-   Run a data scrubbing job every Saturday at 2:45 AM. Scrubbing jobs verify data integrity and automatically attempt to repair corruptions that are found.  
  
> [!NOTE]  
> Do not enable **NtfsDisableLastAccessUpdate** when using System Center Virtual Machine Manager \(VMM\) VHD library server, and deduplication on a hosting volume. The VMM library server will toggle the last\-access date often, preventing deduplication from optimizing files correctly.  
  
The default deduplication policy settings are usually sufficient to get excellent savings without impacting regular server workload. If a particular deployment has any of the following conditions, you might consider altering the default settings.  
  
**Potential deduplication policy settings**  
  
|Condition|Action to consider|  
|-------------|----------------------|  
|Incoming data is static or expected to be read\-only, and you want to process files on the volume sooner.|Change the MinimumFileAgeDays setting to a smaller number of days to process files earlier.|  
|You have directories that you do not want to deduplicate.|Add a directory to the exclusion list.|  
|You have file types that you do not want to deduplicate.|Add a file type to the exclusion list.|  
|The server has different off\-peak hours than the default and you want to change the Garbage Collection and Scrubbing schedules.|Update the schedules using Windows PowerShell.|  
  
