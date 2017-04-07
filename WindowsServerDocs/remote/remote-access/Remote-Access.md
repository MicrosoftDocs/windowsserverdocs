---
title: Remote Access
description: This topic provides an overview of the Remote Access server role in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: jamesmci
author: jamesmci
---
# Remote Access

>Applies To: Windows Server 2016

This topic provides an overview of the Remote Access server role in Windows Server 2016.  
  
> [!NOTE]  
> In addition to this topic, the following RAS documentation is available.  
>   
> -   [Border Gateway Protocol &#40;BGP&#41;](bgp/Border-Gateway-Protocol-BGP.md)  
> -   [DirectAccess](directaccess/DirectAccess.md)  
> -   [RAS Gateway](ras-gateway/RAS-Gateway.md)  
> -   [Remote Access Server Role Documentation](ras/Remote-Access-Server-Role-Documentation.md) 
> -   [RAS Gateway for SDN](../sdn/technologies/network-function-virtualization/RAS-Gateway-for-SDN.md)  
  
The Remote Access server role is a logical grouping of the following related network access technologies.  
  
-   [Remote Access Service (RAS)](#bkmk_da)  
  
-   [Routing](#bkmk_rras)  
  
-   [Web Application Proxy](#bkmk_proxy)  
  
These technologies are the *role services* of the Remote Access server role. When you install the Remote Access server role with the **Add Roles and Features Wizard** or Windows PowerShell, you can install one or more of these three role services.  
  
## <a name="bkmk_da"></a>Remote Access Service (RAS) - RAS Gateway  
When you install the **DirectAccess and (VPN)** role service, you are deploying the Remote Access Service Gateway (**RAS Gateway**). You can deploy the RAS Gateway as a DirectAccess server, a single tenant RAS Gateway virtual private network (VPN) server, and a multitenant RAS Gateway VPN server.  
  
-   **DirectAccess**. DirectAccess enables remote users to securely access shared resources, intranet Web sites, and applications on an internal network without connecting to a VPN. DirectAccess establishes bi-directional connectivity with an internal network every time a DirectAccess-enabled computer is connected to the Internet. Users never have to think about connecting to the internal network, and IT administrators can manage remote computers outside the office, even when the computers are not connected via VPN.

-   **RAS Gateway - Single Tenant**. By using RAS Gateway, you can deploy VPN connections to provide end users with remote access to your organization's network and resources. You can also create a site-to-site VPN connection between two servers at different locations, such as between your primary office and a branch office, and use Network Address Translation (NAT) so that users inside the network can access external resources, such as the Internet. In addition, RAS Gateway supports Border Gateway Protocol (BGP), which provides dynamic routing services when your remote office locations also have edge gateways that support BGP.  
  
-   **RAS Gateway - Multitenant**.  You can deploy RAS Gateway as a multitenant, software-based edge gateway and router when you are using Hyper-V Network Virtualization or you have VM networks deployed with virtual Local Area Networks (VLANs). With the RAS Gateway, Cloud Service Providers (CSPs) and Enterprises can enable datacenter and cloud network traffic routing between virtual and physical networks, including the Internet. With the RAS Gateway, your tenants can use point-so-site VPN connections to access their VM network resources in the datacenter from anywhere. You can also provide tenants with site-to-site VPN connections between their remote sites and your CSP datacenter. In addition, you can configure the RAS Gateway with BGP for dynamic routing, and you can enable Network Address Translation (NAT) to provide Internet access for VMs on VM networks.  
  
    > [!IMPORTANT]  
    > The RAS Gateway with multitenant capabilities is also available in  Windows Server 2012 R2 .  
  
For more information, see [RAS Gateway](../remote-access/ras-gateway/RAS-Gateway.md) and [Border Gateway Protocol &#40;BGP&#41;](../remote-access/bgp/Border-Gateway-Protocol-BGP.md).  
  
## <a name="bkmk_rras"></a>Routing

You can use Remote Access to route network traffic between subnets on your Local Area Network. Routing provides support for Network Address Translation (NAT) routers, LAN routers running BGP, Routing Information Protocol (RIP), and multicast-capable routers using Internet Group Management Protocol (IGMP). As a full-featured router, you can deploy RAS on either a server computer or as a virtual machine (VM) on a computer that is running Hyper-V.  
  
To install Remote Access as a LAN router, either use the Add Roles and Features Wizard in Server Manager and select the **Remote Access** server role and the **Routing** role service; or type the following command at a Windows PowerShell prompt, and then press ENTER.  
  
```  
Install-RemoteAccess -VpnType RoutingOnly  
```  
  
## <a name="bkmk_proxy"></a>Web Application Proxy

Web Application Proxy is a Remote Access role service in Windows Server 2016. Web Application Proxy provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network. Web Application Proxy pre-authenticates access to web applications using Active Directory Federation Services (AD FS), and also functions as an AD FS proxy.  
  
To install Remote Access as a Web Application Proxy, either use the Add Roles and Features Wizard in Server Manager and select the **Remote Access** server role and the **Web Application Proxy** role service; or type the following command at a Windows PowerShell prompt, and then press ENTER.  
  
```  
Install-RemoteAccess -VpnType SstpProxy  
```  

For more information, see [Web Application Proxy](https://technet.microsoft.com/windows-server-docs/identity/web-application-proxy/web-application-proxy-windows-server).


