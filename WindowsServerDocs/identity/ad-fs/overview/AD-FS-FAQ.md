---
ms.assetid: acc9101b-841c-4540-8b3c-62a53869ef7a
title: AD FS FAQ
description: Frequently asked questions for AD FS 
author: billmath
ms.author:  billmath
manager: mtillman
ms.date: 04/17/2019
ms.topic: article
ms.custom: it-pro
ms.prod: windows-server
ms.technology: identity-adfs
---

# AD FS Frequently Asked Questions (FAQ)


The following documentation is a home to frequently asked questions with regard to Active Directory Federation Services.  The document has been split into groups based on the type of question.

## Deployment

### How can I upgrade/migrate from previous versions of AD FS
You can upgrade AD FS using one of the following:


- Windows Server 2012 R2 AD FS to Windows Server 2016 AD FS or higher. Note that the methodology is the same if you are upgrading from Windows Server 2016 AD FS to Windows Server 2019 AD FS. 
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

### Is it possible to deploy AD FS for Office 365 without publishing a proxy to Office 365?
Yes, this is supported. However, as a side effect

1. You will need to manually manage updating token signing certificates because Azure AD will not be able to access the federation metadata. For more information on manually updating token signing certificate read [Renew federation certificates for Office 365 and Azure Active Directory](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-o365-certs)
2. You will not be able to leverage legacy auth flows (e.g. ExO proxy auth flow)

### What are load balancing requirements for AD FS and WAP servers?

AD FS is a stateless system. Hence, load balancing is fairly simple for logins. The following are key recommendations for load balancing systems.


- Load balancers SHOULD not be configured with IP affinity. This may put undue load on a subset of your servers in certain Exchange Online scenarios.
- Load balancers MUST not terminate the HTTPS connections and reinitiate a new connection to the ADFS server.
- Load balancers SHOULD ensure that the connecting IP address should be translated as the source IP in the HTTP packet when being sent to ADFS. In the event that a load balancer cannot send the source IP in the HTTP packet, the load balancer MUST add (or append in case of existing) the IP address to the x-forwarded-for header. This is required for the correct handling of certain IP related features (Banned IP, Extranet Smart Lockout,…) and could lead to reduced security if improperly configured.
- Load balancers SHOULD support SNI. In the event it does not, ensure that AD FS is configured to create HTTPS bindings to handle non SNI capable clients.
- Load balancers SHOULD use the AD FS HTTP health probe endpoint to detect if the AD FS or WAP servers are up and running and exclude them if a 200 OK Is not returned.

### What multi-forest configurations are supported by AD FS?

AD FS supports multiple multi-forest configuration and relies on the underlying AD DS trust network to authenticate users across multiple trusted realms. We strongly  recommend 2-way forests trusts as this is a simpler setup to ensure that the trust subsystem works correctly without issues. Additionally,

- In the event of a one way forest trust such as a DMZ forest containing partner identities, we recommend deploying ADFS in the corp forest and treating the DMZ forest as another local claims provider trust connected via LDAP. In this case Windows Integrated auth will not work for the DMZ forest users and they will be required to perform Password auth as that is the only supported mechanism for LDAP. In the event you cannot pursue this option, you would need to set up another ADFS in the DMZ forest and add that as Claims Provider Trust in the ADFS in the corp forest. Users will need to do Home realm discovery but both Windows Integrated auth and Password auth will work. Please make appropriate changes in the issuance rules in ADFS in DMZ forest as ADFS in the corp forest will not be able to get extra user information about the user from the DMZ forest.
- While domain level trusts are supported and can work, we highly recommend you moving to a forest level trust model. Additionally, you would need to ensure that UPN routing and NETBIOS name resolution of names need to work accurately.

>[!NOTE]  
>If elective authentication is used with a 2-way trust configuration, ensure the caller user is granted the "allow to authenticate" permission on the target service account. 


## Design

### What third party multi-factor authentication providers are available for AD FS?
AD FS provides an extensible mechanism for 3rd party MFA providers to integrate. There is no set certification program for this. It is assumed that the vendor has performed the necessary validations prior to release. 

The list of vendors that have notified Microsoft are published at [MFA providers for AD FS](../operations/Configure-Additional-Authentication-Methods-for-AD-FS.md).  There may always be providers available that we do not know about and we will update the list as we learn about them.

