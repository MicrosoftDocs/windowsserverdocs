---
title: Configure SMB over QUIC client access control in Windows Server
description: Learn how to configure SMB over QUIC client access control using PowerShell in Windows and Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 12/04/2024
#customer intent: As an administrator, I want to configure SMB over QUIC client access control in Windows Server so that I can restrict which clients can access SMB over QUIC servers.
---

# Configure SMB over QUIC client access control

SMB over QUIC client access control enables you to restrict which clients can access SMB over QUIC servers. Client access control allows you to create allowlists and blocklists for devices to connect to the file server. Client access control gives organizations more protection without changing the authentication used when making the SMB connection, nor does it alter the end user experience.

## How client access control works

Client access control involves the server checking an access control list of certificates to determine whether a client is permitted to establish a QUIC connection with the server. The server validates the client certificate chain and ensures that it's trusted before proceeding with the access control checks. To configure client access control, an admin issues a certificate to the client and can add a hash of the certificate to an access control list maintained by the server.

If the client is permitted to connect to the server over QUIC, a TLS 1.3-encrypted tunnel over UDP port 443 is created. Client access control also supports certificates with subject alternative names. You can also configure SMB over QUIC to block access by revoking certificates or explicitly denying certain devices access. A server admin is able to prevent a client from accessing the server by revoking the client certificate, instead of relying solely on client access control.

> [!NOTE]
> We recommend using SMB over QUIC with Active Directory domains, however it isn't required. You can also use SMB over QUIC on a workgroup-joined server with local user credentials and NTLM.

Allow access control entries can be added and removed using the `Grant-SmbClientAccessToServer` and `Revoke-SmbClientAccessToServer` cmdlets respectively. Deny access control entries can be added and removed using the `Block-SmbClientAccessToServer` and `Unblock-SmbClientAccessToServer` cmdlets respectively. The entries in the access control list can be displayed using the `Get-SmbClientAccessToServer` cmdlet.

A leaf certificate can be granted or denied access by adding an access control entry that identifies the certificate by its SHA256 hash. A group of leaf certificates with a common issuer can all be granted or denied access by adding an issuer access control entry for the common issuer. An issuer entry can be added for intermediate CA certificates and root CA certificates. Using issuer entries can be useful since they help reduce the total number of entries that need to be added. If none of the certificates in the client's certificate chain are denied access and at least one is allowed access, the client is granted access. For example:

- If an allow entry is added for a CA certificate and a deny entry is added for one of the leaf certificates, all certificates issued by the CA are granted access except for the certificate for which the deny entry is added.

- If a deny entry is added for a CA certificate and an allow entry is added for one of the lead certificates, all certificates issued by the CA are denied access. The certificate, for which an allow entry was added, is denied access because any deny entry in the certificate chain takes priority over allow entries.

- Suppose a Root CA has two intermediate CAs called intermediate CA 1 and intermediate CA 2. If an allow entry is added for the root CA and a deny entry is added for intermediate CA 2 then certificates issued by intermediate CA 1 are granted access and certificates issued by intermediate CA 2 are denied access.

## Prerequisites

Before you can configure client access control, you need an *SMB server* with the following prerequisites.

