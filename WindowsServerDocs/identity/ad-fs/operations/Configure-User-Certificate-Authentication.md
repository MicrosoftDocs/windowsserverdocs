---
description: Learn how to enable and troubleshoot user certificate authentication as an intranet or extranet authentication method in Active Directory Federation Services.
ms.assetid: 1ea2e1be-874f-4df3-bc9a-eb215002da91
title: Configure AD FS support for user certificate authentication
author: jenfieldmsft
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.custom: has-azure-ad-ps-ref
---

# Configure AD FS support for user certificate authentication

This article describes how to enable user certificate authentication in Active Directory Federation Services (AD FS). It also provides troubleshooting information for common problems with this type of authentication. 

There are two main use cases for user certificate authentication:

- Users are using smart cards to sign in against their AD FS system.
- Users are using certificates provisioned to mobile devices.

## Prerequisites

- Determine the mode of AD FS user certificate authentication that you want to enable by using one of the modes described in [AD FS support for alternate hostname binding for certificate authentication](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md).
- Ensure that your user certificate trust chain is installed and trusted by all AD FS and Web Application Proxy (WAP) servers, including any intermediate certificate authorities. You usually do this via Group Policy Object (GPO) on AD FS and WAP servers.
- Ensure that the root certificate of the chain of trust for your user certificates is in the NTAuth store in Active Directory.
- If you're using AD FS in alternate certificate authentication mode, ensure that your AD FS and WAP servers have Secure Sockets Layer (SSL) certificates that contain the AD FS hostname prefixed with "certauth." An example is `certauth.fs.contoso.com`. Also ensure that traffic to this hostname is allowed through the firewall.
- If you're using certificate authentication from the extranet, ensure that at least one Authority Information Access (AIA) and at least one CRL distribution point (CDP) or Online Certificate Status Protocol (OCSP) location from the list specified in your certificates are accessible from the internet.
- If you're configuring AD FS for Microsoft Entra certificate authentication, ensure that you've configured the [Microsoft Entra settings](/azure/active-directory/active-directory-certificate-based-authentication-get-started#step-2-configure-the-certificate-authorities) and the [AD FS claim rules](/azure/active-directory/active-directory-certificate-based-authentication-ios#requirements) required for certificate issuer and serial number.
- If you're using Microsoft Entra certificate authentication for Exchange ActiveSync clients, the client certificate must have the user's routable email address in Exchange Online in either the **Principal Name** value or the **RFC822 Name** value of the **Subject Alternative Name** field. Microsoft Entra ID maps the RFC822 value to the proxy address attribute in the directory.

> [!NOTE]
> AD FS doesn't support username hints with smart card or certificate-based authentication.

## Enable user certificate authentication

Enable user certificate authentication as an intranet or extranet authentication method in AD FS, by using either the AD FS Management console or the PowerShell cmdlet `Set-AdfsGlobalAuthenticationPolicy`.

Optional considerations include:

- If you want to use claims based on certificate fields and extensions in addition to the EKU claim type, `https://schemas.microsoft.com/2012/12/certificatecontext/extension/eku`, configure more claim passthrough rules on the Active Directory claims provider trust. See the [complete list of available certificate claims](#reference-complete-list-of-user-certificate-claim-types-and-example-values) later in this article.
- If you need to restrict access based on the type of certificate, you can use the additional properties on the certificate in AD FS issuance authorization rules for the application. Common scenarios are to allow only certificates provisioned by a mobile device management (MDM) provider or to allow only smart card certificates.

  > [!IMPORTANT]
  > Customers who use device code flow for authentication and perform device authentication by using an identity provider other than Microsoft Entra ID (for example, AD FS) can't enforce device-based access for Microsoft Entra resources. For example, they can't allow only managed devices by using a third-party MDM service.
  >
  > To help protect access to corporate resources in Microsoft Entra ID and prevent any data leakage, configure Microsoft Entra device-based Conditional Access. For example, use **Require device to be marked complaint** to grant control in Microsoft Entra Conditional Access.

  Configure allowed issuing certificate authorities for client certificates by using the guidance under "Management of trusted issuers for client authentication" in the [Schannel SSP technical overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn786429(v=ws.11)).

- Consider modifying sign-in pages to suit the needs of your users when they're doing certificate authentication. A common case is to change **Sign in with your X509 certificate** to something more user friendly.

## Configure seamless certificate authentication for the Chrome browser on Windows desktops

When a machine has multiple user certificates (such as Wi-Fi certificates) that satisfy the purposes of client authentication, the Chrome browser on Windows desktops will prompt users to select the right certificate. This prompt might be confusing to users. To optimize this experience, you can set a policy for Chrome to automatically select the right certificate.

You can set this policy manually by making a registry change, or you can configure it automatically via GPO (to set the registry keys). This requires your user client certificates for authentication against AD FS to have distinct issuers from other use cases.

For more information on configuring certificate authentication for Chrome, see [Chrome Enterprise policy list](https://chromeenterprise.google/policies/).

## Troubleshoot certificate authentication

Use the following information to troubleshoot common problems when you've configured AD FS for certificate authentication for users.

### Check if certificate trusted issuers are configured properly in all AD FS and WAP servers

If certificate trusted issuers aren't configured properly, a common symptom is an HTTP 204 error: "No content from https\://certauth.adfs.contoso.com."

AD FS uses the underlying Windows operating system to prove possession of the user certificate and ensure that it matches a trusted issuer by validating the certificate trust chain. To match the trusted issuer, you need to ensure that all root and intermediate authorities are configured as trusted issuers in the local store for computer certificate authorities.

To validate this automatically, use the [AD FS Diagnostics Analyzer tool](https://adfshelp.microsoft.com/DiagnosticsAnalyzer/Analyze). The tool queries all the servers and ensures that the right certificates are provisioned correctly.

1. Download and run the tool.
1. Upload the results and review for any failures.

### Check if certificate authentication is enabled in the AD FS authentication policy

AD FS performs user certificate authentication by default on port 49443 with the same hostname as AD FS (example: `adfs.contoso.com`). You can also configure AD FS to use port 443 (the default HTTPS port) by using the alternate SSL binding. However, the URL used in this configuration is `certauth.<adfs-farm-name>` (example: `certauth.contoso.com`). For more information, see [AD FS support for alternate hostname binding for certificate authentication](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md).

> [!NOTE]
> In AD FS on Windows Server 2016, two modes are now supported. The first mode uses the host `adfs.contoso.com` with ports 443 and 49443. The second mode uses hosts `adfs.contoso.com` and `certauth.adfs.contoso.com` with port 443. You need an SSL certificate to support `certauth.\<adfs-service-name>` as an alternate subject name. You can do this at the time of farm creation or later via PowerShell.

The most common case of network connectivity problems is that a firewall has been incorrectly configured and blocks traffic for user certificate authentication. Usually, you see a blank screen or a 500 server error when this problem occurs. To fix it:

1. Note the hostname and port that you configured in AD FS.
1. Ensure that any firewall in front of AD FS or WAP is configured to allow the `hostname:port` combination for your AD FS farm. Your network engineer must perform this step.

### Check CRL connectivity

Certificate revocation lists (CRLs) are endpoints that are encoded into the user certificate to perform runtime revocation checks. For example, if a device that contains a certificate is stolen, an administrator can add the certificate to the list of revoked certificates. Any endpoint that accepted this certificate earlier will now fail the authentication.

Every AD FS and WAP server needs to reach the CRL endpoint to validate if the certificate that was presented to it is still valid and hasn't been revoked. CRL validation can occur over HTTPS, HTTP, LDAP, or OCSP. If AD FS and WAP servers can't reach the endpoint, the authentication will fail. Use the following steps to troubleshoot it:

1. Consult with your public key infrastructure (PKI) engineer to determine which CRL endpoints are used to revoke user certificates from your PKI system.
1. On each AD FS and WAP server, ensure that the CRL endpoints are reachable via the protocol that's used (typically HTTPS or HTTP).
1. For advanced validation, [enable CAPI2 event logging](/archive/blogs/benjaminperkins/enable-capi2-event-logging-to-troubleshoot-pki-and-ssl-certificate-issues) on each AD FS and WAP server.
1. Check for Event ID 41 (Verify Revocation) in the CAPI2 operational logs.
1. Check for `<Result value="80092013">The revocation function was unable to check revocation because the revocation server was offline.</Result>`.

> [!TIP]
> You can target a single AD FS or WAP server for easier troubleshooting by configuring DNS resolution (hosts file on Windows) to point to a specific server. This technique allows you to enable tracing by targeting a server.

### Check for SNI problems

AD FS requires client devices (or browsers) and the load balancers to support Server Name Indication (SNI). Some client devices (for example, older versions of Android) might not support SNI. Additionally, load balancers might not support SNI or might not be configured for SNI. In these instances, you're likely to get user certification failures. 

To fix this problem, work with your network engineer to ensure that the load balancer for AD FS and WAP supports SNI. If SNI can't be supported, use the following workaround in AD FS:

1. Open an elevated Command Prompt window on the primary AD FS server.
1. Enter `Netsh http show sslcert`.
1. Copy the application GUID and certificate hash of the federation service.
1. Enter `netsh http add sslcert ipport=0.0.0.0:{your_certauth_port} certhash={your_certhash} appid={your_applicaitonGUID}`.

### Check if the client device has been provisioned with the certificate correctly

You might notice that some devices are working correctly but other devices are not. In most cases, it means that the user certificate wasn't provisioned correctly on some client devices. Follow these steps:

1. If the problem is specific to an Android device, the most common cause is that the certificate chain is not fully trusted on the device. Refer to your MDM vendor to ensure that the certificate has been provisioned correctly and the entire chain is fully trusted on the Android device.
   
   If the issue is specific to a Windows device, check if the certificate is provisioned correctly by checking the Windows certificate store for the logged-in user (not system or computer).
1. Export the client user certificate to a .cer file and run the command `certutil -f -urlfetch -verify certificatefilename.cer`.

### Check if the TLS version is compatible between AD FS/WAP servers and the client device

In rare cases, a client device is updated to support only a higher version of TLS (for example, 1.3). Or you might have the reverse problem, where AD FS and WAP servers were updated to use only a higher TLS version that the client device doesn't support.

You can use online SSL tools to check your AD FS and WAP servers and see if they're compatible with the device. For more information on how to control the TLS versions, see [Managing SSL/TLS protocols and cipher suites for AD FS](manage-ssl-protocols-in-ad-fs.md).

<a name='check-if-azure-ad-promptloginbehavior-is-configured-correctly-on-your-federated-domain-settings'></a>

### Check if Microsoft Entra PromptLoginBehavior is configured correctly on your federated domain settings

Many Office 365 applications send `prompt=login` to Microsoft Entra ID. Microsoft Entra ID, by default, converts it to a fresh password login to AD FS. As a result, even if you configured certificate authentication in AD FS, your users see only a password login. To fix this problem:

1. Get the federated domain settings by using the `Get-MsolDomainFederationSettings` cmdlet.
1. Ensure that the `PromptLoginBehavior` parameter is set to either `Disabled` or `NativeSupport`.

For more information, see [AD FS prompt=login parameter support](ad-fs-prompt-login.md).

### Additional troubleshooting

In a rare occurrence, if your CRL lists are very long, they might hit a time-out when attempting to download. In this case, you need to update `MaxFieldLength` and `MaxRequestByte` as described in [Http.sys registry settings for Windows](https://support.microsoft.com/help/820129/http-sys-registry-settings-for-windows).

## Reference: Complete list of user certificate claim types and example values

| Claim type | Example value |
|---|---|
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/x509version`| `3` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/signaturealgorithm` | `sha256RSA` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/issuer` | `CN=entca, DC=domain, DC=contoso, DC=com` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/issuername` | `CN=entca, DC=domain, DC=contoso, DC=com` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/notbefore` |`12/05/2016 20:50:18` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/notafter` | `12/05/2017 20:50:1`8 |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/subject` |   `E=user@contoso.com, CN=user, CN=Users, DC=domain, DC=contoso, DC=com` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/subjectname` |   `E=user@contoso.com, CN=user, CN=Users, DC=domain, DC=contoso, DC=com` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/field/rawdata` | `{Base64 encoded digital certificate data}` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/keyusage` | `DigitalSignature` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/keyusage` | `KeyEncipherment` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/subjectkeyidentifier` |`9D11941EC06FACCCCB1B116B56AA97F3987D620A` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/authoritykeyidentifier` |`KeyID=d6 13 e3 6b bc e5 d8 15 52 0a fd 36 6a d5 0b 51 f3 0b 25 7f` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/certificatetemplatename` |`User` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/san` | `Other Name:Principal Name=user@contoso.com, RFC822 Name=user@contoso.com` |
|`http://schemas.microsoft.com/2012/12/certificatecontext/extension/eku` |`1.3.6.1.4.1.311.10.3.4` |

## Related links

- [Configure alternate hostname binding for AD FS certificate authentication](ad-fs-support-for-alternate-hostname-binding-for-certificate-authentication.md)
- [Configure certificate authorities in Microsoft Entra ID](/azure/active-directory/active-directory-certificate-based-authentication-get-started#step-2-configure-the-certificate-authorities)
