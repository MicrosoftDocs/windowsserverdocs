---
title: Remote Access
description: This topic provides an overview of the Remote Access services in Windows Server.
manager: eliotgra
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: anaharris
author: anaharris-ms
ms.date: 09/28/2022
---

# Remote access overview

When you install the Remote Access Server Role with the *Add Roles and Features Wizard* or Windows PowerShell, you can choose to install one or more of the following three role services:

- [Direct Access and VPN (RAS) service](#directaccess-and-vpn-service)
- [Routing service](#routing-service)
- [Web Application Proxy service](#web-application-proxy-service)

Anyone of these services can be installed either individually or on the same server.

>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported. You can't use Remote Access in an Azure VM to deploy VPN, DirectAccess, or any other Remote Access feature in Windows Server. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## DirectAccess and VPN service

### VPN (RAS)

The VPN service uses the connectivity of the internet and a combination of tunneling and data encryption technologies to connect to remote clients and offices.

With VPN and Routing service, you can also choose to deploy Always On VPN. Always On VPN enables Windows 10 clients to securely access shared resources, intranet Web sites, and the applications on an internal network without having to manually connect. For more information, see [Always On VPN](vpn/vpn-map-da.md)

### DirectAccess

DirectAccess allows connectivity for remote users to organization network resources without the need for traditional VPN connections. With DirectAccess connections, remote client computers are always connected to your organization. There's no need for remote users to start and stop connections, as is required with VPN connections. In addition, your IT administrators can manage DirectAccess client computers whenever they're' running and Internet connected.

>[!IMPORTANT]
>For Windows 10 or later, it is recommended to connect using Always On VPN. DirectAccess should be used only for clients earlier than Windows 10.

## Routing service

The Routing service allows you to route network traffic between subnets on your Local Area Network. Routing provides support for the following technologies:

- [Network Address Translation (NAT) routers](/previous-versions/windows/it-pro/windows-2000-server/cc957896(v=technet.10))
- [LAN routers running Border Gateway Protocol (BGP)](bgp/border-gateway-protocol-bgp.md)
- [Routing Information Protocol (RIP)](/previous-versions/windows/it-pro/windows-2000-server/cc957940(v=technet.10))
- [Multicast-capable routers using Internet Group Management Protocol (IGMP)](/previous-versions/windows/it-pro/windows-2000-server/cc957920(v=technet.10))
- [Demand-dial routing](/previous-versions/windows/it-pro/windows-2000-server/cc957968(v=technet.10))
- [Unicast IP Routing](/previous-versions/windows/it-pro/windows-2000-server/cc957899(v=technet.10))

As a full-featured router, you can deploy RAS on either a physical computer or as a virtual machine (VM) on a computer that's running Hyper-V.

To install Remote Access as a LAN router, either use the *Add Roles and Features Wizard* in Server Manager and select the **Remote Access** server role and the **Routing** role service; or type the following command from an elevated Windows PowerShell prompt, and then press ENTER.

```
Install-RemoteAccess -VpnType RoutingOnly
```

## Web Application Proxy service

Web Application Proxy service provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network. Web Application Proxy pre-authenticates access to web applications using Active Directory Federation Services (AD FS), and also functions as an AD FS proxy.

To install Remote Access as a Web Application Proxy, either use the Add Roles and Features Wizard in Server Manager and select the **Remote Access** server role and the **Web Application Proxy** role service; or type the following command at a Windows PowerShell prompt, and then press ENTER.

```
Install-RemoteAccess -VpnType SstpProxy
```

For more information, see [Web Application Proxy](./web-application-proxy/web-app-proxy-windows-server.md).

For more information about other networking technologies, see [Networking in Windows Server](../../networking/index.yml).

## Next Steps

Now you've learned about what the Remote Access role is, here are some articles that might help you during deployment:

- [Always On VPN Deployment Guide](vpn/always-on-vpn/deploy/always-on-vpn-deploy-deployment.md)
- [Border Gateway Protocol &#40;BGP&#41;](bgp/Border-Gateway-Protocol-BGP.md)
- [RAS Gateway](ras-gateway/RAS-Gateway.md)
- [RAS Gateway for SDN](/azure-stack/hci/concepts/gateway-overview)
- [Virtual Private Networking (VPN)](vpn/vpn-top.md)