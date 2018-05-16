---
title: Remote Access Always On VPN Deployment
description: This topic provides detailed instructions for deploying Always On VPN in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: ad748de2-d175-47bf-b05f-707dc48692cf
manager: elizapo
ms.date: 05/18/2018
ms.author: pashort
author: shortpatti
---

# Remote Access Always On VPN Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

You can deploy Always On VPN connections for remote Windows 10 client computers that are domain-joined.  You can also configure conditional access for VPN connectivity using Azure Active Directory.  For more details, see [Azure Active Directory (Azure AD) conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal).


>[!IMPORTANT]
>For this deployment, it is not a requirement that your infrastructure servers, such as computers running Active Directory Domain Services, Active Directory Certificate Services, and Network Policy Server, are running Windows Server 2016. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running Remote Access.

## [Step 1. Configure the Always On VPN Server Infrastructure](vpn-deploy-server-infrastructure.md)

In this step, you install and configure the server-side components necessary to support the VPN, including configuring PKI to distribute the certificates used by users, the VPN server, and the NPS server; configuring RRAS to support IKEv2 connections; and configuring the NPS server to perform authorization for the VPN connections.

To configure the server infrastructure, you must perform the following tasks:
- On a server configured with Active Directory Domain Services: Enable certificate autoenrollment in Group Policy for both computers and users, create the VPN Users Group, the VPN Servers Group, and the NPS Servers Group, and add members to each group.
- On an Active Directory Certificate Server CA: Create the User Authentication, VPN Server Authentication, and NPS Server Authentication certificate templates.
- On domain-joined Windows 10 clients: Enroll and validate user certificates.

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

## (Optional) Step 6. Conditional access for VPN connectivity using Azure AD 

In this optional step, you can fine-tune how authorized VPN users access your resources. With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect the VPN connections. 


### Prerequisites

You are familiar with the following topics:
- [Conditional access in Azure Active Directory](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal)
- [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access)


To configure Azure Active Directory conditional access for VPN connectivity, you need to have the following configured:
* RRAS, NPS, and VPN server  
* [VPN Profile to use Azure AD Conditional Access](vpn-deploy-client-vpn-connections.md#optional-configure-the-vpn-profile-to-use-azure-ad-conditional-access)

### Step 6.1. [Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking](../../vpn-config-eap-tls-to-ignore-crl-checking.md)
An EAP-TLS client cannot connect unless the NPS server completes a revocation check of the certificate chain (including the root certificate) of the client and verifies that certificates have been revoked. Cloud certificates issued to the user by Azure AD do not have a CRL because they are short-lived certificates with a lifetime of one hour. EAP on NPS needs to be configured to ignore the absence of a CRL. By default, IgnoreNoRevocationCheck is set to 0 (disabled) by default.

Since the authentication method is EAP-TLS, this registry value is only needed under EAP\13. If other EAP authentication methods are used, then the registry value should be added under those as well. 

In this step, you can add IgnoreNoRevocationCheck and set it to allow authentication of clients when the certificate does not include CRL distribution points. 


### Step 6.2. [Create root certificates for VPN authentication with Azure AD](../../vpn-create-root-cert-for-vpn-auth-azure-ad.md)

In this step, you configure root certificates for VPN authentication with Azure AD. 

To configure conditional access for VPN connectivity, you need to:
1. Create a VPN certificate in the Azure portal (you can create more than one certificate).
2. Download the VPN certificate.
3. Deploy the certificate to your VPN server.

### Step 6.3. [Configure the Conditional Access policy](../../vpn-config-conditional-access-policy.md)

In this step, you configure the conditional access policy for VPN connectivity, which triggers the creation of the VPN Server cloud application in the customer's tenant. 

To configure the conditional access policy, you need to:
- Create a Conditional Access policy that is assigned to VPN users.
- Set the Cloud app to **VPN Server**.
- Set the Grant (access control) to **Require multi-factor authentication**.  Other controls can be used if desired.

### Step 6.4. [Deploy conditional access root certificates to on-premises AD](../../vpn-deploy-cond-access-root-cert-to-on-premise-ad.md)




### Step 6.5. [Create OMA-DM based VPNv2 Profiles to Windows 10 devices](../../vpn-create-oma-dm-based-vpnv2-profiles.md)




### Step 6.6 [Configure VPNv2 Profiles](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access)






## Related topics
To gain insights on how Microsoft implements this feature, see [Enhancing remote access in Windows 10 with an automatic VPN profile](https://www.microsoft.com/itshowcase/Article/Content/894/Enhancing-remote-access-in-Windows-10-with-an-automatic-VPN-profile).

For more details, see [Azure Active Directory (Azure AD) conditional access](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-conditional-access-azure-portal).




