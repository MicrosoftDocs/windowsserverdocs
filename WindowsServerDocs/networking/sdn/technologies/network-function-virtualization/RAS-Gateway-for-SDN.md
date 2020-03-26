---
title: RAS Gateway for SDN
description: You can use this topic to learn about RAS Gateway, which is a software-based, multitenant, Border Gateway Protocol (BGP) capable router in  Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a32357a5-ab1a-4a4c-848a-7a4ed65b1921
ms.author: lizross
author: eross-msft
---
# RAS Gateway for SDN

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016## RAS Gateway for SDN  


RAS Gateway is a software-based, multitenant, Border Gateway Protocol (BGP) capable router designed for Cloud Service Providers (CSPs) and Enterprises that host multiple tenant virtual networks using Hyper-V Network Virtualization. RAS Gateways routes network traffic between the physical network and VM network resources, regardless of the location. You can route the network traffic at the same physical location or many different locations.   

Multitenancy is the ability of a cloud infrastructure to support the virtual machine workloads of multiple tenants, yet isolate them from each other, while all of the workloads run on the same infrastructure. The multiple workloads of an individual tenant can interconnect and be managed remotely, but these systems do not interconnect with the workloads of other tenants, nor can other tenants remotely manage them.

  
> [!NOTE]  
> In addition to this topic, the following RAS Gateway topics are available.  
>   
> -   [What's New in RAS Gateway](../../../sdn/technologies/network-function-virtualization/What-s-New-in-RAS-Gateway.md)  
> -   [RAS Gateway Deployment Architecture](../../../sdn/technologies/network-function-virtualization/RAS-Gateway-Deployment-Architecture.md)  
> -   [RAS Gateway High Availability](../../../sdn/technologies/network-function-virtualization/RAS-Gateway-High-Availability.md)  
> -   [Border Gateway Protocol &#40;BGP&#41;](../../../../remote/remote-access/bgp/Border-Gateway-Protocol-BGP.md)  
> -   [BGP Windows PowerShell Command Reference](../../../../remote/remote-access/bgp/BGP-Windows-PowerShell-Command-Reference.md)  
  
    
## Prerequisites for installing RAS Gateway for SDN  
You cannot use the Windows interface to install Remote Access when you want to deploy RAS Gateway in multitenant mode for use with SDN. Instead, you must use Windows PowerShell.  
  
But before you can install RAS Gateway by using Windows PowerShell, you must use Windows PowerShell to add the **RemoteAccess** Windows feature. To do so, run the following command at the Windows PowerShell prompt.  
  
`Add-WindowsFeature -Name RemoteAccess -IncludeAllSubFeature -IncludeManagementTools`  
  
This command adds the **RemoteAccess** feature and the Windows PowerShell commands for the feature.  
  
After you have added **RemoteAccess** to your server, you can install Remote Access as a RAS Gateway with multitenant mode and Border Gateway Protocol (BGP).  
  
For more information, see the Windows PowerShell reference topic [Install-RemoteAccess](https://technet.microsoft.com/library/hh918408.aspx).  
  
## RAS Gateway Features  
Following are RAS Gateway features in  Windows Server 2016. You can deploy RAS Gateway in high availability pools that use all of these features at one time.  
  
-   **Site-to-site VPN**. This RAS Gateway feature allows you to connect two networks at different physical locations across the Internet by using a site-to-site VPN connection. For CSPs that host many tenants in their datacenter, RAS Gateway provides a multitenant gateway solution that allows your tenants to access and manage their resources over site-to-site VPN connections from remote sites, and that allows network traffic flow between virtual resources in your datacenter and their physical network.  
  
-   **Point-to-site VPN**. This RAS Gateway feature allows organization employees or administrators to connect to your organization's network from remote locations.  For multitenant deployments, tenant network administrators can use point-to-site VPN connections to access virtual network resources at the CSP datacenter.  
  
-   **GRE Tunneling**. Generic Routing Encapsulation (GRE) based tunnels enable connectivity between tenant virtual networks and external networks. Since the GRE protocol is lightweight and support for GRE is available on most of network devices it becomes an ideal choice for tunneling where encryption of data is not required. GRE support in Site to Site (S2S) tunnels solves the problem of forwarding between tenant virtual networks and tenant external networks using a multi-tenant gateway, as described later in this topic.  
  
-   **Dynamic routing with Border Gateway Protocol (BGP)**. BGP reduces the need for manual route configuration on routers because it is a dynamic routing protocol, and automatically learns routes between sites that are connected by using site-to-site VPN connections. If your organization has multiple sites that are connected by using BGP-enabled routers such as RAS Gateway, BGP allows the routers to automatically calculate and use valid routes to each other in the event of network disruption or failure. For more information, see [RFC 4271](https://tools.ietf.org/html/rfc4271).  
  

  


