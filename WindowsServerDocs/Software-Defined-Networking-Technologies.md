---
title: Software Defined Networking Technologies
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: virtual-network
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b491089c-5bcb-49d4-95b1-915b7ce69f88
author: vhorne
---
# Software Defined Networking Technologies
The topics in this section provide overview and technical information about the Software Defined Networking technologies that are included in [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)].  
  
> [!NOTE]  
> For additional Software Defined Networking documentation, you can use the following library sections.  
>   
> -   [Plan Software Defined Networking](Plan-Software-Defined-Networking.md)  
> -   [Deploy Software Defined Networking](Deploy-Software-Defined-Networking.md)  
> -   [Manage Tenant Workloads and Virtual Networks](Manage-Tenant-Workloads-and-Virtual-Networks.md)  
> -   [Troubleshoot Software Defined Networking](Troubleshoot-Software-Defined-Networking.md)  
  
  
There are many technologies that work together to create Microsoft's Software Defined Networking \(SDN\) solutions, including the following:  
  
-   **[Border Gateway Protocol &#40;BGP&#41;](Border-Gateway-Protocol--BGP-.md)**  
  
    When configured on a [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)] Remote Access Service \(RAS\) Gateway, Border Gateway Protocol \(BGP\) provides you with the ability to manage the routing of network traffic between your tenants’ VM networks and their remote sites. BGP reduces the need for manual route configuration on routers because it is a dynamic routing protocol, and automatically learns routes between sites that are connected by using site\-to\-site VPN connections.  
  
-   **[Datacenter Firewall Overview](Datacenter-Firewall-Overview.md)**  
  
    Datacenter Firewall is a new service included with [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. It is a network layer, 5\-tuple \(protocol, source and destination port numbers, source and destination IP addresses\), stateful, multitenant firewall. When deployed and offered as a service by the service provider, tenant administrators can install and configure firewall policies to help protect their virtual networks from unwanted traffic originating from Internet and intranet networks.  
  
  
-   **[Hyper-V Network Virtualization](Hyper-V-Network-Virtualization.md)**  
  
    Hyper\-V Network Virtualization \(HNV\) enables virtualization of customer networks on top of a shared physical network infrastructure.  
  
-   **[Network Controller](Network-Controller.md)**  
  
    The network controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter.  
  
-   **[Network Function Virtualization](Network-Function-Virtualization.md)**  
  
    Network functions that are being performed by hardware appliances \(such as load balancers, firewalls, routers, switches, and so on\) are increasingly being virtualized as virtual appliances.  
  
    Microsoft has virtualized networks, switches, gateways, NATs, load balancers, and firewalls.  
  
  
-   **[RAS Gateway for SDN](RAS-Gateway-for-SDN.md)**  
  
    RAS Gateway  is a software\-based, multitenant, Border Gateway Protocol \(BGP\) capable router in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] that is designed for Cloud Service Providers \(CSPs\) and Enterprises that host multiple tenant virtual networks using Hyper\-V Network Virtualization.  
      
- **[Remote Direct Memory Access &#40;RDMA&#41; and Switch Embedded Teaming &#40;SET&#41;](Remote-Direct-Memory-Access--RDMA--and-Switch-Embedded-Teaming--SET-.md)**  
  
    You can use a converged NIC to combine both RDMA and Ethernet traffic using a single network adapter. The converged NIC allows you to use a single network adapter for management, Remote Direct Memory Access \(RDMA\)\-enabled storage, and tenant traffic. This reduces the capital expenditures that are associated with each server in your datacenter, because you need fewer network adapters to manage different types of traffic per server.  
  
    SET is a NIC Teaming solution that is integrated in the Hyper\-V Virtual Switch. SET allows the teaming of up to eight physical NICS into a single SET team, which improves availability and provides failover. In [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], you can create SET teams that are restricted to the use of Server Message Block \(SMB\) and RDMA.  
  
-   **[Software Load Balancing &#40;SLB&#41; for SDN](Software-Load-Balancing--SLB--for-SDN.md)**  
  
    Cloud Service Providers \(CSPs\) and Enterprises that are deploying Software Defined Networking \(SDN\) in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] can use Software Load Balancing \(SLB\) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability.  
  
  
-   **System Center**   
    System Center Virtual Machine Manager \(VMM\) can be used to deploy and manage many SDN components.  
  

