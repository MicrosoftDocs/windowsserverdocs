---
title: "Configure SMB over QUIC client access control in Windows Server"
description: Learn how to configure SMB over QUIC client access control using PowerShell in Windows and Windows Server.
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 08/14/2024
#customer intent: As an administrator, I want to configure SMB over QUIC client access control in Windows Server so that I can restrict which clients can access SMB over QUIC servers.
---

# Configure SMB over QUIC client access control in Windows Server 2022 Azure Edition and Windows Server 2025 (preview)

> [!IMPORTANT]
> Windows Insider and Windows Server 2025 builds are in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

SMB over QUIC client access control enables you to restrict which clients can access SMB over QUIC servers. Client access control creates allow and blocklists for devices to connect to the file server. Client access control gives organizations more protection without changing the authentication used when making the SMB connection, nor does it alter the end user experience.

The article explains how to use PowerShell to configure client access control for SMB over QUIC on Windows 11 and Windows Server 2022 Datacenter: Azure Edition. To proceed with the instructions, you must have either the March Update KB5035853 or KB5035857 installed, be running a recent Windows 11 Insider build, or Windows Server 2025.

To learn more about configuring SMB over QUIC, see [SMB over QUIC](smb-over-quic.md).

## How client access control works

Client access control checks clients connecting to a server are using a known client certificate or have a certificate issued by a shared root certificate. The admin issues this certificate to the client and adds the hash to an allowlist maintained by the server. When the client tries to connect to the server, the server compares the client certificate against the allowlist. If the certificate is valid, the server certificate creates a TLS 1.3-encrypted tunnel over UDP port 443 and grants the client access to the share. Client access control also supports certificates with subject alternative names.

You can also configure SMB over QUIC to block access by revoking certificates or explicitly denying certain devices access.

> [!NOTE]
> We recommend using SMB over QUIC with Active Directory domains, however it isn't required. You can also use SMB over QUIC on a workgroup-joined server with local user credentials and NTLM.

## Prerequisites

Before you can configure client access control, you need an *SMB server* with the following prerequisites.

