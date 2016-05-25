---
title: Low Latency Workloads Technologies
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 19513410-ad9b-43a4-a1cc-58e5c38210d9
author: vhorne
---
# Low Latency Workloads Technologies
This section provides overviews for the following group of technologies that are designed for or which were improved in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] to address low latency computing scenarios.  
  
1.  [Data Center Bridging](../Topic/Data-Center-Bridging.md)  
  
2.  [Data Center Transmission Control Protocol &#40;DCTCP&#41;](../Topic/Data-Center-Transmission-Control-Protocol--DCTCP-.md)  
  
3.  [Kernel Mode Remote Direct Memory Access &#40;kRDMA&#41;](../Topic/Kernel-Mode-Remote-Direct-Memory-Access--kRDMA-.md)  
  
4.  [Network Interface Card &#40;NIC&#41; Teaming](../Topic/Network-Interface-Card--NIC--Teaming.md)  
  
5.  [NetworkDirect](../Topic/NetworkDirect.md)  
  
6.  [Receive Segment Coalescing &#40;RSC&#41;](../Topic/Receive-Segment-Coalescing--RSC-.md)  
  
7.  [Receive Side Scaling &#40;RSS&#41;](../Topic/Receive-Side-Scaling--RSS-.md)  
  
8.  [Registered Input - Output &#40;RIO&#41; API Extensions](../Topic/Registered-Input---Output--RIO--API-Extensions.md)  
  
9. [Transmission Control Protocol &#40;TCP&#41; Loopback Optimization](../Topic/Transmission-Control-Protocol--TCP--Loopback-Optimization.md)  
  
10. [Low Latency Workloads Management and Operations](../Topic/Low-Latency-Workloads-Management-and-Operations.md)  
  
Latency means delay, and it refers to the length of time that elapses between two specific events, such as the amount of time between the transmission and the reception of a network message between two computers over a network path. Latency has a variety of possible causes, including electrical propagation delays, processing delays, and queuing effects.  
  
A variety of processing workloads require that the time spent on inter\-machine communications is reduced to the lowest amount possible. These workloads include distributed computing algorithms whose convergence time is bound by the network latency. Examples of such systems include distributed consensus and agreement protocols, Message Passing Interface \(MPI\) workloads, and distributed caching. Stock trading and other financial markets workloads also require that the latency incurred by network communications is reduced to the greatest degree possible.  
  
Low latency computing environments typically contain applications that require very fast inter\-process communication \(IPC\) and inter\-computer communications, a high degree of predictability regarding latency and transaction response times, and the ability to handle very high message rates. The following section contains information about technologies that you can use to improve performance in low latency computing scenarios.  
  
