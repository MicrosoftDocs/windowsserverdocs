---
title: Receive Segment Coalescing (RSC)
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3db31df5-1627-4dd1-bc77-cfe97c6a7499
author: vhorne
---
# Receive Segment Coalescing (RSC)
  
## <a name="BKMK_RSC"></a>Receive Segment Coalescing \(RSC\)  
RSC is a stateless offload technology that helps reduce CPU utilization for network processing on the receive side by offloading tasks from the CPU to an RSC\-capable network adapter. CPU saturation due to networking\-related processing can limit server scalability. This problem in turn reduces the transaction rate, raw throughput, and efficiency. RSC enables an RSC\-capable network interface card to do the following:  
  
-   Parse multiple TCP\/IP packets and strip the headers from the packets while preserving the payload of each packet.  
  
-   Join the combined payloads of the multiple packets into one packet.  
  
-   Send the single packet, which contains the payload of multiple packets, to the network stack for subsequent delivery to applications.  
  
The network interface card performs these tasks based on rules that are defined by the network stack subject to the hardware capabilities of the specific network adapter. This ability to receive multiple TCP segments as one large segment significantly reduces the per\-packet processing overhead of the network stack. Because of this, RSC significantly improves the receive\-side performance of the operating system \(by reducing the CPU overhead\) under network I\/O intensive workloads.  
  
> [!NOTE]  
> Examples of other stateless offloads are Internet Protocol \(IP\) and Transmission Control Protocol \(TCP\) checksum, and Large Send Offload, which is also called Segmentation Offload.  
  
When your server has an RSC\-capable network interface card installed, RSC provides benefits under many circumstances, including the following:  
  
-   Hosted cloud deployments. RSC minimizes the CPU cycles that are spent for network storage and live migration.  
  
-   I\/O intensive database applications and database replication.  
  
-   File servers that are deployed with the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] File Services server role. In addition, if your file server is also configured as a BranchCache\-enabled content server, BranchCache performance is improved by RSC.  
  
-   I\/O intensive server workloads.  
  
> [!IMPORTANT]  
> Because RSC is designed to improve performance and reduce latency for receive\-intensive workloads, it does not significantly improve performance for send\-intensive workloads, such as Web servers that send HTML files to Web browsers running on client computers and other devices. For receive\-intensive workloads, RSC allows virtual and physical servers to effectively service a larger number of clients and connections.  
  
Here are some key facts about RSC:  
  
-   RSC is enabled by default for clean installations of all editions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] on computers that have RSC\-capable network adapters. You do not need to take any action to enable RSC when you have an RSC\-capable network interface card installed in your physical computer or used by a virtual machine that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. In addition, you can track RSC status and usage by using relevant Performance Monitor counters.  
  
    > [!IMPORTANT]  
    > When you perform an operating system upgrade from a previous version of Windows to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], RSC functionality is disabled by default. This ensures that server functionality remains consistent despite the upgrade of the operating system.  
  
-   You can enable or disable RSC globally or on a per\-interface basis.  
  
-   RSC does not cause any difference in performance between IPv4 and IPv6 networks.  
  
-   RSC works seamlessly with third\-party drivers that support Network Driver Interface Specification \(NDIS\) 6.30 and above \(NDIS Lightweight Filters, NDIS Intermediates and Windows Filtering Platform \[WFP\] callout drivers\).  
  
-   RSC is automatically disabled for older incompatible drivers.  
  
-   RSC works well in virtualized environments. The availability of RSC is limited to the parent partition for storage and live migration, and to virtual machines \(VMs\) running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] with SR\-IOV capable network adapters. RSC functionality is not available for VMs that are not running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and VMs that do not run SR\-IOV.  
  
-   RSC is defined only for TCP connections. RSC does not work with User Datagram Protocol \(UDP\) and other transport layer protocols.  
  
-   RSC is a stateless offload technology and does not hold the state of TCP connections. It is not a replacement for TCP Chimney, because RSC\-capable network adapters are not expected to handle the TCP state computer.  
  
-   RSC does not function with IPsec encrypted traffic, because network adapters currently cannot coalesce IPsec packets.  
  
-   RSC provides performance counters that capture the following for each interface: the number of TCP connections on which RSC is active; the number of packets that are coalesced per Deferred Procedure Call \(DPC\); the number of RSC aborts that are issued by the network adapter; the maximum number of packets coalesced in one DPC.  
  
For more information, see the following Windows Dev Center topics.  
  
-   [NDIS\_RSC\_NBL\_INFO union \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh451655(v=VS.85).aspx)  
  
-   [NDIS\_TCP\_RECV\_SEG\_COALESCE\_OFFLOAD structure \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439827(v=VS.85).aspx)  
  
-   [OID\_TCP\_RSC\_STATISTICS \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh451929(v=VS.85).aspx)  
  
-   [NDIS\_OFFLOAD structure \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/ff566599(v=vs.85).aspx)  
  
-   [NDIS\_OFFLOAD\_PARAMETERS structure \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/ff566706(v=vs.85).aspx)  
  
-   [Standardized INF Keywords for RSC \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/jj215793(v=vs.85).aspx)  
  
-   [FWPS\_CALLOUT2 structure \(Windows Drivers\)](http://msdn.microsoft.com/library/windows/hardware/hh439700(v=VS.85).aspx)  
  
