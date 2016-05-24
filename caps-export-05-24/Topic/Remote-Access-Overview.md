---
title: Remote Access Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 09822626-48c3-4533-bc70-9284e5873f24
---
# Remote Access Overview
The Remote Access server role is a logical grouping of the following related network access technologies.  
  
-   [DirectAccess in Windows Server 2012](#bkmk_da)  
  
-   [Routing and Remote Access Service](#bkmk_rras)  
  
-   [Web Application Proxy](#bkmk_proxy)  
  
These technologies are the *role services* of the Remote Access server role. When you install the Remote Access server role, you can install one or more role services while running the **Add Roles and Features Wizard**.  
  
In [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] the Remote Access server role provides centralized administration, configuration, and monitoring of both DirectAccess and VPN\-based remote access services with the Routing and Remote Access Service \(RRAS\). Both DirectAccess and RRAS can now be deployed on the same Edge server and managed by using Windows PowerShell commands and the Remote Access Microsoft Management Console \(MMC\).  
  
> [!NOTE]  
> In addition to this topic, the following Remote Access documentation is also available.  
>   
> -   [What's New in Remote Access](http://technet.microsoft.com/library/dn383589.aspx)  
> -   [Remote Access Server Role Documentation](../Topic/Remote-Access-Server-Role-Documentation.md)  
  
## <a name="bkmk_da"></a>DirectAccess  
DirectAccess enables remote users to securely access shared resources, Web sites, and applications on an internal network without connecting to a virtual private network \(VPN\). DirectAccess establishes bi\-directional connectivity with an internal network every time a DirectAccess\-enabled computer is connected to the Internet. Users never have to think about connecting to the internal network, and IT administrators can manage remote computers outside the office, even when the computers are not connected to the VPN.  
  
For more information, see [DirectAccess in Windows Server](../Topic/DirectAccess-in-Windows-Server.md).  
  
## <a name="bkmk_rras"></a>Routing and Remote Access  
The Routing and Remote Access service \(RRAS\) supports remote user or site\-to\-site connectivity by using virtual private network \(VPN\) or dial\-up connections. RRAS provides the following features.  
  
-   **RRAS Multitenant Gateway**. In [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] the Remote Access server role includes the DirectAccess and Routing and Remote Access Service \(RRAS\) server roles. If you are using Hyper\-V Network Virtualization or you have VM networks deployed with VLANs, you can deploy RRAS as a virtual machine \(VM\)\-based software gateway and router that allows Cloud Service Providers \(CSPs\) and Enterprises to enable datacenter and cloud network traffic routing between virtual and physical networks, including the Internet. With the RRAS Multitenant Gateway, tenants can VPN to their VM network resources in the datacenter from anywhere. You can also provide tenants with site\-to\-site VPN connections between their remote sites and your datacenter. In addition, you can configure the RRAS Multitenant Gateway with Border Gateway Protocol for dynamic routing, and you can enable Network Address Translation \(NAT\) to provide Internet access for VMs on VM networks. Following are links to information about the RRAS Multitenant Gateway.  
  
    > [!IMPORTANT]  
    > The RRAS Multitenant Gateway is available only in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It is not available in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
-   **Remote Access**. By using RRAS, you can deploy VPN connections to provide end users with remote access to your organization's network. You can also create a site\-to\-site VPN connection between two servers at different locations.  
  
-   **Routing**. RRAS is a software router and an open platform for routing and networking. It offers routing services to businesses in local area network \(LAN\) and wide area network \(WAN\) environments or over the Internet by using secure VPN connections. Routing is used for multiprotocol LAN\-to\-LAN, LAN\-to\-WAN, VPN, and network address translation \(NAT\) routing services.  
  
For more information, see [Routing and Remote Access Service &#40;RRAS&#41;](../Topic/Routing-and-Remote-Access-Service--RRAS-.md).  
  
## <a name="bkmk_proxy"></a>Web Application Proxy  
Web Application Proxy is a new Remote Access role service in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Web Application Proxy provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network. Web Application Proxy preauthenticates access to web applications using Active Directory Federation Services \(AD FS\), and also functions as an AD FS proxy.  
  
For more information, see [Web Application Proxy](http://technet.microsoft.com/library/dn584107.aspx)  
  
