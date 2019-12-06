---
title: Hardware considerations in AD performance tuning
description: Hardware considerations in AD performance tuning
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: TimWi; ChrisRob; HerbertM; KenBrumf;  MLeary; ShawnRab
author: phstee
ms.date: 10/16/2017
---

# Hardware considerations in ADDS performance tuning 

>[!Important]
> The following is a summary of the key recommendations and considerations to optimize server hardware for Active Directory workloads covered in greater depth in the [Capacity Planning for Active Directory Domain Services](https://go.microsoft.com/fwlink/?LinkId=324566) article. Readers are highly encouraged to review [Capacity Planning for Active Directory Domain Services](https://go.microsoft.com/fwlink/?LinkId=324566) for a greater technical understanding and implications of these recommendations.

## Avoid going to disk

Active Directory caches as much of the database as memory allows. Fetching pages from memory are orders of magnitude faster than going to physical media, whether the media is spindle or SSD based. Add more memory to minimize disk I/O.

-   Active Directory Best Practices recommend putting enough RAM to load the entire DIT into memory, plus accommodate the operating system and other installed applications, such as anti-virus, backup software, monitoring, and so on.

    -   For limitations of the legacy platforms, see [Memory usage by the Lsass.exe process on domain controllers that are running Windows Server 2003 or Windows 2000 Server](https://support.microsoft.com/kb/308356).

    -   Use the Memory\\Long-Term Average Standby Cache Lifetime (s) &gt; 30 minutes performance counter.

-   Put the operating system, logs, and the database on separate volumes. If all or the majority of the DIT can be cached, once the cache is warmed and under a steady state, this becomes less relevant and offers a little more flexibility in storage layout. In scenarios where the entire DIT cannot be cached, the importance of splitting the operating system, logs, and database on separate volumes becomes more important.

-   Normally, I/O ratios to the DIT are about 90% read and 10% write. Scenarios where write I/O volumes significantly exceed 10% - 20% are considered write-heavy. Write-heavy scenarios do not greatly benefit from the Active Directory cache. To guarantee the transactional durability of data that is written to the directory, Active Directory does not perform disk write caching. Instead, it commits all write operations to the disk before it returns a successful completion status for an operation, unless there is an explicit request not to do this. Therefore, fast disk I/O is important to the performance of write operations to Active Directory. The following are hardware recommendations that might improve performance for these scenarios:

    -   Hardware RAID controllers

    -   Increase the number of low-latency/high-RPM disks hosting the DIT and log files

    -   Write caching on the controller

-   Review the disk subsystem performance individually for each volume. Most Active Directory scenarios are predominantly read-based, thus the statistics on the volume hosting the DIT are the most important to inspect. However, do not overlook monitoring the rest of the drives, including the operating system, and log files drives. To determine if the domain controller is properly configured to avoid storage being the bottleneck for performance, reference the section on Storage Subsystems for standards storage recommendations. Across many environments, the philosophy is to ensure that there is enough head room to accommodate surges or spikes in load. These thresholds are warning thresholds where the head room to accommodate surges or spikes in load becomes constrained and client responsiveness degrades. In short, exceeding these thresholds is not bad in the short term (5 to 15 minutes a few times a day), however a system running sustained with these sorts of statistics is not fully caching the database and may be over taxed and should be investigated.

    -   Database ==&gt; Instances(lsass/NTDSA)\\I/O Database Reads Averaged Latency &lt; 15ms

    -   Database ==&gt; Instances(lsass/NTDSA)\\I/O Database Reads/sec &lt; 10

    -   Database ==&gt; Instances(lsass/NTDSA)\\I/O Log Writes Averaged Latency &lt; 10ms

    -   Database ==&gt; Instances(lsass/NTDSA)\\I/O Log Writes/sec – informational only.

        To maintain consistency of data, all changes must be written to the log. There is no good or bad number here, it is only a measure of how much the storage is supporting.

-   Plan non-core disk I/O loads, such as backup and anti-virus scans, for non-peak load periods. Also, use backup and anti-virus solutions that support the low-priority I/O feature introduced in Windows Server 2008 to reduce competition with I/O needs of Active Directory.

## Don't over tax the processors

Processors that don't have enough free cycles can cause long wait times on getting threads on to the processor for execution. Across many environments, the philosophy is to ensure that there is enough head room to accommodate surges or spikes in load to minimize impact on client responsiveness in these scenarios. In short, exceeding the below thresholds is not bad in the short term (5 to 15 minutes a few times a day), however a system running sustained with these sorts of statistics doesn't provide any head room to accommodate abnormal loads and can easily be put into an over taxed scenario. Systems spending sustained periods above the thresholds should be investigated to how to reduce processor loads.

-   For more info on how to select a processor, see [Performance Tuning for Server Hardware](../../hardware/index.md).

-   Add hardware, optimize load, direct clients elsewhere, or remove load from the environment to reduce CPU load.

-   Use the Processor Information(\_Total)\\% Processor Utilization &lt; 60% performance counter.

## Avoid overloading the network adapter

Just like with processors, excessive network adapter utilization will cause long wait times for the outbound traffic to get on to the network. Active Directory tends to have small inbound requests and relatively to significantly larger amounts of data returned to the client systems. Sent data far exceeds received data. Across many environments, the philosophy is to ensure that there is enough head room to accommodate surges or spikes in load. This threshold is a warning threshold where the head room to accommodate surges or spikes in load becomes constrained and client responsiveness degrades. In short, exceeding these thresholds is not bad in the short term (5 to 15 minutes a few times a day), however a system running sustained with these sorts of statistics is over taxed and should be investigated.

-   For more info on how to tune the network subsystem, see [Performance Tuning for Network Subsystems](../../../../networking/technologies/network-subsystem/net-sub-performance-top.md).

-   Use the Compare NetworkInterface(\*)\\Bytes Sent/Sec with NetworkInterface(\*)\\Current Bandwidth performance counter. The ratio should be less than 60% utilized.

## See also
- [Performance tuning Active Directory Servers](index.md)
- [LDAP considerations](ldap-considerations.md)
- [Proper placement of domain controllers and site considerations](site-definition-considerations.md)
- [Troubleshooting ADDS performance](troubleshoot.md) 
- [Capacity Planning for Active Directory Domain Services](https://go.microsoft.com/fwlink/?LinkId=324566)