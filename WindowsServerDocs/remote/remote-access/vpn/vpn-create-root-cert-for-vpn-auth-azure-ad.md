---
title: Create root certificates for VPN authentication with Azure AD
description: 'Azure AD uses the VPN certificate to sign certificates issued to Windows 10 clients when authenticating to Azure AD for VPN connectivity. The certificate marked as **Primary** is the Issuer that Azure AD uses.'
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
ms.reviewer: jairoc
---


# Create root certificates for VPN authentication with Azure AD

In this step, you configure root certificates for VPN authentication with Azure AD. To configure conditional access for VPN connectivity, you need to:

1. Create a VPN certificate in the Azure portal (you can create more than one certificate).
2. Download the VPN certificate.
2. Deploy the certificate to your VPN server.

Azure AD uses the VPN certificate to sign certificates issued to Windows 10 clients when authenticating to Azure AD for VPN connectivity. The certificate marked as **Primary** is the Issuer that Azure AD uses. The token that the Windows 10 client requests are a certificate that it then presents to the application, which in this case is the VPN server.

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

