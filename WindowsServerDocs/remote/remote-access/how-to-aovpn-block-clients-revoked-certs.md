---
title:Block VPN Clients that use revoked certificates on Windows Server
description: This article shows you how to block VPN clients that use revoked certificates after a Windows Server update.
ms.topic: article
ms.date: 04/28/2023
ms.author: wscontent
author: anastasia-ms
---
# Block VPN clients that use revoked certificates

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10

This article shows you how to block VPN clients that use revoked certificates after a Windows Server update. The RRAS server can enforce certificate revocation for VPNs that use IKEv2 and machine certificates for authentication, such as device tunnel Always-on VPNs. This means that for such VPNs, the RRAS server can deny VPN connections to clients that try to use a revoked certificate.

## Windows updates

The following table lists the releases that contain the fixes for each version of Windows.

|Operating system version |Release  |
|---------|---------|
|Windows Server, version 1903  |[KB4501375](https://support.microsoft.com/help/4501375/windows-10-update-kb4501375) |
|Windows Server 2019<br />Windows Server, version 1809  |[KB4505658](https://support.microsoft.com/help/4505658/windows-10-update-kb4505658)  |
|Windows Server, version 1803  |[KB4507466](https://support.microsoft.com/help/4507466/windows-10-update-kb4507466)  |
|Windows Server, version 1709  |[KB4507465](https://support.microsoft.com/help/4507465/windows-10-update-kb4507465)  |
|Windows Server 2016, version 1607 or lower  |[KB4503294](https://support.microsoft.com/help/4503294/windows-10-update-kb4503294) |

## Configure prerequisites

1. Install the Windows updates as they become available.
1. Make sure that all the VPN client and RRAS server certificates that you use have CDP entries, and that the RRAS server can reach the respective CRLs.
1. On the RRAS server, use the **Set-VpnAuthProtocol** PowerShell cmdlet to configure the **RootCertificateNameToAccept** parameter.<p>
   The following example lists the commands to do this. In the example, **CN=Contoso Root Certification Authority** represents the distinguished name of the Root Certification Authority.
   ``` powershell
   $cert1 = ( Get-ChildItem -Path cert:LocalMachine\root | Where-Object -FilterScript { $_.Subject -Like "*CN=Contoso Root Certification Authority*" } )
   Set-VpnAuthProtocol -RootCertificateNameToAccept $cert1 -PassThru
   ```
**How to configure the RRAS server to enforce certificate revocation for VPN connections that are based on IKEv2 machine certificates**

1. In a Command Prompt window, run the following command:
   ```
   reg add HKLM\SYSTEM\CurrentControlSet\Services\RemoteAccess\Parameters\Ikev2 /f /v CertAuthFlags /t REG_DWORD /d "4"
   ```

1. Restart the **Routing and Remote Access** service.

To disable certificate revocation for these VPN connections, set **CertAuthFlags = 2** or remove the **CertAuthFlags** value, and then restart the **Routing and Remote Access** service.

**How to revoke a VPN client certificate for a VPN connection that is based on an IKEv2 machine certificate**
1. Revoke the VPN client certificate from the Certification Authority.
1. Publish a new CRL from the Certification Authority.
1. On the RRAS server, open an administrative Command Prompt window, and then run the following commands:
   ```
   certutil -urlcache * delete
   certutil -setreg chain\ChainCacheResyncFiletime @now
   ```

**How to verify that certificate revocation for IKEv2 machine certificate-based VPN connections is working**
>[!Note]
> Before you use this procedure, make sure that you enable the CAPI2 operational event log.
1. Follow the previous steps to revoke a VPN client certificate.
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

