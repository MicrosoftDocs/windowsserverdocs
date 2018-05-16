---
title: Conditional access for VPN connectivity using Azure AD
description: 'With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect your VPN connections.'
services: active-directory
ms.prod: windows-server-threshold
ms.technology: networking-ras
documentationcenter: ''
ms.assetid: 51a1ee61-3ffe-4f65-b8de-ff21903e1e74
ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/15/2018
ms.author: pashort
author: shortpatti
manager: elizapo
ms.reviewer: jairoc
---

# Conditional access for VPN connectivity using Azure AD

With [Azure Active Directory (Azure AD) conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal), you can fine-tune how authorized users access your resources. With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect your VPN connections.


## Before you begin

This topic assumes that you're familiar with the following topics:

- [Conditional access in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal)
- [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access)


To gain insights on how Microsoft implements this feature, see [Enhancing remote access in Windows 10 with an automatic VPN profile](https://www.microsoft.com/itshowcase/Article/Content/894/Enhancing-remote-access-in-Windows-10-with-an-automatic-VPN-profile).


## Prerequisites

To configure Azure Active Directory conditional access for VPN connectivity, you need to have a VPN server configured.  

## [Step 1: Configure the Always On VPN infrastructure](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/vpn-deploy-server-infrastructure)

In this step, you install and configure the server-side components necessary to support the VPN, including configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server; configuring RRAS to support IKEv2 connections; and configuring the NPS server to perform authorization for the VPN connections.

## [Step 2: Configure the Remote Access Server for Always On VPN](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/vpn-deploy-ras)

In this step, you configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.

## [Step 3: Install and configure the NPS server](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/vpn-deploy-nps)

In this step, you install Network Policy Server (NPS) by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.  You also configure NPS to handle all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server.

To configure NPS, you must perform the following tasks:
- Register the NPS Server in Active Directory
- Configure RADIUS Accounting for your NPS Server
- Add the VPN Server as a RADIUS Client in NPS
- Configure Network Policy in NPS
- Autoenroll the NPS Server certificate

## [Step 4: Configure DNS and Firewall settings](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/vpn-deploy-dns-firewall)

In this step, you configure DNS and Firewall settings. When remote VPN clients connect, they use the same DNS servers that your internal clients use, which allows them to resolve names in the same manner as the rest of your internal workstations. 

## [Step 5: Configure Windows 10 client Always On VPN connections](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/vpn-deploy-client-vpn-connections)

In this step, you configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection. You can use several technologies to configure Windows 10 VPN clients, including Windows PowerShell, System Center Configuration Manager, and Intune. All three require an XML VPN profile to configure the appropriate VPN settings. 

## [Step 6: Remote Access Always On VPN advanced features](https://docs.microsoft.com/en-us/windows-server/remote/remote-access/vpn/always-on-vpn/deploy/always-on-vpn-adv-options)

Beyond the deployment scenario provided in this guide, you can add other advanced VPN features to improve the security and availability of your VPN connection. For example, such components can help ensure that the connecting client is healthy before allowing a connection.








## <a name="config-vpnv2-profiles-on-client"></a>Step 12: 


