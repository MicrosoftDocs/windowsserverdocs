---
title: GRE Tunneling in Windows Server Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df2023bf-ba64-481e-b222-6f709edaa5c1
author: vhorne
---
# GRE Tunneling in Windows Server Technical Preview
Windows Server 2016 Technical Preview provides updates to Generic Routing Encapsulation \(GRE\) tunnel capability for the RAS Gateway.  
  
GRE is a lightweight tunneling protocol that can encapsulate a wide variety of network layer protocols inside virtual point\-to\-point links over an Internet Protocol internetwork. The Microsoft GRE implementation can encapsulate IPv4 and IPv6.  
  
GRE tunnels are useful in many scenarios because:  
  
-   They are lightweight and RFC 2890 compliant, making it interoperable with various vendor devices  
  
-   Border Gateway Protocol \(BGP\) can be integrated for dynamic routing  
  
-   Multi\-tenancy is supported  
  
-   They can be managed with Virtual Machine Manager  
  
-   You can achieve up to 2.0 Gbps throughput on a 6 core virtual machine  
  
-   A single gateway supports multiple connection modes  
  
GRE based tunnels enable connectivity between tenant virtual networks and external networks. Since the GRE protocol is lightweight and support for GRE is available on most of network devices it becomes an ideal choice for tunneling where encryption of data is not required. GRE support in Site to Site \(S2S\) tunnels solves the problem of forwarding between tenant virtual networks and tenant external networks using a multi\-tenant gateway, as described later in this topic.  
  
The GRE tunnel feature is designed to address the following requirements:  
  
-   A hosting provider must be able to create virtual networks for forwarding without modifying the physical switch configuration.  
  
-   A hosting provider must be able to add subnets to their externally facing networks without modifying the configuration of the physical switches within their infrastructure.  
  
The GRE tunnel feature enables or enhances several key scenarios for hosting service providers using Microsoft technologies to implement Software Defined Networking in their service offerings.  
  
The following are some example scenarios:  
  
-   [Access from tenant virtual networks to tenant physical networks](../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/GRE-Tunneling-in-Windows-Server-Technical-Preview.md#BKMK_Access)  
  
-   [High speed connectivity](../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/GRE-Tunneling-in-Windows-Server-Technical-Preview.md#BKMK_Speed)  
  
-   [Integration with VLAN based isolation](../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/GRE-Tunneling-in-Windows-Server-Technical-Preview.md#BKMK_Integration)  
  
-   [Access shared resources](../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/GRE-Tunneling-in-Windows-Server-Technical-Preview.md#BKMK_Shared)  
  
-   [Services of third party devices to tenants](../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/../../remote-access/ras-gateway/GRE-Tunneling-in-Windows-Server-Technical-Preview.md#BKMK_thirdparty)  
  
## Key scenarios  
The following are key scenarios that the GRE tunnel feature addresses.  
  
### <a name="BKMK_Access"></a>Access from tenant virtual networks to tenant physical networks  
This scenario enables a scalable way to provide access from tenant virtual networks to tenant physical networks located on the hosting service provider premises. A GRE tunnel endpoint is established on the multitenant gateway, the other GRE tunnel endpoint is established on a third\-party device on the physical network. Layer\-3 traffic is routed between the virtual machines in the virtual network and the third\-party device on the physical network.  
  
![](../../media/GRE-Tunneling-in-Windows-Server-Technical-Preview/GRE_.png)  
  
### <a name="BKMK_Speed"></a>High speed connectivity  
This scenario enables a scalable way to provide high speed connectivity from the tenant on premise network to their virtual network located in the hosting service provider network. A tenant connects to the service provider network via multiprotocol label switching \(MPLS\), where a GRE tunnel is established between the hosting service provider’s edge router and the multitenant gateway to the tenant’s virtual network.  
  
![](../../media/GRE-Tunneling-in-Windows-Server-Technical-Preview/GRE-.png)  
  
### <a name="BKMK_Integration"></a>Integration with VLAN based isolation  
This scenario allows you to integrate VLAN based isolation with Hyper\-V Network Virtualization. A physical network on the hosting provider network contains a load balancer using VLAN\-based isolation. A multitenant gateway establishes GRE tunnels between the load balancer on the physical network and the multitenant gateway on the virtual network.  
  
Multiple tunnels can be established between the source and destination, and the GRE key is used to discriminate between the tunnels.  
  
![](../../media/GRE-Tunneling-in-Windows-Server-Technical-Preview/GRE-VLANIsolation.png)  
  
### <a name="BKMK_Shared"></a>Access shared resources  
This scenario allows you to access shared resources on a physical network located on the hosting provider network.  
  
You may have a shared service located on a server on a physical network located in the hosting provider network that you want to share with multiple tenant virtual networks.  
  
The tenant networks with non\-overlapping subnets access the common network over a GRE tunnel. A single tenant gateway routes between the GRE tunnels, thus routing packets to the appropriate tenant networks.  
  
In this scenario, the single tenant gateway can be replaced by third\-party hardware appliances.  
  
![](../../media/GRE-Tunneling-in-Windows-Server-Technical-Preview/GRE-SharedResource.png)  
  
### <a name="BKMK_thirdparty"></a>Services of third party devices to tenants  
This scenario can be used to integrate third party devices \(such as hardware load balancers\) into the tenant virtual network traffic flow. For example, traffic originating from an enterprise site passes through a S2S tunnel to the multitenant gateway. The traffic is routed to the load balancer over a GRE tunnel. The load balancer routes traffic to multiple virtual machines on the enterprise’s virtual network. The same thing happens for another tenant with potentially overlapping IP addresses in the virtual networks. The network traffic is isolated on the load balancer using VLANs, and is applicable to all layer 3 devices that support VLANs.  
  
![](../../media/GRE-Tunneling-in-Windows-Server-Technical-Preview/GREThirdParty.png)  
  
## Configuration and deployment  
A GRE tunnel is exposed as an additional protocol within a S2S interface. It is implemented in a similar fashion as an IPSec S2S tunnel described in the following Networking Blog: [Multi-tenant Site-to-Site (S2S) VPN Gateway with Windows Server 2012 R2](http://blogs.technet.com/b/networking/archive/2013/09/29/multi-tenant-site-to-site-s2s-vpn-gateway-with-windows-server-2012-r2.aspx)  
  
See the following topic for an example that deploys gateways, including GRE tunnel gateways:  
  
[Deploy Software Defined Networks using scripts](Deploy-Software-Defined-Networks-using-scripts.md)  
  
## More information  
For more information about deploying S2S gateways, see the following topics:  
  
-   [RAS Gateway](../../remote-access/ras-gateway/RAS-Gateway.md)  
  
-   [Border Gateway Protocol &#40;BGP&#41;](../../remote-access/bgp/Border-Gateway-Protocol--BGP-.md)  
  
-   [New! Windows Server 2012 R2 RAS Multitenant Gateway Deployment Guide](http://blogs.technet.com/b/wsnetdoc/archive/2014/03/26/new-windows-server-2012-r2-RAS-multitenant-gateway-deployment-guide.aspx)  
  
-   [Deploy Border Gateway Protocol (BGP) with the RAS Multitenant Gateway](http://blogs.technet.com/b/wsnetdoc/archive/2014/04/03/deploy-border-gateway-protocol-bgp-with-the-RAS-multitenant-gateway.aspx)  
  

