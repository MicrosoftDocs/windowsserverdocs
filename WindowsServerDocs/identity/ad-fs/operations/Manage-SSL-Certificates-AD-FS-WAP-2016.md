---
ms.assetid: a3f50046-5d48-43d3-b0f8-ac2346b15285
title: Managing SSL Certificates in AD FS and WAP in Windows Server 2016
description: Managing SSL Certificates in AD FS and WAP in Windows Server 2016
author: jenfieldmsft
ms.author:  jenfieldmsft
manager: samueld
ms.date: 10/12/2016
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Managing SSL Certificates in AD FS and WAP in Windows Server 2016

>Applies To: Windows Server 2016

This article describes how to deploy a new SSL certificate to your AD FS and WAP servers.

## Obtaining your SSL Certificates
For production AD FS farms a publicly trusted SSL certificate is recommended. This is usually obtained by submitting a certificate signing request (CSR) to a third party, public certificate provider.  There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC.  Your vendor should have documentation for this.

- Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements)



### How many certificates are needed
It is recommended that you use a common SSL certificate across all AD FS and Web Application Proxy servers. For detailed requirements see the document [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements)

### SSL Certificate Requirements
For requirements including naming, root of trust and extensions see the document [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements)

## Replacing the SSL certificate for AD FS
First, determine which certificate binding mode your AD FS servers are running: default certificate authentication binding, or alternate client TLS binding mode.

### Replacing the SSL certificate for AD FS running in default certificate authentication binding mode
> Note: The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in.  To change the AD FS SSL certificate, you will need to use PowerShell.  

AD FS by default performs device certificate authentication on port 443 and user certificate authentication on port 49443 (or a configurable port that is not 443).
In this mode, use the powershell cmdlet Set-AdfsSslCertificate to manage the SSL certificate.

Follow the steps below:

1) First, you will need to obtain the new certificate.  This is usually done by submitting a certificate signing request (CSR) to a third party, public certificate provider.  There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC.  Your vendor should have documentation for this.

- Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements)

2) Once you get the response from your certificate provider, import it to the Local Machine store on each AD FS and Web Application Proxy server.

3) On each AD FS server, use the following cmdlet to install the new SSL certificate

    ```
    PS C:\> Set-AdfsSslCertificate -Thumbprint <thumbprint of new cert>
    ```

The certificate thumbprint can be found using the cmdlet

	PS C:\>dir Cert:\LocalMachine\My\

### Replacing the SSL certificate for AD FS running in alternate TLS binding mode
> Note: The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in.  To change the AD FS SSL certificate, you will need to use PowerShell.  

When configured in alternate client TLS binding mode, AD FS performs device certificate authentication on port 443 and user certificate authentication on port 443 as well, on a different hostname.  The user certificate hostname is the AD FS hostname pre-pended with "certauth", for example "certauth.fs.contoso.com".
In this mode, use the powershell cmdlet Set-AdfsAlternateTlsClientBinding to manage the SSL certificate.  This will manage not only the alternative client TLS binding but all other bindings on which AD FS sets the SSL certificate as well.

Follow the steps below:

1) First, you will need to obtain the new certificate.  This is usually done by submitting a certificate signing request (CSR) to a third party, public certificate provider.  There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC.  Your vendor should have documentation for this.

- Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements)

2) Once you get the response from your certificate provider, import it to the Local Machine store on each AD FS and Web Application Proxy server.

3) On each AD FS server, use the following cmdlet to install the new SSL certificate

    ```
    PS C:\> Set-AdfsAlternateTlsClientBinding -Thumbprint <thumbprint of new cert>
    ```

The certificate thumbprint can be found using the cmdlet

	PS C:\>dir Cert:\LocalMachine\My\

## Replacing the SSL certificate for the Web Application Proxy
To replace the Web Application Proxy SSL certificate, on each Web Application Proxy server use the following cmdlet to install the new SSL certificate:

    ```
    PS C:\> Set-WebApplicationProxySslCertificate <thumbprint of new cert>
    ```

If the above cmdlet fails because the old certificate has already expired, reconfigure the proxy using the following cmdlets:

	PS C:\>$cred = Get-Credential

Enter the credentials of a domain user who is local administrator on the AD FS server

	PS C:\>Install-WebApplicationProxy -FederationServiceTrustCredential $cred -CertificateThumbprint '<thumbprint of SSL cert in proxy LocalMachine store>' -FederationServiceName 'fs.contoso.com'

