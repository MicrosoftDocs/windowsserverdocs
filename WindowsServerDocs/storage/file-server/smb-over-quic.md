---
title: SMB over QUIC
description: Describes the SMB over QUIC feature in Windows Server 2022 Datacenter Azure Edition Preview, Windows Insider Dev Channel client 
ms.prod: windows-server
ms.topic: article
author: NedPyle
ms.author: inhenkel
ms.date: 06/07/2021
ms.localizationpriority: medium
---

# SMB over QUIC (PREVIEW)

>Applies to: Windows Server 2022 Datacenter: Azure Edition Preview, Windows Insider Dev Channel preview client

SMB over QUIC (Preview) introduces an alternative to the TCP network transport, providing secure, reliable connectivity to edge file servers over untrusted networks like the Internet. QUIC is an IETF-standardized protocol with many benefits when compared with TCP:

- All packets are always encrypted and handshake is authenticated with TLS 1.3
- Parallel streams of reliable and unreliable application data
- Exchanges application data in the first round trip (0-RTT)
- Improved congestion control and loss recovery
- Survives a change in the clients IP address or port

SMB over QUIC offers an "SMB VPN" for telecommuters, mobile device users, and high security organizations. The server certificate creates a TLS 1.3-encrypted tunnel over the internet-friendly UDP port 443 instead of the legacy TCP port 445. All SMB traffic, including authentication and authorization within the tunnel is never exposed to the underlying network. SMB behaves normally within the QUIC tunnel, meaning the user experience doesn't change. SMB features like multichannel, signing, compression, continuous availability, directory leasing, and so on, work normally.

A file server administrator must opt in to enabling SMB over QUIC. It isn't on by default and a client can't force a file server to enable SMB over QUIC. Windows SMB clients still use TCP by default and will only attempt SMB over QUIC if the TCP attempt first fails or if intentionally requiring QUIC using `NET USE /TRANSPORT:QUIC` or `New-SmbMapping -TransportType QUIC`.

> [!NOTE]
> SMB over QUIC is in preview and not supported for production workloads, but you can get support from Microsoft while evaluating it.

## Prerequisites

To use SMB over QUIC, you need the following things:

