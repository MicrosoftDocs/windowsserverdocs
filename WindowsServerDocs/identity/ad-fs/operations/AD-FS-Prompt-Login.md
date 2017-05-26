---
title: AD FS prompt=login
description: Frequently asked questions for AD FS 2016
author: billmath
ms.author:  billmath
manager: femila
ms.date: 05/23/2017
ms.topic: article
ms.custom: it-pro
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Active Directory Federation Services prompt=login parameter support
The following document describes the native support for the prompt=login parameter that is available in AD FS.

## What is prompt=login?  

Some Office 365 applications (with modern authentication enabled) send the prompt=login parameter to Azure AD as part of each authentication request.  By default, Azure AD translates this into two parameters:
    
 ```
    <b>wauth</b>=urn:oasis:names:tc:SAML:1.0:am:password, and <b>wfresh</b>=0
 ```

This can cause problems with corporate intranet and multi-factor authentication scenarios in which an authentication type other than username and password is desired.  

AD FS in Windows Server 2012 R2 with the July 2016 update rollup introduced native support for the prompt=login parameter.  This means, you now have the option of configuring Azure AD to send this parameter as-is to your AD FS service as part of Azure AD and Office 365 authentication requests.

### AD FS versions that support prompt=login
The following is a list of AD FS versions that support the prompt=login parameter.

- AD FS in Windows Server 2012 R2 with the July 2016 update rollup

- AD FS in Windows Server 2016

## How do to configure your Azure AD tenant to send prompt=login to AD FS

Use the Azure AD PowerShell module to configure the setting.

> [!NOTE]
> The prompt=login capability (enabled by the PromptLoginBehavior parameter) is currently available only in the [‘version 1.0’ Azure AD Powershell module](http://connect.microsoft.com/site1164/Downloads/DownloadDetails.aspx?DownloadID=59185), in which the cmdlets have names that include “Msol”, such as Set-MsolDomainFederationSettings.  It is not currently available via ‘version 2.0’ Azure AD PowerShell module, whose cmdlets have names like “Set-AzureAD\*”.


>[!IMPORTANT]
>Every time you set the PreferredAuthenticationProtocol, SupportsMfa, or PromptLoginBehavior settings on your Azure AD tenant, you must be sure to configure all three to your desired setting, even if you are not changing the values of all three settings.  If you do not set all three, there is a risk that one or more of the settings for which you don’t provide a value will be reset to their default settings, potentially causing a system outage.</b>

To configure prompt=login behavior, use the cmdlet syntax below:

```powershell
    Set-MsolDomainFederationSettings –DomainName <your domain name> -PreferredAuthenticationProtocol <your current protocol setting> -SupportsMfa <$True|$False> -PromptLoginBehavior <TranslateToFreshPasswordAuth|NativeSupport|Disabled>
```
where:

- the required 

 ```
<b>PreferredAuthenticationProtocol</b>
 ```

and

 ```
<b>SupportsMfa</b>
 ```
 
 parameter values can be found by viewing the PreferredAuthenticationProtocol and SupportsMfa settings, respectively, in the output from the cmdlet:

```powershell
    Get-MsolDomainFederationSettings -DomainName <your_domain_name> | fl *
 ```


- <b>TranslateToFreshPasswordAuth</b> means the default Azure AD behavior of sending <b>wauth</b> and <b>wfresh</b> to AD FS instead of prompt=login

- <b>NativeSupport</b> means that the prompt=login parameter will be sent as is to AD FS

- <b>Disabled</b> means nothing will be sent to AD FS

