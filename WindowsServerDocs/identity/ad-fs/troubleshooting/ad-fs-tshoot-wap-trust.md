---
title: AD FS Troubleshooting - Proxy Trust Between WAP and AD FS Is Broken
description: Learn how to troubleshoot various aspects of a broken trust between Web Application Proxy and Active Directory Federation Service (AD FS).
ms.date: 10/14/2024
ms.topic: troubleshooting-general
---

# Proxy trust between WAP and the AD FS server is broken

This article helps to resolve issues with proxy trust configuration with Active Directory Federation Service (AD FS). Use this article if you're seeing problems with your Web Application Proxy (WAP) trust configuration.

## Check for any time skew

Check the time on all AD FS and proxy servers to make sure that there's no time skew. If there's a skew, sync all system clocks with your organization's reliable time source.

## Check that required updates are installed

If AD FS is installed on Windows Server 2012 R2, make sure that the following updates are installed:

- [Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 update: April 2014](https://support.microsoft.com/en-us/help/2919355)
- [November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/en-us/help/3000850/)
- [December 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/en-us/help/3013769)
- [Time-out failures after initial deployment of Device Registration service in Windows Server 2012 R2](https://support.microsoft.com/en-us/help/3020773/)

## Check TLS/SSL certificate settings

On the primary AD FS server, get the thumbprint of the Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificate by running the following cmdlet in PowerShell:

 1. Run `Get-AdfsCertificate -CertificateType Service-Communications | select Thumbprint`.
 1. Run `netsh http show sslcert` on the first internal AD FS server.
 1. From the preceding output:
    - Make sure that the hostname matches the AD FS federation service name.
    - Check the thumbprint against the certhash to make sure they match.
    - Ensure that the Certificate Trust List (CTL) store name is `AdfsTrustedDevices`.
    - You might also see an IP port binding for `0.0.0.0:443`.

Repeat steps 2 and 3 for all AD FS and WAP servers.

## Update TLS/SSL certificate settings if needed

Use Microsoft Entra Connect to update the TLS/SSL certificate on the affected AD FS and WAP servers. Follow the instructions at [Update the TLS/SSL certificate for an Active Directory Federation Services farm](/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update).

## Check trusted root certificate store

Run the following PowerShell command on all AD FS and WAP servers to make sure that there are no non-self-signed certificates in the trusted root certificate store:

 1. Run `Get-ChildItem cert:\LocalMachine\root -Recurse | Where-Object {$_.Issuer -ne $_.Subject} | Format-List * | Out-File "c:\computer_filtered.txt"`.
 1. If they exist, move them to the intermediate store.

## Update TLS/SSL certificate settings

Use Microsoft Entra Connect to update the TLS/SSL certificate on the affected AD FS and WAP servers. Follow the instructions at [Update the TLS/SSL certificate for an Active Directory Federation Services farm](/azure/active-directory/connect/active-directory-aadconnectfed-ssl-update).

## Check for any AD FS replication errors

Check for any AD FS replication errors:

 1. Open the AD FS Microsoft Management Console on the secondary servers and look at the last time they synced.
 1. Fix any sync issues.

## Service principal name

For proper WAP and AD FS communication, ensure that the correct service principal name (SPN) is configured on the AD FS service account. Run `setspn -f -q host/ <federation service name>`, run `setspn -f -q http/ <federation service name>`, and correct any issues.

 - The host should resolve to the AD FS service account.
 - The HTTP call should resolve to one of the AD FS servers. If the SPN lookup resolves to an unrelated computer account, authentication between the servers fails.

## Reset WAP trust

If all else fails, reset the WAP trust by using the `Install-WebApplicationProxy` PowerShell cmdlet.

Example: If the thumbprint of the TLS/SSL certificate is `xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx` and the federation service name is `fs.contoso.com`, run `Install-WebApplicationProxy -FederationServiceName fs.contoso.com -CertificateThumbprint "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"`.

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
