---
ms.assetid: 1ea2e1be-874f-4df3-bc9a-eb215002da91
title: Configure AD FS support for user certificate authentication
description:
author: jenfieldmsft
ms.author: billmath
manager: samueld
ms.date: 01/18/2018
ms.topic: article
ms.prod: windows-server
ms.technology: identity-adfs
---
# Configuring AD FS for user certificate authentication

User Certificate authentication is used mainly in 2 use cases
* Users are using smart cards to sign-in against their AD FS system
* Users are using certificates provisioned to mobile devices


## Prerequisites
1) Determine the mode of AD FS user certificate authentication you want to enable using one of the modes described in [this article](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md)
2) Ensure that your user certificate trust chain is installed & trusted by all AD FS and WAP servers including any intermediate certificate authorities. Usually this is done via GPO on AD FS / WAP servers
3)  Ensure that the root certificate of the chain of trust for your user certificates is in the NTAuth store in Active Directory
4) If using AD FS in alternate certificate authentication mode, ensure that your AD FS and WAP servers have SSL certificates that contain the AD FS hostname prefixed with "certauth", for example "certauth.fs.contoso.com", and that traffic to this hostname is allowed through the firewall
5) If using certificate authentication from the extranet, ensure that at least one AIA and at least one CDP or OCSP location from the list specified in your certificates are accessible from the internet.
6) Also for Azure AD certificate authentication, for Exchange ActiveSync clients, the client certificate must have the users routable email address in Exchange online in either the Principal Name or the RFC822 Name value of the Subject Alternative Name field. (Azure Active Directory maps the RFC822 value to the Proxy Address attribute in the directory.)


## Configure AD FS for user certificate authentication  

Enable user certificate authentication as an intranet or extranet authentication method in AD FS, using either the AD FS Management console or the PowerShell cmdlet `Set-AdfsGlobalAuthenticationPolicy`.

