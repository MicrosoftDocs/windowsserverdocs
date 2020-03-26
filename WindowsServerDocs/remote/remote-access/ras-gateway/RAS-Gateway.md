---
title: RAS Gateway
description: This topic, which is intended for Information Technology (IT) professionals, provides overview information about RAS Gateway, including RAS Gateway deployment modes and features in Windows Server 2016.
manager: dougkim
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: acaa46b7-09b1-4707-9562-116df8db17eb
ms.author: lizross
author: eross-msft
ms.date: 05/23/2018
---
# RAS Gateway

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

RAS Gateway is a software router and gateway that you can use in either single tenant mode or multitenant mode.  
  
- **Single tenant** mode allows organizations of any size to deploy the gateway as an exterior, or Internet-facing edge virtual private network (VPN) and DirectAccess server. In single tenant mode, you can deploy RAS Gateway on a physical server or virtual machine (VM) running  Windows Server 2016.  
  
- **Multitenant mode** allows Cloud Service Providers (CSPs) and Enterprises to use RAS Gateway to enable datacenter and cloud network traffic routing between virtual and physical networks, including the Internet. For multitenant mode, it is recommended that you deploy RAS Gateway on VMs that are running  Windows Server 2016.  
  
> [!NOTE]  
> RAS Gateway supports IPv4 and IPv6, including IPv4 and IPv6 forwarding. When you configure RAS Gateway with Network Address Translation (NAT), only NAT44 is supported.  
  
## Who will be interested in RAS Gateway?
  
If you are a system administrator, network architect, or other IT professional, RAS Gateway might interest you under one or more of the following circumstances:  
  
-   You design or support IT infrastructure for an organization that is using or planning to use Hyper-V to deploy virtual machines (VMs) on virtual networks.  
  
-   You design or support IT infrastructure for an organization that has deployed or is planning to deploy cloud technologies.  
  
-   You want to provide full network connectivity between physical networks and virtual networks.  
  
-   You want to provide your organization's customers with access to their virtual networks over the Internet.  
  
-   You want to provide your organization's employees with remote access to your organization network.  
  
-   You want to connect offices at different physical locations across the Internet.  
 
This topic, which is intended for Information Technology (IT) professionals, provides overview information about RAS Gateway, including RAS Gateway deployment modes and features. 
  
