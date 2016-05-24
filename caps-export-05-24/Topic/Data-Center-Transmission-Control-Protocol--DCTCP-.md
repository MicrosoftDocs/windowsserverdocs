---
title: Data Center Transmission Control Protocol (DCTCP)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5a450956-2d02-4d81-ba62-db70a85a61f7
---
# Data Center Transmission Control Protocol (DCTCP)
  
## <a name="BKMK_DCTCP"></a>Data Center Transmission Control Protocol \(DCTCP\)  
Data centers host diverse applications, mixing on the same network a variety of workflows that require small, predictable latency, while other applications require large, sustained throughput. In this environment, today’s state\-of\-the\-art Transmission Control Protocol \(TCP\) congestion control mechanisms do not provide sufficiently detailed congestion control settings. This results in queue formations in network switches leading to delays, fluctuations in latency, and timeouts.  
  
To reduce this problem, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces DCTCP, which uses Explicit Congestion Notification \(ECN\) to estimate the extent of the congestion at the source, and reduce the sending rate only to the extent of the congestion. This provides a more detailed control over network traffic, allowing DCTCP to operate with very low buffer occupancies while still achieving high throughput.  
  
The following illustration demonstrates the effectiveness of DCTCP in achieving full throughput while taking up a very small footprint in an Ethernet switch packet buffer, as compared to traditional TCP. The graph depicts the queue length in the network switch when using DCTCP and TCP. Two separate 1 gigabits per second \(Gbps\) TCP\/IP streams are directed into two separate switch ports, and are combined into a single outgoing 1 Gbps port.  
  
![](../Image/dctcp.jpg)  
  
With traditional TCP, long\-lived, large volume TCP flows cause the length of the bottleneck queue to grow until packets are dropped, resulting in the sawtooth pattern of the TCP traffic. When long and short flows traverse the same queue, two impairments occur. First, packet loss on the short flows may occur as described above. Second, there is a queue buildup even when no packets are lost. The short flows experience increased latency as they are queued behind packets from the large flows.  
  
DCTCP, however, provides earlier, more detailed responses to congestion, which effectively fine\-tune the sending rates at each source to operate with much smaller message queue build\-up in the switch, while maintaining the same aggregate throughput. The much lower queue lengths exhibited with DCTCP avoid the latency and variation in latency that occur with TCP.  
  
When used with commodity, shallow\-buffered switches, DCTCP delivers the same or better throughput than TCP, while using 90% less buffer space in the network infrastructure. Unlike TCP, it also provides high burst tolerance and low latency for short flows. While the limitations of TCP cause the mistransmission of traffic sent today, DCTCP enables the applications to handle ten times the current background traffic without impacting foreground traffic. In addition, a tenfold increase in foreground traffic does not cause any timeouts, thus largely eliminating problems that can occur when computers retransmit messages as a result of previous timeouts.  
  
