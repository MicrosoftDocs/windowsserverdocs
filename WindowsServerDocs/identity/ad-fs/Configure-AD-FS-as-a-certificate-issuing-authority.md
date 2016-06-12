---
title: Configure AD FS as a certificate issuing authority
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: ad-health-connect
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1b049c11-ba33-4354-8c1a-359a582ff9ac
---
# Configure AD FS as a certificate issuing authority

This document describes how AD FS can be configured as a certificate issuing authority or as a registration authority.    

### How it works
The LogonCert JSON Web Token bearer extension grant flow is used by a client (requestor) to obtain a certificate that can be used to login a user interactively. In order to request a certificate using this extension grant type, the client/requestor needs the following:

-	An access token issued by AD FS to the requestor after authenticating the end-user (i.e. the end-user is the subject of the token).
-	Client credentials in order for the requestor to authenticate itself with AD FS. The requestor MUST be registered with AD FS as a confidential client and can therefore use one of the available confidential client authentication methods (i.e. either of client_secret_post, private_key_jwt or WIA).  For more an example of a confidential client see [Enabling Oauth Confidential Clients with AD FS 2016.](Enabling-Oauth-Confidential-Clients-with-AD-FS-2016.md)
-	A certificate signing request (CSR) generated in accordance with the stipulations of [RFC 2986](https://tools.ietf.org/html/rfc2986).

The following describes the flow in how a native app obtains authorization to access the Azure RemoteApp service.

1.  Native app on Windows/IOS/Android, etc. requests authorization to access the Azure RemoteApp service.
2.  The app is built on ADAL (Active Directory Authentication Library) and uses the OAuth authorization code grant type to request an access token and refresh token to access the Azure RemoteApp service.
3. The native app is re-directed to the instance AD FS
4.  AD FS authenticates the end-user and in the process of doing so generates a persistent SSO cookie. This cookie is promptly cached by the ADAL library.
5.  AD FS redirects the client (native app) back to the Azure with a federated access token.   
6.  Azure validates this federated access token and then issues an access token and refresh token pair to the client (native app).
7.  AD AL caches this access token and refresh token pair for the native app and it is then used for subsequent interactions with the Azure RemoteApp service in order to provide authorization.

As illustrated above, the native app was able to obtain and access token and refresh token issued by Azure that authorizes it to access the Azure RemoteApp service.
-	After obtaining authorization to access the Azure RemoteApp service, the native app is able to retrieve a list of remote applications that have been published for the consumption of the authenticated user.
-	This list of applications is displayed to the user within the native app.
-	When the user selects one of the remote applications available for their use from within the native app, the App then tries to connect the user to the remote application.
-	Note that the user will need to be connected to one of the domain-joined virtual machine instances within the Contoso virtual network that are managed by the Azure RemoteApp servcie.
-	The Remote Desktop Shell component on the virtual machine is responsible for logging in the user interactively to the VM so they can interact with the remote application.

In order for the native app to connect to the Remote Desktop Shell (RDSH) component on the target virtual machine and request an interactive logon for the user, the native app must first obtain an access token for the RDSH that was issued by AD FS. Note that the RDSH component is on a domain joined machine and will trust access tokens issued by the on-premises AD FS instance of which it is a relying party. The following steps are involved in this token acquisition flow:

-	The native app uses ADAL to obtain an access token and refresh token from the AD FS instance using the OpenID Connect authorization code grant type. Note that the native app will request the new ‘logon_cert’ scope that is required in order to exchange a token issued by AD FS for an interactive logon certificate.
-	In this flow, it is important to note that AD FS will consume the persistent single sign-on (PSSO) cookie that was previously issued by AD FS as part of the federated login flow involved in the native app getting a token for the Azure RemoteApp service.
-	The native app will try to use the non-interactive flow to try and acquire a token without having to display anything to the end user.
-	AD FS checks to see whether the corresponding application permission entry exists for the native app (client) to request a token for the RDSH (relying party) with the ‘logon_cert’ scope on behalf of the authenticated user.
-	Once all required authorization checks are complete, AD FS issues an access token and refresh token to the native app. Note that the access token will include the ‘logon_cert’ value for the ‘scp’ claim, indicating that the access token may be used to obtain a logon certificate on behalf of the authenticated user.
-	Note that since AD FS has an admin consent model, the end user will not see a consent page that informs them that the ‘logon_cert’ scope is being requested by the native app.

The above illustrated how the native app obtains an access token issued by AD FS in order to access the RDSH relying party. Now, in order to logon the user interactively into the VM, RDSH needs a logon certificate. 

Note that per this functional specification document, ADFS will support two deployment modes in regard to how the certificate used to logon the user interactively is issued. These are:
-	**Self-signed certificates issued by AD FS** – this mode is suitable for smaller customers who do not have an enterprise PKI infrastructure. For such customers, AD FS will offer a simpler deployment model where certificates used to logon users are issued by AD FS. However, in order for these certificates to be used for interactive logon, administrators will need to configure their KDC to trust AD FS as an issuer CA.

-	**Certificates issued by enterprise CA** – this mode is suitable for customers who have an enterprise PKI deployed and will prefer that their CA issue certificates used to logon users interactively.


### Self-signed certificates issued by AD FS
In this deployment mode, the AD FS server is the certificate issuing authority and is responsible for issuing certificates that are used to login users interactively. The certificates are self-issued and the KDC is configured to trust AD FS as a certificate issuing authority in order to enable domain users to be signed in interactively using the certificate.  Use the following steps to configure AD FS to issue self-signed certificates.

1.  Add AD FS issuing certificate to the Enterprise NTAuth store
Using in the steps outlined in [KB295663](https://support.microsoft.com/en-us/kb/295663) and the issuing certificate to the Enterprise NTAuth store.

2.  Register the native app as a public client with the AD FS server
This step enables the native app to request access tokens from the AD FS server in order to access the RDSH relying party. The access token issued by AD FS to the native app is presented to the RDSH (relying party) when the user needs to connect to the VM. This access token is then used as a bootstrap credential in order to obtain a logon certificate from AD FS.  To register a native app an administrator needs to execute the following command:


```
Add-AdfsClient –Name “Azure RemoteApp” –ClientId <CLIENT_ID_OF_MOHORRO_APP> -RedirectUri <REDIRECT_URI_OF_MOHORRO_APP> -Description “Azure RemoteApp”
```
**NOTE:** The corresponding values of the client ID and redirect URI will need to be replace in the above command. Also note that if there are separate client IDs for the native app on different platforms (iOS, Windows, Android, Mac OS etc.), each of these instances of the native app will need to be registered with AD FS as a public client.

3. 	Register RDSH as a confidential client with the AD FS server
This step enables the RDSH component within the VM to authenticate itself with ADFS and request a logon certificate for the authenticated end-user.  In order to register RDSH as a confidential client with the ADFS server, the administrator needs to execute the following command:

```
Add-AdfsClient –Name “RDSH” –ClientId <CLIENT_ID_OF_RDSH> -RedirectUri <REDIRECT_URI_OF_RDSH> -Description “Terminal Service (RDSH)” –ClientType Confidential –ADComputerAccountGroup “MohorroVMs”
```
**NOTE:** The domain-joined virtual machines spun up by the Azure RemoteApp service will need to have their machine accounts added to a group, in order for RDSH on these virtual machines to use windows integrated authentication when requesting logon certificates for end-users.

4. Create relying party trust for RDSH on the ADFS server
This step enables RDSH to be registered with AD FS as a relying party, which is a requirement for the native app to request an access token from AD FS to call into RDSH.  An example of creating the RP trust with only the mandatory parameters is provided below:


```
Add-AdfsRelyingPartyTrust –Name “RDSH” –Identifier <RELYING_PARTY_ID_OF_RDSH> …
```
5. Configure AD FS application permission for the RDSH RP trust
Once the native app and RDSH have been registered as clients with AD FS and RDSH has also additionally been registered as an RP with AD FS, the next step is to configure application permissions.

The following permissions will be granted:
-	Grant ‘logon_cert’ scope to the natvie App (client role)
-	Grant ‘logon_cert’ scope to the RDSH (client role)
-	Specify which users/groups/principals can be impersonated as part of the permission entry.

The following PowerShell cmdlets can be used in order to configure the requisite permissions:


```
# Grant permissions for the native app to RDSH relying party
Grant-AdfsApplicationPermission –ServerRoleIdentifier < RELYING_PARTY_ID_OF_RDSH> -ClientRoleIdentifier < CLIENT_ID_OF_RDSH> -ScopeNames “openid”,”logon_cert”

# Grant permissions for the RDSH client to the RDSH relying party
Grant-AdfsApplicationPermission –ServerRoleIdentifier < RELYING_PARTY_ID_OF_RDSH> -ClientRoleIdentifier <CLIENT_ID_OF_RDSH> -ScopeNames “openid”,”logon_cert” –ImpersonatedPrincipals “CONTOSO\MohorroUsers”
```
6.  Configure AD FS to issue certificates
Now that we have configured application permissions we need to configure AD FS to issue self-signed certificates.  Use the following PowerShell cmdlet to enable AD FS to issue certificates


```
Set-AdfsCertificateAuthority -SelfIssued
```



### AD FS acts as a registration authority
In this deployment mode, the AD FS server acts as a registration agent and requests certificates from the enterprise CA on behalf of the end-user. Here, the CA is the certificate issuing authority and is responsible for issuing certificates that are used to login users interactively.  Use the following steps to configure AD FS to act as a registration agent.

1. Configure AD FS as an enrollment agent
In order for AD FS to request certificates on behalf of authenticated users, it is necessary to configure it as an enrollment agent on the enterprise CA. Enrollment agents are one or more authorized individuals within an organization. The enrollment agent needs to be issued an enrollment agent certificate, which enables the agent to enroll for smart card certificates on behalf of users. 

Windows Server 2008 R2 and above includes three certificate templates that enable different types of enrollment agents:

* Enrollment Agent. Used to request certificates on behalf of another subject.
* Enrollment Agent (Computer). Used to request certificates on behalf of another computer subject.
* Exchange Enrollment Agent (Offline Request). Used to request certificates on behalf of another subject and supply the subject name in the request. This template is used by the Network Device Enrollment Service for its enrollment agent certificate.

In this case, since AD FS will request certificates on behalf of authenticated users and supply the subject name (i.e. UPN of the user) in the request, it will need a certificate based on the ‘Exchange Enrollment Agent (Offline Request)’ certificate template.

This can be done by accessing the certificates template mmc, locating the Exchange Enrollment Agent template, right-clicking on it and selecting duplicate template.

![ADFS_CA1media/ADFS_CA1.png)

Then simply rename the duplicate AD FS Enrollment Agent.  This template name will be provided to AD FS by setting the ‘EnrollmentAgentCertificateTemplate’ property using the Set-AdfsCertificateAuthority PowerShell cmdlet.

![ADFS_CA1media/ADFS_CA2.png)

In the Security tab of the certificate template property page, the administrator grants permissions to the service account used by AD FS and grants the service account Enroll and AutoEnroll permissions.

2. Configure smartcard logon certificate template

This can be done by accessing the certificates template mmc, locating the Smartcard Logon template, right-clicking on it and selecting dubplicate template.

Then simply rename the duplicate AD FS Logon.  This template name will be provided to AD FS by setting the ‘LogonCertificateTemplate’ property using the Set-AdfsCertificateAuthority PowerShell cmdlet.

In the ‘Subject Name’ tab of the property page, you configure the smartcard logon certificate template to accept subject names supplied in the request. Since requests for certificates using this certificate template will be initiated by AD FS acting as an enrollment agent, the CA can rely on AD FS to supply the correct subject name in the upn format for the authenticated user, when requesting certificates using this template.

![ADFS_CA1media/ADFS_CA3.png)

In the Security tab of the certificate template property page, the administrator grants permissions to the service account used by AD FS and grants the service account Enroll and AutoEnroll permissions.

3.  	Enable AD FS enrollment agent and logon certificate templates on the Certificate Authority

After creating the enrollment agent certificate template and the logon certificate template in the certificate templates console (as shown above), the administrator needs to enable these certificate templates on the CA.  This can be done from the Certificate Authority MMC. Select the certificate templates node, right-click, and select new, certificate template to issue. 
![ADFS_CA1media/ADFS_CA4.png)

4. Configure AD FS service as an enrollment agent
This step enables ADFS to initialize itself as an enrollment agent so that it can request:

* An enrollment agent certificate for itself.
* Smartcard logon certificates on behalf of authenticated end-users.

The previous steps described the configuration steps that had to be performed on the Enterprise CA in order to configure AD FS as an enrollment agent and allow it to request smartcard logon certificates on behalf of authenticated end-users. Once those steps have been configured, ADFS needs to be pointed to the enrollment agent certificate template as well as the smartcard logon certificate template that were previously configured.

In order to configure the ADFS service as an enrollment agent, the following PowerShell command can be used:


```
Set-AdfsCertificateAuthority –EnrollmentAgentCertificateTemplate “ADFSEnrollmentAgent” –LogonCertificateTemplate “ADFSLogon”
```
5.  Register the native app as a public client with the AD FS server

This step enables the native app to request access tokens from the AD FS server in order to access the RDSH relying party. The access token issued by AD FS to the native app is presented to the RDSH (relying party) when the user needs to connect to the VM. This access token is then used as a bootstrap credential in order to obtain a logon certificate from AD FS.  To register a native app an administrator needs to execute the following command:


```
Add-AdfsClient –Name “Azure RemoteApp” –ClientId <CLIENT_ID_OF_MOHORRO_APP> -RedirectUri <REDIRECT_URI_OF_MOHORRO_APP> -Description “Azure RemoteApp”
```
6. 	Register RDSH as a confidential client with the AD FS server

This step enables the RDSH component within the VM to authenticate itself with ADFS and request a logon certificate for the authenticated end-user.  In order to register RDSH as a confidential client with the ADFS server, the administrator needs to execute the following command:

```
Add-AdfsClient –Name “RDSH” –ClientId <CLIENT_ID_OF_RDSH> -RedirectUri <REDIRECT_URI_OF_RDSH> -Description “Terminal Service (RDSH)” –ClientType Confidential –ADComputerAccountGroup “MohorroVMs”
```
**NOTE:** The domain-joined virtual machines spun up by the Azure RemoteApp service will need to have their machine accounts added to a group, in order for RDSH on these virtual machines to use windows integrated authentication when requesting logon certificates for end-users.

7. Create relying party trust for RDSH on the ADFS server
This step enables RDSH to be registered with AD FS as a relying party, which is a requirement for the native app to request an access token from AD FS to call into RDSH.  An example of creating the RP trust with only the mandatory parameters is provided below:


```
Add-AdfsRelyingPartyTrust –Name “RDSH” –Identifier <RELYING_PARTY_ID_OF_RDSH> …
```
8. Configure AD FS application permission for the RDSH RP trust
Once the native app and RDSH have been registered as clients with AD FS and RDSH has also additionally been registered as an RP with AD FS, the next step is to configure application permissions.

The following permissions will be granted:
-	Grant ‘logon_cert’ scope for the native app to access RDSH (server role/RP)
-	Grant required scopes (optional) to the RDSH (client role) to access RDSH (server role/RP)
-	Specify which users/groups/principals can be impersonated as part of the permission entry.


The following PowerShell cmdlets can be used in order to configure the requisite permissions:


```
# Grant permissions for the native app to RDSH relying party
Grant-AdfsApplicationPermission –ServerRoleIdentifier < RELYING_PARTY_ID_OF_RDSH> -ClientRoleIdentifier < CLIENT_ID_OF_MOHORRO_APP> -ScopeNames “openid”,”logon_cert” –ImpersonatedPrincipals “CONTOSO\MohorroUsers”

# Grant permissions for the RDSH client to the RDSH relying party
Grant-AdfsApplicationPermission –ServerRoleIdentifier < RELYING_PARTY_ID_OF_RDSH> -ClientRoleIdentifier <CLIENT_ID_OF_RDSH> -ScopeNames “openid”

```

