---
ms.assetid: a3f50046-5d48-43d3-b0f8-ac2346b15285
title: Managing SSL Certificates in AD FS and WAP in Windows Server 2016
description: Managing SSL Certificates in AD FS and WAP in Windows Server 2016
author: jenfieldmsft
ms.author: billmath
manager: samueld
ms.date: 10/02/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Managing SSL Certificates in AD FS and WAP in Windows Server 2016



This article describes how to deploy a new SSL certificate to your AD FS and WAP servers.

>[!NOTE]
>The recommended way to replace the SSL certificate going forward for an AD FS farm is to use Azure AD Connect.  For more information see [Update the SSL certificate for an Active Directory Federation Services (AD FS) farm](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update)

## Obtaining your SSL Certificates
For production AD FS farms a publicly trusted SSL certificate is recommended. This is usually obtained by submitting a certificate signing request (CSR) to a third party, public certificate provider. There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC. Your vendor should have documentation for this.

- Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements#BKMK_1)

### How many certificates are needed
It is recommended that you use a common SSL certificate across all AD FS and Web Application Proxy servers. For detailed requirements see the document [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements#BKMK_1)

### SSL Certificate Requirements
For requirements including naming, root of trust and extensions see the document [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements#BKMK_1)

## Replacing the SSL certificate for AD FS
> [!NOTE]
> The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in. To change the AD FS SSL certificate, you will need to use PowerShell.

First, determine which certificate binding mode your AD FS servers are running: default certificate authentication binding, or alternate client TLS binding mode.

### Replacing the SSL certificate for AD FS running in default certificate authentication binding mode
AD FS by default performs device certificate authentication on port 443 and user certificate authentication on port 49443 (or a configurable port that is not 443).
In this mode, use the powershell cmdlet Set-AdfsSslCertificate to manage the SSL certificate.

Follow the steps below:

1. First, you will need to obtain the new certificate. This is usually done by submitting a certificate signing request (CSR) to a third party, public certificate provider. There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC. Your vendor should have documentation for this.

    * Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements#BKMK_1)

1. Once you get the response from your certificate provider, import it to the Local Machine store on each AD FS and Web Application Proxy server.

1. On the **primary** AD FS server, use the following cmdlet to install the new SSL certificate

```powershell
Set-AdfsSslCertificate -Thumbprint '<thumbprint of new cert>'
```

The certificate thumbprint can be found by executing this command:

```powershell
dir Cert:\LocalMachine\My\
```

#### Additional Notes

* The Set-AdfsSslCertificate cmdlet is a multi-node cmdlet; this means it only has to run from the primary and all nodes in the farm will be updated. This is new in Server 2016. On Server 2012 R2 you had to run Set-AdfsSslCertificate on each server.
* The Set-AdfsSslCertificate cmdlet has to be run only on the primary server. The primary server has to be running Server 2016 and the Farm Behavior Level should be raised to 2016.
* The Set-AdfsSslCertificate cmdlet will use PowerShell Remoting to configure the other AD FS servers, make sure port 5985 (TCP) is open on the other nodes.
* The Set-AdfsSslCertificate cmdlet will grant the adfssrv principal read permissions to the private keys of the SSL certificate. This principal represents the AD FS service. It's not necessary to grant the AD FS service account read access to the private keys of the SSL certificate.

### Replacing the SSL certificate for AD FS running in alternate TLS binding mode
When configured in alternate client TLS binding mode, AD FS performs device certificate authentication on port 443 and user certificate authentication on port 443 as well, on a different hostname. The user certificate hostname is the AD FS hostname pre-pended with "certauth", for example "certauth.fs.contoso.com".
In this mode, use the powershell cmdlet Set-AdfsAlternateTlsClientBinding to manage the SSL certificate. This will manage not only the alternative client TLS binding but all other bindings on which AD FS sets the SSL certificate as well.

Follow the steps below:

1. First, you will need to obtain the new certificate. This is usually done by submitting a certificate signing request (CSR) to a third party, public certificate provider. There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC. Your vendor should have documentation for this.

    * Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements#BKMK_1)

1. Once you get the response from your certificate provider, import it to the Local Machine store on each AD FS and Web Application Proxy server.

1. On the **primary** AD FS server, use the following cmdlet to install the new SSL certificate

```powershell
Set-AdfsAlternateTlsClientBinding -Thumbprint '<thumbprint of new cert>'
```

The certificate thumbprint can be found by executing this command:

```powershell
dir Cert:\LocalMachine\My\
```

#### Additional Notes

* The Set-AdfsAlternateTlsClientBinding cmdlet is a multi-node cmdlet; this means it only has to run from the primary and all nodes in the farm will be updated.
* The Set-AdfsAlternateTlsClientBinding cmdlet has to be run only on the primary server. The primary server has to be running Server 2016 and the Farm Behavior Level should be raised to 2016.
* The Set-AdfsAlternateTlsClientBinding cmdlet will use PowerShell Remoting to configure the other AD FS servers, make sure port 5985 (TCP) is open on the other nodes.
* The Set-AdfsAlternateTlsClientBinding cmdlet will grant the adfssrv principal read permissions to the private keys of the SSL certificate. This principal represents the AD FS service. It's not necessary to grant the AD FS service account read access to the private keys of the SSL certificate.

## Replacing the SSL certificate for the Web Application Proxy
For configuring both the default certificate authentication binding or alternate client TLS binding mode on the WAP we can use the Set-WebApplicationProxySslCertificate cmdlet.
To replace the Web Application Proxy SSL certificate, on **each** Web Application Proxy server use the following cmdlet to install the new SSL certificate:

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

## Additional references  
* [AD FS support for alternate hostname binding for certificate authentication](../operations/AD-FS-support-for-alternate-hostname-binding-for-certificate-authentication.md)
* [AD FS and certificate KeySpec property Information](../technical-reference/AD-FS-and-KeySpec-Property.md)
