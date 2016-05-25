---
title: Registered Input - Output (RIO) API Extensions
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a3d6a8dd-d776-45e0-82d8-9448cebe9c15
author: vhorne
---
# Registered Input - Output (RIO) API Extensions
  
## <a name="BKMK_RIO"></a>Registered Input\/Output \(RIO\) API Extensions  
The RIO API is a new extension to Windows Sockets \(Winsock\) and provides an opportunity for you to reduce network latency, increase message rates and improve the predictability of response times for applications that require very high performance, very high message rates, and predictability. RIO API extensions allow applications that process large numbers of small messages to achieve higher I\/O operations per second \(IOPS\) with reduced jitter and latency. Server loads with high message rates and low latency requirements benefit most from RIO API extensions, including applications for financial services trading and high speed market data reception and dissemination. In addition, RIO API extensions provide high IOPS when you deploy many Hyper\-V virtual machines \(VMs\) on a single physical computer.  
  
RIO enables send and receive operations to be performed with pre\-registered buffers using queues for requests and completions. Send and receive operations are queued to a request queue that is associated with a Winsock socket. Completed I\/O operations are inserted into a completion queue, and many different sockets can be associated with the same completion queue. Completion queues can also be split between send and receive completions.  Completion operations, such as polling, can be performed entirely in user\-mode and without making system calls.  
  
The use of registered buffers streamlines the network related processing, reduces jitter, and additionally makes it possible for application developers to specify the NUMA node affinity of networking buffers used by the protocol stack — further enhancing overall performance, and reducing latency and jitter characteristics.  
  
RIO API extensions support Transmission Control Protocol \(TCP\), User Datagram Protocol \(UDP\), and multicast UDP, as well as both IPv4 and IPv6.  
  
You can use RIO API extensions if you want to achieve any of the following:  
  
-   Scale up your server to minimize CPU utilization per message  
  
-   Reduce the latency contribution and jitter of the networking stack to a minimum  
  
-   Handle very high rates of multicast or UDP traffic  
  
Use of the RIO API extensions have the following additional benefits:  
  
-   RIO works on all editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   RIO is compatible with normal network adapters and does not require special network adapters or RDMA.  
  
-   RIO is fully compatible with existing Windows networking features, including RSS, RSC, network interface card teaming, and static offloads.  
  
-   RIO works with virtualization when you deploy Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   RIO sockets use the standard Windows networking stack and standard TCP\/IP and UDP protocols.  
  
For more information, see [What's New for Windows Sockets \(Windows\)](http://msdn.microsoft.com/library/windows/desktop/ms740642(v=vs.85).aspx) and [RIO\_EXTENSION\_FUNCTION\_TABLE structure](http://msdn.microsoft.com/library/windows/desktop/hh437226(v=VS.85).aspx).  
  
