---
title: Remote Access Always On VPN Deployment
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
manager: brianlic
ms.author: pashort
author: shortpatti
---

# Remote Access Always On VPN Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

You can use the following sections to deploy Always On VPN connections for remote Windows 10 client computers that are joined to your domain.

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

## [Configure the Always On VPN Server Infrastructure](vpn-deploy-server-infrastructure.md)

You can use this topic to complete the following steps.

- On a server configured with Active Directory Domain Services: Enable certificate autoenrollment in Group Policy for both computers and users, create the VPN Users Group, the VPN Servers Group, and the NPS Servers Group, and add members to each group.
- On an Active Directory Certificate Server CA: Create the User Authentication, VPN Server Authentication, and NPS Server Authentication certificate templates.
- On domain-joined Windows 10 clients: Enroll and validate user certificates.

## [Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md)

You can use this topic to complete the following steps.

- Enroll and validate the VPN server certificate
- Install and configure Remote Access VPN

## [Install and Configure the NPS Server](vpn-deploy-nps.md)

You can use this topic to complete the following steps.

- Install and configure your organization NPS server as a RADIUS server.
- Enroll and validate the NPS server certificate

## [Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md)

You can use this topic to complete the following steps.

- Configure DNS, Internal Perimeter Network Firewall, and Edge Firewall settings.

## [Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md)

You can use this topic to complete the following steps.

- Configure the Remote Access Always On VPN client by using Windows PowerShell, Microsoft System Center Configuration Manager, or Intune.


For the next section in this guide, see [Configure the Always On VPN Server Infrastructure](vpn-deploy-server-infrastructure.md).
