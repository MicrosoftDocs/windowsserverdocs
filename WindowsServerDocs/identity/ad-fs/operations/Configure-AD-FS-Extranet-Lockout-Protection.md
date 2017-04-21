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
  
Web Application Proxy provides a number of security features to protect your corporate network, such as your users and your resources, from external threats. One of these features is AD FS extranet lockout. In case of an attack in the form of authentication requests with invalid(bad) passwords that come through the Web Application Proxy, AD FS extranet lockout enables you to protect your users from an AD FS account lockout. In addition to protecting your users from an AD FS account lockout, AD FS extranet lockout also protects against brute force password guessing attacks.  
  
With the AD FS extranet lockout feature in  Windows Server 2016 and 2012 R2 , an AD FS administrator can set a maximum allowed number of failed authentication requests (`ExtranetLockoutThreshold`) and an ‘observation window's time period (`ExtranetObservationWindow`). When this maximum number (`ExtranetLockoutThreshold`) of authentication requests is reached, AD FS stops trying to authenticate the supplied account credentials against AD FS for the set time period (`ExtranetObservationWindow`). This action protects this account from an AD account lockout, in other words, it protects this account from losing access to corporate resources that rely on AD FS for authentication of the user. These settings apply to all domains that the AD FS service can authenticate.  
  
AD FS extranet lockout functions independently from the AD lockout policies. However, it can be used together with AD lockout policy. We strongly recommend that you set the `ExtranetLockoutThreshold` parameter value to a value that is less than the AD account lockout threshold.  
  
To configure the AD FS extranet lockout, you must set three properties on the AD FS service object, in Windows PowerShell (`get-adfsproperties`/`set-adfsproperties`):  
  
-   `EnableExtranetLockout`: Boolean, to enable/disable.  
  
-   `ExtranetLockoutThreshold`: Integer, that defines the maximum number of bad password attempts. The recommended value for ExtranetLockoutThreshold is 15. The AD DS lockout threshold is 20. For more information, see [Strengthening Domain Policy Settings](http://technet.microsoft.com/library/cc772803(v=WS.10).aspx). When the AD FS lockout policies are in effect, we strongly recommend to set the value of `ExtranetLockoutThreshold` to a value below the AD DS lockout threshold value.  
  
-   `ExtranetObservationWindow`: *TimeSpan*, defines the time period where AD FS does not attempt to contact the domain controller to validate the U/P and immediately rejects the request from outside. The recommended value for `ExtranetObservationWindow` is *30 minutes*.  
  
You can use the following Windows PowerShell command to set the AD FS extranet lockout: 

`Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow ( new-timespan -Minutes 30)`.  

## Additional references  
[Best Practices for Secure Planning and Deployment of AD FS](../../ad-fs/design/Best-Practices-for-Secure-Planning-and-Deployment-of-AD-FS.md)

[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md)
