---
title: Remote Access role
description: This topic provides an overview of the Remote Access server role in Windows Server.
manager: eliotgra
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: anaharris
author: anaharris-ms
ms.date: 05/18/2018
---

# Remote access role

When you install the Remote Access role with the *Add Roles and Features Wizard* or Windows PowerShell, you can choose to install one or more of the following three role services:

- [Direct Access and VPN (RAS)](#directaccess-and-vpn)
- [Routing](#routing)
- [Web Application Proxy](#web-application-proxy)

>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported. You can't use Remote Access in an Azure VM to deploy VPN, DirectAccess, or any other Remote Access feature in Windows Server 2016 or earlier versions of Windows Server. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## DirectAccess and VPN

When you install the DirectAccess and VPN service, you're deploying the Remote Access Service Gateway (RAS Gateway). RAS Gateway is a software router and gateway. For more information, see [RAS Gateway](ras-gateway/RAS-Gateway.md).

With DirectAccess and VPN, you can choose to deploy Always On VPN. Always On VPN enables remote users to securely access shared resources, intranet Web sites, and applications on an internal network without connecting to a VPN. For more information see [Always On VPN]()

## Routing

The routing service allows you to route network traffic between subnets on your Local Area Network. Routing provides support for the following:

- [Network Address Translation (NAT) routers](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-2000-server/cc957896(v=technet.10))
- [LAN routers running Border Gateway Protocol (BGP)](bgp/border-gateway-protocol-bgp.md)
- [Routing Information Protocol (RIP)](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-2000-server/cc957940(v=technet.10))
- [Multicast-capable routers using Internet Group Management Protocol (IGMP)](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-2000-server/cc957920(v=technet.10))
- [Demand-dial routing](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-2000-server/cc957968(v=technet.10))
- [Unicast IP Routing](https://learn.microsoft.com/previous-versions/windows/it-pro/windows-2000-server/cc957899(v=technet.10))

As a full-featured router, you can deploy RAS on either a server computer or as a virtual machine (VM) on a computer that's running Hyper-V.

To install Remote Access as a LAN router, either use the Add Roles and Features Wizard in Server Manager and select the **Remote Access** server role and the **Routing** role service; or type the following command at a Windows PowerShell prompt, and then press ENTER.

```
Install-RemoteAccess -VpnType RoutingOnly
```

## Web Application Proxy

Web Application Proxy provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network. Web Application Proxy pre-authenticates access to web applications using Active Directory Federation Services (AD FS), and also functions as an AD FS proxy.

To install Remote Access as a Web Application Proxy, either use the Add Roles and Features Wizard in Server Manager and select the **Remote Access** server role and the **Web Application Proxy** role service; or type the following command at a Windows PowerShell prompt, and then press ENTER.

```
Install-RemoteAccess -VpnType SstpProxy
```

For more information, see [Web Application Proxy](./web-application-proxy/web-application-proxy-windows-server.md).

For more information about other networking technologies, see [Networking in Windows Server 2016](../../networking/index.yml).
