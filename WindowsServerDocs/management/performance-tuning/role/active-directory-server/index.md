---
title: Performance Tuning Active Directory Servers
description: Performance Tuning for Active Directory Servers
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 83b88700-365b-42df-a9d6-fb011b20ed6f
author: phstee
ms.author: TimWi; ChrisRob; HerbertM; KenBrumf;  MLeary; ShawnRab
ms.date: 10/31/2016
---

# Performance Tuning Active Directory Servers


Performance tuning Active Directory is focused on two goals:

-   Active Directory is optimally configured to service the load in the most efficient manner possible

-   Workloads submitted to Active Directory should be as efficient as possible

This requires proper attention to three separate areas:

-   Proper capacity planning – ensuring sufficient hardware is in place to support existing load

-   Server side tuning – configuring domain controllers to handle the load as efficiently as possible

-   Active Directory client/application tuning – ensuring that clients and applications are using Active Directory in an optimal fashion

**In this topic:**

-   [Capacity planning](#cap)

-   [Updates and evolving recommendations](#updates)

-   [Hardware basics](#hw)

-   [Proper placement of domain controllers and site considerations](#dcsite)

-   [LDAP considerations](#ldap)

-   [Troubleshooting](#ts)

## <a href="" id="cap"></a>Capacity planning


Properly deploying a sufficient number of domain controllers, in the right domain, in the right locales, and to accommodate redundancy is critical to ensuring servicing client requests in a timely fashion. This is an in-depth topic and outside of the scope of this guide. To ensure proper configuration and sizing of Active Directory, see [Capacity Planning for Active Directory Domain Services](http://go.microsoft.com/fwlink/?LinkId=324566).

## <a href="" id="updates"></a>Updates and evolving recommendations


Massive improvements in both Active Directory and client performance optimizations have occurred over the last several generations of the operating system and these efforts continue. We recommend that the most current versions of the platform be deployed to get the benefits, including:

-   New capabilities

-   Increased reliability

-   Better performance

-   Better logging and tools to troubleshoot

However, we realize that this takes time and many environments are running in a scenario where 100% adoption of the most current platform is impossible. Some improvements have been added to older versions of the platform and we’ll continue to add more. We recommend keeping current with these updates.

## <a href="" id="hw"></a>Hardware basics


This is a summary of key points covered in much greater depth in the [Capacity Planning for Active Directory Domain Services](http://go.microsoft.com/fwlink/?LinkId=324566) and is not a replacement for that content.

Read the following sections to optimize hardware for responsiveness of domain controllers to client requests.

### Avoid going to disk

Active Directory caches as much of the database as memory allows. Fetching pages from memory are orders of magnitude faster than going to physical media, whether the media is spindle or SSD based. Add more memory to minimize disk I/O.

-   Active Directory Best Practices recommend putting enough RAM to load the entire DIT into memory, plus accommodate the operating system and other installed applications, such as anti-virus, backup software, monitoring, and so on.

    -   For limitations of the legacy platforms, see [Memory usage by the Lsass.exe process on domain controllers that are running Windows Server 2003 or Windows 2000 Server](http://support.microsoft.com/kb/308356).

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

### <a href="" id="don-t-over-tax-the-processors"></a>Don’t over tax the processors

Processors that don’t have enough free cycles can cause long wait times on getting threads on to the processor for execution. Across many environments, the philosophy is to ensure that there is enough head room to accommodate surges or spikes in load to minimize impact on client responsiveness in these scenarios. In short, exceeding the below thresholds is not bad in the short term (5 to 15 minutes a few times a day), however a system running sustained with these sorts of statistics doesn’t provide any head room to accommodate abnormal loads and can easily be put into an over taxed scenario. Systems spending sustained periods above the thresholds should be investigated to how to reduce processor loads.

-   For more info on how to select a processor, see [Performance Tuning for Server Hardware](../../hardware/index.md).

-   Add hardware, optimize load, direct clients elsewhere, or remove load from the environment to reduce CPU load.

-   Use the Processor Information(\_Total)\\% Processor Utilization &lt; 60% performance counter.

### Avoid overloading the network adapter

Just like with processors, excessive network adapter utilization will cause long wait times for the outbound traffic to get on to the network. Active Directory tends to have small inbound requests and relatively to significantly larger amounts of data returned to the client systems. Sent data far exceeds received data. Across many environments, the philosophy is to ensure that there is enough head room to accommodate surges or spikes in load. This threshold is a warning threshold where the head room to accommodate surges or spikes in load becomes constrained and client responsiveness degrades. In short, exceeding these thresholds is not bad in the short term (5 to 15 minutes a few times a day), however a system running sustained with these sorts of statistics is over taxed and should be investigated.

-   For more info on how to tune the network subsystem, see [Performance Tuning for Network Subsystems](../../../../networking/technologies/network-subsystem/net-sub-performance-top.md).

-   Use the Compare NetworkInterface(\*)\\Bytes Sent/Sec with NetworkInterface(\*)\\Current Bandwidth performance counter. The ratio should be less than 60% utilized.

## <a href="" id="dcsite"></a>Proper placement of domain controllers and site considerations


### Proper site definition

This is critical to performance. Clients falling out of site can experience poor performance for authentications and queries. Furthermore, with the introduction of IPv6 on clients, the request can come from either the IPv4 or the IPv6 address and Active Directory needs to have sites properly defined for IPv6. The operating system prefers IPv6 to IPv4 when both are configured.

Starting in Windows Server 2008, the domain controller attempts to use name resolution to do a reverse lookup in order to determine the site the client should be in. This can cause exhaustion of the ATQ Thread Pool and cause the domain controller to become unresponsive. The appropriate resolution to this is to properly define the site topology for IPv6. As a workaround, one can optimize the name resolution infrastructure to respond quickly to domain controller requests. For more info see [Windows Server 2008 or Windows Server 2008 R2 Domain Controller delayed response to LDAP or Kerberos requests](http://support.microsoft.com/kb/2668820).

An additional area of consideration is locating Read/Write DCs for scenarios where RODCs are in use.  Certain operations require access to a writable Domain Controller or target a writable Domain Controller when a Read-Only Domain Controller would suffice.  Optimizing these scenarios would take two paths:
-   Contacting writable Domain Controllers when a Read-Only Domain Controller would suffice.  This requires an application code change.
-   Where a writable Domain Controller may be necessary.  Place read-write Domain Controllers at central locations to minimize latency.

For further information reference:
-   [Application Compatibility with RODCs](https://technet.microsoft.com/en-us/library/cc772597.aspx)
-   [Active Directory Service Interface (ADSI) and the Read Only Domain Controller (RODC) – Avoiding performance issues](https://blogs.technet.microsoft.com/fieldcoding/2012/06/24/active-directory-service-interface-adsi-and-the-read-only-domain-controller-rodc-avoiding-performance-issues/)

### Optimize for referrals

Referrals are how LDAP queries are redirected when the domain controller does not host a copy of the partition queried. When a referral is returned, it contains the distinguished name of the partition, a DNS name, and a port number. The client uses this information to continue the query on a server that hosts the partition. This is a DCLocator scenario and all of the recommendations site definitions and domain controller placement is maintained, but applications which depend on referrals are often overlooked. It is recommended to ensure AD Topology including site definitions and domain controller placement properly reflects the needs of the client. Also, this may include having domain controllers from multiple domains in a single site, tuning DNS settings, or relocating the site of an application.

### Optimization considerations for trusts

In an intra-forest scenario, trusts are processed according to the following domain hierarchy: Grand-Child Domain -&gt; Child Domain -&gt; Forest Root Domain -&gt; Child Domain -&gt; Grand-Child Domain. This means that secure channels at the forest root, and each parent, can become overloaded due to aggregation of authentication requests transiting the DCs in the trust hierarchy. This may also incur delays in Active Directories of large geographical dispersion when authentication also has to transit highly latent links to affect the above flow. Overloads can occur in inter-forest and down-level trust scenarios. The following recommendations apply to all scenarios:

-   Properly tune the MaxConcurrentAPI to support the load across the secure channel. For more info, see [How to do performance tuning for NTLM authentication by using the MaxConcurrentApi setting](http://support.microsoft.com/kb/2688798/EN-US).

-   Create shortcut trusts as appropriate based on load.

-   Ensure that every domain controller in the domain is able to perform name resolution and communicate with the domain controllers in the trusted domain.

-   Ensure locality considerations are taken into account for trusts.

-   Enable Kerberos where possible and minimize use of the secure channel to reduce risk of running into MaxConcurrentAPI bottlenecks.

Cross domain trust scenarios are an area that has been consistently a pain point for many customers. Name resolution and connectivity issues, often due to firewalls, cause resource exhaustion on the trusting domain controller and impact all clients. Furthermore, an often overlooked scenario is optimizing access to trusted domain controllers. The key areas to ensure this works properly are as follows:

-   Ensure the DNS and WINS name resolution that the trusting domain controllers are using can resolve an accurate list of domain controllers for the trusted domain.

    -   Statically added records have a tendency to become stale and reintroduce connectivity problems over time. DNS forwards, Dynamic DNS, and merging WINS/DNS infrastructures are more maintainable in the long run.

    -   Ensure proper configuration of forwarders, conditional forwards, and secondary copies for both forward and reverse lookup zones for every resource in the environment which a client may need to access. Again, this requires manual maintenance and has a tendency to become stale. Consolidation of infrastructures is ideal.

-   Domain controllers in the trusting domain will attempt to locate domain controllers in the trusted domain that are in the same site first and then failback to the generic locators.

    -   For more info on how DCLocator works, see [Finding a Domain Controller in the Closest Site](http://technet.microsoft.com/library/cc978016.aspx).

    -   Converge site names between the trusted and trusting domains to reflect domain controller in the same location. Ensure subnet and IP address mappings are properly linked to sites in both forests. For more info, see [Domain Locator Across a Forest Trust](http://blogs.technet.com/b/askds/archive/2008/09/24/domain-locator-across-a-forest-trust.aspx).

    -   Ensure ports are open, according to DCLocator needs, for domain controller location. If firewalls exist between the domains, ensure that the firewalls are properly configured for ALL trusts. If firewalls are not open, the trusting domain controller will still attempt to access the trusted domain. If communication fails for any reason, the trusting domain controller will eventually time out the request to the trusted domain controller. However, these time outs can take several seconds per request and can exhaust network ports on the trusting domain controller if the volume of incoming requests is high. The client may experience the waits to timeout at the domain controller as hung threads, which could translate to hung applications (if the application runs the request in the foreground thread). For more info, see [How to configure a firewall for domains and trusts](http://support.microsoft.com/kb/179442).

    -   Use DnsAvoidRegisterRecords to eliminate poorly performing or high-latency domain controllers, such as those in satellite sites, from advertising to the generic locators. For more info, see [How to optimize the location of a domain controller or global catalog that resides outside of a client's site](http://support.microsoft.com/kb/306602).

        **Note**  
        There is a practical limit of about 50 to the number of domain controllers the client can consume. These should be the most site-optimal and highest capacity domain controllers.

         

    -   Consider placing domain controllers from trusted and trusting domains in the same physical location.

For all trust scenarios, credentials are routed according to the domain specified in the authentication requests. This is also true for queries to the LookupAccountName and LsaLookupNames (as well as others, these are just the most commonly used) APIs. When the domain parameters for these APIs are passed a NULL value, the domain controller will attempt to find the account name specified in every trusted domain available.

-   Disable checking all available trusts when NULL domain is specified. [How to restrict the lookup of isolated names in external trusted domains by using the LsaLookupRestrictIsolatedNameLevel registry entry](http://support.microsoft.com/kb/818024)

-   Disable passing authentication requests with NULL domain specified across all available trusts. [The Lsass.exe process may stop responding if you have many external trusts on an Active Directory domain controller](http://support.microsoft.com/kb/923241/EN-US)

## <a href="" id="ldap"></a>LDAP considerations


### Verify LDAP queries

Verify that LDAP queries conform with the creating efficient queries recommendations.

There is extensive documentation on MSDN about how to properly write, structure, and analyze queries for use against Active Directory. For more info, see [Creating More Efficient Microsoft Active Directory-Enabled Applications](http://msdn.microsoft.com/library/ms808539.aspx).

### Optimize LDAP page sizes

When returning results with multiple objects in response to client requests, the domain controller has to temporarily store the result set in memory. Increasing page sizes will cause more memory usage and can age items out of cache unnecessarily. In this case, the default settings are optimal. There are several scenarios where recommendations were made to increase the page size settings. We recommend using the default values unless specifically identified as inadequate.

When queries have many results, a limit of similar queries concurrently executed may be encountered.  This occurs as the LDAP server may deplete a global memory area known as the cookie pool.  It may be necessary to increase the size of the pool as discussed in [How LDAP Server Cookies Are Handled](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-ds/manage/how-ldap-server-cookies-are-handled).

To tune these settings, see [Windows Server 2008 and newer domain controller returns only 5000 values in a LDAP response](http://support.microsoft.com/kb/2009267).

### Determine whether to add indices

Indexing attributes is useful when searching for objects that have the attribute name in a filter. Indexing can reduce the number of objects that must be visited when evaluating the filter. However, this reduces the performance of write operations because the index must be updated when the corresponding attribute is modified or added. It also increases the size of the directory database, though the benefits often outweigh the cost of storage. Logging can be used to find the expensive and inefficient queries. Once identified, consider indexing some attributes that are used in the corresponding queries to improve the search performance. For more info on how Active Directory Searches work, see [How Active Directory Searches Work](http://technet.microsoft.com/library/cc755809.aspx).

Some scenarios in which to add indices include:

-   Client load in requesting the data is generating significant CPU usage and the client query behavior cannot be changed or optimized. By significant load, consider that it is showing itself in a Top 10 offender list in Server Performance Advisor or the built-in Active Directory Data Collector Set and is using more than 1% of CPU.

-   The client load is generating significant disk I/O on a server due to an unindexed attribute and the client query behavior cannot be changed or optimized.

-   A query is taking a long time and is not completing in an acceptable timeframe to the client due to lack of covering indices.

-   Large volumes of queries with high durations are causing consumption and exhaustion of ATQ LDAP Threads. Monitor the following performance counters:

    -   **NTDS\\Request Latency** – This is subject to how long the request takes to process. Active Directory times out requests after 120 seconds (default), however, the majority should run much faster and extremely long running queries should get hidden in the overall numbers. Look for changes in this baseline, rather than absolute thresholds.

        **Note**  
        High values here can also be indicators of delays in “proxying” requests to other domains and CRL checks.

         

    -   **NTDS\\Estimated Queue Delay** – This should ideally be near 0 for optimal performance as this means that requests spend no time waiting to be serviced.

These scenarios can be detected using one or more of the following approaches:

-   [Determining Query Timing with the Statistics Control](http://msdn.microsoft.com/library/ms808539.aspx)

-   [Tracking Expensive and Inefficient Searches](http://msdn.microsoft.com/library/ms808539.aspx)

-   Active Directory Diagnostics Data Collector Set in Performance Monitor ([Son of SPA: AD Data Collector Sets in Win2008 and beyond](http://blogs.technet.com/b/askds/archive/2010/06/08/son-of-spa-ad-data-collector-sets-in-win2008-and-beyond.aspx))

-   [Microsoft Server Performance Advisor](../../../server-performance-advisor/microsoft-server-performance-advisor.md) Active Directory Advisor Pack

-   Searches using any filter besides “(objectClass=\*)” that use the Ancestors Index.

Considerations:

-   Ensure that creating the index is the right solution to the problem after tuning the query has been exhausted as an option. Sizing hardware properly is very important. Indices should be added only when the right fix is to index the attribute, and not an attempt to obfuscate hardware problems.

-   Indices increase the size of the database by a minimum of the total size of the attribute being indexed. An estimate of database growth can therefore be evaluated by taking the average size of the data in the attribute and multiplying by the number of objects that will have the attribute populated. Generally this is about a 1% increase in database size. For more info, see [How the Data Store Works](http://technet.microsoft.com/library/cc772829.aspx).

-   If search behavior is predominantly done at the organization unit level, consider indexing for containerized searches.

-   Tuple indices are larger than normal indices, but it is much harder to estimate the size. Use normal indices size estimates as the floor for growth, with a maximum of 20%. For more info, see [How the Data Store Works](http://technet.microsoft.com/library/cc772829.aspx).

-   If search behavior is predominantly done at the organization unit level, consider indexing for containerized searches.

-   Tuple Indices are needed to support medial search strings and final search strings. Tuple indices are not needed for initial search strings.

    -   Initial Search String – (samAccountName=MYPC\*)

    -   Medial Search String - (samAccountName=\*MYPC\*)

    -   Final Search String – (samAccountName=\*MYPC$)

-   Creating an index will generate disk I/O while the index is being built. This is done on a background thread with lower priority and incoming requests will be prioritized over the index build. If capacity planning for the environment has been done correctly, this should be transparent. However, write-heavy scenarios or an environment where the load on the domain controller storage is unknown could degrade client experience and should be done off-hours.

-   Affects to replication traffic is minimal since building indices occurs locally.

For more info, see the following:

-   [Creating More Efficient Microsoft Active Directory-Enabled Applications](http://msdn.microsoft.com/library/ms808539.aspx)

-   [Searching in Active Directory Domain Services](http://msdn.microsoft.com/library/aa746427.aspx)

-   [Indexed Attributes](http://msdn.microsoft.com/library/windows/desktop/ms677112.aspx)

## <a href="" id="ts"></a>Troubleshooting


For info on troubleshooting, see [Monitoring Your Branch Office Environment](http://technet.microsoft.com/library/dd736504.aspx).
