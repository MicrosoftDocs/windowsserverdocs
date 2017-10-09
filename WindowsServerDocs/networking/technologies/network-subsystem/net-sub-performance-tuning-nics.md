---
title: Performance Tuning Network Adapters
description: This topic is part of the Network Subsystem Performance Tuning guide for Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 0b9b0f80-415c-4f5e-8377-c09b51d9c5dd
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Performance Tuning Network Adapters

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to performance tune network adapters that are installed in computers that are running Windows Server 2016.

Determining the correct tuning settings for your network adapter depend on the following variables:

- The network adapter and its feature set  

- The type of workload performed by the server  

- The server hardware and software resources  

- Your performance goals for the server  

If your network adapter provides tuning options, you can optimize network throughput and resource usage to achieve optimum throughput based on the parameters described above.  

The following sections describe some of your performance tuning options.  

##  <a name="bkmk_offload"></a> Enabling Offload Features

Turning on network adapter offload features is usually beneficial. Sometimes, however, the network adapter is not powerful enough to handle the offload capabilities with high throughput.

>[!IMPORTANT]
>Do not use the offload features **IPsec Task Offload** or **TCP Chimney Offload**. These technologies are deprecated in Windows Server 2016, and might adversely affect server and networking performance. In addition, these technologies might not be supported by Microsoft in the future.

For example, enabling segmentation offload can reduce the maximum sustainable throughput on some network adapters because of limited hardware resources. However, if the reduced throughput is not expected to be a limitation, you should enable offload capabilities, even for this type of network adapter.

>[!NOTE]
> Some network adapters require offload features to be independently enabled for send and receive paths.

##  <a name="bkmk_rss_web"></a> Enabling Receive Side Scaling (RSS) for Web Servers

RSS can improve web scalability and performance when there are fewer network adapters than logical processors on the server. When all the web traffic is going through the RSS-capable network adapters, incoming web requests from different connections can be simultaneously processed across different CPUs.

It is important to note that due to the logic in RSS and Hypertext Transfer Protocol \(HTTP\) for load distribution, performance might be severely degraded if a non-RSS-capable network adapter accepts web traffic on a server that has one or more RSS-capable network adapters. In this circumstance, you should use RSS-capable network adapters or disable RSS on the network adapter properties **Advanced Properties** tab. To determine whether a network adapter is RSS-capable, you can view the RSS information on the network adapter properties **Advanced Properties** tab.

### RSS Profiles and RSS Queues

The default RSS predefined profile is NUMA Static, which changes the default behavior from previous versions of the operating system. To get started with RSS Profiles, you can review the available profiles to understand when they are beneficial and how they apply to your network environment and hardware.

For example, if you open Task Manager and review the logical processors on your server, and they seem to be underutilized for receive traffic, you can try increasing the number of RSS queues from the default of 2 to the maximum that is supported by your network adapter. Your network adapter might have options to change the number of RSS queues as part of the driver.

##  <a name="bkmk_resources"></a> Increasing Network Adapter Resources

For network adapters that allow manual configuration of resources, such as receive and send buffers, you should increase the allocated resources. 

Some network adapters set their receive buffers low to conserve allocated memory from the host. The low value results in dropped packets and decreased performance. Therefore, for receive-intensive scenarios, we recommend that you increase the receive buffer value to the maximum.

>[!NOTE]
>If a network adapter does not expose manual resource configuration, it either dynamically configures the resources, or the resources are set to a fixed value that cannot be changed.

### Enabling Interrupt Moderation

To control interrupt moderation, some network adapters expose different interrupt moderation levels, buffer coalescing parameters (sometimes separately for send and receive buffers), or both.

You should consider interrupt moderation for CPU-bound workloads, and consider the trade-off between the host CPU savings and latency versus the increased host CPU savings because of more interrupts and less latency. If the network adapter does not perform interrupt moderation, but it does expose buffer coalescing, increasing the number of coalesced buffers allows more buffers per send or receive, which improves performance.

##  <a name="bkmk_low"></a> Performance Tuning for Low Latency Packet Processing

Many network adapters provide options to optimize operating system-induced latency. Latency is the elapsed time between the network driver processing an incoming packet and the network driver sending the packet back. This time is usually measured in microseconds. For comparison, the transmission time for packet transmissions over long distances is usually measured in milliseconds \(an order of magnitude larger\). This tuning will not reduce the time a packet spends in transit.

