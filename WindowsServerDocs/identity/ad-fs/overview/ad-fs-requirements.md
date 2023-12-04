---
ms.assetid: 28f4a518-1341-4a10-8a4e-5f84625b314b
title: AD FS 2016 Requirements
description: Learn about the requirements for installing Active Directory Federation Services (ADFS) for your systems.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 09/21/2023
ms.topic: article
---

# AD FS Requirements

The following are the requirements for deploying Active Directory Federation Services (AD FS):

- [Certificate requirements](#certificate-requirements)

- [Hardware requirements](#hardware-requirements)

- [Proxy requirements](#proxy-requirements)

- [AD DS requirements](#ad-ds-requirements)

- [Configuration database requirements](#configuration-database-requirements)

- [Browser requirements](#browser-requirements)

- [Network requirements](#network-requirements)

- [Permissions requirements](#permissions-requirements)

## Certificate requirements

### TLS/SSL Certificates

Each AD FS and Web Application Proxy server has a TLS/SSL certificate to service HTTPS requests to the federation service.  The Web Application Proxy can have extra certificates to service requests to published applications.

#### Recommendations for TLS/SSL Certificates

Use the same TLS/SSL certificate for all AD FS federation servers and Web Application proxies.

#### Requirements for TLS/SSL Certificates

TLS/SSL certificates on federation servers must meet the following requirements:

- Certificate is publicly trusted (for production deployments).
- Certificate contains the Server Authentication Enhanced Key Usage (EKU) value.
- Certificate contains the federation service name, such as `fs.contoso.com` in the Subject or Subject Alternative Name (SAN).
- For user certificate authentication on port 443, certificate contains `certauth.\<federation service name\>`, such as `certauth.fs.contoso.com` in the SAN.
- For device registration or for modern authentication to on-premises resources using pre-Windows 10 clients, the SAN must contain `enterpriseregistration.\<upn suffix\>` for each User Principal Name (UPN) suffix in use in your organization.

TLS/SSL certificates on the Web Application Proxy must meet the following requirements:

- If the proxy is used to proxy AD FS requests that use Windows Integrated Authentication, the proxy TLS/SSL certificate must be the same (use the same key) as the federation server TLS/SSL certificate.
- If the AD FS property, **ExtendedProtectionTokenCheck**, is enabled (the default setting in AD FS), the proxy TLS/SSL certificate must be the same (use the same key) as the federation server TLS/SSL certificate.
- Otherwise, the requirements for the proxy TLS/SSL certificate are the same as the requirements for the federation server TLS/SSL certificate.

### Service Communication Certificate

This certificate isn't required for most AD FS scenarios including Microsoft Entra ID and Office 365.
By default, AD FS configures the TLS/SSL certificate provided upon initial configuration as the service communication certificate.

#### Recommendation for Service Communication Certificate

- Use the same certificate as you use for TLS/SSL.

### Token Signing Certificate

This certificate is used to sign issued tokens to relying parties, so relying party applications must recognize the certificate and its associated key as known and trusted. When the token signing certificate changes, such as when it expires and you configure a new certificate, all relying parties must be updated.

#### Recommendation for Token Signing Certificate

Use the AD FS default, internally generated, self-signed token signing certificates.

#### Requirements for Token Signing Certificate

- If your organization requires that certificates from the enterprise public key infrastructure (PKI) be used for token signing, you can meet this requirement by using the *SigningCertificateThumbprint* parameter of the **Install-AdfsFarm** cmdlet.
- Whether you use the default internally generated certificates or externally enrolled certificates, when the token signing certificate is changed you must ensure all relying parties are updated with the new certificate information. Otherwise, those relying parties can't sign in.

### Token Encrypting/Decrypting Certificate

This certificate is used by claims providers who encrypt tokens issued to AD FS.

#### Recommendation for Token Encrypting/Decrypting Certificate

Use the AD FS default, internally generated, self-signed token decrypting certificates.

#### Requirements for Token Encrypting/Decrypting Certificate

- If your organization requires that certificates from the enterprise PKI be used for token signing, you can meet this requirement by using the *DecryptingCertificateThumbprint* parameter of the **Install-AdfsFarm** cmdlet.
- Whether you use the default internally generated certificates or externally enrolled certificates, when the token decrypting certificate is changed you must ensure all claims providers are updated with the new certificate information.  Otherwise, sign ins using any claims providers not updated fail.

> [!CAUTION]
> Certificates that are used for token\-signing and token\-decrypting\/encrypting are critical to the stability of the Federation Service. Customers managing their own token\-signing & token\-decrypting\/encrypting certificates should ensure that these certificates are backed up and are available independently during a recovery event.

### User Certificates

- When you use x509 user certificate authentication with AD FS, all user certificates must chain up to a root certification authority that the AD FS and Web Application Proxy servers trust.

## Hardware requirements

AD FS and Web Application Proxy hardware requirements (physical or virtual) are gated on CPU, so you should size your farm for processing capacity.

- Use the [AD FS 2016 Capacity Planning spreadsheet](https://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx) to determine the number of AD FS and Web Application Proxy servers you need.

The memory and disk requirements for AD FS are fairly static. The requirements are shown in the following table:

|**Hardware requirement**|**Minimum requirement**|**Recommended requirement**|
|----- | ----- |-----|
|RAM|2 GB|4 GB |
|Disk space|32 GB|100 GB |

### SQL Server Hardware Requirements

If you're using Azure SQL for your AD FS configuration database, size the SQL Server according to the most basic SQL Server recommendations. The AD FS database size is small, and AD FS doesn't put a significant processing load on the database instance. AD FS does, however, connect to the database multiple times during an authentication, so the network connection should be robust. Unfortunately, SQL Azure isn't supported for the AD FS configuration database.

## Proxy requirements

- For extranet access, you must deploy the Web Application Proxy role service \- part of the Remote Access server role.

- Third-party proxies must support the [MS-ADFSPIP protocol](/openspecs/windows_protocols/ms-adfspip/76deccb1-1429-4c80-8349-d38e61da5cbb) to be supported as an AD FS proxy. For a list of third-party vendors, see the [Frequently asked questions (FAQ) about AD FS](AD-FS-FAQ.yml).

- AD FS 2016 requires Web Application Proxy servers on Windows Server 2016. A downlevel proxy can't be configured for an AD FS 2016 farm running at the 2016 farm behavior level.

- A federation server and the Web Application Proxy role service can't be installed on the same computer.

## AD DS requirements

### Domain controller requirements

- AD FS requires Domain controllers running Windows Server 2008 or later.

- At least one Windows Server 2016 domain controller is required for Windows Hello for Business.

> [!NOTE]
> All support for environments with Windows Server 2003 domain controllers has ended. For more information, see the [Microsoft lifecycle information](https://support.microsoft.com/lifecycle/search/default.aspx?sort=PN&alpha=Windows+Server+2003&Filter=FilterNO).

### Domain functional\-level requirements

- All user account domains and the domain to which the AD FS servers are joined must be operating at the domain functional level of Windows Server 2003 or later.

- A Windows Server 2008 domain functional level or later is required for client certificate authentication if the certificate is explicitly mapped to a user's account in AD DS.

### Schema requirements

- New installations of AD FS 2016 require the Active Directory 2016 schema (minimum version 85).

- Raising the AD FS farm behavior level (FBL) to the 2016 level requires the Active Directory 2016 schema (minimum version 85).

### Service account requirements

- Any standard domain account can be used as a service account for AD FS. Group Managed Service Accounts are also supported. The permissions required at runtime are automatically added back when you configure AD FS.

- The User Rights Assignment required for the AD service account is Sign-in as a Service.

- The User Rights Assignments required for the `NT Service\adfssrv` and `NT Service\drs` are Generate Security Audits and Sign-in as a Service.

- Group managed service accounts require at least one domain controller running Windows Server 2012 or later. The group Managed Service Account gMSA must live under the default `CN=Managed Service Accounts` container.

- For Kerberos authentication, the service principal name ‘`HOST/<adfs\_service\_name>`' must be registered on the AD FS service account. By default, AD FS configures this requirement when creating a new AD FS farm. If this process fails, such as if there's a collision or insufficient permissions, you see a warning and you should add it manually.

### Domain Requirements

- All AD FS servers must be a joined to an AD DS domain.

- All AD FS servers within a farm must be deployed in the same domain.

- AD FS farm first node installation depends on having the PDC available.

### Multi Forest Requirements

- The domain to which the AD FS servers are joined must trust every domain or forest that contains users authenticating to the AD FS service.

- The forest, that the AD FS service account is a member of, must trust all user sign-in forests.

- The AD FS service account must have permissions to read user attributes in every domain that contains users authenticating to the AD FS service.

## Configuration database requirements

This section describes the requirements and restrictions for AD FS farms that use respectively the Windows Internal Database (WID) or SQL Server as the database:

### WID

- The artifact resolution profile of SAML 2.0 isn't supported in a WID farm.

- Token replay detection isn't supported in a WID farm. This functionality is only used in scenarios where AD FS is acting as the federation provider and consuming security tokens from external claims providers.

The following table provides a summary of how many AD FS servers are supported in a WID vs a SQL Server farm.

| 1-100 RP Trusts | More than 100 RP Trusts |
|--|--|
| **1-30 AD FS Nodes:** WID supported | **1-30 AD FS Nodes:** Not supported using WID - SQL Required |
| **More than 30 AD FS Nodes:** Not supported using WID - SQL Required | **More than 30 AD FS Nodes:** Not supported using WID - SQL Required |

### SQL Server

- For AD FS in Windows Server 2016, SQL Server 2008 and later versions are supported.

- Both SAML artifact resolution and token replay detection are supported in a SQL Server farm.

## Browser requirements

When AD FS authentication is performed via a browser or browser control, your browser must comply with the following requirements:

- JavaScript must be enabled.

- For single sign-on, the client browser must be configured to allow cookies.

- Server Name Indication \(SNI\) must be supported.

- For user certificate & device certificate authentication, the browser must support TLS/SSL client certificate authentication.

- For seamless sign-on using Windows Integrated Authentication, the federation service name (such as `https:\/\/fs.contoso.com`) must be configured in local intranet zone or trusted sites zone.

## Network requirements

### Firewall Requirements

Both the firewalls located between the Web Application Proxy and the federation server farm and between the clients and the Web Application Proxy must have TCP port 443 enabled inbound.

Also, if you need client user certificate authentication (clientTLS authentication using X509 user certificates) and you don't have port 443 on the certauth endpoint enabled. AD FS 2016 requires that you enable TCP port 49443 inbound on the firewall between the clients and the Web Application Proxy. This requirement doesn't apply to the firewall between the Web Application Proxy and the federation servers.

For more information on hybrid port requirements, see [Hybrid Identity Required Ports and Protocols](/azure/active-directory/connect/active-directory-aadconnect-ports).

For more information, see [Best practices for securing Active Directory Federation Services](../deployment/Best-Practices-Securing-AD-FS.md)

### DNS Requirements

- For intranet access, all clients accessing AD FS service within the internal corporate network \(intranet\) must be able to resolve the AD FS service name to the load balancer for the AD FS servers or the AD FS server.

- For extranet access, all clients accessing AD FS service from outside the corporate network \(extranet\/internet\) must be able to resolve the AD FS service name to the load balancer for the Web Application Proxy servers or the Web Application Proxy server.

- Each Web Application Proxy server in the demilitarized zone (DMZ) must be able to resolve AD FS service name to the load balancer for the AD FS servers or the AD FS server. You can create this configuration by using an alternate Domain Name System (DNS) server in the DMZ network or by changing local server resolution using the HOSTS file.

- For Windows Integrated authentication, you must use a DNS A record \(not CNAME\) for the federation service name.

- For user certificate authentication on port 443, "certauth.\<federation service name\>" must be configured in DNS to resolve to the federation server or Web Application Proxy.

- For device registration or for modern authentication to on-premises resources using pre-Windows 10 clients, `enterpriseregistration.\<upn suffix\>`, for each UPN suffix in use in your organization, you must configure them to resolve to the federation server or Web Application Proxy.

### Load Balancer requirements

- The load balancer must not terminate TLS/SSL. AD FS supports multiple use cases with certificate authentication, which breaks when terminating TLS/SSL. Terminating TLS/SSL at the load balancer isn't supported for any use case.
- Use a load balancer that supports SNI. In the event it doesn't, using the 0.0.0.0 fallback binding on your AD FS or Web Application Proxy server should provide a workaround.
- Use the HTTP (not HTTPS) health probe endpoints to perform load balancer health checks for routing traffic. This requirement avoids any issues relating to SNI. The response to these probe endpoints is an HTTP 200 OK and is served locally with no dependence on back-end services. The HTTP probe can be accessed over HTTP using the path '/adfs/probe'
  - `http://<Web Application Proxy name>/adfs/probe`
  - `http://<AD FS server name>/adfs/probe`
  - `http://<Web Application Proxy IP address>/adfs/probe`
  - `http://<AD FS IP address>/adfs/probe`
- It's not recommended to use DNS round robin as a way to load balance. Using this type of load balancing doesn't provide an automated way to remove a node from the load balancer using health probes.
- It's not recommended to use IP-based session affinity or sticky sessions for authentication traffic to AD FS within the load balancer. You could cause an overload of certain nodes when using legacy authentication protocol for mail clients to connect to Office 365 mail services (Exchange Online).

## Permissions requirements

The administrator that performs the installation and the initial configuration of AD FS must have local administrator permissions on the AD FS server. If the local administrator doesn't have permissions to create objects in Active Directory, they must first have a domain admin create the required AD objects, then configure the AD FS farm using the *AdminConfiguration* parameter.
