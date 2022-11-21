---
title: Deploy Always On VPN
description: Learn about the workflow for deploying Always On VPN connections for remote domain-joined Windows 10 client computers.
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
ms.author: anaharris
author: anaharris-ms
ms.date: 11/21/2022
---

# Tutorial: Deploy Always On VPN

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10, Windows 11

In this tutorial, you'll learn how to deploy Always On VPN (AOV) connections for Windows client computers that are working offsite (for example, from home, a customer site, or a public wireless access point).
In this deployment you'll configure Remote Access as a single tenant VPN RAS Gateway for point-to-site VPN connections. You also find instructions for modifying some of your existing infrastructure for the deployment.

## Prerequisites

In order to follow and implement the steps in this tutorial, make sure that:

- You have membership in the Windows Administrators group, or equivalent.
<!-- Editorial note: What is CSP-->
- You've installed the management platform of your choice for deploying the Always On VPN configuration because the CSP is not vendor-specific.

### Servers

You'll also need to setup the following Windows servers (all versions are supported):

- **An NPS (RADIUS) server.** If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than add a new server.
- **A Certification Authority (CA) server**
- **A Remote Access (Routing/VPN) server**. The RAS server must support IKEv2 VPN connections and LAN routing.
<!-- Editorial note: Where does this go? -->
- Physical server or virtual machine (VM) on your perimeter network with two physical Ethernet network adapters to install Remote Access as a RAS Gateway VPN server. VMs require virtual LAN (VLAN) for the host.

### Active Directory domain infrastructure

Your Active Directory domain infrastructure must include:

- A public perimeter (DNS) zone for the perimeter network (for example, contoso.com).  
- A private internal DNS zone for corporate data and applications (for example, corp.contoso.com).
- Active Directory-based public key infrastructure (PKI) and Active Directory Certificate Services (AD CS).

### Firewalls

- Two firewalls around the perimeter network.  Ensure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function properly. For more information on how to configure firewalls for RADIUS traffic, see [Configure firewalls for RADIUS traffic](../../../../networking/technologies/nps/nps-firewalls-configure.md).

<!-- Editorial note: Is this still true? -->
>[!IMPORTANT]
>Don't attempt to deploy Remote Access on a virtual machine (VM) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## Next steps

[Plan the Always On VPN deployment](always-on-vpn-deploy-planning.md): This section will guide you on the next steps to take in preparing your Remote Access Server.