- An SMB server running Windows Server 2022 Datacenter: Azure Edition with the [March 12, 2024—KB5035857 Update](https://support.microsoft.com/topic/march-12-2024-kb5035857-os-build-20348-2340-a7953024-bae2-4b1a-8fc1-74a17c68203c) or Windows Server 2025 or later. To unlock the preview feature you must also install [Windows Server 2022 KB5035857 240302_030531 Feature Preview](https://download.microsoft.com/download/d/c/b/dcb54178-7997-4a5a-84bf-6269cfa3bb68/Windows%20Server%202022%20KB5035857%20240302_030531%20Feature%20Preview.msi).
- SMB over QUIC enabled and configured on the server. To learn how to configure SMB over QUIC, see [SMB over QUIC](smb-over-quic.md).
- If you're using client certificates issued by a different certificate authority (CA), you need to ensure that the CA is trusted by the server.
- Administrative privileges for the SMB server you're configuring.

> [!IMPORTANT]
> Once KB5035857 is installed, you must enable this feature in Group Policy:
>
> 1. Click **Start**, type **gpedit**, and select **Edit group policy**.
> 1. Navigate to **Computer Configuration\Administrative Templates\KB5035857 240302_030531 Feature Preview\Windows Server 2022**.
> 1. Open the **KB5035857 240302_030531 Feature Preview** policy and select **Enabled**.

You also need an *SMB client* with the following prerequisites.

- An SMB client running on one of the following operating systems:
  - Windows Server 2022 Datacenter: Azure Edition with the [March 12, 2024—KB5035857 Update](https://support.microsoft.com/topic/march-12-2024-kb5035857-os-build-20348-2340-a7953024-bae2-4b1a-8fc1-74a17c68203c). To unlock the preview feature you must also install [Windows Server 2022 KB5035857 240302_030531 Feature Preview](https://download.microsoft.com/download/d/c/b/dcb54178-7997-4a5a-84bf-6269cfa3bb68/Windows%20Server%202022%20KB5035857%20240302_030531%20Feature%20Preview.msi).
  - Windows 11 with the [March 12, 2024—KB5035853 Update](https://support.microsoft.com/topic/march-12-2024-kb5035853-os-builds-22621-3296-and-22631-3296-a69ac07f-e893-4d16-bbe1-554b7d9dd39b). To unlock the preview feature you must also install [Windows 11 (original release) KB5035854 240302_030535 Feature Preview](https://download.microsoft.com/download/9/7/e/97ecf574-855e-441c-9141-bfb61ec2074e/Windows%2011%20(original%20release)%20KB5035854%20240302_030535%20Feature%20Preview.msi).
  - Windows Server 2025 or later.
  - [Windows 11 Insider Preview Build 25977 (Canary Channel)](https://blogs.windows.com/windows-insider/2023/10/18/announcing-windows-11-insider-preview-build-25977-canary-channel/) or later.
- A client certificate that is:
  - Issued for Client Authentication (EKU 1.3.6.1.5.5.7.3.2).
  - Issued by a certificate authority trusted by the SMB server.
  - Installed in the client's certificate store.
- Administrative privileges for the SMB server you're configuring.

> [!IMPORTANT]
> Once KB5035854 is installed, you must enable this feature in Group Policy:
>
> 1. Click **Start**, type **gpedit**, and select **Edit group policy**.
> 1. Navigate to **Computer Configuration\Administrative Templates\KB5035854 240302_030535 Feature Preview\Windows 11 (original release)**.
> 1. Open the **KB5035854 240302_030535 Feature Preview** policy and select **Enabled**.

## Configure the SMB client

### Gather the SMB client certificate information

To gather your client certificate hash using PowerShell:

1. Open an elevated PowerShell prompt on the SMB client.

1. List the certificates in the client's certificate store by running the following command.

   ```powershell
   Get-ChildItem -Path Cert:\LocalMachine\My
   ```

1. Run the following command to store the certificate in a variable. Replace `<subject name>` with the subject name of the certificate you want to use.

   ```powershell
   $clientCert = Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Subject -Match "<subject name>"}
   ```

1. Make a note of the client certificate's SHA256 hash by running the following command. You need this identifier when configuring client access control.

   ```powershell
   $clientCert.GetCertHashString("SHA256")
   ```

> [!NOTE]
> The thumbprint stored in the `$clientCert` object uses the SHA1 algorithm. This is used by commands like `New-SmbClientCertificateMapping`. You'll also need the SHA256 thumbprint to configure client access control, these thumbprints will be different derived using different algorithms against the same certificate.

### Map the client certificate to the SMB client

To map the client certificate to the SMB client:

1. Open an elevated PowerShell prompt on the SMB client.

1. Run the `New-SmbClientCertificateMapping` command to map the client certificate. Replace `<namespace>` with the SMB server's fully qualified domain name (FQDN) and use the SHA1 client certificate thumbprint you gathered in the previous section using the variable.

   ```powershell
   New-SmbClientCertificateMapping -Namespace <namespace> -Thumbprint $clientCert.Thumbprint -StoreName My
   ```

Once complete, the client certificated is used by the SMB client to authenticate to the SMB server matching the FQDN.

## Configure client access control

### Grant individual clients

Follow the steps to grant a specific client access to the SMB server using client access control.

1. Sign in to the SMB server.

1. Open an elevated PowerShell prompt on the SMB server.

1. Run the `Grant-SmbClientAccessToServer` to grant access to the client certificate. Replace `<name>` with the SMB server's hostname and `<hash>` using the SHA256 client certificate identifier you gathered in the [Gather the SMB client certificate information](#gather-the-smb-client-certificate-information) section.

   ```powershell
   Grant-SmbClientAccessToServer -Name <name> -IdentifierType SHA256 -Identifier <hash>
   ```

You've now granted access to the client certificate. You can verify the client certificate access by running the `Get-SmbClientAccessToServer` command.

### Grant specific certification authorities

Follow the steps to grant clients from a specific certification authority, also known as an issuer, using client access control.

1. Sign in to the SMB server.

1. Open an elevated PowerShell prompt on the SMB server.

1. Run the `Grant-SmbClientAccessToServer` to grant access to the client certificate. Replace `<name>` with the SMB server's hostname and `<subject name>` with the complete X.500 distinguished name of the issuer certificate. For example, `CN=Contoso CA, DC=Contoso, DC=com`.

   ```powershell
   Grant-SmbClientAccessToServer -Name <name> -IdentifierType ISSUER -Identifier "<subject name>"
   ```

### Disable SMB over QUIC

Starting with Windows 11 Insider build 26090, admins can now disable SMB over QUIC for client by running the following command:

```powershell
Set-SmbClientConfiguration -EnableSMBQUIC $false
```

Similarly, this operation can be performed in Group Policy by disabling the **Enable SMB over QUIC** policy in the following path:

- **Computer Configuration\Administrative Templates\Network\Lanman Workstation**

## Connect to the SMB server

When you're finished, test whether you can connect to the server by running one of the following commands:

```cmd
NET USE \\<server DNS name>\<share name> /TRANSPORT:QUIC
```

Or

```powershell
New-SmbMapping -RemotePath \\<server DNS name>\<share name> -TransportType QUIC
```

If you can connect to the server, you've successfully configured SMB over QUIC using client access control.

## Related content

- [SMB over QUIC](smb-over-quic.md)
- [Storage at Microsoft blog](https://aka.ms/FileCab)
- [QUIC Working Group homepage](https://quicwg.org/)
- [Microsoft MsQuic GitHub homepage](https://github.com/microsoft/msquic)
- [QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)
- [TLS 1.3 Working Group homepage](https://tlswg.org/)
