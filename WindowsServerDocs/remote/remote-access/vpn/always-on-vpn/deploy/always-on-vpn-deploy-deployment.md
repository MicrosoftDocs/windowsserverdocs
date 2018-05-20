---
title: Remote Access Always On VPN Deployment
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking-ras
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
manager: elizapo
ms.date: 05/21/2018
ms.author: pashort
author: shortpatti
---

# Deploy Always On VPN

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

&#0171; [ **Previous:** Remote Access Always On VPN Deployment Planning](always-on-vpn-deploy-planning.md)<br>
&#0187; [ **Next:** Step 1. Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md)


In this section you deploy Always On VPN connections for remote Windows 10 client computers that are domain-joined. You learn how to configure conditional access for VPN connectivity using Azure Active Directory. For more details about conditional access using Azure AD, see [Conditional access for VPN connectivity using Azure AD](../../ad-ca-vpn-connectivity-windows10.md). 

Additionally, if you are migrating from DirectAccess to Always On VPN, you must properly plan the migration to determine your migration phases. Planning for the migration helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. For more details, see [DirectAccess to Always On VPN migration overview](../../../da-always-on-vpn-migration/da-always-on-migration-overview.md).

The following diagram illustrates the workflow process for the different scenarios when deploying Always On VPN. Click image to enlarge.

<a href="../../../../media/Always-On-Vpn/always-on-vpn-deployment-workflow.png" alt="Full-sized view of the Always On VPN deployment workflow" target="_blank">![thumbnail](../../../../media/Always-On-Vpn/always-on-vpn-deployment-workflow-sm.png)
</a> 

>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

## [Step 1. Configure the Always On VPN Server Infrastructure](vpn-deploy-server-infrastructure.md)

In this step, you install and configure the server-side components necessary to support the VPN, including configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server; configuring RRAS to support IKEv2 connections; and configuring the NPS server to perform authorization for the VPN connections.

To configure the server infrastructure, you must perform the following tasks:
- **On a server configured with Active Directory Domain Services:** Enable certificate autoenrollment in Group Policy for both computers and users, create the VPN Users Group, the VPN Servers Group, and the NPS Servers Group, and add members to each group.
- **On an Active Directory Certificate Server CA:** Create the User Authentication, VPN Server Authentication, and NPS Server Authentication certificate templates.
- **On domain-joined Windows 10 clients:** Enroll and validate user certificates.

## [Step 2. Configure the Remote Access Server for Always On VPN](vpn-deploy-ras.md)

In this step, you configure Remote Access VPN to allow IKEv2 VPN connections, deny connections from other VPN protocols, and assign a static IP address pool for issuance of IP addresses to connecting authorized VPN clients.

To configure RAS, you must perform the following tasks:
- Enroll and validate the VPN server certificate
- Install and configure Remote Access VPN

## [Step 3. Install and Configure the NPS Server](vpn-deploy-nps.md)

In this step, you install Network Policy Server (NPS) by using either Windows PowerShell or the Server Manager Add Roles and Features Wizard.  You also configure NPS to handle all authentication, authorization, and accounting duties for connection requests that it receives from the VPN server.

To configure NPS, you must perform the following tasks:
- Register the NPS Server in Active Directory
- Configure RADIUS Accounting for your NPS Server
- Add the VPN Server as a RADIUS Client in NPS
- Configure Network Policy in NPS
- Autoenroll the NPS Server certificate

## [Step 4. Configure DNS and Firewall Settings for Always On VPN](vpn-deploy-dns-firewall.md)

In this step, you configure DNS and Firewall settings. When remote VPN clients connect, they use the same DNS servers that your internal clients use, which allows them to resolve names in the same manner as the rest of your internal workstations. 

## [Step 5. Configure Windows 10 Client Always On VPN Connections](vpn-deploy-client-vpn-connections.md)

In this step, you configure the Windows 10 client computers to communicate with that infrastructure with a VPN connection. You can use several technologies to configure Windows 10 VPN clients, including Windows PowerShell, System Center Configuration Manager, and Intune. All three require an XML VPN profile to configure the appropriate VPN settings. 

## [Step 6. (Optional) Configure conditional access for VPN connectivity](../../ad-ca-vpn-connectivity-windows10.md) 
In this optional step, you can fine-tune how authorized VPN users access your resources. With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect the VPN connections. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application. For more details, see [Azure Active Directory (Azure AD) conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal).


## Next step
[Step 1. Configure the Always On VPN Server Infrastructure](vpn-deploy-server-infrastructure.md): In this step, you install and configure the server-side components necessary to support the VPN, including configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server; configuring RRAS to support IKEv2 connections; and configuring the NPS server to perform authorization for the VPN connections.

---