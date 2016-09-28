---
title: Welcome to Networking in Windows Server 2016
description: Provides an overview of Networking
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 09/20/2016  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e63110ed-41ce-458d-97a1-cd84cdad7749
author: lizap
manager: dongill
---
# Welcome to Networking in Windows Server 2016 

![Networking](6networking.png) Networking is a foundational part of the Software Defined Datacenter (SDDC) platform, and Windows Server 2016 Technical Preview provides new and improved Software Defined Networking (SDN) technologies to help you move to a fully realized SDDC solution for your organization.

When you manage networks as a software defined resource, you can describe an application’s infrastructure requirements one time, and then choose where the application runs - on premises or in the cloud. This consistency means that your applications are now easier to scale and you can seamlessly run applications , anywhere, with equal confidence around security, performance, quality of service, and availability.

>[!Note]
> To download Windows Server 2016, see [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server-technical-preview).

Windows Server 2016 adds the following new networking technologies:

- [Software Defined Networking](#Software-Defined-Networking): Network Controller, Hyper-V Virtual Switch, Network Function Virtualization
- [Cloud Scale Fundamentals](#Cloud-Scale-Fundamentals): Converged Network Interface Card (NIC), Packet Direct, Switch Embedded Teaming (SET)

Read on for more information about using networking in Windows Server 2016.

## Software Defined Networking technologies

### [Software Defined Networking &#40;SDN&#41;](networking/sdn/Software-Defined-Networking--SDN-.md)
You can use this topic to learn about the SDN technologies that are provided in Windows Server, System Center, and Microsoft Azure.  
### [Deploy a Software Defined Network infrastructure using scripts](networking/sdn/deploy/Deploy-a-Software-Defined-Network-infrastructure-using-scripts.md)
This guide provides instructions on how to deploy Network Controller with virtual networks and gateways in a test lab environment.  
### [Datacenter Firewall Overview](networking/sdn/technologies/network-function-virtualization/Datacenter-Firewall-Overview.md)
Datacenter Firewall is a network layer, 5-tuple (protocol, source and destination port numbers, source and destination IP addresses), stateful, multitenant firewall.  

### [Network Controller](networking/sdn/technologies/network-controller/Network-Controller.md)
Network Controller provides a centralized, programmable point of automation to manage, configure, monitor, and troubleshoot virtual and physical network infrastructure in your datacenter. 
### [Network Function Virtualization](networking/sdn/technologies/network-function-virtualization/Network-Function-Virtualization.md)
In  software defined datacenters, network functions that are being performed by hardware appliances (such as load balancers, firewalls, routers, switches, and so on) are increasingly being virtualized as virtual appliances. This "network function virtualization" is a natural progression of server virtualization and network virtualization.
### [RAS Gateway for SDN](networking/sdn/technologies/network-function-virtualization/RAS-Gateway-for-SDN.md)
RAS Gateway, which is a software-based, multitenant, Border Gateway Protocol (BGP) capable router in Windows Server 2016 Technical Preview, is designed for Cloud Service Providers (CSPs) and Enterprises that host multiple tenant virtual networks using Hyper-V Network Virtualization.  
### [Software Load Balancing &#40;SLB&#41; for SDN](networking/sdn/technologies/network-function-virtualization/Software-Load-Balancing--SLB--for-SDN.md)
Cloud Service Providers (CSPs) and Enterprises that are deploying Software Defined Networking (SDN) in Windows Server 2016 Technical Preview can use Software Load Balancing (SLB) to evenly distribute tenant and tenant customer network traffic among virtual network resources. The Windows Server SLB enables multiple servers to host the same workload, providing high availability and scalability.  

## <a name="bkmk_networking"></a>Networking Technologies  
The following table provides links to some of the networking technologies in Windows Server 2016 Technical Preview.  

### [What's New in Networking](networking/What-s-New-in-Networking.md)
Discover new networking technologies and new features for existing technologies in Windows Server 2016 Technical Preview

### [BranchCache](networking/branchcache/BranchCache.md)
BranchCache is a wide area network (WAN) bandwidth optimization technology. To optimize WAN bandwidth when users access content on remote servers, BranchCache fetches content from your main office or hosted cloud content servers and caches the content at branch office locations, allowing client computers at branch offices to access the content locally rather than over the WAN.

### [Core Network Guide for Windows Server Technical Preview](networking/core-network-guide/core-network-guide-windows-server.md)
Learn how to deploy a Windows Server network with the Core Network Guide.

### [Domain Name System &#40;DNS&#41;](networking/dns/Domain-Name-System--DNS-.md)
Domain Name System \(DNS\) is one of the industry-standard suite of protocols that comprise TCP/IP, and together the DNS Client and DNS Server provide computer name-to-IP address mapping name resolution services to computers and users.  
### [Dynamic Host Configuration Protocol &#40;DHCP&#41;](networking/technologies/dhcp/Dynamic-Host-Configuration-Protocol--DHCP-.md)
Dynamic Host Configuration Protocol \(DHCP\) is a client/server protocol that automatically provides an Internet Protocol \(IP\) host with its IP address and other related configuration information, such as the subnet mask and default gateway.

### [Hyper-V Network Virtualization](networking/sdn/technologies/hyper-v-network-virtualization/Hyper-V-Network-Virtualization.md)
Hyper-V Network Virtualization \(HNV\) enables virtualization of customer networks on top of a shared physical network infrastructure.  

### [Hyper-V Virtual Switch](networking/technologies/hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md) 
The Hyper-V Virtual Switch is a software-based layer-2 Ethernet network switch that is available in Hyper-V Manager when you install the Hyper-V server role. The switch includes programmatically managed and extensible capabilities to connect virtual machines to both virtual networks and the physical network. In addition, Hyper-V Virtual Switch provides policy enforcement for security, isolation, and service levels.

### [IP Address Management &#40;IPAM&#41;](networking/technologies/ipam/IP-Address-Management--IPAM-.md)
IP Address Management \(IPAM\) is an integrated suite of tools to enable end-to-end planning, deploying, managing and monitoring of your IP address infrastructure, with a rich user experience. IPAM automatically discovers IP address infrastructure servers and Domain Name System (DNS) servers on your network and enables you to manage them from a central interface.

### [Network Load Balancing](networking/technologies/Network-Load-Balancing.md)
Network Load Balancing \(NLB\) distributes traffic across several servers using the TCP/IP networking protocol. For non-SDN deployments, NLB ensures that stateless applications, such as Web servers running Internet Information Services \(IIS\), are scalable by adding more servers as the load increases.

### [NIC Teaming](networking/technologies/nic-teaming/NIC-Teaming.md)
NIC Teaming allows you to group physical Ethernet network adapters into one or more software-based virtual network adapters. These virtual network adapters provide fast performance and fault tolerance in the event of a network adapter failure.
### [Remote Access](https://technet.microsoft.com/library/mt421241.aspx)
The Remote Access server role includes DirectAccess and virtual private network (VPN), local area network (LAN) Routing, and Web Application Proxy. RAS allows you to provide network connectivity to remote employees, site-to-site VPN to connect remote office locations over the Internet, and the RAS Gateway, which has multitenant and Border Gateway Protocol ((BGP) capabilities for Enterprises and Cloud Service Providers (CSPs).

### [Remote Direct Memory Access &#40;RDMA&#41; and Switch Embedded Teaming &#40;SET&#41;](networking/technologies/hyper-v-virtual-switch/RDMA-and-Switch-Embedded-Teaming.md)
This topic provides instructions on how to use Windows PowerShell commands to enable Data Center Bridging (DCB), create a Hyper-V Virtual Switch with an RDMA virtual NIC (vNIC), and create a Hyper-V Virtual Switch with SET and RDMA vNICs.

## Additional Resources  
Networking resources for operating systems earlier than Windows Server 2016 Technical Preview are available at the following locations.  

- Windows Server 2012 and Windows Server 2012 R2 [Networking Overview](https://technet.microsoft.com/library/hh831357(v=ws.11).aspx)  
- Windows Server 2008 and Windows Server 2008 R2 [Networking](https://technet.microsoft.com/library/cc753940(v=ws.10))  
- Windows Server 2003 [Network Services](https://technet.microsoft.com/library/cc787191(v=ws.10))  
