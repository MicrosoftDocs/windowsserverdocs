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

# Deploy Always On VPN Connections

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

Always On VPN requires a specific process to deploy to Always On VPN connections for remote Windows 10 client computers that are domain joined. At a high level, the deployment process consists of these four primary steps:

1. **[Configure the Always On VPN Server Infrastructure](vpn-deploy-server-infrastructure.md)**. 
    a. AD DS: Enable certificate autoenrollment in Group Policy for both computers and users, create the VPN Users Group, the VPN Servers Group, and the NPS Servers Group, and add members to each group.
    b. AD CS: Create the User Authentication, VPN Server Authentication, and NPS Server Authentication certificate templates.
    c. Domain-joined Windows 10 client: Enroll and validate user certificates.
2. **[Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md)**. 
    a. Enroll and validate the VPN server certificate.
    b. Install and configure Remote Access VPN.
3. **[Install and Configure the NPS Server](vpn-deploy-nps.md)**. 
    a. Install and configure your organization NPS as a RADIUS server.
    b. Enroll and validate the NPS certificate.
4. **[Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md)**. Configure DNS, Internal Perimeter Network Firewall, and Edge Firewall settings.
5. **[Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md)**. Configure the Remote Access Always On VPN client by using Windows PowerShell, Microsoft System Center Configuration Manager, or Intune.

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

## Next steps
**[Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md)