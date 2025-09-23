---
title: Capacity planning for Active Directory Domain Services
description: Provides a detailed discussion of the factors to consider during capacity planning for Active Directory Domain Services.
ms.topic: best-practice
ms.author: roharwoo
author: robinharwood
ms.date: 09/04/2025
---

# Capacity planning for Active Directory Domain Services

This article provides recommendations for capacity planning for Active Directory Domain Services (AD DS).

## Goals of capacity planning

Capacity planning isn't the same as troubleshooting performance incidents. The goals of capacity planning are:

- Properly implement and operate an environment.
- Minimize time spent troubleshooting performance issues.

In capacity planning, an organization might have a baseline target of 40% processor utilization during peak periods to meet client performance requirements and give enough time to upgrade the hardware in the datacenter. Meanwhile, they set their monitoring alert threshold for performance issues at 90% over a five-minute interval.

When you continually exceed the capacity management threshold, then either adding more or faster processors to increase capacity or scaling the service across multiple servers would be a solution. Performance alert thresholds let you know when you need to take immediate action when performance issues negatively affect client experience. In contrast, a troubleshooting solution would be more concerned with addressing one-time events.

Capacity management is proactive: design, size, and monitor the environment so utilization trends stay within defined thresholds and scaling actions can occur before user impact. Performance troubleshooting is reactive: resolve acute conditions that are already degrading user operations.

Capacity planning for scale-up systems is about making sure that the hardware and the service can handle the load you expect. In both cases, the goal is to make sure that the system can handle the expected load while still providing a good user experience. The following architecture choices can help you meet that goal:

- Virtualization
- High speed storage such as Solid State Drives (SSDs) and NVMe (nonvolatile memory express)
- Cloud scenarios

Active Directory Domain Services (AD DS) is a mature distributed service that many Microsoft and third-party products use as a backend. It's one of the most critical components for ensuring other applications have the capacity they need.

### Important information to consider before you start planning

In order to get the most out of this article, you should do the following things:

- Make sure you've read and understand the [Performance Tuning Guidelines for Windows Server](/windows-server/administration/performance-tuning/).
- The Windows Server platform is an x64-based architecture, which provides larger memory address space compared to x86 systems. This article's guidelines apply to your Active Directory environment regardless of the Windows Server version. For current releases, the expanded x64 memory capabilities allow for caching larger databases in memory, though the capacity planning principles remain the same. The guidelines also apply if your environment has a directory information tree (DIT) that can fit entirely in the available system memory.
- Understand that capacity planning is a continuous process, so you should regularly review how well the environment you build is meeting your expectations.
- Understand that optimization occurs over multiple hardware lifecycles as hardware costs change. For example, if memory becomes cheaper, cost per core decreases, or the price of different storage options change.
- Plan for the daily peak busy period. We recommend you make your plans based on either 30 minute or hour intervals. Consider the following information when choosing your interval:
  - Intervals greater than one hour might hide when your service actually reaches peak capacity.
  - Intervals less than 30 minutes can make transient increases look more important than they actually are.
- Plan for growth over the course of the hardware lifecycle for the enterprise. This growth planning can include strategies for upgrading or adding hardware in a staggered fashion, or a complete refresh every three to five years. Each growth plan requires you estimate how much the load on Active Directory grows. Historical data can help you make a more accurate assessment.
- Fault tolerance is the ability of a system to continue operating properly when some components fail. Once you determine the capacity you need (known as *n*), you should plan for fault tolerance. Consider *n* + 1, *n* + 2, or even *n* + *x* scenarios. For example, if you need two domain controllers (DCs), plan for three so you can handle one DC failure.
  - Based on your growth plan, add extra servers according to organizational need to ensure that losing one or more servers doesn't cause the system to exceed maximum peak capacity estimates.
  - Remember to integrate your growth and fault tolerance plans. For example, one domain controller (DC) handles today’s load. Forecasts show the load doubles within a year and will need two DCs just to meet demand. That leaves no spare capacity for fault tolerance. In order to prevent this lack of capacity, you should instead plan to start with three DCs. If your budget doesn't allow for three DCs, you can also start with two DCs, then plan to add a third after three or six months.

    > [!NOTE]
    > Adding Active Directory-aware applications might have a noticeable impact on the DC load, whether the load is coming from the application servers or clients.

### The three-part capacity planning cycle

Before you start your planning cycle, you need to decide what quality of service your organization requires. All recommendations and guidance in this article are for optimal performance environments. However, you can selectively relax them in cases where you don't need optimization. For example, if your organization needs a higher level of concurrency and more consistent user experience, you should look at setting up a datacenter. Datacenters let you pay greater attention to redundancy and minimize system and infrastructure bottlenecks. In contrast, if you're planning a deployment for a satellite office with only a few users, you don't need to worry as much about hardware and infrastructure optimization, which lets you choose lower-cost options.

Next, you should decide whether to go with virtual or physical machines. From a capacity planning standpoint, there's no right or wrong answer. However, you do need to keep in mind that each scenario gives you a different set of variables to work with.

Virtualization scenarios give you two options:

- *Direct mapping*, where you have only one guest per host.
- *Shared host* scenarios, where you have multiple guests per host.

You can treat direct mapping scenarios identically to physical hosts. If you choose a shared host scenario, it introduces other variables that you should take into consideration in later sections. Shared hosts also compete for resources with Active Directory Domain Services (AD DS), which might affect system performance and user experience.

Once you answer those earlier planning questions, let's look at the capacity planning cycle itself. Each capacity planning cycle involves a three-step process:

1. Measure the existing environment, determine where the system bottlenecks currently are, and get environmental basics necessary to plan the amount of capacity your deployment needs.
1. Determine what hardware you need based on your capacity requirements.
1. Monitor and validate that the infrastructure you set up is operating within specifications. Data you collect in this step becomes the baseline for the next cycle of capacity planning.

### Applying the process

To optimize performance, ensure the following major components are correctly selected and tuned to the application loads:

- Memory
- Network
- Storage
- Processor
- Netlogon

Basic storage requirements for AD DS and the general behavior of compatible client software mean that modern server-class hardware easily meets the capacity planning needs of environments with as many as 10,000 to 20,000 users. While capacity planning remains important for all deployments, smaller environments generally have more flexibility in their hardware choices since most current server systems can handle these loads without requiring specialized optimization.

