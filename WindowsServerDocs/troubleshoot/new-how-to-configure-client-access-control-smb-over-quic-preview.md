title: Configure SMB over QUIC client access control in Windows Insider
description: Learn how to use SMB over QUIC client access control in Windows Insider
ms.topic: how-to
author: gswashington
ms.author: nedpyle
ms.date: 03/01/2024

---

# Configure SMB over QUIC client access control in Windows Insider

>Applies to: Windows and Windows Server Insider builds

SMB over QUIC represents an alternative to TCP and RDMA, supplying secure connectivity to edge file servers over untrusted networks like the Internet. SMB over QUIC CAC enhances security in the SMB over QUIC feature. This article explains how to configure SMB over QUIC client access control (CAC) in Windows and Windows Server Insider builds. See [SMB over QUIC](https://aka.ms/smboverquic) for detailed information on SMB over QUIC. 

Prior to the introduction of SMB over QUIC CAC, servers trusted all clients if they were issued the same certificate root chain as the server’s SMB over QUIC server certificate. With SMB over QUIC CAC, administrators can restrict which clients can access SMB over QUIC servers -- essentially an allowlist for devices trusted to connect to the file server. This functionality gives organizations more protection but doesn't change the Windows authentication used to make the SMB connection nor does it alter the end user experience.

>[!IMPORTANT]
>SMB over QUIC is not enabled by default. A file server administrator must opt in to enable SMB over QUIC. A client can't force a file server to enable SMB over QUIC.

SMB over QUIC CAC supports using certificates with subject alternative names and not just a single subject. This means the client access control feature supports using a Microsoft AD Certificate Authority and multiple endpoint names, just like the currently released version of SMB over QUIC. You can evaluate the feature using the recommended options and not require self-signed test certificates.

SMB over QUIC CAC works by a client trusting the SMB over QUIC server via a valid shared root authority key. An admin also gives the client a certificate from the same issuer, and that certificate’s hash (or issuer) is added to a trust list maintained by the server. When the client connects, it sends the certificate info to the server for comparison against the allow list, granting or denying access to QUIC. Then SMB authentication occurs inside the QUIC TLS tunnel, and the user connects to their share. An admin can also explicitly deny access or just revoke certificates. CAC is optional and – for now – not on by default.

You can remove specific SMB protocols from usage in your organization, blocking older, less secure, less capable Windows devices and third parties from connecting to the server. For example, you can limit users to SMB 3.1.1, the most secure dialect of the protocol.

## Configure SMB over QUIC CAC using PowerShell

### Prerequisites

- One Windows Server vNext Azure Edition Preview Build 25977 or later VM. You’re allowed to run Windows Server Azure Edition outside of Azure IaaS and Azure Stack HCI for evaluation and testing purposes.
- One Windows 11 Insider Preview Build 25977 (Canary Channel) or later client.

To configure SMB over QUIC CAC using a self-signed certificate, and administrator-elevated PowerShell:

# [PowerShell](#tab/powershell)

1. From an elevated PowerShell prompt on the SMB over QUIC server, run the following commands to create a server self-signed certificate (where “Server DNS name” is the fully-qualified name of the SMB over QUIC server):

```powershell
$serverCert = New-SelfSignedCertificate -DnsName Server DNS name -CertStoreLocation "Cert:\LocalMachine\My" -NotAfter (Get-Date).AddMonths(6) -KeyAlgorithm "RSA" -KeyLength "2048"
```

---

1. Configure the server certificate mapping requiring client authentication:

```powershell
New-SmbServerCertificateMapping -Name Server DNS name -Thumbprint $serverCert.Thumbprint -Store My -Requireclientauthentication $true
```

---

1. Export the certificate:

```powershell
Export-Certificate -Cert $serverCert -FilePath path\serverCert.cer
```

---

1. Copy the servercert.cer file to the client machine and on the client. Then open an administrator-elevated PowerShell console.

1. Install the certificate into the trusted root store on the client:

```powershell
Import-Certificate -FilePath path\serverCert.cer -CertStoreLocation Cert:\LocalMachine\root
```

---

1.Create the client’s certificate for use with the server allow list:

```powershell
$clientCert = New-SelfSignedCertificate -DnsName Server DNS name -CertStoreLocation "Cert:\LocalMachine\My" -NotAfter (Get-Date).AddMonths(6) -KeyAlgorithm "RSA" -KeyLength "2048"
```

---

1. Configure the client certificate mapping on the client machine:

```powershell
New-SmbClientCertificateMapping -Namespace Server DNS name -Thumbprint $clientCert.Thumbprint -Store My
```

---

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

1. Install the client certificate into the trusted root store on the server:

```powershell
Import-Certificate -FilePath path\ClientCert.cer -CertStoreLocation Cert:\LocalMachine\root
```

---

1. Grant access to the client by its SHA256 entry:

```powershell
Grant-SmbClientAccessToServer -Name Server DNS name -IdentifierType SHA256 -Identifier Cert Hash(sha256)
```

---

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

## Final notes

SMB over QUIC isn’t just for mobile users and edge servers in Internet DMZs, it’s a practical defensive layer to prevent leakage of NTLM credentials and makes attacking internal files servers harder without first subverting a trusted client. TCP had its time, QUIC is the future of user and application transport.

We also just announced that a replacement for KDC Proxy -  IAKerb - is coming to Windows Insider Previews along with a local KDC. These combined options mean the beginning of the end for NTLM, which will make SMB over QUIC Kerberos usage much easier. Read about it at The evolution of Windows authentication.    

## Related content

- [SMB over QUIC](https://aka.ms/smboverquic)

- []()
