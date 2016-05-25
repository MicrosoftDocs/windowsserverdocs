---
title: Network Subsystem Performance Tuning
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a37bba06-8891-48ac-99e0-82b5e8d30071
author: vhorne
---
# Network Subsystem Performance Tuning
Performance tuning the network subsystem, particularly for network intensive workloads, can involve each layer of the network architecture, which is also called the network stack. These layers are broadly divided into the following sections.  
  
1.  **Network interface**. This is the lowest layer in the network stack, and contains the network driver that communicates directly with the network adapter.  
  
2.  **Network Driver Interface Specification \(NDIS\)**. NDIS exposes interfaces for the driver below it and for the layers above it, such as the Protocol Stack.  
  
3.  **Protocol Stack**. The protocol stack implements protocols such as TCP\/IP and UDP\/IP. These layers expose the transport layer interface for layers above them.  
  
4.  **System Drivers**. These are typically clients that use a transport data extension \(TDX\) or Winsock Kernel \(WSK\) interface to expose interfaces to user\-mode applications. The WSK interface was introduced in [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and Windows Vista, and it is exposed by AFD.sys. The interface improves performance by eliminating the switching between user mode and kernel mode.  
  
5.  **User\-Mode Applications**. These are typically Microsoft solutions or custom applications.  
  
The table below provides a vertical illustration of the layers of the network stack, including examples of items that run in each layer.  
  
||||||  
|-|-|-|-|-|  
|5|**User\-Mode Applications**|WMS|DNS|IIS|  
|4|**System Drivers**|AFD.sys|HTTP.sys||  
|3|**Protocol Stack**|TCP\/IP|UDP\/IP|VPN|  
|2|**NDIS**|Network Driver Interface Specification \(NDIS\)|||  
|1|**Network interface**|Network driver|||  
  
The following sections of this guide provide performance tuning recommendations for network devices and the network stack.  
  
-   [Choosing a Network Adapter](../Topic/Choosing-a-Network-Adapter.md)  
  
-   [Performance Tuning Network Adapters](../Topic/Performance-Tuning-Network-Adapters.md)  
  
-   [Network-Related Performance Counters](../Topic/Network-Related-Performance-Counters.md)  
  
-   [Performance Tools for Network Workloads](../Topic/Performance-Tools-for-Network-Workloads.md)  
  
