---
title: Block VPN clients that use revoked certificates on Windows Server
description: This article shows you how to configure RRAS server to block VPN clients that use a revoked IKEv2 certificate for authentication after installing any Windows update.
ms.topic: article
ms.date: 05/04/2023
ms.author: wscontent
author: anaharris-ms
---
# Block VPN clients that use revoked certificates

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10+

This article shows you how to configure RRAS server to block VPN clients that use a revoked IKEv2 certificate for authentication after installing any Windows update.

Once the RRAS server is configured for certificate revocation, any VPN clients that attempt to use a revoked IKEv2 certificate for authentication, such as device tunnel Always-on VPNs, will be denied connection.

For more information on authentication certificates in Windows, see [Certificates and trust in Windows](/windows-server/identity/ad-cs/certificate-trust).

## Configure VPN authentication

1. Confirm that all VPN client and RRAS server certificates have CDP entries, and that the RRAS server can reach the respective CRLs.

1. On the RRAS server, run the following PowerShell code to set the authentication method to accept root certificates with a Subject that contains the name of your certification authority. Make sure that you replace *{Your Root Certification Authority}* with the name of your root certification authority.

    ``` powershell
      $cert1 = ( Get-ChildItem -Path cert:LocalMachine\root | Where-Object -FilterScript { $_.Subject -Like "*CN={Your Root Certification Authority}*" } )
      Set-VpnAuthProtocol -RootCertificateNameToAccept $cert1 -PassThru
    ```

## Configure the RRAS server to enforce IKEv2 machine certificate revocation

1. On the RRAS server, open a Command Prompt window.

1. In the Command Prompt window, run the following command:

   ```
   reg add HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\Ikev2 /f /v CertAuthFlags /t REG_DWORD /d "4"
   ```

1. Restart the **Routing and Remote Access** service.

>[!NOTE]
>To disable certificate revocation for these VPN connections, set **CertAuthFlags = 2** or remove the **CertAuthFlags** value, and then restart the **Routing and Remote Access** service.

## Revoke an IKEv2 machine VPN client certificate

1. Revoke the VPN client certificate from the Certification Authority.

1. Publish a new CRL from the Certification Authority.

1. On the RRAS server, open an administrative Command Prompt window, and then run the following commands:

   ```
   certutil -urlcache * delete
   certutil -setreg chain\ChainCacheResyncFiletime @now
   ```

## Verify that certificate revocation is working

>[!NOTE]
> Before you use this procedure, make sure that you enable the CAPI2 operational event log.

1. Try to connect to the VPN by using a client that has the revoked certificate. The RRAS server should refuse the connection and display a message such as "IKE authentication credentials are unacceptable."

1. On the RRAS server, open Event Viewer, and navigate to **Applications and Services Logs/Microsoft/Windows/CAPI2**.

1. Search for an event that has the following information:
   * Log Name: **Microsoft-Windows-CAPI2/Operational Microsoft-Windows-CAPI2/Operational**
   * Event ID: **41**
   * The event contains the following text: **subject="*Client FQDN*"** (*Client FQDN* represents the fully qualified domain name of the client that has the revoked certificate.)

   The **\<Result>** field of the event data should include **The certificate is revoked**. For example, see the following excerpts from an event:

   ```xml
   Log Name:      Microsoft-Windows-CAPI2/Operational Microsoft-Windows-CAPI2/Operational
   Source:        Microsoft-Windows-CAPI2
   Date:          5/20/2019 1:33:24 PM
   Event ID:      41
   ...
   Event Xml:
   <Event xmlns="https://schemas.microsoft.com/win/2004/08/events/event">
    <UserData>
     <CertVerifyRevocation>
      <Certificate fileRef="C97AE73E9823E8179903E81107E089497C77A720.cer" subjectName="client01.corp.contoso.com" />
      <IssuerCertificate fileRef="34B1AE2BD868FE4F8BFDCA96E47C87C12BC01E3A.cer" subjectName="Contoso Root Certification Authority" />
      ...
      <Result value="80092010">The certificate is revoked.</Result>
     </CertVerifyRevocation>
    </UserData>
   </Event>
   ```

