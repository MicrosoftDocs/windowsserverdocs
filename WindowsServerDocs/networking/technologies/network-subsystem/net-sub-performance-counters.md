---
title: Network-Related Performance Counters
description: This topic is part of the Network Subsystem Performance Tuning guide for Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 7ebaa271-2557-4c24-a679-c3d863e6bf9e
manager: brianlic
ms.author: lizross
author: eross-msft
---

# Network-Related Performance Counters

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic lists the counters that are relevant to managing network performance, and contains the following sections.  
  
-   [Resource Utilization](#bkmk_ru)  
  
-   [Potential Network Problems](#bkmk_np)  
  
-   [Receive Side Coalescing (RSC) performance](#bkmk_rsc)  
  
##  <a name="bkmk_ru"></a> Resource Utilization  

The following performance counters are relevant to network resource utilization.  
  
- IPv4, IPv6  
  
  -   Datagrams Received/sec  
  
  -   Datagrams Sent/sec  
  
- TCPv4, TCPv6  
  
  -   Segments Received/sec  
  
  -   Segments Sent/sec  
  
  -   Segments Retransmitted/sec  
  
- Network Interface(*), Network Adapter(\*)  
  
  - Bytes Received/sec  
  
  - Bytes Sent/sec  
  
  - Packets Received/sec  
  
  - Packets Sent/sec  
  
  - Output Queue Length  
  
    This counter is the length of the output packet queue \(in packets\). If this is longer than 2, delays occur. You should find the bottleneck and eliminate it if you can. Because NDIS queues the requests, this length should always be 0.  
  
- Processor Information  
  
  - % Processor Time  
  
  - Interrupts/sec  
  
  - DPCs Queued/sec  
  
    This counter is an average rate at which DPCs were added to the logical processor's DPC queue. Each logical processor has its own DPC queue. This counter measures the rate at which DPCs are added to the queue, not the number of DPCs in the queue. It displays the difference between the values that were observed in the last two samples, divided by the duration of the sample interval.  
  
##  <a name="bkmk_np"></a> Potential Network Problems  

The following performance counters are relevant to potential network problems.  
  
-   Network Interface(*), Network Adapter(\*)  
  
    -   Packets Received Discarded  
  
    -   Packets Received Errors  
  
    -   Packets Outbound Discarded  
  
    -   Packets Outbound Errors  
  
-   WFPv4, WFPv6  
  
    -   Packets Discarded/sec

-   UDPv4, UDPv6

    -   Datagrams Received Errors  
  
-   TCPv4, TCPv6  
  
    -   Connection Failures  
  
    -   Connections Reset  
  
-   Network QoS Policy  
  
    -   Packets dropped  
  
    -   Packets dropped/sec  
  
-   Per Processor Network Interface Card Activity  
  
    -   Low Resource Receive Indications/sec  
  
    -   Low Resource Received Packets/sec  
  
-   Microsoft Winsock BSP  
  
    -   Dropped Datagrams  
  
    -   Dropped Datagrams/sec  
  
    -   Rejected Connections  
  
    -   Rejected Connections/sec  
  
##  <a name="bkmk_rsc"></a> Receive Side Coalescing (RSC) performance  

The following performance counters are relevant to RSC performance.  
  
-   Network Adapter(*)  
  
    -   TCP Active RSC Connections  
  
    -   TCP RSC Average Packet Size  
  
    -   TCP RSC Coalesced Packets/sec  
  
    -   TCP RSC Exceptions/sec

For links to all topics in this guide, see [Network Subsystem Performance Tuning](net-sub-performance-top.md).