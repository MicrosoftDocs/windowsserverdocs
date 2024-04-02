---
title: "Configure SMB over QUIC client access control in Windows Server (preview)"
description: Learn how to configure SMB over QUIC client access control using PowerShell in Windows and Windows Server.
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 03/27/2024
#customer intent: As an administrator, I want to configure SMB over QUIC client access control in Windows Server so that I can restrict which clients can access SMB over QUIC servers.
---

# Configure SMB over QUIC client access control in Windows Insider (preview)

> [!IMPORTANT]
> Windows Insider and Windows Server Insider builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

SMB over QUIC Client Access Control (CAC) enables you to restrict which clients can access SMB over QUIC servers, creating an allowlist for trusted devices to connect to the file server. This gives organizations more protection but does not change the Windows authentication used to make the SMB connection nor does it alter the end user experience.

This article explains how to configure SMB over QUIC Client Access Control (CAC) using PowerShell in Windows and Windows Server.

To learn more about SMB over QUIC, see [SMB over QUIC](../file-server/smb-over-quic.md).

## How Client Access Control work

SMB over QUIC CAC controls access by making any client trying to access a server require a shared root authority key. The admin issues this certificate to the client and adds the hash to an allow list maintained by the server. When the client tries to connect to the server, the server compares the client certificate info against the allow list. If the certificate is valid, the server certificate creates a TLS 1.3-encrypted tunnel over UDP port 443 and grants the client access to the share. SMB over QUIC CAC also supports  certificates with subject alternative names, not just a single subject.

You can also configure SMB over QUIC to block access by revoking certificates or explicitly denying certain devices or users access. For example, you can configure SMB over QUIC to block connection requests from third-party users or unsupported devices that use earlier, less secure SMB dialects.

## Prerequisites

Before you can configure SMB over QUIC CAC, you an *SMB server* with the following:

- An SMB server running on one of the following operating systems:
  - [Windows Server Insiders build 25977](https://techcommunity.microsoft.com/t5/windows-server-insiders/announcing-windows-server-preview-build-25977/m-p/3958483) or later.
  - [Windows 11 Insider Preview Build 25977 (Canary Channel)](https://blogs.windows.com/windows-insider/2023/10/18/announcing-windows-11-insider-preview-build-25977-canary-channel/) or later.
- SMB over QUIC enabled and configured on the server. To learn how to configure SMB over QUIC, see [SMB over QUIC](../file-server/smb-over-quic.md).
- If you're using client certificates issues by a different certificate authority (CA) than the server, you need to ensure that the CA is trusted by the server.
- Administrative privileges for the SMB server you're configuring.

You also need an *SMB client* with the following:

- An SMB client running on one of the following operating systems:
  - [Windows Server Insiders build 25977](https://techcommunity.microsoft.com/t5/windows-server-insiders/announcing-windows-server-preview-build-25977/m-p/3958483) or later.
  - [Windows 11 Insider Preview Build 25977 (Canary Channel)](https://blogs.windows.com/windows-insider/2023/10/18/announcing-windows-11-insider-preview-build-25977-canary-channel/) or later.
- A client certificate which is:
  - Issued by a certificate authority trusted by the SMB server.
  - Installed in the client's certificate store.
  - Administrative privileges for the SMB server you're configuring.

> [!NOTE]
> We recommended using SMB over QUIC with Active Directory domains, however it isn't required. You can also use SMB over QUIC on a workgroup-joined server with local user credentials and NTLM.

## Configure SMB over QUIC CAC

## Gather the SMB client certificate information

To gather your client certificate hash using PowerShell:

1. Open an elevated PowerShell prompt on the SMB client.

1. List the certificates in the client's certificate store by running the following command.

   ```powershell
   Get-ChildItem -Path Cert:\LocalMachine\My
   ```

1. Run the following command to store the certificate in a variable by replacing `<subject name>` with the subject name of the certificate you want to use.

   ```powershell
   $clientCert = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Subject -Match "<subject name>"}
   ```

1. Make a note of client certificate SHA256 hash by running the following command. You'll need this when configuring client access control.

   ```powershell
   $clientCert.GetCertHashString("SHA256")`
   ```

> [!NOTE]
> The thumbprint algorithm is SHA1 stored in the `$clientCert` object. This is used by commands like `New-SmbClientCertificateMapping`. You'll also need SHA256 thumbprint to configure client access control, these thumbprints will be different devired using different algorithms against the same certificate.

## Map client cerficate to the SMB client

To map the client certificate to the SMB client:

1. Open an elevated PowerShell prompt on the SMB client.

1. Run the `New-SmbClientCertificateMapping` command to map the client certificate to the SMB client. Replace `<namespace>` with the SMB servers fully qualified domain nanme (FQDN) and use the SHA1 client certificate thumbprint you gathered in the previous section.

   ```powershell
   New-SmbClientCertificateMapping -Namespace <namespace> -Thumbprint $clientCert.Thumbprint -StoreName My
   ```

You're client certificated will now be used by the SMB client to authenticate to the SMB server matching the FQDN.

## Grant individual clients using CAC

1. Sign in to the SMB server.

1. Open an elevated PowerShell prompt on the SMB server.

1. Run the `Grant-SmbClientAccessToServer` to grant access to the client certificate. Replace `<name>` with the SMB servers hostname and `<thumbprint>` using the SHA256 client certificate thumbprint you gathered in the [Gather the SMB client certificate information](#gather-the-smb-client-certificate-information) section.

   ```powershell
   Grant-SmbClientAccessToServer -Name <name> -Thumbprint <thumbprint>
   ```

You've now granted access to the client certificate. You can verify the client certificate access by running the `Get-SmbClientAccessToServer` command.

## Grant specific certification authorities using CAC

TODO:

## Connect to the SMB server using SMB over QUIC

When you're finished, test whether you can connect to the server by running one of the following commands:

```powershell
NET USE \\server DNS name\share /TRANSPORT:QUIC
```

or

```powershell
New-SmbMapping -RemotePath \\server DNS name\share -TransportType QUIC
```

If you can connect to the server, you've successfully configured SMB over QUIC CAC.

## Related content

- [SMB over QUIC](/file-server/smb-over-quic)

- [Storage at Microsoft blog](https://aka.ms/FileCab)

- [QUIC Working Group homepage](https://quicwg.org/)

- [Microsoft MsQuic GitHub homepage](https://github.com/microsoft/msquic)

- [QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)

- [TLS 1.3 Working Group homepage](https://tlswg.org/)