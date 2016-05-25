---
title: Troubleshoot Preseeding for Initial Synchronization in DFS Replication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e8a7d9d6-ab32-4e69-ab75-19636febea15
author: JasonGerend
---
# Troubleshoot Preseeding for Initial Synchronization in DFS Replication
If you encounter problems while you are preseeding files for Distributed File System \(DFS\) Replication \(also known as DFSR or DFS\-R\), or you find later that all of the files and folders have mismatched hashes, you will need to troubleshoot. This topic explains how to resolve issues that are most commonly reported in forums and Microsoft Customer Support Services.  
  
Guidance for following issues is provided:  
  
-   [Mismatched hashes](#BKMK_MismatchedHashes)  
  
-   [Missing files and folders](#BKMK_MissingFiles)  
  
-   [Poor copy or restore performance](#BKMK_PoorPerformance)  
  
## <a name="BKMK_MismatchedHashes"></a>Troubleshoot mismatched hashes  
If you find that files or folders on the source and destination servers have mismatched hashes, validate the following:  
  
-   If you used Robocopy to preseed files for DFS Replication, check for the following issues:  
  
    -   Ensure that the downstream server did not already contain the destination folder before you copied the folder and its contents. If the destination folder already exists on the destination server, the permissions are not copied correctly to the root folder.  
  
    -   Ensure that you included the **\/copyall** option when you ran Robocopy.exe.  
  
-   If you used a third\-party backup solution, ensure that your backup utility restores files without altering the security or alternate data streams. Contact the backup vendor to confirm this capability.  
  
## <a name="BKMK_MissingFiles"></a>Troubleshoot missing files and folders  
If you find that files are missing after preseeding, validate the following:  
  
-   If you used Robocopy to preseed files for DFS Replication, check for the following issues:  
  
    -   Ensure that you provided the **\/E \/B** options during the copy.  
  
    -   Examine the Robocopy log file for files that were skipped because of exclusive locks.  
  
-   If you restored from a backup:  
  
    -   Verify that the backup you restored included the files.  
  
    -   Examine the restore log to ensure that no files were skipped during the restore.  
  
-   If you are using security software such as anti\-malware protection, ensure that files were not deleted or quarantined during copy or restore from backup because of virus heuristics.  
  
## <a name="BKMK_PoorPerformance"></a>Troubleshoot poor copy or restore performance  
If copy or restore performance is slower than expected, validate the following:  
  
-   If you are using security software such as anti\-malware protection, ensure that file scanning that the security software performs is not affecting performance. Consider setting exclusions for the replicated folders.  
  
-   If you are copying large amounts of data over slower, lower\-bandwidth, or high\-latency networks, consider copying during off\-peak hours, when more throughput is available. Alternatively, ship a copy of the data using a physical mail or package service.  
  
-   Ensure that you have installed the latest networking drivers from your vendors.  
  
-   If you are using Robocopy, check for the following issues:  
  
    -   Ensure that you specified an appropriate **\/MT** \(multithread\) value to ensure maximum throughput \(an **\/MT** value of 64 is recommended\). If you are copying mostly large files \(multi\-Gigabyte or larger\), consider using the **\/j** option if that option is supported by your version of Robocopy.  
  
    -   Ensure that you are not using the **\/zb** options, as this might be slower than copying with just **\/b** \(Backup mode\) in some versions of Robocopy. The **\/zb** options together copy files in Uses Restart mode; however, if access is denied, the files are copied Backup mode.  
  
    -   Ensure that **\/R:6 \/W:5** or similar settings are used, to ensure that copying is not blocked by long\-running retries for a file. If **\/R** and **\/W** are not set, the default behavior is for Robocopy to retry each file 1 million times, waiting 30 seconds between each retry \(that is, Robocopy might wait one full year for a file\).  
  
## Related resources  
  
-   [DFS Replication: Copying Files to Preseed or Stage Initial Synchronization](../Topic/DFS-Replication--Copying-Files-to-Preseed-or-Stage-Initial-Synchronization.md)  
  
-   [Step 1: Preseed Files for DFS Replication](../Topic/Step-1--Preseed-Files-for-DFS-Replication.md)  
  
-   [Step 2: Validate Preseeded Files for DFS Replication](../Topic/Step-2--Validate-Preseeded-Files-for-DFS-Replication.md)  
  
