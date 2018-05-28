---
title: Always On VPN Deployment for Windows Server and Windows 10
description: You can use this deployment to deploy Always On Virtual Private Network (VPN) connections for remote employees by using Remote Access in Windows Server 2016 or later and Always On VPN profiles for Windows 10 client computers.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: elizapo
ms.date: 05/25/2018
ms.author: pashort
author: shortpatti
---

# Always On VPN Deployment for Windows Server and Windows 10

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#171;  [**Previous:** Remote Access](../../../Remote-Access.md)<br>
&#187; [**Next:** Learn about the feature comparison between Always On VPN and DirectAccess](../../vpn-map-da.md)


Always On VPN provides a single, cohesive solution for remote access for all your connected devices, even personally owned devices. With Always On VPN, the connection type does not have to be exclusively user or device but can be a combination of both. For example, you could enable device authentication for remote device management, and then enable user authentication for connectivity to internal company sites and services.

Always On VPN has many benefits over the Windows VPN solutions of the past. The following key improvements align Always On VPN with Microsoft’s cloud-first, mobile-first vision:

- **Platform Integration:** Always On VPN has improved integration with the Windows operating system and third-party solutions to provide a robust platform for countless advanced connection scenarios.
- **Security:** Always On VPN has new, advanced security capabilities to restrict the type of traffic, which applications can use the VPN connection, and which authentication methods you can use to initiate the connection. When the connection is active most of the time, it is important to secure the connection.
- **VPN Connectivity:** Always On VPN, with or without Device Tunnel, creates a persistent connection by using either user or device authentication. Before Always On VPN, the ability to create a persistent connection through either user or device authentication was not possible. 
- **Networking control:** Always On VPN allows administrators to specify routing policies at a more granular level—even down to the individual application—which is perfect for line-of-business (LOB) apps that require special remote access.  Always On VPN is also fully compatible with both Internet Protocol version 4 (IPv4) and version 6 (IPv6); unlike DirectAccess, there is no specific dependency on IPv6.
- **Configuration and compatibility:** Always On VPN can be deployed and managed several ways that give Always On VPN several advantages over the other VPN client software. 

To learn more about the key improvements, see [Always On VPN enhancements](../always-on-vpn-enhancements.md).

To learn more about the improved functionality over DirectAcsess, see [Always On VPN Advanced Features](../../vpn-map-da.md#improved-functionality). 


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
|Start planning your Always On VPN deployment |[Plan the Always On VPN deployment](always-on-vpn-deploy-planning.md): Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks. After proper planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.  |


---
