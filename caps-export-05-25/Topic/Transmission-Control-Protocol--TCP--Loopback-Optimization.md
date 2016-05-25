---
title: Transmission Control Protocol (TCP) Loopback Optimization
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 464e64f4-00c0-409d-99e2-b122ee489b45
author: vhorne
---
# Transmission Control Protocol (TCP) Loopback Optimization
  
## <a name="BKMK_TCP"></a>Transmission Control Protocol \(TCP\) loopback optimization  
Many applications use the TCP\/IP loopback path to provide interprocess communications. While convenient from a development and deployment perspective, the TCP\/IP loopback path can become a bottleneck for applications that require very high performance or very low latency.  
  
To address the needs of these kinds of applications, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a TCP Loopback performance enhancement that provides an optimized fast path. The optimized fast path increases the achievable TCP send and receive rates, and reduces latency and jitter for low latency scenarios.  
  
Optimization of TCP loopback provides the following benefits:  
  
-   TCP loopback optimization provides an optimized low\-latency loopback path for performance\-critical applications that rely on loopback for inter\-process communication.  
  
-   TCP loopback optimization does not cause any disparity in performance between IPv4 and IPv6 networks.  
  
-   The optimized loopback path works in virtualized environments. Loopback is defined as an inter\-process communication mechanism for both processes on the same computer. Because of this, VM\-to\-VM optimization — when both VMs are installed in the same physical host — is not provided. The boundary for optimization between VMs in this case is the individual VM boundary.  
  
-   With TCP loopback optimization, you are provided the choice to use either registered \(Winsock RIO\) sockets or Winsock to make use of the optimized fast path. You can observe when the connections take the slow path rather than the optimized fast path.  
  
-   The optimized loopback path is available for developers to programmatically control on a per\-connection basis.  
  
In addition, TCP loopback fast path is an optimization for newly written applications, and does not provide performance improvements for existing applications.  
  
TCP loopback optimization is available on all versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. This feature is turned on whenever the Socket option for fast path is set for a connection, and utilizes the optimized fast path whenever the application has opted\-in and the Windows Filtering Platform \(WFP\) filter driver is not present for that connection.  
  
The TCP loopback fast path is enabled by the socket IOCTL SIO\_LOOPBACK\_FASTPATH applied to the sending and receiving sockets.  
  
