---
title: Remote Access Always On VPN Deployment Planning
description: This topic provides planning instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 3c9de3ec-4bbd-4db0-b47a-03507a315383
manager: brianlic
ms.author: jamesmci
author: jamesmci
---
# Remote Access Always On VPN Deployment Planning

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

You can use the following steps to plan for your Always On VPN deployment.

## Prepare the Remote Access Server

Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks.

- **Ensure VPN server software and hardware configuration is correct**. You must install Windows Server 2016 on the computer that you plan to use as a Remote Access VPN server. This server must have two physical network adapters installed, one to connect to the external perimeter network, and one to connect to the internal perimeter network.

- **Identify which network adapter connects to the Internet and which network adapter connects to your private network**. You must configure the Internet facing network adapter with a public IP address, while the adapter facing the Intranet can use an IP address from the local network.

>[!NOTE]
>If you prefer not to use a public IP address on your perimeter network, you can configure the Edge Firewall with a public IP address, and then configure the firewall to forward VPN connection requests to the VPN server.

- **Connect the VPN server to the network**. Install the VPN server on a perimeter network, between the edge firewall and the perimeter firewall.

## Plan Authentication Methods

IKEv2 is a VPN tunneling protocol described in Internet Engineering Task Force Request for Comments 7296. The primary advantage of IKEv2 is that it tolerates interruptions in the underlying network connection. For example, if the connection is temporarily lost or if a user moves a client computer from one network to another, IKEv2 automatically restores the VPN connection when the network connection is reestablished — all without user intervention.

You can configure the Remote Access VPN server to support IKEv2 connections while also disabling unused protocols, which reduces the server’s security footprint. 

## Plan IP Addresses for Remote Clients

You can configure the VPN server to assign addresses to VPN clients from a static address pool that you configure, or you can use IP addresses obtained from a DHCP server. 

## Prepare the Environment

- **Ensure that you have permissions to configure your external firewall and that you have a valid public IP address**. To support Internet Key Exchange version 2 \(IKEv2\) VPN connections, you must open ports on the firewall. To accept connections from external clients, you need a public IP address.

- **Choose a range of static IP addresses for VPN clients**. Determine the maximum number of simultaneous VPN clients that you want to support, and plan a range of static IP addresses on the internal perimeter network to meet that requirement (i.e., the *static address pool*). If you’re using Dynamic Host Configuration Protocol \(DHCP\) to supply IP addresses on the internal DMZ, you might also need to create an exclusion for those static IP addresses in DHCP.

- **Ensure that you can edit your public DNS zone**. To support the VPN infrastructure, you must add DNS records to your public DNS domain. Ensure that you have permissions to edit this zone.

- **Verify that all VPN users have user accounts in Active Directory User \(AD DS\)**. Before users can connect to the network with VPN connections, they must have user accounts in AD DS.

## Routing and Firewall Preparations

The following steps provide instructions on how to make minor adjustments to the firewall configuration to support VPN deployment.

In addition, the VPN server is installed inside the perimeter network, which partitions the perimeter network into internal and external perimeter networks. Because of this, you might need to make several routing modifications, depending on your network environment.

- **Configure port forwarding \(optional\)**. Your edge firewall must open the ports and protocol IDs associated with an IKEv2 VPN and forward them to the VPN server. In most environments, doing so requires you to configure port forwarding. Redirect Universal Datagram Protocol (UDP) ports 500 and 4500 to the VPN server.

- **Configure routing so that the DNS servers and VPN servers can reach the Internet**. This deployment uses IKEv2 and Network Address Translation \(NAT\). Ensure that the VPN server can reach all of the required internal networks and network resources that you want to provide to remote users. Any network or resource that is not reachable from the VPN server will also be unreachable over VPN connections from remote locations.

In most environments, you can simply adjust static routes on the edge firewall and the VPN server to allow them to reach this new internal perimeter network. In complex environments, you may need to add static routes to internal routers or adjust internal firewall rules for the VPN server and the block of IP addresses associated with VPN clients.

For the next section in this guide, see [Remote Access Always On VPN Deployment](always-on-vpn-deploy-deployment.md).

