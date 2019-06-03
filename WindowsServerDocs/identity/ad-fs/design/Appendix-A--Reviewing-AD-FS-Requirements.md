---
ms.assetid: 39ecc468-77c5-4938-827e-48ce498a25ad
title: Appendix A - Reviewing AD FS Requirements
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Appendix A: Reviewing AD FS Requirements

So that the organizational partners in your Active Directory Federation Services (AD FS) deployment can collaborate successfully, you must first make sure that your corporate network infrastructure is configured to support AD FS requirements for accounts, name resolution, and certificates. AD FS has the following types of requirements:  
  
> [!TIP]  
> You can find additional AD FS resource links at the [AD FS Content Map](https://social.technet.microsoft.com/wiki/contents/articles/2735.aspx) page on the Microsoft TechNet Wiki. This page is managed by members of the AD FS Community and is monitored on a regular basis by the AD FS Product Team.  
  
## Hardware requirements  
The following minimum and recommended hardware requirements apply to the federation server and federation server proxy computers.  
  
|Hardware requirement|Minimum requirement|Recommended requirement|  
|------------------------|-----------------------|---------------------------|  
|CPU speed|Single-core, 1 gigahertz (GHz)|Quad-core, 2 GHz|  
|RAM|1 GB|4 GB|  
|Disk space|50 MB|100 MB|  
  
## Software requirements  
AD FS relies on server functionality that is built into the Windows Server® 2012 operating system.  
  
> [!NOTE]  
> The Federation Service and Federation Service Proxy role services cannot coexist on the same computer.  
  
## Certificate requirements  
Certificates play the most critical role in securing communications between federation servers, federation server proxies, claims-aware applications, and Web clients. The requirements for certificates vary, depending on whether you are setting up a federation server or federation server proxy computer, as described in this section.  
  
### Federation server certificates  
Federation servers require the certificates in the following table.  
  
|Certificate type|Description|What you need to know before deploying|  
|--------------------|---------------|------------------------------------------|  
|Secure Sockets Layer (SSL) certificate|This is a standard Secure Sockets Layer (SSL) certificate that is used for securing communications between federation servers and clients.|This certificate must be bound to the Default Web Site in Internet Information Services (IIS) for a Federation Server or a Federation Server Proxy.  For a Federation Server Proxy, the binding must be configured in IIS prior to running the Federation Server Proxy Configuration Wizard successfully.<br /><br />**Recommendation:** Because this certificate must be trusted by clients of AD FS, use a server authentication certificate that is issued by a public (third-party) certification authority (CA), for example, VeriSign. **Tip:** The Subject name of this certificate is used to represent the Federation Service name for each instance of AD FS that you deploy. For this reason, you may want to consider choosing a Subject name on any new CA-issued certificates that best represents the name of your company or organization to partners.|  
|Service communication certificate|This certificate enables WCF message security for securing communications between federation servers.|By default, the SSL certificate is used as the service communications certificate.  This can be changed using the AD FS Management console.|  
|Token-signing certificate|This is a standard X509 certificate that is used for securely signing all tokens that the federation server issues.|The token-signing certificate must contain a private key, and it should chain to a trusted root in the Federation Service. By default, AD FS creates a self-signed certificate. However, you can change this later to a CA-issued certificate by using the AD FS Management snap-in, depending on the needs of your organization.|  
|Token-decryption certificate|This is a standard SSL certificate that is used to decrypt any incoming tokens that are encrypted by a partner federation server. It is also published in federation metadata.|By default, AD FS creates a self-signed certificate. However, you can change this later to a CA-issued certificate by using the AD FS Management snap-in, depending on the needs of your organization.|  
  
> [!CAUTION]  
> Certificates that are used for token-signing and token-decrypting are critical to the stability of the Federation Service. Because a loss or unplanned removal of any certificates that are configured for this purpose can disrupt service, you should back up any certificates that are configured for this purpose.  
  
For more information about the certificates that federation servers use, see [Certificate Requirements for Federation Servers](Certificate-Requirements-for-Federation-Servers.md).  
  
### Federation server proxy certificates  
Federation server proxies require the certificates in the following table.  
  
|Certificate type|Description|What you need to know before deploying|  
|--------------------|---------------|------------------------------------------|  
|Server authentication certificate|This is a standard Secure Sockets Layer (SSL) certificate that is used for securing communications between a federation server proxy and Internet client computers.|This certificate must be bound to the Default Web Site in Internet Information Services (IIS) before you can run the AD FS Federation Server Proxy Configuration Wizard successfully.<br /><br />**Recommendation:** Because this certificate must be trusted by clients of AD FS, use a server authentication certificate that is issued by a public (third-party) certification authority (CA), for example, VeriSign.<br /><br />**Tip:** The Subject name of this certificate is used to represent the Federation Service name for each instance of AD FS that you deploy. For this reason, you may want to consider choosing a Subject name that best represents the name of your company or organization to partners.|  
  
For more information about the certificates that federation server proxies use, see [Certificate Requirements for Federation Server Proxies](Certificate-Requirements-for-Federation-Server-Proxies.md).  
  
## Browser requirements  
Although any current Web browser with JavaScript capability can be made to work as an AD FS client, the Web pages that are provided by default have been tested only against Internet Explorer versions 7.0, 8.0 and 9.0, Mozilla Firefox 3.0, and Safari 3.1 on Windows. JavaScript must be enabled, and cookies must be enabled for browser-based sign-in and sign-out to work correctly.  
  
The AD FS product team at Microsoft successfully tested the browser and operating system configurations in the following table.  
  
|Browser|Windows 7|Windows Vista|  
|-----------|-------------|-----------------|  
|Internet Explorer 7.0|X|X|  
|Internet Explorer 8.0|X|X|  
|Internet Explorer 9.0|X|Not Tested|  
|FireFox 3.0|X|X|  
|Safari 3.1|X|X|  
  
> [!NOTE]  
> AD FS supports both the 32bit and 64bit versions of all the browsers showing in the above table.  
  
### Cookies  
AD FS creates session-based and persistent cookies that must be stored on client computers to provide sign-in, sign-out, single sign-on (SSO), and other functionality. Therefore, the client browser must be configured to accept cookies. Cookies that are used for authentication are always Secure Hypertext Transfer Protocol (HTTPS) session cookies that are written for the originating server. If the client browser is not configured to allow these cookies, AD FS cannot function correctly. Persistent cookies are used to preserve user selection of the claims provider. You can disable them by using a configuration setting in the configuration file for the AD FS sign-in pages.  
  
Support for TLS/SSL is required for security reasons.  
  
## Network requirements  
Configuring the following network services appropriately is critical for successful deployment of AD FS in your organization.  
  
### TCP/IP network connectivity  
For AD FS to function, TCP/IP network connectivity must exist between the client; a domain controller; and the computers that host the Federation Service, the Federation Service Proxy (when it is used), and the AD FS Web Agent.  
  
### DNS  
The primary network service that is critical to the operation of AD FS, other than Active Directory Domain Services (AD DS), is Domain Name System (DNS). When DNS is deployed, users can use friendly computer names that are easy to remember to connect to computers and other resources on IP networks.  
  
 Windows Server 2008  uses DNS for name resolution instead of the Windows Internet Name Service (WINS) NetBIOS name resolution that was used in Windows NT 4.0–based networks. It is still possible to use WINS for applications that require it. However, AD DS and AD FS require DNS name resolution.  
  
The process of configuring DNS to support AD FS varies, depending on whether:  
  
-   Your organization already has an existing DNS infrastructure. In most scenarios, DNS is already configured throughout your network so that Web browser clients in your corporate network have access to the Internet. Because Internet access and name resolution are requirements of AD FS, this infrastructure is assumed to be in place for your AD FS deployment.  
  
-   You intend to add a federated server to your corporate network. For the purpose of authenticating users in the corporate network, internal DNS servers in the corporate network forest must be configured to return the CNAME of the internal server that is running the Federation Service. For more information, see [Name Resolution Requirements for Federation Servers](Name-Resolution-Requirements-for-Federation-Servers.md).  
  
-   You intend to add a federated server proxy to your perimeter network. When you want to authenticate user accounts that are located in the corporate network of your identity partner organization, the internal DNS servers in the corporate network forest must be configured to return the CNAME of the internal federation server proxy. For information about how to configure DNS to accommodate the addition of federation server proxies, see [Name Resolution Requirements for Federation Server Proxies](Name-Resolution-Requirements-for-Federation-Server-Proxies.md).  
  
-   You are setting up DNS for a test lab environment. If you plan to use AD FS in a test lab environment where no single root DNS server is authoritative, it is probable that you will have to set up DNS forwarders so that queries to names between two or more forests will be forwarded appropriately. For general information about how to set up an AD FS test lab environment, see [AD FS Step-by-Step and How To Guides](https://go.microsoft.com/fwlink/?LinkId=180357).  
  
## Attribute store requirements  
AD FS requires at least one attribute store to be used for authenticating users and extracting security claims for those users. For a list of attribute stores that AD FS supports, see [The Role of Attribute Stores](../../ad-fs/technical-reference/The-Role-of-Attribute-Stores.md) in the AD FS Design Guide.  
  
> [!NOTE]  
> AD FS automatically creates an Active Directory attribute store, by default.  
  
Attribute store requirements depend on whether your organization is acting as the account partner (hosting the federated users) or the resource partner (hosting the federated application).  
  
### AD DS  
For AD FS to operate successfully, domain controllers in either the account partner organization or the resource partner organization must be running Windows Server 2003 SP1, Windows Server 2003 R2,  Windows Server 2008 , or  Windows Server 2012 .  
  
When AD FS is installed and configured on a domain-joined computer, the Active Directory user account store for that domain is made available as a selectable attribute store.  
  
> [!IMPORTANT]  
> Because AD FS requires the installation of Internet Information Services (IIS), we recommend that you not install the AD FS software on a domain controller in a production environment for security purposes. However, this configuration is supported by Microsoft Customer Service Support.  
  
#### Schema requirements  
AD FS does not require schema changes or functional-level modifications to AD DS.  
  
#### Functional-level requirements  
Most AD FS features do not require AD DS functional-level modifications to operate successfully. However, Windows Server 2008 domain functional level or higher is required for client certificate authentication to operate successfully if the certificate is explicitly mapped to a user's account in AD DS.  
  
#### Service account requirements  
If you are creating a federation server farm, you must first create a dedicated domain-based service account in AD DS that the Federation Service can use. Later, you configure each federation server in the farm to use this account. For more information about how to do this, see [Manually Configure a Service Account for a Federation Server Farm](../../ad-fs/deployment/Manually-Configure-a-Service-Account-for-a-Federation-Server-Farm.md) in the AD FS Deployment Guide.  
  
### LDAP  
When you work with other Lightweight Directory Access Protocol (LDAP)-based attribute stores, you must connect to an LDAP server that supports Windows Integrated authentication. The LDAP connection string must also be written in the format of an LDAP URL, as described in RFC 2255.  
  
### SQL Server  
For AD FS to operate successfully, computers that host the Structured Query Language (SQL) Server attribute store must be running either Microsoft SQL Server 2005 or SQL Server 2008. When you work with SQL-based attribute stores, you also must configure a connection string.  
  
### Custom attribute stores  
You can develop custom attribute stores to enable advanced scenarios. The policy language that is built into AD FS can reference custom attribute stores so that any of the following scenarios can be enhanced:  
  
-   Creating claims for a locally authenticated user  
  
-   Supplementing claims for an externally authenticated user  
  
-   Authorizing a user to obtain a token  
  
-   Authorizing a service to obtain a token on behavior of a user  
  
When you work with a custom attribute store, you may also have to configure a connection string. In this situation, you can enter any custom code you like that enables a connection to your custom attribute store. The connection string in this situation is a set of name/value pairs that are interpreted as implemented by the developer of the custom attribute store.  
  
For more information about developing and using custom attribute stores, see [Attribute Store Overview](https://go.microsoft.com/fwlink/?LinkId=190782).  
  
## Application requirements  
Federation servers can communicate with and protect federation applications, such as claims-aware applications.  
  
## Authentication requirements  
AD FS integrates naturally with existing Windows authentication, for example, Kerberos authentication, NTLM, smart cards, and X.509 v3 client-side certificates. Federation servers use standard Kerberos authentication to authenticate a user against a domain. Clients can authenticate by using forms-based authentication, smart card authentication, and Windows Integrated authentication, depending on how you configure authentication.  
  
The AD FS federation server proxy role makes possible a scenario in which the user authenticates externally using SSL client authentication. You can also configure the federation server role to require SSL client authentication, although typically the most seamless user experience is achieved by configuring the account federation server for Windows Integrated authentication. In this situation, AD FS has no control over what credentials the user employs for Windows desktop logon.  
  
### Smart card logon  
Although AD FS can enforce the type of credentials that it uses for authentication (passwords, SSL client authentication, or Windows Integrated authentication), it does not directly enforce authentication with smart cards. Therefore, AD FS does not provide a client-side user interface (UI) to obtain smart-card personal identification number (PIN) credentials. This is because Windows-based clients intentionally do not provide user credential details to federation servers or Web servers.  
  
### Smart card authentication  
Smart card authentication uses the Kerberos protocol to authenticate to an account federation server. AD FS cannot be extended to add new authentication methods. The certificate in the smart card is not required to chain up to a trusted root on the client computer. Use of a smart-card-based certificate with AD FS requires the following conditions:  
  
-   The reader and cryptographic service provider (CSP) for the smart card must work on the computer where the browser is located.  
  
-   The smart card certificate must chain up to a trusted root on the account federation server and the account federation server proxy.  
  
-   The certificate must map to the user account in AD DS by either of the following methods:  
  
    -   The certificate subject name corresponds to the LDAP distinguished name of a user account in AD DS.  
  
    -   The certificate subject altname extension has the user principal name (UPN) of a user account in AD DS.  
  
To support certain authentication strength requirements in some scenarios, it is also possible to configure AD FS to create a claim that indicates how the user was authenticated. A relying party can then use this claim to make an authorization decision.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
