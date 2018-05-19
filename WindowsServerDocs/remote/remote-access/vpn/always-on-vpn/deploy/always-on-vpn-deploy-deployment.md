---
title: Remote Access Always On VPN Deployment
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
manager: elizapo
ms.date: 05/21/2018
ms.author: pashort
author: shortpatti
---

# Remote Access Always On VPN Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

[&#0171; Previous: Remote Access Always On VPN Deployment Planning](always-on-vpn-deploy-planning.md)<br>
[&#0187; Next: Step 1. Configure the Server Infrastructure](vpn-deploy-server-infrastructure.md)


In this section you learn how to deploy Always On VPN connections for remote Windows 10 client computers that are domain-joined. You can also learn how to configure conditional access for VPN connectivity using Azure Active Directory. For more details about conditional access using Azure AD, see [Conditional access for VPN connectivity using Azure AD](../../ad-ca-vpn-connectivity-windows10.md).

This workflow illustrates the workflow process for the different scenarios when deploying Always On VPN. 
![Full-sized view of the Always On VPN deployment workflow](../../../../media/Always-On-Vpn/always-on-vpn-deployment-workflow-sm.png)<br>
[Click to enlarge image](img-always-on-vpn-deploy-workflow.md)

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

## Related topics
- [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access): This topic provides an overview of the Remote Access server role in Windows Server 2016.

- [Windows 10 VPN Technical Guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide): This guide walks you through the decisions you will make for Windows 10 clients in your enterprise VPN solution and how to configure your deployment. This guide references the VPNv2 Configuration Service Provider (CSP) and provides mobile device management (MDM) configuration instructions using Microsoft Intune and the VPN Profile template for Windows 10.

- [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide): This guide provides instructions on how to plan and deploy the core components required for a fully functioning network and a new Active Directory domain in a new forest.

- [Domain Name System (DNS)](https://docs.microsoft.com/windows-server/networking/dns/dns-top): This topic provides an overview of Domain Name Systems (DNS). In Windows Server 2016, DNS is a server role that you can install by using Server Manager or Windows PowerShell commands. If you are installing a new Active Directory forest and domain, DNS is automatically installed with Active Directory as the Global Catalogue server for the forest and domain. 

- [Active Directory Certificate Services Overview](https://technet.microsoft.com/library/hh831740.aspx): This document provides an overview of Active Directory Certificate Services (AD CS) in Windows Server® 2012. AD CS is the Server Role that allows you to build a public key infrastructure (PKI) and provide public key cryptography, digital certificates, and digital signature capabilities for your organization.

- [Public Key Infrastructure Design Guidance](https://social.technet.microsoft.com/wiki/contents/articles/2901.public-key-infrastructure-design-guidance.aspx):  This wiki provides guidance on designing Public Key Infrastructures (PKIs). Before you configure a PKI and certification authority (CA) hierarchy, you should be aware of your organization's security policy and certificate practice statement (CPS).

- [AD CS Step by Step Guide: Two Tier PKI Hierarchy Deployment](https://social.technet.microsoft.com/wiki/contents/articles/15037.ad-cs-step-by-step-guide-two-tier-pki-hierarchy-deployment.aspx): This step-by-step guide describes the steps needed to set up a basic configuration of Active Directory® Certificate Services (AD CS) in a lab environment. AD CS in Windows Server® 2008 R2 provides customizable services for creating and managing public key certificates used in software security systems employing public key technologies.

- [Network Policy Server (NPS)](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-top): This topic provides an overview of Network Policy Server in Windows Server 2016. Network Policy Server (NPS) allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. 

---