---
ms.assetid: acc9101b-841c-4540-8b3c-62a53869ef7a
title: AD FS 2016 FAQ
description:
author: jenfieldmsft
ms.author:  jenfieldmsft
manager: samueld
ms.date: 10/12/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: identity-adfs
---

# AD FS Frequently Asked Questions (FAQ)

>Applies To: Windows Server 2016


-   [How can I upgrade/migrate from previous versions of AD FS?](AD-FS-FAQ.md#BKMK_1)  

-   [What third party multi-factor authentication providers are available for AD FS?](AD-FS-FAQ.md#BKMK_2)  

-   [Are third party proxies supported with AD FS?](AD-FS-FAQ.md#BKMK_3)  

-   [Where is the capacity planning sizing spreadsheet for AD FS 2016?](AD-FS-FAQ.md#BKMK_4)  

-   [How do I replace the SSL certificate for AD FS?](AD-FS-FAQ.md#BKMK_5)  

-   [Does the proxy SSL certificate have to be the same as the AD FS SSL certificate?](AD-FS-FAQ.md#BKMK_6)  

-   [How can I configure prompt=login behavior for AD FS?](AD-FS-FAQ.md#BKMK_7)  

-   [How can I configure browsers to use Windows Integrated Authentication (WIA) with AD FS?](AD-FS-FAQ.md#BKMK_8)  

-   [How long are AD FS tokens valid?](AD-FS-FAQ.md#BKMK_9)  

## <a name="BKMK_1"></a>How can I upgrade/migrate from previous versions of AD FS?  
You can upgrade an AD FS 2012 R2 farm using the “mixed farm” process described [here](https://technet.microsoft.com/windows-server-docs/identity/ad-fs/deployment/upgrading-to-ad-fs-in-windows-server-2016).  It works for WID or SQL farms, though the document shows only the WID scenario.

If you need to upgrade from AD FS 2.0 or 2.1 (Windows Server 2008 R2 or Windows Server 2012), you must use the in-box scripts (located in C:\Windows\ADFS).

## <a name="BKMK_2"></a>What third party multi-factor authentication providers are available for AD FS?  
Below is a list of third party providers we are aware of.  There may always be providers available that we do not know about and we will update the list as we learn about them.

[Gemalto Identity & Security Services](http://www.gemalto.com/identity)

[inWebo Enterprise Authentication service](http://www.inwebo.com/)

[Login People MFA API connector](https://www.loginpeople.com)

[RSA SecurID Authentication Agent for Microsoft Active Directory Federation Services](http://www.emc.com/security/rsa-securid/rsa-authentication-agents/microsoft-ad-fs.htm)

[SafeNet Authentication Service (SAS) Agent for AD FS](http://www.safenet-inc.com/resources/integration-guide/data-protection/Safenet_Authentication_Service/SafeNet_Authentication_Service__AD_FS_Agent_Configuration_Guide/?langtype=1033)

Swisscom [Mobile ID Authentication Service](http://swisscom.ch/mid)

[Symantec Validation and ID Protection Service (VIP)](http://www.symantec.com/vip-authentication-service)


## <a name="BKMK_3"></a>Are third party proxies supported with AD FS?  
Third party proxies can be placed in front of the Web Application Proxy, but any third party proxy must support the [MS-ADFSPIP protocol](https://msdn.microsoft.com/en-us/library/dn392811.aspx) to be used in place of the Web Application Proxy.

## <a name="BKMK_4"></a>Where is the capacity planning sizing spreadsheet for AD FS 2016?  
The AD FS 2016 version of the spreadsheet can be downloaded [here](http://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx).
This can also be used for AD FS in Windows Server 2012 R2.

## <a name="BKMK_5"></a>How do I replace the SSL certificate for AD FS?
The AD FS SSL certificate is not the same as the AD FS Service communications certificate found in the AD FS Management snap-in.  To change the AD FS SSL certificate, you’ll need to use PowerShell.  

Follow the steps below:

1) First, you’ll need to obtain the new certificate.  This is usually done by submitting a certificate signing request (CSR) to a third party, public certificate provider.  There are a variety of ways to generate the CSR, including from a Windows 7 or higher PC.  Your vendor should have documentation for this.

- Make sure the certificate meets the [AD FS and Web Application Proxy SSL certificate requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements)

2) Once you get the response from your certificate provider, you’ll need to import it to the Local Machine store on each AD FS and Web Application Proxy server.

3) On each AD FS server, use the following cmdlet to install the new SSL certificate

    ```
    PS C:\> Set-AdfsSslCertificate <thumbprint of new cert>
    ```

The certificate thumbprint can be found using the cmdlet

	PS C:\>dir Cert:\LocalMachine\My\

4) On each Web Application Proxy server use the following cmdlet to install the new SSL certificate:

    ```
    PS C:\> Set-WebApplicationProxySslCertificate <thumbprint of new cert>
    ```

If the above cmdlet fails because the old certificate has already expired, reconfigure the proxy using the following cmdlets:

	PS C:\>$cred = Get-Credential

Enter the credentials of a domain user who is local administrator on the AD FS server

	PS C:\>Install-WebApplicationProxy -FederationServiceTrustCredential $cred -CertificateThumbprint '<thumbprint of SSL cert in proxy LM store>' -FederationServiceName 'fs.contoso.com'

## <a name="BKMK_6"></a>Does the proxy SSL certificate have to be the same as the AD FS SSL certificate?  
- If the proxy is used to proxy AD FS requests that use Windows Integrated Authentication, the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- If the AD FS property "ExtendedProtectionTokenCheck" is enabled (the default setting in AD FS), the proxy SSL certificate must be the same (use the same key) as the federation server SSL certificate
- Otherwise, the proxy SSL certificate can have a different key from the AD FS SSL certificate, but must meet the same [requirements](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/AD-FS-2016-Requirements#BKMK_1)


## <a name="BKMK_7"></a>How can I configure prompt=login behavior for AD FS?  

**Why would I need to worry about prompt=login?**  

Some Office 365 applications (with modern authentication enabled) send the prompt=login parameter to Azure AD as part of each authentication request.  By default, Azure AD translates this into two parameters:

 <b>wauth</b>=urn:oasis:names:tc:SAML:1.0:am:password, and <b>wfresh</b>=0

This can cause problems with corporate intranet and multi factor authentication scenarios in which an authentication type other than username and password is desired.  

Now that AD FS has native support for the prompt=login parameter, you have the option of configuring Azure AD to send this parameter as-is to your AD FS service as part of Azure AD and Office 365 authentication requests.


**What version(s) of AD FS support prompt=login?**  
- AD FS in Windows Server 2012 R2 with the July 2016 update rollup

- AD FS in Windows Server 2016

**How do I configure my Azure AD tenant to send prompt=login to AD FS?**

Use the Azure AD PowerShell module to configure the setting.

> Note: The prompt=login capability (enabled by the PromptLoginBehavior parameter) is currently available only in the [‘version 1.0’ Azure AD Powershell module](http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185), in which the cmdlets have names that include “Msol”, such as Set-MsolDomainFederationSettings.  It is not currently available via ‘version 2.0’ Azure AD PowerShell module, whose cmdlets have names like “Set-AzureAD\*”.

> <b>Important: every time you set the PreferredAuthenticationProtocol, SupportsMfa, or PromptLoginBehavior settings on your Azure AD tenant, you must be sure to configure all three to your desired setting, even if you are not changing the values of all three settings.  If you do not set all three, there is a risk that one or more of the settings for which you don’t provide a value will be reset to their default settings, potentially causing a system outage.</b>

To configure prompt=login behavior, use the cmdlet syntax below:

    PS C:\>Set-MsolDomainFederationSettings –DomainName <your domain name> -PreferredAuthenticationProtocol <your current protocol setting> -SupportsMfa <$True|$False> -PromptLoginBehavior <TranslateToFreshPasswordAuth|NativeSupport|Disabled>

where:

- the required <b>PreferredAuthenticationProtocol</b> and <b>SupportsMfa</b> parameter values can be found by viewing the PreferredAuthenticationProtocol and SupportsMfa settings, respectively, in the output from the cmdlet:

    ```
    PS:\>Get-MsolDomainFederationSettings -DomainName <your_domain_name> | fl *
    ```


- <b>TranslateToFreshPasswordAuth</b> means the default Azure AD behavior of sending <b>wauth</b> and <b>wfresh</b> to AD FS instead of prompt=login

- <b>NativeSupport</b> means that the prompt=login parameter will be sent as is to AD FS

- <b>Disabled</b> means nothing will be sent to AD FS

## <a name="BKMK_8"></a>How can I configure browsers to use Windows Integrated Authentication (WIA) with AD FS?  

AD FS 2016 now has an improved default setting that enables the Edge browser to do WIA while not also (incorrectly) catching Windows Phone as well:

    “=~Windows\s*NT.*Edge”

The above means you no longer have to configure individual user agent strings to support common Edge scenarios, even though they are updated quite often.

For other browsers, configure the AD FS property WiaSupportedUserAgents to add the required values based on the browsers you are using.

**View the current setting**

    PS C:\>$strings = Get-AdfsProperties | select -ExpandProperty WiaSupportedUserAgents

**Add additional strings or regex match expresssions**

    PS C:\>$strings = $strings+”newstring”
    PS C:\>Set-AdfsProperties -WiaSupportedUserAgents $strings


## <a name="BKMK_9"></a>How long are AD FS tokens valid?

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
