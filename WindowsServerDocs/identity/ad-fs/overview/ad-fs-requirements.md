---
ms.assetid: 28f4a518-1341-4a10-8a4e-5f84625b314b
title: AD FS 2016 Requirements
description: Requirements for installing Active Directory Federation Services.
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 03/06/2018
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---

# AD FS Requirements



The following are the requirements for deploying AD FS:  
  
-   [Certificate requirements](ad-fs-requirements.md#BKMK_1)  
  
-   [Hardware requirements](ad-fs-requirements.md#BKMK_2)  
  
-   [Proxy requirements](ad-fs-requirements.md#BKMK_3)  
  
-   [AD DS requirements](ad-fs-requirements.md#BKMK_4)  
  
-   [Configuration database requirements](ad-fs-requirements.md#BKMK_5)  
  
-   [Browser requirements](ad-fs-requirements.md#BKMK_6)  

-   [Network requirements](ad-fs-requirements.md#BKMK_7)  
  
-   [Permissions requirements](ad-fs-requirements.md#BKMK_13)  
  
## <a name="BKMK_1"></a>Certificate requirements  
  
### SSL Certificates

Each AD FS and Web Application Proxy server has an SSL certificate to service HTTPS requests to the federation service.  The Web Application Proxy can have additional SSL certificates to service requests to published applications.

**Recommendation:**
Use the same SSL certificate for all AD FS federation servers and Web Application proxies. 

**Requirements:**

SSL certificates on federation servers must meet the following requirements
- Certificate is publicly trusted (for production deployments)
- Certificate contains the Server Authentication Enhanced Key Usage (EKU) value
- Certificate contains the federation service name, such as "fs.contoso.com" in the Subject or Subject Alternative Name (SAN)
- For user certificate authentication on port 443, certificate contains "certauth.\<federation service name\>", such as "certauth.fs.contoso.com" in the SAN
- For device registration or for modern authentication to on premises resources using pre-Windows 10 clients, the SAN must contain "enterpriseregistration.\<upn suffix\>" for each UPN suffix in use in your organization.

SSL certificates on the Web Application Proxy must meet the following requirements
- If the proxy is used to proxy AD FS requests that use Windows Integrated Authentication, the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- If the AD FS property "ExtendedProtectionTokenCheck" is enabled (the default setting in AD FS), the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- Otherwise, the requirements for the proxy SSL certificate are the same as those for the federation server SSL certificate

### Service Communication Certificate
This certificate is not required for most AD FS scenarios including Azure AD and Office 365. 
By default, AD FS configures the SSL certificate provided upon initial configuration as the service communication certificate.

**Recommendation:**
- Use the same certificate as you use for SSL.  

### Token Signing Certificate
This certificate is used to sign issued tokens to relying parties, so relying party applications must recognize the certificate and it's associated key as known and trusted. When the token signing certificate changes, such as when it expires and you configure a new certificate, all relying parties must be updated.

**Recommendation:**
Use the AD FS default, internally generated, self-signed token signing certificates.  

**Requirements:**
- If your organization requires that certificates from the enterprise PKI be used for token signing, this can be done using the SigningCertificateThumbprint parameter of the Install-AdfsFarm cmdlet.
- Whether you use the default internally generated certificates or externally enrolled certificates, when the token signing certificate is changed you must ensure all relying parties are updated with the new certificate information.  Otherwise, logons to any relying parties not updated will fail.

### Token Encrypting/Decrypting Certificate
This certificate is used by claims providers who encrypt tokens issued to AD FS.

**Recommendation:**
Use the AD FS default, internally generated, self-signed token decrypting certificates.  

**Requirements:**
- If your organization requires that certificates from the enterprise PKI be used for token signing, this can be done using the DecryptingCertificateThumbprint parameter of the Install-AdfsFarm cmdlet.
- Whether you use the default internally generated certificates or externally enrolled certificates, when the token decrypting certificate is changed you must ensure all claims providers are updated with the new certificate information.  Otherwise, logons using any claims providers not updated will fail.
  
> [!CAUTION]  
> Certificates that are used for token\-signing and token\-decrypting\/encrypting are critical to the stability of the Federation Service. Customers managing their own token\-signing & token\-decrypting\/encrypting certificates should ensure that these certificates are backed up and are available independently during a recovery event.  

### User Certificates
- When using x509 user certificate authentication with AD FS, all user certificates must chain up to a root certification authority that is trusted by the AD FS and Web Application Proxy servers.

## <a name="BKMK_2"></a>Hardware requirements  
AD FS and Web Application Proxy hardware requirements (physical or virtual) are gated on CPU, so you should size your farm for processing capacity.  
- Use the [AD FS 2016 Capacity Planning spreadsheet](http://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx) to determine the number of AD FS and Web Application Proxy servers you will need.

The memory and disk requirements for AD FS are fairly static, see the table below:


|**Hardware requirement**|**Minimum requirement**|**Recommended requirement**|
|----- | ----- |-----|
|RAM|2 GB|4 GB |
|Disk space|32 GB|100 GB |

**SQL Server Hardware Requirements**

If you are using SQL Server for your AD FS configuration database, size the SQL Server according to the most basic SQL Server recommendations.  The AD FS database size is very small, and AD FS does not put a significant processing load on the database instance.  AD FS does, however, connect to the database multiple times during an authentication, so the network connection should be robust.  Unfortunately, SQL Azure is not supported for the AD FS configuration database.
  
## <a name="BKMK_3"></a>Proxy requirements  
  
-   For extranet access, you must deploy the Web Application Proxy role service \- part of the Remote Access server role. 

-   Third party proxies must support the [MS-ADFSPIP protocol](https://msdn.microsoft.com/library/dn392811.aspx) to be supported as an AD FS proxy.  For a list of 3rd party vendors see the [FAQ](AD-FS-FAQ.md).

-   AD FS 2016 requires Web Application Proxy servers on Windows Server 2016.  A downlevel proxy cannot be configured for an AD FS 2016 farm running at the 2016 farm behavior level.
  
-   A federation server and the Web Application Proxy role service cannot be installed on the same computer.  
  
## <a name="BKMK_4"></a>AD DS requirements  
**Domain controller requirements**  
  
- AD FS requires Domain controllers running Windows Server 2008 or later.

- At least one Windows Server 2016 domain controller is required for Microsoft Passport for Work.
  
> [!NOTE]  
> All support for environments with Windows Server 2003 domain controllers has ended. Visit [this page](https://support.microsoft.com/lifecycle/search/default.aspx?sort=PN&alpha=Windows+Server+2003&Filter=FilterNO) for additional information on the Microsoft Support Lifecycle.  
  
**Domain functional\-level requirements**  
  
 - All user account domains and the domain to which the AD FS servers are joined must be operating at the domain functional level of Windows Server 2003 or higher.  
  
 - A Windows Server 2008 domain functional level or higher is required for client certificate authentication if the certificate is explicitly mapped to a user's account in AD DS.  
  
**Schema requirements**  
  
-   New installations of AD FS 2016 require the Active Directory 2016 schema (minimum version 85).

-   Raising the AD FS farm behavior level (FBL) to the 2016 level requires the Active Directory 2016 schema (minimum version 85).  

  
**Service account requirements**  
  
-   Any standard domain account can be used as a service account for AD FS. Group Managed Service accounts are also supported. The permissions required at runtime will be added automatically when you configure AD FS.

-   The User Rights Assignment required for the AD service account is 'Log on as a Service'

-   The User Rights Assignments required for the 'NT Service\adfssrv' and 'NT Service\drs' are 'Generate Security Audits' and 'Log on as a Service'.

-   Group Managed service accounts require at least one domain controller running Windows Server 2012 or higher.  The GMSA must live under the default 'CN=Managed Service Accounts' container.  

-   For Kerberos authentication, the service principal name ‘`HOST/<adfs\_service\_name>`' must be registered on the AD FS service account. By default, AD FS will configure this when creating a new AD FS farm.  If this fails, such as in the case of a collision or insufficient permissions, you'll see a warning and you should add it manually.  
   
**Domain Requirements**  
  
-   All AD FS servers must be a joined to an AD DS domain.  
  
-   All AD FS servers within a farm must be deployed in the same domain.  
   
**Multi Forest Requirements**  
  
-   The domain to which the AD FS servers are joined must trust every domain or forest that contains users authenticating to the AD FS service.  

-   The forest, that the AD FS service account is a member of, must trust all user login forests. 
  
-   The AD FS service account must have permissions to read user attributes in every domain that contains users authenticating to the AD FS service.  
  
## <a name="BKMK_5"></a>Configuration database requirements  
This section describes the requirements and restrictions for AD FS farms that use respectively the Windows Internal Database (WID) or SQL Server as the database:  
  
**WID**  
  
-   The artifact resolution profile of SAML 2.0 is not supported in a WID farm.    

-   Token replay detection is not supported a WID farm. (This functionality is only used only in scenarios where AD FS is acting as the federation provider and consuming security tokens from external claims providers.)  
  
The following table provides a summary of how many AD FS servers are supported in a WID vs a SQL Server farm.    
  
  
|| 1 - 100 relying party (RP) trusts configured in AD FS | More than 100 RP trusts configured  |
| --- |--- | --- |
|1 - 30 AD FS servers|WID Supported|Not supported using WID - SQL Server required |
|More than 30 AD FS servers|Not supported using WID - SQL Server required|Not supported using WID - SQL Server required  
  
**SQL Server**  
  
- For AD FS in Windows Server 2016, SQL Server 2008 and higher versions are supported.

- Both SAML artifact resolution and token replay detection are supported in a SQL Server farm.  
  
## <a name="BKMK_6"></a>Browser requirements  
When AD FS authentication is performed via a browser or browser control, your browser must comply to the following requirements:  
  
- JavaScript must be enabled  
  
- For single sign on, the client browser must be configured to allow cookies  
  
- Server Name Indication \(SNI\) must be supported  
  
- For user certificate & device certificate authentication, the browser must support SSL client certificate authentication  

- For seamless sign on using Windows Integrated Authentication, the federation service name (such as https:\/\/fs.contoso.com) must be configured in local intranet zone or trusted sites zone.
  ## <a name="BKMK_7"></a>Network requirements  
 
**Firewall Requirements**  
  
Both the firewall located between the Web Application Proxy and the federation server farm and the firewall between the clients and the Web Application Proxy must have TCP port 443 enabled inbound.  
  
In addition, if client user certificate authentication \(clientTLS authentication using X509 user certificates\) is required and the certauth endpoint on port 443 is not enabled, AD FS 2016 requires that TCP port 49443 be enabled inbound on the firewall between the clients and the Web Application Proxy. This is not required on the firewall between the Web Application Proxy and the federation servers. 

For additional information on hybrid port requirements see [Hybrid Identity Ports and Protocols](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-ports). 

For additional information see [Best practices for securing Active Directory Federation Services](../deployment/Best-Practices-Securing-AD-FS.md)
  
**DNS Requirements**  
  
-   For intranet access, all clients accessing AD FS service within the internal corporate network \(intranet\) must be able to resolve the AD FS service name to the load balancer for the AD FS servers or the AD FS server.  
  
-   For extranet access, all clients accessing AD FS service from outside the corporate network \(extranet\/internet\) must be able to resolve the AD FS service name to the load balancer for the Web Application Proxy servers or the Web Application Proxy server.  
  
-   Each Web Application Proxy server in the DMZ must be able to resolve AD FS service name to the load balancer for the AD FS servers or the AD FS server. This can be achieved using an alternate DNS server in the DMZ network or by changing local server resolution using the HOSTS file.  
  
-   For Windows Integrated authentication, you must use a DNS A record \(not CNAME\) for the federation service name.  

-   For user certificate authentication on port 443, "certauth.\<federation service name\>" must be configured in DNS to resolve to the federation server or web application proxy.

-   For device registration or for modern authentication to on premises resources using pre-Windows 10 clients, "enterpriseregistration.\<upn suffix\>", for each UPN suffix in use in your organization, must be configured to resolve to the federation server or web application proxy.

**Load Balancer requirements**
- The load balancer MUST NOT terminate SSL. AD FS supports multiple use cases with certificate authentication which will break when terminating SSL. Terminating SSL at the load balancer is not supported for any use case. 
- It is recommended to use a load balancer that supports SNI. In the event it does not, using the 0.0.0.0 fallback binding on your AD FS / Web Application Proxy server should provide a workaround.
- It is recommended to use the HTTP (not HTTPS) health probe endpoints to perform load balancer health checks for routing traffic. This avoids any issues relating to SNI. The response to these probe endpoints is an HTTP 200 OK and is served locally with no dependence on back-end services. The HTTP probe can be accessed over HTTP using the path ‘/adfs/probe'
    - http://&lt;Web Application Proxy name&gt;/adfs/probe
    - http://&lt;ADFS server name&gt;/adfs/probe
    - http://&lt;Web Application Proxy IP address&gt;/adfs/probe
    - http://&lt;ADFS IP address&gt;/adfs/probe
- It is NOT recommended to use DNS round robin as a way to load balance. Using this type of load balancing does not provide an automated way to remove a node from the load balancer using health probes. 
- It is NOT recommended to use IP based session affinity or sticky sessions for authentication traffic to AD FS within the load balancer. This can cause an overload of certain nodes when using legacy authentication protocol for mail clients to connect to Office 365 mail services (Exchange Online). 

## <a name="BKMK_13"></a>Permissions requirements  
The administrator that performs the installation and the initial configuration of AD FS must have local administrator permissions on the AD FS server.  If the local administrator does not have permissions to create objects in Active Directory, they must first have a domain admin create the required AD objects, then configure the AD FS farm using the AdminConfiguration parameter.  
  
  

