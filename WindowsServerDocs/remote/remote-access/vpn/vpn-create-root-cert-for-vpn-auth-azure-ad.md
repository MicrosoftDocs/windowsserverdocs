---
title: Create root certificates for VPN authentication with Azure AD
description: 'Azure AD uses the VPN certificate to sign certificates issued to Windows 10 clients when authenticating to Azure AD for VPN connectivity. The certificate marked as Primary is the Issuer that Azure AD uses.'
services: active-directory
ms.prod: windows-server-threshold
ms.technology: networking-ras

ms.workload: identity

ms.topic: article
ms.date: 06/28/2019
ms.author: pashort
author: shortpatti
ms.localizationpriority: medium 
ms.reviewer: deverette
---
# Step 7.2. Create conditional access root certificates for VPN authentication with Azure AD

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 7.1. Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking](vpn-config-eap-tls-to-ignore-crl-checking.md)
- [**Next:** Step 7.3. Configure the Conditional Access policy](vpn-config-conditional-access-policy.md)

In this step, you configure conditional access root certificates for VPN authentication with Azure AD, which automatically creates a Cloud app called VPN Server in the tenant. To configure conditional access for VPN connectivity, you need to:

1. Create a VPN certificate in the Azure portal.
2. Download the VPN certificate.
3. Deploy the certificate to your VPN and NPS servers.

> [!IMPORTANT]
> Once a VPN certificate is created in the Azure portal, Azure AD will start using it immediately to issue short lived certificates to the VPN client. It is critical that the VPN certificate be deployed immediately to the VPN server to avoid any issues with credential validation of the VPN client.

When a user attempts a VPN connection, the VPN client makes a call into the Web Account Manager (WAM) on the Windows 10 client. WAM makes a call to the VPN Server cloud app. When the Conditions and Controls in the Conditional Access policy are satisfied, Azure AD issues a token in the form of a short-lived (1-hour) certificate to the WAM. The WAM places the certificate in the user's certificate store and passes off control to the VPN client.  

The VPN client then sends the certificate issues by Azure AD to the VPN for credential validation.  

> [!NOTE]
> Azure AD uses the most recently created certificate in the VPN connectivity blade as the Issuer.

**Procedure:**

1. Sign in to your [Azure portal](https://portal.azure.com) as a global administrator.
2. On the left menu, click **Azure Active Directory**.
3. On the **Azure Active Directory** page, in the **Manage** section, click **Conditional access**.
4. On the **Conditional access** page, in the **Manage** section, click **VPN connectivity (preview)**.
5. On the **VPN connectivity** page, click **New certificate**.
6. On the **New** page, perform the following steps:
   a. For **Select duration**, select either 1, 2 or 3 years.
   b. Select **Create**.

## Next steps

[Step 7.3. Configure the Conditional Access policy](vpn-config-conditional-access-policy.md): In this step, you configure the conditional access policy for VPN connectivity.
