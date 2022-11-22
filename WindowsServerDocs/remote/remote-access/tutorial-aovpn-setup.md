---
title: Tutorial- Deploy Always On VPN
description: Learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date: 11/21/2022
---

# Tutorial: Step 1 - Deploy Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows 11

In this tutorial, you'll learn how to deploy Always On VPN (AOV) connections for Windows 10+ client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).

<!-- Editorial note: Emphasize that this is not production ready and has no security infrastructure such as firewalls, etc to protect the network.-->

<!-- Remove dual NIC requirement. No need to worry about "internal network"-->

## Prerequisites

To implement the steps in this tutorial, you'll need to setup the following:

**Servers:**

- A Remote Access (RAS) VPN server that has:
    - One physical network adapter with a public IP address installed to connect to the network.  
    - <!-- Editorial note: This one may be covered in the tutorial-->Determine the maximum number of simultaneous VPN clients that you want to support. Also, plan a range of static IP addresses on the internal perimeter network to meet that requirement, namely the *static address pool*. If you use DHCP to supply IP addresses on the internal DMZ, you might also need to create an exclusion for those static IP addresses in DHCP.

- A [Network Policy Server (NPS or RADIUS)](../../../../../networking/technologies/nps/nps-top.md) server. If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than add a new server. 

- A Certification Authority (CA) server.

**Active Directory:**

- Active Directory Certificate Services (AD CS) to provide public key infrastructure (PKI).

- A public DNS (Domain Name Services) zone for the network.

- <!-- Editorial note: This item can probably be removed as I believe it is one of the steps in the tutorial-->Make sure that all VPN users have user accounts in Active Directory User (AD DS). Before users can connect to the network with VPN connections, they must have user accounts in AD DS.

**Routing and Firewall infrastructure:**

- Configure your firewalls to allow RADIUS traffic. For more information on how to configure firewalls for RADIUS traffic, see [Configure firewalls for RADIUS traffic](../../../../../networking/technologies/nps/nps-firewalls-configure.md).

- Configure your firewalls to allow VPN traffic by opening User Datagram Protocol (UDP) ports 500 and 4500 on the external perimeter network adapter.

- Make sure that the VPN server can reach all of the required internal networks and network resources. Any network or resource unreachable from the VPN server is also unreachable over VPN connections from remote locations.

<!-- Editorial note: Is this still true? -->
>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine (VM) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Create certificate templates

##

## Next steps

- [Step 1: Configure Always On VPN certificate-based authentication](tutorial-aovpn-certificates.md).