---
title: Create root certificates for VPN authentication with Azure AD
description: 'Azure AD uses the VPN certificate to sign certificates issued to Windows 10 clients when authenticating to Azure AD for VPN connectivity. The certificate marked as Primary is the Issuer that Azure AD uses.'
services: active-directory
ms.prod: windows-server-threshold
ms.technology: networking-ras
documentationcenter: ''
ms.assetid: 
ms.service: active-directory
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/15/2018
ms.author: pashort
author: shortpatti
manager: elizapo
ms.reviewer: deverette
---


# Step 6.2. Create root certificates for VPN authentication with Azure AD

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

[&#171; Previous: Step 6.1. Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking](vpn-config-eap-tls-to-ignore-crl-checking.md)<br>
[&#187; Next: Step 6.3. Configure the Conditional Access policy](vpn-config-conditional-access-policy.md)

In this step, you configure root certificates for VPN authentication with Azure AD, which automatically creates a Cloud app called VPN server in the tenant. To configure conditional access for VPN connectivity, you need to:

1. Create a VPN certificate in the Azure portal (you can create more than one certificate).
2. Download the VPN certificate.
2. Deploy the certificate to your VPN server.

When a user attempts a VPN connection, the VPN client makes a call into the Web Account Manager (WAM) on the Windows 10 client. WAM makes a call to the VPN Server cloud app. When the Conditions and Controls in the Conditional Access policy are satisfied, Azure AD issues a token in the form of a short-lived (1-hour0) certificate to the WAM. The WAM places the certificate in the user's certificate store and passes off control to the VPN client.  The VPN client then send the certificate issues by Azure AD to the VPN for credential validation.  Azure AD uses the certificate that is marked as **Primary** in the VPN connectivity blade as the Issuer. is issued by Azure AD is a short-lived certificate which the VPN client presents to the VPN server.

In the Azure portal, you can create two certificates to manage the transition when one certificate is about to expire. When you create a certificate, you can choose whether it is the primary certificate, which is used during the authentication to sign the certificate for the connection.

**Procedure:**

1. Sign in to your [Azure portal](https://portal.azure.com) as a global administrator.

2. On the left menu, click **Azure Active Directory**. 

    ![Select Azure Active Directory](../../media/Always-On-Vpn/01.png)

3. On the **Azure Active Directory** page, in the **Manage** section, click **Conditional access**.

    ![Select Conditional access](../../media/Always-On-Vpn/02.png)

4. On the **Conditional access** page, in the **Manage** section, click **VPN connectivity (preview)**.

    ![Select VPN connectivity](../../media/Always-On-Vpn/03.png)

5. On the **VPN connectivity** page, click **New certificate**.

    ![Select new certificate](../../media/Always-On-Vpn/04.png)

6. On the **New** page, perform the following steps:

    ![Select duration and primary](../../media/Always-On-Vpn/05.png)

    a. For **Select duration**, select either 1 or 2 years. You can add up to two certificates to manage transitions when the certificate is about to
        expire. You can choose which one is the primary (the one used during authentication to sign the certificate for connectivity).

    b. For **Primary**, select **Yes**.

    c. Click **Create**.

## Next steps
[Step 6.3. Configure the Conditional Access policy](vpn-config-conditional-access-policy.md): In this step, you configure the conditional access policy for VPN connectivity. 

---