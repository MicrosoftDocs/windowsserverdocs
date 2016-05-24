---
title: Receive Side Scaling (RSS)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dbd0e079-2219-4241-83bf-1db4985661c6
---
# Receive Side Scaling (RSS)
  
## <a name="BKMK_RSS"></a>Receive Side Scaling \(RSS\)  
  
> [!NOTE]  
> For information about virtual Receive\-side Scaling \(vRSS\), see [Virtual Receive-side Scaling in Windows Server 2012 R2](../Topic/Virtual-Receive-side-Scaling-in-Windows-Server-2012-R2.md).  
  
RSS enables network adapters to distribute the kernel\-mode network processing load across multiple processor cores in multi\-core computers. The distribution of this processing makes it possible to support higher network traffic loads than would be possible if only a single core were to be used. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], RSS has been enhanced, including computers with more than sixty\-four processors. RSS achieves this by spreading the network processing load across many processors and actively load balancing TCP terminated traffic.  
  
In addition, RSS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides automatic load balancing capabilities for non\-TCP traffic \(including UDP unicast, multicast, and IP\-forwarded traffic\), improved RSS diagnostics and management capabilities, improved scalability across Non\-Uniform Memory Access \(NUMA\) nodes, and improved resource utilization and resource partitioning through facilitation of kernel\-scheduler and networking stack alignment.  
  
RSS diagnostics and management capabilities include:  
  
-   Event tracing. RSS logs events for the following cases:  
  
    -   RSS configuration information \(base RSS CPU, number of queues, and indirection table\)  
  
    -   Indirection table change notification  
  
    -   Change in processor set  
  
-   NICStats functionality through Windows Management Instrumentation \(WMI\) and Windows PowerShell.  
  
-   Improved per\-interface default settings.  
  
-   RSS profiles. RSS now supports the following predefined profiles:  
  
    1.  **Default:** With this profile selected, new RSS features are disabled and it performs very similarly to the way that RSS performs in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
    2.  **No dynamic load balancing:** With this profile selected, RSS distributes but does not load balance at runtime.  
  
    3.  **NUMA scalability:** With this profile selected, RSS CPUs are assigned per NUMA node on a round robin basis. This is done to enable applications running on multi\-NUMA servers to scale well. For this profile, RSS assigns at least one RSS CPU per NUMA node before assigning the second RSS CPU for each NUMA node. While in NUMA scalability mode, RSS uses the limits that are set for scaling across multiple NUMA nodes.  
  
    4.  **NUMA scalability with no dynamic load balancing:** With this profile selected, the profile NUMA Scalability is used, however RSS does not perform load balancing.  
  
    5.  **Conservative Scaling:** With this profile selected, RSS uses as few processors as possible to sustain the load. This option assists in reducing the number of interrupts.  
  
RSS provides the following additional benefits for low latency scenarios:  
  
-   **Parallel Receive Processing:** Receive packets from a single network interface card can be indicated via generating interrupts and DPCs concurrently on multiple CPUs.  
  
-   **Preserving in\-order packet delivery:** Received packets for a specific stream from a single network interface card are delivered in order to the TCP\/IP protocol driver.  
  
-   **Dynamic Load Balancing:** As the load on the host varies, RSS rebalances the network processing load between the processors.  
  
-   **Cache Locality:** Because packets from a single connection are mapped to a specific processor state for a particular connection stays resident in the cache of the processor, thereby eliminating cache thrashing and improving performance.  
  
-   **Send Side Scaling:** The RSS hash value is passed by the TCP\/IP protocol to the network interface card in each packet on the egress path thus allowing for the send completions to be indicated on the same CPU. This enables better scaling on the send side.  
  
-   **Toeplitz Hash:** The default generated RSS signature is statistically secure, making it more difficult for malicious remote hosts to force the system into an unbalanced state.  
  
Following are some application\-specific advantages of RSS:  
  
-   RSS enables [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to scale optimally on large servers that have more than 64 processors.  
  
-   RSS allows multi\-NUMA node servers, such as web servers, file servers, and servers running other workloads, to scale efficiently.  
  
-   For DirectAccess, RSS allows improved scalability by actively load balancing forwarded traffic.  
  
-   RSS enables financial applications, such as ticker plants and algorithmic trading systems using UDP as their transport, to scale with increasing load.  
  
-   RSS provides applications with an input\/output control to align themselves with the stack.  
  
-   RSS is compatible with the Windows load balancing and failover solution.  
  
-   RSS provides administrators with the ability to deploy, manage, and diagnose RSS functioning through standard management interfaces and diagnostics tools.  
  
-   RSS optimally scales all workloads by aligning the networking stack with the kernel scheduler. RSS uses the processor list provided by the kernel scheduler while making processor selection decisions.  
  
For more information, see [Introduction to Receive Side Scaling \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/ff556942(v=vs.85).aspx).  
  
