---
title: RAS Gateway Deployment Architecture
description: You can use this topic to learn about Cloud Service Provider (CSP) deployment of RAS Gateway in Windows Server 2016, including RAS Gateway pools, Route Reflectors, and deploying multiple  gateways for individual tenants.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: d46e4e91-ece0-41da-a812-af8ab153edc4
ms.author: lizross
author: eross-msft
---
# RAS Gateway Deployment Architecture

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about Cloud Service Provider (CSP) deployment of RAS Gateway, including RAS Gateway pools, Route Reflectors, and deploying multiple  gateways for individual tenants.  
  
The following sections provide brief overviews of some of the RAS Gateway new features so that you can understand how to use these features in the design of your gateway deployment.  
  
In addition, an example deployment is provided, including information about the process of adding new tenants, route synchronization and data plane routing, gateway and Route Reflector failover, and more.  
  
This topic contains the following sections.  
  
-   [Using RAS Gateway New Features to Design Your Deployment](#bkmk_new)  
  
-   [Example Deployment](#bkmk_example)  
  
-   [Adding New Tenants and Customer Address (CA) Space EBGP Peering](#bkmk_tenant)  
  
-   [Route Synchronization and Data Plane Routing](#bkmk_route)  
  
-   [How Network Controller Responds to RAS Gateway and Route Reflector Failover](#bkmk_failover)  
  
-   [Advantages of Using New RAS Gateway Features](#bkmk_advantages)  
  
## <a name="bkmk_new"></a>Using RAS Gateway New Features to Design Your  Deployment  
RAS Gateway includes multiple new features that change and improve the way in which you deploy your gateway infrastructure in your datacenter.  
  
### BGP Route Reflector  
The Border Gateway Protocol (BGP) Route Reflector capability  is now included with RAS Gateway, and provides an alternative to BGP full mesh topology that is normally required for route synchronization between routers. With full mesh synchronization, all BGP routers must connect with all other routers in the routing topology. When you use Route Reflector, however, the Route Reflector is the only router that connects with all of the other routers, called BGP Route Reflector clients, thereby simplifying route synchronization and reducing network traffic. The Route Reflector learns all routes, calculates best routes, and redistributes the best routes to its BGP clients.  
  
For more information, see [What's New in RAS Gateway](../../../sdn/technologies/network-function-virtualization/What-s-New-in-RAS-Gateway.md).  
  
### <a name="bkmk_pools"></a>Gateway Pools  
In  Windows Server 2016, you can create many gateway pools of different types. Gateway pools contain many instances of RAS Gateway, and route network traffic between physical and virtual networks.  
  
For more information, see [What's New in RAS Gateway](../../../sdn/technologies/network-function-virtualization/What-s-New-in-RAS-Gateway.md) and [RAS Gateway High Availability](../../../sdn/technologies/network-function-virtualization/RAS-Gateway-High-Availability.md).  
  
### <a name="bkmk_gps"></a>Gateway Pool Scalability  
You can easily scale a gateway pool up or down by adding or removing gateway VMs in the pool. Removal or addition of gateways does not disrupt the services that are provided by a pool. You can also add and remove entire pools of gateways.  
  
For more information, see [What's New in RAS Gateway](../../../sdn/technologies/network-function-virtualization/What-s-New-in-RAS-Gateway.md) and [RAS Gateway High Availability](../../../sdn/technologies/network-function-virtualization/RAS-Gateway-High-Availability.md).  
  
### <a name="bkmk_m"></a>M+N Gateway Pool Redundancy  
Every gateway pool is M+N redundant. This means that an 'M' number of active gateway VMs are backed up by an 'N' number of standby gateway VMs. M+N redundancy provides you with more flexibility in determining  the level of reliability that you require when you deploy RAS Gateway.  
  
For more information, see [What's New in RAS Gateway](../../../sdn/technologies/network-function-virtualization/What-s-New-in-RAS-Gateway.md) and [RAS Gateway High Availability](../../../sdn/technologies/network-function-virtualization/RAS-Gateway-High-Availability.md).  
  
## <a name="bkmk_example"></a>Example Deployment  
The following illustration provides an example with eBGP peering over site-to-site VPN connections configured between two tenants, Contoso and Woodgrove, and the Fabrikam CSP datacenter.  
  
![eBGP peering over site-to-site VPN](../../../media/RAS-Gateway-Deployment-Architecture/ras_gateway_architecture.png)  
  
In this example, Contoso requires additional gateway bandwidth, leading to the gateway infrastructure design decision to terminate the Contoso Los Angeles site on GW3 instead of GW2. Because of this, Contoso VPN connections from different sites terminate in the CSP datacenter on two different gateways.  
  
Both of these gateways, GW2 and GW3, were the first RAS Gateways configured by Network Controller when the CSP added the Contoso and Woodgrove tenants to their infrastructure. Because of this, these two gateways are configured as Route Reflectors for these corresponding customers (or tenants). GW2 is the Contoso Route Reflector, and GW3 is the Woodgrove Route Reflector - in addition to being the CSP RAS Gateway termination point for the VPN connection with the Contoso Los Angeles HQ site.  
  
> [!NOTE]  
> One RAS Gateway can route virtual and physical network traffic for up to one hundred different tenants, depending on the bandwidth requirements of each tenant.  
  
As Route Reflectors, GW2 sends Contoso CA Space routes to Network Controller, and GW3 sends Woodgrove CA Space routes to Network Controller.  
  
Network Controller pushes Hyper-V Network Virtualization policies to the Contoso and Woodgrove virtual networks, as well as RAS policies to the RAS Gateways and load balancing policies to the Multiplexers (MUXes) that are configured as a Software Load Balancing pool.  
  
## <a name="bkmk_tenant"></a>Adding New Tenants and Customer Address (CA) Space eBGP Peering  
When you sign a new customer and add the customer as a new tenant in your datacenter, you can use the following process, much of which is automatically performed by Network Controller and RAS Gateway eBGP routers.  
  
1.  Provision a new virtual network and workloads according to your tenant's requirements.  
  
2.  If required, configure remote connectivity between the remote tenant Enterprise site and their virtual network at your datacenter. When you deploy a site-to-site VPN connection for the tenant, Network Controller automatically selects an available RAS Gateway VM from the available gateway pool and configures the connection.  
  
3.  While configuring the RAS Gateway VM for the new tenant, Network Controller also configures the RAS Gateway as a  BGP Router and designates it as the Route Reflector for the tenant. This is true even in circumstances where the RAS Gateway serves as a gateway, or as a gateway and Route Reflector, for other tenants.  
  
4.  Depending on whether CA space routing is configured to use statically configured networks or dynamic BGP routing, Network Controller configures the corresponding static routes, BGP neighbors, or both on the RAS Gateway VM and Route Reflector.  
  
    > [!NOTE]  
    > -   After Network Controller has configured a RAS Gateway and Route Reflector for the tenant, whenever the same tenant requires a new site-to-site VPN connection, Network Controller checks for the available capacity on this RAS Gateway VM. If the original gateway can service the required capacity, the new network connection is also configured on the same RAS Gateway VM. If the RAS Gateway VM cannot handle additional capacity, Network Controller selects a new available RAS Gateway VM and configures the new connection on it. This new RAS Gateway VM associated with the tenant becomes the Route Reflector client of the original tenant RAS Gateway Route Reflector.  
    > -   Because RAS Gateway pools are behind Software Load Balancers (SLBs), the tenants' site-to-site VPN addresses each use a single public IP address, called a virtual IP address (VIP), which is translated by the SLBs into a datacenter-internal IP address, called a dynamic IP address (DIP), for a RAS Gateway that routes traffic for the Enterprise tenant. This public-to-private IP address mapping by SLB ensures that the site-to-site VPN tunnels are correctly established between the Enterprise sites and the CSP RAS Gateways and Route Reflectors.  
    >   
    >     For more information about SLB, VIPs, and DIPs, see [Software Load Balancing &#40;SLB&#41; for SDN](../../../sdn/technologies/network-function-virtualization/Software-Load-Balancing--SLB--for-SDN.md).  
  
5.  After the site-to-site VPN tunnel between the Enterprise site and the CSP datacenter RAS Gateway is established for the new tenant, the static routes that are associated with the tunnels are automatically provisioned on both the Enterprise and CSP sides of the tunnel.  
  
6.  With CA space BGP routing, the eBGP peering between the Enterprise sites and the CSP RAS Gateway Route Reflector is also  established.  
  
## <a name="bkmk_route"></a>Route Synchronization and Data Plane Routing  
After eBGP peering is established between Enterprise sites and the CSP RAS Gateway Route Reflector, the Route Reflector learns all of the Enterprise routes by using dynamic BGP routing. The  Route Reflector synchronizes these routes between all of the Route Reflector clients so that they are all configured with the same set of routes.  
  
Route Reflector also updates these consolidated routes, using route synchronization,  to Network Controller. Network Controller then translates the routes into the Hyper-V Network Virtualization policies and configures the Fabric Network to ensure that End-to-End Data Path routing is provisioned. This process makes the tenant virtual network accessible from the tenant Enterprise sites.  
  
For Data Plane routing, the packets that reach the RAS Gateway VMs are directly routed to the tenant's virtual network, because the required routes are now available with all of the participating RAS Gateway VMs.  
  
Similarly, with the Hyper-V Network Virtualization policies in place, the tenant virtual network routes packets directly to the RAS Gateway VMs (without requiring to know about the Route Reflector) and then to the Enterprise sites over the site-to-site VPN tunnels.  
  
In addition. return traffic from the tenant virtual network to the remote tenant Enterprise site bypasses the SLBs, a process called Direct Server Return (DSR).  
  
## <a name="bkmk_failover"></a>How Network Controller Responds to RAS Gateway and Route Reflector Failover  
Following are two possible failover scenarios - one for RAS Gateway Route Reflector clients and one for RAS Gateway Route Reflectors - including information about how Network Controller handles failover for VMs in either configuration.  
  
### VM Failure of a RAS Gateway BGP Route Reflector Client  
Network Controller takes the following actions when a RAS Gateway Route Reflector client fails.  
  
> [!NOTE]  
> When a RAS Gateway is not a Route Reflector for a tenant's BGP infrastructure, it is a Route Reflector client in the tenant's BGP infrastructure.  
  
-   Network Controller selects an available standby RAS  Gateway VM and provisions the new RAS Gateway VM with the configuration of the failed RAS Gateway VM.  
  
-   Network Controller updates the corresponding SLB configuration to ensure that  the site-to-site VPN tunnels from tenant sites to the failed RAS Gateway are correctly established with the new RAS Gateway.  
  
-   Network Controller configures the BGP Route Reflector client on the new gateway.  
  
-   Network Controller configures the new RAS Gateway BGP Route Reflector client as active. The RAS Gateway immediately starts peering with the tenant's Route Reflector to share routing information and to enable eBGP peering for the corresponding Enterprise site.  
  
### VM Failure for a RAS Gateway BGP Route Reflector  
Network Controller takes the following actions when a RAS Gateway BGP Route Reflector fails.  
  
-   Network Controller selects an available standby RAS  Gateway VM and provisions the new RAS Gateway VM with the configuration of the failed RAS Gateway VM.  
  
-   Network Controller configures the Route Reflector on the new RAS Gateway VM, and assigns the new VM the same IP address that was used by the failed VM, thereby providing route integrity despite the VM failure.  
  
-   Network Controller updates the corresponding SLB configuration to ensure that  the site-to-site VPN tunnels from tenant sites to the failed RAS Gateway are correctly established with the new RAS Gateway.  
  
-   Network Controller configures the new RAS Gateway BGP Route Reflector VM as active.  
  
-   The Route Reflector immediately becomes active. The site-to-site VPN tunnel to the Enterprise is established,  and the Route Reflector uses eBGP peering and exchanges routes with the Enterprise site routers.  
  
-   After BGP route selection, the RAS Gateway BGP Route Reflector updates tenant Route Reflector clients in the datacenter, and synchronizes routes with Network Controller, making the End-to-End Data Path available for tenant traffic.  
  
## <a name="bkmk_advantages"></a>Advantages of Using New RAS Gateway Features  
Following are a few of the advantages of using these new RAS Gateway features when designing your RAS Gateway deployment.  
  
**RAS Gateway scalability**  
  
Because you can add as many RAS Gateway VMs as you need to RAS Gateway pools, you can easily scale your RAS Gateway deployment to optimize performance and capacity. When you add VMs to a pool, you can configure these RAS Gateways with site-to-site VPN connections of any kind (IKEv2, L3, GRE), eliminating capacity bottlenecks with no down time.  
  
**Simplified Enterprise Site Gateway Management**  
  
When your tenant has multiple Enterprise sites, the tenant can configure all sites with one remote site-to-site VPN IP address and a single remote neighbor IP address - your CSP datacenter RAS Gateway BGP Route Reflector VIP for that tenant. This simplifies gateway management for your tenants.  
  
**Fast Remediation of Gateway Failure**  
  
To ensure a fast failover response, you can configure the BGP Keepalive parameter time between edge routes and the control router to a short time interval, such as less than or equal to ten seconds. With this short keep alive interval, if a RAS Gateway BGP edge router fails, the failure is quickly detected and Network Controller follows the steps provided in previous sections. This advantage might reduce the need for a separate failure detection protocol, such as Bidirectional Forwarding Detection (BFD) protocol.  
  
 
  


