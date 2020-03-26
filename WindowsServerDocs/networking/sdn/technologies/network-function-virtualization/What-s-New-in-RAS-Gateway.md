---
title: What's New in RAS Gateway
description: You can use this topic to learn about new features for RAS Gateway, which is a software-based, multitenant, Border Gateway Protocol (BGP) capable router in  Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 709cb192-313a-47b5-954e-eb5f6fee51a7
ms.author: lizross
author: eross-msft
---
# What's New in RAS Gateway

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about new features for RAS Gateway, which is a software-based, multitenant, Border Gateway Protocol (BGP) capable router in  Windows Server 2016. The RAS Gateway Multitenant BGP router is designed for Cloud Service Providers (CSPs) and Enterprises that host multiple tenant virtual networks using Hyper-V Network Virtualization.  
  
> [!NOTE]  
> In Windows Server 2012 R2, RAS Gateway is named RRAS Gateway; and in System Center Virtual Machine Manager, RAS Gateway is named Windows Server Gateway.  
  
This topic contains the following sections.  
  
-   [Site-to-site Connectivity Options](#bkmk_s2s)  
  
-   [Gateway Pools](#bkmk_pools)  
  
-   [Gateway Pool Scalability](#bkmk_gps)  
  
-   [M+N Gateway Pool Redundancy](#bkmk_m)  
  
-   [Route Reflector](#bkmk_rr)  
  
## <a name="bkmk_s2s"></a>Site-to-site Connectivity Options  
RAS Gateway now supports three types of VPN site-to-site connections:  Internet Key Exchange version 2 (IKEv2) site-to-site virtual private networking (VPN), Layer 3 (L3) VPN, and Generic Routing Encapsulation (GRE) tunnels.  
  
For more information about GRE, see [GRE Tunneling in Windows Server 2016](../../../../remote/remote-access/ras-gateway/gre-tunneling-windows-server.md).  
  
## <a name="bkmk_pools"></a>Gateway Pools  
In  Windows Server 2016, you can create gateway pools of different types. Gateway pools contain many instances of RAS Gateway, and route network traffic between physical and virtual networks. Gateway pools can perform any of the individual gateway functions - Internet Key Exchange version 2 (IKEv2) site-to-site virtual private networking (VPN), Layer 3 (L3) VPN, and Generic Routing Encapsulation (GRE) tunnels - or the pool can perform all of these functions and act as a mixed pool.  
  
You can create gateway pools using any logic that you prefer based on your infrastructure requirements. For example, you can create gateway pools based on any of the following characteristics.  
  
-   Tunnel types (IKEv2 VPN, L3 VPN, GRE VPN)  
  
-   Capacity  
  
-   Redundancy level (reliability based on your billing plan for tenants)  
  
-   Customized separation for customers  
  
For more information, see [RAS Gateway High Availability](RAS-Gateway-High-Availability.md).  
  
## <a name="bkmk_gps"></a>Gateway Pool Scalability  
You can easily scale a gateway pool up or down by adding or removing gateway VMs in the pool. Removal or addition of gateways does not disrupt the services that are provided by a pool. You can also add and remove entire pools of gateways.  
  
For more information, see [RAS Gateway High Availability](RAS-Gateway-High-Availability.md).  
  
## <a name="bkmk_m"></a>M+N Gateway Pool Redundancy  
Every gateway pool is M+N redundant. This means that an 'M' number of active gateway virtual machines (VMs) are backed up by an 'N' number of standby gateway VMs. M+N redundancy provides you with more flexibility in determining  the level of reliability that you require when you deploy RAS Gateway. Rather than using only one standby RAS Gateway per active RAS Gateway VM - which is the only configuration option with  Windows Server 2012 R2  - you can now configure as many  standby VMs as you require. The Network Controller Gateway Service Manager feature efficiently uses the standby RAS Gateway VM capacity to provide reliable failover if an active RAS Gateway VM fails or loses connectivity.  
  
For more information, see [RAS Gateway High Availability](RAS-Gateway-High-Availability.md).  
  
## <a name="bkmk_rr"></a>Route Reflector  
The Border Gateway Protocol (BGP) Route Reflector is now included with RAS Gateway, and provides an alternative to BGP full mesh topology that is required for route synchronization between routers. With full mesh synchronization, all BGP routers must connect with all other routers in the routing topology. When you use Route Reflector, however, the Route Reflector is the only router that connects with all of the other routers, called BGP clients, thereby simplifying route synchronization and reducing network traffic. The Route Reflector learns all routes, calculates best routes, and redistributes the best routes to its BGP clients.  
  
With  Windows Server 2016, you can configure an individual tenant's remote access tunnels to terminate on more than one RAS Gateway VM. This provides increased flexibility for Cloud Service Providers when faced with circumstances where one RAS Gateway VM cannot meet all of the bandwidth requirements of the tenant connections.  
  
This capability, however, introduces the additional complexity of route management and effective synchronization of routes between the tenant remote sites and their virtual resources in the cloud datacenter. Providing tenants with connections to multiple RAS Gateways also introduces additional complexity in configuration at the Enterprise end, where each tenant site will have separate routing neighbors.  
  
A BGP Route Reflector in the control plane addresses these problems and makes the CSP internal fabric deployment transparent to the Enterprise tenants. Following are some key points about the BGP Route Reflector that is included with RAS Gateway and integrated with Network Controller.  
  
-   A Route Reflector in a Software Defined Networking deployment is a logical entity that sits on the control plane between the RAS Gateways and the Network Controller. It does not, however, participate in data plane routing.  
  
-   When you add a new tenant to your datacenter, Network Controller automatically configures the first tenant RAS Gateway as a Route Reflector.  
  
-   Each tenant has a corresponding Route Reflector, and it resides on one of the RAS Gateway VMs that are associated with that tenant.  
  
-   A tenant Route Reflector acts as the Route Reflector for all of the RAS Gateway VMs that are associated with the tenant. Tenant gateways other than the RAS Gateway Route Reflector are the Route Reflector Clients. The Route Reflector performs route synchronization between all Route Reflector Clients so that the actual data path routing can occur.  
  
-   A Route Reflector does not provide route reflector services for the RAS Gateway upon which it is configured.  
  
-   A Route Reflector updates Network Controller with the Enterprise routes that correspond to the tenant's Enterprise sites. This allows Network Controller to configure the required Hyper-V Network Virtualization policies on the tenant virtual network for End-to-End Data Path access.  
  
-   If your Enterprise customers use BGP Routing in the Customer Address space, the RAS Gateway  Route Reflector is the only external BGP (eBGP) neighbor for all of the sites of the corresponding tenant. This is true regardless of the Enterprise tenant's tunnel termination points. In other words, no matter which RAS Gateway VM in the CSP datacenter terminates the site-to-site VPN tunnel for a tenant site, the eBGP Peer for all the tenant sites is the Route Reflector.  
  
For more information, see [RAS Gateway Deployment Architecture](RAS-Gateway-Deployment-Architecture.md) and the Internet Engineering Task Force (IETF) Request for Comments topic [RFC 4456 BGP Route Reflection: An Alternative to Full Mesh Internal BGP (IBGP)](https://tools.ietf.org/html/rfc4456).  
  

