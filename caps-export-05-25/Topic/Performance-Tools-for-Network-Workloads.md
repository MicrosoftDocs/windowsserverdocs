---
title: Performance Tools for Network Workloads
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0598c62d-e105-4b05-b644-fda9c4c7f401
author: vhorne
---
# Performance Tools for Network Workloads
This topic contains the following sections about performance tools for networking.  
  
-   [Tuning for NTttcp](#bkmk_tuning)  
  
-   [TCP\/IP Window Size](#bkmk_size)  
  
-   [Microsoft Server Performance Advisor 3.0](#bkmk_advisor)  
  
## <a name="bkmk_tuning"></a>Tuning for NTttcp  
NTttcp is a Winsock\-based port of ttcp to Windows. It helps measure network driver performance and throughput on different network topologies and hardware setups. It provides the customer with a multithreaded, asynchronous performance workload for measuring an achievable data transfer rate on an existing network setup.  
  
When setting up NTttcp, consider the following:  
  
-   A single thread should be sufficient for optimal throughput.  
  
-   Multiple threads are required only for single\-to\-many clients.  
  
-   Posting enough user receive buffers \(by increasing the value passed to the \-a option\) reduces TCP copying.  
  
-   You should not excessively post user receive buffers because the first buffers that are posted would return before you need to use other buffers.  
  
-   It is best to bind each set of threads to a logical processor \(the second delimited parameter in the **\-m** option\).  
  
-   Each thread creates a logical processor that connects to \(listens\) a different port.  
  
The following table provides example syntax for NTttcp Sender and Receiver.  
  
|Syntax|Details|  
|----------|-----------|  
|Example Syntax for a Sender: NTttcps –m 1,0,10.1.2.3 –a 2|Single thread; Bound to CPU 0; Connects to a computer that uses IP 10.1.2.3; Posts two send\-overlapped buffers; Default buffer size: 64 K; Default number of buffers to send: 20 K.|  
|Example Syntax for a Receiver: NTttcpr –m 1,0,10.1.2.3 –a 6 –fr|Single thread; Bound to CPU 0; Binds on local computer to IP 10.1.2.3; Posts six receive\-overlapped buffers; Default buffer size: 64 KB; Default number of buffers to receive: 20 K; Posts full\-length \(64 K\) receive buffers.|  
  
> [!NOTE]  
> Ensure that you enable all offloading features on the network adapter.  
  
For more information, see [How to Use NTttcp to Test Network Performance](http://msdn.microsoft.com/windows/hardware/gg463264.aspx) in the Windows Dev Center.  
  
## <a name="bkmk_size"></a>TCP\/IP Window Size  
For 1 GB adapters, the settings shown in the previous table should provide good throughput because NTttcp sets the default TCP window size to 64 K through a specific logical processor option \(SO\_RCVBUF\) for the connection. This provides good performance on a low\-latency network.  
  
In contrast, for high\-latency networks or for 10 GB adapters, the default TCP window size value for NTttcp yields less than optimal performance. In both cases, you must adjust the TCP window size to allow for the larger bandwidth delay product.  
  
You can statically set the TCP window size to a large value by using the **\-rb** option. This option disables TCP Window Auto\-Tuning, and we recommend using it only if the user fully understands the resultant change in TCP\/IP behavior. By default, the TCP window size is set at a sufficient value and adjusts only under heavy load or over high\-latency links.  
  
## <a name="bkmk_advisor"></a>Microsoft Server Performance Advisor 3.0  
Microsoft Server Performance Advisor \(SPA\) 3.0 helps IT administrators collect metrics to identify, compare, and diagnose potential performance issues in a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] deployment. SPA generates comprehensive diagnostic reports and charts, and it provides recommendations to help you quickly analyze issues and develop corrective actions.  
  
For more information, see [Microsoft Server Performance Advisor 3.0](http://msdn.microsoft.com/windows/hardware/hh367834.aspx) in the Windows Dev Center.  
  
