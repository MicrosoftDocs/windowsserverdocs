---
ms.assetid: f15c02d7-1cbd-4eba-a571-0ea34ab93ef4
title: Running Data Deduplication
ms.technology: storage-deduplication
ms.prod: windows-server-threshold
ms.topic: article
author: wmgries
manager: klaasl
ms.author: wgries
ms.date: 09/15/2016
---
# Running Data Deduplication

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

## <a id="running-dedup-jobs-manually"></a>Running Data Deduplication jobs manually

You can run every scheduled Data Deduplication job manually by using the following PowerShell cmdlets:
* [`Start-DedupJob`](https://technet.microsoft.com/library/hh848442.aspx): Starts a new Data Deduplication job
* [`Stop-DedupJob`](https://technet.microsoft.com/library/hh848439.aspx): Stops a Data Deduplication job already in progress (or removes it from the queue)
* [`Get-DedupJob`](https://technet.microsoft.com/library/hh848452.aspx): Shows all the active and queued Data Deduplication jobs

All [settings that are available when you schedule a Data Deduplication job](advanced-settings.md#modifying-job-schedules-available-settings) are also available when you start a job manually except for the scheduling-specific settings. For example, to start an [Optimization](understand.md#job-info-optimization) job manually with high priority, maximum CPU usage, and maximum memory usage, execute the following PowerShell command with administrator privilege:

```PowerShell
Start-DedupJob -Type Optimization -Volume <Your-Volume-Here> -Memory 100 -Cores 100 -Priority High
```

## <a id="monitoring-dedup"></a>Monitoring Data Deduplication

### <a id="monitoring-dedup-job-successes"></a>Job successes

Because Data Deduplication uses a post-processing model, it is important that [Data Deduplication jobs](understand.md#job-info) succeed. An easy way to check the status of the most recent job is to use the [`Get-DedupStatus`](https://technet.microsoft.com/library/hh848437.aspx) PowerShell cmdlet. Periodically check the following fields:

* For the [Optimization job](understand.md#job-info-optimization), look at `LastOptimizationResult` (0 = Success), `LastOptimizationResultMessage`, and `LastOptimizationTime` (should be recent).
* For the [Garbage Collection job](understand.md#job-info-gc), look at `LastGarbageCollectionResult` (0 = Success), `LastGarbageCollectionResultMessage`, and `LastGarbageCollectionTime` (should be recent).
* For the [Integrity Scrubbing job](understand.md#job-info-scrubbing), look at `LastScrubbingResult` (0 = Success), `LastScrubbingResultMessage`, and `LastScrubbingTime` (should be recent).

> [!Note]  
> More detail on job successes and failures can be found in the Windows Event Viewer under `\Applications and Services Logs\Windows\Deduplication\Operational`.

### <a id="monitoring-dedup-optimization-rates"></a>Optimization rates

One indicator of [Optimization job](understand.md#job-info-optimization) failure is a downward-trending optimization rate which might indicate that the Optimization jobs are not keeping up with the rate of changes, or churn. You can check the optimization rate by using the [`Get-DedupStatus`](https://technet.microsoft.com/library/hh848437.aspx) PowerShell cmdlet.

> [!Important]
> `Get-DedupStatus` has two fields that are relevant to the optimization rate: `OptimizedFilesSavingsRate` and `SavingsRate`. These are both important values to track, but each has a unique meaning.
> - `OptimizedFilesSavingsRate` applies only to the files that are 'in-policy' for optimization (`space used by optimized files after optimization / logical size of optimized files`).
> - `SavingsRate` applies to the entire volume (`space used by optimized files after optimization / total logical size of the optimization`).

## <a id="disabling-dedup"></a>Disabling Data Deduplication
To turn off Data Deduplication, run the [Unoptimization job](understand.md#job-info-unoptimization). To undo volume optimization, run the following command:

```PowerShell
Start-DedupJob -Type Unoptimization -Volume <Desired-Volume>
```

> [!Important]  
> The Unoptimization job will fail if the volume does not have sufficient space to hold the unoptimized data.

## <a id="faq"></a>Frequently Asked Questions
**Is there a System Center Operations Manager Management Pack available to monitor Data Deduplication?**  
Yes. Data Deduplication can be monitored through the System Center Management Pack for File Server. For more information, see the  [Guide for System Center Management Pack for File Server 2012 R2](https://download.microsoft.com/download/6/F/7/6F7A33B9-9383-48ED-9252-23C2C8AD1BDA/MPGuide_FileServer2012R2.doc) document.
