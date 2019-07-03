---
title: Memory usage considerations in AD DS performance tuning
description: Memory usage by the Lsass.exe process on domain controllers that are running Windows Server 2012 R2, 2016 and 2019.
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: v-tea; lindakup
author: Teresa-Motiv
ms.date: 7/3/2019
---

# Memory usage considerations for AD DS performance tuning

This article describes some Lsass.exe process basics, best practices for the configuration of the Lsass.exe process, and expectations for memory usage. This article should be used as a guide in the analysis of Lsass.exe performance and memory use on domain controllers. The information in this article may be useful if you have questions about how to tune and configure servers and domain controllers to optimize this engine.  

The Lsass.exe process is responsible for management of local security authority (LSA) domain authentication and Active Directory management. This process handles authentication for both the client and the server, and it also governs the Active Directory engine. The Lsass.exe process is responsible for the following components:  

- Local Security Authority
- NetLogon service
- Security Accounts Manager (SAM) service
- LSA Server service
- Secure Sockets Layer (SSL)
- Kerberos v5 authentication protocol
- NTLM authentication protocol
- Other authentication packages that load into LSA

The AD database services (NTDSAI.DLL) are working with the Extensible Storage Engine (ESE, ESENT.DLL).

Here is a visual diagram of LSASS memory usage on a Domain Controller (DC):

![Diagram of the components that use LSASS memory](media/domain-controller-lsass-memory-usage.png)  

The amount of memory that the Lsass.exe process uses on a DC increases in accordance with Active Directory usage. When data is queried, it is cached in memory.  

LSASS process memory usage can be divided into several parts as illustrated in the above diagram.

## ESE database buffer cache  
The largest variable memory usage within the Lsass.exe process is the ESE database buffer cache. The size of the cache can range from less than 1 MB to the size of the entire database. Because a larger cache improves performance, the database engine for AD (ESENT) attempts to keep the cache as large as possible. While the size of the cache varies with memory pressure in the computer, the maximum size of the ESE Database cache is limited ONLY by physical RAM installed in the computer can grow to the size of the AD NTDS.DIT database file as long as there is no other memory pressure. The more of the AD database that can be cached, the better the performance of the DC will be.  
  
> [!NOTE]
> Because of the way that the database caching algorithm works, on a 64-bit system on which the database size is smaller than the available RAM, the database cache can grow larger than the database size by 30 to 40 percent.

## ESE version store

There is variable memory usage by the ESE Version store (the red part in the diagram above). The amount of memory used depends on whether you have Windows Server 2019 or older versions of Windows.

- In Windows Server versions predating WS 2019, by default Lsass.exe may use up to around 400MB of memory (depending on the number of CPUs) on a 64-bit machine for the ESE version store. For more information about how the version store is used see the following ASKDS blog post by Ryan Ries: [The Version Store Called and They're All Out of Buckets](https://techcommunity.microsoft.com/t5/Ask-the-Directory-Services-Team/The-Version-Store-Called-and-They-8217-re-All-Out-of-Buckets/ba-p/400415).

- In WS 2019 this is simplified and when NTDS service first starts, the ESE version store size is now calculated as 10% of physical RAM, with a minimum of 400MB and a maximum of 4GB. For great details about this and version store troubleshooting, see another great blog from Ryan here: [Deep Dive: Active Directory ESE Version Store Changes in Server 2019](https://techcommunity.microsoft.com/t5/Ask-the-Directory-Services-Team/Deep-Dive-Active-Directory-ESE-Version-Store-Changes-in-Server/ba-p/400510).

## Other memory use

Finally, there is code, stacks, heaps, and various fixed size data structures (for example, the schema cache). The amount of memory that Lsass.exe uses may vary, depending on the load on the computer. As the number of running threads increases, so does the number of memory stacks. Lsass.exe process usually uses 100 MB to 300 MB of memory for these fixed components on average. When a larger amount of RAM is installed, Lsass.exe can use more RAM and less virtual memory.

**Limit or minimize the number of programs on your domain controller OR add additional RAM where appropriate**

For optimum performance, the Lsass.exe process takes as much RAM as possible on a given DC. The Lsass.exe process relinquishes that RAM as other processes ask for it. The idea is to optimize performance of the Lsass.exe process while still accounting for other processes that might run on a computer. The list of programs to watch out for includes monitoring agents. Some customers have separate agents for various server functions which can consume quite some RAM resources. Some may issue many WMI queries, for which we have a few details below.

Because of this and to increase performance, it is a good practice to limit or minimize the number of programs on a DC. If there are no memory requests, the Lsass.exe process uses this memory to cache the Active Directory database and therefore achieve optimum performance.

When you notice that a DC has performance problems, also watch for processes with significant memory utilization. These may have a problem you need to troubleshoot. They may include Microsoft Components. Please make sure you keep up with recent servicing updates&mdash;Microsoft is including solutions for excessive memory utilization as part of the quality updates, which may also help your DC performance.

There are built-in OS facilities that can consume significant RAM depending on the usage profile:

- **File Server**. DCs are also file servers for SYSVOL and Netlogon shares, servicing group policy and scripts for policy and startup/logon scripts.
  We however see customers use DCs to service other file content. The SMB file server would then consume RAM to track the active clients, but foremost, the file content would make the OS File Cache grow, and compete over RAM with the ESE database cache.  

- **WMI Queries**. Monitoring solutions often make many WMI queries. The individual query may be cheap to execute, often it is the volume of calls that incurs some overhead. This includes that the solutions extract the new events logged in the various event logs that Windows manages.  

  The event log with the most volume is typically the Security Event log. And this is also the event log that security administrators want to collect especially from DCs.  

  The WMI Service has a dynamic memory allocation scheme that would optimize the queries and there is the chance it is allocating a lot of memory, again competing with the ESE database cache.  
