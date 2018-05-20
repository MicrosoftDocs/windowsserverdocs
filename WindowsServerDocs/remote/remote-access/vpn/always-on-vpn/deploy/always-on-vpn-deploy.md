---
title: Remote Access Always On VPN Deployment Guide for Windows Server and Windows 10
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

# Remote Access Always On VPN Deployment Guide for Windows Server and Windows 10

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#171;  [**Previous:** Remote Access](../../../Remote-Access.md)<br>
&#187; [ **Next:** Review the Always On VPN technology](../always-on-vpn-technology-overview.md)

Always On VPN has many benefits over the Windows VPN solutions of the past. Key improvements in integration, security, connectivity,  networking control, and compatibility align Always On VPN with Microsoft's cloud-first, mobile-first vision.

Because many of the devices that require remote access are personal devices, Always On VPN does not require that a device be domain joined. Always On VPN provides a single, cohesive solution for remote access for all your connected devices going forward, even personally owned devices. Also, organizations can choose which management platform they prefer for deploying the Always On VPN configuration because the CSP is not vendor specific.

## <a name="bkmk_about"></a>About this guide

This guide is designed for deploying Always On VPN with the Remote Access server role on an on\-premises organization network. This guide provides instructions on how to deploy Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections for remote client computers that are running Windows 10. This guide also provides instructions for modifying some of your existing infrastructure for the deployment. You also learn about the VPN connection process, servers to configure, ProfileXML VPNv2 CSP node, and other technologies to deploy Always On VPN.

>[!Important]
>Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).



## <a name="bkmk_prerequisites"></a>Prerequisites for using this guide

This guide provides instructions on how to deploy Remote Access Always On VPN connections for remote client computers that are running Windows 10. Following are the prerequisites for performing the procedures in this guide.

It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network. For more information, see [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

- You must have an Active Directory domain infrastructure, including one or more Domain Name System \(DNS\) servers.
- You must have a Public Key Infrastructure \(PKI\) and Active Directory Certificate Services \(AD CS\).
- You must have a perimeter network that includes two firewalls. For more information, see [Always On VPN Technology Overview](../always-on-vpn-technology-overview.md).
- Remote client computers must be joined to the Active Directory domain.
- Remote client computers must be running the Windows 10 Anniversary Update \(version 1607\) or later operating system.
- You must be prepared to deploy one new physical server or virtual machine \(VM\) on your perimeter network, upon which you will install Remote Access. This server must have two physical Ethernet network adapters.
- You must be prepared to install NPS as a RADIUS server on a server or VM. You can install NPS on a new physical server or on a new VM. If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than adding a new server.
- You must read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.
- You must perform the steps in this guide in the order in which they are presented.

## <a name="bkmk_not"></a>What this guide does not provide

This guide does not provide instructions for deploying the following items.

- Active Directory Domain Services \(AD DS\)
- Active Directory Certificate Services \(AD CS\) and a Public Key Infrastructure \(PKI\).
- Dynamic Host Configuration Protocol \(DHCP\) automatic IP address assignment to computers and other devices that are configured as DHCP clients. 
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity

## Next step
|If you want to...  |Then see...  |
|---------|---------|
|Learn more about the Always On VPN technology     |[Always On VPN Technology Overview](../always-on-vpn-technology-overview.md): This page provies a brief overview of the Always On VPN technologies with links to detailed documents.         |
|Learn more about the Always On VPN advanced features  |[Advance VPN features](always-on-vpn-adv-options.md): This page provides guidance on how to enable VPN Traffic Filters, how to configure Automatic VPN connections using App-Triggers, and how to configure NPS to only allow VPN Connections from clients using certificates issued by Azure AD.         |
|Learn about the feature comparison between Always On VPN and DirectAccess    |[Feature Comparison of Always On VPN and DirectAccess](../../vpn-map-da.md): In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess.         |
|Migrate from DirectAccess to Always On VPN  |[DirectAccess to Always On VPN migration planning](../../../da-always-on-vpn-migration/da-always-on-migration-planning.md): If you are migrating from DirectAccess to Always On VPN, and have successfully deployed Always On VPN, you must properly plan your migration phases, which helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources.         |
|Start planning your Always On VPN deployment |[Plan the Always On VPN deployment](always-on-vpn-deploy-planning.md): Before you install the Remote Access server role on the computer you're planning on using as a VPN server, perform the following tasks. After proper planning, you can deploy Always On VPN, and optionally configure conditional access for VPN connectivity using Azure AD.  |


---