If you are configuring AD FS for Azure AD certificate authentication, ensure that you have configured the [Azure AD settings](https://docs.microsoft.com/azure/active-directory/active-directory-certificate-based-authentication-get-started#step-2-configure-the-certificate-authorities) and the [AD FS claim rules required](https://docs.microsoft.com/azure/active-directory/active-directory-certificate-based-authentication-ios#requirements) for certificate Issuer and Serial Number

Additionally, there some optional aspects.
- If you wish to use claims based on certificate fields and extensions in addition to EKU (claim type https://schemas.microsoft.com/2012/12/certificatecontext/extension/eku), configure additional claim pass through rules on the Active Directory claims provider trust.  See below for a complete list of available certificate claims.  
- If you need to restrict access based on the type of cert, you can use the additional properties on the certificate in AD FS issuance authorization rules for the application. Common scenarios are "only allow certificates provisioned by an MDM provider" or "only allow smart card certificates"
>[!IMPORTANT]
> Customers using device code flow for authentication and performing device authentication using an IDP other than Azure AD (e.g AD FS) will not be able to enforce device based access (e.g. only allow managed devices using a 3rd party MDM service) for Azure AD resources. To protect access to your corporate resources in Azure AD and prevent any data leakage, customers should configure Azure AD device based Conditional Access (i.e. “Require device to be marked complaint” grant control in Azure AD Conditional Access).
- Configure allowed issuing certification authorities for client certificates using the guidance under "Management of trusted issuers for client authentication" in [this article](https://technet.microsoft.com/library/dn786429(v=ws.11).aspx).
- You may want to consider modifying the sign-in pages to suit the needs of your end users when doing certificate authentication. Common cases are to (a) Change 'Sign-in with your X509 certificate' to something more end user friendly

## Configure Seamless Certificate Authentication for Chrome browser on Windows Desktops
When multiple user certificates (such as Wi-Fi certificates) are present on the machine that satisfy the purposes of client authentication, the Chrome browser on Windows desktop will prompt the user to select the right certificate. This may be confusing to the end user. To optimize this experience, you can set a policy for Chrome to auto-select the right certificate for a better user experience. This policy can be set manually by making a registry change or configured automatically via GPO (to set the registry keys). This requires your user client certificates for authentication against AD FS to have distinct issuers from other use cases. 

For more information on configuring this for Chrome, please refer to this [link](http://www.chromium.org/administrators/policy-list-3#AutoSelectCertificateForUrls).  


## Troubleshoot Certificate Authentication
This document focuses on trouble shooting common issues when AD FS is configured for certificate authentication for users. 

### Check if Certificate Trusted issuers is configured properly in all the AD FS/WAP servers
*Common Symptom: HTTP 204 “No content from https\://certauth.adfs.contoso.com”*

AD FS uses the underlying windows operation system to prove possession of the user certificate and ensure that it matches a trusted issuer by doing certificate trust chain validation. To match the trusted issuer, you will need to ensure that all root and intermediate authorities are configured as trusted issuers in the local computer certification authorities store. 
To validate this automatically, please use the [AD FS Diagnostic Analyzer tool](https://adfshelp.microsoft.com/DiagnosticsAnalyzer/Analyze). The tool queries all the servers and ensures that the right certificates are provisioned correctly. 
1)	Download and run the tool as per the instructions provided in the link above
2)	Upload the results and review for any failures

### Check if Certificate Authentication is enabled in the AD FS authentication policy
AD FS does not enable certificate authentication by default. Refer to the beginning of this document on how to enable certificate authentication. 

### Check if Certificate Authentication is enabled in the AD FS authentication policy
AD FS does user certificate authentication by default on port 49443 with the same host name as AD FS (e.g. `adfs.contoso.com`). You can also configure AD FS to use port 443 (default HTTPS port) using the alternate SSL binding. However, the URL used in this configuration is `certauth.<adfs-farm-name>` (e.g. `certauth.contoso.com`). See [this link](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md) for more information. 
The most common case of network connectivity is that a firewall has been incorrectly configured and blocks or interferes user certificate authentication traffic. Usually, you will see a blank screen or a 500 server error when this issue occurs. 
1)	Note the hostname and port that you have configured in AD FS
2)	Ensure that any firewall in front of AD FS or Web Application Proxy (WAP) is configured to allow the `hostname:port` combination for your AD FS farm. You will have to refer to your network engineer to perform this step. 

### Check Certificate Revocation List Connectivity
Certificate Revocation Lists (CRL) are endpoints that are encoded into the user certificate to perform runtime revocation checks. For example, if a device that contained a certificate is stolen, an administrator can add the certificate to the revoked certificates list. Any endpoint that accepted this certificate earlier would now fail the authentication.

Every AD FS and WAP server will need to reach the CRL endpoint to validate if the cert that was presented to it is still valid and has not been revoked. CRL validation can occur over HTTPS, HTTP, LDAP or via OCSP (Online Certificate Status Protocol). If AD FS/WAP servers cannot reach the endpoint, the authentication will fail. Follow the steps below to troubleshoot it. 
1) Consult with your PKI engineer to determine the CRL endpoints used to revoke user certificates from your PKI system. 
2)	On each AD FS/WAP server ensure that the CRL endpoints are reachable via the protocol used (typically HTTPS or HTTP)
3)	For advanced validation, [enable CAPI2 event logging](https://blogs.msdn.microsoft.com/benjaminperkins/2013/09/30/enable-capi2-event-logging-to-troubleshoot-pki-and-ssl-certificate-issues/) on each AD FS/WAP server
4) Check for Event ID 41 (Verify Revocation) in the CAPI2 operational logs
5) Check for `‘\<Result value="80092013"\>The revocation function was unable to check revocation because the revocation server was offline.\</Result\>'`

***Tip***: You can target a single AD FS or WAP server for easier troubleshooting by configuring DNS resolution (HOSTS file on Windows) to point to a specific server. This allows you to enable tracing targeting a server. 

### Check if this is a Server Name Indication (SNI) issue
AD FS requires the client device (or browsers) and the load balancers to support SNI. Some client devices (usually older versions of Android) may not support SNI. Additionally, load balancers may not support SNI or have not been configured for SNI. In these instances you are likely to see user certification failures. 
1)	Work with your network engineer to ensure that the Load Balancer for AD FS/WAP supports SNI
2)	In the event that SNI can't be supported AD FS has a work around by following the below steps
    *	Open an elevated command prompt window on the primary AD FS server
    *   Type in ```Netsh http show sslcert```
    *   Copy the ‘application GUID' and ‘certificate hash' of the federation service
    *   Type in `netsh http add sslcert ipport=0.0.0.0:{your_certauth_port} certhash={your_certhash} appid={your_applicaitonGUID}`

### Check if the client device has been provisioned with the certificate correctly
You may notice that some devices are working correctly but other devices are not. In this case, it is usually a result of the user certificate not being provisioned correctly on the client device. Follow the steps below. 
1)	If the issue is specific to an Android device, the most common issue is that the certificate chain is not fully trusted on the Android device.  Refer to your MDM vendor to ensure that the certificate has been provisioned correctly and the entire chain is fully trusted on the Android device. 
2)	If the issue is specific to a Windows device, check if the certificate is provisioned correctly by checking the Windows Cert Store for the logged in user (not system/computer).
3)	Export the client user certificate to .cer file and run the command ‘certutil -f -urlfetch -verify certificatefilename.cer'


