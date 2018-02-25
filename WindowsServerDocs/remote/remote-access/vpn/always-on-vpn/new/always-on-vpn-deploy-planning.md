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
# Plan and Stage the Always On VPN Environment 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Deploying Always On VPN requires proper planning to determine your deployment phases, which helps identify any issues before they affect the entire organization. This section provides planning guidelines for deploying Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections. 

The Always On VPN planning process consists of these primary components and high-level processes:

1. **Prepare the Remote Access Server.**
2. **Plan the Authentication Methods.**
3. **Plan IP Addresses for Remote Clients.**
4. **Prepare the Environment.**
5. **Prepare the Routing and Firewall.**


## Requirements
This section provides a high-level overview of the Always On VPN deployment server and client requirements. Microsoft recommends that you review the design and deployment guides for each of the technologies that are used in the deployment scenario. These guides help you determine whether this deployment scenario provides the services and configuration you need for your organization's network.

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

### Servers
|Requirement  |Description  |
|---------|---------|
|Active Directory Domain Services (AD DS)     |Contains the user accounts, computer accounts, and account properties. These properties are required by Protected Extensible Authentication Protocol (PEAP) to authenticate user credentials and to evaluate authorization for VPB connection requests.         |
|Domain Name System (DNS)     |Hosts the information that enables client computers and servers to resolve IP addresses.         |
|Active Directory Certificate Services (AD CS)     |Allows you to build a public key infrastructure (PKI) and provide public key cryptography, digital certificates, and digital signature capabilities of your organization.          |
|Perimeter network with two firewalls   |Allows the traffic necessary for both VPN and RADIUS communications to function correctly.         |
|Remote Access as a RAS Gateway VPN Server (on\-premise) with two ethernet network adapters and connected to the perimeter network  |Provides centralized administration, configuration, and monitoring of VPN remote access services.         |
|NPS as a RADIUS server on either a new or existing physical server or VM     |Allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. If you have an existing NPS on your network, you can modify it rather than add a new server.        |

<!-- there's a disconnect in the content -- the above table says that you can use a VM for the VPN server -->
>[!IMPORTANT]
>This guide is designed for deploying Always On VPN with the Remote Access server role on an on\-premises organization network. Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

### Clients
The remote client computers must be joined to the Active Directory domain and is running the Windows 10 Anniversary Update version 1607 or later.

For more details, see the [Always On VPN Technology Overview](always-on-vpn-technologies.md) section.

## <a name="bkmk_not"></a>What this guide does not provide

This guide does not provide instructions for deploying the following items.

- Active Directory Domain Services \(AD DS\)
- Active Directory Certificate Services \(AD CS\) and a Public Key Infrastructure \(PKI\).
- Dynamic Host Configuration Protocol \(DHCP\) automatic IP address assignment to computers and other devices that are configured as DHCP clients. 
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity

## Prepare the Remote Access Server
Before you install the Remote Access server role on the VPN server, you must:

- **Ensure VPN server software and hardware configuration is correct**. 
    - Windows Server 2012 R2 or Windows Server 2016
    - Two physical network adapters to connect to the external (Internet) and internal perimeter networks (private network)

- **Identify which network adapter connects to the Internet and which network adapter connects to your private network**. The Internet facing network adapter must be configured with a public IP address, while the adapter facing the Intranet can use an IP address from the local network.

>[!NOTE]
>If you prefer not to use a public IP address on your perimeter network, you can configure the Edge Firewall with a public IP address, and then configure the firewall to forward VPN connection requests to the VPN server.

- **Connect the VPN server to the network**. Install the VPN server on a perimeter network, between the edge firewall and the perimeter firewall.

## Plan Authentication Methods

IKEv2 is a VPN tunneling protocol described in Internet Engineering Task Force Request for Comments 7296. The primary advantage of IKEv2 is that it tolerates interruptions in the underlying network connection. For example, if the connection is temporarily lost or if a user moves a client computer from one network to another, IKEv2 automatically restores the VPN connection when the network connection is reestablished — all without user intervention.

Configure the Remote Access VPN server to support IKEv2 connections while also disabling unused protocols, which reduces the server’s security footprint. 

## Plan IP Addresses for Remote Clients

Configure the VPN server to assign addresses to VPN clients from a static address pool that you configure, or you can use IP addresses obtained from a DHCP server. 

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

## Next steps
**[Deploy Always On VPN Connections](always-on-vpn-deploy-deployment.md)**. This section provides instructions on how to deploy Always On VPN connections for remote Windows 10 client computers that are joined to your domain.