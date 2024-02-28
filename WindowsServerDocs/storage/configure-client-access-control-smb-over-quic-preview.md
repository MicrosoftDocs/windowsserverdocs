---
title: Configure SMB over QUIC client access control in Windows Insider (preview)
description: Learn how to use SMB over QUIC client access control in Windows Insider
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 02/29/2024

---

# Configure SMB over QUIC client access control in Windows Insider (preview)

>Applies to: Windows and Windows Server Insider builds

> [!IMPORTANT]
> Windows Insider and Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

SMB over QUIC introduces an alternative to the TCP network transport, providing secure, reliable connectivity to edge file servers over untrusted networks like the Internet. QUIC is an IETF-standardized protocol with many benefits when compared with TCP.

This article explains how to configure SMB over QUIC Client Access Control (CAC) in Windows and Windows Server Insider builds. See [SMB over QUIC](https://aka.ms/smboverquic) for detailed information on SMB over QUIC.

>[!IMPORTANT]
>SMB over QUIC is not enabled by default. A file server administrator must opt in to enable SMB over QUIC. A client can't force a file server to enable SMB over QUIC.

## SMB over QUIC Client Access Control

SMB over QUIC CAC works by a client trusting the SMB over QUIC server via a valid shared root authority key. An admin also gives the client a certificate from the same issuer, and that certificate’s hash (or issuer) is added to a trust list maintained by the server. When the client connects, it sends the certificate info to the server for comparison against the allow list, granting or denying access to QUIC. Then SMB authentication occurs inside the QUIC TLS tunnel, and the user connects to their share. An admin can also explicitly deny access or just revoke certificates. CAC is optional and not enabled by default.

SMB over QUIC CAC supports using certificates with subject alternative names, not just a single subject. This means the client access control feature supports using a Microsoft AD Certificate Authority and multiple endpoint names, just like the currently released version of SMB over QUIC. You can evaluate the feature using the recommended options and not require self-signed test certificates.

You can remove specific SMB protocols from usage in your organization, blocking older, less secure, less capable Windows devices and third parties from connecting to the server. For example, you can limit users to SMB 3.1.1, the most secure dialect of the protocol.

## Prerequisites

Before you can configure SMB over QUIC CAC you need:

- An SMB QUIC server running on one of the following operating systems.
  - Windows Server Insiders build 25075 or later.
  - Windows Server vNext Azure Edition Preview Build 25977 or later VM. You’re allowed to run Windows Server Azure Edition outside of Azure IaaS and Azure Stack HCI for evaluation and testing purposes.
- Windows 11 Insider Preview Build 25977 (Canary Channel) or later client.
- Administrative privileges to the computer.
- If you're using Group Policy on a domain, you need privileges to create or edit a Group Policy object (GPO) and link it to the appropriate organizational unit (OU).

## Configure SMB over QUIC CAC using PowerShell

To configure SMB over QUIC CAC using PowerShell, follow these steps:

1. Deploy a [Windows Server 2022 Datacenter: Azure Edition](https://aka.ms/ws2022ae) server.

1. Install the latest version of Windows Admin Center on a management PC or the file server. You need the latest version of the *Files & File Sharing* extension. It's installed automatically by Windows Admin Center if *Automatically update extensions* is enabled in **Settings > Extensions**.

1. Join your Windows Server 2022 Datacenter: Azure Edition file server to your Active Directory domain and make it accessible to Windows Insider clients on the Azure public interface by adding a firewall allow rule for UDP/443 inbound. Do **not** allow TCP/445 inbound to the file server. The file server must have access to at least one domain controller for authentication, but no domain controller requires any internet access.

> [!NOTE]
> We recommended using SMB over QUIC with Active Directory domains, however it isn't required. You can also use SMB over QUIC on a workgroup-joined server with local user credentials and NTLM.

1. Connect to the server with Windows Admin Center and click the **Settings** icon in the lower left. In the **File shares (SMB server)** section, under **File sharing across the internet with SMB over QUIC**, click **Configure**.

1. Click a certificate under **Select a computer certificate for this file server**, click the server addresses clients can connect to or click **Select all**, and click **Enable**.

    :::image type="content" source="./media/smb-over-quic-cac/wac1.png" alt-text="image showing the steps for configure SMB over QUIC1":::

1. Ensure that the certificate and SMB over QUIC report are healthy.

    :::image type="content" source="./media/smb-over-quic-cac/wac2.png" alt-text="image showing the steps for configure SMB over QUIC2":::

1. Click **Files and File Sharing**. Note your existing SMB shares or create a new one.

For a demonstration of configuring and using SMB over QUIC, watch this video:

> [!VIDEO https://www.youtube.com/embed/OslBSB8IkUw]

# [PowerShell](#tab/powershell)

1. From an elevated PowerShell prompt on the SMB over QUIC server, run the following commands to 

1. Obtain client certificate SHA256 hash by running certutil to examine the Cert Hash(sha256) field:

```powershell
Export-Certificate -Cert $clientCert -FilePath path\clientCert.cer
```

```powershell
certutil.exe path\clientCert.cer | findstr /i /c:"Cert Hash(sha256)"
```

---

:::image type="content" source="media/smb-over-quic-cac/certutil-command-running.png" alt-text="Screenshot showing example of certutil command running.":::

1. Return to the server.

SMB over QUIC CAC is configured.

>[!IMPORTANT]
>You also can grant access by Issuer. Access by Issuer means that instead of adding a certificate SHA256 hash from every single client, you instead can add the Issuer DN by using -IdentifierType ISSUER. Access by Issuer is not as granular or secure but useful for large client fleets when using a trusted certificate authority and not self-signed evaluation certs.

1. Connect to the server using either:

```powershell
NET USE \\server DNS name\share /TRANSPORT:QUIC
```

or, 

```powershell
New-SmbMapping -RemotePath \\server DNS name\share -TransportType QUIC
```

---

## Related content

- [SMB over QUIC](/file-server/smb-over-quic)

- [Storage at Microsoft blog](https://aka.ms/FileCab)

- [QUIC Working Group homepage](https://quicwg.org/)

- [Microsoft MsQuic GitHub homepage](https://github.com/microsoft/msquic)

- [QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)

- [TLS 1.3 Working Group homepage](https://tlswg.org/)