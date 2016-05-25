---
title: Data Center Bridging (DCB) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d635ab26-89c6-41a5-ac1e-9deb6a06d56b
author: vhorne
---
# Data Center Bridging (DCB) Overview
This document provides introductory information about Data Center Bridging \(DCB\). Links to resources with information about technologies that are closely related to DCB, or otherwise relevant to DCB are also provided.  
  
**Did you mean…**  
  
-   Hyper\-V Virtual Fiber Channel, see [Hyper-V Virtual Fibre Channel Overview](../Topic/Hyper-V-Virtual-Fibre-Channel-Overview.md)  
  
-   Hyper\-V Virtual Switch, see [Hyper\-V Virtual Switch Overview \[tp\]](assetId:///39da28f3-0dff-49da-aae2-a383cc6d33e0)  
  
-   iSCSI High\-Availability Block Storage, see [iSCSI High\-Availability Block Storage Technical Preview](assetId:///014de3c8-4ba5-4cae-90b2-eadc9a224257)  
  
-   Latency mitigation, see [Low Latency Workloads Technologies](../Topic/Low-Latency-Workloads-Technologies.md)  
  
-   Network Bridge, see [How the Windows XP Network Bridge Works](http://technet.microsoft.com/library/bb877962.aspx)  
  
## <a name="BKMK_OVER"></a>Feature description  
Data Center Bridging DCB is a suite of Institute of Electrical and Electronics Engineers \(IEEE\) standards that enable Converged Fabrics in the data center, where storage, data networking, cluster IPC and management traffic all share the same Ethernet network infrastructure. DCB provides hardware\-based bandwidth allocation to a specific type of traffic and enhances Ethernet transport reliability with the use of priority\-based flow control. Hardware\-based bandwidth allocation is essential if traffic bypasses the operating system and is offloaded to a converged network adapter, which might support Internet Small Computer System Interface \(iSCSI\), Remote Direct Memory Access \(RDMA\) over Converged Ethernet, or Fiber Channel over Ethernet \(FCoE\). Priority\-based flow control is essential if the upper layer protocol, such as Fiber Channel, assumes a lossless underlying transport.  
  
## <a name="BKMK_APP"></a>Practical applications  
Many enterprises have large Fiber Channel \(FC\) storage area network \(SAN\) installations for storage service. FC SAN requires special network adapters on servers and FC switches in the network. In general, FC hardware is significantly more expensive to deploy than the Ethernet hardware, which results in large capital expenditures. Additionally, having separate adapter and switch hardware to support Ethernet network traffic and FC SAN services requires additional space, power and cooling capacity in a datacenter, which results in additional, ongoing operational expenditures. From a cost perspective, it is advantageous for many enterprises to merge their FC technology with their Ethernet\-based hardware solution to provide both storage and data networking services.  
  
For the enterprises that already have a large FC SAN but want to migrate away from additional investment in the FC technology, DCB will enable them to build an Ethernet based converged fabric for both storage and data networking. A DCB converged fabric can reduce the future total cost of ownership \(TCO\) and simplify the management.  
  
For hosters who have already adopted, or who plan to adopt iSCSI as their storage solution, DCB can provide hardware\-assisted bandwidth reservation for iSCSI traffic to ensure performance isolation. And unlike other proprietary solutions, DCB is standard\-based and therefore relatively easy to deploy and manage in a heterogeneous network.  
  
A [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]\-based implementation of DCB alleviates many of the issues that can occur when converged fabric solutions are provided by multiple original equipment manufacturers \(OEMs\). Implementations of proprietary solutions provided by multiple OEM’s might not interoperate with one another, might be difficult to manage, and will typically have different software maintenance schedules. By contrast, [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] DCB is standard\-based and therefore relatively easy to deploy and manage in a heterogeneous network.  
  
## <a name="BKMK_NEW"></a>Important functionality  
Following is a list that summarizes the functionality that is provided by DCB.  
  
1.  Provides interoperability between DCB\-capable network adapters and DCB\-capable switches.  
  
2.  Provides a lossless Ethernet transport between a computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and its neighbor switch by turning on priority\-based flow control on the network adapter.  
  
3.  Provides the ability to allocate bandwidth to a Traffic Control \(TC\) by percentage, where the TC might consist of one or more classes of traffic that are differentiated by 802.1p.  
  
4.  Enables server administrators or network administrators to assign an application to a particular traffic class or priority based on well\-known protocols, well\-known TCP\/UDP port, or NetworkDirect port used by that application.  
  
5.  Provides DCB management through [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Windows Management Instrumentation \(WMI\) and PowerShell.  
  
6.  Provides DCB management through [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Group Policy.  
  
7.  Supports the co\-existence of [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Quality of Service \(QoS\) solutions.  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Following is a list of hardware requirements for DCB:  
  
1.  Requires that DCB\-capable Ethernet network adapter\(s\) are installed in computers that are providing [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] DCB.  
  
2.  Requires that DCB\-capable hardware switches are deployed on your network.  
  
## <a name="BKMK_LINKS"></a>See also  
Following is a table of resources for technologies related to DCB.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[DCB Windows PowerShell User Scripting Guide](../Topic/DCB-Windows-PowerShell-User-Scripting-Guide.md)|  
|**Planning**|Content not available|  
|**Deployment**|Content not available|  
|**Operations**|Content not available|  
|**Troubleshooting**|Content not available|  
|**Security**|Content not available|  
|**Tools and settings**|Content not available|  
|**Community resources**|Content not available|  
|**Related technologies**|Content not available|  
  
