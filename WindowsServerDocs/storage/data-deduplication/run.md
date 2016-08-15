---
title:"Running Data Deduplication"  
description:""  
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

# Running Data Deduplication
> Applies to Windows Server 2016

## <a id="running-dedup-jobs-manually"></a>Running Data Deduplication Jobs Manually
Every scheduled Dedup job can be run manually with the following PowerShell cmdlets:
* [`Start-DedupJob`](https://technet.microsoft.com/en-us/library/hh848442.aspx), which starts a new Dedup job
* [`Stop-DedupJob`](https://technet.microsoft.com/en-us/library/hh848439.aspx), which stops a Dedup job already in progress (or removes it from the queue)
* [`Get-DedupJob`](https://technet.microsoft.com/en-us/library/hh848452.aspx), which shows all the active and queued Dedup jobs

All of the [settings available when scheduling a Dedup job](advanced-settings.md#modifying-job-schedules-available-settings) are available when starting a job manually, with the exception of the scheduling specific ones. For example, to start an [Optimization](understand.md#job-info-optimization) job manually with high priority and maximum CPU and memory usage, execute the following PowerShell command with administrator privilege:

```PowerShell
Start-DedupJob -Type Optimization -Volume <Your-Volume-Here> -Memory 100 -Cores 100 -Priority High
```

## <a id="monitoring-dedup"></a>Monitoring Data Deduplication
### <a id="monitoring-dedup-optimization-rates"></a>Optimization Rates

### <a id="monitoring-dedup-job-successes"></a>Job Successes

## <a id="disabling-dedup"></a>Disabling Data Deduplication