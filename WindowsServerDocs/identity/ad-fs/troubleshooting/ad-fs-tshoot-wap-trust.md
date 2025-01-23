---
title: AD FS Troubleshooting - Proxy trust between WAP and AD FS broken
description: Learn how to troubleshoot various aspects of a broken trust between WAP and AD FS.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 10/14/2024
ms.topic: article
---




# Proxy trust between Web Application Proxy (WAP) and Active Directory Federation Service (AD FS) server is broken
This document helps to resolve issues with proxy trust configuration with AD FS. Use this document if you're seeing problems with your Web Application Proxy (WAP) trust configuration.

## Check for any time skew
Check the time on all AD FS and proxy servers to make sure that there's no time skew. If there's a skew, sync all system clocks with your organization's reliable time source.

## Check required updates are installed
If AD FS is installed on Windows Server 2012 R2, make sure that the following updates are installed:

Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 update: April 2014 https://support.microsoft.com/en-us/help/2919355
November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 https://support.microsoft.com/en-us/help/3000850/
December 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 https://support.microsoft.com/en-us/help/3013769
Time-out failures after initial deployment of Device Registration service in Windows Server 2012 R2 https://support.microsoft.com/en-us/help/3020773/

## Check SSL certificate settings
On the primary AD FS server, get the thumbprint of the SSL certificate by running the following cmdlet in PowerShell:

 1. `Get-AdfsCertificate -CertificateType Service-Communications | select Thumbprint`
 2. Run netsh http show sslcert on the first internal AD FS server.
 3. From the output above:
   - Make sure that the hostname matches the AD FS federation service name
   - Check the thumbprint against the certhash to make sure they match
   - Ensure that the CTL Store name is "AdfsTrustedDevices"
  - You may also see an IP Port binding for 0.0.0.0:443

Repeat step 2 and 3 for all AD FS and WAP servers.

## Update SSL certificate settings if needed
Use Azure AD Connect to update the SSL certificate on the impacted AD FS and WAP servers. Follow the instruction at [Update the SSL certificate for an Active Directory Federation Services (AD FS) farm](/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update)

## Check trusted root certificate store
Run the following PowerShell command on all ADFS and WAP servers to make sure that there are no non-self-signed certificates in the trusted root cert store>

 1. `Get-ChildItem cert:\LocalMachine\root -Recurse | Where-Object {$_.Issuer -ne $_.Subject} | Format-List * | Out-File "c:\computer_filtered.txt"`
 2. Move them to the intermediate store if they exist

## Update SSL certificate settings
Use Azure AD Connect to update the SSL certificate on the impacted AD FS and WAP servers. Follow the instruction at Update the SSL certificate for an Active Directory Federation Services (AD FS) farm

## Check for any AD FS replication errors
Check for any AD FS Replication Errors.

 1. Open the AD FS MMC on the secondary servers and look at the last time they synced.
 2. Fix any sync issues

## Service principal name
For proper WAP - AD FS communication, ensure that the correct service principal name (SPN) is configured on the AD FS service account. Run setspn -f -q host/&lt;federation service name&gt; and run setspn -f -q http/&lt;federation service name&gt; and correct any issues.

 1. HOST should resolve to the ADFS service account.
 2. HTTP call should resolve to one of the AD FS servers. If SPN lookup resolves to an unrelated computer account, the authentication between the servers fails.

## Reset WAP trust
If all else fails, reset the WAP trust using the Install-WebApplicationProxy PowerShell cmdlet

Example: If the thumbprint of the SSL cert is 3638de9b03a488341dfe32fc3ae5c480ee687793 and the federation service name is fs.contoso.com

Run, `Install-WebApplicationProxy -FederationServiceName fs.contoso.com -CertificateThumbprint "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"`



## Related links

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)