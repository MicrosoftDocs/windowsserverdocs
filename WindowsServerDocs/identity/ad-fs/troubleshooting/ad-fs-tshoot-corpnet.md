---
title: AD FS Troubleshooting - Users can't login using AD FS from inside corpnet
description:  Learn how to troubleshoot various aspects of  AD FS login from inside corpnet.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 10/14/2024
ms.topic: article
---

# Users can't login using AD FS from inside corpnet

This document resolves sign-in issues with Active Directory Federation Services (AD FS) inside corpnet. It does not cover seamless SSO / unexpected prompt configuration or troubleshooting of sign-in happening via the Web Application Proxy (WAP).


## Check AD FS Servers
This is not a good situation, let's fix this quickly. First, ensure that all AD FS servers are working as expected. We will use the AD FS diagnostic script to automatically check the health of the AD FS servers in your farm.

 1. Go to [Offline tools](../operations/offline-tools.md) and download the diagnostic script from Downloadable Tools.
 2. Execute the script on each AD FS server in the farm
 3. Fix the errors reported

## Check Network Settings
Check DNS and any load balancer settings.

### DNS and network checks for external access

If you have Web Application Proxy (WAP) servers

- Ping the federation service name e.g. fs.contoso.com and confirm if the IP address that it resolves to is one of the WAP servers or the load balancer in front of the WAP servers.
- In the DNS server hosting the service name externally, check that there is an A record for the federation service (e.g. fs.contoso.com) pointing to the WAP server or load balancer in front of the WAP servers

### Load Balancer

- Check that the firewall is not blocking traffic between AD FS and the load balancer, and between WAP and the load balancer
- If probe is enabled
- If you are running Windows Server 2012 R2, confirm that the August 2014 Windows Server 2012 R2 Update rollup (KB.2975719) is installed
- Check if port 80 is enabled in the firewall on the WAP and AD FS servers
- Ensure that probe is set for port 80 and endpoint /adfs/probe

### Firewall

Both the firewall located between the Web Application Proxy and the federation server farm and the firewall between the clients and the Web Application Proxy must have TCP port 443 enabled inbound.

In addition, if client user certificate authentication (clientTLS authentication using X509 user certificates) is required, AD FS in Windows Server 2012 R2 requires that TCP port 49443 be enabled inbound on the firewall between the clients and the Web Application Proxy. This is not required on the firewall between the Web Application Proxy and the federation servers.


## Check the SSL certificate for corpnet access
If you have Azure AD Connect, you should use it for managing the SSL certificates on your AD FS and WAP farm. Refer to [Update the TLS/SSL certificate for an Active Directory Federation Services](/entra/identity/hybrid/connect/how-to-connect-fed-ssl-update)

### Is the certificate from a trusted authority?

AD FS requires that the SSL certificate be issued from a trusted root certificate authority. If AD FS is going to be accessed from non-domain joined machines, then it is suggested to get a certificate from a trusted third party root certificate authority like DigiCert, VeriSign, etc. If the certificate is not from a trusted root certificate authority, then SSL communication can break.

### Is the certificate subject name valid?

The subject name of the certificate should match the federation service name. It can also be listed as a subject alternate name. You can get the federation service name by using the following cmdlet on the AD FS primary server:

`Get-AdfsProperties | select hostname`
The certificate subject name cannot be the same as your AD FS server name

### Is the certificate revoked?

Check for certificate revocation. If the certificate is revoked or the revocation list cannot be reached, the SSL connection cannot be trusted and will be blocked by clients.

### Ensure the certificate is installed on all AD FS and WAP server's certificate stores

For successful configuration of the SSL certificate for your AD FS farm, it should be stored in the local computer personal certificates store on each federation server in your farm. You can install the certificate in the local computer personal store of each federation farm by double-clicking the .PFX file and completing the wizard. Ensure the certificate is installed in the local computer personal certificates store on each federation server.

`PS:\>dir Cert:\LocalMachine\My`
To confirm, open a Windows PowerShell window and execute the following command to list the contents of the local machine store:

### Check and ensure the SSL certificate is installed on all AD FS servers in the farm

To get the current AD FS SSL certificate thumbprint, use the PowerShell cmdlet: `Get-AdfsSslCertificate`

If the thumbprint of the SSL certificate already configured does not match the expected certificate thumbprint, use the cmdlet `Set-AdfsSslCertificate –Thumbprint <thumbprint>`.

### Ensure the certificate is set as the Service Communication certificate

The SSL certificate also needs to be the service communication certificate in your AD FS farm. This does not happen automatically. You can do this via the MMC -> Certificates -> Set Service Communications Certificate. If the Service Communication certificate is not set properly, use the MMC to set the correct certificate and follow the below steps to set correct permissions on the new certificate:

 1. Add the Certificates snap-in to MMC, select Computer account and click Next, then select Local computer and click Finish.
 2. Expand Certificates (Local Computer), expand Personal, and select Certificates.
 3. Right-click your new SSL and Service Communications certificate, select All Tasks, and select Manage Private Keys.
 4. Click Add...
 5. Click Locations...
 6. Select the local host name (not the directory) and click OK.
 7. In the Enter the object names field, type nt service\adfssrv and click Check names. The name should resolve to the service adfssrv
 8. Click OK.
 9. If you are using AD FS with DRS, in the Enter the object names field, type nt service\drs and click Check names. The name should resolve to the service DRS. Click OK.
 10. Select the service and ensure only Read access is selected. Click OK again.

### Certificate has all correct DRS names as subject alternate names (SAN)?

If you have configured AD FS with DRS, then you must make sure that your new SSL certificate for AD FS is also properly configured for DRS. For example, if there are two UPN suffixes - contoso.com and fabrikam.com, then the certificate has enterpriseregistration.contoso.com and enterpriseregistration.fabrikma.com as SANs.

Use `Get-AdfsDeviceRegistrationUpnSuffix` to find all the UPN suffixes being used in the organization and whether the certificate has the required SANs configured.

### Checking bindings and update if necessary

For addressing non-SNI cases, it is possible that administrators specify fallback mappings. Other than the standard federationservicename:443 binding, look for bindings under the two application IDs:

{5d89a20c-beab-4389-9447-324788eb944a} – AD FS App ID

{f955c070-e044-456c-ac00-e9e4275b3f04} – Web Application Proxy App ID

For exmple, if a binding for 0.0.0.0:443 has been specified, this is a binding for fallback. In case the SSL certificate has been specified for any binding like this, ensure that while updating the SSL certificate such bindings were taken care of.









## Related links

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)