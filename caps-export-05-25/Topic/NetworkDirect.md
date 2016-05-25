---
title: NetworkDirect
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cb40cfce-fc72-4e90-aa93-d0263e8cbd85
author: vhorne
---
# NetworkDirect
  
## <a name="BKMK_NetworkDirect"></a>NetworkDirect  
NetworkDirect is a user\-mode programming interface specification for Remote Direct Memory Access \(RDMA\). RDMA is provided by RDMA\-enabled network adapters. Because NetworkDirect is fabric agnostic, it can be used on Infiniband, iWARP, and RoCE. NetworkDirect allows RDMA\-enabled network interface card manufacturers to expose the RDMA functionality of their network adapters in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
RDMA is a kernel bypass technique which makes it possible to transfer large amounts of data quite rapidly. Because the transfer is performed by the DMA engine on the network adapter, the CPU is not used for the memory movement, which frees the CPU to perform other work.  
  
NetworkDirect is widely used for high\-performance computing \(HPC\) applications in which computational workloads are distributed to large numbers of servers for parallel processing. In addition, various financial markets trading workloads also require extremely low latency and extremely high message rates, which RDMA can provide.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] extends support for NetworkDirect to non\-HPC server versions, adds numerous management features \(performance monitor counters and event tracing\) and a new Kernel Mode interface which is used as the underlying transport mechanism for Server Message Block 2 and RDMA.  
  
For more information, see the following Windows Dev Center topics.  
  
-   [OID\_NDK\_CONNECTIONS \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh451810(v=vs.85).aspx)  
  
-   [OID\_NDK\_LOCAL\_ENDPOINTS \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh451811(v=vs.85).aspx)  
  
-   [NDK\_OBJECT\_TYPE enumeration \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439930(v=vs.85).aspx)  
  
-   [NDK\_FN\_CONNECT routine \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439865(v=vs.85).aspx)  
  
-   [NDIS\_QOS\_CLASSIFICATION\_ELEMENT structure \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh451631(v=vs.85).aspx)  
  
-   [NDISTest 6.5 \-](http://msdn.microsoft.com/library/windows/hardware/hh998187.aspx)  
  
-   [NDK\_FN\_LISTEN routine \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439902(v=vs.85).aspx)  
  
-   [NDK\_FN\_CREATE\_SHARED\_ENDPOINT routine \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439882(v=vs.85).aspx)  
  
-   [NDK\_FN\_CONNECT\_WITH\_SHARED\_ENDPOINT routine \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439868(v=vs.85).aspx)  
  
