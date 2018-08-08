---
title: Software Defined Networking (SDN)
description: Software Defined Networking (SDN) provides a method to centrally configure and manage physical and virtual network devices such as routers, switches, and gateways in your datacenter. Use this topic to learn about the Software Defined Networking (SDN) technologies that are provided in Windows Server, System Center, and Microsoft Azure.
manager: elizapo
ms.prod: windows-server-threshold
ms.technology: networking-sdn
ms.topic: article
ms.assetid: 9a1ea73c-20cd-42c5-95ad-b003b9cc6d64
ms.author: pashort
author: shortpatti
ms.date: 09/15/2015
---
# Software Defined Networking (SDN)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Software Defined Networking (SDN) provides a method to centrally configure and manage physical and virtual network devices such as routers, switches, and gateways in your datacenter. You can use your existing SDN-compatible devices to achieve deeper integration between the virtual network and the physical network.


Virtual network elements such as Hyper-V Virtual Switch, Hyper-V Network Virtualization, and RAS Gateway are designed to be integral elements of your SDN infrastructure. 

>[!Note]
>Hyper-V hosts and virtual machines (VMs) running SDN infrastructure servers, such as Network Controller and Software Load Balancing nodes, must have Windows Server 2016 Datacenter edition installed. 
>
>Hyper-V hosts containing only tenant workload VMs connected to SDN-controlled networks can use Windows Server 2016 Standard edition.

SDN is possible because network planes are no longer bound to the network devices themselves. However, other entities, such as datacenter management software like System Center 2016 use network planes. SDN allows you to manage your datacenter network dynamically, providing an automated, centralized way to meet the requirements of your applications and workloads. 

Software defined networking gives you the ability to. 
- Abstract your applications and workloads from the underlying physical network, which is accomplished by virtualizing the network. Just as with server virtualization using Hyper-V, the abstractions are consistent and work with your applications and workloads in a non-disruptive manner. For example, software defined networking provides virtual abstractions for your physical network elements, such as IP addresses, switches, and load balancers. 
- Define and control policies that govern both physical and virtual networks, including traffic flow between these two network types centrally. 
- Implement network policies consistently at scale, even as you deploy new workloads or move workloads across virtual or physical networks. 


  
## <a name="bkmk_ws"></a>Windows Server Technologies for Software Defined Networking  
Windows Server includes the following software defined networking technologies.  

### <a name="bkmk_nc"></a>Network Controller

The network controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot both virtual and physical network infrastructure in your datacenter. With the network controller, you can automate the configuration of network infrastructure instead of performing manual configuration of network devices and services. 

The network controller is a highly available and scalable server and provides two application programming interfaces (APIs):

- **Southbound API** – allows the network controller to communicate with the network.
- **Northbound API** – allows you to communicate with the network controller.

You can use wither Windows PowerShell, the Representational State Transfer (REST) API or a management application to manage the following physical and virtual network infrastructure. 

- Hyper-V VMs and virtual switches 
- Physical network switches 
- Physical network routers 
- Firewall software 
- VPN Gateways, including Remote Access Service (RAS) Multitenant Gateways 
- Load Balancers 
  
For more information, see [Network Controller](../sdn/technologies/network-controller/Network-Controller.md).  
  
### <a name="bkmk_hv"></a>Hyper-V Network Virtualization

Hyper-V Network Virtualization helps you abstract your applications and workloads from the physical network by using virtual networks. Virtual networks provide the necessary multitenant isolation while running on a shared physical network fabric, thereby driving up resource utilization. To ensure that you can carry forward your existing investments, you can set up virtual networks on existing networking gear. In addition, virtual networks are compatible with virtual Local Area Networks (VLANs).  
  
For more information, see [Hyper-V Network Virtualization](../sdn/technologies/hyper-v-network-virtualization/Hyper-V-Network-Virtualization.md).  
  
### <a name="bkmk_switch"></a>Hyper-V Virtual Switch

The Hyper-V Virtual Switch is a software-based layer-2 Ethernet network switch that is available in Hyper-V Manager after you have installed the Hyper-V server role. The switch includes programmatically managed and extensible capabilities to connect virtual machines to both virtual networks and the physical network. In addition, Hyper-V Virtual Switch provides policy enforcement for security, isolation, and service levels.  
  
