---
title: Using Storage-related Parameters and Performance Counters
description: Using Storage-related Parameters and Performance Counters
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0bf254d6-80da-4ad9-868c-9c3dc6fc8334
author: phstee
ms.author: Vshankar;Danlo; KaranMe
ms.date: 10/31/2016
---

# Using Storage-related Parameters and Performance Counters


This topic describes performance counters that you can use for workload characterization and capacity planning and to identify potential storage subsystem bottlenecks.

**In this topic:**

-   [I/O priorities](#io)

-   [Logical disks and physical disks](#logical)

-   [Processor information](#proc)

-   [Power protection and advanced performance option](#power)

-   [Block alignment (DISKPART)](#diskpart)

-   [Solid-state drives](#solidstate)

-   [Trim and unmap capabilities](#trim)

-   [Response times](#bkmk-responsetimes)

-   [Queue lengths](#bkmk-queuelengths)

## <a href="" id="io"></a>I/O priorities


Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 can specify an internal priority level on individual I/Os. Windows Server primarily uses this ability to lower the priority of background I/O activity and to give precedence to response-sensitive I/Os (for example, multimedia). However, extensions to file system APIs let applications specify I/O priorities per handle. The storage stack logic to sort out and manage I/O priorities has overhead, so if some disks will be targeted by only a single priority of I/Os (such as database disks), you can improve performance by using the SetupDiOpenDeviceInterfaceRegKey or SetupDiCreateDeviceInterfaceRegKey APIS to get a handle to the device parameters for the interface you want to modify. You can then use that handle to set the IdlePrioritySupported value.

## <a href="" id="logical"></a>Logical disks and physical disks


On servers that have heavy I/O workloads, you should enable the disk counters on a sampling basis or in specific scenarios to diagnose storage-related performance issues. Continuously monitoring disk counters can incur up to a few percent CPU overhead penalty.

The same counters are valuable in the logical disk and the physical disk counter objects. Logical disk statistics are tracked at the volume level, and physical disk statistics are tracked by the partition manager.

The following counters are exposed through volume and partition managers:

-   **% Idle Time**

    This counter is of little value when multiple physical drives are behind logical disks. Imagine a subsystem of 100 physical drives presented to the operating system as five disks, each backed by a 20-disk RAID 0+1 array. Now imagine that you span the five disks to create one logical disk (volume x). One can assume that any serious system that needs that many physical disks has at least one outstanding request to volume *x* at any given time. This makes the volume appear to be 0% idle, when in fact the 100-disk array could be up to 99% idle with only a single request outstanding.

-   **% Disk Time, % Disk Read Time, % Disk Write Time**

    The % disk time counter is nothing more than the average disk queue length counter multiplied by 100. It is the same value displayed in a different scale.

    If the Avg. Disk Queue Length is equal to 1, the % disk time will equal 100. If the average disk queue length is 0.37, then the % disk time will be 37. So if the average disk queue length value is greater than 1, the % disk time will be greater than 100%. The same logic applies to the % disk read time and % disk write time counters. Their data comes from the average disk read queue length and average disk write queue length counters, respectively

-   **Average Disk Bytes / { Read | Write | Transfer }**

    This counter collects average, minimum, and maximum request sizes. If possible, you should observe individual or sub-workloads separately. You cannot differentiate multimodal distributions by using average values if the request types are consistently interspersed.

-   **Average Disk Queue Length, Average Disk { Read | Write } Queue Length**

    These counters collect concurrency data, including peak loads and workloads that contain significant bursts. These counters represent the number of requests that are active below the driver that takes the statistics. This means that the requests are not necessarily queued; they could actually be in service or completed and on the way back up the path. Possible active locations include the following:

    -   Waiting in an ATA port queue or a storport queue

    -   Waiting in a queue in a miniport driver

    -   Waiting in a disk controller queue

    -   Waiting in an array controller queue

    -   Waiting in a hard disk queue (that is, on board a physical disk)

    -   Actively receiving service from a physical disk

    -   Completed, but not yet back up the stack to where the statistics are collected

    It is important to note that these values are not strictly accurate; rather, they are derived values. Average Disk Queue Length is equal to (Disk Transfers/sec) \* (Disk sec/Transfer). This is based on [Little’s Law](http://en.wikipedia.org/wiki/Little%27s_law) from the mathematical theory of queues. The same derivation is performed for the read and write versions of this counter. The main concern for interpreting these values is that they make the assumption that the number of outstanding requests is the same at the start and the end of each sampling interval. For guidelines, see [Performance Tuning for Subsystems](performance-tuning-for-subsystems.md#bkmk-queuelengths).

-   **Average disk second / {Read | Write | Transfer}**

    These counters collect disk request response time data and possibly extrapolate service time data. They are probably the most straightforward indicators of storage subsystem bottlenecks. If possible, you should observe individual or sub-workloads separately. You cannot differentiate multimodal distributions by using Performance Monitor if the requests are consistently interspersed. For guidelines, see [Response times](#bkmk-responsetimes).

-   **Current disk queue length**

    This counter instantly measures the number of active requests; therefore, it is subject to extreme variance. This counter is of limited use except to check for the existence of many short bursts of activity or to validate specific instances of the Average Disk Queue Length counter values. As described earlier, these values are derived rather than measured, and they rely on the number of outstanding requests being equal at the start and end of each sampling interval.

-   **Disk bytes / second, Disk {read | write } bytes / second**

    This counter collects throughput data. If the sample time is long enough, a histogram of the array’s response to specific loads (queues, request sizes, and so on) can be analyzed. If possible, you should observe individual or sub-workloads separately.

-   **Disk {Reads | Writes | Transfers } / second**

    This counter collects throughput data. If the sample time is long enough, a histogram of the array’s response to specific loads (queues, request sizes, and so on) can be analyzed. If possible, you should observe individual or sub-workloads separately.

-   **Split I/O / second**

    This counter measures the rate of high-level I/Os split into multiple low-level I/Os due to file fragmentation. It is useful only if the value is not statistically significant in comparison to the disk I/O rate. If it becomes significant, in terms of split I/Os per second per physical disk, further investigation could be needed to determine the size of the original requests that are being split and the workload that is generating them.

**Note**  
If the standard stacked drivers scheme in Windows is circumvented for a controller, monolithic drivers can assume the role of partition manager or volume manager. If so, the monolithic driver writer must supply the counters listed earlier through the Windows Management Instrumentation (WMI) interface, or the counters will not be available.

 

## <a href="" id="proc"></a>Processor information


-   **% DPC time, % Interrupt time, % Privileged time**

    If the interrupt time and deferred procedure call (DPC) time are a large part of privileged time, the kernel is spending a long time processing I/Os. Sometimes, it is best to keep interrupts and DPCs affinitized to only a few CPUs on a multiprocessor system to improve cache locality. At other times, it is best to distribute the interrupts and DPCs among many CPUs to prevent the interrupt and DPC activity from becoming a bottleneck on individual CPUs.

-   **DPCs queued / second**

    This counter is another measurement of how DPCs are using CPU time and kernel resources.

-   **Interrupts / second**

    This counter is another measurement of how interrupts are using CPU time and kernel resources. Modern disk controllers often combine or coalesce interrupts so that a single interrupt processes multiple I/O completions. Of course, there is a trade-off between delaying interrupts (and therefore completions) and amortizing CPU processing time.

## <a href="" id="power"></a>Power protection and advanced performance option


The following two performance-related options for every disk are located under Disk &gt; Properties &gt; Policies:

-   Enable write caching on the device

-   Enable **Turn off Windows write-cache buffer flushing on the device** mode that assumes the storage is protected against power failures

Enable write caching means that the storage hardware can indicate to the operating system that a write request is complete, even though the data has not been flushed from the volatile intermediate hardware caches to its final nonvolatile storage location. With this action, a period of time passes during which a power failure or other catastrophic event could result in data loss. However, this period is typically fairly short because write caches in the storage hardware are usually flushed during any period of idle activity. Cache flushes are also requested frequently by the operating system, NTFS, or some apps, to explicitly force writes to be written to the final storage medium in a specific order. Alternately, hardware time-outs at the cache level might force dirty data out of the caches.

Other than cache flush requests, the only means of synchronizing writes is to tag them as write-through. Storage hardware is supposed to guarantee that write-through request data has reached nonvolatile storage (such as magnetic media on a disk platter) before it indicates a successful request completion to the operating system. Some commodity disks or disk controllers may not honor write-through semantics. In particular, SATA and USB storage components may not support the ForceUnitAccess flag that is used to tag write-through requests in the hardware. Enterprise storage subsystems typically use battery-backed write caching or use SAS/SCSI/FC hardware to correctly maintain write-through semantics. In Windows Server 2012 R2, NTFS exclusively uses cache flushes to protect its metadata.

The **Turn off Windows write-cache buffer flushing on the device** disk policy option is available only when write caching is enabled. This option strips all write-through flags from disk requests and removes all flush-cache commands from the request stream. If you have power protection (such as an uninterruptible power supply, or UPS) for all hardware write caches along the I/O path, you do not need to worry about write-through flags and cache flushes. By definition, any dirty data that resides in a power-protected write cache is safe, and it appears to have occurred in-order to the software. If power is lost to the final storage location while the data is being flushed from a write cache, the cache manager can retry the write operation after power has been restored to the relevant storage components.

## <a href="" id="diskpart"></a>Block alignment (DISKPART)


NTFS aligns its metadata and data clusters to partition boundaries in increments of the cluster size (which is selected during file system creation or set by default to 4 KB). Prior to Windows Server 2008, the partition boundary offset for a specific disk partition could be misaligned when it was compared to array disk stripe unit boundaries. This caused small requests to be unintentionally split across multiple disks. To force alignment, you were required to use diskpar.exe or DiskPart.exe at the time the partition was created.

In Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008, partitions are created by default with a 1 MB offset, which provides good alignment for the power-of-two stripe unit sizes that are typically found in hardware. If the stripe unit size is set to a size that is greater than 1 MB, the alignment issue is much less of an issue because small requests rarely cross large stripe unit boundaries.

**Note**  
Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 default to a 64 KB offset if the disk is smaller than 4 GB.

 

If alignment is still an issue, even with the default offset, you can use DiskPart.exe to force alternative alignments when you create a partition.

## <a href="" id="solidstate"></a>Solid-state drives


Previously, the cost of large quantities of nonvolatile memory used as block storage was prohibitive for most server configurations. Exceptions included aerospace or military applications in which the high shock and vibration tolerance of solid-state storage is highly desirable.

As the cost of flash memory continues to decrease, new hierarchies of storage become feasible, where nonvolatile memory (NVM) is used to improve the storage subsystem response time on servers. The typical vehicle for incorporating NVM in a server is the solid-state drive (SSD). One cost-effective strategy is to place only the hottest data of a workload into nonvolatile memory. In Windows Server 2012, as in previous versions of Windows Server, partitioning can be performed only by applications that store data on an SSD; Windows operating systems have not tried to dynamically determine what data should optimally be stored on SSDs versus rotating media. It has changed with Windows Server 2012 R2 and Storage Spaces which allow data placement and migration to be performed without human intervention. This is called *tiering*. For more info about tiering, see [Using Storage Spaces for Storage Subsystem Performance](using-storage-spaces-for-storage-subsystem-performance.md#bkmk-tieredstorage).

Choosing suitable SSDs to complement the hierarchy is a tradeoff between the cost of the additional storage layer, endurance of the media (with associated servicing costs), improved responsiveness of the system, and improved energy efficiency. Current server SSDs are designed around one or more types of flash memory. Some important flash memory characteristics include:

-   Cost per capacity is orders of magnitude higher than for the rotational media, while SSD access times are 2-3 orders of magnitude better for random I/Os.

-   Read latency is substantially lower than write latency.

-   Media lifetime is limited by the number of erase cycles and write operations.

-   SSDs are inherently parallel devices, and they operate better with longer I/O queues.

-   Power consumption of an SSD may spike with load, especially for random workloads. Contrary to many claims, an SSD’s power efficiency needs to be evaluated relative to the load, and it is not always superior to that of a hard disk drive.

SSDs are commonly grouped by their designers along the axes of performance (especially latency), price per capacity, and endurance. Server-grade SSDs are designed to withstand substantially higher I/O pressure by overprovisioning flash media, which increases cost per capacity. Besides overprovisioning, another method is to use higher quality flash, such as Single Level Cell (SLC) and Multiple Level Cell (eMLC), that can support higher write cycles but has a higher cost per gigabyte. Therefore, server SSDs can support much higher random write IOPS rates, while being marginally better at read rates than desktop SSDs. Throughput characteristics of SSDs are improving with time, with the rapid rate of changes currently in the industry making it crucial to consult up-to-date performance, power, and reliability comparison data.

Due to superior media performance, the interconnect to the SSD plays an important role. While most of the client and entry-level server designs settled on using SATA interconnect (SATA version 3.0 becoming dominant recently) as the most compatible, better operation characteristics may be achieved by using newer, PCIe-based interconnect schemes. PCIe SSDs bring substantial advantages, like more scalable throughput, lower latency, and, in some cases, improved energy efficiency relative to throughput. One of the drawbacks of this technology is its relative immaturity, creating vertically integrated silos based on proprietary driver stacks. To evaluate PCIe SSDs, it is important to test complete combinations of the storage device, server platform, and software layer, including the impact of reliability and maintainability on the total cost of ownership (TCO).

## <a href="" id="trim"></a>Trim and unmap capabilities


Windows Server 2012 and Windows Server 2012 R2 provides storage allocation transparency to storage devices, including traditional storage arrays, hard disk drives, SSDs, and Storage Spaces. Although this transparency is critical for reducing capacity utilization in thinly provisioned environments, it can also have an important impact on performance and power consumption. Providing greater visibility into what’s allocated for storage devices from a holistic view enables the devices to make better resource utilization decisions that result in higher performance. In addition, because the storage footprint for a deployment is reduced, power consumption can be reduced also.

The storage stack in Windows Server 2012 and Windows Server 2012 R2 will issue standards-based trims or unmaps for any Storage Space that becomes unallocated, even within virtualized environments. Further, the new Storage Optimizer runs automatically to help further reduce the physical footprint of the data by consolidating data from sparsely populated slabs to more densely populated slabs.

Together, these technologies can help improve performance and power consumption. You should investigate whether your storage devices support Trim or Unmap commands to ensure an efficient and performant deployment.

## <a href="" id="bkmk-responsetimes"></a>Response times


You can use tools such as Performance Monitor to obtain data on disk request response times. Write requests that enter a write-back hardware cache often have very low response times (less than 1 ms) because completion depends on dynamic RAM (DRAM) speeds instead of rotating disk speeds. The data is lazily written to disk media in the background. As the workload begins to saturate the cache, response times increase until the write cache’s only potential benefit is a better ordering of requests to reduce positioning delays.

For JBOD arrays, reads and writes have approximately the same performance characteristics. Writes can be slightly longer due to additional mechanical settling delays. With modern hard disks, positioning delays for random requests are 5 to 15 ms. Smaller 2.5-inch drives have shorter positioning distances and lighter actuators, so they generally provide faster seek times than comparable larger 3.5-inch drives. Positioning delays for sequential requests should be insignificant except for streams of write-through requests, where each positioning delay should approximate the required time for a complete disk rotation. (Write-through requests are typically identified by the ForceUnitAccess (FUA) flag on the disk request.)

Transfer times are usually less significant when they are compared to positioning delays, except for large or sequential requests, which are instead dominated by disk media access speeds as the requests become larger or more sequential. Modern enterprise disks access their media at 50 to 150 MB/s depending on rotation speed and sectors per track, which varies across a range of blocks on a specific disk model. The outermost tracks can have up to twice the sequential throughput of innermost tracks.

If the stripe unit size is well chosen, each request is serviced by a single disk—except for low-concurrency workloads. So, the same general positioning and transfer times still apply.

For simple implementations of mirrored arrays, a write completion must wait for both disks to complete the request. Depending on how the requests are scheduled, the two completions of the requests could take a long time. Although writes for mirrored arrays generally should not take twice the time to complete, they are typically slower than a JBOD configuration. Reads can experience a performance increase if the array controller is dynamically load balancing or factoring in spatial locality. More complex implementations may use logging or battery-backed write caching or other means to improve write latencies.

For RAID 5 arrays (rotated parity), small writes become four separate requests in the basic read-modify-write scenario. In the best case, this is approximately the equivalent of two mirrored reads plus a full rotation of the two disks that hold the data and corresponding parity, if you assume that the read/write pairs continue in parallel.

You must consider the performance effect of redundancy on read and write requests when you plan subsystems or analyze performance data. For example, Performance Monitor might show that 50 writes per second are being processed by volume x, but in reality, this could mean 100 requests per second for a mirrored array virtual disk, 200 requests per second for a RAID 5 array or parity virtual disk, or even more than 200 requests per second if the requests are split across stripe units.

Use the following response-time guidelines if no workload details are available:

-   As a baseline, on under-loaded storage subsystems, there is a floor of performance where read/write response times will match the manufacturer specifications for average seek times (incorporating command times, head movement, rotational latency, etc.). As per above, 5 to 15 ms. This model is also true for SSDs (with different values). When there is an increase over this floor that means that the volume of IO is exceeding the nominal specifications of the storage, or aggregate specifications in the case of an array. That means items are queuing. However, queuing, and in turn waiting on access to the media is not in and of itself not bad, it is just when the wait times become excessive. Excessive being a subjective concept to the demands of the application. However, the following two bullets providing suggestions for consideration.

-   For a high priority applications system, average write response times should be less than 25 ms on RAID 5 or RAID 6, and less than 15 ms on non-RAID 5 or non-RAID 6 disks. Average read response times should be less than 15 ms regardless.

-   For a low priority system that is not saturated, average write response times should be less than 75 ms on RAID 5 or RAID 6, and less than 50 ms on non-RAID 5 or non-RAID 6 disks. Average read response times should be less than 50 ms.

## <a href="" id="bkmk-queuelengths"></a>Queue lengths


This is a mathematically derived counter according to Little’s Law, N = A \* T (N = Queue Length, A = I/O per second, T = seconds per IO). As a result, the math works out such that this is relevant and easily translate nicely for scenarios where the number of physicals disks in the server are known. While still an accurate measure as storage becomes a more abstract concept, including the thin provisioning model and data-tiering, it becomes harder to effectively use this information. Essentially, the fact that all spindles are the same and exclusively available to the server/application is no longer valid.

As a result, several opinions exist about what constitutes excessive disk request queuing. These topics assume that the boundary between a busy disk subsystem and a saturated subsystem is a persistent average of two requests per physical disk. A disk subsystem is near saturation when every physical disk is servicing a request and has at least one queued-up request to maintain maximum concurrency—that is, to keep the data pipeline flowing. In this guideline, disk requests that split into multiple requests (because of striping or redundancy maintenance) are considered multiple requests.

This rule has caveats, because most administrators do not want all physical disks constantly busy. Because disk activity often occurs in bursts, this rule is more likely applied over shorter periods of peak time. Requests are typically not uniformly spread among all hard disks at the same time, so you must consider deviations between queues—especially for workloads that contain significant bursts. Conversely, a longer queue provides more opportunity for disk request schedulers to reduce positioning delays or to optimize for full stripe RAID 5 writes or mirrored read selection.

Because hardware has an increased capability to queue requests—either through multiple queuing agents along the path or through agents with more queuing capability—increasing the multiplier threshold might allow more concurrency within the hardware. This creates a potential increase in response time variance, however. Ideally, the additional queuing time is balanced by increased concurrency and reduced mechanical positioning times.

Use the following queue length targets when few workload details are available:

-   For a lightly loaded system, the average queue length should be less than one per physical disk, with occasional spikes of 10 or less. If the workload is write heavy, the average queue length above a mirrored array or virtual disk should be less than 0.6 per physical disk and the average queue length above a RAID 5 or RAID 6 array or a parity virtual disk should be less than 0.3 per physical disk.

-   For a heavily loaded system that is not saturated, the average queue length should be less than 2.5 per physical disk, with infrequent spikes up to 20. If the workload is write heavy, the average queue length above a mirrored array or virtual disk should be less than 1.5 per physical disk, and the average queue length above a RAID 5 array or parity virtual disk should be less than 1.0 per physical disk.

-   For workloads of sequential requests, larger queue lengths can be tolerated because services times, and therefore response times, are much shorter than those for a random workload.
