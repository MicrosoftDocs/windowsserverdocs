---
title: SDN Technologies
description: The topics in this section provide overview and technical information about the Software Defined Networking technologies that are included in Windows Server 2016.
manager: dougkim
ms.prod: windows-server-threshold
ms.service: virtual-network
ms.technology: networking-sdn
ms.topic: article
ms.assetid: b491089c-5bcb-49d4-95b1-915b7ce69f88
ms.author: pashort
author: shortpatti 
ms.date: 02/14/2019
---
# SDN Technologies

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

The topics in this section provide overview and technical information about the Software Defined Networking technologies that are included in Windows Server 2016.  

## [Network Controller](network-controller/Network-Controller.md)

The network controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot both virtual and physical network infrastructure in your datacenter. With the network controller, you can automate the configuration of network infrastructure instead of performing manual configuration of network devices and services. 

The network controller is a highly available and scalable server and provides two application programming interfaces (APIs):

1. **Southbound API** – allows the network controller to communicate with the network.
2. **Northbound API** – allows you to communicate with the network controller.

You can use Windows PowerShell, the Representational State Transfer (REST) API, or a management application to manage the following physical and virtual network infrastructure:

- Hyper-V VMs and virtual switches 
- Physical network switches 
- Physical network routers 
- Firewall software 
- VPN Gateways, including Remote Access Service (RAS) Multitenant Gateways 
- Load Balancers 
  
## [Hyper-V Network Virtualization](hyper-v-network-virtualization/Hyper-V-Network-Virtualization.md)

Hyper-V Network Virtualization (HNV) helps you abstract your applications and workloads from the physical network by using virtual networks. Virtual networks provide the necessary multitenant isolation while running on a shared physical network fabric, thereby driving up resource utilization. To ensure that you can carry forward your existing investments, you can set up virtual networks on existing networking gear. Also, virtual networks are compatible with virtual Local Area Networks (VLANs).
  
## [Hyper-V Virtual Switch](../../../virtualization/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md) 

The Hyper-V Virtual Switch is a software-based layer-2 Ethernet network switch that is available in Hyper-V Manager after you have installed the Hyper-V server role. The switch includes programmatically managed and extensible capabilities to connect virtual machines to both virtual networks and the physical network. Also, Hyper-V Virtual Switch provides policy enforcement for security, isolation, and service levels.
  
You can also deploy the Hyper-V Virtual Switch with Switch Embedded Teaming (SET) and Remote Direct Memory Access (RDMA). For more information, see the section [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](#remote-direct-memory-access-rdma-and-switch-embedded-teaming-set) in this topic.

## [Internal DNS Service (iDNS) for SDN](Idns-for-Sdn.md)

Hosted virtual machines (VMs) and applications require DNS to communicate within their networks and with external resources on the Internet. With iDNS, you can provide tenants with DNS name resolution services for isolated, local namespace and Internet resources. 
  
## [Network Function Virtualization](network-function-virtualization/Network-Function-Virtualization.md)

Hardware appliances, such as load balancers, firewalls, routers, and switches are increasingly becoming virtual appliances. Microsoft has virtualized networks, switches, gateways, NATs, load balancers, and firewalls. This "network function virtualization" is a natural progression of server virtualization and network virtualization. Virtual appliances are quickly emerging and creating a brand new market. They continue to generate interest and gain momentum in both virtualization platforms and cloud services. 
  
The following Network Function Virtualization technologies are available.  
  
-   **Software Load Balancer (SLB) and Network Address Translation (NAT)**. Enhance throughput by supporting Direct Server Return in which the return network traffic can bypass the Load Balancing multiplexer. For more details, see [Software Load Balancing /(SLB/) for SDN](network-function-virtualization/software-load-balancing-for-sdn.md).
  
-   **Datacenter Firewall**. Provide granular access control lists (ACLs), enabling you to apply firewall policies at the VM interface level or the subnet level. For more details, see [Datacenter Firewall Overview](network-function-virtualization/Datacenter-Firewall-Overview.md).
  
-   **RAS Gateway for SDN**. Route network traffic between the physical network and VM network resources, regardless of the location. You can route the network traffic at the same physical location or many different locations. For more details, see [RAS Gateway for SDN](network-function-virtualization/RAS-Gateway-for-SDN.md).

## Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)  
In  Windows Server 2016, you can enable RDMA on network adapters that are bound to a Hyper-V Virtual Switch with or without Switch Embedded Teaming (SET). This allows you to use fewer network adapters when you want to use RDMA and SET at the same time.  
  
SET is an alternative NIC Teaming solution that you can use in environments that include Hyper-V and the Software Defined Networking (SDN) stack in  Windows Server 2016. SET integrates some of the NIC Teaming functionality into the Hyper-V Virtual Switch.  
  
SET allows you to group between one and eight physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.  
SET member network adapters must all be installed in the same physical Hyper-V host to be placed in a team.  
  
In addition,  you can use Windows PowerShell commands to enable Data Center Bridging (DCB), create a Hyper-V Virtual Switch with an RDMA virtual NIC (vNIC), and create a Hyper-V Virtual Switch with SET and RDMA vNICs. For more information, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/rdma-and-switch-embedded-teaming.md).

## [Border Gateway Protocol (BGP)](../../../remote/remote-access/bgp/Border-Gateway-Protocol-BGP.md)
  
Border Gateway Protocol (BGP) is a dynamic routing protocol that automatically learns routes between sites that use site-to-site VPN connections. Therefore, BGP reduces manual configuration of routers.   When you configure RAS Gateway, BGP lets you manage the routing of network traffic between your tenants’ VM networks and remote sites.  
  
## [Software Load Balancing (SLB) for SDN](network-function-virtualization/software-load-balancing-for-sdn.md)
Cloud Service Providers (CSPs) and Enterprises that deploy SDN can use Software Load Balancing (SLB) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability. 

## [Windows Server Containers](Containers/Container-networking-overview.md)

Windows Server Containers are a lightweight operating system virtualization method separating applications or services from other services running on the same container host. Each container has its own operating system, processes, file system, registry, and IP addresses, which you can connect to virtual networks. 

## System Center

Deploy and manage the SDN infrastructure with [Virtual Machine Management (VMM)](https://docs.microsoft.com/system-center/vmm/) and [Operations Manager](https://docs.microsoft.com/system-center/scom/). With VMM, you provision and manage the resources needed to create and deploy virtual machines and services to private clouds.  With Operations Manager, you monitor services, devices, and operations across your enterprise to identify problems for immediate action. 


---