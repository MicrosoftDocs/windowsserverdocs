---
title: Low Latency Workloads Management and Operations
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ca081cb-b98d-4119-917e-017d33346a65
author: vhorne
---
# Low Latency Workloads Management and Operations
  
## New Performance Counters  
Following are some of the new performance counters for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
#### UDP Datagram Loss  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes new performance counters that make it easier to measure UDP datagram and multicast receive loss due to insufficient socket buffering. If UDP datagrams or multicast datagrams arrive more rapidly than the receive application can process them, or if the application has not specified sufficient receive socket buffering, these counters record the number of datagrams that are dropped and the number of datagrams that are dropped per second. The counters are part of the Microsoft Winsock BSP counter set in performance monitor.  
  
#### Rejected Connections  
This new performance counter provides the total number of rejected TCP connections, and the rate of rejected TCP connections per second. The counters are part of the Microsoft Winsock BSP counter set in performance monitor.  
  
#### NetworkDirect Activity  
These new performance counters allow you to track NetworkDirect \(RDMA\) activity, including traffic rates, errors, and control plane activity.  
  
#### Per Processor Network interface card Activity  
These new performance monitor counters allow you to monitor how RSS is distributing the workload across multiple cores, automatic rebalancing of workloads, and RSC packets coalescing activity.  
  
#### NUMA systems synchronization  
NUMA systems synchronization performance monitor counters track lock contention and related information, such as the generation of inter\-processor interrupts \(IPIs\), to simplify performance monitoring of NUMA systems.  
  
### Windows PowerShell management of networking features  
Windows PowerShell now supports a wide variety of network configuration tasks and management tasks on both local and remote computers, including:  
  
-   Networking stack configuration  
  
-   Network interface card configuration  
  
-   RSS configuration  
  
-   SR\-IOV configuration  
  
-   Windows Firewall configuration  
  
-   RDMA configuration  
  
-   Network interface card teaming configuration  
  
Because it is now possible to examine and manage these parameters locally and remotely, Windows PowerShell makes it much easier to ensure that large server installations are correctly and consistently configured using scripts and automation.  
  
