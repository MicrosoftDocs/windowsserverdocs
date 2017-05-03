---
ms.assetid: 777aab65-c9c7-4dc9-a807-9ab73fac87b8
title: Configure AD FS Extranet Lockout Protection
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 04/10/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Configure AD FS Extranet Lockout Protection

>Applies To: Windows Server 2016, Windows Server 2012 R2

In the context of AD FS, Web Application Proxy functions as a federation server proxy. Web Application Proxy also serves as a barrier between the Internet and your corporate applications.  

Web Application Proxy provides a number of security features to protect your corporate network, such as your users and your resources, from external threats. One of these features is AD FS extranet lockout. In case of an attack in the form of authentication requests with invalid (bad) passwords that come through the Web Application Proxy, AD FS extranet lockout protects your users from an account lockout in Active Directory. In addition to protecting your users from an AD account lockout, AD FS extranet lockout also protects against brute force password guessing attacks.  

With the AD FS extranet lockout feature in Windows Server 2012 R2/2016, an AD FS administrator can set a maximum allowed number of failed authentication requests (**ExtranetLockoutThreshold**) and an observation window's time period (**ExtranetObservationWindow**). When this maximum number (**ExtranetLockoutThreshold**) of authentication requests is reached, AD FS stops trying to authenticate the supplied account credentials against Active Directory for the set time period (**ExtranetObservationWindow**). This action protects the account from an being locked out in Active Directory. These settings apply to all domains that the AD FS service can authenticate.  

AD FS extranet lockout functions independently from the AD lockout policies. However, we strongly recommend that you set the **ExtranetLockoutThreshold** parameter value to a value that is less than the AD account lockout threshold. Failing to do so would result in AD FS being unable to protect accounts from being locked out in Active Directory.  

To configure AD FS extranet lockout, you must configure the following properties for the AD FS service:

- **EnableExtranetLockout &lt;Boolean&gt;** - Enable/disable Extranet Lockout.  
- **ExtranetLockoutThreshold &lt;Integer&gt;** - Defines the maximum number of bad password attempts. For the extranet lockout to be effective this settings has to be lower than the Active Directory lockout treshold. The recommended Active Directory lockout threshold is 10 bad attempts. Given that value, the recommended value for ExtranetLockoutThreshold is 6. For more information, see [Configuring Account Lockout](https://blogs.technet.microsoft.com/secguide/2014/08/13/configuring-account-lockout/).     
- **ExtranetObservationWindow &lt;TimeSpan&gt;** - Defines the time period where AD FS does not attempt to contact the domain controller to validate the U/P and immediately rejects the request from outside. The recommended value for this setting is *30 minutes*.  

You can use the following Windows PowerShell command to configure the AD FS extranet lockout:

```powershell
Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow (new-timespan -Minutes 30)
```

> [!warning]
> When AD FS Extranet lockout on Server 2012 R2 is enabled all authentication requests through the WAP are validated by AD FS on the PDC. When the PDC is unavailble, users will be unable to authenticate from the extranet.

Server 2016 offers an additional parameter that allows AD FS to fallback to another domain controller when the PDC is unavailable:

- **ExtranetLockoutRequirePDC &lt;Boolean&gt;** - When enabled: extranet lockout requires a primary domain controller (PDC). When disabled: extranet lockout will fallback to another domain controller in case the PDC is unavailable.

You can use the following Windows PowerShell command to configure the AD FS extranet lockout on Server 2016:

```powershell
Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow (new-timespan -Minutes 30) -ExtranetLockoutRequirePDC $false
```

## Additional references  
[Best practices for securing Active Directory Federation Services](../../ad-fs/deployment/best-practices-securing-ad-fs.md)

[Set-AdfsProperties](https://technet.microsoft.com/en-us/itpro/powershell/windows/adfs/set-adfsproperties)

[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)