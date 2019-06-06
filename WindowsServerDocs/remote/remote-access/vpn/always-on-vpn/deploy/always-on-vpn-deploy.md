---
title: Always On VPN Deployment for Windows Server and Windows 10
description: You can use this deployment to deploy Always On Virtual Private Network (VPN) connections for remote employees by using Remote Access in Windows Server 2016 or later and Always On VPN profiles for Windows 10 client computers.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
ms.localizationpriority: medium 
ms.date: 12/20/2018
ms.author: pashort
author: shortpatti
---

# Always On VPN deployment for Windows Server and Windows 10

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Remote Access](../../../Remote-Access.md)<br>
- [**Next:** Learn about the Always On VPN features and functionality](../../vpn-map-da.md)

Always On VPN provides a single, cohesive solution for remote access and supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices, even personally owned devices. With Always On VPN, the connection type does not have to be exclusively user or device but can be a combination of both. For example, you could enable device authentication for remote device management, and then enable user authentication for connectivity to internal company sites and services.

## Prerequisites

You most likely have the technologies deployed that you can use to deploy Always On VPN. Other than your DC/DNS servers, the Always On VPN deployment requires an NPS (RADIUS) server, a Certification Authority (CA) server, and a Remote Access (Routing/VPN) server. Once the infrastructure is set up, you must enroll clients and then connect the clients to your on-premises securely through several network changes.

- Active Directory domain infrastructure, including one or more Domain Name System (DNS) servers. Both internal and external Domain Name System (DNS) zones are required, which assumes that the internal zone is a delegated subdomain of the external zone (for example, corp.contoso.com and contoso.com).
- Active Directory-based public key infrastructure (PKI) and Active Directory Certificate Services (AD CS).
- Server, either virtual or physical, existing or new, to install Network Policy Server (NPS). If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than add a new server.
- Remote Access as a RAS Gateway VPN server with a small subset of features supporting IKEv2 VPN connections and LAN routing.
- Perimeter network that includes two firewalls.  Ensure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function properly. For more information, see [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).
- Physical server or virtual machine (VM) on your perimeter network with two physical Ethernet network adapters to install Remote Access as a RAS Gateway VPN server. VMs require virtual LAN (VLAN) for the host. 
- Membership in Administrators, or equivalent, is the minimum required.
- Read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.
- Review the design and deployment guides for each of the technologies used. These guides can help you determine whether the deployment scenarios provide the services and configuration that you need for your organization's network. For more information, see [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).
- Management platform of your choice for deploying the Always On VPN configuration because the CSP is not vendor-specific.

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.
>
>Do not attempt to deploy Remote Access on a virtual machine (VM) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

## About this deployment

The instructions provided walk you through deploying Remote Access as a single tenant VPN RAS Gateway for point-to-site VPN connections, using any of the scenarios mentioned below, for remote client computers that are running Windows 10. You also find instructions for modifying some of your existing infrastructure for the deployment. Also throughout this deployment, you find links to help you learn more about the VPN connection process, servers to configure, ProfileXML VPNv2 CSP node, and other technologies to deploy Always On VPN.

**Always On VPN deployment scenarios:**

1. Deploy Always On VPN only.
2. Deploy Always On VPN with conditional access for VPN connectivity using Azure AD.

For more information and workflow of the scenarios presented, see [Deploy Always On VPN](always-on-vpn-deploy-deployment.md).

## What isn't provided in this deployment

This deployment does not provide instructions for:

- Active Directory Domain Services (AD DS).
- Active Directory Certificate Services (AD CS) and a Public Key Infrastructure (PKI).
- Dynamic Host Configuration Protocol (DHCP).
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity or Conditional Access for Internet connectivity using Azure AD. For details, see [Conditional access in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal).

## Next steps

- [Learn more about the Always On VPN features and functionality](../../vpn-map-da.md)

- [Learn more about the Always On VPN enhancements](../always-on-vpn-enhancements.md)

- [Learn about some of the advanced Always On VPN features](always-on-vpn-adv-options.md)

- [Learn more about the Always On VPN technology](../always-on-vpn-technology-overview.md)

- [Start planning your Always On VPN deployment](always-on-vpn-deploy-deployment.md)