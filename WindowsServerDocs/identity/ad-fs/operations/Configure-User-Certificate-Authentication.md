---
ms.assetid: 1ea2e1be-874f-4df3-bc9a-eb215002da91
title: Configure AD FS support for user certificate authentication
description:
author: jenfieldmsft
ms.author: billmath
manager: samueld
ms.date: 01/18/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---
# Configuring AD FS for user certificate authentication


AD FS can be configured for x509 user certificate authentication using one of the modes described in [this article](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md). This capability can be used [with Azure Active Directory](https://blogs.msdn.microsoft.com/samueld/2016/07/19/adfs-certauth-aad-o365/) or on its own, to enable clients and devices provisioned with user certificates to access AD FS resources from the intranet or the extranet.

## Prerequisites
- Ensure that your user certificates are trusted by all AD FS and WAP servers
- Ensure that the root certificate of the chain of trust for your user certificates is in the NTAuth store in Active Directory
- If using AD FS in alternate certificate authentication mode, ensure that your AD FS and WAP servers have SSL certificates that contain the AD FS hostname prefixed with "certauth", for example "certauth.fs.contoso.com", and that traffic to this hostname is allowed through the firewall
- If using certificate authentication from the extranet, ensure that at least one AIA and at least one CDP or OCSP location from the list specified in your certificates are accessible from the internet.
- If you are configuring AD FS for Azure AD certificate authentication, ensure that you have configured the [Azure AD settings](https://docs.microsoft.com/azure/active-directory/active-directory-certificate-based-authentication-get-started#step-2-configure-the-certificate-authorities) and the [AD FS claim rules required](https://docs.microsoft.com/azure/active-directory/active-directory-certificate-based-authentication-ios#requirements) for certificate Issuer and Serial Number
- Also for Azure AD certificate authentication, for Exchange ActiveSync clients, the client certificate must have the users routable email address in Exchange online in either the Principal Name or the RFC822 Name value of the Subject Alternative Name field. (Azure Active Directory maps the RFC822 value to the Proxy Address attribute in the directory.)

## Configure AD FS for user certificate authentication  
- Enable user certificate authentication as an intranet or extranet authentication method in AD FS, using either the AD FS Management console or the PowerShell cmdlet Set-AdfsGlobalAuthenticationPolicy
- Ensure that the entire chain of trust, including any intermediate certificates, is installed on every AD FS and WAP server. 
The intermediate certificates should be installed in the local computer intermediate certification authorities store on all AD FS and WAP servers.
- If you wish to use claims based on certificate fields and extensions in addition to EKU (claim type https://schemas.microsoft.com/2012/12/certificatecontext/extension/eku), configure additional claim pass through rules on the Active Directory claims provider trust.  See below for a complete list of available certificate claims.  
- [Optional] Configure allowed issuing certification authorities for client certificates using the guidance under "Management of trusted issuers for client authentication" in [this article](https://technet.microsoft.com/library/dn786429(v=ws.11).aspx).

## Configure Seamless Certificate Authentication for Chrome browser on Windows Desktops
When multiple user certificates (such as Wi-Fi certificates) are present on the machine that satisfy the purposes of client authentication, the Chrome browser on Windows desktop will prompt the user to select the right certificate. This may be confusing to the end user. To optimize this experience, you can set a policy for Chrome to auto-select the right certificate for a better user experience. This policy can be set manually by making a registry change or configured automatically via GPO (to set the registry keys). This requires your user client certificates for authentication against AD FS to have distinct issuers from other use cases. 

For more information on configuring this for Chrome, please refer to this [link](http://www.chromium.org/administrators/policy-list-3#AutoSelectCertificateForUrls).  


## Troubleshooting
- If certificate authentication requests fail with an HTTP 204 "No Content from https:\//certauth.fs.contoso.com" response, verify that the root and any intermediate CA certificates are installed, respectively, to the trusted root CA and intermediate CA certificate stores on all federation servers.
- If certificate authentication requests are failing for unknown reasons, export the client certificate to a .cer file, and run the command 

`certutil -f -urlfetch -verify certificatefilename.cer`

Ensure any CRL and delta CRL locations resolve.  Note that delta CRL locations are found based on the contents of the Base CRL.

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

