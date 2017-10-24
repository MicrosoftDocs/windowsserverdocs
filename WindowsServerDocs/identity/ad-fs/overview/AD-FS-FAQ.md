---
ms.assetid: acc9101b-841c-4540-8b3c-62a53869ef7a
title: AD FS 2016 FAQ
description: Frequently asked questions for AD FS 2016
author: jenfieldmsft
ms.author:  billmath
manager: femila
ms.date: 09/19/2017
ms.topic: article
ms.custom: it-pro
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# AD FS Frequently Asked Questions (FAQ)

>Applies To: Windows Server 2016

The following documentation is a home to frequently asked questions with regard to Active Directory Federation Services.  The document has been split into groups based on the type of question.

## Deployment 

### How can I upgrade/migrate from previous versions of AD FS
You can upgrade AD FS using one of the following:


- Windows Server 2012 R2 AD FS to Windows Server 2016 AD FS
	- [Upgrading to AD FS in Windows Server 2016 using a WID database](../deployment/Upgrading-to-AD-FS-in-Windows-Server-2016.md)
	- [Upgrading to AD FS in Windows Server 2016 using a SQL database](../deployment/Upgrading-to-AD-FS-in-Windows-Server-2016-SQL.md)
- Windows Server 2012 AD FS to Windows Server 2012 R2 AD FS
	- [Migrate to AD FS on Windows Server 2012 R2](https://technet.microsoft.com/library/dn486815.aspx)
- AD FS 2.0 to Windows Server 2012 AD FS
	- [Migrate to AD FS on Windows Server 2012](https://technet.microsoft.com/library/jj647765.aspx)
- AD FS 1.x to AD FS 2.0 
	- [Upgrade from AD FS 1.x to AD FS 2.0](https://technet.microsoft.com/library/ff678035.aspx)

If you need to upgrade from AD FS 2.0 or 2.1 (Windows Server 2008 R2 or Windows Server 2012), you must use the in-box scripts (located in C:\Windows\ADFS).

### Why does AD FS installation require a reboot of the server?

HTTP/2 support was added in Windows Server 2016, but HTTP/2 can't be used for client certificate authentication.  Because many AD FS scenarios make use of client certificate authentication, and a significant number of clients do not support retrying requests using HTTP/1.1, AD FS farm configuration re-configures the local server's HTTP settings to HTTP/1.1.  This requires a reboot of the server.  

### Is using Windows 2016 WAP Servers to publish the AD FS farm to the internet without upgrading the back-end AD FS farm supported?
Yes, this configuration is supported, however no new AD FS 2016 features would be supported in this configuration.  This configuration is meant to be temporary during the migration phase from AD FS 2012 R2 to AD FS 2016 and should not be deployed for long periods of time.

### Are third party proxies supported with AD FS?
Yes, third party proxies can be placed in front of the Web Application Proxy, but any third party proxy must support the [MS-ADFSPIP](https://msdn.microsoft.com/library/dn392811.aspx) protocol to be used in place of the Web Application Proxy.

## Design

### What third party multi-factor authentication providers are available for AD FS? 
Below is a list of third party providers we are aware of.  There may always be providers available that we do not know about and we will update the list as we learn about them.

- [Gemalto Identity & Security Services](http://www.gemalto.com/identity)
- [inWebo Enterprise Authentication service](http://www.inwebo.com/)
- [Login People MFA API connector](https://www.loginpeople.com)
- [RSA SecurID Authentication Agent for Microsoft Active Directory Federation Services](http://www.emc.com/security/rsa-securid/rsa-authentication-agents/microsoft-ad-fs.htm)
- [SafeNet Authentication Service (SAS) Agent for AD FS](http://www.safenet-inc.com/resources/integration-guide/data-protection/Safenet_Authentication_Service/SafeNet_Authentication_Service__AD_FS_Agent_Configuration_Guide/?langtype=1033)
- [Swisscom Mobile ID Authentication Service](http://swisscom.ch/mid)
- [Symantec Validation and ID Protection Service (VIP)](http://www.symantec.com/vip-authentication-service) 

### Are third party proxies supported with AD FS?
Yes, third party proxies can be placed in front of the Web Application Proxy, but any third party proxy must support the [MS-ADFSPIP protocol](https://msdn.microsoft.com/library/dn392811.aspx) to be used in place of the Web Application Proxy.

### Where is the capacity planning sizing spreadsheet for AD FS 2016?
The AD FS 2016 version of the spreadsheet can be downloaded [here](http://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx).
This can also be used for AD FS in Windows Server 2012 R2.

### How can I ensure my AD FS and WAP servers support Apple's ATP requirements?

Apple has released a set of requirements called App Transport Security (ATS) that may impact calls from iOS apps that authenticate to AD FS.  You can ensure your AD FS and WAP servers comply by making sure they support the [requirements for connecting using ATS](https://developer.apple.com/library/prerelease/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW57).  
In particular, you should verify that your AD FS and WAP servers support TLS 1.2 and that the TLS connection's negotiated cipher suite will support perfect forward secrecy.

You can enable and disable SSL 2.0 and 3.0 and TLS versions 1.0, 1.1, and 1.2 using [Manage SSL Protocols in AD FS](../operations/Manage-SSL-Protocols-in-AD-FS.md).

To ensure your AD FS and WAP servers negotiate only TLS cipher suites that support ATP, you can disable all cipher suites that are not in the [list of ATP compliant cipher suites](https://developer.apple.com/library/prerelease/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW57).  To do this, use the [Windows TLS PowerShell cmdlets](https://technet.microsoft.com/itpro/powershell/windows/tls/index). 


## Operations

### How do I replace the SSL certificate for AD FS? 
The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in.  To change the AD FS SSL certificate, you’ll need to use PowerShell. Follow the guidance in the article below:

[Managing SSL Certificates in AD FS and WAP 2016](../operations/Manage-SSL-Certificates-AD-FS-WAP-2016.md)

### How can I enable or disable TLS/SSL settings for AD FS
To disable or enable SSL protocols and cipher suites, use the following:

[Manage SSL Protocols in AD FS](../operations/Manage-SSL-Protocols-in-AD-FS.md)

### Does the proxy SSL certificate have to be the same as the AD FS SSL certificate?  
Use the following guidance with regard to the proxy SSL certificate and the AD FS SSL certificate:


- If the proxy is used to proxy AD FS requests that use Windows Integrated Authentication, the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- If the AD FS property "ExtendedProtectionTokenCheck" is enabled (the default setting in AD FS), the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- Otherwise, the proxy SSL certificate can have a different key from the AD FS SSL certificate, but must meet the same [requirements](../overview/AD-FS-2016-Requirements.md)

### How can I configure prompt=login behavior for AD FS?
For information on how to configure prompt=login, see [Active Directory Federation Services prompt=login parameter support](../operations/AD-FS-Prompt-Login.md).

### How can I configure browsers to use Windows Integrated Authentication (WIA) with AD FS

For information on how to configure browsers see [Configure browsers to use Windows Integrated Authentication (WIA) with AD FS](../operations/Configure-AD-FS-Browser-WIA.md).


### How long are AD FS tokens valid?

Often this question means ‘how long do users get single sign on (SSO) without having to enter new credentials, and how can I as an admin control that?’  This behavior, and the configuration settings that control it, are described in the article [here](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/operations/ad-fs-2016-single-sign-on-settings).

The default lifetimes of the various cookies and tokens are listed below (as well as the parameters that govern the lifetimes):

**Registered Devices**

- PRT and SSO cookies: 90 days maximum, governed by PSSOLifeTimeMins. (Provided device is used at least every 14 days, which is controlled by DeviceUsageWindow)

- Refresh token: calculated based on the above to provide consistent behavior

- access_token: 1 hour by default, based on the relying party

- id_token: same as access token

**Un-registered Devices**

- SSO cookies: 8 hours by default, governed by SSOLifetimeMins.  When Keep Me Signed in (KMSI) is enabled, default is 24 hours and configurable via KMSILifetimeMins.

- Refresh token: 8 hours by default. 24 hours with KMSI enabled

- access_token: 1 hour by default, based on the relying party

- id_token: same as access token

### Does AD FS support HTTP Strict Transport Security (HSTS)?  

HTTP Strict Transport Security (HSTS) is a web security policy mechanism which helps mitigate protocol downgrade attacks and cookie hijacking for services that have both HTTP and HTTPS endpoints. It allows web servers to declare that web browsers (or other complying user agents) should only interact with it using HTTPS and never via the HTTP protocol.

All AD FS endpoints for web authentication traffic are opened exclusively over HTTPS.  As a result, AD FS effectively mitigates the threats that HTTP String Transport Security policy mechanism provides (by design there is no downgrade to HTTP since there are no listeners in HTTP). In addition, AD FS prevents the cookies from being sent to another server with HTTP protocol endpoints by marking all cookies with the secure flag.

Therefore, implementing HSTS on an AD FS server is not required because it can never be downgraded.  For compliance purposes, AD FS servers meet these requirements because they can never use HTTP and all cookies are marked secure.

### X-ms-forwarded-client-ip does not contain the IP of the client but contains IP of the firewall in front of the proxy. Where can I get the right IP of the client?
It is not recommended to do SSL termination before WAP. In case SSL termination is done in front of the WAP, the X-ms-forwarded-client-ip will contain the IP of the network device in front of WAP. Below is a brief description of the various IP related claims that are supported by AD FS:
 - x-ms-client-ip : Network IP of device which connected to the STS.  In the case of an extranet request this always contains the IP of the WAP.
 - x-ms-forwarded-client-ip : Multi-valued claim which will contain any values forwarded to ADFS by Exchange Online plus the IP address of the device which connected to the WAP.
 - Userip: For extranet requests this claim will contain the value of x-ms-forwarded-client-ip.  For intranet requests, this claim will contain the same value as x-ms-client-ip.

### I am trying to get additional claims on the user info endpoint, but its only returning subject. How can I get additional claims?
The ADFS userinfo endpoint always returns the subject claim as specified in the OpenID standards. AD FS does not provide additional claims requested via the UserInfo endpoint. If you need additional claims in ID token, refer to [Custom ID Tokens in AD FS](../development/custom-id-tokens-in-ad-fs.md).