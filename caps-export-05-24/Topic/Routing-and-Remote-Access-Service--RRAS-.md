---
title: Routing and Remote Access Service (RRAS)
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9dd7a805-b8e7-4b0a-b434-e967a491728d
---
# Routing and Remote Access Service (RRAS)
The Routing and Remote Access service \(RRAS\) supports remote user or site\-to\-site connectivity by using virtual private network \(VPN\) or dial\-up connections.  
  
> [!NOTE]  
> In addition to this topic, the following RRAS documentation is available.  
>   
> -   [Windows Server 2012 R2 RRAS Multitenant Gateway Deployment Guide](../Topic/Windows-Server-2012-R2-RRAS-Multitenant-Gateway-Deployment-Guide.md)  
> -   [Cost Savings with the RRAS Multitenant Gateway in Windows Server 2012 R2](http://blogs.technet.com/b/wsnetdoc/archive/2014/04/08/cost-savings-with-the-rras-multitenant-gateway-in-windows-server-2012-r2.aspx) \(WSiX Network Connection blog post\)  
> -   [Border Gateway Protocol &#40;BGP&#41; Overview](../Topic/Border-Gateway-Protocol--BGP--Overview.md)  
> -   [Test Lab Guide : Corp to Cloud: Configure an IKEv2\-based Site\-to\-site VPN Connection](http://technet.microsoft.com/library/jj574084.aspx)  
> -   [Deploy and Configure a VPN for Devices Running Windows RT](http://technet.microsoft.com/library/jj900206.aspx)  
> -   [Deploy VPN When Connecting Remotely with Windows 8](http://technet.microsoft.com/library/jj613768.aspx)  
> -   [Manage VPN Connections in Windows 8 by Using Windows PowerShell](http://technet.microsoft.com/library/jj613766.aspx)  
> -   [Set Up and Edit VPN Connections in Windows 8](http://technet.microsoft.com/library/jj613767.aspx)  
> -   [VPN Compatibility and Interoperability in Windows 8 and Windows Server 2012](http://technet.microsoft.com/library/jj613765.aspx)  
> -   [Windows Server 2012 R2 Test Lab Guide: Demonstrate VPN Auto trigger](http://technet.microsoft.com/library/dn383580.aspx)  
> -   [Connection Manager](http://technet.microsoft.com/library/hh831583.aspx)  
> -   [Connection Manager Administration Kit Overview](http://technet.microsoft.com/library/hh831675.aspx)  
  
RRAS provides the following features.  
  
-   **RRAS Multitenant Gateway**. If you are using Hyper\-V Network Virtualization or you have VM networks deployed with VLANs, you can deploy RRAS as a virtual machine \(VM\)\-based software gateway and router that allows Cloud Service Providers \(CSPs\) and Enterprises to enable datacenter and cloud network traffic routing between virtual and physical networks, including the Internet. With the RRAS Multitenant Gateway, tenants can VPN to their VM network resources in the datacenter from anywhere. You can also provide tenants with site\-to\-site VPN connections between their remote sites and your datacenter. In addition, you can configure the RRAS Multitenant Gateway with Border Gateway Protocol for dynamic routing, and you can enable Network Address Translation \(NAT\) to provide Internet access for VMs on VM networks.  
  
    > [!IMPORTANT]  
    > The RRAS Multitenant Gateway is available only in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It is not available in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
-   **Remote Access**. By using RRAS, you can deploy VPN connections to provide end users with remote access to your organization's network. You can also create a site\-to\-site VPN connection between two servers at different locations.  
  
-   **Routing**. RRAS is a software router and an open platform for routing and networking. It offers routing services to businesses in local area network \(LAN\) and wide area network \(WAN\) environments or over the Internet by using secure VPN connections. Routing is used for multiprotocol LAN\-to\-LAN, LAN\-to\-WAN, VPN, and network address translation \(NAT\) routing services.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure virtualization solutions](http://aka.ms/f9bh7g).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Connect your network to Azure with greater performance, privacy, control, and agility](http://aka.ms/k6fcsj)<br /> \- [Learn about new networking capabilities available for your hybrid cloud](http://aka.ms/k6fcsj)|  
  
