---
title: Optimize the size of staging folders
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c8a66fda-b6ab-4a0d-8fe3-adeb2eb5489f
author: JasonGerend
---
# Optimize the size of staging folders
DFS Replication uses staging folders for each replicated folder to act as caches for new and changed files that are ready to be replicated from sending members to receiving members. These files are stored under the local path of the replicated folder in the DfsrPrivate\\Staging folder.  
  
By default, the quota size of each staging folder is 4,096 MB, and the quota size of each Conflict and Deleted folder is 660 MB. The size of each folder on a member is cumulative per volume, so if there are multiple replicated folders on a member, DFS Replication creates multiple staging and Conflict and Deleted folders, each with its own quota.  
  
Optimizing the size of the staging folder can improve performance and reduce the likelihood of replication failing. When adjusting the size of the staging folder, consider the following factors:  
  
-   If a staging folder quota is configured to be too small, DFS Replication might consume additional CPU and disk resources to regenerate the staged files. Replication might also slow down, or even stop, because the lack of staging space can effectively limit the number of concurrent transfers with partners.  
  
    > [!IMPORTANT]  
    > For the initial replication of existing data on the primary member, the staging folder quota must be large enough so that replication can continue even if multiple large files remain in the staging folder because partners cannot promptly download the files.  
    >   
    > To properly size the staging folder for initial replication, you must take into account the size of the files to be replicated. At a minimum, the staging folder quota should be at least the size of the 32 largest files in the replicated folder, or the 16 largest files for read\-only replicated folders. To improve performance, set the size of the staging folder quota as close as possible to the size of the replicated folder.  
    >   
    > To determine the size of the largest files in a replicated folder using Windows Explorer, sort by size and add the 32 largest file sizes \(16 if it’s a read\-only replicated folder\) to get the minimum staging folder size. To get the recommended minimum staging folder size \(in gigabytes\) from a Windows PowerShell® command prompt, use this Windows PowerShell command where *<replicatedfolderpath>* is the path to the replicated folder \(change `32` to `16` for read\-only replicated folders\):  
    >   
    > `(Get-ChildItem` *<replicatedfolderpath>* `-recurse –force | Sort-Object length -descending | select-object -first 32 | measure-object -property length -sum).sum /1gb`  
  
-   Increase the staging folder quota when you must replicate multiple large files that change frequently.  
  
-   If possible, increase the staging folder quota on hub members that have many replication partners.  
  
-   If free disk space is a concern, you might need to configure the staging quota to be lower than the default quota when several replicated folders share staging space on the same volume.  
  
-   During normal operation, if the event that indicates the staging quota \(event ID 4208 in the DFS Replication event log\) is over its configured size and is logged multiple times in an hour, increase the staging quota by 20 percent.  
  
-   To improve input\/output \(I\/O\) throughput, locate staging folders and replicated folders on different physical disks. This can be done by editing the path of the staging folder.  
  
> [!NOTE]  
> The staging quota for DFS Replication is not a hard limit, and it can grow over its configured size, unlike the staging quota for FRS. When the quota is reached, DFS Replication deletes old files from the staging folder to reduce the disk usage under the quota. The staging folder does not reserve hard disk space, and it only consumes as much disk space as is currently needed.  
  
