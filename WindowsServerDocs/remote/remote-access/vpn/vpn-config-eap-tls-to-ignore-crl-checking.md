---
title: Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking
description: 'An EAP-TLS client cannot connect unless the NPS server completes a revocation check of the certificate chain (including the root certificate) of the client and verifies that certificates have been revoked.'
services: active-directory
ms.prod: windows-server
ms.technology: networking-ras
documentationcenter: ''
ms.assetid: 
ms.workload: identity
ms.tgt_pltfrm: na
ms.devlang: na
ms.topic: article
ms.date: 07/13/2018
ms.author: lizross
author: eross-msft
ms.localizationpriority: medium 
ms.reviewer: deverette
---

# Step 7.1. Configure EAP-TLS to ignore Certificate Revocation List (CRL) checking

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

- [**Previous:** Step 7. (Optional) Conditional access for VPN connectivity using Azure AD](ad-ca-vpn-connectivity-windows10.md)
- [**Next:** Step 7.2. Create root certificates for VPN authentication with Azure AD](vpn-create-root-cert-for-vpn-auth-azure-ad.md)

>[!IMPORTANT]
>Failure to implement this registry change will cause IKEv2 connections using cloud certificates with PEAP to fail, but IKEv2 connections using Client Auth certificates issued from the on-premises CA would continue to work.

In this step, you can add **IgnoreNoRevocationCheck** and set it to allow authentication of clients when the certificate does not include CRL distribution points. By default, IgnoreNoRevocationCheck is set to 0 (disabled).

>[!NOTE]
>If a Windows Routing and Remote Access Server (RRAS) uses NPS to proxy RADIUS calls to a second NPS, then you must set **IgnoreNoRevocationCheck=1** on both servers.

An EAP-TLS client cannot connect unless the NPS server completes a revocation check of the certificate chain (including the root certificate). Cloud certificates issued to the user by Azure AD do not have a CRL because they are short-lived certificates with a lifetime of one hour. EAP on NPS needs to be configured to ignore the absence of a CRL. By default, IgnoreNoRevocationCheck is set to 0 (disabled). Add IgnoreNoRevocationCheck and set it to 1 to allow authentication of clients when the certificate does not include CRL distribution points. 

Since the authentication method is EAP-TLS, this registry value is only needed under EAP\13. If other EAP authentication methods are used, then the registry value should be added under those as well. 

**Procedure**

1. Open **regedit.exe** on the NPS server.

2. Navigate to **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13**.

3. Select **Edit > New** and select **DWORD (32-bit) Value** and enter **IgnoreNoRevocationCheck**.

4. Double-click **IgnoreNoRevocationCheck** and set the Value data to **1**.

5. Select **OK** and reboot the server. Restarting the RRAS and NPS services does not suffice.

For more information, see [How to Enable or Disable Certificate Revocation Checking (CRL) on Clients](https://technet.microsoft.com/library/bb680540.aspx).


|Registry Path  |EAP Extension  |
|---------|---------|
|HKLM\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\13     |EAP-TLS         |
|HKLM\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\25     |PEAP         |
|HKLM\SYSTEM\CurrentControlSet\Services\RasMan\PPP\EAP\26     |EAP-MSCHAP v2         |

## Next steps

[Step 7.2. Create root certificates for VPN authentication with Azure AD](vpn-create-root-cert-for-vpn-auth-azure-ad.md): In this step, you configure conditional access root certificates for VPN authentication with Azure AD, which automatically creates a VPN Server cloud app in the tenant.
