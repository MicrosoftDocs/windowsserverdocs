---
ms.assetid: 8ce6e7c4-cf8e-4b55-980c-048fea28d50f
title: Federation Server Farm Using SQL Server
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# AD FS Requirements

The following are the various requirements that you must conform to when deploying AD FS:  
  
-   [Certificate requirements](AD-FS-Requirements.md#BKMK_1)  
  
-   [Hardware requirements](AD-FS-Requirements.md#BKMK_2)  
  
-   [Software requirements](AD-FS-Requirements.md#BKMK_3)  
  
-   [AD DS requirements](AD-FS-Requirements.md#BKMK_4)  
  
-   [Configuration database requirements](AD-FS-Requirements.md#BKMK_5)  
  
-   [Browser requirements](AD-FS-Requirements.md#BKMK_6)  
  
-   [Extranet requirements](AD-FS-Requirements.md#BKMK_extranet)  
  
-   [Network requirements](AD-FS-Requirements.md#BKMK_7)  
  
-   [Attribute store requirements](AD-FS-Requirements.md#BKMK_8)  
  
-   [Application requirements](AD-FS-Requirements.md#BKMK_9)  
  
-   [Authentication requirements](AD-FS-Requirements.md#BKMK_10)  
  
-   [Workplace join requirements](AD-FS-Requirements.md#BKMK_11)  
  
-   [Cryptography requirements](AD-FS-Requirements.md#BKMK_12)  
  
-   [Permissions requirements](AD-FS-Requirements.md#BKMK_13)  
  
## <a name="BKMK_1"></a>Certificate requirements  
Certificates play the most critical role in securing communications between federation servers, Web Application Proxies, claims\-aware applications, and Web clients. The requirements for certificates vary, depending on whether you are setting up a federation server or a proxy computer, as described in this section.  
  
**Federation server certificates**  
  
|||  
|-|-|  
|**Certificate type**|**Requirements, Support & Things to Know**|  
|**Secure Sockets Layer \(SSL\) certificate:** This is a standard SSL certificate that is used for securing communications between federation servers and clients.|-   This certificate must be a publicly trusted\* X509 v3 certificate.<br />-   All clients that access any AD FS endpoint must trust this certificate. It is strongly recommended to use certificates that are issued by a public \(third\-party\) certification authority \(CA\). You can use a self\-signed SSL certificate successfully on federation servers in a test lab environment. However, for a production environment, we recommend that you obtain the certificate from a public CA.<br />-   Supports any key size supported by Windows Server 2012 R2 for SSL certificates.<br />-   Does not support certificates that use CNG keys.<br />-   When used together with Workplace Join\/Device Registration Service, the subject alternative name of the SSL certificate for the AD FS service must contain the value enterpriseregistration that is followed by the User Principal Name \(UPN\) suffix of your organization, for example, enterpriseregistration.contoso.com.<br />-   Wild card certificates are supported. When you create your AD FS farm, you will be prompted to provide the service name for the AD FS service \(for example, **adfs.contoso.com**.<br />-   It is strongly recommended to use the same SSL certificate for the Web Application Proxy. This is however **required** to be the same when supporting Windows Integrated Authentication endpoints through the Web Application Proxy and when Extended Protection Authentication is turned on \(default setting\).<br />-   The Subject name of this certificate is used to represent the Federation Service name for each instance of AD FS that you deploy. For this reason, you may want to consider choosing a Subject name on any new CA\-issued certificates that best represents the name of your company or organization to partners.<br />    The identity of the certificate must match the federation service name \(for example, fs.contoso.com\).The identity is either a subject alternative name extension of type dNSName or, if there are no subject alternative name entries, the subject name specified as a common name. Multiple subject alternative name entries can be present in the certificate, provided one of them matches the federation service name.<br />-   **Important:** it’s strongly recommended to use the same SSL certificate across all nodes of your AD FS farm as well as all Web Application proxies in your AD FS farm.|  
|**Service communication certificate:** This certificate enables WCF message security for securing communications between federation servers.|-   By default, the SSL certificate is used as the service communications certificate.  But you also have the option to configure another certificate as the service communication certificate.<br />-   **Important:** if you are using the SSL certificate as the service communication certificate, when the SSL certificate expires, make sure to configure the renewed SSL certificate as your service communication certificate. This does not happen automatically.<br />-   This certificate must be trusted by clients of AD FS that use WCF Message Security.<br />-   We recommend that you use a server authentication certificate that is issued by a public \(third\-party\) certification authority \(CA\).<br />-   The service communication certificate cannot be a certificate that uses CNG keys.<br />-   This certificate can be managed using the AD FS Management console.|  
|**Token\-signing certificate:** This is a standard X509 certificate that is used for securely signing all tokens that the federation server issues.|-   By default, AD FS creates a self\-signed certificate with 2048 bit keys.<br />-   CA issued certificates are also supported and can be changed using the AD FS Management snap\-in<br />-   CA issued certificates must be stored & accessed through a CSP Crypto Provider.<br />-   The token signing certificate cannot be a certificate that uses CNG keys.<br />-   AD FS does not require externally enrolled certificates for token signing.<br />    AD FS automatically renews these self\-signed certificates before they expire, first configuring the new certificates as secondary certificates to allow for partners to consume them, then flipping to primary in a process called automatic certificate rollover.We recommend that you use the default, automatically generated certificates for token signing.<br />    If your organization has policies that require different certificates to be configured for token signing, you can specify the certificates at installation time using Powershell \(use the –SigningCertificateThumbprint parameter of the Install\-AdfsFarm cmdlet\).  After installation, you can view and manage token signing certificates using the AD FS Management console or Powershell cmdlets Set\-AdfsCertificate and Get\-AdfsCertificate.<br />    When externally enrolled certificates are used for token signing, AD FS does not perform automatic certificate renewal or rollover.  This process must be performed by an administrator.<br />    To allow for certificate rollover when one certificate is close to expiring, a secondary token signing certificate can be configured in AD FS. By default, all token signing certificates are published in federation metadata, but only the primary token\-signing certificate is used by AD FS to actually sign tokens.|  
|**Token\-decryption\/encryption certificate:** This is a standard X509 certificate that is used to decrypt\/encrypt any incoming tokens. It is also published in federation metadata.|- By default, AD FS creates a self\-signed certificate with 2048 bit keys.<br />-   CA issued certificates are also supported and can be changed using the AD FS Management snap\-in<br />-   CA issued certificates must be stored & accessed through a CSP Crypto Provider.<br />-   The token\-decryption\/encryption certificate cannot be a certificate that uses CNG keys.<br />-   By default, AD FS generates and uses its own, internally generated and self\-signed certificates for token decryption.  AD FS does not require externally enrolled certificates for this purpose.<br />    In addition, AD FS automatically renews these self\-signed certificates before they expire.<br />    **We recommend that you use the default, automatically generated certificates for token decryption.**<br />    If your organization has policies that require different certificates to be configured for token decryption, you can specify the certificates at installation time using Powershell \(use the –DecryptionCertificateThumbprint parameter of the Install\-AdfsFarm cmdlet\).  After installation, you can view and manage token decryption certificates using the AD FS Management console or Powershell cmdlets Set\-AdfsCertificate and Get\-AdfsCertificate.<br />    **When externally enrolled certificates are used for token decryption, AD FS does not perform automatic certificate renewal.  This process must be performed by an administrator**.<br />-   The AD FS service account must have access to the token\-signing certificate’s private key in the personal store of the local computer. This is taken care of by Setup. You can also use the AD FS Management snap\-in to ensure this access if you subsequently change the token\-signing certificate.|  
  
> [!CAUTION]  
> Certificates that are used for token\-signing and token\-decrypting\/encrypting are critical to the stability of the Federation Service. Customers managing their own token\-signing & token\-decrypting\/encrypting certificates should ensure that these certificates are backed up and are available independently during a recovery event.  
  
> [!NOTE]  
> In AD FS you can change the Secure Hash Algorithm \(SHA\) level that is used for digital signatures to either SHA\-1 or SHA\-256 \(more secure\). AD FS does not support the use of certificates with other hash methods, such as MD5 \(the default hash algorithm that is used with the Makecert.exe command\-line tool\). As a security best practice, we recommend that you use SHA\-256 \(which is set by default\) for all signatures. SHA\-1 is recommended for use only in scenarios in which you must interoperate with a product that does not support communications using SHA\-256, such as a non\-Microsoft product or legacy versions of AD FS.  
  
> [!NOTE]  
> After you receive a certificate from a CA, make sure that all certificates are imported into the personal certificate store of the local computer. You can import certificates to the personal store with the Certificates MMC snap\-in.  
  
## <a name="BKMK_2"></a>Hardware requirements  
The following minimum and recommended hardware requirements apply to the AD FS federation servers in Windows Server 2012 R2:  
  
||||  
|-|-|-|  
|**Hardware requirement**|**Minimum requirement**|**Recommended requirement**|  
|CPU speed|1.4 GHz 64\-bit processor|Quad\-core, 2 GHz|  
|RAM|512 MB|4 GB|  
|Disk space|32 GB|100 GB|  
  
## <a name="BKMK_3"></a>Software requirements  
The following AD FS requirements are for the server functionality that is built into the Windows Server® 2012 R2 operating system:  
  
-   For extranet access, you must deploy the Web Application Proxy role service \- part of the Windows Server® 2012 R2 Remote Access server role. Prior versions of a federation server proxy are not supported with AD FS in Windows Server® 2012 R2.  
  
-   A federation server and the Web Application Proxy role service cannot be installed on the same computer.  
  
## <a name="BKMK_4"></a>AD DS requirements  
**Domain controller requirements**  
  
Domain controllers in all user domains and the domain to which the AD FS servers are joined must be running Windows Server 2008 or later.  
  
> [!NOTE]  
> All support for environments with Windows Server 2003 domain controllers will end after the Extended Support End Date for Windows Server 2003. Customers are strongly recommended to upgrade their domain controllers as soon as possible. Visit [this page](https://support.microsoft.com/lifecycle/search/default.aspx?sort=PN&alpha=Windows+Server+2003&Filter=FilterNO) for additional information on Microsoft Support Lifecycle. For issues discovered that are specific to Windows Server 2003 domain controller environments, fixes will be issued only for security issues and if a fix can be issued prior to the expiry of Extended Support for Windows Server 2003.  
  
**Domain functional\-level requirements**  
  
All user account domains and the domain to which the AD FS servers are joined must be operating at the domain functional level of Windows Server 2003 or higher.  
  
Most AD FS features do not require AD DS functional\-level modifications to operate successfully. However, Windows Server 2008 domain functional level or higher is required for client certificate authentication to operate successfully if the certificate is explicitly mapped to a user's account in AD DS.  
  
**Schema requirements**  
  
-   AD FS does not require schema changes or functional\-level modifications to AD DS.  
  
-   To use Workplace Join functionality, the schema of the forest that AD FS servers are joined to must be set to Windows Server 2012 R2.  
  
**Service account requirements**  
  
-   Any standard service account can be used as a service account for AD FS. Group Managed Service accounts are also supported. This requires at least one domain controller \(it is recommended that you deploy two or more\) that is running Windows Server 2012 or higher.  
  
-   For Kerberos authentication to function between domain\-joined clients and AD FS, the ‘HOST\/<adfs\_service\_name>’ must be registered as a SPN on the service account. By default, AD FS will configure this when creating a new AD FS farm if it has sufficient permissions to perform this operation.  
  
-   The AD FS service account must be trusted in every user domain that contains users authenticating to the AD FS service.  
  
**Domain Requirements**  
  
-   All AD FS servers must be a joined to an AD DS domain.  
  
-   All AD FS servers within a farm must be deployed in a single domain.  
  
-   The domain that the AD FS servers are joined to must trust every user account domain that contains users authenticating to the AD FS service.  
  
**Multi Forest Requirements**  
  
-   The domain that the AD FS servers are joined to must trust every user account domain or forest that contains users authenticating to the AD FS service.  
  
-   The AD FS service account must be trusted in every user domain that contains users authenticating to the AD FS service.  
  
## <a name="BKMK_5"></a>Configuration database requirements  
The following are the requirements and restrictions that apply based on the type of configuration store:  
  
**WID**  
  
-   A WID farm has a limit of 30 federation servers if you have 100 or fewer relying party trusts.  
  
-   Artifact resolution profile in SAML 2.0 is not supported in the WID configuration database.  Token Replay Detection is not supported in the WID configuration database. This functionality is only used only in scenarios where AD FS is acting as the federation provider and consuming security tokens from external claims providers.  
  
-   Deploying AD FS servers in distinct data centers for failover or geographic load balancing is supported as long as the number of servers does not exceed 30.  
  
The following table provides a summary for using a WID farm.  Use it to plan your implementation.  
  
||||  
|-|-|-|  
||1 \- 100 RP Trusts|More than 100 RP Trusts|  
|1 \- 30 AD FS Nodes|WID Supported|Not supported using WID \- SQL Required|  
|More than 30 AD FS Nodes|Not supported using WID \- SQL Required|Not supported using WID \- SQL Required|  
  
**SQL Server**  
  
For AD FS in Windows Server 2012 R2, you can use SQL Server 2008 and higher  
  
## <a name="BKMK_6"></a>Browser requirements  
When AD FS authentication is performed via a browser or browser control, your browser must comply to the following requirements:  
  
-   JavaScript must be enabled  
  
-   Cookies must be turned on  
  
-   Server Name Indication \(SNI\) must be supported  
  
-   For user certificate & device certificate authentication \(workplace join functionality\), the browser must support SSL client certificate authentication  
  
Several key browsers and platforms have undergone validation for rendering and functionality the details of which are listed below. Browsers and devices that not covered in this table are still supported if they meet the requirements listed above:  
  
|||  
|-|-|  
|**Browsers**|**Platforms**|  
|IE 10.0|Windows 7, Windows 8.1, Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2|  
|IE 11.0|Windows7, Windows 8.1, Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2|  
|Windows Web Authentication Broker|Windows 8.1|  
|Firefox \[v21\]|Windows 7, Windows 8.1|  
|Safari \[v7\]|iOS 6, Mac OS\-X 10.7|  
|Chrome \[v27\]|Windows 7, Windows 8.1, Windows Server 2012, Windows Server 2012 R2, Mac OS\-X 10.7|  
  
> [!IMPORTANT]  
> Known issue \- Firefox: Workplace Join functionality that identifies the device using device certificate is not functional on Windows platforms. Firefox does not currently support performing SSL client certificate authentication using certificates provisioned to the user certificate store on Windows clients.  
  
**Cookies**  
  
AD FS creates session\-based and persistent cookies that must be stored on client computers to provide sign\-in, sign\-out, single sign\-on \(SSO\), and other functionality. Therefore, the client browser must be configured to accept cookies. Cookies that are used for authentication are always Secure Hypertext Transfer Protocol \(HTTPS\) session cookies that are written for the originating server. If the client browser is not configured to allow these cookies, AD FS cannot function correctly. Persistent cookies are used to preserve user selection of the claims provider. You can disable them by using a configuration setting in the configuration file for the AD FS sign\-in pages. Support for TLS\/SSL is required for security reasons.  
  
## <a name="BKMK_extranet"></a>Extranet requirements  
To provide extranet access to the AD FS service, you must deploy the Web Application Proxy role service as the extranet facing role that proxies authentication requests in a secure manner to the AD FS service. This provides isolation of the AD FS service endpoints as well as isolation of all security keys \(such as token signing certificates\) from requests that originate from the internet. In addition, features such as Soft Extranet Account Lockout require the use of the Web Application Proxy. For more information about Web Application Proxy, see [Web Application Proxy](https://technet.microsoft.com/library/dn584107.aspx).  
  
If you want to use a third\-party proxy for extranet access, this third\-party proxy must support the protocol defined in [http:\/\/download.microsoft.com\/download\/9\/5\/E\/95EF66AF\-9026\-4BB0\-A41D\-A4F81802D92C\/%5bMS\-ADFSPIP%5d.pdf](https://download.microsoft.com/download/9/5/E/95EF66AF-9026-4BB0-A41D-A4F81802D92C/%5bMS-ADFSPIP%5d.pdf).  
  
## <a name="BKMK_7"></a>Network requirements  
Configuring the following network services appropriately is critical for successful deployment of AD FS in your organization:  
  
**Configuring Corporate Firewall**  
  
Both the firewall located between the Web Application Proxy and the federation server farm and the firewall between the clients and the Web Application Proxy must have TCP port 443 enabled inbound.  
  
In addition, if client user certificate authentication \(clientTLS authentication using X509 user certificates\) is required, AD FS in Windows Server 2012 R2 requires that TCP port 49443 be enabled inbound on the firewall between the clients and the Web Application Proxy. This is not required on the firewall between the Web Application Proxy and the federation servers\).  
  
**Configuring DNS**  
  
-   For intranet access, all clients accessing AD FS service within the internal corporate network \(intranet\) must be able to resolve the AD FS service name \(name provided by the SSL certificate\) to the load balancer for the AD FS servers or the AD FS server.  
  
-   For extranet access, all clients accessing AD FS service from outside the corporate network \(extranet\/internet\) must be able to resolve the AD FS service name \(name provided by the SSL certificate\) to the load balancer for the Web Application Proxy servers or the Web Application Proxy server.  
  
-   For extranet access to function properly, each Web Application Proxy server in the DMZ must be able to resolve AD FS service name \(name provided by the SSL certificate\) to the load balancer for the AD FS servers or the AD FS server. This can be achieved using an alternate DNS server in the DMZ network or by changing local server resolution using HOSTS file.  
  
-   For Windows Integrated authentication to work inside the network and outside the network for a subset of endpoints exposed through the Web Application Proxy, you must use an A record \(not CNAME\) to point to the load balancers.  
  
For information on configuring corporate DNS for the federation service and Device Registration Service, see [Configure Corporate DNS for the Federation Service and DRS](https://technet.microsoft.com/library/dn486786.aspx).  
  
For information on configuring corporate DNS for Web Application proxies, see the “Configure DNS” section in [Step 1: Configure the Web Application Proxy Infrastructure](https://technet.microsoft.com/library/dn383644.aspx).  
  
For information about how to configure a cluster IP address or cluster FQDN using NLB, see Specifying the Cluster Parameters at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=75282](https://go.microsoft.com/fwlink/?LinkId=75282).  
  
## <a name="BKMK_8"></a>Attribute store requirements  
AD FS requires at least one attribute store to be used for authenticating users and extracting security claims for those users. For a list of attribute stores that AD FS supports, see [The Role of Attribute Stores](../../ad-fs/technical-reference/The-Role-of-Attribute-Stores.md).  
  
> [!NOTE]  
> AD FS automatically creates an “Active Directory” attribute store, by default. Attribute store requirements depend on whether your organization is acting as the account partner \(hosting the federated users\) or the resource partner \(hosting the federated application\).  
  
**LDAP Attribute Stores**  
  
When you work with other Lightweight Directory Access Protocol \(LDAP\)\-based attribute stores, you must connect to an LDAP server that supports Windows Integrated authentication. The LDAP connection string must also be written in the format of an LDAP URL, as described in RFC 2255.  
  
It is also required that the service account for the AD FS service has the right to retrieve user information in the LDAP attribute store.  
  
**SQL Server Attribute Stores**  
  
For AD FS in Windows Server 2012 R2 to operate successfully, computers that host the SQL Server attribute store must be running either Microsoft SQL Server 2008 or higher. When you work with SQL\-based attribute stores, you also must configure a connection string.  
  
**Custom Attribute Stores**  
  
You can develop custom attribute stores to enable advanced scenarios.  
  
-   The policy language that is built into AD FS can reference custom attribute stores so that any of the following scenarios can be enhanced:  
  
    -   Creating claims for a locally authenticated user  
  
    -   Supplementing claims for an externally authenticated user  
  
    -   Authorizing a user to obtain a token  
  
    -   Authorizing a service to obtain a token on behavior of a user  
  
    -   Issuing additional data in security tokens issued by AD FS to relying parties.  
  
-   All custom attribute stores must be built on top of .NET 4.0 or higher.  
  
When you work with a custom attribute store, you might also have to configure a connection string. In that case, you can enter a custom code of your choice that enables a connection to your custom attribute store. The connection string in this situation is a set of name\/value pairs that are interpreted as implemented by the developer of the custom attribute store.For more information about developing and using custom attribute stores, see [Attribute Store Overview](https://go.microsoft.com/fwlink/?LinkId=190782).  
  
## <a name="BKMK_9"></a>Application requirements  
AD FS supports claims\-aware applications that use the following protocols:  
  
-   WS\-Federation  
  
-   WS\-Trust  
  
-   SAML 2.0 protocol using IDPLite, SPLite & eGov1.5 profiles.  
  
-   OAuth 2.0 Authorization Grant Profile  
  
AD FS also supports authentication and authorization for any non\-claims\-aware applications that are supported by the Web Application Proxy.  
  
## <a name="BKMK_10"></a>Authentication requirements  
**AD DS Authentication \(Primary Authentication\)**  
  
For intranet access, the following standard authentication mechanisms for AD DS are supported:  
  
-   Windows Integrated Authentication using Negotiate for Kerberos & NTLM  
  
-   Forms Authentication using username\/passwords  
  
-   Certificate Authentication using certificates mapped to user accounts in AD DS  
  
For extranet access, the following authentication mechanisms are supported:  
  
-   Forms Authentication using username\/passwords  
  
-   Certificate Authentication using certificates that are mapped to user accounts in AD DS  
  
-   Windows Integrated Authentication using Negotiate \(NTLM only\) for WS\-Trust endpoints that accept Windows Integrated Authentication.  
  
For Certificate Authentication:  
  
-   Extends to smartcards that can be pin protected.  
  
-   The GUI for the user to enter their pin is not provided by AD FS and is required to be part of the client operating system that is displayed when using client TLS.  
  
-   The reader and cryptographic service provider \(CSP\) for the smart card must work on the computer where the browser is located.  
  
-   The smart card certificate must chain up to a trusted root on all the AD FS servers and Web Application Proxy servers.  
  
-   The certificate must map to the user account in AD DS by either of the following methods:  
  
    -   The certificate subject name corresponds to the LDAP distinguished name of a user account in AD DS.  
  
    -   The certificate subject altname extension has the user principal name \(UPN\) of a user account in AD DS.  
  
For seamless Windows Integrated Authentication using Kerberos in the intranet,  
  
-   It is required for the service name to be part of the Trusted Sites or the Local Intranet sites.  
  
-   In addition, the HOST\/<adfs\_service\_name> SPN must be set on the service account that the AD FS farm runs on.  
  
**Multi\-Factor Authentication**  
  
AD FS supports additional authentication \(beyond primary authentication supported by AD DS\) using a provider model whereby vendors\/customers can build their own multi\-factor authentication adapter that an administrator can register and use during login.  
  
Every MFA adapter must be built on top of .NET 4.5.  
  
For more information on MFA, see [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../../ad-fs/operations/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).  
  
**Device Authentication**  
  
AD FS supports device authentication using certificates provisioned by the Device Registration Service during the act of an end user workplace joining their device.  
  
## <a name="BKMK_11"></a>Workplace join requirements  
End users can workplace join their devices to an organization using AD FS. This is supported by the Device Registration Service in AD FS. As a result, end users get the additional benefit of SSO across the applications supported by AD FS. In addition, administrators can manage risk by restricting access to applications only to devices that have been workplace joined to the organization. Below are the following requirements to enable this scenario.  
  
-   AD FS supports workplace join for Windows 8.1 and iOS 5\+ devices  
  
-   To use Workplace Join functionality, the schema of the forest that AD FS servers are joined to must be Windows Server 2012 R2.  
  
-   The subject alternative name of the SSL certificate for AD FS service must contain the value enterpriseregistration that is followed by the User Principal Name \(UPN\) suffix of your organization, for example, enterpriseregistration.corp.contoso.com.  
  
## <a name="BKMK_12"></a>Cryptography requirements  
The following table provides additional cryptography support information on the AD FS token signing, token encryption\/decryption functionality:  
  
||||  
|-|-|-|  
|**Algorithm**|**Key lengths**|**Protocols\/Applications\/Comments**|  
|TripleDES – Default 192 \(Supported 192 – 256\) \- [http:\/\/www.w3.org\/2001\/04\/xmlenc\#tripledes\-cbc](http://www.w3.org/2001/04/xmlenc)|>\= 192|Supported algorithm for Decrypting the security token. Encrypting the security token with this algorithm is not supported.|  
|AES128 \- http:\/\/www.w3.org\/2001\/04\/xmlenc\#aes128\-cbc|128|Supported algorithm for Decrypting the security token. Encrypting the security token with this algorithm is not supported.|  
|AES192 \- http:\/\/www.w3.org\/2001\/04\/xmlenc\#aes192\-cbc|192|Supported algorithm for Decrypting the security token. Encrypting the security token with this algorithm is not supported.|  
|AES256 \- [http:\/\/www.w3.org\/2001\/04\/xmlenc\#aes256\-cbc](http://www.w3.org/2001/04/xmlenc)|256|**Default**. Supported algorithm for Encrypting the security token.|  
|TripleDESKeyWrap \- http:\/\/www.w3.org\/2001\/04\/xmlenc\#kw\-tripledes|All Key sizes supported by .NET 4.0\+|Supported algorithm for Encrypting the symmetric key that encrypts a security token.|  
|AES128KeyWrap \- [http:\/\/www.w3.org\/2001\/04\/xmlenc\#kw\-aes128](http://www.w3.org/2001/04/xmlenc)|128|Supported algorithm for Encrypting the symmetric key that encrypts the security token.|  
|AES192KeyWrap \- [http:\/\/www.w3.org\/2001\/04\/xmlenc\#kw\-aes192](http://www.w3.org/2001/04/xmlenc)|192|Supported algorithm for Encrypting the symmetric key that encrypts the security token.|  
|AES256KeyWrap \- [http:\/\/www.w3.org\/2001\/04\/xmlenc\#kw\-aes256](http://www.w3.org/2001/04/xmlenc)|256|Supported algorithm for Encrypting the symmetric key that encrypts the security token.|  
|RsaV15KeyWrap \- http:\/\/www.w3.org\/2001\/04\/xmlenc\#rsa\-1\_5|1024|Supported algorithm for Encrypting the symmetric key that encrypts the security token.|  
|RsaOaepKeyWrap \- [http:\/\/www.w3.org\/2001\/04\/xmlenc\#rsa\-oaep\-mgf1p](http://www.w3.org/2001/04/xmlenc)|1024|Default. Supported algorithm for Encrypting the symmetric key that encrypts the security token.|  
|SHA1\-http:\/\/www.w3.org\/PICS\/DSig\/SHA1\_1\_0.html|N\/A|Used by AD FS Server in artifact SourceId generation:  In this scenario, the STS uses SHA1 \(per the recommendation in the SAML 2.0 standard\) to create a short 160 bit value for the artifact sourceiD.<br /><br />Also used by the ADFS web agent \(legacy component from WS2003 timeframe\) to identify changes in a “last updated” time value so that it knows when to update information from the STS.|  
|SHA1withRSA\-<br /><br />http:\/\/www.w3.org\/PICS\/DSig\/RSA\-SHA1\_1\_0.html|N\/A|Used in cases when AD FS Server validates the signature of SAML AuthenticationRequest, sign the artifact resolution request or response, create token\-signing certificate.<br /><br />In these cases, SHA256 is the default, and SHA1 is only used if the partner \(relying party\) cannot support SHA256 and must use SHA1.|  
  
## <a name="BKMK_13"></a>Permissions requirements  
The administrator that performs the installation and the initial configuration of AD FS must have domain administrator permissions in the local domain \(in other words, the domain to which the federation server is joined to.\)  
  
## See Also  
[AD FS Design Guide in Windows Server 2012 R2](AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)  
  