Following are some performance tuning suggestions for microsecond-sensitive networks.

- Set the computer BIOS to **High Performance**, with C-states disabled. However, note that this is system and BIOS dependent, and some systems will provide higher performance if the operating system controls power management. You can check and adjust your power management settings from **Settings** or by using the **powercfg** command. For more information, see [Powercfg Command-Line Options](http://technet.microsoft.com/library/cc748940.aspx)

- Set the operating system power management profile to **High Performance System**. Note that this will not work properly if the system BIOS has been set to disable operating system control of power management.

- Enable Static Offloads, for example, UDP Checksums, TCP Checksums, and Send Large Offload (LSO).

- Enable RSS if the traffic is multi-streamed, such as high-volume multicast receive.

-   Disable the **Interrupt Moderation** setting for network card drivers that require the lowest possible latency. Remember, this can use more CPU time and it represents a tradeoff.

- Handle network adapter interrupts and DPCs on a core processor that shares CPU cache with the core that is being used by the program (user thread) that is handling the packet. CPU affinity tuning can be used to direct a process to certain logical processors in conjunction with RSS configuration to accomplish this. Using the same core for the interrupt, DPC, and user mode thread exhibits worse performance as load increases because the ISR, DPC, and thread contend for the use of the core.

##  <a name="bkmk_smi"></a> System Management Interrupts

Many hardware systems use System Management Interrupts \(SMI\) for a variety of maintenance functions, including reporting of error correction code \(ECC\) memory errors, legacy USB compatibility, fan control, and BIOS controlled power management. 

The SMI is the highest priority interrupt on the system and places the CPU in a management mode, which preempts all other activity while it runs an interrupt service routine, typically contained in BIOS.

Unfortunately, this can result in latency spikes of 100 microseconds or more. 

If you need to achieve the lowest latency, you should request a BIOS version from your hardware provider that reduces SMIs to the lowest degree possible. These are frequently referred to as “low latency BIOS” or “SMI free BIOS.” In some cases, it is not possible for a hardware platform to eliminate SMI activity altogether because it is used to control essential functions (for example, cooling fans).

>[!NOTE]
>The operating system can exert no control over SMIs because the logical processor is running in a special maintenance mode, which prevents operating system intervention.

##  <a name="bkmk_tcp"></a> Performance Tuning TCP

 You can performance tune TCP using the following items.

###  <a name="bkmk_tcp_params"></a>  TCP Receive Window Auto-Tuning

Prior to Windows Server 2008, the network stack used a fixed-size receive-side window (65,535 bytes) that limited the overall potential throughput for connections. One of the most significant changes to the TCP stack is TCP receive window auto-tuning. 

You can calculate the total throughput of a single connection when you use a fixed size TCP receive window as:

**Total achievable throughput in bytes = TCP receive window size in bytes \* (1 / connection latency in seconds)**

For example, the total achievable throughput is only 51 Mbps on a connection with 10 ms latency \(a reasonable value for a large corporate network infrastructure\). 

With auto-tuning, however, the receive-side window is adjustable, and it can grow to meet the demands of the sender. It is possible for a connection to achieve a full line rate of a 1 Gbps connection. Network usage scenarios that might have been limited in the past by the total achievable throughput of TCP connections can now fully use the network.

#### Deprecated TCP parameters

The following registry settings from Windows Server 2003 are no longer supported, and are ignored in later versions.

All of these settings had the following registry location:

    ```  
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters  
    ```  

- TcpWindowSize

- NumTcbTablePartitions  

- MaxHashTableSize  



###  <a name="bkmk_wfp"></a> Windows Filtering Platform

The Windows Filtering Platform (WFP) that was introduced in Windows Vista and Windows Server 2008 provides APIs to non-Microsoft independent software vendors (ISVs) to create packet processing filters. Examples include firewall and antivirus software.

>[!NOTE]
>A poorly written WFP filter can significantly decrease a server’s networking performance. For more information, see [Porting Packet-Processing Drivers and Apps to WFP](http://msdn.microsoft.com/windows/hardware/gg463267.aspx) in the Windows Dev Center.


For links to all topics in this guide, see [Network Subsystem Performance Tuning](net-sub-performance-top.md).
