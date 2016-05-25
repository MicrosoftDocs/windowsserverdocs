---
title: Configuring AD FS Extranet Lockout
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6bb36a0d-5659-421b-ab7f-e568df0db503
author: billmath
---
# Configuring AD FS Extranet Lockout
In the context of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], Web Application Proxy functions as a federation server proxy. Web Application Proxy also serves as a barrier between the Internet and your corporate applications.  
  
Web Application Proxy provides a number of security features to protect your corporate network, such as your users and your resources, from external threats. One of these features is [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout. In case of an attack in the form of authentication requests with invalid \(bad\) passwords that come through the Web Application Proxy, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout enables you to protect your users from an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] account lockout. In addition to protecting your users from an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] account lockout, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout also protects against brute force password guessing attacks.  
  
With the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout feature in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] administrator can set a maximum allowed number of failed authentication requests \(`ExtranetLockoutThreshold`\) and an ‘observation window's time period \(`ExtranetObservationWindow`\). When this maximum number \(`ExtranetLockoutThreshold`\) of authentication requests is reached, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] stops trying to authenticate the supplied account credentials against [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for the set time period \(`ExtranetObservationWindow`\). This action protects this account from an AD account lockout, in other words, it protects this account from losing access to corporate resources that rely on [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for authentication of the user. These settings apply to all domains that the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] service can authenticate.  
  
[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout functions independently from the AD lockout policies. However, it can be used together with AD lockout policy. We strongly recommend that you set the `ExtranetLockoutThreshold` parameter value to a value that is less than the AD account lockout threshold.  
  
To configure the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout, you must set three properties on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] service object, in [!INCLUDE[wps_2](../Token/wps_2_md.md)] \(`get-adfsproperties`\/`set-adfsproperties`\):  
  
-   `EnableExtranetLockout`: Boolean, to enable\/disable.  
  
-   `ExtranetLockoutThreshold`: Integer, that defines the maximum number of bad password attempts. The recommended value for ExtranetLockoutThreshold is 15. The AD DS lockout threshold is 20. For more information, see [Strengthening Domain Policy Settings](http://technet.microsoft.com/library/cc772803(v=WS.10).aspx). When the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] lockout policies are in effect, we strongly recommend to set the value of `ExtranetLockoutThreshold` to a value below the AD DS lockout threshold value.  
  
-   `ExtranetObservationWindow`: *TimeSpan*, defines the time period where [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] does not attempt to contact the domain controller to validate the U\/P and immediately rejects the request from outside. The recommended value for `ExtranetObservationWindow` is *30 minutes*.  
  
You can use the following [!INCLUDE[wps_2](../Token/wps_2_md.md)] command to set the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] extranet lockout: `Set-AdfsProperties -EnableExtranetLockout $true -ExtranetLockoutThreshold 15 -ExtranetObservationWindow ( new-timespan -Minutes 30)`.  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
