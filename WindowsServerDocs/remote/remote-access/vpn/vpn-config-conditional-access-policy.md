---
title: Configure the Conditional Access policy
description: After a root certificate has been created, the 'VPN connectivity' triggers the creation of the 'VPN Server' cloud application in the customer's tenant.
services: active-directory
ms.prod: windows-server
ms.technology: networking-ras
documentationcenter: ''
ms.assetid: 
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 05/25/2018
ms.author: lizross
author: eross-msft
ms.localizationpriority: medium 
ms.reviewer: deverette
---


# Step 7.3. Configure the conditional access policy

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 7.2. Create root certificates for VPN authentication with Azure AD](vpn-create-root-cert-for-vpn-auth-azure-ad.md)
- [**Next:** Step 7.4. Deploy conditional access root certificates to on-premises AD](vpn-deploy-cond-access-root-cert-to-on-premise-ad.md)

In this step, you configure the conditional access policy for VPN connectivity. When the first root certificate is created in the 'VPN connectivity' blade, it automatically creates a 'VPN Server' cloud application in the tenant.

Create a Conditional Access policy that is assigned to VPN users group and scope the **Cloud app** to **VPN Server**:

- **Users**: VPN Users
- **Cloud App**: VPN Server
- **Grant (access control)**: 'Require multi-factor authentication'. Other controls can be used if desired.

**Procedure:**
This step covers creation of the most basic Conditional Access policy.  If desired, additional Conditions and Controls can be used.


1. On the **Conditional Access** page, in the toolbar on the top, select **Add**.

    ![Select add on conditional access page](../../media/Always-On-Vpn/07.png)

2. On the **New** page, in the **Name** box, enter a name for your policy. For example, enter **VPN policy**.

    ![Add name for policy on conditional access page](../../media/Always-On-Vpn/08.png)

3. In the **Assignment** section, select **Users and groups**.

    ![Select users and groups](../../media/Always-On-Vpn/09.png)

4. On the **Users and groups** page, perform the following steps:

    ![Select test user](../../media/Always-On-Vpn/10.png)

    a. Select **Select users and groups**.

    b. Select **Select**.

    c. On the **Select** page, select the **VPN users** group, and then select **Select**.

    d. On the **Users and groups** page, select **Done**.

5. On the **New** page, perform the following steps:

    ![Select cloud apps](../../media/Always-On-Vpn/11.png)

    a. In the **Assignments** section, select **Cloud apps**.

    b. On the **Cloud apps** page, select **Select apps**.

    d. Select **VPN Server**.

6.  On the **New** page, to open the **Grant** page, in the **Controls** section, select **Grant**.

    ![Select grant](../../media/Always-On-Vpn/13.png)

7.  On the **Grant** page, perform the following steps:

    ![Select require multi-factor authentication](../../media/Always-On-Vpn/14.png)

    a. Select **Require multi-factor authentication**.

    b. Select **Select**.

8.  On the **New** page, under **Enable policy**, select **On**.

    ![Enable policy](../../media/Always-On-Vpn/15.png)

9.  On the **New** page, select **Create**.


## Next steps
[Step 7.4. Deploy conditional access root certificates to on-premises AD](vpn-deploy-cond-access-root-cert-to-on-premise-ad.md): In this step, you deploy the conditional access root certificate as trusted root certificate for VPN authentication to your on-premises AD.
