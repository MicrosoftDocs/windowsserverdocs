---
title: Conditional access for VPN connectivity using Azure AD
description: In this optional step, you can fine-tune how authorized VPN users access your resources using Azure Active Directory (Azure AD) conditional access.
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article

ms.localizationpriority: medium 
ms.author: lizross
author: eross-msft
ms.date: 06/28/2019
ms.reviewer: deverette
---
# Step 7. (Optional) Conditional access for VPN connectivity using Azure AD

- [**Previous:** Step 6. Configure Windows 10 Client Always On VPN Connections](always-on-vpn/deploy/vpn-deploy-client-vpn-connections.md)
- [**Next:** Step 7.1. Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking](vpn-config-eap-tls-to-ignore-crl-checking.md)

In this optional step, you can fine-tune how VPN users access your resources using [Azure Active Directory (Azure AD) conditional access](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal). With Azure AD conditional access for virtual private network (VPN) connectivity, you can help protect the VPN connections. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application.

## Prerequisites

You are familiar with the following topics:

- [Conditional access in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal)
- [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access)

To configure Azure Active Directory conditional access for VPN connectivity, you need to have the following configured:

- [Server Infrastructure](always-on-vpn/deploy/vpn-deploy-server-infrastructure.md)
- [Remote Access Server for Always On VPN](always-on-vpn/deploy/vpn-deploy-ras.md)
- [Network Policy Server](always-on-vpn/deploy/vpn-deploy-nps.md)
- [DNS and Firewall Settings](always-on-vpn/deploy/vpn-deploy-dns-firewall.md)
- [Windows 10 Client Always On VPN Connections](always-on-vpn/deploy/vpn-deploy-client-vpn-connections.md)

## [Step 7.1. Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking](vpn-config-eap-tls-to-ignore-crl-checking.md)

In this step, you can add **IgnoreNoRevocationCheck** and set it to allow authentication of clients when the certificate does not include CRL distribution points. By default, IgnoreNoRevocationCheck is set to 0 (disabled).

An EAP-TLS client cannot connect unless the NPS server completes a revocation check of the certificate chain (including the root certificate). Cloud certificates issued to the user by Azure AD do not have a CRL because they are short-lived certificates with a lifetime of one hour. EAP on NPS needs to be configured to ignore the absence of a CRL. Since the authentication method is EAP-TLS, this registry value is only needed under **EAP\13**. If other EAP authentication methods are used, then the registry value should be added under those as well.

## [Step 7.2. Create root certificates for VPN authentication with Azure AD](vpn-create-root-cert-for-vpn-auth-azure-ad.md)

In this step, you configure root certificates for VPN authentication with Azure AD, which automatically creates a VPN server cloud app in the tenant.  

To configure conditional access for VPN connectivity, you need to:

1. Create a VPN certificate in the Azure portal.
2. Download the VPN certificate.
3. Deploy the certificate to your VPN server.

> [!IMPORTANT]
> Once a VPN certificate is created in the Azure portal, Azure AD will start using it immediately to issue short lived certificates to the VPN client. It is critical that the VPN certificate be deployed immediately to the VPN server to avoid any issues with credential validation of the VPN client.

## [Step 7.3. Configure the Conditional Access policy](vpn-config-conditional-access-policy.md)

In this step, you configure the conditional access policy for VPN connectivity.

To configure the conditional access policy, you need to:

1. Create a Conditional Access policy that is assigned to VPN users.
2. Set the Cloud app to **VPN Server**.
3. Set the Grant (access control) to **Require multi-factor authentication**.  You can use other controls as necessary.

## [Step 7.4. Deploy conditional access root certificates to on-premises AD](vpn-deploy-cond-access-root-cert-to-on-premise-ad.md)

In this step, you deploy a trusted root certificate for VPN authentication to your on-premises AD.

To deploy the trusted root certificate, you need to:

1. Add the downloaded certificate as a *trusted root CA for VPN authentication*.
2. Import the root certificate to the VPN server and VPN client.
3. Verify that the certificates are present and show as trusted.

## [Step 7.5. Create OMA-DM based VPNv2 Profiles to Windows 10 devices](vpn-create-oma-dm-based-vpnv2-profiles.md)

In this step, you can create OMA-DM based VPNv2 profiles using Intune to deploy a VPN Device Configuration policy. If you want to use Configuration Manager or PowerShell Script to create VPNv2 profiles, see [VPNv2 CSP settings](https://docs.microsoft.com/windows/client-management/mdm/vpnv2-csp) for more details.

## Next steps

[Step 7.1. Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking](vpn-config-eap-tls-to-ignore-crl-checking.md): In this step, you must add **IgnoreNoRevocationCheck** and set it to allow authentication of clients when the certificate does not include CRL distribution points. By default, IgnoreNoRevocationCheck is set to 0 (disabled).

## Related topics

- [Configure VPNv2 Profiles](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access): The VPN client is now able to integrate with the cloud-based Conditional Access Platform to provide a device compliance option for remote clients. In this step, you configure the VPNv2 profiles with **\<DeviceCompliance> \<Enabled>true\</Enabled>**.

- [Enhancing remote access in Windows 10 with an automatic VPN profile](https://www.microsoft.com/itshowcase/Article/Content/894/Enhancing-remote-access-in-Windows-10-with-an-automatic-VPN-profile): Learn how Microsoft implements Conditional Access for VPN connectivity. VPN profiles contain all the information a device requires to connect to the corporate network, including the authentication methods that are supported and the VPN server that the device should connect to. Changes in Windows 10 Anniversary Update, including Conditional Access and single sign-on, made it possible for us to create our Always-On VPN connection profile.

- [Conditional access in Azure Active Directory](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal): Security is a top concern for organizations using the cloud. A key aspect of cloud security is identity and access when it comes to managing your cloud resources. In a mobile-first, cloud-first world, users can access your organization's resources using a variety of devices and apps from anywhere. As a result of this, just focusing on who can access a resource is not sufficient anymore. In order to master the balance between security and productivity, IT professionals also need to factor how a resource is being accessed into an access control decision.

- [VPN and conditional access](https://docs.microsoft.com/windows/access-protection/vpn/vpn-conditional-access): The VPN client is now able to integrate with the cloud-based Conditional Access Platform to provide a device compliance option for remote clients. Conditional Access is a policy-based evaluation engine that lets you create access rules for any Azure Active Directory (Azure AD) connected application.
