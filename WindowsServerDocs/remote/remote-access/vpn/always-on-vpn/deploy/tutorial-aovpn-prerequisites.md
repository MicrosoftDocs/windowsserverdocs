---
title: Tutorial- Deploy Always On VPN
description: Learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date: 11/21/2022
---

# Tutorial: Deploy Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows 11

In this tutorial, you'll learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).
In this deployment you'll configure Remote Access as a single tenant VPN RAS Gateway for point-to-site VPN connections.

## Prerequisites

In order to follow and implement the steps in this tutorial, make sure that:

- You have membership in the Windows Administrators group, or equivalent.
<!-- Editorial note: What is CSP-->
- You've installed the management platform of your choice for deploying the Always On VPN configuration because the CSP is not vendor-specific.

### Server infrastructure

You'll need to setup the following Windows servers:

| Server | Details |
|--------|--------|
| **An NPS (RADIUS) server.**  |If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than add a new server. |
|**A Certification Authority (CA) server**  | |
| **A Remote Access (RAS) VPN server**  | The VPN server must: </br><li> Be installed on a perimeter network, between the edge firewall and the perimeter firewall.<li>  Support IKEv2 VPN connections and LAN routing.<li> Have two physical network adapters installed: one to connect to the external perimeter network, and one to connect to the internal perimeter network. Configure the network adapter facing the internet with a public IP address. The adapter facing the intranet can use an IP address from the local network. <li> (*Optional*) Configure the Remote Access VPN server to support [IKEv2](https://datatracker.ietf.org/doc/rfc7296/) connections while also disabling unused protocols, which reduces the server's security footprint. <li> Determine the maximum number of simultaneous VPN clients that you want to support. Also, plan a range of static IP addresses on the internal perimeter network to meet that requirement, namely the *static address pool*. If you use DHCP to supply IP addresses on the internal DMZ, you might also need to create an exclusion for those static IP addresses in DHCP.|

### Active Directory domain infrastructure

Your Active Directory domain infrastructure must include:

- A public perimeter (DNS) zone for the perimeter network (for example, contoso.com).  
- A private internal DNS zone for corporate data and applications (for example, corp.contoso.com).
- Active Directory-based public key infrastructure (PKI) and Active Directory Certificate Services (AD CS).
- <!-- Editorial note: This item can probably be removed as I believe it is one of the steps in the tutorial-->Make sure that all VPN users have user accounts in Active Directory User (AD DS). Before users can connect to the network with VPN connections, they must have user accounts in AD DS.

### Routing and Firewall infrastructure

Before walking through this tutorial, you'll need to set up two firewalls around the perimeter network. Make sure that you have done the following:

- Ensure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function properly. For more information on how to configure firewalls for RADIUS traffic, see [Configure firewalls for RADIUS traffic](../../../../networking/technologies/nps/nps-firewalls-configure.md).

- Make sure that you have permissions to configure your external firewall and that you have a valid public IP address.

- Configure port forwarding. Your edge firewall must open the ports and protocol IDs associated with an IKEv2 VPN and forward them to the VPN server. In most environments, doing so requires you to configure port forwarding. Redirect Universal Datagram Protocol (UDP) ports 500 and 4500 to the VPN server.

- Configure routing so that the DNS servers and VPN servers can reach the Internet. This tutorial uses IKEv2 and Network Address Translation (NAT). Make sure that the VPN server can reach all of the required internal networks and network resources. Any network or resource unreachable from the VPN server is also unreachable over VPN connections from remote locations.

- In most environments, to reach the new internal perimeter network, you just need to adjust static routes on the edge firewall and the VPN server. In more complex environments, however, you may need to add static routes to internal routers or adjust internal firewall rules for the VPN server and the block of IP addresses associated with VPN clients.


<!-- Editorial note: Is this still true? -->
>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine (VM) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Next steps

- [Configure certificate-based authentication for Always On VPN](tutorial-aovpn-certificates.md).