This topic contains the following sections.  
  
  
-   [RAS Gateway Deployment Modes](#bkmk_modes)  
  
-   [Clustering RAS Gateway for high availability](#bkmk_clustering)  
  
-   [RAS Gateway Features](#bkmk_features)  
  
-   [RAS Gateway Deployment Scenarios](#bkmk_deploy)  
  
-   [RAS Gateway Management Tools](#bkmk_manage)  
  


  
## <a name="bkmk_modes"></a>RAS Gateway Deployment Modes  
RAS Gateway includes the following deployment modes.  
  
### Single tenant mode  
For most organizations, using RAS Gateway in single tenant mode is the typical configuration. In single tenant mode, you can deploy RAS Gateway as an edge VPN server, an edge DirectAccess server, or both simultaneously. In this configuration, RAS Gateway provides remote employees with connectivity to your network by using either VPN or DirectAccess connections. In addition, single tenant mode allows you to connect offices at different physical locations across the Internet.  
  
### Multitenant mode  
If your organization is a CSP or an Enterprise with multiple tenants, you can deploy RAS Gateway in multitenant mode to provide network traffic routing to and from virtual and physical networks.  
  
Multitenancy is the ability of a cloud infrastructure to support the virtual machine workloads of multiple tenants, yet isolate them from each other, while all of the workloads run on the same infrastructure. The multiple workloads of an individual tenant can interconnect and be managed remotely, but these systems do not interconnect with the workloads of other tenants, nor can other tenants remotely manage them.  
  
For example, an Enterprise might have many different virtual subnets, each of which is dedicated to servicing a specific department, such as Research and Development or Accounting. In another example, a CSP has many tenants with isolated virtual subnets existing in the same physical datacenter. In both cases, RAS Gateway can route traffic to and from each tenant while maintaining the designed isolation of each tenant. This capability makes the RAS Gateway multitenant-aware.  
  
Virtual networks are created by using Hyper-V Network Virtualization, which is a technology that was introduced in Windows Server 2012, and is improved in  Windows Server 2016. RAS Gateway is integrated with Hyper-V Network Virtualization, and is able to route network traffic effectively in circumstances where there are many different customers - or tenants - who have isolated virtual networks in the same datacenter.  
  
Hyper-V Network Virtualization provides you with the ability to deploy a virtual machine (VM) network that is independent of the underlying physical network. With VM networks, which are composed of one or more virtual subnets, the exact physical location of an IP subnet is decoupled from the virtual network topology. As a result, you can easily move your on premises subnets to the cloud - while preserving your existing IP addresses and topology in the cloud. This ability to preserve infrastructure allows existing services to continue to work, unaware of the physical location of the subnets. That is, Hyper-V Network Virtualization enables a seamless hybrid cloud.  
  
> [!NOTE]  
> Hyper-V Network Virtualization is a network overlay technology using Network Virtualization Generic Routing Encapsulation ([NVGRE](https://tools.ietf.org/html/draft-sridharan-virtualization-nvgre-00)), which allows tenants to bring their own address space and allows CSPs better scalability than is possible by using VLANs for tenant isolation.  
  
In  Windows Server 2016, RAS Gateway routes network traffic between the physical network and VM network resources, regardless of where the resources are located. You can use RAS Gateway to route network traffic between physical and virtual networks at the same physical location or at many different physical locations.  
  
For example, if you have both a physical network and a virtual network at the same physical location, you can deploy a computer running Hyper-V that is configured with an RAS Gateway VM to act as a forwarding gateway and route traffic between the virtual and physical networks.  
  
In another example, if your virtual networks exist in the cloud, your CSP can deploy an RAS Gateway so that you can create a virtual private network (VPN) site-to-site connection between your VPN server and the CSP's RAS Gateway; when this link is established you can connect to your virtual resources in the cloud over the VPN connection.  
  
For more information, see [RAS Gateway High Availability](../../../networking/sdn/technologies/network-function-virtualization/RAS-Gateway-High-Availability.md).  
  
## <a name="bkmk_clustering"></a>Clustering RAS Gateway for high availability  
RAS Gateway is deployed on a dedicated computer that is running Hyper-V and that is configured with one VM. The VM is then configured as a RAS Gateway.  
  
For high availability of network resources, you can deploy RAS Gateway with failover by using two physical host servers running Hyper-V that are each also running a virtual machine (VM) that is configured as a gateway. The gateway VMs are then configured as a cluster to provide failover protection against network outages and hardware failure.  
  
For example, if your organization is an Enterprise with a private cloud deployment, you might need only two RAS Gateway VMs, each of which is installed on a different computer running Hyper-V. In this scenario, the RAS Gateway VMs are added to a cluster to provide high availability.  
  
In another example, if your organization is a Cloud Service Provider (CSP) with two hundred tenants in your datacenter, you can use eight RAS Gateway VMs, with each pair of clustered RAS Gateway VMs providing routing services for fifty tenants. In this scenario, two computers that are running Hyper-V each have four VMs that are configured as RAS Gateways. You then configure four RAS Gateway VM clusters, each cluster containing one VM from each computer running Hyper-V.  
  
When you deploy RAS Gateway, the host servers running Hyper-V and the VMs that you configure as gateways must be running  Windows Server 2012 R2  or  Windows Server 2016.  
  
## <a name="bkmk_features"></a>RAS Gateway Features  
RAS Gateway includes the following capabilities.  
  
-   **Site-to-site VPN**. This RAS Gateway feature allows you to connect two networks at different physical locations across the Internet by using a site-to-site VPN connection. If you have a main office and multiple branch offices, you can deploy an edge RAS Gateway at each location and create site-to-site connections to provide network traffic flow between the locations. For CSPs that host many tenants in their datacenter, RAS Gateway provides a multitenant gateway solution that allows your tenants to access and manage their resources over site-to-site VPN connections from remote sites, and that allows network traffic flow between virtual resources in your datacenter and their physical network.  
  
-   **Point-to-site VPN**. This RAS Gateway feature allows organization employees or administrators to connect to your organization's network from remote locations. For single tenant deployments of RAS Gateway, remote employees can connect to your organization network by using a VPN connection. This connection allows them to use internal network resources, such as intranet web sites and file servers. For multitenant deployments, tenant network administrators can use point-to-site VPN connections to access virtual network resources at the CSP datacenter.  
  
-   **Dynamic routing with Border Gateway Protocol (BGP)**. BGP reduces the need for manual route configuration on routers because it is a dynamic routing protocol, and automatically learns routes between sites that are connected by using site-to-site VPN connections. If your organization has multiple sites that are connected by using BGP-enabled routers such as RAS Gateway, BGP allows the routers to automatically calculate and use valid routes to each other in the event of network disruption or failure. For more information, see [RFC 4271](https://tools.ietf.org/html/rfc4271).  
  
-   **Network Address Translation (NAT)**. Network address translation (NAT) allows you to share a connection to the public Internet through a single interface with a single public IP address. The computers on the private network use private, non-routable addresses. NAT maps the private addresses to the public address. This RAS Gateway feature allows organization employees with single tenant deployments to access Internet resources from behind the gateway. For CSPs, this feature allows applications that are running on tenant VMs to access the Internet. For example, a tenant VM that is configured as a Web server can contact external financial resources to process credit card transactions.  

  
## <a name="bkmk_deploy"></a>RAS Gateway Deployment Scenarios  
Following are the recommended deployment scenarios for RAS Gateway.  
  
-   **Enterprise Edge - Single Tenant deployment**. With the single tenant Enterprise deployment, you can connect one physical to multiple other physical locations across the Internet by using the site-to-site VPN feature - and Border Gateway Protocol (BGP) allows you to use dynamic routing. You can also provide remote employees access to your organization network with both point-to-site VPN connections and DirectAccess connections. (DirectAccess connections are always on, and also provide the advantage that you can easily manage computers that are connected using DirectAccess, because they are connected whenever they are on and Internet-connected.) You can also configure single tenant Enterprise RAS Gateways with NAT, so that computers on your Intranet can easily communicate with the Internet.  
  
-   **Cloud Service Provider Edge - Multitenant deployment**. RAS Gateway multitenant deployment for CSPs allows you to offer your tenants all of the features that are available with the Enterprise Edge single tenant deployment. Site-to-site VPN connections between tenant virtual networks in your datacenter and the tenant network locations across the Internet mean that tenants have seamless access to their cloud resources all the time. Point-to-site VPN access for tenants means that tenant administrators can always connect to their virtual networks in your datacenter to manage their resources. BGP provides dynamic routing and keeps tenants connected to their assets even when network problems occur on the Internet or elsewhere. And NAT allows tenant VMs to connect to resources on the Internet, such as credit card processing resources.  
  
## <a name="bkmk_manage"></a>RAS Gateway Management Tools  
Following are the management tools for RAS Gateway.  
  
-   In  Windows Server 2016, to deploy an RAS Gateway router, you must use Windows PowerShell commands. For more information, see  [Remote Access Cmdlets](https://docs.microsoft.com/powershell/module/remoteaccess) for  Windows Server 2016 and Windows 10.  
  
-   In System Center 2012 R2 Virtual Machine Manager (VMM), the RAS Gateway is named Windows Server Gateway. A limited set of Border Gateway Protocol (BGP) configuration options are available in the VMM software interface, including **Local BGP IP Address** and **Autonomous System Numbers (ASN)**, **List of BGP Peer IP Addresses**, and **ASN values**. You can, however, use Remote Access Windows PowerShell BGP commands to configure all other features of Windows Server Gateway. For more information, see  [Virtual Machine Manager (VMM)](https://technet.microsoft.com/system-center-docs/vmm/vmm) and [Remote Access Cmdlets](https://technet.microsoft.com/library/hh918399.aspx) for  Windows Server 2016 and Windows 10.  
  
## Related topics
- [RAS Gateway High Availability](../../../networking/sdn/technologies/network-function-virtualization/RAS-Gateway-High-Availability.md)  
- [GRE Tunneling in Windows Server](gre-tunneling-windows-server.md)
- [RAS Gateway GRE Tunnel Throughput and Performance](RAS-Gateway-GRE-Perf.md)