### Check if the TLS version is compatible between AD FS/WAP servers and the client device
In rare cases, a client device (typically mobile devices) are updated to only support a higher version of TLS (say 1.3) or you may have the reverse problem where AD FS/WAP servers were updated to only use a higher TLS version and the client device does not support it. 
You can use online SSL tools to check your AD FS/WAP servers and see if it is compatible with the device. 
For more information on how to control the TLS versions, see [this link](manage-ssl-protocols-in-ad-fs.md).

### Check if Azure AD PromptLoginBehavior is configured correctly on your federated domain settings
Many Office 365 applications send prompt=login to Azure AD. Azure AD, by default, converts it to a fresh password login to AD FS. As a result, even if you have configured certificate authentication in AD FS, your end users will only see a password login. 
1)	Get the federated domain settings using the ‘Get-MsolDomainFederationSettings' command let
2)	Ensure that PromptLoginBehavior parameter is set to one of ‘Disabled' or ‘NativeSupport'

For more information see [this link](ad-fs-prompt-login.md). 

### Additional Troubleshooting
These are rare occurrences
1)	If your CRL lists are very long, it may hit a time out when attempting to download. In that case you need to update the ‘MaxFieldLength' and ‘MaxRequestByte' as per https://support.microsoft.com/help/820129/http-sys-registry-settings-for-windows




## Reference: Complete list of user certificate claim types and example values

|                                         Claim type                                         |                              Example Value                               |
|--------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
|         https://schemas.microsoft.com/2012/12/certificatecontext/field/x509version         |                                    3                                     |
|     https://schemas.microsoft.com/2012/12/certificatecontext/field/signaturealgorithm      |                                sha256RSA                                 |
|           https://schemas.microsoft.com/2012/12/certificatecontext/field/issuer            |                 CN=entca, DC=domain, DC=contoso, DC=com                  |
|         https://schemas.microsoft.com/2012/12/certificatecontext/field/issuername          |                 CN=entca, DC=domain, DC=contoso, DC=com                  |
|          https://schemas.microsoft.com/2012/12/certificatecontext/field/notbefore          |                           12/05/2016 20:50:18                            |
|          https://schemas.microsoft.com/2012/12/certificatecontext/field/notafter           |                           12/05/2017 20:50:18                            |
|           https://schemas.microsoft.com/2012/12/certificatecontext/field/subject           |   E=user@contoso.com, CN=user, CN=Users, DC=domain, DC=contoso, DC=com   |
|         https://schemas.microsoft.com/2012/12/certificatecontext/field/subjectname         |   E=user@contoso.com, CN=user, CN=Users, DC=domain, DC=contoso, DC=com   |
|           https://schemas.microsoft.com/2012/12/certificatecontext/field/rawdata           |                {Base64 encoded digital certificate data}                 |
|        https://schemas.microsoft.com/2012/12/certificatecontext/extension/keyusage         |                             DigitalSignature                             |
|        https://schemas.microsoft.com/2012/12/certificatecontext/extension/keyusage         |                             KeyEncipherment                              |
|  https://schemas.microsoft.com/2012/12/certificatecontext/extension/subjectkeyidentifier   |                 9D11941EC06FACCCCB1B116B56AA97F3987D620A                 |
| https://schemas.microsoft.com/2012/12/certificatecontext/extension/authoritykeyidentifier  |    KeyID=d6 13 e3 6b bc e5 d8 15 52 0a fd 36 6a d5 0b 51 f3 0b 25 7f     |
| https://schemas.microsoft.com/2012/12/certificatecontext/extension/certificatetemplatename |                                   User                                   |
|           https://schemas.microsoft.com/2012/12/certificatecontext/extension/san           | Other Name:Principal Name=user@contoso.com, RFC822 Name=user@contoso.com |
|           https://schemas.microsoft.com/2012/12/certificatecontext/extension/eku           |                          1.3.6.1.4.1.311.10.3.4                          |

## Related Links
* [Configure alternate hostname binding for AD FS certificate authentication](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md)
* [Configure certificate authorities in Azure AD](https://docs.microsoft.com/azure/active-directory/active-directory-certificate-based-authentication-get-started#step-2-configure-the-certificate-authorities)
