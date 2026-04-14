---
title: AD FS Troubleshooting - Corporate Network Sign-In
description: Learn how to troubleshoot various aspects of Active Directory Federation Services (AD FS) sign-in from inside the corporate network.
ms.date: 01/23/2025
ms.topic: troubleshooting-general
---

# Users can't sign in by using AD FS from inside the corporate network

This article resolves sign-in issues with Active Directory Federation Services (AD FS) inside the corporate network. It doesn't cover seamless single sign-on/unexpected prompt configuration or troubleshooting of sign-in that happens via Web Application Proxy (WAP).

## Check AD FS servers

First, ensure that all AD FS servers are working as expected. Use the AD FS diagnostic script to automatically check the health of the AD FS servers in your farm.

 1. Go to [Offline tools](../operations/offline-tools.md), and download the diagnostic script from **Downloadable Tools**.
 1. Run the script on each AD FS server in the farm.
 1. Fix the errors reported.

## Check network settings

Check Domain Name System (DNS) and any load balancer settings.

### DNS and network checks for external access

If you have WAP servers:

- Ping the federation service name, for example, `fs.contoso.com`. Confirm if the IP address that it resolves to is one of the WAP servers or the load balancer in front of the WAP servers.
- In the DNS server hosting the service name externally, check that an A record for the federation service (for example, `fs.contoso.com`) points to the WAP server or load balancer in front of the WAP servers.

### Load balancer

- Check that the firewall isn't blocking traffic between AD FS and the load balancer, and between WAP and the load balancer.
- Check if the probe is enabled.
- Check if you're running Windows Server 2012 R2. Confirm that the August 2014 Windows Server 2012 R2 Update rollup (KB.2975719) is installed.
- Check if port 80 is enabled in the firewall on the WAP and AD FS servers.
- Ensure that the probe is set for port 80 and the endpoint is `/adfs/probe`.

### Firewall

Both the firewall located between WAP and the federation server farm and the firewall between the clients and WAP must have TCP port 443 enabled inbound.

Client Transport Layer Security (TLS) authentication using X509 user certificates might be required. If this client user certificate authentication is required, AD FS in Windows Server 2012 R2 requires that TCP port 49443 is enabled inbound on the firewall between the clients and WAP. This configuration isn't required on the firewall between WAP and the federation servers.

## Check the TLS/SSL certificate for corpnet access

If you have Microsoft Entra Connect, use it for managing the TLS/Secure Sockets Layer (SSL) certificates on your AD FS and WAP farm. For more information, see [Update the TLS/SSL certificate for AD FS](/entra/identity/hybrid/connect/how-to-connect-fed-ssl-update).

### Is the certificate from a trusted authority?

AD FS requires that the TLS/SSL certificate must be issued from a trusted root certificate authority. If you plan to access AD FS from nondomain-joined machines, we recommend that you get a certificate from a trusted third-party root certificate authority like DigiCert or VeriSign. If the certificate isn't from a trusted root certificate authority, TLS/SSL communication can break.

### Is the certificate subject name valid?

The subject name of the certificate should match the federation service name. It can also be listed as a subject alternate name. You can get the federation service name by using the following cmdlet on the AD FS primary server:

`Get-AdfsProperties | select hostname`

The certificate subject name can be the same as your AD FS server name.

### Is the certificate revoked?

Check for certificate revocation. If the certificate is revoked or you can't reach the revocation list, the TLS/SSL connection can't be trusted and clients block it.

### Ensure that the certificate is installed on all AD FS and WAP servers certificate stores

For successful configuration of the TLS/SSL certificate for your AD FS farm, store it in the local computer personal certificates store on each federation server in your farm. To install the certificate in the local computer personal store of each federation farm, double-click the .PFX file and complete the wizard. Ensure that the certificate is installed in the local computer personal certificates store on each federation server.

To confirm, open a Windows PowerShell window and run the following command to list the contents of the local machine store:

`PS:\>dir Cert:\LocalMachine\My`

### Ensure that the TLS/SSL certificate is installed on all AD FS servers in the farm

To get the current AD FS TLS/SSL certificate thumbprint, use the PowerShell cmdlet `Get-AdfsSslCertificate`.

If the thumbprint of the TLS/SSL certificate already configured doesn't match the expected certificate thumbprint, use the cmdlet `Set-AdfsSslCertificate –Thumbprint <thumbprint>`.

### Ensure that the certificate is set as the Service Communication certificate

The TLS/SSL certificate also needs to be the Service Communication certificate in your AD FS farm. This setup doesn't happen automatically. To do this step, select **MMC** > **Certificates** > **Set Service Communications Certificate**. If the Service Communication certificate isn't set properly, use the Microsoft Management Console (MMC) to set the correct certificate and follow these steps to set correct permissions on the new certificate.

 1. Add the Certificates snap-in to the MMC, and select **Computer account** > **Next**. Then select **Local computer** > **Finish**.
 1. Expand **Certificates (Local Computer)**, expand **Personal**, and select **Certificates**.
 1. Right-click your new TLS/SSL and Service Communications certificate, and select **All Tasks** > **Manage Private Keys**.
 1. Select **Add**.
 1. Select **Locations**.
 1. Select the local host name (not the directory) and select **OK**.
 1. In the **Enter the object names** field, enter `nt service\adfssrv` and select **Check names**. The name should resolve to the service `adfssrv`.
 1. Select **OK**.
 1. If you're using AD FS with Device Registration Service (DRS), in the **Enter the object names** field, enter `nt service\drs` and select **Check names**. The name should resolve to the service **DRS**. Select **OK**.
 1. Select the service and ensure that only **Read access** is selected. Select **OK** again.

### Does the certificate have all correct DRS names as SANs?

If you configured AD FS with DRS, make sure that your new TLS/SSL certificate for AD FS is also properly configured for DRS. For example, if there are two user principal name (UPN) suffixes, `contoso.com` and `fabrikam.com`, the certificate has `enterpriseregistration.contoso.com` and `enterpriseregistration.fabrikma.com` as subject alternate names (SANs).

Use `Get-AdfsDeviceRegistrationUpnSuffix` to find all the UPN suffixes that are used in the organization and whether the certificate has the required SANs configured.

### Check bindings and update if necessary

For addressing nonserver name indication cases, it's possible that administrators can specify fallback mappings. Other than the standard `federationservicename:443` binding, look for bindings under the two application IDs:

{5d89a20c-beab-4389-9447-324788eb944a} – AD FS App ID

{f955c070-e044-456c-ac00-e9e4275b3f04} – Web Application Proxy App ID

For example, if a binding for 0.0.0.0:443 was specified, this binding is for fallback. If the TLS/SSL certificate was specified for any binding like this, ensure that while you update the TLS/SSL certificate, such bindings are taken care of.

## Related content

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)
