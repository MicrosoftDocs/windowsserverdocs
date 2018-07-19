---
title: Always On VPN Deployment for Windows Server and Windows 10
description: You can use this deployment to deploy Always On Virtual Private Network (VPN) connections for remote employees by using Remote Access in Windows Server 2016 or later and Always On VPN profiles for Windows 10 client computers.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: elizapo
ms.date: 07/16/2018
ms.author: pashort
author: shortpatti
---

# Always On VPN deployment for Windows Server and Windows 10

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#171;  [**Previous:** Remote Access](../../../Remote-Access.md)<br>
&#187; [**Next:** Learn about the Always On VPN and DirectAccess feature comparison](../../vpn-map-da.md)


Always On VPN provides a single, cohesive solution for remote access and supports domain-joined, nondomain-joined (workgroup), or Azure AD–joined devices, even personally owned devices.  With Always On VPN, the connection type does not have to be exclusively user or device but can be a combination of both. For example, you could enable device authentication for remote device management, and then enable user authentication for connectivity to internal company sites and services.



## Prerequisites

You most likely have the technologies deployed that you can use to deploy Always On VPN. Other than your DC/DNS servers, the Always On VPN deployment requires an NPS (RADIUS) server, a Certification Authority (CA) server, and a Remote Access (Routing/VPN) server. Once the infrastructure is set up, you must enroll clients and then connect the clients to your on-premises securely through several network changes.

- Active Directory domain infrastructure, including one or more Domain Name System (DNS) servers. Both internal and external Domain Name System (DNS) zones are required, which assumes that the internal zone is a delegated subdomain of the external zone (for example, corp.contoso.com and contoso.com).
- Active Directory-based public key infrastructure (PKI) and Active Directory Certificate Services (AD CS).
- Physical server, either existing or new, to install Network Policy Server (NPS). If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than add a new server.
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
>Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).


## <a name="bkmk_about"></a>About this deployment

The instructions provided walk you through deploying Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections, using any of the four scenarios mentioned below, for remote client computers that are running Windows 10. You also find instructions for modifying some of your existing infrastructure for the deployment. Also throughout this deployment, you find links to help you learn more about the VPN connection process, servers to configure, ProfileXML VPNv2 CSP node, and other technologies to deploy Always On VPN.

**Always On VPN deployment scenarios:**

1. Deploy Always On VPN only.
2. Deploy Always On VPN with conditional access for VPN connectivity using Azure AD.
3. Deploy Always On VPN and migrate from DirectAccess.
4. Deploy Always On VPN with conditional access for VPN connectivity using Azure AD and migrate from DirectAccess.

For more information and workflow of the scenarios presented, see [Deploy Always On VPN](always-on-vpn-deploy-deployment.md).




## <a name="bkmk_not"></a>What is not provided in this deployment

This deployment does not provide instructions for:

- Active Directory Domain Services \(AD DS\).
- Active Directory Certificate Services \(AD CS\) and a Public Key Infrastructure \(PKI\).
- Dynamic Host Configuration Protocol \(DHCP\). 
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity or Conditional Access for Internet connectivity using Azure AD. For details, see [Conditional access in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal).




## Next step
|If you want to...  |Then see...  |
|---------|---------|
|Learn about the feature comparison between Always On VPN and DirectAccess    |[Feature Comparison of Always On VPN and DirectAccess](../../vpn-map-da.md): In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess.         |
|Learn about the Always On VPN feature enhancements |[Always On VPN enhancements](../always-on-vpn-enhancements.md): Discover new or improved features that Always On VPN offers to improve your configuration. |
|Learn more about the Always On VPN technology     |[Always On VPN Technology Overview](../always-on-vpn-technology-overview.md): This page provides a brief overview of the Always On VPN technologies with links to detailed documents.         |
|Learn more about the Always On VPN advanced features  |[Advanced VPN features](always-on-vpn-adv-options.md): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.         |
|Migrate from DirectAccess to Always On VPN  |[DirectAccess to Always On VPN migration planning](../../../da-always-on-vpn-migration/da-always-on-migration-planning.md): If you are migrating from DirectAccess to Always On VPN, you must properly plan your migration phases before deploying Always On VPN.  Planning your migration phases helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources.         |
|Start planning your Always On VPN deployment |[Plan the Always On VPN deployment](always-on-vpn-deploy-deployment.md): Learn about the workflow for deploying Always On VPN connections for Windows 10 client computers.  |


---