- A file server running Windows Server 2022 Datacenter: Azure Edition Preview ([Microsoft Server Operating Systems Preview](https://aka.ms/ws2022ae))
- A Windows Insider Dev Channel client ([Windows Insider Dev Channel Preview Downloads](https://www.microsoft.com/software-download/windowsinsiderpreviewiso))
- Windows Admin Center ([Homepage](https://aka.ms/windowsadmincenter))
- A Public Key Infrastructure to issue certificates like Active Directory Certificate Server or access to a trusted third party certificate issuer like Verisign, Digicert, Let's Encrypt, and so on.

## Deploy SMB over QUIC

### Step 1: Install a server certificate

1. Create a Certificate Authority-issued certificate with the following properties:

    - Key usage: digital signature, non-repudiation
    - Purpose: Server Authentication (EKU 1.3.6.1.5.5.7.3.1)
    - Signature algorithm: SHA256RSA *(or greater)*
    - Signature hash: SHA256 *(or greater)*
    - Public key algorithm: ECDCA_P256 *(or greater. Can also use RSA with at least 2048 length)*
    - Subject Alternative Name (SAN): *(A DNS name entry for each fully qualified DNS name used to reach the SMB server)*
    - Subject: *(CN= anything, but must exist)*
    - Private key included: yes

    :::image type="content" source="./media/smb-over-quic/cert1.png" alt-text="certificate settings showing Signature algorithm with a value of sha256RSA, signature hash algorithm value of sha256, and Subject value of ws2022-quic":::
    :::image type="content" source="./media/smb-over-quic/cert2.png" alt-text="Certificate settings under the Detail tab showing Public key value of ECC (256 bits), public key parameters ECDSA-P256 and Application policies 1 application Certificate Policy ":::
    :::image type="content" source="./media/smb-over-quic/cert3.png" alt-text="Certificate details showing subject alternative name value as DNS Name equals ws2022-quic.corp, and Key Usage value as Digital Signature, Non-Repudiated":::

    If using a Microsoft Enterprise Certificate Authority, you can create a certificate template and allow the file server administrator to supply the DNS names when requesting it. For more information on creating a certificate template, review [Designing and Implementing a PKI: Part III Certificate Templates](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/designing-and-implementing-a-pki-part-iii-certificate-templates/ba-p/397860). For a demonstration of creating a certificate for SMB over QUIC using a Microsoft Enterprise Certificate Authority, watch this video:

    > [!VIDEO https://www.youtube.com/embed/L0yl5Z5wToA]

    For requesting a third-party certificate, consult your vendor documentation.

1. If using a Microsoft Enterprise Certificate Authority:
    1. Start *MMC.EXE* on the file server.
    1. Add the **Certificates** snap-in, and select the **Computer account**.
    1. Expand **Certificates (Local Computer)**, **Personal**, then right-click **Certificates** and click **Request New Certificate**.
    1. Click **Next**
    1. Select **Active Directory Enrollment Policy**
    1. Click **Next**
    1. Select the certificate template for SMB over QUIC that was published in Active Directory.
    1. Click **More information is required to enroll for this certificate. Click here to configure settings**
    1. So users can use to locate the file server, fill in the value **Subject** with a common name and **Subject Alternative Name** with one or more DNS names.
    1. Click **Ok** and click **Enroll**.

    :::image type="content" source="./media/smb-over-quic/select-cert.png" alt-text="image showing the steps covered 1":::
    :::image type="content" source="./media/smb-over-quic/san-cert.png" alt-text="image showing the steps covered  2":::
    :::image type="content" source="./media/smb-over-quic/mmccert.png" alt-text="image showing the steps covered 3":::

> [!NOTE]
> If you're using a certificate file issued by a third party certificate authority, you can use the Certificates snap-in or Windows Admin Center to import it.

### Step 2: Configure SMB over QUIC

1. Deploy a [Windows Server 2022 Datacenter: Azure Edition](https://aka.ms/ws2022ae) preview server.
1. Install the latest version of Windows Admin Center on a management PC or the file server. You need the latest version of the *Files & File Sharing* extension. It's installed automatically by Windows Admin Center if *Automatically update extensions* is enabled in **Settings > Extensions**.
1. Join your Windows Server 2022 Datacenter: Azure Edition file server to your Active Directory domain and make it accessible to Windows Insider clients on the Azure public interface by adding a firewall allow rule for UDP/443 inbound. Do **not** allow TCP/445 inbound to the file server. The file server must have access to at least one domain controller for authentication, but no domain controller requires any internet access.
1. Connect to the server with Windows Admin Center and click the **Settings** icon in the lower left. In the **File Shares (SMB server)** section, under **File sharing across the internet with SMB over QUIC**, click **Configure**.
1. Click a certificate under **Select a computer certificate for this file server**, click the server addresses clients can connect to or click **Select all**, and click **Enable**.

    :::image type="content" source="./media/smb-over-quic/wac1.png" alt-text="image showing the steps for configure SMB over QUIC1":::

1. Ensure that the certificate and SMB over QUIC report are healthy.

    :::image type="content" source="./media/smb-over-quic/wac2.png" alt-text="image showing the steps for configure SMB over QUIC2":::

1. Click on the **Files and File Sharing** menu option. Note your existing SMB shares or create a new one.

For a demonstration of configuring and using SMB over QUIC, watch this video:

> [!VIDEO https://www.youtube.com/embed/OslBSB8IkUw]

### Step 3: Connect to SMB shares

1. Join your Windows Insider Dev Channel client to your domain.Be certain the names of the SMB over QUIC file server's certificate subject alternative names are published to DNS and are fully qualified **OR** added to the HOST files for your Windows Insider Dev Channel client.Ensure that the  server's certificate subject alternative names are published to DNS **OR** added to the HOSTS files for your Windows Insider Dev Channel client.
1. Move your Windows Insider Dev Channel client to an external network where it no longer has any network access to domain controllers or the file server's internal IP addresses.
1. In Windows File Explorer, in the Address Bar, type the UNC path to a share on the file server and confirm you can access data in the share. Alternatively, you can use *NET USE /TRANSPORT:QUIC* or *New-SmbMapping -TransportType QUIC* with a UNC path. Examples:

    `NET USE * \\fsedge1.contoso.com\sales` *(automatically tries TCP then QUIC)*

    `NET USE * \\fsedge1.contoso.com\sales /TRANSPORT:QUIC` *(tries only QUIC)*

    `New-SmbMapping -LocalPath 'Z:' -RemotePath '\\fsedge1.contoso.com\sales' -TransportType QUIC` *(tries only QUIC)*

### Configure the KDC Proxy (Optional, but recommended)

By default, a Windows Insider Dev Channel client won't have access to an Active Directory domain controller when connecting to an SMB over QUIC file server. This means authentication uses NTLMv2, where the file server authenticates on behalf of the client. No NTLMv2 authentication or authorization occurs outside the TLS 1.3-encrypted QUIC tunnel. However, we still recommend using Kerberos as a general security best practice and don't recommend creating new NTLMv2 dependencies in deployments. To allow this, you can configure the KDC proxy to forward ticket requests on the user's behalf, all while using an internet-friendly HTTPS encrypted communication channel.

1. On the file server, in an elevated PowerShell prompt, run:

    `NETSH http add urlacl url=https://+:443/KdcProxy user="NT authority\Network Service"`

    `REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\KPSSVC\Settings" /v HttpsClientAuth /t REG_DWORD /d 0x0 /f`

    `REG ADD "HKLM\SYSTEM\CurrentControlSet\Services\KPSSVC\Settings" /v DisallowUnprotectedPasswordAuth /t REG_DWORD /d 0x0 /f`

    `Get-SmbServerCertificateMapping`

1. Copy the thumbprint value from the certificate associated with SMB over QUIC certificate (there may be multiple lines but they will all have the same thumbprint) and paste it as the **Certhash** value for the following command:

    `$guid = [Guid]::NewGuid()`

    `Add-NetIPHttpsCertBinding -ipport 0.0.0.0:443 -CertificateHash <thumbprint> -CertificateStoreName "my" -ApplicationId "{$guid}" -NullEncryption $false`

1. Add the file server's SMB over QUIC names as SPNs in Active Directory for Kerberos. For example:

    `NETDOM computername ws2022-quic.corp.contoso.com /add fsedge1.contoso.com`

1. Set the KDC Proxy service to automatic and start it:

    `Set-Service -Name kpssvc -StartupType Automatic`

    `Start-Service -Name kpssvc`

1. Configure the following group policy to apply to the Windows Insider Dev Channel client:

    **Computers > Administrative templates > System > Kerberos > Specify KDC proxy servers for Kerberos clients**

    The format of this group policy setting is a value name of your fully qualified Active Directory domain name and the value will be the external  name you specified for the QUIC server. For example, where the Active Directory domain is named "corp.contoso.com" and the external DNS domain is named "contoso.com":

    `value name: corp.contoso.com`

    `value: <https fsedge1.contoso.com:443:kdcproxy />`

    This Kerberos realm mapping means that if user `ned@corp.contoso.com` tried to connect to a file server name `fs1edge.contoso.com"`, the KDC proxy will know to forward the kerberos tickets to a domain controller in the internal `corp.contoso.com` domain. The communication with the client will be over HTTPS/443 and user credentials aren't directly exposed on the client-file server network.
1. Create a Windows Defender Firewall rule that inbound-enables TCP port 443 for the KDC Proxy service to receive authentication requests.  
1. Ensure that edge firewalls allow HTTPS/443 inbound to the file server.
1. Apply the group policy and restart the Windows Insider Dev Channel client.  

> [!NOTE]
> Automatic configuration of the KDC Proxy will come later in the SMB over QUIC Preview and these server steps will not be necessary.

## Notes

- Windows Server 2022 Datacenter: Azure Edition Preview will also be available on Azure Stack HCI 21H2 Preview later this year, for customers not using Azure public cloud.
- We recommend read-only domain controllers configured only with passwords of mobile users be made available to the file server.
- Users should have strong passwords or, ideally, be configured using a [passwordless strategy](/windows/security/identity-protection/hello-for-business/passwordless-strategy) with [Windows Hello for Business MFA](/windows/security/identity-protection/hello-for-business) or [smart cards](/windows/security/identity-protection/smart-cards/smart-card-windows-smart-card-technical-reference). Configure an account lockout policy for mobile users through [fine-grained password policy](../../identity/ad-ds/get-started/adac/Introduction-to-Active-Directory-Administrative-Center-Enhancements--Level-100-.md#fine_grained_pswd_policy_mgmt) and you should deploy intrusion protection software to detect brute force or password spray attacks.

## More references

[Storage at Microsoft blog](https://aka.ms/FileCab)

[QUIC Working Group homepage](https://quicwg.org/)

[Microsoft MsQuic GitHub homepage](https://github.com/microsoft/msquic)

[QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)

[TLS 1.3 Working Group homepage](https://tlswg.org/)

[Microsoft TLS 1.3 Support Reference](https://devblogs.microsoft.com/premier-developer/microsoft-tls-1-3-support-reference/)
