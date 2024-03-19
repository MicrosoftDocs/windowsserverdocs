---
title: Virtual Private Networking (VPN)
description: Learn how you can use RAS Gateway as a single-tenant VPN server.
ms.topic: article
ms.assetid: cd4908f0-0d6f-4c02-8f98-4dc88c3dcb65
ms.date: 11/05/2018
ms.author: jgerend
author: JasonGerend
---

# Virtual Private Networking (VPN)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 10

## RAS Gateway as a Single Tenant VPN Server

In Windows Server 2016, the Remote Access server role is a logical grouping of the following related network access technologies.

- Remote Access Service (RAS)
- Routing
- Web Application Proxy

These technologies are the role services of the Remote Access server role.

When you install the Remote Access server role with the Add Roles and Features Wizard or Windows PowerShell, you can install one or more of these three role services.

When you install the **DirectAccess and VPN (RAS)** role service, you are deploying the Remote Access Service Gateway (**RAS Gateway**). You can deploy RAS Gateway as a single tenant RAS Gateway virtual private network (VPN) server that provides many advanced features and enhanced functionality.

>[!NOTE]
>You can also deploy RAS Gateway as a Multitenant VPN server for use with Software Defined Networking (SDN), or as a DirectAccess server. For more information, see [RAS Gateway](../ras-gateway/ras-gateway.md), [Software Defined Networking (SDN)](/azure-stack/hci/concepts/software-defined-networking), and [DirectAccess](../directaccess/directaccess.md).

## Related topics
- [Always On VPN features and functionality](vpn-map-da.md): In this topic, you learn about the features and functionality of Always On VPN.

- [Configure VPN Device Tunnels in Windows 10](vpn-device-tunnel-config.md): Always On VPN gives you the ability to create a dedicated VPN profile for device or machine. Always On VPN connections include two types of tunnels: _device tunnel_ and _user tunnel_. Device tunnel is used for pre-logon connectivity scenarios and device management purposes. User tunnel allows users to access organization resources through VPN servers.

- [Always On VPN Deployment for Windows Server 2016 and Windows 10](always-on-vpn/deploy/always-on-vpn-deploy-deployment.md): Provides instructions on deploying Remote Access as a single tenant VPN RAS Gateway for point-to-site VPN connections that allow your remote employees to connect to your organization network with Always On VPN connections. It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment.

- [Windows 10 VPN Technical Guide](/windows/access-protection/vpn/vpn-guide): Walks you through the decisions you will make for Windows 10 clients in your enterprise VPN solution and how to configure your deployment. You can find references to the VPNv2 Configuration Service Provider (CSP) and provides mobile device management (MDM) configuration instructions using Microsoft Intune and the VPN Profile template for Windows 10.

- [How to Create VPN profiles in Configuration Manager](/configmgr/protect/deploy-use/create-vpn-profiles): In this topic, you learn how to create VPN profiles in Configuration Manager.

- [Configure Windows 10 Client Always On VPN Connections](./always-on-vpn/deploy/vpn-deploy-client-vpn-connections.md): This topic describes the ProfileXML options and schema, and how to create the ProfileXML VPN. After setting up the server infrastructure, you must configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection.

- [VPN profile options](/windows/access-protection/vpn/vpn-profile-options): This topic describes the VPN profile settings in Windows 10 and learn how to configure VPN profiles using Intune or Configuration Manager. You can configure all VPN settings in Windows 10 using the ProfileXML node in the VPNv2 CSP.
