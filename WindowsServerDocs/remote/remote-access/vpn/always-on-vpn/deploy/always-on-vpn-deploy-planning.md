---
title: Plan the Always On VPN Deployment
description: This topic provides planning instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 3c9de3ec-4bbd-4db0-b47a-03507a315383
ms.localizationpriority: medium 
ms.author: pashort
author: shortpatti
ms.date: 11/05/2018
---
# Step 1. Plan the Always On VPN deployment

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Learn about the workflow for deploying Always On VPN](always-on-vpn-deploy-deployment.md)
- [**Next:** Step 2. Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md)

In this step, you start to plan and prepare your Always On VPN deployment. Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks. After proper planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.

[!INCLUDE [always-on-vpn-standard-config-considerations-include](../../../includes/always-on-vpn-standard-config-considerations-include.md)]

## Prepare the Remote Access Server

You must do the following on the computer used as a VPN server:

- **Make sure the VPN server software and hardware configuration is correct**. Install Windows Server 2016 on the computer that you plan to use as a Remote Access VPN server. This server must have two physical network adapters installed, one to connect to the external perimeter network, and one to connect to the internal perimeter network.

- **Identify which network adapter connects to the Internet and which network adapter connects to your private network**. Configure the network adapter facing the Internet with a public IP address, while the adapter facing the Intranet can use an IP address from the local network.

    >[!TIP]
    >If you prefer not to use a public IP address on your perimeter network, you can configure the Edge Firewall with a public IP address, and then configure the firewall to forward VPN connection requests to the VPN server.

- **Connect the VPN server to the network**. Install the VPN server on a perimeter network, between the edge firewall and the perimeter firewall.

## Plan Authentication Methods

IKEv2 is a VPN tunneling protocol described in [Internet Engineering Task Force Request for Comments 7296](https://datatracker.ietf.org/doc/rfc7296/). The primary advantage of IKEv2 is that it tolerates interruptions in the underlying network connection. For example, if a temporary loss in connection or if a user moves a client computer from one network to another, when reestablishing the network connection IKEv2 restores the VPN connection automatically — without user intervention.

>[!TIP]
>You can configure the Remote Access VPN server to support IKEv2 connections while also disabling unused protocols, which reduces the server’s security footprint. 

## Plan IP Addresses for Remote Clients

You can configure the VPN server to assign addresses to VPN clients from a static address pool that you configure or IP addresses from a DHCP server. 

## Prepare the Environment

- **Make sure that you have permissions to configure your external firewall and that you have a valid public IP address**. Open ports on the firewall to support IKEv2 VPN connections. You also need a public IP address to accept connections from external clients.

- **Choose a range of static IP addresses for VPN clients**. Determine the maximum number of simultaneous VPN clients that you want to support. Also, plan a range of static IP addresses on the internal perimeter network to meet that requirement, namely the *static address pool*. If you use DHCP to supply IP addresses on the internal DMZ, you might also need to create an exclusion for those static IP addresses in DHCP.

- **Make sure that you can edit your public DNS zone**. Add DNS records to your public DNS domain to support the VPN infrastructure. 

- **Make sure that all VPN users have user accounts in Active Directory User (AD DS)**. Before users can connect to the network with VPN connections, they must have user accounts in AD DS.

## Prepare Routing and Firewall 

Install the VPN server inside the perimeter network, which partitions the perimeter network into internal and external perimeter networks. Depending on your network environment, you might need to make several routing modifications.

- **(Optional) Configure port forwarding.** Your edge firewall must open the ports and protocol IDs associated with an IKEv2 VPN and forward them to the VPN server. In most environments, doing so requires you to configure port forwarding. Redirect Universal Datagram Protocol (UDP) ports 500 and 4500 to the VPN server.

- **Configure routing so that the DNS servers and VPN servers can reach the Internet**. This deployment uses IKEv2 and Network Address Translation (NAT). Make sure that the VPN server can reach all of the required internal networks and network resources. Any network or resource unreachable from the VPN server is also unreachable over VPN connections from remote locations.

In most environments, to reach the new internal perimeter network, adjust static routes on the edge firewall and the VPN server. In more complex environments, however, you may need to add static routes to internal routers or adjust internal firewall rules for the VPN server and the block of IP addresses associated with VPN clients.

## Next steps

[Step 2. Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md): In this step, you install and configure the server-side components necessary to support the VPN. The server-side components include configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server.