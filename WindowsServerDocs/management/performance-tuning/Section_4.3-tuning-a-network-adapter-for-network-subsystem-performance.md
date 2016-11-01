---
title: Tuning a Network Adapter for Network Subsystem Performance
description: Tuning a Network Adapter for Network Subsystem Performance
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: performance-tuning-guide
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a93a4b28-0c77-4131-b4c7-ce2a773e66b2
author: phstee
ms.author: donst;dahavey
ms.date: 10/31/2016
---

# Tuning a Network Adapter for Network Subsystem Performance


You can optimize network throughput and resource usage by tuning the network adapter, if any tuning options are exposed by the adapter.

**Note**  
The correct tuning settings depend on the network adapter, the workload, the host computer resources, and your performance goals.

 

**In this topic:**

-   [Enabling offload features](#offload)

-   [Enabling interrupt moderation](#irq)

-   [Workload specific tuning](#workload)

-   [System management interrupts](#smi)

-   [Tuning TCP](#tcp)

-   [Network-related performance counters](#counters)

## <a href="" id="offload"></a>Enabling offload features


Turning on network adapter offload features is usually beneficial. Sometimes, however, the network adapter is not powerful enough to handle the offload capabilities with high throughput. For example, enabling segmentation offload can reduce the maximum sustainable throughput on some network adapters because of limited hardware resources. However, if the reduced throughput is not expected to be a limitation, you should enable offload capabilities, even for such network adapters.

**Note**  
Some network adapters require offload features to be independently enabled for send and receive paths.

 

### Enabling RSS for web scenarios

RSS can improve web scalability and performance when there are fewer network adapters than logical processors on the server. When all the web traffic is going through the RSS-capable network adapters, incoming web requests from different connections can be simultaneously processed across different CPUs.

**Important**  
Due to the logic in RSS and HTTP for load distribution, performance can be severely degraded if a non-RSS-capable network adapter accepts web traffic on a server that has one or more RSS-capable network adapters.

 

We recommend that you use RSS-capable network adapters or disable RSS by using the **Advanced Properties** tab of the network adapter. You can also see if a network adapter is RSS-capable by using the **Advanced Properties** tab.

### RSS profiles and RSS queues

RSS Profiles was introduced in Windows Server 2012. The default profile is **NUMA Static**, which changes the default behavior from previous versions of Windows. We suggest reviewing the available profiles and understanding when they are beneficial. If your logical processors are underutilized for receive traffic, for example, as viewed in Task Manager, you can try increasing the number of RSS queues from the default of 2 to the maximum that is supported by your network adapter. Your network adapter may have options to change the number of RSS queues as part of the driver.

### RSS and VMQ

Most network adapters have queues that can be used for either RSS or VMQ, but not both at the same time. Therefore, some VMQ settings appear to be settings for RSS queues but are really settings on the generic queues that both RSS and VMQ use depending on which feature is presently in use. When a network adapter is connected to vSwitch, RSS is automatically disabled.

## <a href="" id="irq"></a>Enabling interrupt moderation


To control interrupt moderation, some network adapters expose different interrupt moderation levels, buffer coalescing parameters (sometimes separately for send and receive buffers), or both. You should consider interrupt moderation for CPU-bound workloads, and consider the trade-off between the host CPU savings and latency versus the increased host CPU savings because of more interrupts and less latency. If the network adapter does not perform interrupt moderation, but it does expose buffer coalescing, increasing the number of coalesced buffers allows more buffers per send or receive, which improves performance.

## <a href="" id="workload"></a>Workload specific tuning


### Tuning for low latency packet processing within the operating system

The network adapter has a number of options to optimize operating system-induced latency. This is the elapsed time between the network driver processing an incoming packet and the network driver sending the packet back. This time is usually measured in microseconds. For comparison, the transmission time for packet transmissions over long distances is usually measured in milliseconds (an order of magnitude larger). This tuning will not reduce the time a packet spends in transit.

Some tuning suggestions for microsecond-sensitive networks include:

-   Set the computer BIOS to **High Performance**, with C-states disabled. You can check and adjust your power management settings by using the Control Panel or by using the powercfg command.

    **Note**  
    This is system and BIOS dependent, and some systems will provide higher performance if the operating system controls power management.

     

-   Set the operating system power management profile to **High Performance System**.

    **Note**  
    This will not work properly if the system BIOS has been set to disable operating system control of power management.

     

-   Enable Static Offloads, such as UDP Checksums, TCP Checksums, and Send Large Offload (LSO).

-   Enable RSS if the traffic is multi-streamed, such as high-volume multicast receive.

-   Disable the **Interrupt Moderation** setting for network card drivers that require the lowest possible latency. Remember, this can use more CPU time and it represents a tradeoff.

-   Handle network adapter interrupts and DPCs on a core processor that shares CPU cache with the core that is being used by the program (user thread) that is handling the packet. CPU affinity tuning can be used to direct a process to certain logical processors in conjunction with RSS configuration to accomplish this. Using the same core for the interrupt, DPC, and user mode thread exhibits worse performance as load increases because the ISR, DPC, and thread contend for the use of the core.

## <a href="" id="smi"></a>System management interrupts


Many hardware systems use System Management Interrupts (SMI) for a variety of maintenance functions, including reporting of error correction code (ECC) memory errors, legacy USB compatibility, fan control, and BIOS-controlled power management. The SMI is the highest priority interrupt on the system and places the CPU in a management mode, which preempts all other activity while it runs an interrupt service routine, typically contained in BIOS.

Unfortunately, this can result in latency spikes of 100 microseconds or more. If you need to achieve the lowest latency, you should request a BIOS version from your hardware provider that reduces SMIs to the lowest degree possible. These are frequently referred to as low latency BIOS or SMI free BIOS. In some cases, it is not possible for a hardware platform to eliminate SMI activity altogether because it is used to control essential functions (for example, cooling fans).

**Note**  
The operating system can exert no control over SMIs because the logical processor is running in a special maintenance mode, which prevents operating system intervention.

 

## <a href="" id="tcp"></a>Tuning TCP


### TCP receive window auto-tuning

Prior to Windows Server 2008, the network stack used a fixed-size receive-side window that limited the overall potential throughput for connections. One of the most significant changes to the TCP stack is TCP receive window auto-tuning. You can calculate the total throughput of a single connection when you use this fixed size default as:

Total achievable throughput in bytes = TCP window \* (1 / connection latency)

For example, the total achievable throughput is only 51 Mbps on a 1 GB connection with 10 ms latency (a reasonable value for a large corporate network infrastructure). With auto-tuning, however, the receive-side window is adjustable, and it can grow to meet the demands of the sender. It is entirely possible for a connection to achieve a full line rate of a 1 GB connection. Network usage scenarios that might have been limited in the past by the total achievable throughput of TCP connections can now fully use the network.

### Deprecated TCP parameters

The following registry settings, under HKLM\\System\\CurrentControlSet\\Services\\Tcpip\\Parameters, from Windows Server 2003 are no longer supported, and are ignored in later versions:

-   TcpWindowSize

-   NumTcbTablePartitions

-   MaxHashTableSize

## <a href="" id="counters"></a>Network-related performance counters


This section lists the counters that are relevant to managing network performance.

Resource utilization

-   IPv4, IPv6

    -   Datagrams received/sec

    -   Datagrams sent/sec

-   TCPv4, TCPv6

    -   Segments received/sec

    -   Segments sent/sec

    -   Segments retransmitted/sec

-   Network Interface(\*), Network Adapter(\*)

    -   Bytes received/sec

    -   Bytes sent/sec

    -   Packets received/sec

    -   Packets sent/sec

-   Processor Information

    -   % processor time

    -   Interrupts/sec

    -   DPCs queued/sec

        This counter is an average rate at which DPCs were added to the logical processor's DPC queue. Each logical processor has its own DPC queue. This counter measures the rate at which DPCs are added to the queue, not the number of DPCs in the queue. It displays the difference between the values that were observed in the last two samples, divided by the duration of the sample interval.

Potential network problems

-   Network Interface(\*), Network Adapter(\*)

    -   Packets received discarded

    -   Packets received errors

    -   Packets outbound discarded

    -   Packets outbound errors

-   WFPv4, WFPv6

    -   Packets discarded/sec

-   UDPv4, UDPv6

    -   Datagrams received errors

-   TCPv4, TCPv6

    -   Connection failures

    -   Connections reset

-   Network QoS Policy

    -   Packets dropped

    -   Packets dropped/sec

-   Per Processor Network Interface Card Activity

    -   Low resource receive indications/sec

    -   Low resource received packets/sec

-   Microsoft Winsock BSP

    -   Dropped datagrams

    -   Dropped datagrams/sec

    -   Rejected connections

    -   Rejected connections/sec

Receive Side Coalescing (RSC) performance

-   Network Adapter(\*)

    -   TCP active RSC connections

    -   TCP RSC average packet size

    -   TCP RSC coalesced packets/sec

    -   TCP RSC exceptions/sec
