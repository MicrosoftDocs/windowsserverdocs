---
title: Network-Related Performance Counters
description: Learn about the counters that are relevant to managing network performance.
ms.topic: concept-article
ms.author: roharwoo
author: robinharwood
ms.date: 10/27/2021
---

# Network-Related Performance Counters

This topic lists the counters that are relevant to managing network performance, and contains the following sections.

-   [Resource Utilization](#bkmk_ru)

-   [Potential Network Problems](#bkmk_np)

-   [Receive Side Coalescing (RSC) performance](#bkmk_rsc)

##  <a name="bkmk_ru"></a> Resource Utilization

The following performance counters are relevant to network resource utilization.

- :::no-loc text="IPv4, IPv6":::

  -   :::no-loc text="Datagrams Received/sec":::

  -   :::no-loc text="Datagrams Sent/sec":::

- :::no-loc text="TCPv4, TCPv6":::

  -   :::no-loc text="Segments Received/sec":::

  -   :::no-loc text="Segments Sent/sec":::

  -   :::no-loc text="Segments Retransmitted/sec":::

- :::no-loc text="Network Interface(\*), Network Adapter(\*)":::

  - :::no-loc text="Bytes Received/sec":::

  - :::no-loc text="Bytes Sent/sec":::

  - :::no-loc text="Packets Received/sec":::

  - :::no-loc text="Packets Sent/sec":::

  - :::no-loc text="Output Queue Length":::

    This counter is the length of the output packet queue \(in packets\). If this is longer than 2, delays occur. You should find the bottleneck and eliminate it if you can. Because NDIS queues the requests, this length should always be 0.

- :::no-loc text="Processor Information":::

  - % :::no-loc text="Processor Time":::

  - :::no-loc text="Interrupts/sec":::

  - :::no-loc text="DPCs Queued/sec":::

    This counter is an average rate at which DPCs were added to the logical processor's DPC queue. Each logical processor has its own DPC queue. This counter measures the rate at which DPCs are added to the queue, not the number of DPCs in the queue. It displays the difference between the values that were observed in the last two samples, divided by the duration of the sample interval.

##  <a name="bkmk_np"></a> Potential Network Problems

The following performance counters are relevant to potential network problems.

-   :::no-loc text="Network Interface(\*), Network Adapter(\*)":::

    -   :::no-loc text="Packets Received Discarded":::

    -   :::no-loc text="Packets Received Errors":::

    -   :::no-loc text="Packets Outbound Discarded":::

    -   :::no-loc text="Packets Outbound Errors":::

-   :::no-loc text="WFPv4, WFPv6":::

    -   :::no-loc text="Packets Discarded/sec":::

-   :::no-loc text="UDPv4, UDPv6":::

    -   :::no-loc text="Datagrams Received Errors":::

-   :::no-loc text="TCPv4, TCPv6":::

    -   :::no-loc text="Connection Failures":::

    -   :::no-loc text="Connections Reset":::

-   :::no-loc text="Network QoS Policy":::

    -   :::no-loc text="Packets dropped":::

    -   :::no-loc text="Packets dropped/sec":::

-   :::no-loc text="Per Processor Network Interface Card Activity":::

    -   :::no-loc text="Low Resource Receive Indications/sec":::

    -   :::no-loc text="Low Resource Received Packets/sec":::

-   :::no-loc text="Microsoft Winsock BSP":::

    -   :::no-loc text="Dropped Datagrams":::

    -   :::no-loc text="Dropped Datagrams/sec":::

    -   :::no-loc text="Rejected Connections":::

    -   :::no-loc text="Rejected Connections/sec":::

##  <a name="bkmk_rsc"></a> Receive Side Coalescing (RSC) performance

The following performance counters are relevant to RSC performance.

-   :::no-loc text="Network Adapter(\*)":::

    -   :::no-loc text="TCP Active RSC Connections":::

    -   :::no-loc text="TCP RSC Average Packet Size":::

    -   :::no-loc text="TCP RSC Coalesced Packets/sec":::

    -   :::no-loc text="TCP RSC Exceptions/sec":::

For links to all topics in this guide, see [Network Subsystem Performance Tuning](net-sub-performance-top.md).


