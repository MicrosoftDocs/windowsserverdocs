---
title: Remote Access Always On VPN Deployment Planning
description: This topic provides planning instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 3c9de3ec-4bbd-4db0-b47a-03507a315383
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 3/4/2018
---
# STEP 1: Plan and Stage the Always On VPN Environment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Deploying Always On VPN requires proper planning to determine your deployment phases, which helps identify any issues before they affect the entire organization. This section provides planning guidelines for deploying Remote Access as a single tenant VPN RAS Gateway for point-to-site VPN connections.

## Requirements

Microsoft recommends that you review the design and deployment guides for each of the technologies that are used in the deployment scenario. These guides help you determine whether this deployment scenario provides the services and configuration you need for your organization's network.

>[!IMPORTANT] 
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services (AD DS), Active Directory  Certificate Services (AD CS), and Network Policy Server (NPS), are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

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

## STEP 1.1: Prepare the Remote Access Server

Before you install the Remote Access server role on the VPN server, you must:

1.  Ensure VPN server software and hardware configuration is correct.

2.  Identify which network adapter connects to the Internet and which network adapter connects to your private network. The Internet facing network adapter must be configured with a public IP address, while the adapter facing the Intranet can use an IP address from the local network.

    >[!NOTE] 
    >If you prefer not to use a public IP address on your perimeter network, you can configure the Edge Firewall with a public IP address, and then configure the firewall to forward VPN connection requests to the VPN server.

3.  Install the VPN server on a perimeter network, between the edge firewall and the perimeter firewall.

## STEP 1.2: Plan Authentication Methods

Configure the Remote Access VPN server to support Internet Key Exchange Version 2 (IKEv2) connections while also disabling unused protocols, which reduces the
server’s security footprint.

IKEv2 protocol is an industry-standard tunneling protocol used by many VPN providers. The primary advantage of IKEv2 is that it tolerates interruptions in the underlying network connection. For example, if the connection is temporarily lost or if a user moves a client computer from one network to another, IKEv2 automatically restores the VPN connection when the network connection is reestablished — all without user intervention.

For more information on IKEv2, see [Internet Engineering Task Force Request for Comments 7296](https://datatracker.ietf.org/doc/rfc7296/?include_text=1).

## STEP 1.3: Plan IP Addresses for Remote Clients

Configure the VPN server to assign addresses to VPN clients from a static address pool that you configure, or you can use IP addresses obtained from a DHCP server.

1.  Determine the maximum number of simultaneous VPN clients that you want to support.

2.  Plan a range of static IP addresses on the internal perimeter network to meet that requirement (i.e., the _static address pool_).

3.  (Optional) If you’re using Dynamic Host Configuration Protocol (DHCP) to supply IP addresses on the internal DMZ, you might also need to create an exclusion for those static IP addresses in DHCP.

## STEP 1.4: Prepare the Environment

1.  Ensure that you have permissions to configure your external firewall and that you have a valid public IP address.<br><br>To support IKEv2 VPN connections, you must open ports on the firewall. To accept connections from external clients, you need a public IP address.

2.  Choose a range of static IP addresses for VPN clients.

3.  Ensure that you can edit your public DNS zone.<br><br>To support the VPN infrastructure, you must add DNS records to your public DNS domain. Ensure that you have permissions to edit this zone.

4.  Verify that all VPN users have user accounts in Active Directory User (AD DS).<br><br>Before users can connect to the network with VPN connections, they must have   user accounts in AD DS.

## STEP 1.5: Prepare the Routing and Firewall

The VPN server is installed inside the perimeter network, which partitions the perimeter network into internal and external perimeter networks. Because of this, you might need to make several routing modifications, depending on your network environment.

1.  (Optional) Configure port forwarding.<br><br>Your edge firewall must open the ports and protocol IDs associated with an IKEv2 VPN and forward them to the VPN server. In most environments, doing so requires you to configure port forwarding. Redirect Universal Datagram Protocol (UDP) ports 500 and 4500 to the VPN server.

2.  Configure routing so that the DNS servers and VPN servers can reach the Internet.<br><br>This deployment uses IKEv2 and Network Address Translation (NAT).

3.  Ensure that the VPN server can reach all the required internal networks and network resources that you want to provide to remote users.<br><br>Any network or resource that is not reachable from the VPN server is also unreachable over VPN connections from remote locations.

>[!TIP] 
>In most environments, you can simply adjust static routes on the edge firewall and the VPN server to allow them to reach this new internal perimeter network. In complex environments, you may need to add static routes to internal routers or adjust internal firewall rules for the VPN server and the block of IP addresses associated with VPN clients.

Next steps
----------

| **If you…**                      | **Then …**      |
|----------------------------------|--------------------------|
| Are migrating from DirectAccess  | Refer to [STEP 2: Plan your migration](rmeote-access/da-always-on-vpn-migration/da-always-on-migration-planning)**.** The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process.                                                                                    |
| Are just deploying Always On VPN | Refer to [STEP 3: Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md). Install and configure the server-side components necessary to support the VPN, including configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server. |