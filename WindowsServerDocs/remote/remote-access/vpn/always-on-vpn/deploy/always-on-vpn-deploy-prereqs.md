---
title: Always On VPN Deployment prerequisites
description: You most likely have the technologies deployed that you can use to deploy Always On VPN. Other than your DC/DNS servers, the Always On VPN deployment requires an NPS (RADIUS) server, a Certification Authority (CA) server, and a Remote Access (Routing/VPN) server.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 
manager: elizapo
ms.date: 05/28/2018
ms.author: pashort
author: shortpatti
---

# Always On VPN deployment prerequisites

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#171; [**Previous:** Review the Always On VPN workflow scenarios](always-on-vpn-deploy-deployment.md)<br>
&#187; [**Next:** 1. Migrate from DirectAccess to Always On VPN](../../../da-always-on-vpn-migration/da-always-on-migration-overview.md)<br>
        -OR-<br>
&#187; [**Next:** 2. Start planning your Always On VPN deployment](always-on-vpn-deploy-planning.md)

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
- Remote client computers must be joined to the Active Directory domain and running the Windows 10 Anniversary Update (version 1607) or later operating system.
- Management platform of your choice for deploying the Always On VPN configuration because the CSP is not vendor-specific.


>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.
>
>Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).



## Next step
|If you want to...  |Then see...  |
|---------|---------|
|Migrate from DirectAccess to Always On VPN  |[DirectAccess to Always On VPN migration planning](../../../da-always-on-vpn-migration/da-always-on-migration-planning.md): If you are migrating from DirectAccess to Always On VPN, you must properly plan your migration phases before deploying Always On VPN.  Planning your migration phases helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources.         |
|Start planning your Always On VPN deployment |[Plan the Always On VPN deployment](always-on-vpn-deploy-planning.md): Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks. After proper planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.  |



## Related topics
|If you want to...  |Then see...  |
|---------|---------|
|Learn about the feature comparison between Always On VPN and DirectAccess    |[Feature Comparison of Always On VPN and DirectAccess](../../vpn-map-da.md): In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess.         |
|Learn about the Always On VPN feature enhancements |[Always On VPN enhancements](../always-on-vpn-enhancements.md): Discover new or improved features that Always On VPN offers to improve your configuration. |
|Learn more about the Always On VPN technology     |[Always On VPN Technology Overview](../always-on-vpn-technology-overview.md): This page provides a brief overview of the Always On VPN technologies with links to detailed documents.         |
|Learn more about the Always On VPN advanced features  |[Advanced VPN features](always-on-vpn-adv-options.md): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.         |


---
