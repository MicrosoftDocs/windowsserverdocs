---
title: Capacity planning for Active Directory Domain Services
description: Provides a detailed discussion of the factors to consider during capacity planning for Active Directory Domain Services.
ms.topic: article
ms.author: wscontent
author: teresa-motiv
ms.date: 7/3/2019
---

# Capacity planning for Active Directory Domain Services

This article provides recommendations for capacity planning for Active Directory Domain Services (AD DS).

<!--Should I have deleted the author information?-->

## Goals of capacity planning

Capacity planning isn't the same as troubleshooting performance incidents. The goals of capacity planning are:

- Properly implement and operate an environment.
- Minimize time spent troubleshooting performance issues.

In capacity planning, an organization might have a baseline target of 40% processor utilization during peak periods to meet client performance requirements and give enough time to upgrade the hardware in the datacenter. Meanwhile, they set their monitoring alert threshold for performance issues at 90% over a five-minute interval.

When you continually exceed the capacity management threshold, then either adding more or faster processors to increase capacity or scaling the service across multiple servers would be a solution. Performance alert thresholds let you know when you need to take immediate action when performance issues negatively affect client experience. In contrast, a troubleshooting solution would be more concerned with addressing one-time events.

Capacity management is like the preventative measures you'd take to avoid a car accident, such as defensive driving, making sure the brakes are working properly, and so on. Performance troubleshooting is more like when the police, fire department, and emergency medical professionals respond to an accident. In summary, capacity management is “defensive driving,” Active Directory-style.

Over the last several years, capacity planning guidance for scale-up systems has changed dramatically. The following changes in system architectures have challenged fundamental assumptions about designing and scaling a service:

- 64-bit server platforms
- Virtualization
- Increased attention to power consumption
- SSD storage
- Cloud scenarios

The approach to capacity planning is also shifting from server-based planning exercises to service-based ones. Active Directory Domain Services (AD DS), a mature distributed service that many Microsoft and third-party products use as a backend, is now one the most critical products in ensuring your other applications have the the necessary capacity to run.

### Important information to consider before you start planning

<!--Should I have changed this title? At first I thought it was a prerequisites section, but now I'm not so sure if I'm changing the intended meaning.-->

In order to get the most out of this article, you should do the following things:

- Make sure you've read and understand the [Performance Tuning Guidelines for Windows Server 2012 R2](/previous-versions/dn529133(v=vs.85)).
- Understand that the Windows Server platform is an x64-based architecture. Also, you must understand that this article's guidelines still apply even if your Active Directory environment is installed on Windows Server 2003 x86 (now beyond the end of the support lifecycle) and has a directory information tree (DIT) that's smaller than 1.5 GB and can easily be stored in memory.
- Understand that capacity planning is a continuous process, so you should regularly review how well the environment you build is meeting your expectations.
- Understand that optimization will occur over multiple hardware lifecycles as hardware costs change. For example, if memory becomes cheaper, cost per core decreases, or the price of different storage options change.
- Plan for the peak busy period of every day. We recommend you make your plans based on either 30 minute or hour intervals. Intervals greater than one hour may hide when your service actually reaches peak capacity, and intervals less than 30 minutes can give you inaccurate information that makes transient increases look more important than they actually are.
- Plan for growth over the course of the hardware lifecycle for the enterprise. This planning can include strategies for upgrading or adding hardware in a staggered fashion, or a complete refresh every three to five years. Each growth plan will require you estimate how much the load on Active Directory will grow. Historical data can help you make a more accurate assessment.
- Plan for fault tolerance. Once you've derived the estimate *N*, plan for scenarios that include *N* &ndash; 1, *N* &ndash; 2, and *N* &ndash; *x*.
  - Based on your growth plan, add additional servers according to organizational need to ensure that losing one or more servers doesn't cause the system to exceed maximum peak capacity estimates.
  - Also remember that you must integrate your growth and fault tolerance plans. For example, if you know your deployment currently requires one domain controller (DC) to support the load but your estimate says the load will double in the next year and require two DCs to carry, then your system doesn't have enough capacity to support fault tolerance. In order to prevent this lack of capacity, you should instead plan to start with three DCs. If your budget doesn't allow for three DCs, you can also start with two DCs, then plan to add a third after three or six months.

    > [!NOTE]
    > Adding Active Directory-aware applications might have a noticeable impact on the DC load, whether the load is coming from the application servers or clients.

### The three-part capacity planning cycle

Before you start your planning cycle, you need to decide what quality of service your organization requires. All recommendations and guidance in this article are for optimal performance environments. However, you can selectively relax them in cases where you don't need optimization. For example, if your organization needs a higher level of concurrency and more consistent user experience, you should look at setting up a datacenter. Datacenters let you pay greater attention to redundancy and minimize system and infrastructure bottlenecks. In contrast, if you're planning a deployment for a satellite office with only a few users, you don't need to worry as much about hardware and infrastructure optimization, which will let you choose lower-cost options.

Next, you should decide whether to go with virtual or physical machines. From a capacity planning standpoint, there's no right or wrong answer. However, you do need to keep in mind that each scenario gives you a different set of variables to work with.

Virtualization scenarios give you two options:

- *Direct mapping*, where you have only one guest per host.
- *Shared host* scenarios, where you have multiple guests per host.

You can treat direct mapping scenarios identically to physical hosts. If you choose a shared host scenario, it introduces other variables that you should take into consideration that we discuss in a later section. <!--Missing link to future section?--> Shared hosts also compete for resources with Active Directory Domain Services (AD DS), which may affect system performance and user experience.

Now that we've answered those questions, let's look at the capacity planning cycle itself. Each capacity planning cycle involves a three-step process:

1. Measure the existing environment, determine where the system bottlenecks currently are, and get environmental basics necessary to plan the amount of capacity your deployment needs.
1. Determine what hardware you need based on your capacity requirements.
1. Monitor and validate that the infrastructure you set up is operating within specifications. Data you collect in this step becomes the baseline for the next cycle of capacity planning.

### Applying the process

To optimize performance, ensure the following major components are correctly selected and tuned to the application loads:

- Memory
- Network
- Storage
- Processor
- Net Logon <!--Is "logon" the right word to use?-->

