---
title: Always On VPN Deployment Guide for Windows Server and Windows 10
description: You can use this guide to deploy Always On Virtual Private Network (VPN) connections for remote employees by using Remote Access in Windows Server 2016 or later and Always On VPN profiles for Windows 10 client computers.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: elizapo
ms.date: 05/21/2018
ms.author: pashort
author: shortpatti
---

# Always On VPN Deployment Guide for Windows Server and Windows 10

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#171;  [**Previous:** Remote Access](../../../Remote-Access.md)<br>
&#187; [ **Next:** Review the Always On VPN technology](../always-on-vpn-technology-overview.md)

Always On VPN has many benefits over the Windows VPN solutions of the past. Key improvements in integration, security, connectivity, networking control, and compatibility align Always On VPN with Microsoft's cloud-first, mobile-first vision. For details on the improved functionality, see [Always On VPN Advanced Features](../../vpn-map-da.md#improved-functionality). 

Always On VPN provides a single, cohesive solution for remote access for all your connected devices going forward, even personally owned devices. Also, you can choose which management platform they prefer for deploying the Always On VPN configuration because the CSP is not vendor specific. 


## <a name="bkmk_about"></a>About this guide

The instructions in this guide describe how to deploy Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections, using any of the four scenarios mentioned below, for remote client computers that are running Windows 10. You also find in this guide instructions for modifying some of your existing infrastructure for the deployment. Also throughout this guide, you find links to help you learn more about the VPN connection process, servers to configure, ProfileXML VPNv2 CSP node, and other technologies to deploy Always On VPN.

**Always On VPN deployment scenarios:**

1. Deploy Always On VPN only.
2. Deploy Always On VPN with conditional access for VPN connectivity using Azure AD.
3. Deploy Always On VPN and migrate from DirectAccess.
4. Deploy Always On VPN with conditional access for VPN connectivity using Azure AD and migrate from DirectAccess.

For more details about the scenarios presented, see [Deploy Always On VPN](always-on-vpn-deploy-deployment.md).

## <a name="bkmk_not"></a>What this guide does not provide

This guide does not provide instructions for deploying the following items.

- Active Directory Domain Services \(AD DS\).
- Active Directory Certificate Services \(AD CS\) and a Public Key Infrastructure \(PKI\).
- Dynamic Host Configuration Protocol \(DHCP\) automatic IP address assignment to computers and other devices that are configured as DHCP clients. 
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity or Conditional Access for Internet connectivity using Azure AD.

## <a name="bkmk_prerequisites"></a>Prerequisites for using this guide

To deploy Always On VPN successfully, the remote client computers must be joiened to the Active Directory domain and running the Windows 10 Anniversary Update \(version 1607\) or later operating system.  Additionally, you must have:
- An Active Directory domain infrastructure, including one or more Domain Name System \(DNS\) servers.
- A Public Key Infrastructure \(PKI\) and Active Directory Certificate Services \(AD CS\).
- A perimeter network that includes two firewalls. For more information, see [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).
- Read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.
- Physical server or virtual machine \(VPN\) on your perimeter network with two physical Ethernet network adapters to install Remote Access.
- Physical server, existing or new, to install Network Policy Server \(NPS\). If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than adding a new server.

It is recommended that you review the design and deployment guides for each of the technologies that are used in the deployment scenarios. These guides can help you determine whether the deployment scenarios provide the services and configuration that you need for your organization's network. For more information, see [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.
>
>Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).



## Next step
|If you want to...  |Then see...  |
|---------|---------|
|Learn more about the Always On VPN technology     |[Always On VPN Technology Overview](../always-on-vpn-technology-overview.md): This page provies a brief overview of the Always On VPN technologies with links to detailed documents.         |
|Learn more about the Always On VPN advanced features  |[Advance VPN features](always-on-vpn-adv-options.md): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.         |
|Learn about the feature comparison between Always On VPN and DirectAccess    |[Feature Comparison of Always On VPN and DirectAccess](../../vpn-map-da.md): In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess.         |
|Migrate from DirectAccess to Always On VPN  |[DirectAccess to Always On VPN migration planning](../../../da-always-on-vpn-migration/da-always-on-migration-planning.md): If you are migrating from DirectAccess to Always On VPN, you must properly plan your migration phases before deploying Always On VPN.  Planning your migration phases helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources.         |
|Start planning your Always On VPN deployment |[Plan the Always On VPN deployment](always-on-vpn-deploy-planning.md): Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks. After proper planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.  |


---
