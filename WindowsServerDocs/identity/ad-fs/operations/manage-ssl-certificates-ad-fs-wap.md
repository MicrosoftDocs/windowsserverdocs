---
ms.assetid: a3f50046-5d48-43d3-b0f8-ac2346b15285
title: Manage TLS/SSL Certificates in AD FS and WAP in Windows Server 2016
description: Learn how to manage TLS/SSL Certificates in Active Directory Federation Services (AD FS) and WAP in Windows Server 2016.
author: jenfieldmsft
ms.author: billmath
manager: amycolannino
ms.date: 06/12/2023
ms.topic: article
---

# Manage TLS/SSL certificates in AD FS and WAP in Windows Server 2016

This article describes how to deploy a new TLS/SSL certificate to your AD FS and WAP servers.

>[!NOTE]
>The recommended way to replace the TLS/SSL certificate going forward for an AD FS farm is to use Azure AD Connect. For more information, see [Update the SSL certificate for an Active Directory Federation Services (AD FS) farm](/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update).

## Obtain your TLS/SSL certificates

For production, AD FS farms a publicly trusted TLS/SSL certificate is recommended. This certificate is obtained by submitting a certificate signing request (CSR) to a third party, public certificate provider. There are various ways to generate the CSR, including from a Windows 7 or higher PC. Your vendor should have documentation for this process.

- Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](../overview/ad-fs-requirements.md#BKMK_1).

### How many certificates are needed

You should use a common TLS/SSL certificate across all AD FS and Web Application Proxy servers. For detailed requirements, see the document [AD FS and Web Application Proxy SSL certificate requirements](../overview/ad-fs-requirements.md#BKMK_1).

### TLS/SSL certificate requirements

For requirements including naming, root of trust and extensions see the document [AD FS and Web Application Proxy SSL certificate requirements](../overview/ad-fs-requirements.md#BKMK_1).

## Replace the TLS/SSL certificate for AD FS
>
> [!NOTE]
> The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in. To change the AD FS SSL certificate, you will need to use PowerShell.

First, determine which certificate binding mode your AD FS servers are running: default certificate authentication binding, or alternate client TLS binding mode.

### Replace the TLS/SSL certificate for AD FS running in default certificate authentication binding mode

AD FS by default performs device certificate authentication on port 443 and user certificate authentication on port 49443 (or a configurable port that isn't 443).
In this mode, use the PowerShell cmdlet Set-AdfsSslCertificate to manage the TLS/SSL certificate as shown in the following steps:

1. First, you need to obtain the new certificate. This procress is done by submitting a certificate signing request (CSR) to a third party, public certificate provider. There are various ways to generate the CSR, including from a Windows 7 or higher PC. Your vendor should have documentation for this process.

    - Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](../overview/ad-fs-requirements.md#BKMK_1)

1. Once you get the response from your certificate provider, import it to the Local Machine store on each AD FS and Web Application Proxy server.

1. On the **primary** AD FS server, use the following cmdlet to install the new TLS/SSL certificate

```powershell
Set-AdfsSslCertificate -Thumbprint '<thumbprint of new cert>'
```

The certificate thumbprint can be found by executing this command:

```powershell
dir Cert:\LocalMachine\My\
```

#### Other considerations TLS/SSL certificates in default certificate authentication binding mode

- The **Set-AdfsSslCertificate** cmdlet is a multi-node cmdlet, so it only has to run from the primary. The cmdlet also updates all nodes in the farm. This change is new in Server 2016. On Server 2012 R2, you had to run Set-AdfsSslCertificate on each server.
- The Set-AdfsSslCertificate cmdlet has to be run only on the primary server. The primary server has to be running Server 2016 and the Farm Behavior Level should be raised to 2016.
- The Set-AdfsSslCertificate cmdlet uses PowerShell Remoting to configure the other AD FS servers, make sure port 5985 (TCP) is open on the other nodes.
- The Set-AdfsSslCertificate cmdlet grants the adfssrv principal read permissions to the private keys of the TLS/SSL certificate. This principal represents the AD FS service. It's not necessary to grant the AD FS service account read access to the private keys of the TLS/SSL certificate.

### Replace the TLS/SSL certificate for AD FS running in alternate TLS binding mode

When configured in alternate client TLS binding mode, AD FS performs device certificate authentication on port 443. It also performs user certificate authentication on port 443 as well, on a different hostname. The user certificate hostname is the AD FS hostname prepended with `certauth`, for example `certauth.fs.contoso.com`.
In this mode, use the PowerShell cmdlet Set-AdfsAlternateTlsClientBinding to manage the TLS/SSL certificate. This cmdlet manages not only the alternative client TLS binding but all other bindings on which AD FS sets the TLS/SSL certificate as well.

Use the following steps to replacing your TLS/SSL certificate for AD FS running in alternate TLS binding mode.

1. First, you need to obtain the new certificate. This process is done by submitting a certificate signing request (CSR) to a third party, public certificate provider. There are various ways to generate the CSR, including from a Windows 7 or higher PC. Your vendor should have documentation for this process.

    - Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](../overview/ad-fs-requirements.md#BKMK_1)

1. Once you get the response from your certificate provider, import it to the Local Machine store on each AD FS and Web Application Proxy server.

1. On the **primary** AD FS server, use the following cmdlet to install the new TLS/SSL certificate

```powershell
Set-AdfsAlternateTlsClientBinding -Thumbprint '<thumbprint of new cert>'
```

The certificate thumbprint can be found by executing this command:

```powershell
dir Cert:\LocalMachine\My\
```

#### Other considerations for TLS/SSL certificates in alternate TLS binding mode

- The Set-AdfsAlternateTlsClientBinding cmdlet is a multi-node cmdlet, so it only has to run from the primary. The cmdlet also updates all nodes in the farm.
- The Set-AdfsAlternateTlsClientBinding cmdlet has to be run only on the primary server. The primary server has to be running Server 2016 and the Farm Behavior Level should be raised to 2016.
- The Set-AdfsAlternateTlsClientBinding cmdlet uses PowerShell Remoting to configure the other AD FS servers, make sure port 5985 (TCP) is open on the other nodes.
- The Set-AdfsAlternateTlsClientBinding cmdlet grants the adfssrv principal read permissions to the private keys of the TLS/SSL certificate. This principal represents the AD FS service. It's not necessary to grant the AD FS service account read access to the private keys of the TLS/SSL certificate.

## Replace the TLS/SSL certificate for the Web Application Proxy

If you want to configure both, the default certificate authentication binding or alternate client TLS binding mode on the WAP we can use the **Set-WebApplicationProxySslCertificate** cmdlet.
To replace the Web Application Proxy TLS/SSL certificate, on **each** Web Application Proxy server use the following cmdlet to install the new TLS/SSL certificate:

```powershell
Set-WebApplicationProxySslCertificate -Thumbprint '<thumbprint of new cert>'
```

If the above cmdlet fails because the old certificate has already expired, reconfigure the proxy using the following cmdlets:

```powershell
$cred = Get-Credential
```

Enter the credentials of a domain user who is local administrator on the AD FS server

```powershell
Install-WebApplicationProxy -FederationServiceTrustCredential $cred -CertificateThumbprint '<thumbprint of new cert>' -FederationServiceName 'fs.contoso.com'
```

## Related links

- [AD FS support for alternate hostname binding for certificate authentication](../operations/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication.md)

- [AD FS and certificate KeySpec property Information](../technical-reference/AD-FS-and-KeySpec-Property.md)