The tables in [Data collection summary tables](#data-collection-summary-tables) explain how to evaluate your existing environment to select the right hardware. The sections after that one go into more detail about baseline recommendations and environment-specific principles for hardware to help AD DS admins evaluate their infrastructure.

Other information you should keep in mind while planning:

- Any sizing based on current data is only accurate for the current environment.
- When making estimates, expect demand to grow over the lifecycle of the hardware.
- Accommodate future growth by determining whether you should oversize your environment today or gradually add capacity over the course of the lifecycle.
- All capacity planning principles and methodologies you'd apply to a physical deployment also apply to a virtualized deployment. However, when planning a virtualized environment, you need to remember to add the virtualization overhead to any domain-related planning or estimates.
- Capacity planning is a prediction, not a perfectly correct value, so don't expect it to be perfectly accurate. Always remember to adjust capacity as needed and constantly validate that your environment is working as intended.

### Data collection summary tables

The following tables list and explain criteria for determining your hardware estimates.

#### Working environment

| Component | Estimates |
|--|--|
| Storage/Database Size | 40KB to 60KB for each user |
| RAM | Database Size<br/>Base operating system recommendations<br/>Third-party applications |
| Network | 1GB |
| CPU | 1,000 concurrent users for each core |

#### High-level evaluation criteria

| Component | Evaluation criteria or performance count | Planning considerations |
|--|--|--|
| Storage/database size | [Offline defragmentation](/previous-versions/windows/it-pro/windows-2000-server/cc961769(v=technet.10)#offline-defragmentation) |  |
| Storage/database performance | <ul><li>`LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Read`</li><li>`LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Write`</li><li>`LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Transfer`</li><li>`LogicalDisk(<NTDS Database Drive>)\Reads/sec`</li><li>`LogicalDisk(<NTDS Database Drive>*\Writes/sec`</li><li>`LogicalDisk(<NTDS Database Drive>)\Transfers/sec`</li></ul> | <ul><li>Storage has two concerns to address<ul><li>Space available, which, with the size of today's spindle-based and SSD-based storage, is irrelevant for most AD environments.</li> <li>Input/Output (I/O) Operations available. In many environments, admins often overlook I/O operation availability. However, it's important to evaluate only environments where there isn't enough RAM to load the entire NTDS Database into memory.</li></ul><li>Storage is a complex subject and should involve hardware vendor expertise for proper sizing, especially with more complex scenarios such as SAN, NAS, and iSCSI. However, cost per gigabyte of storage is generally in direct opposition to cost per I/O:<ul><li>RAID 5 has lower cost per gigabyte than RAID 1, but RAID 1 has lower cost per I/O</li><li>Spindle-based hard drives have lower cost per gigabyte, but SSDs have a lower cost per I/O</li></ul><li>After you restart the computer or the AD DS service, the Extensible Storage Engine (ESE) cache is empty. Performance is disk-bound while the cache warms.</li><li>In most environments, AD is read-intensive I/O in a random pattern to disks, negating much of the benefit of caching and read optimization strategies. AD also has a larger cache in memory than most storage system caches.</li></ul> |
| RAM | <ul><li>Database size</li><li>Base operating system recommendations</li><li>Third-party applications</li></ul> | <ul><li>Storage is the slowest component in a computer. The more storage that can occupy RAM, the less needs to go to the disk.</li><li>Ensure enough RAM is allocated to store the operating system, Agents (antivirus, backup, monitoring), NTDS Database, and growth over time.</li><li>For environments where maximizing the amount of RAM isn't cost effective (such as a satellite location) or not feasible (DIT is too large), reference the Storage section to ensure that storage is properly sized.</li></ul> |
| Network | <ul><li>`Network Interface(*)\Bytes Received/sec`</li><li>`Network Interface(*)\Bytes Sent/sec` | <ul><li>In general, traffic sent from a DC far exceeds traffic sent to a DC.</li><li>As a switched Ethernet connection is full-duplex, inbound, and outbound network traffic need to be sized independently.</li><li>Consolidating the number of DCs increases the amount of bandwidth used to send responses back to client requests for each DC, but is close enough to linear for the site as a whole.</li><li>If removing satellite location DCs, don't forget to add the bandwidth for the satellite DC into the hub DCs and use that to evaluate how much WAN traffic there is.</li></ul> |
| CPU | <ul><li>`Logical Disk(<NTDS Database Drive\>)\Avg Disk sec/Read`</li><li>`Process(lsass)\% Processor Time`</li></ul> | <ul><li>After eliminating storage as a bottleneck, address the amount of compute power needed.</li><li>You can estimate the total number of processor cores needed by adding up the cores used across all servers in a site. Although this estimate isn't perfectly linear, it helps you determine how much processing power you need to support all clients. Add the minimum necessary to maintain the current level of service across all the systems within the scope.</li><li>Changes in processor speed, including power management related changes, affect numbers derived from the current environment. Generally, it's impossible to precisely evaluate how going from a 2.5-GHz processor to a 3-GHz processor reduces the number of CPUs needed.</li></ul> |
| NetLogon | <ul><li>`Netlogon(*)\Semaphore Acquires`</li><li>`Netlogon(*)\Semaphore Timeouts`</li><li>`Netlogon(*)\Average Semaphore Hold Time`</li></ul> | <ul><li>Net Logon Secure Channel/MaxConcurrentAPI only affects environments with NTLM authentications and/or PAC Validation. PAC Validation is on by default in operating system versions before Windows Server 2008. This PAC validation client setting affects the DCs until you disable it on all client systems.</li><li>Environments with significant cross trust authentication, which includes intra-forest trusts, have greater risk if not sized properly.</li><li>Server consolidations increase concurrency of cross-trust authentication.</li><li>Surges need to be accommodated, such as cluster fail-overs, as users reauthenticate en masse to the new cluster node.</li><li>Individual client systems (such as a cluster) might also need tuning.</li></ul> |

## Planning

For a long time, the typical recommendation for AD DS sizing was to put in as much RAM as the database size. Although increased compute power and switching from x86 architecture to x64 made subtler aspects of sizing for performance less important for AD DS hosted on physical machines, virtualization emphasized the importance of performance tuning.

To address those concerns, the following sections describe how to determine and plan for the demands of Active Directory as a service. You can apply these guidelines to any environment regardless of whether your environment is physical, virtualized, or mixed. To maximize your performance, your goal should be to get your AD DS environment as close to processor bound as possible.

## RAM

The more storage you can cache in the RAM, the less needs to go to disk.

To maximize server scalability, calculate your minimum RAM requirements by summing these components:

- Current database size
- Recommended amount for your operating system
- Vendor recommendations for agents, such as:
  - Antivirus programs
  - Monitoring software
  - Backup applications

You should also include extra RAM to accommodate future growth over the server's lifetime. This estimate changes based on database growth and environmental changes.

For environments where maximizing RAM isn't cost-effective or feasible, refer to the [Storage](#storage) section to properly configure your storage. These scenarios include:

- Satellite locations with budget constraints
- Deployments where the Directory Information Tree (DIT) is too large to fit in memory

Another important thing to consider for sizing memory is the page file sizing. In disk sizing, like everything else related to memory, the goal is to minimize disk usage. In particular, how much RAM do you need to minimize paging? The next few sections should give you the information you need to answer this question. Other considerations for page size that don't necessarily affect AD DS performance are operating system (OS) recommendations and configuring your system for memory dumps.

Determining how much RAM a domain controller (DC) needs can be difficult due to many complex factors:

- Existing systems aren't always reliable indicators of RAM requirements because the Local Security Authority Subsystem Service (LSASS) trims RAM under memory pressure, artificially deflating requirements.
- Individual DCs only need to cache data their clients are interested in. This means data cached in different environments change depending on what kinds of clients it contains. For example, a DC in an environment with an Exchange Server collects different data than a DC that only authenticates users.
- The amount of effort you need to evaluate RAM for each DC on a case-by-case basis is often excessive and changes as the environment changes.

The criteria behind recommendations can help you make more informed decisions:

- The more you cache in RAM, the less you need to go to disk.
- Storage is a computer's slowest component. Data access on spindle-based and SSD storage media is a million times slower than data access in RAM.

### Virtualization considerations for RAM

Your goal for optimizing RAM is to minimize time spent going to disk. Avoid memory over-commit at the host (allocating more RAM to guests than the physical machine has). Over-commit alone isn't a problem, but if total guest usage exceeds host RAM, the host pages. Paging makes performance disk-bound when the DC goes to the `NTDS.dit` or page file, or when the host pages RAM. This behavior sharply reduces performance and user experience.

### Calculation summary example

| Component | Estimated memory (example) |
|--|--|
| Base operating system recommended RAM | 4GB |
| LSASS internal tasks | 200MB |
| Monitoring agent | 100MB |
| Antivirus | 200MB |
| Database (Global Catalog) | 8.5GB |
| Cushion for backup to run and administrators to sign in without issue | 1GB |
| Total | 14GB |

**Recommended: 16GB**

Over time, more data is added to the database, and the average server lifespan is about three to five years. Based on a growth estimate of 33%, 18GB is a reasonable amount of RAM to put in a physical server.

## Network

This section is about evaluating how much total bandwidth and network capacity your deployment needs, inclusive of client queries, Group Policy settings, and so on. You can collect data to make your estimate by using the `Network Interface(*)\Bytes Received/sec` and `Network Interface(*)\Bytes Sent/sec` performance counters. Sample intervals for Network Interface counters should be either 15, 30, or 60 minutes. Anything less is too volatile for good measurements, and anything greater excessively smooths out daily peaks.

> [!NOTE]
> Generally, most network traffic on a DC is outbound as the DC responds to client queries. As a result, this section mainly focuses on outbound traffic. However, we also recommend you also evaluate each of your environments for inbound traffic. You can use the guidelines in this article to evaluate inbound network traffic requirements as well. For more information, see [929851: The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008](https://support.microsoft.com/kb/929851).

### Bandwidth needs

Planning for network scalability covers two distinct categories: the amount of traffic and the CPU load from the network traffic.

There are two things you need to take into account when capacity planning for traffic support. First, you need to know how much [Active Directory Replication Traffic](/previous-versions/windows/it-pro/windows-2000-server/bb742457(v=technet.10)) goes between your DCs. Second, you must evaluate your intrasite client-to-server traffic. Intrasite traffic mainly receives small requests from clients relative to the large amounts of data it sends back to clients. 100MB is typically enough for environments with up to 5,000 users per server. For environments of over 5,000 users, we recommend you use a 1GB network adapter and Receive Side Scaling (RSS) support instead.

To evaluate intrasite traffic capacity, particularly in server consolidation scenarios, you should look at the `Network Interface(*)\Bytes/sec` performance counter across all DCs in a site, add them together, then divide the sum by the target number of DCs. An easy way to calculate this number is to open the **Windows Reliability and Performance Monitor** and look at the **Stacked Area** view. Make sure all the counters are scaled the same.

Let's take a look at an example of a more complex way to validate that this general rule applies to a specific environment. In this example, we're making the following assumptions:

- The goal is to reduce the footprint to as few servers as possible. Ideally, one server carries the load, then you deploy another server for redundancy (*n* + 1 scenario).
- In this scenario, the current network adapter only supports 100MB and is in a switched environment.
- The maximum target network bandwidth utilization is 60% in an *n* scenario (loss of a DC).
- Each server has about 10,000 clients connected to it.

Now, let's look at what the chart in the `Network Interface(*)\Bytes Sent/sec` counter shows for this example scenario:

1. The business day starts ramping up around 5:30 AM and winds down at 7:00 PM.
1. The peak busiest period is from 8:00 AM to 8:15 AM, with greater than 25 bytes sent per second on the busiest DC.
   > [!NOTE]
   > All performance data is historical, so the peak data point at 8:15 AM indicates the load from 8:00 AM to 8:15 AM.
1. There are spikes before 4:00 AM, with more than 20 bytes sent per second on the busiest DC, which could indicate either load from different time zones or background infrastructure activity, such as backups. Since the peak at 8:00 AM exceeds this activity, it's not relevant.
1. There are five DCs in the site.
1. The maximum load is about 5.5MBps per DC, which represents 44% of the 100-MB connection. Using this data, we can estimate that the total bandwidth needed between 8:00 AM and 8:15 AM is 28MBps.
   > [!NOTE]
   > The Network Interface send/receive counters are in bytes, but the network bandwidth is measured in bits. Therefore, to calculate the total bandwidth, you'd need to do 100MB ÷ 8 = 12.5MB and 1GB ÷ 8 = 128MB.

After you review the data, what conclusions can you draw from the network utilization example?

- The current environment meets the *n* + 1 level of fault tolerance at 60% target utilization. Taking one system offline shifts the bandwidth per server from about 5.5MBps (44%) to about 7MBps (56%).
- Based on the previously stated goal of consolidating to one server, this consolidation change exceeds the maximum target utilization and possible utilization of a 100-MB connection.
- With a 1GB connection, this per‑server bandwidth value represents 22% of the total capacity.
- Under normal operating conditions in the *n* + 1 scenario, the client load is relatively distributed at about 14MBps per server or 11% of total capacity.
- To make sure you have enough capacity while a DC is unavailable, the normal operating targets per server would be about 30% network utilization or 38MBps per server. Failover targets would be 60% network utilization or 72MBps per server.

The final system deployment must have a 1GB network adapter and a connection to network infrastructure that can support the required load. Because of the amount of network traffic, the CPU load from network communications can potentially limit the maximum scalability of AD DS. You can use this same process to estimate inbound communication to the DC. However, in most scenarios, you don't need to calculate inbound traffic because it's smaller than outbound traffic.

It's important to make sure your hardware supports RSS in environments with over 5,000 users per server. In high network traffic scenarios, balancing interrupt load can become a bottleneck. You can detect potential bottlenecks by checking the `Processor(*)\% Interrupt Time` counter to see whether interrupt time is unevenly distributed across CPUs. RSS-enabled network interface controllers (NICs) can mitigate these limitations and increase scalability.

> [!NOTE]
> You can take a similar approach to estimate if you need more capacity when consolidating datacenters or retiring a DC in a satellite location. To estimate the required capacity, look at the data for outbound and inbound traffic to clients. The result is the amount of traffic present in the wide area network (WAN) links.
>
> In some cases, you might experience more traffic than expected because traffic is slower, such as when certificate checking fails to meet aggressive timeouts on the WAN. For this reason, WAN sizing and utilization should be an iterative, ongoing process.

### Virtualization considerations for network bandwidth

The typical recommendation for a physical server is a 1GB adapter for servers supporting over 5,000 users. Once multiple guests start sharing an underlying virtual switch infrastructure, confirm the host has adequate aggregate network bandwidth to support all guests. Account for bandwidth in both scenarios: when the DC runs as a VM on a host with network traffic over a virtual switch, and when it connects directly to a physical switch. Virtual switches require careful bandwidth planning. The uplink must support the aggregate data passed through it. The physical host network adapter linked to the switch must support the DC load and all other guests that share the virtual switch and connect through the physical adapter.

### Network calculation summary example

The following table contains values from an example scenario that we can use to calculate network capacity:

| System | Peak bandwidth |
|--|--|
| DC 1 | 6.5MBps |
| DC 2 | 6.25MBps |
| DC 3 | 6.25MBps |
| DC 4 | 5.75MBps |
| DC 5 | 4.75MBps |
| Total | 28.5MBps |

Based on this table, the recommended bandwidth would be 72MBps (28.5MBps ÷ 40%).

|Target system count|Total bandwidth (from the peak bandwidth)|
|-|-|
|2|28.5MBps|
|Resulting normal behavior|28.5 ÷ 2 = 14.25MBps|

As always, you should assume that client load will increase over time, so you should plan for this growth as early as possible. We recommend you plan for at least 50% estimated network traffic growth.

## Storage

There are two things you should consider when capacity planning for storage:

- Capacity or storage size
- Performance

Although capacity is important, it's important to not neglect performance. With current hardware costs, most environments aren't large enough for either factor to be a major concern. Therefore, the usual recommendation is to just put in as much RAM as the database size. However, this recommendation might be overkill for satellite locations in larger environments.

### Sizing

#### Evaluating for storage

Compared to when Active Directory first arrived at a time when 4GB and 9GB drives were the most common drive sizes, now sizing for Active Directory isn't even a consideration for all but the largest environments. With the smallest available hard drive sizes in the 180GB range, the entire operating system, `SYSVOL`, and `NTDS.dit` can easily fit on one drive. As a result, we recommend you avoid investing too heavily in storage sizing.

We recommend that 110% of the `NTDS.dit` size us available so you can defragment your storage.

Beyond this recommendation, you should take the usual considerations in accommodating future growth.

If you're going to evaluate your storage, you must first evaluate how large the `NTDS.dit` and `SYSVOL` need to be. These measurements help you size both the fixed disk and RAM allocations. Because the components are relatively low cost, you don't need to be super precise when doing the math. For more information about storage evaluation, see [Storage Limits](/previous-versions/windows/it-pro/windows-2000-server/cc961769(v=technet.10)) and [Growth Estimates for Active Directory Users and Organizational Units](/previous-versions/windows/it-pro/windows-2000-server/cc961779(v=technet.10)).

  > [!NOTE]
  > The articles linked in the previous paragraph are based on data size estimates made during the release of Active Directory in Windows 2000. When making your own estimate, use object sizes that reflect the actual size of objects in your environment.

As you review existing environments with multiple domains, you might notice variations in database sizes. When you spot these variations, use the smallest global catalog (GC) and non-GC sizes.

Database sizes can vary between OS versions. DCs running earlier OS versions have smaller database sizes than one running a later version. The DC having features like Active Directory REcycle Bin or Credential Roaming enabled can also affect database size.

> [!NOTE]
>
> - For new environments, remember that 100,000 users in the same domain consume about 450MB of space. The attributes you populate can have a huge impact on the total amount of space consumed. Many objects populate attributes, including Microsoft Exchange Server, and Skype for Business. As a result, we recommend you evaluate based on the environment's product portfolio. You should keep in mind that calculations and testing for precise estimates for all but the largest environments might not be worth significant time or effort.
> - To enable offline defrag, make sure the free space you have available is 110% of the `NTDS.dit` size. This free space also lets you plan for growth over the server's three to five year hardware lifespan. If you have the storage for it, allocating enough free space to equal 300% of the DIT size is a safe way to accommodate growth and defragging. This expansion buffer allocation simplifies future maintenance.

#### Virtualization considerations for storage

In scenarios where you allocate multiple Virtual Hard Disk (VHD) files to a single volume, you should use a fixed state disk. The disk should be at least 210% the size of the DIT to ensure you have enough space reserved for your needs. This fixed VHD size includes 100% of the DIT size plus 110% free space.

#### Storage calculation summary example

The following table lists the values you'd use to estimate the space requirements for a hypothetical storage scenario.

| Data collected from evaluation phase | Size |
|--|--|
| `NTDS.dit` size | 35GB |
| Modifier to allow for offline defrag | 2.1GB |
| Total storage needed | 73.5GB |

The storage estimate should also include more storage components beyond the database. These components include:

- SYSVOL
- Operating system files
- Page file
- Temporary files
- Local cached data, such as installer files
- Applications

### Storage performance

As the slowest component within any computer, storage can have the biggest adverse impact on client experience. For environments large enough that the RAM sizing recommendations in this article aren't feasible, the consequences of overlooking capacity planning for storage can be devastating for system performance. The complexities and varieties of available storage technology further increase risk, as the typical recommendation to put the OS, logs, and database on separate physical disks doesn't apply universally across all scenarios.

The old recommendations about disks assumed that a disk was a dedicated spindle that allowed for isolated I/O. This dedicated‑spindle assumption is no longer true due to the introduction of the following storage types:

- RAID
- New storage types and virtualized and shared storage scenarios
- Shared spindles on a Storage Area Network (SAN)
- VHD file on a SAN or network-attached storage
- Solid State Drives (SSDs)
- Nonvolatile memory express (NVMe) drives
- Tiered storage architectures, such as SSD storage tier caching larger spindle-based storage

Other workloads placed on the back-end storage can overload shared storage, such as RAID, SAN, NAS, JBOD, Storage Spaces, and VHD. These types of storage devices can present an extra consideration. For example, SAN, network, or driver issues between the physical disk and the AD application can cause throttling and delays. To clarify, these types of storage architectures aren't a bad choice, but they're more complex, which means you need to pay extra attention to make sure every component is working as intended. For more detailed explanations, see [Appendix C](#appendix-c-how-the-operating-system-interacts-with-storage) and [Appendix D](#appendix-d-storage-troubleshooting-in-environments-where-more-ram-isnt-an-option) later in this article.

This solid-state storage technology (NVMe and SSD) doesn't have the same mechanical limitations as traditional hard drives. However, they still have I/O limitations. When you exceed these limits, the system can become overloaded.

The goal of storage performance planning is to ensure that the needed number of I/Os is always available and that they happen within an acceptable timeframe. For more information about scenarios with locally attached storage, see [Appendix C](#appendix-c-how-the-operating-system-interacts-with-storage). You can apply the principles in the appendix to more complex storage scenarios, and conversations with vendors supporting your back-end storage solutions.

Due to how many storage options are available today, we recommend you consult your hardware support teams or vendors while planning to ensure the solution meets the needs of your AD DS deployment. During these conversations, you might find the following performance counters helpful, especially when your database is too large for your RAM:

- `LogicalDisk(*)\Avg Disk sec/Read` (for example, if `NTDS.dit` is stored on drive D, the full path would be `LogicalDisk(D:)\Avg Disk sec/Read`)
- `LogicalDisk(*)\Avg Disk sec/Write`
- `LogicalDisk(*)\Avg Disk sec/Transfer`
- `LogicalDisk(*)\Reads/sec`
- `LogicalDisk(*)\Writes/sec`
- `LogicalDisk(*)\Transfers/sec`

When you provide the data, you should make sure the sample intervals are 15, 30, or 60 minutes to give the most accurate picture of your current environment possible.

#### Evaluating the results

This section focuses on reads from the database, as the database is usually the most demanding component. You can apply the same logic to writes to the log file by substituting `<NTDS Log>)\Avg Disk sec/Write` and `LogicalDisk(<NTDS Log>)\Writes/sec)`.

The `LogicalDisk(<NTDS>)\Avg Disk sec/Read` counter shows whether the current storage is adequately sized. If the value is roughly equal to the expected Disk Access Time for the disk type, the `LogicalDisk(<NTDS>)\Reads/sec` counter is a valid measure. If the results are roughly equal to the Disk Access Time for the disk type, the `LogicalDisk(<NTDS>)\Reads/sec` counter is a valid measure. Although acceptable latency varies by storage vendor, good ranges for `LogicalDisk(<NTDS>)\Avg Disk sec/Read` are:

- 7,200 rpm: 9 milliseconds to 12.5 milliseconds (ms)
- 10,000 rpm: 6 ms to 10 ms
- 15,000 rpm:  4 ms to 6 ms
- SSD – 1 ms to 3 ms

You might hear from other sources that storage performance is degraded at 15 ms to 20 ms. The difference between those values and the values in the preceding list is that the list values show the normal operating range. The other values are for troubleshooting purposes, which help you identify when client experience has degraded enough that it becomes noticeable. For more information, see [Appendix C](#appendix-c-how-the-operating-system-interacts-with-storage).

- `LogicalDisk(<NTDS>)\Reads/sec` is the amount of I/O the system is currently performing.
  - If `LogicalDisk(<NTDS>)\Avg Disk sec/Read` is within the optimal range for the backend storage, you can directly use `LogicalDisk(<NTDS>)\Reads/sec` to size the storage.
  - If `LogicalDisk(<NTDS>)\Avg Disk sec/Read` isn't within the optimal range for the backend storage, more I/O is needed according to the following formula: `LogicalDisk(<NTDS>)\Avg Disk sec/Read` ÷ Physical Media Disk Access Time × `LogicalDisk(<NTDS>)\Avg Disk sec/Read`

When you're making these calculations, here are some things you should consider:

- If the server has a suboptimal amount of RAM, the resulting values might be too high and not accurate enough to be useful for planning. However, you can still use them to predict worst-case scenarios.
- If you add or optimize RAM, you also decrease the amount of read I/O `LogicalDisk(<NTDS>)\Reads/Sec`. That decrease can cause the storage solution to be less robust than the original calculations suggested. Unfortunately, we can't give more specifics about what this statement means, as calculations vary widely depending on individual environments, particularly client load. However, we do recommend that you adjust storage sizing after you optimize the RAM.

#### Virtualization considerations for performance

Similar to the previous sections, the goal for virtualization performance is to ensure the shared infrastructure can support the total load of all consumers. Keep this goal in mind when planning for the following scenarios:

- A physical CD sharing the same media on a SAN, NAS, or iSCSI infrastructure as other servers or applications.
- A user using pass-through access to a SAN, NAS, or iSCSI infrastructure that shares the media.
- A user using a VHD file on shared media locally or a SAN, NAS, or iSCSI infrastructure.

From the perspective of a guest user, having to go through a host to access any storage impacts performance, as the user must travel down more code paths to gain access. Performance testing indicates virtualizing impacts throughput based on how much of the processor the host system utilizes. Processor utilization influences how many resources the guest user demands of the host. This demand contributes to the [Virtualization considerations for processing](#virtualization-considerations-for-processing) you should take for processing needs in virtualized scenarios. For more information, see [Appendix A](#appendix-a-cpu-sizing-criteria).

Further complicating matters are how many storage options are currently available, each with wildly different performance impacts. These options include pass-through storage, SCSI adapters, and IDE. When migrating from a physical to a virtual environment, you should adjust for different storage options for virtualized guest users by using a multiplier of 1.10. However, you don't need to consider adjustments when transferring between different storage scenarios, as whether the storage is local, SAN, NAS, or iSCSI matters more.

#### Virtualization calculation example

Determining the amount of I/O needed for a healthy system under normal operating conditions:

- LogicalDisk(`<NTDS Database Drive>`) ÷ Transfers per second during the peak period 15-minute period
- To determine the amount of I/O needed for storage where the capacity of the underlying storage is exceeded:
  > *Needed IOPS* = (LogicalDisk(`<NTDS Database Drive>`)) ÷ Avg Disk Read/sec ÷ `<Target Avg Disk Read/sec>`) × LogicalDisk(`<NTDS Database Drive>`)\Read/sec

| Counter | Value |
|--|--|
| Actual LogicalDisk(`<NTDS Database Drive>`)\Avg Disk sec/Transfer | 0.02 seconds (20 milliseconds) |
| Target LogicalDisk(`<NTDS Database Drive>`)\Avg Disk sec/Transfer | 0.01 seconds |
| Multiplier for change in available I/O | 0.02 ÷ 0.01 = 2 |

| Value name | Value |
|--|--|
| LogicalDisk(`<NTDS Database Drive>`)\Transfers/sec | 400 |
| Multiplier for change in available I/O | 2 |
| Total IOPS needed during peak period | 800 |

To determine the rate at which you should warm the cache:

- Determine the maximum time you find acceptable for to spend on cache warming. In typical scenarios, an acceptable amount of time would be how long it should take to load the entire database from a disk. In scenarios where the RAM can't load the entire database, use the time it would take to fill the entire RAM.
- Determine the size of the database, excluding space that you don't plan to use. For more information, see [Evaluating for storage](#evaluating-for-storage).
- Divide the database size by 8KB to get the total number of I/Os you need to load the database.
- Divide the total I/Os by the number of seconds in the defined time frame.

The number you calculate is an approximation. It isn't exact because the Extensible Storage Engine (ESE) cache size isn't fixed. By default the cache grows and shrinks, so AD DS might evict pages it loaded earlier. A fixed cache size would make the estimate more precise.

| Data points to collect | Values |
|--|--|
| Maximum acceptable time to warm | 10 minutes (600 seconds) |
| Database size | 2GB |

| Calculation step | Formula | Result |
|--|--|--|
| Calculate size of database in pages | (2GB × 1024 × 1024) = *Size of database in KB* | 2,097,152KB |
| Calculate number of pages in database | 2,097,152KB ÷ 8KB = *Number of pages* | 262,144 pages |
| Calculate IOPS necessary to fully warm the cache | 262,144 pages ÷ 600 seconds = *IOPS needed* | 437 IOPS |

## Processing

### Evaluating Active Directory processor usage

For most environments, managing processing capacity is the component that deserves the most attention. When you're evaluating how much CPU capacity your deployment needs, you should consider the following two things:

- Do the applications in your environment behave as intended within a shared services infrastructure based on the criteria outlined in [Tracking expensive and inefficient searches](/previous-versions/ms808539(v=msdn.10)#tracking-expensive-and-inefficient-searches)? In larger environments, poorly coded applications can make the CPU load become volatile, take an inordinate amount of CPU time at the expense of other applications, drive up capacity needs, and unevenly distribute load against the DCs.
- AD DS is a distributed environment with many potential clients whose processing needs vary widely. Estimated costs for each client can vary due to usage patterns and how many applications are using AD DS. Much like in [Network](#network), you should approach estimating as an evaluation of total needed capacity in the environment instead of looking at each client one at a time.

Complete your [storage](#storage) estimate before you begin to estimate your processor usage. You can't make an accurate guess without valid data about your processor load. It's also important to make sure that your storage isn't creating any bottlenecks before troubleshooting the processor. As you remove processor wait states, CPU utilization increases because it no longer needs to wait on the data. Therefore, the performance counters you should pay the most attention to are:

- `Logical Disk(<NTDS Database Drive>)\Avg Disk sec/Read`
- `Process(lsass)\ Processor Time`

If the `Logical Disk(<NTDS Database Drive>)\Avg Disk sec/Read` counter is over 10 milliseconds or 15 milliseconds, then the data in `Process(lsass)\ Processor Time` is artificially low and the issue is related to storage performance. We recommend you set sample intervals to 15, 30, or 60 minutes for the most accurate data possible.

### Processing overview

In order to plan capacity planning for domain controllers, processing power requires the most attention and understanding. When sizing systems to ensure maximum performance, there's always a component that's the bottleneck, and in a properly sized Domain Controller this component is the processor.

Similar to the networking section where the demand of the environment is reviewed on a site-by-site basis, the same must be done for the compute capacity demanded. Unlike the networking section, where the available networking technologies far exceed the normal demand, pay more attention to sizing CPU capacity. As any environment of even moderate size; anything over a few thousand concurrent users can put significant load on the CPU.

Unfortunately, due to the huge variability of client applications that use AD, a general estimate of users per CPU is woefully inapplicable to all environments. Specifically, the compute demands are subject to user behavior and application profile. Therefore, each environment needs to be individually sized.

#### Target site behavior profile

When you're capacity planning for an entire site, your goal should be an *N* + 1 capacity design. In this design, even if one system fails during the peak period, service can still continue at acceptable levels of quality. In an *N* scenario, load across all boxes should be less than 80%-100% during peak periods.

Also, the site's applications and clients use the recommended [DsGetDcName function](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea) method for locating DCs. They should already be evenly distributed with only minor transient spikes.

Now we're going to look at two examples of environments that are on target and off target. First, we're going to take a look at an example of an environment that works as intended and doesn't exceed the capacity planning target.

For the first example, we're making the following assumptions:

- Each of the five DCs in the site has four CPUs.
- Total target CPU usage during business hours is 40% under normal operating conditions (*N* + 1) and 60% otherwise (*N*). During nonbusiness hours, the target CPU usage is 80% because we expect the backup software and other maintenance processes to consume all available resources.

Now, let's take a look at the `(Processor Information(_Total)\% Processor Utility)` chart, for each of the DCs, as shown in the following image.

:::image type="content" source="media/capacity-planning-considerations-cpu-chart.png" alt-text="A screenshot of the CPU usage chart for each domain controller.":::

- The load is evenly distributed, which is what we'd expect when clients use the DC locator and well-written searches.
- In several five-minute intervals, there are spikes at 10%, sometimes even 20%. However, unless these spikes cause the CPU usage to exceed the capacity plan target, you don't need to investigate them.
- The peak period for all systems is between 8:00 AM and 9:15 AM. The average business day lasts from 5:00 AM to 5:00 PM. Therefore, any randomized spikes of CPU usage that happen between 5:00 PM and 4:00 AM are outside of business hours, and therefore you don't need to include them in your capacity planning concerns.

  During off-peak hours, brief spikes on a well-managed system usually come from:  

  - Backup jobs  
  - Full antivirus scans  
  - Hardware inventory scans  
  - Software inventory scans  
  - Software distribution or patch deployments  

  Spikes outside these tasks might indicate an abnormal load and warrant investigation. Because these spikes happen outside of business hours, they don't count towards exceeding capacity planning targets.

- Because each system is about 40% and they all have the same number of CPUs, if one of them goes offline, the remaining systems run at an estimated 53%. System D's 40% load is then evenly split between the remaining systems and added to their existing 40% load. This linear redistribution assumption isn't perfectly accurate, but it provides enough accuracy for estimation.

Next, let's look at an example of an environment that doesn't have good CPU usage and exceeds the capacity planning target.

In this example, two DCs run at 40%. One goes offline and the remaining DC jumps to an estimated 80%. During failover this load exceeds the capacity plan threshold and shrinks headroom to 10%–20% for spikes. Each spike could now drive the DC to 90% or even 100%, reducing responsiveness.

### Calculating CPU demands

The `Process\% Processor Time` performance counter tracks the total amount of time all application threads spend on the CPU, then divides that sum by the total amount of system time that's passed. A multithreaded application on a multi-CPU system can exceed 100% CPU time, and you'd interpret its data differently than the `Processor Information\% Processor Utility` counter. In practice, the `Process(lsass)\% Processor Time` counter tracks how many CPUs running at 100% the system requires to support a process' demands. For example, if the counter has a value of 200%, that means the system needs two CPUs running at 100% to support the full AD DS load. Although a CPU running at 100% capacity is the most cost-efficient in terms of power and energy consumption, a multithreaded system is more responsive when its system isn't running on 100%. The reasons for this efficiency are outlined in [Appendix A](#appendix-a-cpu-sizing-criteria).

To accommodate transient spikes in client load, we recommend you target a peak period CPU between 40% and 60% of system capacity. For example, in the first example in [Target site behavior profile](#target-site-behavior-profile), you'd need between 3.33 CPUs (60% target) and 5 CPUs (40% target) to support the AD DS load. You should add extra capacity according to the demands of the OS and any other required agents, such as antivirus, backup, monitoring, and so on. Plan to reserve 5–10% of one CPU’s capacity for infrastructure agents (antivirus, backup, monitoring). Measure actual agent usage in your environment and adjust as needed. To revisit our example, we would need between 3.43 (60% target) and 5.1 (40% target) CPUs to support load during peak periods.

Now, let's take a look at an example of calculating for a specific process. In this case, we're looking at the LSASS process.

#### Calculating CPU usage for the LSASS process

In this example, the system is an *N* + 1 scenario where one server carries the AD DS load while an extra server is there for redundancy.

The following chart shows the processor time for the LSASS process over all processors for this example scenario. These data points come from the `Process(lsass)\% Processor Time` performance counter.

:::image type="content" source="media/capacity-planning-considerations-proc-time-chart.png" alt-text="A screenshot of the time chart for the Process LSASS Processor Time performance counter across all processors.":::

Here's what the LSASS processor time chart shows about the scenario environment:

- There are three domain controllers in the site.
- The business day starts ramping up around 7:00 AM, then ramps down at 5:00 PM.
- The busiest period of the day is from 9:30 AM to 11:00 AM.
  > [!NOTE]
  > All performance data is historical. The peak data point at 9:15 AM indicates the load from 9:00 AM to 9:15 AM.
- Spikes before 7:00 AM could indicate extra load from different time zones or background infrastructure activity, such as backups. However, since this spike is lower than peak activity at 9:30 AM, it's not a cause for concern.

At maximum load, the LSASS process consumes around 4.85 CPUs running at 100%, which would be 485% on a single CPU. These results suggest the scenario site needs about 12/25 CPUs to handle AD DS. When you bring in the recommended 5% to 10% extra capacity for background processes, the server needs 12.30 to 12.25 CPUs to support its current load. Estimates anticipating future growth make this number even higher.

### When to tune LDAP weights

There are certain scenarios where you should consider tuning [LdapSrvWeight](/previous-versions/windows/it-pro/windows-2000-server/cc957291(v=technet.10)). In the context of capacity planning, you'd tune it when your applications, user loads, or underlying system capabilities aren't evenly balanced.

The following sections describe two example scenarios where you should tune the Lightweight Directory Access Protocol (LDAP) weights.

#### Example 1: PDC emulator environment

If you're using a Primary Domain Controller (PDC) emulator, unevenly distributed user or application behavior can affect multiple environments at once. The PDC emulator usually has higher CPU load than other domain controllers. Many operations prefer or always contact it, examples include:

- Group Policy management tools (creation, editing, linking, GPMC refresh)
- Password change verification / second authentication attempts (fallback password check)
- Trust creation and maintenance operations
- Time service hierarchy (authoritative time source in the domain/forest)
- Account lockout processing
- Legacy or misconfigured applications that still target the PDC emulator

Monitor its CPU separately and plan extra headroom if these activities are common.

You should tune your PDC emulator only if there's a noticeable difference in CPU utilization. Tuning should reduce the load on the PDC emulator and increase the load on other DCs, allowing for more even load distribution.

In these cases, set the value for `LDAPSrvWeight` between 50 and 75 for the PDC emulator.

| System | CPU utilization with defaults | New LdapSrvWeight | Estimated new CPU utilization |
|--|--|--|--|
| DC 1 (PDC emulator)| 53% | 57 | 40% |
| DC 2| 33% | 100 | 40% |
| DC 3| 33% | 100 | 40% |

The catch is that if the PDC emulator role is transferred or seized, particularly to another domain controller in the site, then CPU utilization dramatically increase on the new PDC emulator.

In this example scenario, we assume based on [Target site behavior profile](#target-site-behavior-profile) that all three domain controllers in this site have four CPUs. Under normal conditions, what would happen if one of these DCs had eight CPUs? There would be two DCs at 40% utilization and one at 20% utilization. While this configuration isn't necessarily bad, there's an opportunity here for you to use LDAP weight tuning to balance the load better.

#### Example 2: environment with different CPU counts

When you have servers with different CPU counts and speeds in the same site, you need to make sure they're evenly distributed. For example, if your site has two eight-core servers and one four-core server, the four-core server only has half the processing power of the other two servers. If the client load is evenly distributed, that means the four-core server needs to work twice as hard as the two eight-core servers to manage its CPU load. On top of that, if one of the eight-core servers goes offline, the four-core server gets overloaded.

| System | Processor Information\\ % Processor Utility(_Total)<br />CPU utilization with defaults | New LdapSrvWeight | Estimated new CPU utilization |
|--|--|--|--|
| 4-CPU DC 1 | 40 | 100 | 30% |
| 4-CPU DC 2 | 40 | 100 | 30% |
| 8-CPU DC 3 | 20 | 200 | 30% |

Planning for an *N* + 1 scenario is critical. The impact of one DC going offline must be calculated for every scenario. In the previous example, load is evenly shared across all servers. In an *N* scenario (one server lost), each remaining server stays at about 60%. The current distribution is acceptable because the ratios stay consistent. When you look at the PDC emulator tuning scenario, or any general scenario where user or application load is unbalanced, the effect is different:

| System | Tuned Utilization | New LdapSrvWeight | Estimated New Utilization |
|--|--|--|--|
| DC 1 (PDC emulator) | 40% | 85 | 47% |
| DC 2 | 40% | 100 | 53% |
| DC 3 | 40% | 100 | 53% |

### Virtualization considerations for processing

When you're capacity planning for a virtualized environment, there are two levels you need to consider: the host level and the guest level. At the host level, you must identify the peak periods of your business cycle. Because scheduling guest threads on the CPU for a virtual machine is similar to getting AD DS threads on the CPU for a physical machine, we still recommend you use 40% to 60% of the underlying host. At the guest level, because the underlying thread scheduling principles are unchanged, we also still recommend you keep CPU usage within the 40% to 60% range.

For a direct-mapped setup (one guest per host), reuse the capacity planning numbers gathered earlier. Apply them directly to size this deployment.

In a shared host scenario, assume about a 10% CPU efficiency overhead from virtualization. If the site needs 10 CPUs at a 40% target utilization on physical hardware, add one more CPU for that overhead. Allocate a total of 11 virtual CPUs (vCPUs) across the *N* guest domain controllers.

In sites with mixed distributions of physical and virtual servers, this virtualization overhead only applies to the virtual machines (VMs). In an *N* + 1 design, a 10‑CPU physical (or direct-mapped) server is roughly equivalent to a virtual DC with 11 vCPUs. The host also needs another 11 CPUs reserved for that VM.

While you're analyzing and calculating how many CPUs you need to support AD DS load.  Keep in mind that if you plan to purchase physical hardware, the types of hardware available on the market might not map exactly to your estimates. However, you don't have that problem when you use virtualization. Using VMs decreases the effort needed for you to add compute capacity to a site, as you can add as many CPUs with the exact specifications you want to a VM. However, virtualization doesn't eliminate your responsibility to accurately evaluate how much compute power you need to guarantee your underlying hardware is available when guests need more CPU resources. Always plan ahead for growth.

### Virtualization calculation summary example

| System | Peak CPU |
|--|--|--|
| DC 1 | 120% |
| DC 2 | 147% |
| DC 3 | 218% |
| Total CPU usage | 485% |

| Target systems count | Total CPU count require |
|--|--|
| CPUs needed at 40% target at peak | 485% ÷ 0.4 = 12.25 |

If you project 50% demand growth over three years, plan for 18.375 CPUs (12.25 × 1.5) by that time. Alternatively, you can review demand after the first year, then add extra capacity based on what the results tell you.

### Cross-trust client authentication load for NTLM

#### Evaluating cross-trust client authentication load

Many environments might have one or more domains connected by a trust. Authentication requests for identities in other domains that don't use Kerberos need to traverse a trust using a secure channel between two domain controllers. The user’s domain controller contacts a domain controller in the destination domain or the next one along the trust path toward that domain. The **MaxConcurrentAPI* setting controls how many calls the DC can make to the other DC in the trusted domain. In order to ensure the secure channel can handle the amount of load required for the DCs to communicate with each other, you can either tune MaxConcurrentAPI or, if you're in a forest, create shortcut trusts. Learn more about how to determine traffic volume across trusts at [How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting](https://support.microsoft.com/kb/2688798).

As with the previous scenarios, you must collect data during the peak busy periods of the day in order for it to be useful.

> [!NOTE]
> Intraforest and interforest scenarios might cause the authentication to traverse multiple trusts, which means you need to tune during each stage of the process.

#### Virtualization planning

There are a few things you should keep in mind when capacity planning for virtualization:

- Many applications use NTLM authentication by default or in certain configurations.
- As the number of active clients increases, so does the need for application servers to have more capacity.
- Clients sometimes keep sessions open for a limited time and instead reconnect regularly for services like email pull sync.
- Web proxy servers that require authentication for internet access can cause high NTLM load.

These applications can create a large load for NTLM authentication, which puts significant stress on the DCs, especially when users and resources are in different domains.

There are many approaches you can take to manage cross-trust load, which often you can and should use together at the same time:

- Reduce cross-trust client authentication by locating the services that a user consumes in the domain they're located in.
- Increase the number of secure channels available. These channels are called *shortcut trusts* and are relevant to intraforest and cross-forest traffic.
- Tune the default settings for **MaxConcurrentAPI**.

To tune **MaxConcurrentAPI** on an existing server, use the following equation:

*New_MaxConcurrentApi_setting* ≥ (*semaphore_acquires* + *semaphore_time-outs*) × *average_semaphore_hold_time* ÷ *time_collection_length*

For more information, see [KB article 2688798: How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting](https://support.microsoft.com/kb/2688798).

## Virtualization considerations

There aren't any special considerations you need to make, as virtualization is an operating system tuning setting.

### Virtualization tuning calculation example

| Data type | Value |
|--|--|
| Semaphore Acquires (Minimum) | 6,161 |
| Semaphore Acquires (Maximum) | 6,762 |
| Semaphore Timeouts | 0 |
| Average Semaphore Hold Time | 0.012 |
| Collection Duration (seconds) | 1:11 minutes (71 seconds) |
| Formula (from KB 2688798) | ((6762 - 6161) + 0) × 0.012 / |
| Minimum value for **MaxConcurrentAPI** | ((6762 - 6161) + 0) × 0.012 ÷ 71 = 0.101 |

For this system for this time period, the default values are acceptable.

## Monitoring for compliance with capacity planning goals

Throughout this article, we discussed how planning and scaling go towards utilization targets. The following table summarizes the recommended thresholds you must monitor to ensure systems are operating as intended. Keep in mind that these aren't performance thresholds, just capacity planning thresholds. A server operating in excess of these thresholds still works, but you need to validate your applications are working as intended before you start seeing performance issues as user demand increases. If the applications are okay, then you should start evaluating hardware upgrades or other configuration changes.

| Category | Performance counter | Interval/Sampling | Target | Warning |
|--|--|--|--|--|
| Processor | `Processor Information(_Total)\% Processor Utility` | 60 min | 40% | 60% |
| RAM (Windows Server 2008 R2 or earlier) | `Memory\Available MB` | < 100MB | N/A | < 100MB |
| RAM (Windows Server 2012 and later) | `Memory\Long-Term Average Standby Cache Lifetime(s)` | 30 min | Must be tested | Must be tested |
| Network | `Network Interface(*)\Bytes Sent/sec`<p>`Network Interface(*)\Bytes Received/sec` | 30 min | 40% | 60% |
| Storage | `LogicalDisk((<NTDS Database Drive>))\Avg Disk sec/Read`<p>`LogicalDisk((<NTDS Database Drive>))\Avg Disk sec/Write` | 60 min | 10 ms | 15 ms |
| AD Services | `Netlogon(*)\Average Semaphore Hold Time` | 60 min | 0 | 1 second |

## Appendix A: CPU sizing criteria

This appendix discusses useful terms and concepts that can help you estimate your environment's CPU sizing needs.

### Definitions: CPU sizing

- A *processor (microprocessor)* is a component that reads and executes program instructions.

- A *multi-core processor* has multiple CPUs on the same integrated circuit.

- A *multi-CPU* system has multiple CPUs that aren't on the same integrated circuit.

- A *logical processor* is a processor that only has one logical computing engine from the perspective of the operating system.

These definitions include hyper-threaded, one core on multi-core processor, or a single core processor.

As today's server systems have multiple processors, multiple multi-core processors, and hyper-threading, these definitions are generalized to cover both scenarios. We use the term logical processor because it represents the OS and application perspective of the available computing engines.

### Thread-level parallelism

Each thread is an independent task, as each thread has its own stack and instructions. AD DS can scale well across multiple logical processors as it is multi-threaded and can be tuned the number of available threads. To learn more about tuning the available threads, follow the directions in [How to view and set LDAP policy in Active Directory by using Ntdsutil.exe](https://support.microsoft.com/kb/315071).

### Data-level parallelism

Data-level parallelism is when a service shares data across many threads for the same process and sharing many threads across multiple processes. The AD DS process alone would count as a service sharing data across several threads for a single process. Any changes to the data are reflected across all running threads in all levels of the cache, every core, and any updates to the shared memory. Performance can degrade during write operations because all memory locations adjust to the changes before instruction processing can continue.

### CPU speed versus multiple-core considerations

Faster logical processors shorten the time a single thread needs to finish its work. Adding more logical processors increases how many threads can run in parallel. However, scaling is nonlinear due to memory latency, shared resource contention, synchronization/locking, serial code paths, and scheduling overhead. As a result, scalability in multi-core systems isn't linear.

Utilization scales nonlinearly because multiple constraints interact:

- A single runnable thread finishes sooner on a faster core; adding more idle cores provides no benefit unless there's runnable parallel work.
- When a thread stalls on a cache miss or needs data from main memory, it can't make forward progress until the data returns. Faster cores don't eliminate memory latency; they may wait longer relative to their cycle rate.
- As concurrency (runnable threads) increases, synchronization, cache coherence traffic, lock contention, and scheduler overhead consume a larger percentage of total cycles.
- Wider systems (more sockets / cores) amplify latency effects for operations requiring global ordering (for example, modifying shared data, TLB shootdowns, inter-processor interrupts).
- Some code paths are serial (Amdahl's Law). Once parallel regions are saturated, extra cores contribute diminishing returns.

Therefore, adding cores or frequency only improves AD DS throughput when the workload has sufficient runnable, parallelizable work and isn't predominantly stalled on memory, storage, or lock contention.

In summary, questions about whether you should add more or faster processors become highly subjective and should be considered on a case-by-case basis. For AD DS in particular, its processing needs depend on environmental factors and can vary from server to server within a single environment. As a result, the earlier sections in this article didn't invest heavily on making super precise calculations. When you make budget-driven buying decisions, we recommend you first optimize processor usage at either 40% or whichever number your specific environment requires. If your system isn't optimized, then you don't benefit as much from buying more processors.

> [!NOTE]
> [Amdahl's law](https://wikipedia.org/wiki/Amdahl%27s_law) and [Gustafson's law](https://wikipedia.org/wiki/Gustafson%27s_law) are the relevant concepts here.

### Response time and how system activity levels impact performance

Queuing theory is the mathematical study of waiting lines, or *queues*. In queuing theory for computing, the utilization law is represented by t equation:

*U* k = *B* ÷ *T*

Where *U* k is the utilization percentage, *B* is the amount of time spent being busy, and *T* is the total time spent observing the system. In a Microsoft context, this means the number of 100-nanosecond (ns) interval threads that are in a Running state divided by how many 100-ns intervals were available in the given time interval. This is the same formula that calculates  percentage of processor utilization shown in [Processor Object](/previous-versions/ms804036(v=msdn.10)) and [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10)).

Queuing theory also provides the formula: *N* = *U* k ÷ (1 - *U* k) to estimate the number of waiting items based on utilization, where *N* is the length of the queue. Charting this equation over all utilization intervals provides the following estimates of how long the queue to get on the processor is at any given CPU load.

:::image type="content" source="media/capacity-planning-considerations-queue-length.png" alt-text="A line graph showing how long it takes for the queue to get on the processor as CPU load increases. The queue length gets longer as CPU utilization increases.":::

Based on this estimate, we can observe that after 50% CPU load, the average wait usually includes one other item in the queue, and increases rapidly to 70% CPU utilization.

To understand how queuing theory applies to your AD DS deployment, let's return to the highway metaphor we used in [CPU speed versus multiple-core considerations](#cpu-speed-versus-multiple-core-considerations).

Busier times in the mid-afternoon would fall somewhere into the 40% to 70% capacity range. There's enough traffic that your ability to choose a lane to drive in isn't severely restricted. While the chance of another driver getting in your way is high, it doesn't require the same level of effort you'd need to find a safe gap between other cars in the lane as during rush hour.

As rush hour approaches, the road system approaches 100% capacity. Changing lanes during rush hour becomes very challenging because cars are so close together that you don't have as much room to maneuver when changing lanes. Queuing behavior explains the 40% long-term average capacity target. Keeping average utilization near 40% leaves room for brief spikes (for example, slow or poorly coded queries) and larger burst events (such as the surge the morning after a holiday).

The previous statement regards the percentage of processor time calculation as being the same as the utilization law equation. This simplified version is meant to introduce the concept to new users. However, for more advanced math, you can use the following references as a guide:

- Translating the [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10))
  - *B* = The number of 100-ns intervals that Idle thread spends on the logical processor. The change in the *X* variable in the [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10)) calculation
  - *T* = the total number of 100-ns intervals in a given time range. The change in the *Y* variable in the [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10)) calculation.
  - *U* k = The utilization percentage of the logical processor by the Idle Thread or % Idle Time.
- Working out the math:
  - *U* k = 1 – %Processor Time
  - %Processor Time = 1 – *U* k
  - %Processor Time = 1 – *B* / *T*
  - %Processor Time = 1 – *X1* – *X0* / *Y1* – *Y0*

### Applying these concepts to capacity planning

The math in the previous section probably makes determining how many logical processors you need in a system seem complex. As a result, your approach to sizing the system should focus on determining maximum target utilization based on current load, then calculating the number of logical processors you need to reach that target. Furthermore, your estimate doesn't need to be perfectly exact. While logical processor speeds do have a significant impact on synchronization, other areas can also affect performance, such as:

- Cache efficiency
- Memory coherence requirements
- Thread scheduling and synchronization
- Imperfectly balanced client loads

Since compute power is relatively low-cost, it's not worth investing too much time in calculating the perfectly exact number of CPUs you need.

It's also important to remember that the 40% recommendation, in this case, isn't a mandatory requirement. We use it as a reasonable start for making calculations. Different kinds of AD users need different levels of responsiveness. Some environments can average 80%–90% CPU and still meet user expectations if queue wait times don't rise noticeably. Treat this as an exception, validate with latency data and monitor closely for emerging contention.

Other parts of the system are slower than the CPU. Tune them too. Focus on RAM access, disk access, and network response time. For example:

- If you add processors to a system running at 90% utilization that's disk-bound, it probably won't significantly improve performance. If you look more closely at the system, there are lots of threads that aren't even getting onto the processor because they're waiting for I/O operations to complete.
- Resolving disk-bound issues can mean that threads previously stuck in waiting state stop being stuck, creating more competition for CPU time. As a result, the 90% utilization goes to 100%. You need to tune both components in order to bring back down utilization to manageable levels.

  > [!NOTE]
  > The `Processor Information(*)\% Processor Utility` counter can exceed 100% with systems that have a Turbo mode. Turbo mode lets the CPU exceed the rated processor speed for short periods. If you need more information, look at the CPU manufacturers' documentation and counter descriptions.

Discussing whole-system utilization considerations also involves domain controllers as virtualized guests. [Response time and how system activity levels impact performance](#response-time-and-how-system-activity-levels-impact-performance) applies to both host and guest in a virtualized scenario. In a host with only one guest, a DC or system has almost the same performance as it would on physical hardware. Adding more guests to the hosts increases the utilization of the underlying host, also increasing wait times to get access to the processors. Therefore, you must manage logical processor utilization at both host and guest levels.

Let's revisit the highway metaphor from the previous sections, only this time we're imagining the guest VM as an express bus. Express buses, as opposed to public transit or school buses, go straight to the rider's destination without making any stops.

Now, let's imagine four scenarios:

- A system's off-peak hours are like riding an express bus late at night. When the rider gets on, there are almost no other passengers and the road is nearly empty. Because there's no traffic for the bus to contend with, the ride is easy and as fast as if the rider had driven there in their own car. However, the local speed limit can constrain the rider's travel time.
- Off-peak hours when a system's CPU utilization is too high is like a late night ride when most of the lanes on the highway are closed. Even though the bus itself is mostly empty, the road is still congested from leftover traffic dealing with the restricted lanes. While the rider is free to sit anywhere they want, their actual trip time is determined by the traffic outside of the bus.
- A system with high CPU utilization during peak hours is like a crowded bus during rush hour. Not only does the trip take longer, but getting on and off the bus is harder because the bus is full of other passengers. Adding more logical processors to the guest system to try to speed up wait times would be like trying to solve the traffic problem by adding more buses. The problem isn't the number of buses, but how long the trip takes.
- A system with high CPU utilization during off-peak hours is like that same crowded bus on a mostly empty road at night. While riders might have trouble finding seats or getting on and off the bus, the trip is fairly smooth once the bus picks up all its passengers. This scenario is the only one where performance would improve by adding more buses.

Based on the previous examples, you can see that there are many scenarios between 0% and 100% utilization that have varying degrees of impact on performance. Also, adding more logical processors doesn't necessarily improve performance outside of specific scenarios. It should be fairly simple to apply these principles to the recommended 40% CPU utilization target for hosts and guests.

## Appendix B: Considerations regarding different processor speeds

In [Processing](#processing), we assumed that the processor is running at 100% clock speed while you collect data, and that any replacement systems have the same processing speed. Despite these assumptions not being accurate, especially for Windows Server 2008 R2 and later, where the default power plan is Balanced, these assumptions still work for conservative estimates. While potential errors might increase, it only increases the margin of safety as processor speeds increase.

- For example, in a scenario that demands 11.25 CPUs, if the processors ran at half speed when you collected your data, the more accurate estimate of their demand would be 5.125 ÷ 2.
- It's impossible to guarantee that doubling clock speed doubles the amount of processing that happens within the recorded time period. The amount of time that processors spend waiting on RAM or other components stays roughly the same. Therefore, faster processors might spend a greater percentage of time idle while waiting for the system to fetch data. We recommend you stick with the lowest common denominator, keep your estimates conservative, and avoid assuming a linear comparison between processor speeds that could make your results inaccurate.

If processor speeds in your replacement hardware are lower than your current hardware, you should proportionally increase the estimate of how many processors you need. For example, let's look at a scenario where you calculate you need 10 processors to sustain your site's load. The current processors run at 3.3 GHz, and the processors you plan to replace them with run at 2.6 GHz. Replacing only the 10 original processors would give you a 21% decrease in speed. To increase speed, you need to get at least 12 processors instead of 10.

However, this variability doesn't change capacity management processor utilization targets. Processor clock speeds adjust dynamically based on load demand, so running the system under higher loads causes the CPU to spend more time in a higher clock speed state. The ultimate goal is to have the CPU be at 40% utilization in a 100% clock speed state during peak business hours. Anything less generates power savings by throttling CPU speeds during off-peak scenarios.

> [!NOTE]
> You can turn off power management on the processors during data collection by setting the power plan to **High Performance**. Turning power management off gives more accurate readings of CPU consumption in the target server.

To adjust estimates for different processors, we recommend you use the SPECint_rate2006 benchmark from Standard Performance Evaluation Corporation. To use this benchmark:

1. Go to the [Standard Performance Evaluation Corporation (SPEC) website](https://spec.org/).
1. Select **Results**.
1. Enter **CPU2006** and select **Search**.
1. In the drop-down menu for **Available Configurations**, select **All SPEC CPU2006**.
1. In the **Search Form Request** field, select **Simple**, then select **Go!**.
1. Under **Simple Request**, enter the search criteria for your target processor. For example, if you're looking for an E5-2630 processor, in the drop-down menu, select **Processor**, then enter the processor name in the search field. When finished, select **Execute Simple Fetch**.
1. Look for your server and processor configuration in the search results. If the search engine doesn't return an exact match, look for the closest match possible.
1. Record the values in the **Result** and **# Cores** columns.
1. Determine the modifier by using this equation:

   ((*Target platform per-core score value*) × (*MHz per-core of baseline platform*)) ÷ ((*Baseline per-core score value*) × (*MHz per-core of target platform*))

   For example, here's how you'd find the modifier for an E5-2630 processor:

   (35.83 × 2000) ÷ (33.75 × 2300) = 0.92

1. Multiply the number of processors you estimate you need by this modifier.

   For the E5-2630 processor example, 0.92 × 10.3 = 10.35 processors.

## Appendix C: How the operating system interacts with storage

The queuing theory concepts we discussed in [Response time and how system activity levels impact performance](#response-time-and-how-system-activity-levels-impact-performance) also apply to storage. You need to be familiar with how your OS handles I/O in order to apply these concepts effectively. In Windows operating systems, the system creates a queue that holds I/O requests for each physical disk. However, a physical disk isn't necessarily a single disk. The OS can also register an aggregation of spindles on an array controller or SAN as a physical disk. Array controllers and SANs can also aggregate multiple disks into a single array set, split it into multiple partitions, then use each partition as a physical disk, as shown in the following image.

:::image type="content" source="media/capacity-planning-considerations-block-spindles.png" alt-text="A diagram showing two block spindles divided by a partition. Each block has two rectangles inside of it labeled Data 1 and Data 2 that represent the data it stores.":::

In this illustration, the two spindles are mirrored and split into logical areas for data storage, labeled Data 1 and Data 2. The OS registers each of these logical areas as separate physical disks.

Now we've clarified what defines a physical disk. The following terms can help you better understand the information in this Appendix.

- A *spindle* is the device physically installed in the server.
- An *array* is a collection of spindles aggregated by the controller.
- An *array partition* is a partitioning of the aggregated array.
- A *Logical Unit Number (LUN)* is an array of SCSI devices connected to a computer. This article uses these terms when talking about SANs.
- A *disk* includes any spindle or partition that the OS registers as a single physical disk.
- A *partition* is a logical partitioning of what the OS registers as a physical disk.

### Operating system architecture considerations

The OS creates a First In, First Out (FIFO) I/O queue for each disk it registers. These disks can be spindles, arrays, or array partitions. When it comes to how the OS handles I/O, the more active queues, the better. When the OS serializes the FIFO queue, it must process all FIFO I/O requests issued to the storage subsystem in order of arrival. By keeping a separate I/O queue for each spindle or array, the OS prevents disks from competing for the same scarce I/O resources and keeps activity isolated to only the disks involved. However, Windows Server 2008 introduced an exception in the form of *I/O prioritization*. Applications designed to use low priority I/O are moved to the back of the queue no matter when the OS received them. Applications not coded to use the low priority setting default to normal priority instead.

### Introducing simple storage subsystems

In this section, we talk about simple storage subsystems. Let's start with an example: a single hard drive inside a computer. If we break down this system into its major storage subsystem components, here's what we get:

- One 10,000 RPM Ultra Fast SCSI HD (Ultra Fast SCSI has a 20MBps transfer rate)
- One SCSI Bus (the cable)
- One Ultra Fast SCSI Adapter
- One 32-bit 33MHz PCI bus

> [!NOTE]
> This example doesn't reflect the disk cache where the system typically keeps the data of one cylinder. In this case, the first I/O needs 10 ms and the disk reads the whole cylinder. All other sequential I/Os are satisfied by the cache. As a result, in-disk caches might improve sequential I/O performance.

Once you identify the components, you can begin to get an idea of how much data the system can transmit and how much I/O it can handle. The amount of I/O and quantity of data that can transit the system are related to each other, but not the same value. This correlation depends on the block size and whether the disk I/O is random or sequential. The system writes all data to the disk as a block, but different applications can use different block sizes.

Next, let's analyze these items on a component-by-component basis.

### Hard drive access times

The average 10,000-RPM hard drive has a 7ms seek time and a 3ms access time. Seek time is the average amount of time it takes the read or write head to move to a location on the platter. Access time is the average amount of time it takes for the head to read or write the data to disk once it's in the correct location. Therefore, the average time for reading a unique block of data in a 10,000-RPM HD includes both seek and access times for a total of approximately 10 ms, or 0.010 seconds, per block of data.

When every disk access requires the head move to a new location on the disk, the read or write behavior is called random. When all I/O is random, a 10,000-RPM HD can handle approximately 100 I/O per second (IOPS).

When all I/O occurs from adjacent sectors on the hard drive, we call it *sequential I/O*. Sequential I/O adds no extra seek time. After the first I/O finishes, the read/write head is already positioned at the next data block. For example, a 10,000-RPM HD is capable of handling approximately 333 I/O per second, based on the following equation:

1000ms per second ÷ 3ms per I/O

So far, the transfer rate of the hard drive hasn't been relevant to our example. No matter the hard drive size, the actual amount of IOPS the 10,000-RPM HD can handle is always about 100 random or 300 sequential I/Os. As block sizes change based on which application is writing to the drive, the amount of data pulled per I/O also changes. For example, if the block size is 8KB, 100 I/O operations read from or write to the hard drive a total of 800KB. However, if the block size is 32KB, 100 I/O will read or write 3,200KB (3.2MB) to the hard drive. If the SCSI transfer rate exceeds the total amount of transferred data, then getting a faster transfer rate doesn't change anything. For more information, see the following tables:

| Description | 7,200 RPM 9ms seek, 4ms access | 10,000 RPM 7ms seek, 3ms access | 15,000 RPM 4ms seek, 2ms access |
|--|--|--|--|
| Random I/O | 80 | 100 | 150 |
| Sequential I/O | 250 | 300 | 500 |

| 10,000 RPM drive | 8KB block size (Active Directory Jet) |
|--|--|
| Random I/O | 800KB/s |
| Sequential I/O | 2400KB/s |

#### The SCSI backplane

How the SCSI backplane, which in this example scenario is the ribbon cable, impacts throughput of the storage subsystem depends on block size. How much I/O can the bus handle if the I/O is in 8KB blocks? In this scenario, the SCSI bus is 20MBps, or 20480KB/s. 20480KB/s divided by 8KB blocks yields a maximum of approximately 2500 IOPS supported by the SCSI bus.

> [!NOTE]
> The figures in the following table represent an example scenario. Most attached storage devices currently use PCI Express, which provides higher throughput.

| I/O supported by SCSI bus per block size | 2KB block size | 8KB block size (AD Jet) (SQL Server 7.0/SQL Server 2000) |
|--|--|--|
| 20MBps | 10,000 | 2,500 |
| 40MBps | 20,000 | 5,000 |
| 128MBps | 65,536 | 16,384 |
| 320MBps | 160,000 | 40,000 |

As the previous table shows, in our example scenario, the bus is never a bottleneck because the spindle maximum is 100 I/O, way below any of the listed thresholds.

> [!NOTE]
> In this scenario, we're assuming that the SCSI bus is 100% efficient.

#### The SCSI adapter

In order to determine how much I/O the system can handle, you must check the manufacturer's specifications. Directing I/O requests to the appropriate device requires processing power, so how much I/O the system can handle depends on the SCSI adaptor or array controller processor.

In this example scenario, we're assuming that the system can handle 1,000 I/O.

#### The PCI bus

The PCI bus is an oft-overlooked component. In this example scenario, the PCI bus isn't the bottleneck. However, as systems scale up, it can potentially become a bottleneck in the future.

We can see how much a PCI bus can transfer data in our example scenario by using this equation:

32 bits ÷ 8 bits per byte × 33 MHz = 133MBps

Therefore, we can assume a 32 bit PCI bus operating at 33 Mhz can transfer 133MBps of data.

>[!NOTE]
>This equation's result represents the theoretical limit of transferred data. In reality, most systems only reach about 50% of maximum limit. In certain burst scenarios, the system can reach 75% of the limit for short periods.

A 66MHz 64-bit PCI bus can support a theoretical maximum of 528MBps based on this equation:

64 bits ÷ 8 bits per byte × 66Mhz = 528MBps

Adding another device (for example a network adapter or second SCSI controller) reduces the bandwidth available to the system. All devices on the bus share that bandwidth and each new device competes for limited processing resources.

#### Analyzing storage subsystems to find bottlenecks

In this scenario, the spindle is the limiting factor for how much I/O you can request. As a result, this bottleneck also limits how much data the system can transmit. Because our example is an AD DS scenario, the amount of transmittable data is 100 random I/O per second in 8KB increments, for a total of 800KB per second when you access the Jet database. By comparison, a spindle dedicated only to log files can deliver up to 300 sequential 8KB I/O per second. That equals 2,400KB (2.4MB) per second.

Now that we've analyzed the components of our example configuration, let's look at a table that demonstrates where bottlenecks can happen as we add and change components in the storage subsystem.

| Notes | Bottleneck analysis | Disk | Bus | Adapter | PCI bus |
|--|--|--|--|--|--|
| Domain controller configuration after adding a second disk. The disk configuration represents the bottleneck at 800KB/s. | Add 1 disk (Total=2)<p>I/O is random<p>4KB block size<p>10,000 RPM HD | 200 I/Os total<br />800KB/s total |  |  |  |
| After adding seven disks, the disk configuration still represents the bottleneck at 3200KB/s. | Add 7 disks (Total=8)  <p>I/O is random<p>4KB block size<p>10,000 RPM HD | 800 I/Os total.<br />3200KB/s total |  |  |  |
| After changing I/O to sequential, the network adapter becomes the bottleneck because it's limited to 1000 IOPS. | Add 7 disks (Total=8)<p>I/O is sequential<p>4KB block size<p>10,000 RPM HD |  |  | 2400 I/O sec can be read/written to disk, controller limited to 1000 IOPS |  |
| After replacing the network adapter with a SCSI adapter that supports 10,000 IOPS, the bottleneck returns to the disk configuration. | Add 7 disks (Total=8)<p>I/O is random<p>4KB block size<p>10,000 RPM HD<p>Upgrade SCSI adapter (now supports 10,000 I/O) | 800 I/Os total.<br />3,200KB/s total |  |  |  |
| After increasing the block size to 32KB, the bus becomes the bottleneck because it only supports 20MBps. | Add 7 disks (Total=8)<p>I/O is random<p>32KB block size<p>10,000 RPM HD |  | 800 I/Os total. 25,600KB/s (25MBps) can be read/written to disk.<p>The bus only supports 20MBps |  |  |
| After upgrading the bus and adding more disks, the disk remains the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI adapter with 14 disks<p>I/O is random<p>4KB block size<p>10,000 RPM HD<p>Upgrade to 320MBps SCSI bus | 2800 I/Os<p>11,200KB/s (10.9MBps) |  |  |  |
| After changing I/O to sequential, the disk remains the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI Adapter with 14 disks<p>I/O is sequential<p>4KB block size<p>10,000 RPM HD<p>Upgrade to 320MBps SCSI bus | 8,400 I/Os<p>33,600KB\s<p>(32.8MB\s) |  |  |  |
| After adding faster hard drives, the disk remains the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI adapter with 14 disks<p>I/O is sequential<p>4KB block size<p>15,000 RPM HD<p>Upgrade to 320MBps SCSI bus | 14,000 I/Os<p>56,000KB/s<p>(54.7MBps) |  |  |  |
| After increasing the block size to 32KB, the PCI bus becomes the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI adapter with 14 disks<p>I/O is sequential<p>32KB block size<p>15,000 RPM HD<p>Upgrade to 320MBps SCSI bus |  |  |  | 14,000 I/Os<p>448,000KB/s<p>(437MBps) is the read/write limit to the spindle.<p>The PCI bus supports a theoretical maximum of 133MBps (75% efficient at best). |

### Introducing RAID

When you introduce an array controller to your storage subsystem, it doesn't dramatically change its nature. The array controller only replaces the SCSI adapter in the calculations. However, the cost of reading and writing data to the disk when you use the various array levels does change.

In RAID 0, writing data stripes it across all disks in the RAID set. During a read or write operation, the system pulls data from or pushes it to each disk, increasing the amount of data the system can transmit during this particular time period. Therefore, in this example where we're using 10,000RPM drives, using RAID 0 would let you perform 100 I/O operations. The total amount of I/O the system supports is *N* spindles times 100 1/O per second per spindle, or *N* spindles × 100 I/O per second per spindle.

:::image type="content" source="media/capacity-planning-considerations-logical-d-drive.png" alt-text="A diagram showing the logical D drive in a RAID 0 deployment. The read and write operations the system performs between disks are represented by a blue line that chains each spindle together like a necklace.":::

In RAID 1, the system mirrors, or duplicates, data across a pair of spindles for redundancy. When the system performs a read I/O operation, it can read data from both spindles in the set. This mirroring makes I/O capacity for both disks available during a read operation. However, RAID 1 doesn't give write operations any performance advantages, because the system also needs to mirror written data on the pair of spindles. Although mirroring doesn't make write operations take longer, it does prevent the system from making more than one read operation at the same time. Therefore, every write I/O operation costs two read I/O operations.

The following equation calculates how many I/O operations are happening in this scenario:

*Read I/O* + 2 × *Write I/O* = *Total available disk I/O consumed*

When you know the ratio of reads to writes and the number of spindles in your deployment, you can use this equation to calculate how much I/O your array can support:

*Maximum IOPS per spindle* × 2 spindles × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 2 × *% Writes*)] = *Total IOPS*

A scenario using both RAID 1 and RAID 0 behaves exactly like RAID 1 in the cost of reading and writing operations. However, the I/O is now striped across each mirrored set. This means the equation changes to:

*Maximum IOPS per spindle* × 2 spindles × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 2 × *% Writes*)] = *Total I/O*

In a RAID 1 set, when you stripe *N* number of RAID 1 sets, the total I/O your array can process becomes *N* × I/O per RAID 1 set:

*N* × {*Maximum IOPS per spindle* × 2 spindles × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 2 × *% Writes*)]} = *Total IOPS*

We sometimes call RAID 5 *N + 1* RAID because the system stripes the data across *N* spindles and writes parity information to the *+ 1* spindle. However, RAID 5 uses more resources when performing a write I/O than RAID 1 or RAID 1 + 0. RAID 5 performs the following process every time the operating system submits a write I/O to the array:

1. Read the old data.
1. Read the old parity.
1. Write the new data.
1. Write the new parity.

Every write I/O request that the OS sends to the array controller requires four I/O operations to finish. Therefore, *N* + 1 RAID write requests take four times as long as a read I/O to finish. In other words, to determine how many I/O requests from the OS translate to how many requests the spindles get, you use this equation:

*Read I/O* + 4 × *Write I/O* = *Total I/O*

For RAID 1, once you know the read/write ratio and the number of spindles, you can use the following equation to estimate total supported I/O for the array:

*IOPS per spindle* × (*Spindles* – 1) × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 4 × *% Writes*)] = *Total IOPS*

>[!NOTE]
>The previous equation's result doesn't include the drive lost to parity.

### Introducing SANs

When you introduce a storage area network (SAN) into your environment, it doesn't affect the planning principles we've described in the earlier sections. However, you should take into account that the SAN can change the I/O behavior for all systems connected to it. A SAN adds redundancy compared to internal or direct‑attached storage. You must still plan for fault tolerance. Assume one or more paths, controllers, or shelves can fail without pushing the rest past target utilization. Also, as you introduce more components to your system, you also need to factor these new parts into your calculations.

Now, let's break down a SAN into its components:

- The SCSI or Fibre Channel hard drive
- The storage unit channel backplane
- The storage units themselves
- The storage controller module
- One or more SAN switches
- One or more host bus adapters (HBAs)
- The peripheral component interconnect (PCI) bus

When you design a system for redundancy, you must include extra components to ensure your system keeps working during a crisis scenario where one or more of the original components stop working. However, when you're capacity planning, you need to exclude redundant components from available resources to get an accurate estimate of your system's baseline capacity, as those components don't usually come online unless there's an emergency. For example, if your SAN has two controller modules, you only need to use one when calculating total available I/O throughput, as the other won't turn on unless the original module stops working. You also shouldn't bring the redundant SAN switch, storage unit, or spindles into I/O calculations.

Also, because your capacity planning only considers periods of peak usage, you shouldn't factor redundant components into your available resources. Peak utilization shouldn't exceed 80% saturation of the system in order to accommodate bursts or other unusual system behavior.

When you analyze the behavior of the SCSI or Fibre Channel hard drive, you should analyze it according to the principles we outlined in previous sections. Despite each protocol having their own advantages and disadvantages, the main thing that limits performance on a per-disk basis is the mechanical limitations of the hard drive.

When you analyze the channel on the storage unit, you should take the same approach, you did when calculating how many resources were available on the SCSI bus: divide the bandwidth by the block size. For example, if your storage unit has six channels that each support a 20MBps maximum transfer rate, your total amount of available I/O and data transfer is 100MBps. Six channels at 20MBps each give a theoretical 120MBps. We cap planned throughput at 100MBps (N+1 design). If one channel fails, the remaining five (5 × 20MBps) still deliver the required 100MBps. This example also assumes that the system is evenly distributing load and fault tolerance across all channels.

Whether you can turn the previous example into an I/O profile depends on the application behavior. For Active Directory Jet I/O, the maximum value would be approximately 12,500 I/O per second, or 100MBps ÷ 8KB per I/O.

In order to understand how much throughput your controller modules support, you also need to get their manufacturer specifications. In this example, the SAN has two controller modules that support 7,500 I/O each. If you aren't using redundancy, then the total system throughput would be 15,000 IOPS. However, in a scenario where redundancy is required, you'd calculate the maximum throughput based on the limits of only one of the controllers, which is 7,500 IOPS. Assuming that the block size is 4KB, this threshold is well below the 12,500 IOPS maximum that the storage channels can support, and is therefore the bottleneck in your analysis. However, for planning purposes, the desired maximum I/O you should plan for is 10,400 I/O.

When the data leaves the controller module, it transmits a Fibre Channel connection rated at 1GBps, or 128MBps. Because this amount exceeds the total bandwidth of 100MBps across all the storage unit channels, it won't bottleneck the system. Only one of the two Fibre Channel paths carries traffic during normal operation; the other path is reserved for redundancy. If the active path fails, the standby path takes over. It has enough capacity to handle the full data load.

The data then transits a SAN switch on its way to the server. The switch limits the amount of I/O it can handle because it needs to process the incoming request and then forward it to the appropriate port. However, you can only know what the switch limit is if you look at the manufacturer specifications. For example, if your system has two switches and each switch can handle 10,000 IOPS, the total throughput is 20,000 IOPS. Based on the rules of fault tolerance, if one switch stops working, the total system throughput is 10,000 IOPS. Therefore, during normal circumstances, you shouldn't use more than 80% utilization, or 8,000 I/O.

Finally, the HBA you install in the server also limits how much I/O it can handle. Install more HBAs for redundancy. When calculating capacity, exclude the redundant HBA. Plan as if one HBA is offline (*N* - 1) and size total available I/O on one or more remaining active HBAs.

### Caching considerations

Caches are one of the components that can significantly impact overall performance anywhere in the storage system. However, a detailed analysis of caching algorithms is beyond the scope of this article. Instead, here's a quick list of things you should know about caching on disk subsystems.

- Caching improves sustained sequential write I/O because it buffers many smaller write operations into larger I/O blocks. It also destages operations to storage in a few large blocks instead of many tiny ones. This optimization reduces total random and sequential I/O operations, making more resources available for other I/O operations.
- Caching doesn't improve sustained write I/O throughput on the storage subsystem because it only buffers writes until spindles are available to commit the data. When all available I/O from the spindles is saturated by data for long periods of time, then the cache eventually fills up. To empty the cache, you must provide enough I/O for the cache to clear itself by providing extra spindles or giving enough time between bursts for the system to catch up.
- Larger caches allow for more data to buffer, which means the cache can handle longer periods of saturation.
- In typical storage subsystems, the OS experiences improved write performance with caches, as the system only needs to write the data to the cache. However, once the underlying media is saturated with I/O operations, the cache fills up and write performance returns to regular disk speed.
- When you cache read I/O, the cache is most useful when you store data sequentially on the desk and allow the cache to read ahead. Reading ahead is when the cache can immediately move to the next sector as if the next sector contains the data the system will request next.
- When read I/O is random, caching at the drive controller doesn't increase how much data the disk can read. If the OS or application-based cache size is bigger than the hardware-based cache size, then any attempts to enhance the disk read speed don't change anything.
- In Active Directory, the cache is only limited by the amount of RAM the system holds.

### SSD considerations

Solid state drives (SSDs) are fundamentally different than spindle-based hard disks. SSDs can handle higher volumes of I/O with lower latency. While SSDs can be expensive on a cost-per-Gigabyte basis, they're cheap on a cost-per-I/O basis. Capacity planning with SSDs still asks the same core questions as with spindles: how many IOPS can they handle, and what is the latency of those IOPS?

Here are some things you should consider when planning for SSDs:

- Both IOPS and latency are subject to manufacturer designs. In some cases, certain SSD designs can perform worse than spindle-based technologies. Validate the vendor specifications for each SSD or spindle model; performance and latency vary by design. Don't treat all SSDs or all spindles as equal. Compare IOPS, latency, endurance, queue depth behavior, and firmware features per model.
- IOPS types can have different values depending on whether they're read or write. AD DS services are predominantly read-based, and therefore are less affected by which write technology you use compared to other application scenarios.
- Write endurance is the assumption that SSD cells have a limited lifespan and will eventually wear out after you use them a lot. For database drives, a predominantly read I/O profile extends the write endurance of cells to the point where you don't need to worry about write endurance that much.

### Summary

Shared storage contention occurs when multiple independent workloads compete for limited I/O operations per second (IOPS) and bandwidth on the same underlying media or interconnect. Typical contention sources include:

- Several servers using the same SAN LUN
- Multiple VMs whose virtual disks reside on the same NAS volume
- Hosts accessing common iSCSI targets over a shared fabric

When one workload generates sustained high I/O—for example backups, full antivirus scans, large directory enumerations, or bulk export or import tasks—average and tail latency for read and write operations increase for all consumers of that shared resource. Elevated latency directly reduces AD DS responsiveness if `NTDS.dit` or log I/O must wait in device queues.

Recommended remediation workflow:

1. Measure: Collect `LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Read`, `Avg Disk sec/Write`, `Reads/sec`, `Writes/sec`, and storage array statistics (queue depth, controller utilization) at 15–60 minute intervals covering peak and maintenance windows.
1. Attribute: Identify which workload is causing latency spikes (correlate with backup windows, antivirus scans, batch jobs, or VM neighbor activity). Use per‑LUN / per‑VM metrics where available.
1. Classify issue type:

   - Capacity saturation (IOPS or throughput consistently near device/controller spec and latency rising).
   - Burst interference (short high‑intensity tasks increasing tail latency but not average utilization).
   - Infrastructure chokepoint (oversubscribed HBA, switch, path failover reducing available lanes, outdated driver/firmware, misaligned multipath policy).

1. Act:

   - Rebalance or isolate heavy workloads to separate LUNs / volumes / storage tiers.
   - Stagger or reschedule backups, full antivirus scans, and defragmentation outside AD DS peak authentication/query periods.
   - Add or upgrade storage components when sustained usage stays high.
   - Ensure drivers/firmware and multipath software are current and correctly configured.
   - Right‑size RAM so frequently accessed data resides in memory, reducing read pressure on storage.

1. Validate: Confirm post‑change latency returns to target (for example, 2–6 ms SSD/NVMe, 4–12 ms spindle) and that peak queue depth remains within acceptable limits.

Potential chokepoints that mimic or exacerbate storage contention include oversubscribed switches or host bus adapters sharing lanes.

Check and rule these out before you add more disks or move to faster media.

Always pair latency data with queue length and device/controller utilization to determine whether to optimize, reschedule, or scale out.

Key success criteria:

- Sustained `Avg Disk sec/Read` and `Avg Disk sec/Write` within target latency band during peak AD DS load.
- There are no prolonged periods where IOPS plateau and latency climbs. If observed this could indicate saturation.
- Heavy maintenance tasks execute during defined maintenance windows without pushing production latency above thresholds.

If targets aren't met after scheduling and configuration adjustments, proceed to capacity expansion or migration to higher‑performance storage tiers.

## Appendix D: storage troubleshooting in environments where more RAM isn't an option

Many storage recommendations before virtualized storage served two purposes:

- Isolating I/O to prevent performance issues on the OS spindle from impacting performance for the database and I/O profiles.
- Taking advantage of the performance boost that spindle-based hard drives and caches can give your system when used with the sequential I/O of AD DS log files. Isolating sequential I/O to a separate physical drive can also increase throughput.

With new storage options, a lot fundamental assumptions behind earlier storage recommendations are no longer true. Virtualized storage scenarios, such as iSCSI, SAN, NAS, and Virtual Disk image files, often share underlying storage media across multiple hosts. Shared‑storage negates the assumptions that you must isolate I/O and optimize sequential I/O. Now other hosts that access the shared media can reduce responsiveness to the domain controller.

You should consider the following when capacity planning for storage performance:

- Cold cache state
- Warm cache state
- Backup and restore

The *cold cache* state is when you initially reboot the domain controller or restart the Active Directory service, so there's no Active Directory data in the RAM. A *warm cache* state is when the domain controller is operating in a steady state and has cached the database. In terms of performance design, warming a cold cache is like a sprint, while running a server with a fully warmed cache is like a marathon. Defining these states and the different performance profiles they drive is important, as you need to consider them both when estimating capacity. For example, just because you have enough RAM to cache the entire database during a warm cache state doesn't help you optimize performance during cold cache state.

For both cache scenarios, the most important thing is how fast storage can move data from disk to memory. When you warm the cache, over time performance improves as queries reuse data, the cache hit rate increases, and the frequency of going to the disk to retrieve data decreases. As a result, adverse performance impacts from having to go to the disk also decrease. Any performance degradations are temporary and usually go away when the cache reaches its warm state and the maximum size the system allows.

You can measure how quickly the system can get data from the disk by measuring the available IOPS in Active Directory. How many available IOPS there are is also subject to how many IOPS are available in the underlying storage. You should also consider planning for some exceptional states, for example:

- Cache warm-up after a reboot
- Backup operations
- Restore operations

Treat these as exceptional states. Run them during off-peak hours. Their duration and impact depend on current domain controller load, so no universal sizing rule applies beyond scheduling them outside peak periods.

In most scenarios, AD DS is predominantly read I/O with a ratio of 90% read to 10% write. Read I/O is the typical bottleneck for user experience, while write I/O is the bottleneck that degrades write performance. Caches tend to provide minimal benefit to read I/O because I/O operations for the `NTDS.dit` file are predominantly random. Therefore, your main priority is to make sure you correctly configure the read I/O profile storage.

Under normal operating conditions, your storage planning goal is to minimize wait times for the system to return requests from AD DS to the disk. The number of outstanding and pending I/O operations should be less than or equal to the number of pathways in the disk. For performance monitoring scenarios, we generally recommend that the `LogicalDisk((<NTDS Database Drive>))\Avg Disk sec/Read` counter should be less than 20 ms. Set the operating threshold close to the native storage latency. Target 2–6 ms, choosing the lower end for faster media (NVMe/SSD) and the higher end for slower tiers.

The following line graph shows the disk latency measurement within a storage system.

:::image type="content" source="media/capacity-planning-considerations-storage-latency.png" alt-text="A line graph showing the disk latency within a storage system. An area on the right side of the chart has a maroon circle drawn around it.":::

Let's analyze this line graph:

- The area on the left of the chart that's circled in green shows the latency is consistent at 10 ms as the load increases from 800 IOPS to 2,400 IOPS. This latency baseline is affected by what kind of storage solution you use.
- The area on the right side of the chart circled in maroon shows the system throughput between the baseline and the end of data collection. The throughput itself doesn't change, but the latency increases. This area shows what happens when request volume passes the storage system's physical limit. Requests sit in the queue longer before the disk serves them.

Now, let's think about what this data tells us.

First, let's assume a user querying membership of a large group requires the system read 1MB of data from the disk. You can evaluate the amount of I/O required and how long the operations take with these values:

- The size of each Active Directory database page is 8KB.
- The minimum number of pages the system needs to read is 128.
- Therefore, at the baseline area in the diagram, the system should take at least 1.28 seconds to load the data from the disk and return it to the client. At the 20ms mark, where the throughput goes well above the recommended maximum, the process takes 2.5 seconds.

Based on those numbers, you can calculate how fast the cache warms by using this equation:

2,400 IOPS × 8KB per I/O

After running this calculation, we can say that the cache warm rate in this scenario is 20MBps. In other words, the system loads about 1GB of database into the RAM every 53 seconds.

>[!NOTE]
>It's normal to see latency go up for short periods while components are aggressively reading or writing to the disk. For example, latency increases when the system is backing up or AD DS runs garbage collection. You should provide extra room for these periodic events on top of your original usage estimates. Your goal is to give enough throughput to accommodate these spikes without affecting overall functioning.

There's a physical limit to how quickly the cache warms based on how you design the storage system. The only thing that can warm the cache up to the rate the underlying storage can accommodate are incoming client requests. Running scripts to try to prewarm the cache during peak hours competes with real client requests, increases overall load, loads data that's not relevant to client requests, and degrades performance. We recommend you avoid using artificial measures to warm the cache.