Basic storage requirements for AD DS and the general behavior of compatible client software allows environments with as many as 10,000 to 20,000 users to ignore capacity planning for physical hardware, as most modern server-class systems can already handle a load that size. However, the tables in [Data collection summary tables](#data-collection-summary-tables) explain how to evaluate your existing environment to select the right hardware. The sections after that one go into more detail about baseline recommendations and environment-specific principles for hardware to help AD DS admins evaluate their infrastructure.

Other information you should keep in mind while planning:

- Any sizing based on current data will only be accurate for the current environment.
- When making estimates, expect demand to grow over the lifecycle of the hardware.
- Accommodate future growth by determining whether you should oversize your environment today or gradually add capacity over the course of the lifecycle.
- All capacity planning principles and methodologies you'd apply to a physical deployment also apply to a virtualized deployment. However, when planning a virtualized environment, you need to remember to add the virtualization overhead to any domain-related planning or estimates.
- Capacity planning is a prediction, not a perfectly correct value, so don't expect it to be perfectly accurate. Always remember to adjust capacity as needed and constantly validate that your environment is working as intended.

### Data collection summary tables

The following tables list and explain criteria for determining your hardware estimates.

#### New environment

<!--This title...doesn't really explain what's going on here. I think these need to be more specific, and maybe have in intro giving more context to the tables.-->

<!--What should I do about tags for lists, etc? Should I rework these sections into plain bulleted lists with no tables?-->

| Component | Estimates |
|--|--|
| Storage/Database Size | 40 KB to 60 KB for each user |
| RAM | Database Size<br />Base operating system recommendations<br />Third-party applications |
| Network | 1 GB |
| CPU | 1000 concurrent users for each core |

#### High-level evaluation criteria

| Component | Evaluation criteria | Planning considerations |
|--|--|--|
| Storage/database size | The section called “To activate logging of disk space that is freed by defragmentation” in [Offline defragmentation](/previous-versions/windows/it-pro/windows-2000-server/cc961769(v=technet.10)#offline-defragmentation) |  |
| Storage/database performance | <ul><li>`LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Read`, `LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Write`, `LogicalDisk(<NTDS Database Drive>)\Avg Disk sec/Transfer`</li><li>`LogicalDisk(<NTDS Database Drive>)\Reads/sec`, `LogicalDisk(<NTDS Database Drive>*\Writes/sec`, "`LogicalDisk(<NTDS Database Drive>)\Transfers/sec`"</li></ul> | <ul><li>Storage has two concerns to address<ul><li>Space available, which, with the size of today's spindle-based and SSD-based storage, is irrelevant for most AD environments.</li> <li>Input/Output (IO) Operations available. In many environments, admins often overlook IO operation availablilty. However, it's important to evaluate only environments where there isn't enough RAM to load the entire NTDS Database into memory.</li></ul><li>Storage can be a complex topic and should involve hardware vendor expertise for proper sizing, especially with more complex scenarios such as SAN, NAS, and iSCSI. However, cost per gigabyte of storage is generally in direct opposition to cost per IO:<ul><li>RAID 5 has lower cost per gigabyte than RAID 1, but RAID 1 has lower cost per IO</li><li>Spindle-based hard drives have lower cost per gigabyte, but SSDs have a lower cost per IO</li></ul><li>After you restart the computer or the AD DS service, the Extensible Storage Engine (ESE) cache is empty and performance is disk-bound while the cache warms.</li><li>In most environments, AD is read-intensive IO in a random pattern to disks, negating much of the benefit of caching and read optimization strategies. AD also has a much larger cache in memory than most storage system caches.</li></ul> |
| RAM | <ul><li>Database size</li><li>Base operating system recommendations</li><li>Third-party applications</li></ul> | <ul><li>Storage is the slowest component in a computer. The more storage that can occupy RAM, the less needs to go to the disk.</li><li>Ensure enough RAM is allocated to store the operating system, Agents (antivirus, backup, monitoring), NTDS Database and growth over time.</li><li>For environments where maximizing the amount of RAM is not cost effective (such as a satellite locations) or not feasible (DIT is too large), reference the Storage section to ensure that storage is properly sized.</li></ul> |
| Network | <ul><li>“Network Interface(\*)\Bytes Received/sec”</li><li>“Network Interface(\*)\Bytes Sent/sec” <!--Are these supposed to be code blocks or math equations?-->| <ul><li>In general, traffic sent from a DC far exceeds traffic sent to a DC.</li><li>As a switched Ethernet connection is full-duplex, inbound and outbound network traffic need to be sized independently.</li><li>Consolidating the number of DCs will increase the amount of bandwidth used to send responses back to client requests for each DC, but will be close enough to linear for the site as a whole.</li><li>If removing satellite location DCs, don't forget to add the bandwidth for the satellite DC into the hub DCs as well as use that to evaluate how much WAN traffic there will be.</li></ul> |
| CPU | <ul><li>`Logical Disk(<NTDS Database Drive\>)\Avg Disk sec/Read`</li><li>“Process(lsass)\\% Processor Time”</li></ul> | <ul><li>After eliminating storage as a bottleneck, address the amount of compute power needed.</li><li>While not perfectly linear, the number of processor cores consumed across all servers within a specific scope (such as a site) can be used to gauge how many processors are necessary to support the total client load. Add the minimum necessary to maintain the current level of service across all the systems within the scope.</li><li>Changes in processor speed, including power management related changes, impact numbers derived from the current environment. Generally, it's impossible to precisely evaluate how going from a 2.5 GHz processor to a 3 GHz processor will reduce the number of CPUs needed.</li></ul> |
| NetLogon | <ul><li>“Netlogon(*)\Semaphore Acquires”</li><li>“Netlogon(*)\Semaphore Timeouts”</li><li>“Netlogon(*)\Average Semaphore Hold Time”</li></ul> | <ul><li>Net Logon Secure Channel/MaxConcurrentAPI only affects environments with NTLM authentications and/or PAC Validation. PAC Validation is on by default in operating system versions before Windows Server 2008. This is a client setting, so the DCs will be impacted until this is turned off on all client systems.</li><li>Environments with significant cross trust authentication, which includes intra-forest trusts, have greater risk if not sized properly.</li><li>Server consolidations will increase concurrency of cross-trust authentication.</li><li>Surges need to be accommodated, such as cluster fail-overs, as users re-authenticate en masse to the new cluster node.</li><li>Individual client systems (such as a cluster) might need tuning too.</li></ul> |

<!--Come back to these tables later and ask Alan & co. if they can help me figure out what's going on with those equations(?) in the second column.-->

## Planning

For a long time, the usual recommendation for AD DS sizing was to put in as much RAM as the database size. Now that AD DS environments and the ecosystem that consumes them have grown much larger, things have changed. Although increased compute power and switching from x86 architecture to x64 made subtler aspects of sizing for performance irrelevant to customers running AD DS on physical machines, virtualization has made a tuning a much bigger concern.

To address those concerns, the following sections describe how to determine and plan for the demands of Active Directory as a service. You can apply these guidelines to any environment regardless of whether your environment is physical, virtualized, or mixed. To maximize your performance, your goal should be to get your AD DS environment as close to processor bound as possible.

## RAM

The more storage you can cache in the RAM, the less needs to go to disk. To maximize server scalability, the minimum amount of RAM you use should equal the sum of the current database size, the total system value size, the recommended amount for your operating system, and the vendor recommendations for the agents (antivirus programs, monitoring, backup, and so on). You should also include extra RAM to accommodate future growth over the server's lifetime. This estimate will change based on database growth and environmental changes.

For environments where maximizing RAM is either not cost-effective or unfeasible, such as satellite locations or when DIT <!--What does this acronym mean?--> is too large, skip ahead to [Storage](#storage) to make sure your storage is configured properly.

Another important thing to consider for sizing memory is the page file sizing. In disk sizing, like everything else related to memory, the goal is to minimize disk usage. In particular, how much RAM do you need to minimize paging? The next few sections should give you the information you need to answer this question. Other considerations for page size that don't necessarily affect AD DS performance are OS <!--Define acronym--> recommendations and configuring your system for memory dumps.

Determining how much RAM a domain controller (DC) needs can be difficult due to many complex factors:

- Existing systems aren't always reliable indicators of RAM requirements because LSSAS <!--Acronym--> trims RAM under memory pressure conditions, artificially deflating requirements.
- Individual DCs only need to cache data their clients are interested in. This means data cached in different environments will change depending on what kinds of clients it contains. For example, a DC in an environment with an Exchange Server will collect different data than a DC that only authenticates users.
- The amount of effort you need to evaluate RAM for each DC on a case-by-case basis is often excessive and changes as the environment changes.

The criteria behind recommendations can help you make more informed decisions:

- The more you cache in RAM, the less you need to go to disk.
- Storage is a computer's slowest component. Data access on spindle-based and SSD storage media is a million times slower than data access in RAM.

<!--The content here was literally the exact same as the stuff in the intro except for formatting, so I deleted it.-->

### Virtualization considerations for RAM

Your goal for optimizing RAM is to minimize the amount of time spent going to disk. You should also avoid memory over-commit at the host. In virtualization scenarios, memory over-commit is when the system allocates more RAM to guests than what exists on the physical machine itself. While over-commit isn't a problem on its own, when the total memory used by all guests exceeds the capability of the host's RAM, it causes the host to page. Paging makes performance disk-bound in cases where the DC goes to the NTS.dit or page file to get data or the host goes to disk to try to access RAM data. As a result, this process vastly decreases performance and overall user experience.

### Calculation summary example

<!--This table needs more context-->

| Component | Estimated memory (example) |
|--|--|
| Base operating system recommended RAM (Windows Server 2008) | 2 GB |
| LSASS internal tasks | 200 MB |
| Monitoring agent | 100 MB |
| Antivirus | 100 MB |
| Database (Global Catalog) | 8.5 GB |
| Cushion for backup to run, administrators to log on without impact | 1 GB |
| Total | 12 GB |

**Recommended: 16 GB**

<!--How did they reach this number?-->

Over time, more data is added to the database, and the average server lifespan is about three to five years. Based on a growth estimate of 333%, 16 GB is a reasonable amount of RAM to put in a physical server.

In a virtual machine (VM), the recommended amount to start with for this example would be 12 GB. The recommended amount is smaller because it's easier to modify settings and add RAM to the VM.

## Network

This section is about evaluating how much total bandwidth and network capacity your deployment needs, inclusive of client queries, Group Policy settings, and so on. You can collect data to make your estimate by using the `Network Interface(*)\Bytes Received/sec` and `Network Interface(*)\Bytes Sent/sec` performance counters. Sample intervals for Network Interface counters should be either 15, 30, or 60 minutes. Anything less will be too volatile for good measurements, and anything greater will excessively smooth out daily peaks.

> [!NOTE]
> Generally, the majority of network traffic on a DC is outbound as the DC responds to client queries. As a result, this section mainly focuses on outbound traffic. However, we also recommend you also evaluate each of your environments for inbound traffic. You can use the guidelines in this article to evaluate inbound network traffic requirements as well. For more information, see [929851: The default dynamic port range for TCP/IP has changed in Windows Vista and in Windows Server 2008](https://support.microsoft.com/kb/929851).

### Bandwidth needs

Planning for network scalability covers two distinct categories: the amount of traffic and the CPU load from the network traffic.

There are two things you need to take into account when capacity planning for traffic support. First, you need to know how much [Active Directory Replication Traffic](/previous-versions/windows/it-pro/windows-2000-server/bb742457(v=technet.10)) goes between your DCs. Second, you must evaluate your intrasite client-to-server traffic. Intrasite traffic mainly receives small requests from clients relative to the large amounts of data it sends back to clients. 100 MB is usually enough for environments with up to 5,000 users per server. For environments of over 5,000 users, we recommend you use a 1 GB network adapter and Receive Side Scaling (RSS) support instead.

To evaluate intrasite traffic capacity, particularly in server consolidation scenarios, you should look at the `Network Interface(*)\Bytes/sec` performance counter across all DCs in a site, add them together, then divide the sum by the target number of DCs. An easy way to calculate this number is to open the **Windows Reliability and Performance Monitor** and look at the **Stacked Area** view. Make sure all the counters are scaled the same.

Let's take a look at an example of a more complex way to validate that this general rule applies to a specific environment. In this example, we're making the following assumptions:

- The goal is to reduce the footprint to as few servers as possible. Ideally, one server carries the load, then you deploy an additional server for redundancy (*n* + 1 scenario).
- In this scenario, the current network adapter only supports 100 MB and is in a switched environment.
- The maximum target network bandwidth utilization is 60% in an *n* scenario (loss of a DC).
- Each server has about 10,000 clients connected to it.

Now, let's take a look at what the chart in the `Network Interface(*)\Bytes Sent/sec` counter says about this example scenario:

1. The business day starts ramping up around 5:30 AM and winds down at 7:00 PM.
1. The peak busiest period is from 8:00 AM to 8:15 AM, with greater than 25 bytes sent per second on the busiest DC.
   > [!NOTE]
   > All performance data is historical, so the peak data point at 8:15 AM indicates the load from 8:00 AM to 8:15 AM.
1. There are spikes before 4:00 AM, with more than 20 bytes sent per second on the busiest DC, which could indicate either load from different time zones or background infrastructure activity, such as backups. Since the peak at 8:00 AM exceeds this activity, it's not relevant.
1. There are five DCs in the site.
1. The maximum load is about 5.5 MBps per DC, which represents 44% of the 100 MB connection. Using this data, we can estimate that the total bandwidth needed between 8:00 AM and 8:15 AM is 28 MBps.
   > [!NOTE]
   > The Network Interface send/receive counters are in bytes, but the network bandwidth is measured in bits. Therefore, to calculate the total bandwidth, you'd need to do 100 MB ÷ 8 = 12.5 MB and 1 GB ÷ 8 = 128 MB.

Now that we've reviewed the data, what conclusions can we draw from it?

- The current environment meets the *n* + 1 level of fault tolerance at 60% target utilization. Taking one system offline will shift the bandwidth per server from about 5.5 MBps (44%) to about 7 MBps (56%).
- Based on the previously stated goal of consolidating to one server, this both exceeds the maximum target utilization and possible utilization of a 100 MB connection.
- With a 1 GB connection, this value represents 22% of the total capacity.
- Under normal operating conditions in the *n* + 1 scenario, the client load is relatively evenly distributed at about 14 MBps per server or 11% of total capacity.
- To make sure you have enough capacity while a DC is unavailable, the normal operating targets per server would be about 30% network utilization or 38 MBps per server. Failover targets would be 60% network utilization or 72 MBps per server.

The final system deployment must have 1 GB network adapter and a connection to a network infrastructure that will support said load. Because of the amount of network traffic, the CPU load from network communications can potentially limit the maximum scalability of AD DS. You can use this same process to estimate inbound communication to the DC. However, in most scenarios, you won't need to calculate the inbound traffic because it's smaller than the outbound traffic.

It's important to make sure your hardware supports RSS in environments with over 5,000 users per server. For high network traffic scenarios, balancing interrupt load can be a bottleneck. You can detect potential bottlenecks by checking the `Processor(*)\% Interrupt Time` counter to see if interrupt time is unevenly distributed across CPUs. RSS-enabled NICs <!--Acronym--> can mitigate these limitations and increase scalability.

> [!NOTE]
> You can take a similar approach to estimate if you need more capacity when consolidating datacenters or retiring a DC in a satellite location. To estimate the required capacity, simply look at the data for outbound and inbound traffict to clients. The result is the amount od traffic present in the WAN <!--Acronym--> links.
>
> In some cases, you might experience more traffic than expected because traffic is slower, such as when certificate checking fails to meet aggressive time-outs on the WAN. For this reason, WAN sizing and utilization should be an iterative, ongoing process.

### Virtualization considerations for network bandwidth

The typical recommendations for a physical server are 1 GB for servers supporting over 5,000 users. Once multiple guests start sharing an underlying virtual switch infrastructure, you should pay extra attention to whether the host has adequate network bandwidth to support all the guests in the system. You need to consider bandwidth regardless of whether the network includes the DC running as a VM on a host with network traffic going over a virtual switch or directly connected to a physical switch. Virtual switches are components where the uplink must support the amount of data the connection transmits, which means the physical host network adapter linked to the switch should be able to support the DC load plus all other guests sharing the virtual switch connected to the physical network adapter.

### Network calculation summary example

The following table contains values from an example scenario that we can use to calculate network capacity:

| System | Peak bandwidth |
|--|--|
| DC 1 | 6.5 MBps |
| DC 2 | 6.25 MBps |
| DC 3 | 6.25 MBps |
| DC 4 | 5.75 MBps |
| DC 5 | 4.75 MBps |
| Total | 28.5 MBps |

Based on this table, the recommended bandwidth would be 72 MBps (28.5 MBps ÷ 40%).

|Target system count|Total bandwidth (from above)|
|-|-|
|2|28.5 MBps|
|Resulting normal behavior|28.5 ÷ 2 = 14.25 MBps|

As always, you should assume that client load will increase over time, so you should plan for this growth as early as possible. We recommend you plan for at least 50% estimated network traffic growth.

## Storage

There are two things you should consider when capacity planning for storage:

- Capacity or storage size
- Performance

Although capacity is important, it's important to not neglect performance. With current hardware costs, most environments aren't large enough for either factor to be a major concern. Therefore, the usual recommendation is to just put in as much RAm as the database size. However, this recommendation might be overkill for satellite locations in larger environments.

### Sizing

#### Evaluating for storage

Compared to when Active Directory first arrived at a time when 4 GB and 9 GB drives were the most common drive sizes, now sizing for Active Directory isn't even a consideration for all but the largest environments. With the smallest available hard drive sizes in the 180 GB range, the entire operating system, SYSVOL, and NTDS.dit can easily fit on one drive. As a result, we recommend you avoid investing too heavily in this area.

Our only recommendation is that you ensure 110% of the NTS.dit size is available in order to enable defrag. Beyond that, you should take the usual considerations in accommodating future growth.

<!--Where I left off-->

If you are going to evaluate your storage, then first you must evaluate how large the NTDS.dit and SYSVOL need to be. These measurements will help you size both the fixed disk and RAM allocations. Because the components are relatively low cost, you don't need to be super precise when doing the math. For more information about storage evaluation, see [Storage Limits](/previous-versions/windows/it-pro/windows-2000-server/cc961769(v=technet.10)) and [Growth Estimates for Active Directory Users and Organizational Units](/previous-versions/windows/it-pro/windows-2000-server/cc961779(v=technet.10)).

  > [!NOTE]
  > The articles linked in the previous paragraph are based on data size estimates made during the release of Active Directory in Windows 2000. When making your own estimate, use object sizes that reflect the actual size of objects in your environment.

As you review existing environments with multiple domains, you may notice variations in database sizes. When you spot these variations, use the smallest global catalog (GC) and non-GC sizes.

Database sizes can vary between OS versions. DCs running earlier versions of OSes like Windows Server 2003 have smaller database sizes than one running a later version like Windows Server 2008 R2. The DC having features like Active Directory REcycle Bin or Credential Roaming enabled can also affect database size.

> [!NOTE]
>
> - For new environments, remember that 100,000 users in the same domain consume about 450 MB of space. The attributes you populate can have a huge impact on the total amount of space consumed. Attributes are populated by many objects from both third-party and Microsoft products, including Microsoft Exchange Server and Lync. As a result, we recommend you evaluate based on the environment's product portfolio. However, you should also keep in mind that doing the math and testing for precise estimates for all but the largest environments may not be worth significant time or effort.
> - Make sure the free space you have available is 110% of the NTDS.dit size to enable offline defrag. This free space also lets you plan for growth over the server's three to five year hardware lifespan. If you have the storage for it, allocating enough free space to equal 300% of the DIT for storage is a safe way to accommodate growth and defragging.

#### Virtualization considerations for storage

In scenarios where you allocate multiple Virtual Hard Disk (VHD) files to a single volume, you should use a fixed state disk of at least 210% the size of the DIT (100% of the DIT + 110% free space) to ensure you have enough space reserved for your needs.

#### Storage calculation summary example

The following table lists the values you'd use to estimate the space requirements for a hypothetical storage scenario.

| Data collected from evaluation phase | Size |
|--|--|
| NTDS.dit size | 35 GB |
| Modifier to allow for offline defrag | 2.1 GB |
| Total storage needed | 73.5 GB |

> [!NOTE]
> The storage estimate should also include how much storage you need for SYSVOL, the OS, the page file, temporary files, local cached data such as installer files, and applications.

### Storage performance

As the slowest component within any computer, storage can have the biggest adverse impact on client experience. For environments large enough that the RAM sizing recommendations in this article aren't feasible, the consequences of overlooking capacity planning for storage can be devastating for system performance. THe complexities and varieties of available storage technology further increase risk, as the typical recommendation to put the OS, logs, and database on separate physical disks doesn't apply universally across all scenarios.

The old recommendations about disks assumed that a disk was a dedicated spindle that allowed for isolated I/O. This assumption is no longer true due to the introduction of the following storage types:

- RAID
- New storage types and virtualized and shared storage scenarios
- Shared spindles on a Storage Area Network (SAN)
- VHD file on a SAN or network-attached storage
- Solid State Drives (SSDs)
- Tiered storage architectures, such as SSD storage tier caching larger spindle-based storage

<!--Where I left off-->

Shared storage, such as RAID, SAN, NAS, JBOD, Storage Spaces, and VHD, are capable of being overloaded by other workloads you place on the back-end storage. These types of storage also present an extra challenge: SAN, network, or driver issues between the physical disk and the AD application can cause throttling and delays. To clarify, these aren't bad configurations, but they are more complex, which means you need to pay extra attention to make sure every component is working as intended. For more detailed explanations, see [Appendix C](#appendix-c-fundamentals-regarding-the-operating-system-interacting-with-storage) and [Appendix D](#appendix-d---discussion-on-storage-troubleshooting---environments-where-providing-at-least-as-much-ram-as-the-database-size-is-not-a-viable-option) later in this article. Also, while SSDs aren't limited by hard drives that can only process one IO at a time, they still have IO limitations that can be overloaded.

In summary, the goal of all storage performance planning, regardless of storage architecture, is to ensure that the needed amount of IOs is always available and that they happen within an acceptable timeframe. For scenarios with locally attached storage, see [Appendix C](#appendix-c-fundamentals-regarding-the-operating-system-interacting-with-storage) for more information about design and planning. You can apply the principles in the appendix to more complex storage scenarios, as well as conversations with vendors supporting your back-end storage solutions.

Due to how many storage options are available today, we recommend you consult your hardware support teams or vendors while planning to ensure the solution meets the needs of your AD DS deployment. During these conversations, you may find the following performance counters helpful, especially when your database is too large for your RAM:

- `LogicalDisk(*)\Avg Disk sec/Read` (for example, if NTDS.dit is stored on drive D, the full path would be `LogicalDisk(D:)\Avg Disk sec/Read`)
- `LogicalDisk(*)\Avg Disk sec/Write`
- `LogicalDisk(*)\Avg Disk sec/Transfer`
- `LogicalDisk(*)\Reads/sec`
- `LogicalDisk(*)\Writes/sec`
- `LogicalDisk(*)\Transfers/sec`

When you provide the data, you should make sure it's sampled in intervals of 15, 30, or 60 minutes to give the most accurate picture of your current environment possible.

#### Evaluating the results

This section focuses on reads from the database, as the database is usually the most demanding component. You can apply the same logic to writes to the log file by substituting `<NTDS Log>)\Avg Disk sec/Write` and `LogicalDisk(<NTDS Log>)\Writes/sec)`.

The `LogicalDisk(<NTDS>)\Avg Disk sec/Read` counter shows whether the current storage is adequately sized. If the value is roughly equal to the expected Disk Access TIme for the disk type, the `LogicalDisk(<NTDS>)\Reads/sec` counter is a valid measure. If the results are roughly equal to the Disk Access Time for the disk type, the `LogicalDisk(<NTDS>)\Reads/sec` counter is a valid measure. Although this can change depending on which manufacturer specifications your back-end storage has, but good ranges for `LogicalDisk(<NTDS>)\Avg Disk sec/Read` would roughly be:

- 7200 – 9 to 12.5 milliseconds (ms)
- 10,000 – 6 to 10 ms
- 15,000 – 4 to 6 ms
- SSD – 1 to 3 ms

<!--I need more context for what these numbers mean.-->

You may hear from other sources that storage performance is degraded at 15 ms to 20 ms. The difference between those values and the values in the preceding list is that the list values show the normal operating range. The other values are for troubleshooting purposes, which help you identify when client experience has degraded enough that it becomes noticeable. For more information, see [Appendix C](#appendix-c-fundamentals-regarding-the-operating-system-interacting-with-storage).

<!--I have no idea what this following list of counters is. This whole section was a mess with duplicate content, and it's not clear where this should go because the context here is so poor compared to the other sections.-->

<!--Is the LogicalDisk string supposed to be an equation or a file path/command?-->

> - `LogicalDisk(<NTDS>)\Reads/sec` is the amount of I/O the system is currently performing.
>   - If `LogicalDisk(<NTDS>)\Avg Disk sec/Read` is within the optimal range for the backend storage, you can directly use `LogicalDisk(<NTDS>)\Reads/sec` to size the storage.
>   - If `LogicalDisk(<NTDS>)\Avg Disk sec/Read` is not within the optimal range for the backend storage, additional I/O is needed according to the following formula: `LogicalDisk(<NTDS>)\Avg Disk sec/Read` ÷ Physical Media Disk Access Time × `LogicalDisk(<NTDS>)\Avg Disk sec/Read`

When you're making these calculations, here are some things you should consider:

- If the server has a sub-optimal amount of RAM, the resulting values will be too high and won't be accurate enough to be useful for planning. However, you can still use them to predict worst-case scenarios.
- If you add or optimize RAM, you also decrease the amount of read I/O `LogicalDisk(<NTDS>)\Reads/Sec`. This decrease can cause the storage solution to not be as robust as the original calculations guessed. Unfortunately, we can't give more specifics about what this statement means, as calculations vary widely depending on individual environments, particularly client load. However, we do recommend that you adjust storage sizing after you optimize the RAM.

#### Virtualization considerations for performance

Much like the previous sections, our goal here is to make sure the shared infrastructure can support the total load of all consumers. You need to keep this goal in mind when planning for the following scenarios:

- A physical CD sharing the same media on a SAN, NAS, or iSCSI infrastructure as other servers or applications.
- A user using pass-through access to a SAN, NAS, or iSCSI infrastructure that shares the media.
- A user using a VHD file on shared media locally or a SAN, NAS, or iSCSI infrastructure.

From the perspective of a guest user, having to go through a host to access any storage impacts performance, as the user must travel down additional code paths to gain access. Performance testing indicates virtualizing impacts throughput based on how much of the processor the host system utilizes. Processor utilization is also influenced by how many resources the guest user demands of the host. This demand contributes to the [Virtualization considerations for processing](#virtualization-considerations-for-processing) you should take for processing needs in virtualized scenarios. For more information, see [Appendix A](#appendix-a-cpu-sizing-criteria).

Further complicating matters is the huge number of currently available storage options, each with wildly different performance impacts. These options include pass-through storage, SCSI adapters, and IDE. When migrating from a physical to a virtual environment, you should adjust for different storage options for virtualized guest users by using a multiplier of 1.10. <!--To do what? What value are we multiplying?--> However, you don't need to consider adjustments when transferring between different storage scenarios, as whether the storage is local, SAN, NAS, or iSCSI matters more.

#### Virtualization calculation example

Determining the amount of I/O needed for a healthy system under normal operating conditions:

<!--I'm attempting to translate this into a more standard equation. This may be hilariously inaccurate, so please leave comments if you spot something.-->

<!--What's the difference between Read/sec and sec/Read?-->

- LogicalDisk(`<NTDS Database Drive>`) ÷ Transfers per second during the peak period 15 minute period
- To determine the amount of I/O needed for storage where the capacity of the underlying storage is exceeded:
  >*Needed IOPS* = (LogicalDisk(`<NTDS Database Drive>`)) ÷ Avg Disk sec/Read ÷ `<Target Avg Disk sec/Read>`) × LogicalDisk(`<NTDS Database Drive>`)\Read/sec

| Counter | Value |
|--|--|
| Actual LogicalDisk(`<NTDS Database Drive>`)\Avg Disk sec/Transfer | .02 seconds (20 milliseconds) |
| Target LogicalDisk(`<NTDS Database Drive>`)\Avg Disk sec/Transfer | .01 seconds |
| Multiplier for change in available IO | 0.02 ÷ 0.01 = 2 |

| Value name | Value |
|--|--|
| LogicalDisk(`<NTDS Database Drive>`)\Transfers/sec | 400 |
| Multiplier for change in available IO | 2 |
| Total IOPS needed during peak period | 800 |

To determine the rate at which you should warm the cache:

- Determine the maximum time you find acceptable for to spend on cache warming. In typical scenarios, an acceptable amount of time would be how long it should take to load the entire database from a disk. In scenarios where the RAM can't load the entire database, use the time it would take to fill the entire RAM.
- Determine the size of the database, excluding space that will be unused. For more information, see [Evaluating for storage](#evaluating-for-storage).
- Divide the database size by 8 KB to get the total number of IOs you need to load the database.
- Divide the total IOs by the number of seconds in the defined time frame.

<!--Note to self: address inconsistent use of I/O and IO-->

The number you calculate is mostly accurate, but may not be exact because you haven't configured ESE <!--Acronym--> to have a fixed cache size, then AD DS will evict previously loaded pages because it uses variable cache size by default.

<!--No context given for this table-->

| Data points to collect | Values |
|--|--|
| Maximum acceptable time to warm | 10 minutes (600 seconds) |
| Database size | 2 GB |

| Calculation step | Formula | Result |
|--|--|--|
| Calculate size of database in pages | (2 GB × 1024 × 1024) = *Size of database in KB* | 2,097,152 KB |
| Calculate number of pages in database | 2,097,152 KB ÷ 8 KB = *Number of pages* | 262,144 pages |
| Calculate IOPS necessary to fully warm the cache | 262,144 pages ÷ 600 seconds = *IOPS needed* | 437 IOPS |

## Processing

<!--Intro-->

### Evaluating Active Directory processor usage

For most environments, managing processing capacity is the component that deserves the most attention. When you're evaluating how much CPU capacity your deployment needs, you should consider the following two things:

- Do the applications in your environment behave as intended within a shared services infrastructure based on the criteria outlined in [Tracking expensive and inefficient searches](/previous-versions/ms808539(v=msdn.10)#tracking-expensive-and-inefficient-searches)? In larger environments, poorly coded applications can make the CPU load become volatile, take an inordinate amount of CPU time at the expense of other applications, drive up capacity needs, and unevenly distribute load against the DCs.
- AD DS is a distributed environment with many potential clients whose processing needs vary widely. Estimated costs for each client can vary due to usage patterns and how many applications are using AD DS. Much like in [Network](#network), you should approach estimating as an evaluation of total needed capacity in the environment instead of looking at each client one at a time.

You should only make this estimate after you've completed your [storage](#storage) estimate, as you won't be able to make an accurate guess without valid data about your processor load. It's also important to make sure any bottlenecks aren't being caused by storage before troubleshooting the processor. As you remove processor wait states, CPU utilization increases because it no longer needs to wait on the data. Therefore, the performance counters you should pay the most attention to are `Logical Disk(<NTDS Database Drive>)\Avg Disk sec/Read`and `Process(lsass)\ Processor Time`. If the `Logical Disk(<NTDS Database Drive>)\Avg Disk sec/Read` counter is over 10 or 15 milliseconds, then the data in `Process(lsass)\ Processor Time` is artifically low and the issue is related to storage performance. We recommend you set sample intervals to 15, 30, or 60 minutes for the most accurate data possible.

### Processing overview

<!---Make sure new titles are consistent-->

<!--Wait, most of the content in this section sounds exactly like what was in the previous section. Let's come back to this later and see if we need to remove it.-->

In order to plan capacity planning for domain controllers, processing power requires the most attention and understanding. When sizing systems to ensure maximum performance, there is always a component that is the bottleneck and in a properly sized Domain Controller this will be the processor.

Similar to the networking section where the demand of the environment is reviewed on a site-by-site basis, the same must be done for the compute capacity demanded. Unlike the networking section, where the available networking technologies far exceed the normal demand, pay more attention to sizing CPU capacity.  As any environment of even moderate size; anything over a few thousand concurrent users can put significant load on the CPU.

Unfortunately, due to the huge variability of client applications that leverage AD, a general estimate of users per CPU is woefully inapplicable to all environments. Specifically, the compute demands are subject to user behavior and application profile. Therefore, each environment needs to be individually sized.

#### Target site behavior profile

When you're capacity planning for an entire site, your goal should be an *N* + 1 capacity design. In this design, even if one system fails during the peak period, service can still continue at acceptable levels of quality. In an *N* scenario, load across all boxes should be less than 80%-100% during peak periods.

<!--Where I left off.-->

Also, the site's applications and clients use the recommended [DsGetDcName function](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea) method for locating DCs, they should already be evenly distributed with only minor transient spikes.

Now we're going to look at two examples of environments that are on target and off target. First, we're going to take a look at an example of an environment that works as intended and doesn't exceed the capacity planning target.

For the first example, we're making the following assumptions:

- Each of the five DCs in the site has four CPUs.
- Total target CPU usage during business hours is 40% under normal operating conditions (*N* + 1) and 60% otherwise (*N*). During non-business hours, the target CPU usage is 80% because we expect the backup software and other maintenance processes to consume all available resources.

Now, let's take a look at the `(Processor Information(_Total)\% Processor Utility)` chart, for each of the DCs, as shown in the following image.

![CPU usage chart](media/capacity-planning-considerations-cpu-chart.png)

- The load is relatively evenly distributed, which is what we'd expect when clients use the DC locator and well-written searches.
- In several five-minute intervals, there are spikes at 10%, sometimes even 20%. However, unless these spikes cause the CPU usage to exceed the capacity plan target, you don't need to investigate them.
- The peak period for all systems is between 8:00 AM and 9:15 AM. The average business day lasts from 5:00 AM to 5:00 PM. Therefore, any randomized spikes of CPU usage that happen between 5:00 PM and 4:00 AM are outside of business hours, and therefore you don't need to include them in your capacity planning concerns.

  > [!NOTE]
  > On a well-managed system, spikes that happen during the off-peak period are usually caused by backup software, full system antivirus scans, hardware or software inventory, software or patch deployment, and so on. Because these spikes happen outside of business hours, they don't count towards exceeding capacity planning targets.

<!--Can we clarify what these percentages mean? 40% of what? CPU usage? I feel like I'm missing something here.-->
- Because each system is about 40% and they all have the same number of CPUs, if one of them goes offline, the remaining systems run at an estimated 53%. System D has a 40% load that's evenly split and added to System A and C's existing 40% load. This linear assumption isn't perfectly accurate, but provides enough accuracy to gauge.
<!--System A? Was this in the graphic or did I miss something?-->

<!--Why are we flipping into an 'alternate scenario' now? This section is really confusing.-->

Next, let's look at an example of an environment that doesn't have good CPU usage and exceeds the capacity planning target.

In this example, we have two DCs running at 40%. One domain controller goes offline, which causes the estimated CPU usage on the remaining DC to reach 80%. This level of CPU usage far exceeds the threshold for the capacity plan and begins to limit the amount of headroom for the 10% to 20% of the load profile. As a result, every spike could potentially drive the DC to 90% or even 100 % during the *N* scenario, reducing its responsiveness.

### Calculating CPU demands

The `Process\% Processor Time` performance counter tracks the total amount of time all application threads spend on the CPU, then divides that sum by the total amount of system time that's passed. A mutli-threaded application on a multi-CPU system can exceed 100% CPU time, and you'd interpret its data very differently than the `Processor Information\% Processor Utility` counter. In practice, the `Process(lsass)\% Processor Time` counter tracks how many CPUs running at 100% the system requires to support a process' demands. For example, if the counter has a value of 200%, that means the system needs two CPUs running at 100% to support the full AD DS load. Although a CPU running at 100% capacity is the most cost-efficient in terms of power and energy consumption, for reasons outlined in [Appendix A](#appendix-a-cpu-sizing-criteria), a multi-threaded system is more responsive when its system isn't running on 100%.

To accommodate transient spikes in client load, we recommend you target a peak period CPU between 40% and 60% of system capacity. For example, in the first example in [Target site behavior profile](#target-site-behavior-profile), you'd need between 3.33 CPUs (60% target) and 5 CPUs (40% target) to support the AD DS load. You should add extra capacity according to the demands of the OS and any other required agents, such as antivirus, backup, monitoring, and so on. Although you should evaluate the impact of agents on CPU agents on a per-environment basis, generally you can allot between 5% and 10% for agent processes on a single CPU. To revisit our example, we would need between 3.43 (60% target) and 5.1 (40% target) CPUs to support load during peak periods.

Now, let's take a look at an example of calculating for a specific process. In this case, we'll look at the lsass process.

#### Calculating CPU usage for the lsass process

In this example, the system is an *N* + 1 scenario where one server carries the AD DS load while an extra server is there for redundancy.

The following chart shows the processor time for the lsass process over all processors for this example scenario. This data was gathered from the `Process(lsass)\% Processor Time` performance counter.

![Processor time chart for lsass process (over all processors)](media/capacity-planning-considerations-proc-time-chart.png)

<!--Reformat image-->

Here's what this chart tells us about the scenario environment:

- There are three domain controllers in the site.
- The business day starts ramping up around 7:00 AM, then ramps down at 5:00 PM.
- The busiest period of the day is from 9:30 AM to 11:00 AM.
  > [!NOTE]
  > All performance data is historical. The peak data point at 9:15 AM indicates the load from 9:00 AM to 9:15 AM.
- Spikes before 7:00 AM could indicate extra load from different time zones or background infrastructure activity, such as backups. However, since this spike is lower than peak activity at 9:30 AM, it's not a cause for concern.

At maximum load, the lsass process consumes around 4.85 CPUs running at 100%, which would be 485% on a single CPU. These results suggest the scenario site needs about 12/25 CPUs to handle AD DS. When you bring in the recommended 5% to 10% extra capacity for background processes, that means the server would need 12.30 to 12.25 CPUs to support its current load. Estimates anticipating future growth will make this number even higher.

### When to tune LDAP weights

There are certain scenarios where you should consider tuning [LdapSrvWeight](/previous-versions/windows/it-pro/windows-2000-server/cc957291(v=technet.10)). In the context of capacity planning, you'd tune it when your applications, user loads, or underlying system capabilities aren't evenly balanced.

The following sections describe two example scenarios where you should tune the Lightweight Directory Access Protocol (LDAP) weights.

#### Example 1: PDC emulator environment

If you're using a Primary Domain Controller (PDC) emulator, unevenly distributed user or application behavior can affect multiple environments at once. CPU resources on the PDC emulator are often more heavily demanded than elsewhere in the deployment because several tools and actions target it, such as Group Policy management tools, second authentication attempts, trust establishment, and so on.

- You should tune your PDC emulator only if there's a noticeable difference in CPU utilization. Tuning should reduce the load on the PDC emulator and increase the load on other DCs, allowing for more even load distribution.
- In these cases, set the value for `LDAPSrvWeight` between 50 and 75 for the PDC emulator.

The following table...

<!--Give this a better intro when I have more context.-->

| System | CPU utilization with defaults | New LdapSrvWeight | Estimated new CPU utilization |
|--|--|--|--|
| DC 1 (PDC emulator)| 53% | 57 | 40% |
| DC 2| 33% | 100 | 40% |
| DC 3| 33% | 100 | 40% |

The catch here is that if the PDC emulator role is transferred or seized, particularly to another domain controller in the site, there will be a dramatic increase on the new PDC emulator.

<!--A dramatic increase of WHAT?-->

In this example scenario, we assume based on [Target site behavior profile](#target-site-behavior-profile) that all three domain controllers in this site have four CPUs. Under normal conditions, what would happen if one of these DCs had eight CPUs? There would be two DCs at 40% utilization and one at 20% utilization. While this configuration isn't necessarily bad, there's an opportunity here for you to use LDAP weight tuning to balance the load better.

#### Example 2: environment with different CPU counts

When you have servers with different CPU counts and speeds in the same site, you need to make sure they're evenly distributed. For example, if your site has two eight-core servers and one four-core server, the four-core server only has half the processing power of the other two servers. If the client load is evenly distributed, that means the four-core server needs to work twice as hard as the two eight-core servers to manage its CPU load. On top of that, if one of the eight-core servers goes offline, the four-core server gets overloaded.

The following table...

<!--Better intro once I can get more context-->

| System | Processor Information\\ % Processor Utility(_Total)<br />CPU utilization with defaults | New LdapSrvWeight | Estimated new CPU utilization |
|--|--|--|--|
| 4-CPU DC 1 | 40 | 100 | 30% |
| 4-CPU DC 2 | 40 | 100 | 30% |
| 8-CPU DC 3 | 20 | 200 | 30% |

<!--I think I need more context before I can properly rewrite this.-->

Be very careful with these scenarios though. As can be seen above, the math looks really nice and pretty on paper. But throughout this article, planning for an “*N* + 1” scenario is of paramount importance. The impact of one DC going offline must be calculated for every scenario. In the immediately preceding scenario where the load distribution is even, in order to ensure a 60% load during an “*N*” scenario, with the load balanced evenly across all servers, the distribution will be fine as the ratios stay consistent. Looking at the PDC emulator tuning scenario, and in general any scenario where user or application load is unbalanced, the effect is very different:

| System | Tuned Utilization | New LdapSrvWeight | Estimated New Utilization |
|--|--|--|--|
| DC 1 (PDC emulator) | 40% | 85 | 47% |
| DC 2 | 40% | 100 | 53% |
| DC 3 | 40% | 100 | 53% |

### Virtualization considerations for processing

When you're capacity planning for a virtualized environment, there are two levels you need to consider: the host level and the guest level. At the host level, you must identify the peak periods of your business cycle. Because scheduling guest threads on the CPU for a virtual machine is similar to getting AD DS threads on the CPU for a physical machine, we still recommend you use 40% to 60% of the underlying host. At the guest level, because the underlying thread scheduling principles haven't changed, we also still recommend you keep <!--noun--> within the 40% to 60% range.

In a direct-mapped scenario with one guest per host, you must bring in all capacity planning estimates you've done in the previous sections in order to make your estimate. For a shared host scenario, there's about 10% impact on the efficiency of the underlying processors, which means if a site needs 10 CPUs at a target of 40%, the recommended amount of virtual CPUs you should allocate across all *N* guests would be 11. In sites with mixed distributions of physical and virtual servers, this modifier only applies to the virtual machines (VMs). For example, in an *N* + 1 scenario, one physical or direct-mapped server with 10 CPUs is almost equal to one guest with 11 CPUs on a host with 11 more CPUs reserved for the DC.

While you're analyzing and calculating how many CPUs you need to support AD DS load, keep in mind that if you plan to purchase physical hardware, the types of hardware available on the market may not map exactly to your estimates. With virtualization, that isn't a problem. It decreases the effort needed for you to add compute capacity to a site, as you can add as many CPUs with the exact specifications you want to a VM. However, virtualization doesn't eliminate your responsibility to accurately evaluate how much compute power you need to guarantee your underlying hardware is available when guests need more CPU. As always, remember to plan ahead for growth.

### Virtualization calculation summary example

<!--Intro for these tables once I get more context-->

| System | Peak CPU |
|--|--|--|
| DC 1 | 120% |
| DC 2 | 147% |
| Dc 3 | 218% |
| Total CPU being used | 485% |

| Target system(s) count | Total bandwidth (from above) |
|--|--|
| CPUs needed at 40% target | 4.85 ÷ .4 = 12.25 |

When planning ahead for growth in this scenario, if you assume that demand will grow by 50% over the next three years, you need to make sure it has 18.375 CPUs (12.25 × 1.5) by that time. Alternatively, you can review demand after the first year, then add extra capacity based on what the results tell you.

### Cross-trust client authentication load for NTLM

<!--Need intro here-->

#### Evaluating cross-trust client authentication load

Many environments may have one or more domains connected by a trust. Authentication requests for identities in other domains that don't use Kerberos need to traverse a trust using a secure channel between two domain controllers. The domain controller the user is trying to access in the site connects to another domain controller that's located in either the destination domain or somewhere further up the path towards the destination domain. How many calls the DC can make to the other DC in the trusted domain is controlled by the **MaxConcurrentAPI* setting. In order to ensure the secure channel can handle the amount of load required for the DCs to communicate with each other, you can either tune MaxConcurrentAPI or, if you're in a forest, create shortcut trusts. Learn more about how to determine traffic volume across trusts at [How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting](https://support.microsoft.com/kb/2688798).

As with the previous scenarios, you must collect data during the peak busy periods of the day in order for it to be useful.

> [!NOTE]
> Intraforest and interforest scenarios may cause the authentication to traverse multiple trusts, which means you need to tune during each stage of the process.

#### Virtualization planning

There are a few things you should keep in mind when capacity planning for virtualizaiton:

- Many applications use NTLM <!--Acronym--> authentication by default or in certain configurations.
- As the number of active clients increases, so does the need for application servers to have more capacity.
- Clients sometimes keep sessions open for a limited time and instead reconnect on a regular basis for services like email pull sync.
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

<!--Intro w/ more context-->

| Data type | Value |
|--|--|
| Semaphore Acquires (Minimum) | 6,161 |
| Semaphore Acquires (Maximum) | 6,762 |
| Semaphore Timeouts | 0 |
| Average Semaphore Hold Time | 0.012 |
| Collection Duration (seconds) | 1:11 minutes (71 seconds) |
| Formula (from KB 2688798) | ((6762 - 6161) + 0) × 0.012 / |
| Minimum value for **MaxConcurrentAPI** | ((6762 - 6161) + 0) × 0.012 ÷ 71 = .101 |

For this system for this time period, the default values are acceptable.

## Monitoring for compliance with capacity planning goals

Throughout this article, we've discussed how planning and scaling go towards utilization targets. The following table summarizes the recommended thresholds you must monitor to ensure systems are operating as intended. Keep in mind that these aren't performance thresholds, just capacity planning thresholds. A server operating in excess of these thresholds will still work, but you need to validate your applications are working as intended before you start seeing performance issues as user demand increases. If the applications are okay, then you should start evaluating hardware upgrades or other configuration changes.

<!--Combe back to formatting later once I understand whether these text strings are equations or performance counter names.-->

| Category | Performance counter | Interval/Sampling | Target | Warning |
|--|--|--|--|--|
| Processor | `Processor Information(_Total)\% Processor Utility` | 60 min | 40% | 60% |
| RAM (Windows Server 2008 R2 or earlier) | Memory\Available MB | < 100 MB | N/A | < 100 MB |
| RAM (Windows Server 2012) | Memory\Long-Term Average Standby Cache Lifetime(s) | 30 min | Must be tested | Must be tested |
| Network | Network Interface(\*)\Bytes Sent/sec<p>Network Interface(\*)\Bytes Received/sec | 30 min | 40% | 60% |
| Storage | LogicalDisk((`<NTDS Database Drive>`))\Avg Disk sec/Read<p>LogicalDisk((`<NTDS Database Drive>`))\Avg Disk sec/Write | 60 min | 10 ms | 15 ms |
| AD Services | Netlogon(\*)\Average Semaphore Hold Time | 60 min | 0 | 1 second |

## Appendix A: CPU sizing criteria

<!--Should these be in their own conceptual article(s)? This article is long enough already.-->

This appendix discusses useful terms and concepts that can help you estimate your environment's CPU sizing needs.

### Definitions: CPU sizing

- A *processor (microprocessor)* is a component that reads and executes program instructions.

- A *multi-core processor* has multiple CPUs on the same integrated circuit.

- A *multi-CPU* system has multiple CPUs that aren't on the same integrated circuit.

- A *logical processor* is a processor that only has one logical computing engine from the perspective of the operating system.

This includes hyper-threaded, one core on multi-core processor, or a single core processor.
<!--What includes hyper-threaded processors? No clear subject for this sentence.-->

As today's server systems have multiple processors, multiple multi-core processors, and hyper-threading, these definitions are generalized to cover both scenarios. We use the term logical processor because it represents the OS and application perspective of the available computing engines.

### Thread-level parallelism

Each thread is an independent task, as each thread has its own stack and instructions. AD DS is multi-threaded and you can tune the number of available threads by following the directions in [How to view and set LDAP policy in Active Directory by using Ntdsutil.exe](https://support.microsoft.com/kb/315071), it scales well across multiple logical processors.

### Data-level parallelism

Data-level parallelism is when a service shares data across many threads for the same process and sharing many threads across multiple processes. The AD DS process alone would count as a service sharing data across several threads for a single process. Any changes to the data are reflected across all running threads in all levels of the cache, every core, and any updates to the shared memory. Performance can degrade during write operations because all memory locations adjust to the changes before instruction processing can continue.

### CPU speed versus multiple-core considerations

Generally, faster logical processors reduce the time required to process a series of instructions. More logical processors means you can run more tasks at the same time. However, these rules don't apply in scenarios that are more complex, such as fetching data from shared memory, waiting on data-level parallelism, and the overhead of managing multiple threads at once. As a result, scalability in multi-core systems isn't linear.

To understand why this change happens, it helps to think of these scenarios like a highway. Each thread is an individual car, each lane is a core, and the speed limit is the clock speed.

If there's only one car on the highway, it doesn't matter if there are two or 12 lanes. That car only goes as fast as the speed limit allows.

If the data the thread needs isn't immediately available, then the thread can't process instructions until it fetches the relevant data from memory. It's like if a segment of the highway is shut down. Even if there's only one car on the highway, the speed limit won't affect its ability to travel, because it can't go anywhere until the road is reopened.

As the number of cars increases, the overhead the highway needs to manage the number of cars also increases. Drivers need to focus harder when driving on the highway during rush hour traffic as opposed to the late evening when the road is mostly empty. Also, driving on a two-lane highway where you only need to worry about one other lane requires less focus than driving on a six-lane highway where you have five other lanes of traffic to pay attention to.

In summary, questions about whether you should add more or faster processors become highly subjective and should be considered on a case-by-case basis. For AD DS in particular, its processing needs depend on environmental factors and can vary from server to server within a single environment. As a result, the earlier sections in this article didn't invest heavily on making super precise calculations. When you make budget-driven buying decisions, we recommend you first optimize processor usage at either 40% or whichever number your specific environment requires. If your system isn't optimized, then you don't benefit as much from buying additional processors.

> [!NOTE]
> [Amdahl's law](https://wikipedia.org/wiki/Amdahl%27s_law) and [Gustafson's law](https://wikipedia.org/wiki/Gustafson%27s_law) are the relevant concepts here. <!--Are we allowed to link to Wikipedia? I feel like having ref links would be helpful as users might not know what these laws specifically mean depending on their familiarity with the topic.-->

### Response time and how system activity levels impact performance

Queuing theory is the mathematical study of waiting lines, or *queues*. In queuing theory for computing, the utilization law is represented by t equation:

*U* k = *B* ÷ *T*

Where *U* k is the utilization percentage, *B* is the amount of time spent being busy, and *T* is the total time spent observing the system. In a Microsoft context, this means the number of 100-nanosecond (ns) interval threads that are in a Running state divided by how many 100-ns intervals were available in the given time interval. This is the same formula that calculates  percentage of processor utilization shown in [Processor Object](/previous-versions/ms804036(v=msdn.10)) and [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10)).

Queuing theory also provides the formula: *N* = *U* k ÷ (1 - *U* k) to estimate the number of waiting items based on utilization, where *N* is the length of the queue. Charting this equation over all utilization intervals provides the following estimates of how long the queue to get on the processor is at any given CPU load.

![Queue length](media/capacity-planning-considerations-queue-length.png)
<!--Reformat image-->
<!--Maybe also give a text-only version for accessibility purposes?-->

Based on this estimate, we can observe that after 50% CPU load, the average wait usually includes one other item in the queue, and increases rapidly to 70% CPU utilization.

To understand how queuing theory applies to your AD DS deployment, let's return to the highway metaphor we used in [CPU speed versus multiple-core considerations](#cpu-speed-versus-multiple-core-considerations).

Busier times in the mid-afternoon would fall somewhere into the 40% to 70% capacity range. There's enough traffic that your ability to choose a lane to drive in isn't majorly restricted. While the chance of another driver getting in your way is high, it doesn't require the same level of effort you'd need to find a safe gap between other cars in the lane as during rush hour.

As rush hour approaches, the road system approaches 100% capacity. Changing lanes during rush hour becomes very challenging because cars are so close together that you don't have as much room to maneuver when changing lanes.

This is why estimating longterm averages for capacity at 40% allows for more headroom for abnormal load spikes, whether those spikes are transitory, such as with poorly-coded queries that take a while to run, or abnormal bursts in general load, like the spike in activity the morning after a holiday weekend.

The previous statement regards the percentage of processor time calculation as being the same as the utilization law equation. This simplified version is meant to introduce the concept to new users. However, for more advanced math, you can use the following references as a guide:

- Translating the [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10))
  - *B* = The number of 100-ns intervals Idle thread spends on the logical processor. The change in the *X* variable in the [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10)) calculation
  - *T* = the total number of 100-ns intervals in a given time range. The change in the *Y* variable in the [PERF_100NSEC_TIMER_INV](/previous-versions/windows/embedded/ms901169(v=msdn.10)) calculation.
  - *U* k = The utilization percentage of the logical processor by the Idle Thread or % Idle Time.
- Working out the math:
  - *U* k = 1 – %Processor Time
  - %Processor Time = 1 – *U* k
  - %Processor Time = 1 – *B* / *T*
  - %Processor Time = 1 – *X1* – *X0* / *Y1* – *Y0*

<!--Let's come back to this bulleted list later.-->

### Applying these concepts to capacity planning

<!--I need to figure out a more specific title for this, because I suspect it's going to duplicate in the other appendices.-->

<!--Where I left off-->

The math in the previous section probably makes determining how many logical processors you need in a system seem very complex. As a result, your approach to sizing the system should focus on determining maximum target utilization based on current load, then calculating the number of logical processors you need to reach that target. Furthermore, your estimate doesn't need to be perfectly exact. While logical processor speeds do have a significant impact on synchronization, performance can also be affected by other areas:

- Cache efficiency
- Memory coherence requirements
- Thread scheduling and synchronization
- Imperfectly balanced client loads

Since compute power is relatively low-cost, it's not worth investing too much time in calculating the perfectly exact number of CPUs you need.

It's also important to remember that the 40% recommendation, in this case, isn't a mandatory requirement. We use it as a reasonable start for making calculations. Different kinds of AD users need different levels of responsiveness. There may even be scenarios where environments can run at 80% or even 90% utilization at a sustained average without the increased wait times for processor access noticeably affecting client performance.

There are also other areas in the system that are much slower than the logical processor which you should also tune, including RAM access, disk access, and transmitting responses over the network. For example:

- If you add processors to a system running at 90% utilization that's disk-bound, it probably won't significantly improve performance. If you look more closely at the system, there are lots of threads that aren't even getting onto the processor because they're waiting for IO operations to complete.
- Resolving disk-bound issues can mean that threads previously stuck in waiting state stop being stuck, creating more competition for CPU time. As a result, the 90% utilization will go to 100%. You need to tune both components in order to bring utilization back down to manageable levels.
  
  > [!NOTE]
  > The `Processor Information(*)\% Processor Utility` counter can exceed 100% with systems that have a Turbo mode. Turbo mode lets the CPU exceeds the rated processor speed for short periods. If you need more information, look at the CPU manufacturers' documentation and counter descriptions.

Discussing whole-system utilization considerations also involves domain controllers as virtualized guests. [Response time and how system activity levels impact performance](#response-time-and-how-system-activity-levels-impact-performance) applies to both host and guest in a virtualized scenario. In a host with only one guest, a DC or system has almost the same performance as it would on physical hardware. Adding more guests to the hosts increases the utilization of the underlying host, also increasing wait times to get access to the processors. Therefore, you must manage logical processor utilization at both host and guest levels.

Let's revisit the highway metaphor from the previous sections, only this time we're imagining the guest VM as an express bus. Express buses, as opposed to public transit or school buses, go straight to the rider's destination without making any stops.

Now, let's imagine four scenarios:

- A system's off-peak hours are like riding an express bus late at night. When the rider gets on, there are almost no other passengers and the road is nearly empty. Because there's no traffic for the bus to contend with, the ride is easy and just as fast as if the rider had driven there in their own car. However, the rider's travel time is also constrained by the local speed limit.
- Off-peak hours when a system's CPU utilization is too high is like a late night ride when most of the lanes on the highway are closed. Even though the bus itself is mostly empty, the road is still congested from leftover traffic dealing with the restricted lanes. While the rider is free to sit anywhere they want, their actual trip time is determined by the traffic outside of the bus.
- A system with high CPU utilization during peak hours is like a crowded bus during rush hour. Not only does the trip take longer, but getting on and off the bus is harder because the bus is full of other passengers. Adding more logical processors to the guest system to try to speed up wait times would be like trying to solve the traffic problem by adding more buses. The problem isn't the number of buses, but how long the trip takes.
- A system with high CPU utilization during off-peak hours is like that same crowded bus on a mostly empty road at night. While riders may have trouble finding seats or getting on and off the bus, the trip will be fairly smooth once the bus picks up all its passengers. This scenario is the only one where performance would improve by adding more buses.

Based on the previous examples, you can see that there are many scenarios between 0% and 100% utilization that have varying degrees of impact on performance. Also, adding more logical processors doesn't necessarily improve performance outside of very specific scenarios. It should be fairly simple to apply these principles to the recommended 40% CPU utilization target for hosts and guests.

## Appendix B: Considerations regarding different processor speeds

In [Processsing](#processing), we assumed that the processor is running at 100% clock speed while you collect data, and that any replacement systems have the same processing speed. Despite these assumptions not being accurate, especially for Windows Server 2008 R2 and later, where the default power plan is Balanced, these assumptions still work for conservative estimates. While potential errors may increase, it only increases the margin of safety as processor speeds increase.

- For example, in a scenario that demands 11.25 CPUs, if the processors ran at half speed when you collected your data, the more accurate estimate of their demand would be 5.125 ÷ 2. <!--Is this right? He's not really clear about where this number came from.-->
- It's impossible to guarantee that doubling clock speed doubles the amount of processing that happens within the recorded time period. The amount of time processors spend waiting on RAM or other components stays roughly the same. Therefore, faster processors might spend a greater percentage of time idle while waiting for the system to fetch data. We recommend you stick with the lowest common denominator, keep your estimates conservative, and avoid assuming a linear comparison between processor speeds that could make your results inaccurate.

If processor speeds in your replacement hardware are lower than your current hardware, you should proportionally increase the estimate of how many processors you need. For example, let's look at a scenario where you calculate you need 10 processors to sustain your site's load. The current processors run at 3.3 GHz, and the processors you plan to replace them with run at 2.6 GHz. Replacing only the 10 original processors would give you a 21% decrease in speed. To increase speed, you need to get at least 12 processors instead of 10.

However, this variability doesn't change capacity management processor utilization targets. Processor clock speeds adjust dynamically based on load demand, so running the system under higher loads causes the CPU to spend more time in a higher clock speed state. The ultimate goal is to have the CPU be at 40% utilization in a 100% clock speed state during peak business hours. Anything less will generate power savings by throttling CPU speeds during off-peak scenarios.

> [!NOTE]
> You can turn off power management on the processors during data collection by setting the power plan to **High Performance**. Turning power management off gives you more accurate readings of CPU consumption in the target server.

To adjust estimates for different processors, we recommend you use the SPECint_rate2006 benchmark from Standard Performance Evaluation Corporation. To use this benchmark:

1. Go to the [Standard Performance Evaluation Corporation (SPEC) website](https://spec.org/).
1. Select **Results**.
1. Enter **CPU2006** and select **Search**.
1. In the drop-down menu for **Available Configurations**, select **All SPEC CPU2006**.
1. In the **Search Form Request** field, select **Simple**, then select **Go!**.
1. Under **Simple Request**, enter the search criteria for your target processor. FOr example, if you're looking for an ES-2630 processor, in the drop-down menu, select **Processor**, then enter the processor name in the search field. When finished, select **Execute Simple Fetch**.
1. Look for your server and processor configuration in the search results. If the search engine doesn't return an exact match, look for the closest match possible.
1. Record the values in the **Result** and **# Cores** columns.
1. Determine the modifier by using this equation:
   
   ((*Target platform per-core score value*) × (*MHz per-core of baseline platform*)) ÷ ((*Baseline per-core score value*) × (*MHz per-core of target platform*))

   For example, here's how you'd find the modifier for an ES-2630 processor:

   (35.83 × 2000) ÷ (33.75 × 2300) = 0.92

1. Multiply the number of processors you estimate you need by this modifier.

   For the ES-2630 processor example, 0.92 × 10.3 = 10.35 processors.

## Appendix C: How the operating system interacts with storage

The queuing theory concepts we discussed in [Response time and how system activity levels impact performance](#response-time-and-how-system-activity-levels-impact-performance) also apply to storage. You need to be familiar with how your OS handles IO in order to apply these concepts effectively. In Windows OSes, the OS creates a queue that holds IO requests for each physical disk. However, a physical disk isn't necessarily a single disk. The OS can also register an aggregation of spindles on an array controller or SAN as a physical disk. Array controllers and SANs can also aggregate multiple disks into an single array set, split it into multiple partitions, then use each partition as a physical disk, as shown in the following image.

![Block spindles](media/capacity-planning-considerations-block-spindles.png)
<!--Reformat image-->

In this illustration, the two spindles are mirrored and split into logical areas for data storage, labeled Data 1 and Data 2. The OS registers each of these logical areas as separate physical disks.

Now that we've clarified what defines a physical disk, you should also get familiar with the following terms to help you better understand the information in this Appendix.

- A *spindle* is the device physically installed in the server.
- An *array* is a collection of spindles aggregated by the controller.
- An *array partition* is a partitioning of the aggregated array.
- A *Logical Unit Number (LUN)* is an array of SCSI devices connected to a computer. This article uses these terms when talking about SANs.
- A *disk* includes any spindle or partition that the OS registers as a single physical disk.
- A *partition* is a logical partioning of what the OS registers as a physical disk. <!--Does this match teh definition given in the earlier paragraph?-->

### Operating system architecture considerations

The OS creates a First In, First Out (FIFO) IO queue for each disk it registers. These disks can be spindles, arrays, or array partitions. When it comes to how the OS handles IO, the more active queues, the better. When the OS serializes the FIFO queue, it must process all FIFO IO requests issued to the storage subsystem in order of arrival. By correlating each disk with a spindle or array, the OS maintains an IO queue for each unique set of disks, eliminating competition for scarce IO resources across disks and isolating IO demand to a single disk. However, Windows Server 2008 introduced an exception in the form of *IO prioritization*. Applications designed to use low priority IO are moved to the back of the queue no matter when the OS received them. Applications not specifically coded to use the low priority setting default to normal priority instead.

### Introducing simple storage subsystems

In this section, we talk about simple storage subsystems. Let's start with an example: a single hard drive inside a computer. If we break this system iown into its major storage subsystem components, here's what we get:

- One 10,000 RPM Ultra Fast SCSI HD (Ultra Fast SCSI has a 20 MBps transfer rate)
- One SCSI Bus (the cable)
- One Ultra Fast SCSI Adapter
- One 32-bit 33 MHz PCI bus

Once you identify the components, you can begin to get an idea of how much data the system can transmit and how much IO it can handle. The amount of IO and quantity of data that can transit the system are related to each other, but not the same value. This correlation depends on the block size and whether the disk IO is random or sequential. The system writes all data to the disk as a block, but different applications can use different block sizes.

Next, let's analyze these items on a compoment-by-component basis.

### The hard drive

The average 10,000-RPM hard drive has a 7 ms seek time and a 3 ms access time. Seek time is the average amount of time it takes the read or write head to move to a location on the platter. Access time is the average amount of time it takes for the head to read or write the data to disk once it's in the correct location. Therefore, the average time for reading a unique block of data in a 10,000-RPM HD includes both seek and access times for a total of approximately 10 ms, or .010 seconds, per block of data.

When every disk access requires the head move to a new location on the disk, the read or write behavior is called random. When all I/O is random, a 10,000-RPM HD can handle approximately 100 I/O per second (IOPS), based on this formula:

1000 ms per second ÷ 10 ms per I/O
<!--Double check equation format in style guide-->

When all I/O occurs from adjacent sectors on the hard drive, we call it *sequential IO*. Sequential IO has no seek time because, after the first IO finishes, the read or write head is at the start of where the hard drive is storing the next data block. For example, a Thus a 10,000-RPM HD is capable of handling approximately 333 I/O per second, based on the following equation:

1000 ms per second ÷ 3 ms per I/O

> [!NOTE]
> This example doesn't reflect the disk cache where the system typically keeps the data of one cylinder. In this case, the first IO needs 10 ms <!--Of what?--> and the disk reads the whole cylinder. All other sequential I/Os are satisfied by the cache. As a result, in-disk caches might improve sequential I/O performance.

So far, the transfer rate of the hard drive hasn't been relevant to our example. No matter the hard drive size, the actual amount of IOPS the 10,000-RPM HD can handle is always about 100 random or 300 sequential I/Os. As block sizes change based on which application is writing to the drive, the amount of data pulled per IO also changes. For example, if the block size is 8 KB, 100 I/O operations will read from or write to the hard drive a total of 800 KB. However, if the block size is 32 KB, 100 I/O will read or write 3,200 KB (3.2 MB) to the hard drive. If the SCSI transfer rate exceeds the total amount of transferred data, then getting a faster transfer rate doesn't change anything.

The following tables give a comparison between...<!--Between what and what? Original text didn't specify.-->

| Description | 7200 RPM 9ms seek, 4ms access | 10,000 RPM 7ms seek, 3ms access | 15,000 RPM 4ms seek, 2ms access |
|--|--|--|--|
| Random I/O | 80 | 100 | 150 |
| Sequential I/O | 250 | 300 | 500 |

| 10,000 RPM drive | 8 KB block size (Active Directory Jet) |
|--|--|
| Random I/O | 800 KB/s |
| Sequential I/O | 2400 KB/s |

#### The SCISI backplane (bus)

How the SCSI backplane, which in this example scenario is the ribbon cable, impacts throughput of the storage subsystem depends on block size. How much I/O can the bus handle if the I/O is in 8 KB blocks? In this scenario, the SCSI bus is 20 MBps, or 20480 KB/s. 20480 KB/s divided by 8 KB blocks yields a maximum of approximately 2500 IOPS supported by the SCSI bus.

> [!NOTE]
> The figures in the following table represent an example scenario. Most attached storage devices currently use PCI Express, which provides much higher throughput.

| I/O supported by SCSI bus per block size | 2 KB block size | 8 KB block size (AD Jet) (SQL Server 7.0/SQL Server 2000) |
|--|--|--|
| 20 MBps | 10,000 | 2,500 |
| 40 MBps | 20,000 | 5,000 |
| 128 MBps | 65,536 | 16,384 |
| 320 MBps | 160,000 | 40,000 |

As the previous table shows, in our example scenario, the bus is never a bottleneck because teh spindle maximum is 100 IO, way below any of the listed thresholds.

> [!NOTE]
> In this scenario, we're assuming that the SCSI bus is 100% efficient.

#### The SCSI adapter

In order to determine how much IO the system can handle, you must check the manufacturer's specifications. Directing IO requests to the appropriate device requires processing power, so how much IO the system can handle depends on the SCSI adaptor or array controller processor.

In this example scenario, we're assuming that the system can handle 1,000 I/O.

#### The PCI bus

The PCI bus is an oft-overlooked component. In this example scenario, the PCI bus isn't the bottleneck. However, as systems scale up, it can potentially become a bottleneck in the future.

We can see how much a PCI bus can transfer data in our example scenario by using this equation:

32 bits ÷ 8 bits per byte × 33 MHz = 133 MBps

Therefore, we can assume a 32 bit PCI bus operating at 33Mhz can transfer 133 MBps of data.

>[!NOTE]
>This equation's result represents the theoretical limit of transferred data. In reality, most systems only reach about 50% of maximum limit. In certain burst scenarios, the system can reach 75% of the limit for short periods.

A 66 MHz 64-bit PCI bus can support a theoretical maximum of 528 MBps based on this equation: 

64 bits ÷ 8 bits per byte × 66 Mhz = 528 MBps

Adding any other device, such as a network adapter or a second SCSI controller, reduces bandwidth available to the system, as all devices share the bandwidth and can compete with each other for limited processing resources.

#### Analyzing storage subsystems to find bottlenecks

<!--Where I left off.-->

In this scenario, the spindle is the limiting factor for how much I/O you can request. As a result, this bottleneck also limits how much data the system can transmit. Because our example is an AD DS scenario, the amount of transmittable data is 100 random I/O per second in 8 KB increments, for a total of 800 KB per second when you access the Jet database. In contrast, the maximum throughput for a spindle you configure to exclusively allocate to log files would be limited to 300 sequential I/O per second in 8 KB installments, totalling at 2,400 KB or 2.4 MB per second.

Now that we've analyzed the components of our example configuration, let's look at a table that demonstrates where bottlenecks can happen as we add and change components in the storage subsystem.

<!--I think I'll need to go in and rework this. The author used table format to try to make this data visually "snappier," but it might need to be written out instead.-->

| Notes | Bottleneck analysis | Disk | Bus | Adapter | PCI bus |
|--|--|--|--|--|--|
| This is the domain controller configuration after adding a second disk. The disk configuration represents the bottleneck at 800 KB/s. | Add 1 disk (Total=2)<p>I/O is random<p>4 KB block size<p>10,000 RPM HD | 200 I/Os total<br />800 KB/s total. |  |  |  |
| After adding 7 disks, the disk configuration still represents the bottleneck at 3200 KB/s. | Add 7 disks (Total=8)  <p>I/O is random<p>4 KB block size<p>10,000 RPM HD | 800 I/Os total.<br />3200 KB/s total |  |  |  |
| After changing I/O to sequential, the network adapter becomes the bottleneck because it is limited to 1000 IOPS. | Add 7 disks (Total=8)<p>I/O is sequential<p>4 KB block size<p>10,000 RPM HD |  |  | 2400 I/O sec can be read/written to disk, controller limited to 1000 IOPS |  |
| After replacing the network adapter with a SCSI adapter that supports 10,000 IOPS, the bottleneck returns to the disk configuration. | Add 7 disks (Total=8)<p>I/O is random<p>4 KB block size<p>10,000 RPM HD<p>Upgrade SCSI adapter (now supports 10,000 I/O) | 800 I/Os total.<br />3,200 KB/s total |  |  |  |
| After increasing the block size to 32 KB, the bus becomes the bottleneck because it only supports 20 MBps. | Add 7 disks (Total=8)<p>I/O is random<p>32 KB block size<p>10,000 RPM HD |  | 800 I/Os total. 25,600 KB/s (25 MBps) can be read/written to disk.<p>The bus only supports 20 MBps |  |  |
| After upgrading the bus and adding more disks, the disk remains the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI adapter with 14 disks<p>I/O is random<p>4 KB block size<p>10,000 RPM HD<p>Upgrade to 320 MBps SCSI bus | 2800 I/Os<p>11,200 KB/s (10.9 MBps) |  |  |  |
| After changing I/O to sequential, the disk remains the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI Adapter with 14 disks<p>I/O is sequential<p>4 KB block size<p>10,000 RPM HD<p>Upgrade to 320 MBps SCSI bus | 8,400 I/Os<p>33,600 KB\s<p>(32.8 MB\s) |  |  |  |
| After adding faster hard drives, the disk remains the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI adapter with 14 disks<p>I/O is sequential<p>4 KB block size<p>15,000 RPM HD<p>Upgrade to 320 MBps SCSI bus | 14,000 I/Os<p>56,000 KB/s<p>(54.7 MBps) |  |  |  |
| After increasing the block size to 32 KB, the PCI bus becomes the bottleneck. | Add 13 disks (Total=14)<p>Add second SCSI adapter with 14 disks<p>I/O is sequential<p>32 KB block size<p>15,000 RPM HD<p>Upgrade to 320 MBps SCSI bus |  |  |  | 14,000 I/Os<p>448,000 KB/s<p>(437 MBps) is the read/write limit to the spindle.<p>The PCI bus supports a theoretical maximum of 133 MBps (75% efficient at best). |

### Introducing RAID

When you introduce an array controller to your storage subsystem, it doesn't dramatically change its nature. The array controller only replaces the SCSI adapter in the calculations. However, the cost of reading and writing data to the disk when you use the various array levels does change.

In RAID 0, writing data stripes it across all disks in the RAID set. During a read or write operation, the system pulls data from or pushes it to each disk, increasing the amount of data the system can transmit during this particular time period. Therefore, in this example where we're using 10,000 RPM drives, using RAID 0 would let you perform 100 I/O operations. The total amount of I/O the system supports is *N* spindles times 100 1/O per second per spindle, or *N* spindles × 100 I/O per second per spindle.

<!--Reformat image-->

![Logical d: drive](media/capacity-planning-considerations-logical-d-drive.png)

In RAID 1, the system mirrors, or duplicates, data across a pair of spindles for redundancy. When the system performs a read I/O operation, it can read data from both spindles in the set. This mirroring makes I/O capacity for both disks available during a read operation. However, RAID 1 doesn't give write operations any performance advantages, because the system also needs to mirror written data on the pair of spindles. Although mirroring doesn't make write operations take longer, it does prevent the system from making more than one read operation at the same time. Therefore, every write I/O operation costs two read I/O operations.

The following equation calculates how many I/O operations are happening in this scenario:

*Read I/O* + 2 × *Write I/O* = *Total available disk I/O consumed*

When you know the ratio of reads to writes and the number of spindles in your deployment, you can use this equation to calculate how much I/O your array can support:

*Maximum IOPS per spindle* × 2 spindles × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 2 × *% Writes*)] = *Total IOPS*

A scenario using both RAID 1 and RAID 0 behaves exactly like RAID 1 in the cost of reading and writing operations. However, the I/O is now striped across each mirrored set. This means the equation will change to this:

*Maximum IOPS per spindle* × 2 spindles × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 2 × *% Writes*)] = *Total I/O*

in a RAID 1 set, when you stripe *N* number of RAID 1 sets, the total I/O your array can process becomes *N* × I/O per RAID 1 set:

*N* × {*Maximum IOPS per spindle* × 2 spindles × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 2 × *% Writes*)]} = *Total IOPS*

We sometimes call RAID 5 *N + 1* RAID because the system stripes the data across *N* spindles and writes parity information to the *+ 1* spindle. However, RAID 5 uses more resources when performing a write I/O than RAID 1 or RAID 1 + 0. RAID 5 performs the following process every time the operating system submits a write I/O to the array:

1. Read the old data.
1. Read the old parity.
1. Write the new data.
1. Write the new parity.

Every write I/O request that the OS sends to the array controller requires four I/O operations to finish. Therefore, *N* + 1 RAID write requests take four times as long as a read I/O to finish. In other words, to determine how many I/O requests from the OS translate to how many requests the spindles get, you use this equation:

*Read I/O* + 4 × *Write I/O* = *Total I/O*

Similarly, in a RAID 1 set where you know the ratio of reads to writes and how many spindles there are, you can use this equation to identify how much I/O your array can support:

*IOPS per spindle* × (*Spindles* – 1) × [(*% Reads* + *% Writes*) ÷ (*% Reads* + 4 × *% Writes*)] = *Total IOPS*

>[!NOTE]
>The previous equation's result doesn't include the drive lost to parity.

### Introducing SANs

When you introduce a storage area network (SAN) into your environment, it doesn't affect the planning principles we've described in the earlier sections. However, you should take into account that the SAN can change the I/O behavior for all systems connected to it. One of the main advantages of using a SAN is that it gives you more redundancy over internally or externally attached storage, but it also means your capacity planing needs to account for fault tolerance needs. Also, as you introduce more components to your system, you also need to factor these new parts into your calculations.

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

When you analyze the channel on the storage unit, you should take the same approach you did when calculating how many resources were available on the SCSI bus: divide the bandwidth by the block size. For example, if your storage unit has six channels that each support a 20 MBps maximum transfer rate, your total amount of available I/O and data transfer is 100 MBps. The reason the total is 100 MBps instead of 120 MBps is because the storage channel total throughput shouldn't exceed the amount of throughput it would use if one of the channels were to suddenly turn off, leaving it with only five functioning channels. Of course, this example also assumes that the system is evenly distributing load and fault tolerance across all channels.

Whether you can turn the previous example into an I/O profile depends on the application behavior. For Active Directory Jet I/O, the maximum value would be approximately 12,500 I/O per second, or 100 MBps ÷ 8 KB per I/O.

In order to understand how much throughput your controller modules support, you also need to get their manufacturer specifications. In this example, the SAN has two controller modules that support 7,500 I/O each. If you aren't using redundancy, then the total system throughput would be 15,000 IOPS. However, in a scenario where redundancy is required, you'd calculate the maximum throughput based on the limits of only one of the controllers, which is 7,500 IOPS. Assuming that the block size is 4 KB, this threshold is well below the 12,500 IOPS maximum that the storage channels can support, and is therefore the bottleneck in your analysis. However, for planning purposes, the desired maximum I/O you should plan for is 10,400 I/O.

<!--How exactly did the original author get to this number? Not much context in the original paragraph.-->

When the data leaves the controller module, it transmits a Fibre Channel connection rated at 1 GBps, or 128 MBps. Because this amount exceeds the total bandwidth of 100 MBps across all the storage unit channels, it won't bottleneck the system. Also, because this transmission is on only one of the two Fibre Channels due to redundancy, if one Fibre Channel connection stops working, the remaining connection still has enough capacity to handle the data transfer demand.

The data then transits a SAN switch on its way to the server. The switch limits the amount of I/O it can handle because it needs to process the incoming request and then forward it to the appropriate port. However, you can only know what the switch limit is if you look at the manufacturer specifications. For example, if your system has two switches and each switch can handle 10,000 IOPS, the total throughput will be 20,000 IOPS. Based on the rules of fault tolerance, if one switch stops working, the total system throughput will be 10,000 IOPS. Therefore, during normal circumstances, you shouldn't use more than 80% utilization, or 8,000 I/O.

Finally, the HBA you install in the server also limits how much I/O it can handle. Typically, you install a second HBA for redundancy, but like with the SAN switch, when you calculate how much I/O the system can handle, the total throughput will be *N* - 1 HBA.

### Caching considerations

Caches are one of the components that can significantly impact overall performance anywhere in the storage system. However, a detailed analysis of caching algorithms is beyond the scope of this article. Instead, we'll give you a quick list of things you should know about caching on disk subsystems.

<!--Where I left off.-->

- Caching does improved sustained sequential write I/O as it can buffer many smaller write operations into larger I/O blocks and de-stage to storage in fewer, but larger block sizes. This will reduce total random I/O and total sequential I/O, thus providing more resource availability for other I/O.
- Caching does not improve sustained write I/O throughput of the storage subsystem. It only allows for the writes to be buffered until the spindles are available to commit the data. When all the available I/O of the spindles in the storage subsystem is saturated for long periods, the cache will eventually fill up. In order to empty the cache, enough time between bursts, or extra spindles, need to be allotted in order to provide enough I/O to allow the cache to flush.

  Larger caches only allow for more data to be buffered. This means longer periods of saturation can be accommodated.

  In a normally operating storage subsystem, the operating system will experience improved write performance as the data only needs to be written to cache. Once the underlying media is saturated with I/O, the cache will fill and write performance will return to disk speed.

- When caching read I/O, the scenario where the cache is most advantageous is when the data is stored sequentially on the disk, and the cache can read-ahead (it makes the assumption that the next sector contains the data that will be requested next).
- When read I/O is random, caching at the drive controller is unlikely to provide any enhancement to the amount of data that can be read from the disk. Any enhancement is non-existent if the operating system or application-based cache size is greater than the hardware-based cache size.

  In the case of Active Directory, the cache is only limited by the amount of RAM.

### SSD considerations

SSDs are a completely different animal than spindle-based hard disks. Yet the two key criteria remain: “How many IOPS can it handle?” and “What is the latency for those IOPS?” In comparison to spindle-based hard disks, SSDs can handle higher volumes of I/O and can have lower latencies. In general and as of this writing, while SSDs are still expensive in a cost-per-Gigabyte comparison, they are very cheap in terms of cost-per-I/O and deserve significant consideration in terms of storage performance.

Considerations:

- Both IOPS and latencies are very subjective to the manufacturer designs and in some cases have been observed to be poorer performing than spindle based technologies. In short, it is more important to review and validate the manufacturer specs drive by drive and not assume any generalities.
- IOPS types can have very different numbers depending on whether it is read or write. AD DS services, in general, being predominantly read-based, will be less affected than some other application scenarios.
- “Write endurance” – this is the concept that SSD cells will eventually wear out. Various manufacturers deal with this challenge different fashions. At least for the database drive, the predominantly read I/O profile allows for downplaying the significance of this concern as the data is not highly volatile.

### Summary

One way to think about storage is picturing household plumbing. Imagine the IOPS of the media that the data is stored on is the household main drain. When this is clogged (such as roots in the pipe) or limited (it is collapsed or too small), all the sinks in the household back up when too much water is being used (too many guests). This is perfectly analogous to a shared environment where one or more systems are leveraging shared storage on an SAN/NAS/iSCSI with the same underlying media. Different approaches can be taken to resolve the different scenarios:

- A collapsed or undersized drain requires a full scale replacement and fix. This would be similar to adding in new hardware or redistributing the systems using the shared storage throughout the infrastructure.
- A “clogged” pipe usually means identification of one or more offending problems and removal of those problems. In a storage scenario this could be storage or system level backups, synchronized antivirus scans across all servers, and synchronized defragmentation software running during peak periods.

In any plumbing design, multiple drains feed into the main drain. If anything stops up one of those drains or a junction point, only the things behind that junction point back up. In a storage scenario, this could be an overloaded switch (SAN/NAS/iSCSI scenario), driver compatibility issues (wrong driver/HBA Firmware/storport.sys combination), or backup/antivirus/defragmentation. To determine if the storage “pipe” is big enough, IOPS and I/O size needs to be measured. At each joint add them together to ensure adequate “pipe diameter.”

## Appendix D - Discussion on storage troubleshooting - Environments where providing at least as much RAM as the database size is not a viable option

It is helpful to understand why these recommendations exist so that the changes in storage technology can be accommodated. These recommendations exist for two reasons. The first is isolation of IO, such that performance issues (that is, paging) on the operating system spindle do not impact performance of the database and I/O profiles. The second is that log files for AD DS (and most databases) are sequential in nature, and spindle-based hard drives and caches have a huge performance benefit when used with sequential I/O as compared to the more random I/O patterns of the operating system and almost purely random I/O patterns of the AD DS database drive. By isolating the sequential I/O to a separate physical drive, throughput can be increased. The challenge presented by today's storage options is that the fundamental assumptions behind these recommendations are no longer true. In many virtualized storage scenarios, such as iSCSI, SAN, NAS, and Virtual Disk image files, the underlying storage media is shared across multiple hosts, thus completely negating both the “isolation of IO” and the “sequential I/O optimization” aspects. In fact these scenarios add an additional layer of complexity in that other hosts accessing the shared media can degrade responsiveness to the domain controller.

In planning storage performance, there are three categories to consider: cold cache state, warmed cache state, and backup/restore. The cold cache state occurs in scenarios such as when the domain controller is initially rebooted or the Active Directory service is restarted and there is no Active Directory data in RAM. Warm cache state is where the domain controller is in a steady state and the database is cached. These are important to note as they will drive very different performance profiles, and having enough RAM to cache the entire database does not help performance when the cache is cold. One can consider performance design for these two scenarios with the following analogy, warming the cold cache is a “sprint” and running a server with a warm cache is a “marathon.”

For both the cold cache and warm cache scenario, the question becomes how fast the storage can move the data from disk into memory. Warming the cache is a scenario where, over time, performance improves as more queries reuse data, the cache hit rate increases, and the frequency of needing to go to disk decreases. As a result the adverse performance impact of going to disk decreases. Any degradation in performance is only transient while waiting for the cache to warm and grow to the maximum, system-dependent allowed size. The conversation can be simplified to how quickly the data can be gotten off of disk, and is a simple measure of the IOPS available to Active Directory, which is subjective to IOPS available from the underlying storage. From a planning perspective, because warming the cache and backup/restore scenarios happen on an exceptional basis, normally occur off hours, and are subjective to the load of the DC, general recommendations do not exist except in that these activities be scheduled for non-peak hours.

AD DS, in most scenarios, is predominantly read IO, usually a ratio of 90% read/10% write. Read I/O often tends to be the bottleneck for user experience, and with write IO, causes write performance to degrade. As I/O to the NTDS.dit is predominantly random, caches tend to provide minimal benefit to read IO, making it that much more important to configure the storage for read I/O profile correctly.

For normal operating conditions, the storage planning goal is minimize the wait times for a request from AD DS to be returned from disk. This essentially means that the number of outstanding and pending I/O is less than or equivalent to the number of pathways to the disk. There are a variety of ways to measure this. In a performance monitoring scenario, the general recommendation is that LogicalDisk((`<NTDS Database Drive>`))\Avg Disk sec/Read be less than 20 ms. The desired operating threshold must be much lower, preferably as close to the speed of the storage as possible, in the 2 to 6 millisecond (.002 to .006 second) range depending on the type of storage.

Example:

![Storage latency chart](media/capacity-planning-considerations-storage-latency.png)

Analyzing the chart:

- **Green oval on the left –** The latency remains consistent at 10 ms. The load increases from 800 IOPS to 2400 IOPS. This is the absolute floor to how quickly an I/O request can be processed by the underlying storage. This is subject to the specifics of the storage solution.
- **Burgundy oval on the right –** The throughput remains flat from the exit of the green circle through to the end of the data collection while the latency continues to increase. This is demonstrating that when the request volumes exceed the physical limitations of the underlying storage, the longer the requests spend sitting in the queue waiting to be sent out to the storage subsystem.

Applying this knowledge:

- **Impact to a user querying membership of a large group –** Assume this requires reading 1 MB of data from the disk, the amount of I/O and how long it takes can be evaluated as follows:
  - Active Directory database pages are 8 KB in size.
  - A minimum of 128 pages need to be read in from disk.
  - Assuming nothing is cached, at the floor (10 ms) this is going to take a minimum 1.28 seconds to load the data from disk in order to return it to the client. At 20 ms, where the throughput on storage has long since maxed out and is also the recommended maximum, it will take 2.5 seconds to get the data from disk in order to return it to the end user.
- **At what rate will the cache be warmed –** Making the assumption that the client load is going to maximize the throughput on this storage example, the cache will warm at a rate of 2400 IOPS × 8 KB per IO. Or, approximately 20 MBps per second, loading about 1 GB of database into RAM every 53 seconds.

> [!NOTE]
> It is normal for short periods to observe the latencies climb when components aggressively read or write to disk, such as when the system is being backed up or when AD DS is running garbage collection. Additional head room on top of the calculations should be provided to accommodate these periodic events. The goal being to provide enough throughput to accommodate these scenarios without impacting normal function.

As can be seen, there is a physical limit based on the storage design to how quickly the cache can possibly warm. What will warm the cache are incoming client requests up to the rate that the underlying storage can provide. Running scripts to “pre-warm” the cache during peak hours will provide competition to load driven by real client requests. That can adversely affect delivering data that clients need first because, by design, it will generate competition for scarce disk resources as artificial attempts to warm the cache will load data that is not relevant to the clients contacting the DC.
