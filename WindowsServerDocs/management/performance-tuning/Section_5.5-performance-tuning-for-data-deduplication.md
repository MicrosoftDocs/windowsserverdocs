---
title: Performance Tuning for Data Deduplication
description: Performance Tuning for Data Deduplication
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ae015370-07a0-4a62-9f8d-327e1f75cfe4
author: phstee
ms.author: wgries
ms.date: 10/31/2016
---

# Performance Tuning for Data Deduplication


[Data Deduplication](http://technet.microsoft.com/library/hh831602.aspx) involves finding and removing duplication within data without compromising its fidelity or integrity. The goal is to store more data in less space by segmenting files into small variable-sized chunks (32–128 KB), identifying duplicate chunks, and maintaining a single copy of each chunk. Redundant copies of the chunk are replaced by a reference to the single copy. The chunks are compressed and then organized into special container files in the System Volume Information folder.

**In this topic:**

-   [Types of data on deduplication-enabled volumes](#typesdata)

-   [Types of job schedules](#jobs)

-   [Storage and CPU](#cpu)

-   [Memory](#memory)

-   [I/O throttling](#throttle)

-   [Garbage collection](#garbage)

## <a href="" id="typesdata"></a>Types of data on deduplication-enabled volumes


The data type suitable for Data Deduplication on general purpose file servers are the files that are written to rarely. Apps that frequently write data to files (like Microsoft SQL Server or Microsoft Exchange Server) are not recommended to be hosted on deduplication-enabled volumes. Frequently changing files may cause the deduplication job to do unnecessary optimization work which may impact performance.

For virtual machines hosted on deduplicated volumes, the only types of virtual machines that are officially supported are client operating systems supported by VDI.

## <a href="" id="jobs"></a>Types of job schedules


There are three types of Data Deduplication jobs:

-   **Optimization (daily)** Identify duplicate data and optimize duplicates away

-   **Garbage Collection (weekly)** Remove unreferenced chunks of data that were part of deleted files

-   **Scrubbing (weekly)** Identify and fix any corruptions

## <a href="" id="cpu"></a>Storage and CPU


The Data Deduplication subsystem schedules one single threaded job per volume depending on system resources. To achieve optimal throughput, consider configuring multiple deduplication volumes, up to the number of CPU cores on the file server.

## Memory


The amount of memory required by the deduplication optimization job is directly related to the number of optimization jobs that are running. During the optimization process, approximately 1 to 2 GB of RAM is necessary to process 1 TB of data per volume at maximum speed.

For example, a file server running concurrent optimization jobs on 3 volumes of 1 TB, 1 TB, and 2 TB of data respectively would need the following amount of memory, assuming a normal amount of file data changes:

<table>
<colgroup>
<col width="33%" />
<col width="33%" />
<col width="33%" />
</colgroup>
<thead>
<tr class="header">
<th>Volume</th>
<th>Volume size</th>
<th>Memory used</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Volume 1</p></td>
<td><p>1 TB</p></td>
<td><p>1-2 GB</p></td>
</tr>
<tr class="even">
<td><p>Volume 2</p></td>
<td><p>1 TB</p></td>
<td><p>1-2 GB</p></td>
</tr>
<tr class="odd">
<td><p>Volume 3</p></td>
<td><p>2 TB</p></td>
<td><p>2-4 GB</p></td>
</tr>
<tr class="even">
<td><p>Total for all volumes</p></td>
<td><p>1+1+2 * 1GB up to 2GB</p></td>
<td><p>4 – 8 GB RAM</p></td>
</tr>
</tbody>
</table>

 

By default, deduplication optimization will use up to 50% of a server’s memory. In this example, having 8 to 16 GB of memory available on the file server would allow the deduplication to optimally allocate the expected amount of RAM during optimization. Allowing optimization to use more memory would speed optimization throughput. The amount of RAM given to a job can be adjusted by using the Windows PowerShell cmdlet.

``` syntax
Start-Dedupjob <volume> -Type Optmization  -Memory <50 to 80>
```

Machines where very large amount of data change between optimization job is expected may require even up to 3 GB of RAM per 1 TB of diskspace.

## <a href="" id="throttle"></a>I/O throttling


All deduplication jobs are I/O intensive and may affect the performance of other apps when running. To alleviate potential problems, the default schedules can be modified by using Server Manager or by using the following Windows PowerShell command:

``` syntax
Set-DedupSchedule
```

To further alleviate I/O performance issues introduced by the most I/O intensive optimization jobs, I/O throttling may be manually enabled for the specific job to balance system performance. The following Windows PowerShell command to control I/O throttling:

``` syntax
Start-DedupJob <volume>  -Type Optimization -InputOutputThrottleLevel <Level>
where <Level> can be:   {None | Low | Medium | High | Maximum}
```

In the case of **Maximum**, deduplication jobs run with maximum throttling and deduplication will not make any progress in the presence of other I/Os resulting in very slow optimization. A throttle level of **None**, is the most intrusive but will process deduplication jobs fastest at the expense of all other I/O activity on the system. By default, the optimization job runs with a throttle level of **Low**.

## <a href="" id="garbage"></a>Garbage collection


For file servers that have large amounts of data that is frequently created and deleted, you might need to set the garbage collection job schedule to run more frequently to keep up with the changes and delete the stale data.

Custom Garbage Collection schedules can be set by using Server Manager or by using this Windows PowerShell command:

``` syntax
New-DedupSchedule
```