### Are third party proxies supported with AD FS?
Yes, third party proxies can be placed in front of the Web Application Proxy, but any third party proxy must support the [MS-ADFSPIP protocol](https://msdn.microsoft.com/library/dn392811.aspx) to be used in place of the Web Application Proxy.

Below is a list of third party providers we are aware of.  There may always be providers available that we do not know about and we will update the list as we learn about them.

- [F5 Access Policy Manager](https://support.f5.com/kb/en-us/products/big-ip_apm/manuals/product/apm-third-party-integration-13-1-0/12.html#guid-1ee8fbb3-1b33-4982-8bb3-05ae6868d9ee)


### Where is the capacity planning sizing spreadsheet for AD FS 2016?
The AD FS 2016 version of the spreadsheet can be downloaded [here](http://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx).
This can also be used for AD FS in Windows Server 2012 R2.

### How can I ensure my AD FS and WAP servers support Apple's ATP requirements?

Apple has released a set of requirements called App Transport Security (ATS) that may impact calls from iOS apps that authenticate to AD FS.  You can ensure your AD FS and WAP servers comply by making sure they support the [requirements for connecting using ATS](https://developer.apple.com/library/prerelease/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW57).  
In particular, you should verify that your AD FS and WAP servers support TLS 1.2 and that the TLS connection's negotiated cipher suite will support perfect forward secrecy.

You can enable and disable SSL 2.0 and 3.0 and TLS versions 1.0, 1.1, and 1.2 using [Manage SSL Protocols in AD FS](../operations/Manage-SSL-Protocols-in-AD-FS.md).

To ensure your AD FS and WAP servers negotiate only TLS cipher suites that support ATP, you can disable all cipher suites that are not in the [list of ATP compliant cipher suites](https://developer.apple.com/library/prerelease/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW57).  To do this, use the [Windows TLS PowerShell cmdlets](https://technet.microsoft.com/itpro/powershell/windows/tls/index).

## Developer

### When generating an id_token with ADFS for a user authenticated against AD, how is the “sub” claim generated in the id_token?
The value of “sub” claim is the hash of client ID + anchor claim value.

### What is the lifetime of the refresh token/access token when the user logs in via a remote claims provider trust over WS-Fed/SAML-P?
The lifetime of refresh token will be the lifetime of the token that ADFS got from remote claims provider trust. The lifetime of the access token will be the token lifetime of the relying party for which access token is being issued.

### I need to return profile and email scopes as well in addition to the OpenId scope. Can I obtain additional information using scopes? How to do it in AD FS?
You can use customized id_token to add relevant information in the id_token itself. For more information, see the article [Customize claims to be emitted in id_token](../development/Custom-Id-Tokens-in-AD-FS.md).

### How to issue json blobs inside JWT tokens?
A special ValueType("<http://www.w3.org/2001/XMLSchema#json>" ) and escape character(\x22) for this was added in AD FS 2016. Please the sample below for the issuance rule and also the final output from the access token.

Sample issuance rule:

	=> issue(Type = "array_in_json", ValueType = "http://www.w3.org/2001/XMLSchema#json", Value = "{\x22Items\x22:[{\x22Name\x22:\x22Apple\x22,\x22Price\x22:12.3},{\x22Name\x22:\x22Grape\x22,\x22Price\x22:3.21}],\x22Date\x22:\x2221/11/2010\x22}");

Claim issued in Access token:

	"array_in_json":{"Items":[{"Name":"Apple","Price":12.3},{"Name":"Grape","Price":3.21}],"Date":"21/11/2010"}

### Can I pass resource value as part of the scope value like how requests are done against Azure AD?
With AD FS on Server 2019, you can now pass the resource value embedded in the scope parameter. The scope parameter can now be organized as a space separated list where each entry is structure as resource/scope. For example  
**< create a valid sample request>**

### Does AD FS support PKCE extension?
AD FS in Server 2019 supports Proof Key for Code Exchange (PKCE) for OAuth Authorization Code Grant flow

### What permitted scopes are supported by AD FS?
- aza - If using [OAuth 2.0 Protocol Extensions for Broker Clients](https://docs.microsoft.com/openspecs/windows_protocols/ms-oapxbc/2f7d8875-0383-4058-956d-2fb216b44706) and if the scope parameter contains the scope "aza", the server issues a new primary refresh token and sets it in the refresh_token field of the response, as well as setting the refresh_token_expires_in field to the lifetime of the new primary refresh token if one is enforced.
- openid - Allows application to request use of the OpenID Connect authorization protocol.
- logon_cert - The logon_cert scope allows an application to request logon certificates, which can be used to interactively logon authenticated users. The AD FS server omits the access_token parameter from the response and instead provides a base64-encoded CMS certificate chain or a CMC full PKI response. More details available [here](https://docs.microsoft.com/openspecs/windows_protocols/ms-oapx/32ce8878-7d33-4c02-818b-6c9164cc731e). 
- user_impersonation - The user_impersonation scope is necessary to successfully request an on-behalf-of access token from AD FS. For details on how to use this scope refer [Build a multi-tiered application using On-Behalf-Of (OBO) using OAuth with AD FS 2016](../../ad-fs/development/ad-fs-on-behalf-of-authentication-in-windows-server.md).
- vpn_cert - The vpn_cert scope allows an application to request VPN certificates, which can be used to establish VPN connections using EAP-TLS authentication. This is not supported anymore.
- email - Allows application to request email claim for the signed in user. This is not supported anymore. 
- profile - Allows application to request profile related claims for the sign-in user. This is not supported anymore. 


## Operations

### How do I replace the SSL certificate for AD FS?
The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in.  To change the AD FS SSL certificate, you'll need to use PowerShell. Follow the guidance in the article below:

[Managing SSL Certificates in AD FS and WAP 2016](../operations/Manage-SSL-Certificates-AD-FS-WAP-2016.md)

### How can I enable or disable TLS/SSL settings for AD FS
To disable or enable SSL protocols and cipher suites, use the following:

[Manage SSL Protocols in AD FS](../operations/Manage-SSL-Protocols-in-AD-FS.md)

### Does the proxy SSL certificate have to be the same as the AD FS SSL certificate?  
Use the following guidance with regard to the proxy SSL certificate and the AD FS SSL certificate:


- If the proxy is used to proxy AD FS requests that use Windows Integrated Authentication, the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- If the AD FS property "ExtendedProtectionTokenCheck" is enabled (the default setting in AD FS), the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- Otherwise, the proxy SSL certificate can have a different key from the AD FS SSL certificate, but must meet the same [requirements](../overview/AD-FS-2016-Requirements.md)

### Why do I only see a password login on AD FS and not my other authentication methods that I have configured? 
AD FS only shows a single authentication method in the login screen when the application explicitly requires a specific authentication URI that maps to a configured and enabled authentication method. This is conveyed in the 'wauth' parameter for WS-Federation requests and the 'RequestedAuthnCtxRef' parameter in a SAML protocol request. As a result, only the requested authentication method is displayed (e.g. password login).

When AD FS is used with Azure AD, it is common for applications to send the prompt=login parameter to Azure AD. Azure AD by default translates this to requesting a fresh password based login to AD FS. This is the most common reason to see a password login on AD FS inside your network or not see an option to login with your certificate. This can be easily remedied by making a change to the federated domain settings in Azure AD. 

For information on how to configure this, see [Active Directory Federation Services prompt=login parameter support](../operations/AD-FS-Prompt-Login.md).

### How can I change the AD FS service account?
To change the AD FS service account, follow the instructions using the AD FS toolbox [Service Account Powershell Module](https://github.com/Microsoft/adfsToolbox/tree/master/serviceAccountModule).

### How can I configure browsers to use Windows Integrated Authentication (WIA) with AD FS?

For information on how to configure browsers see [Configure browsers to use Windows Integrated Authentication (WIA) with AD FS](../operations/Configure-AD-FS-Browser-WIA.md).

### Can I turn off BrowserSsoEnabled?
If you don't have Access control policies based on device on ADFS or Windows Hello for Business Certificate enrollment using ADFS; you can turn off BrowserSsoEnabled. BrowserSsoEnabled allows ADFS to collect a PRT(Primary Refresh Token) from client which contains device information. Without that device authentication of ADFS will not work on Windows 10 devices.

### How long are AD FS tokens valid?

Often this question means ‘how long do users get single sign on (SSO) without having to enter new credentials, and how can I as an admin control that?'  This behavior, and the configuration settings that control it, are described in the article [AD FS Single Sign-On Settings](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/operations/ad-fs-2016-single-sign-on-settings).

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

All AD FS endpoints for web authentication traffic are opened exclusively over HTTPS.  As a result, AD FS effectively mitigates the threats that HTTP Strict Transport Security policy mechanism provides (by design there is no downgrade to HTTP since there are no listeners in HTTP). In addition, AD FS prevents the cookies from being sent to another server with HTTP protocol endpoints by marking all cookies with the secure flag.

Therefore, implementing HSTS on an AD FS server is not required because it can never be downgraded.  For compliance purposes, AD FS servers meet these requirements because they can never use HTTP and all cookies are marked secure.

Additionally, AD FS 2016 (with the most up to date patches) and AD FS 2019 support emitting the HSTS header. To configure this please see [Customize HTTP security response headers with AD FS](../operations/customize-http-security-headers-ad-fs.md)

### X-ms-forwarded-client-ip does not contain the IP of the client but contains IP of the firewall in front of the proxy. Where can I get the right IP of the client?
It is not recommended to do SSL termination before WAP. In case SSL termination is done in front of the WAP, the X-ms-forwarded-client-ip will contain the IP of the network device in front of WAP. Below is a brief description of the various IP related claims that are supported by AD FS:
 - x-ms-client-ip : Network IP of device which connected to the STS.  In the case of an extranet request this always contains the IP of the WAP.
 - x-ms-forwarded-client-ip : Multi-valued claim which will contain any values forwarded to ADFS by Exchange Online plus the IP address of the device which connected to the WAP.
 - Userip: For extranet requests this claim will contain the value of x-ms-forwarded-client-ip.  For intranet requests, this claim will contain the same value as x-ms-client-ip.

 Additionally, in AD FS 2016 (with the most up to date patches) and higher versions also support capturing the x-forwarded-for header. Any load balancer or network device that does not forward at layer 3 (IP is preserved) should add the incoming client IP to the industry standard x-forwarded-for header. 

### I am trying to get additional claims on the user info endpoint, but its only returning subject. How can I get additional claims?
The AD FS userinfo endpoint always returns the subject claim as specified in the OpenID standards. AD FS does not provide additional claims requested via the UserInfo endpoint. If you need additional claims in ID token, refer to [Custom ID Tokens in AD FS](../development/custom-id-tokens-in-ad-fs.md).

### Why do I see a lot of 1021 errors on my AD FS servers?
This event is logged usually for an invalid resource access on AD FS for resource 00000003-0000-0000-c000-000000000000. This error is caused by an erroneous behavior of the client where it tries to get an access token for the Azure AD Graph service. Since the resource is not present on AD FS, this results in event ID 1021 on the AD FS servers. It's safe to ignore any warnings or errors for resource 00000003-0000-0000-c000-000000000000 on AD FS.

### Why am I seeing a warning for failure to add the AD FS service account to the Enterprise Key Admins group?
This group is only created when a Windows 2016 Domain Controller with the FSMO PDC role exists in the Domain. To resolve the error, you can create the Group manually and follow the below to give the required permission after adding the service account as member of the group.
1.	Open **Active Directory Users and Computers**.
2.	**Right-click** your domain name from the navigation pane and **click** Properties.
3.	**Click** Security (if the Security tab is missing, turn on Advanced Features from the View menu).
4.	**Click** Advanced. **Click** Add. **Click** Select a principal.
5.	The Select User, Computer, Service Account, or Group dialog box appears.  In the Enter the object name to select text box, type Key Admin Group.  Click OK.
6.	In the Applies to list box, select **Descendant User objects**.
7.	Using the scroll bar, scroll to the bottom of the page and **click** Clear all.
8.	In the **Properties** section, select **Read msDS-KeyCredentialLink** and **Write msDS-KeyCredentialLink**.

### Why does modern authentication from Android devices fail if the server does not send all the intermediate certificates in the chain with the SSL cert?

Federated users may experience authentication to Azure AD for apps that use the Android ADAL library failing. The app will get an **AuthenticationException** when it tries to show the login page. In chrome the AD FS login page might be called out as unsafe.

Android - across all versions and all devices - does not support downloading additional certificates from the **authorityInformationAccess** field of the certificate. This is true of the Chrome browser as well. Any Server Authentication certificate that's missing intermediate certificates will result in this error if the entire certificate chain is not passed from AD FS.

A proper solution to this problem is to configure the AD FS and WAP servers to send the necessary intermediate certificates along with the SSL certificate.

When exporting the SSL certificate, from one machine, to be imported to the computer's personal store, of the AD FS and WAP server(s), make sure to export the Private key and select **Personal Information Exchange - PKCS #12**.

It is important that the check box to **Include all certificates in the certificate path if possible** is checked, as well as **Export all extended properties**.  

Run certlm.msc on the Windows servers and import the *.PFX into the Computer's Personal Certificate store. This will cause the server to pass the entire certificate chain to the ADAL library.

>[!NOTE]
> The certificate store of Network Load Balancers should also be updated to include the entire certificate chain if present

### Does AD FS support HEAD requests?
AD FS does not support HEAD requests.  Applications should not be using HEAD requests against AD FS endpoints.  This may cause HTTP error responses that are unexpected and/or delayed.  Additionally, you may see unexpected error events in the AD FS event log.

### Why am I not seeing a refresh token when I am logging in with a remote IdP?
A refresh token is not issued if the token issued by IdP has a validty of less than 1 hour. To ensure a refresh token is issued, increase the validity of token issued by the IdP to more than 1 hour.

### Do we have any way to change RP token encryption algorithm?
By default the RP token encryption is set to AES256 and it cannot be changed to any other value.

### On a mixed-mode farm, I get error when trying to set the new SSL certificate using Set-AdfsSslCertificate -Thumbprint. How can I update the SSL certificate in a mixed mode AD FS farm?
Mixed mode AD FS farms are meant to be a transitionary state. It is recommended during your planning to either roll over the SSL certificate prior to the upgrade process or complete the process and increase the farm behaviour level prior to updating the SSL certificate. In the event that this was not done, the below instructions provide the ability to update the SSL certificate. 

On WAP servers you can still use Set-WebApplicationProxySslCertificate. On the ADFS servers, you need to use netsh. Follow the steps as given below:

1. Select subset of ADFS 2016 servers for maintenance (e.g. remove from load balancer)
2. On the servers selected in #1, import the new certificate via MMC
3. Delete the existing certificates

    a. netsh http delete sslcert hostnameport=fs.contoso.com:443
    b. netsh http delete sslcert hostnameport=localhost:443
    c. netsh http delete sslcert hostnameport=fs.contoso.com:49443

4.  Add the new cert

    a. netsh http add sslcert hostnameport=fs.contoso.com:443 certhash=CERTTHUMBPRINT appid={5d89a20c-beab-4389-9447-324788eb944a} certstorename=MY sslctlstorename=AdfsTrustedDevices

    b. netsh http add sslcert hostnameport=localhost:443 certhash=CERTTHUMBPRINT appid={5d89a20c-beab-4389-9447-324788eb944a} certstorename=MY sslctlstorename=AdfsTrustedDevices

    c. netsh http add sslcert hostnameport=fs.contoso.com:49443 certhash=CERTTHUMBPRINT appid={5d89a20c-beab-4389-9447-324788eb944a} certstorename=MY sslctlstorename=AdfsTrustedDevices

5. Restart ADFS service on the selected server
6. Remove subset of WAP servers for maintenance
7. On the selected WAP servers, import the new certificate via MMC
8. Set the new cert on WAP using cmdlet

    a. Set-WebApplicationProxySslCertificate -Thumbprint " CERTTHUMBPRINT"

9. Restart service on the selected WAP servers
10. Put the selected WAP and AD FS servers back in production environment.

Perform the update on the rest of AD FS and WAP servers in similar fashion.

### Is ADFS supported when Web Application Proxy (WAP) servers are behind Azure Web Application Firewall(WAF)?
ADFS and Web Application servers support any firewall that does not perform SSL termination on the endpoint. Additionally, ADFS/WAP servers have built in mechanisms to prevent common web attacks such as cross-site scripting, ADFS proxy and satisfy all requirements defined by the [MS-ADFSPIP protocol](https://msdn.microsoft.com/library/dn392811.aspx).

### I am seeing an "Event 441: A token with a bad token binding key was found." What should I do to resolve this?
In AD FS 2016, token binding is automatically enabled and causes multiple known issues with proxy and federation scenarios which result in this error. To resolve this, run the following Powershell command and remove token binding support.

`Set-AdfsProperties -IgnoreTokenBinding $true`

### I have upgraded my farm from AD FS in Windows Server 2016 to AD FS in Windows Server 2019. The Farm Behavior Level for the AD FS farm has been successfully raised to 2019 but the Web Application Proxy configuration is still displayed as Windows Server 2016?
After an upgrade to Windows Server 2019, the configuration version of the Web Application Proxy will continue to display as Windows Server 2016. The Web Application Proxy does not have new version specific features for Windows Server 2019, and if the Farm Behaviour Level has been successfully raised on AD FS, the Web Application Proxy will continue to display as Windows Server 2016 by design.

### Can I estimate the size of the ADFSArtifactStore before enabling ESL?
With ESL enabled, AD FS tracks the account activity and known locations for users in the ADFSArtifactStore database. This database scales in size relative to the number of users and known locations tracked. When planning to enable ESL, you can estimate the size for the ADFSArtifactStore database to grow at a rate of up to 1GB per 100,000 users. If the AD FS farm is using the Windows Internal Database (WID), the default location for the database files is C:\Windows\WID\Data. To prevent filling this drive, ensure you have a minimum of 5GB of free storage before enabling ESL. In addition to disk storage, plan for total process memory to grow after enabling ESL by up to an additional 1GB of RAM for user populations of 500,000 or less.