- An SMB server running Windows Server 2022 Datacenter: Azure Edition with the [March 12, 2024—KB5035857 Update](https://support.microsoft.com/topic/march-12-2024-kb5035857-os-build-20348-2340-a7953024-bae2-4b1a-8fc1-74a17c68203c) or Windows Server 2025 or later. To unlock the preview feature, you must also install [Windows Server 2022 KB5035857 240302_030531 Feature Preview](https://download.microsoft.com/download/d/c/b/dcb54178-7997-4a5a-84bf-6269cfa3bb68/Windows%20Server%202022%20KB5035857%20240302_030531%20Feature%20Preview.msi).
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
  - Windows Server 2022 Datacenter: Azure Edition with the [March 12, 2024—KB5035857 Update](https://support.microsoft.com/topic/march-12-2024-kb5035857-os-build-20348-2340-a7953024-bae2-4b1a-8fc1-74a17c68203c). To unlock the preview feature, you must also install [Windows Server 2022 KB5035857 240302_030531 Feature Preview](https://download.microsoft.com/download/d/c/b/dcb54178-7997-4a5a-84bf-6269cfa3bb68/Windows%20Server%202022%20KB5035857%20240302_030531%20Feature%20Preview.msi).
  - Windows 11 with the [March 12, 2024—KB5035853 Update](https://support.microsoft.com/topic/march-12-2024-kb5035853-os-builds-22621-3296-and-22631-3296-a69ac07f-e893-4d16-bbe1-554b7d9dd39b). To unlock the preview feature, you must also install [Windows 11 (original release) KB5035854 240302_030535 Feature Preview](https://download.microsoft.com/download/9/7/e/97ecf574-855e-441c-9141-bfb61ec2074e/Windows%2011%20(original%20release)%20KB5035854%20240302_030535%20Feature%20Preview.msi).
  - Windows Server 2025 or later.
  - Windows 11, version 24H2 or later.
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

## Configure the SMB server

To manage the settings for the SMB client, it's necessary to first configure the SMB server to mandate that the client sends a valid and trusted certificate chain and to perform the access control checks based on the client certificate chain. To perform this action, run the following command:

```powershell
Set-SmbServerCertificateMapping -RequireClientAuthentication $true
```

> [!NOTE]
> If both **RequireClientAuthentication** and **SkipClientCertificateAccessCheck** are set to `$true`, the server verifies the validity and trustworthiness of the client certificate chain but does not perform access control checks.

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

### Test mapping connectivity

Run a connectivity test by mapping to a share for your server or client device. To perform this, run one of the following commands:

```cmd
NET USE \\<server DNS name>\<share name> /TRANSPORT:QUIC
```

Or

```powershell
New-SmbMapping -RemotePath \\<server DNS name>\<share name> -TransportType QUIC
```

If you receive an error message indicating that access was denied by the server, then you're ready to proceed to the next step as this verifies the server certificate mapping and client certificate mapping are configured.

## Configure client access control

### Grant individual clients

Follow the steps to grant a specific client access to the SMB server using client access control.

1. Sign in to the SMB server.

1. Open an elevated PowerShell prompt on the SMB server.

1. Run the `Grant-SmbClientAccessToServer` to grant access to the client certificate. Replace `<name>` with the SMB server's hostname and `<hash>` using the SHA256 client certificate identifier you gathered in the [Gather the SMB client certificate information](#gather-the-smb-client-certificate-information) section.

   ```powershell
   Grant-SmbClientAccessToServer -Name <name> -IdentifierType SHA256 -Identifier <hash>
   ```

You've now granted access to the client certificate. You can verify the client certificate access by running the `Get-SmbClientAccessToServer` cmdlet.

### Grant specific certification authorities

Follow the steps to grant clients from a specific certification authority, also known as an issuer, using client access control.

1. Sign in to the SMB server.

1. Open an elevated PowerShell prompt on the SMB server.

1. Run the `Grant-SmbClientAccessToServer` to grant access to the client certificate. Replace `<name>` with the SMB server's hostname and `<subject name>` with the complete X.500 distinguished name of the issuer certificate. For example, `CN=Contoso CA, DC=Contoso, DC=com`.

   ```powershell
   Grant-SmbClientAccessToServer -Name <name> -IdentifierType ISSUER -Identifier "<subject name>"
   ```

Once this step is complete, run the `New-SmbMapping` cmdlet as mentioned in [Test mapping connectivity](configure-smb-over-quic-client-access-control.md#test-mapping-connectivity), as a second run is recommended to verify that client access control has been correctly configured.

## Audit event logs

Certain events, such as access allowed and access denied, are captured for troubleshooting purposes. These events provide information about the client certificates (excluding the root certificate) such as the subject, issuer, serial number, SHA1 and SHA256 hash, and the access control entries that apply to these certificates. These events display a connection ID. This ID is displayed in certain client connectivity events, which allows the administrator to easily match the server with the client that attempted to establish the connection.

Auditing these events are disabled by default and can be enabled by running the following command:

```powershell
Set-SmbServerConfiguration -AuditClientCertificateAccess $true
```

Once enabled, these events are captured in the **Event Viewer** in the following paths:

| Path | Event ID |
|-|:-:|
| Applications and Services Logs\Microsoft\Windows\SMBServer\Audit | 3007 <br> 3008 <br> 3009 |
| Applications and Services Logs\Microsoft\Windows\SMBClient\Connectivity | 30831 |

## Related content

- [SMB over QUIC](smb-over-quic.md)
- [Storage at Microsoft blog](https://aka.ms/FileCab)
- [SmbShare module reference](/powershell/module/smbshare)
- [QUIC Working Group homepage](https://quicwg.org/)
- [Microsoft MsQuic GitHub homepage](https://github.com/microsoft/msquic)
- [QUIC Wikipedia](https://en.wikipedia.org/wiki/QUIC)
- [TLS 1.3 Working Group homepage](https://tlswg.org/)