In Hyper-V Virtual Switch in  Windows Server 2016, you can also deploy Switch Embedded Teaming (SET) and Remote Direct Memory Access (RDMA). For more information, see the section [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](#bkmk_rdma) in this topic.  
  
For more information about Hyper-V Virtual Switch, see [Hyper-V Virtual Switch](../../virtualization/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md).

### <a name="bkmk_idns"></a>Internal DNS Service &#40;iDNS&#41;

Hosted virtual machines \(VMs\) and applications require DNS to communicate within their own networks and with external resources on the Internet. With iDNS, you can provide tenants with DNS name resolution services for their isolated, local name space and for Internet resources.

For more information, see [Internal DNS Service &#40;iDNS&#41; for SDN](technologies/Idns-for-Sdn.md).
  
### <a name="bkmk_nfv"></a>Network Function Virtualization

In today's software defined datacenters, network functions that are being performed by hardware appliances (such as load balancers, firewalls, routers, switches, and so on) are increasingly being virtualized as virtual appliances. This "network function virtualization" is a natural progression of server virtualization and network virtualization. Virtual appliances are quickly emerging and creating a brand new market. They continue to generate interest and gain momentum in both virtualization platforms and cloud services.  
  
The following Network Function Virtualization technologies are available.  
  
-   **Software Load Balancer (SLB) and Network Address Translation (NAT)**. The north-south and east-west layer 4 load balancer and NAT enhances throughput by supporting Direct Server Return, with which the return network traffic can bypass the Load Balancing multiplexer. For more information, see [Software Load Balancing (SLB) for SDN](technologies/network-function-virtualization/software-load-balancing-for-sdn.md).  
  
-   **Datacenter Firewall**. This distributed firewall provides granular access control lists (ACLs),  enabling you to apply firewall policies at the VM interface level or at the subnet level.  
  
    For more information, see [Datacenter Firewall Overview](../sdn/technologies/network-function-virtualization/Datacenter-Firewall-Overview.md).  
  
-   **RAS Gateway**. You can use gateways for bridging traffic between virtual networks and non-virtualized networks; specifically, you can deploy site-to-site VPN gateways, forwarding gateways, and Generic Routing Encapsulation (GRE) gateways. In addition, M+N redundancy of gateways is supported. For more information, see [RAS Gateway for SDN](technologies/network-function-virtualization/RAS-Gateway-for-SDN.md).
  
For more information, see [Network Function Virtualization](technologies/network-function-virtualization/Network-Function-Virtualization.md).  
  
### <a name="bkmk_rdma"></a>Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)  
In  Windows Server 2016, you can  enable RDMA on network adapters that are  bound to a Hyper-V Virtual Switch with or without Switch Embedded Teaming (SET). This allows you to use fewer network adapters when you want to use RDMA and SET at the same time.  
  
SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking (SDN) stack in  Windows Server 2016. SET integrates some of the NIC Teaming functionality into the Hyper-V Virtual Switch.  
  
SET allows you to group between one and eight physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.  
SET member network adapters must all be installed in the same physical Hyper-V host to be placed in a team.  
  
In addition,  you can use Windows PowerShell commands to enable Data Center Bridging (DCB), create a Hyper-V Virtual Switch with an RDMA virtual NIC (vNIC), and create a Hyper-V Virtual Switch with SET and RDMA vNICs.  
  
For more information, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://technet.microsoft.com/library/mt403349.aspx).  
  
### <a name="bkmk_rras"></a>RAS Gateway for SDN  
RAS Gateway is a software-based, multitenant, Border Gateway Protocol (BGP) capable router in  Windows Server 2016 that is designed for Cloud Service Providers (CSPs) and Enterprises that host multiple tenant virtual networks using Hyper-V Network Virtualization.  
  
RAS Gateway provides gateway pools, M+N redundancy, multiple types of site-to-site VPN connections, and BGP Route Reflector to provide you with flexible design choices for your gateway infrastructure.  
  
For more information, see [RAS Gateway for SDN](technologies/network-function-virtualization/RAS-Gateway-for-SDN.md)  
  
### <a name="bkmk_slb"></a>Software Load Balancing (SLB)  
Cloud Service Providers (CSPs) and Enterprises that are deploying Software Defined Networking (SDN) in  Windows Server 2016 can use Software Load Balancing (SLB) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability.  
  
For more information, see [Software Load Balancing &#40;SLB&#41; for SDN](../sdn/technologies/network-function-virtualization/software-load-balancing-for-sdn.md).

### Windows Server Containers

Windows Server Containers are a lightweight operating system virtualization method used to separate applications or services from other services that are running on the same container host. To enable this, each container has its own view of the operating system, processes, file system, registry, and IP addresses. With Windows Server 2016, you can now connect Windows Server containers to virtual networks. For more information, see [Windows Server Containers](technologies/containers/Container-networking-overview.md).

### Contact the Datacenter and Cloud Networking product team

If you're interested in discussing SDN technologies with Microsoft or other SDN customers, there are a variety of methods for making contact.

For more information, see [Contact the Datacenter and Cloud Networking Team](contact-sdn-team.md).
