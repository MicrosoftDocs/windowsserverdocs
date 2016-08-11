---
title: AD FS 2016 Single Sign On Settings
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ae14f2b8-c670-409b-9998-9cea2ae6fb78
author: billmath
---
# AD FS 2016 Single Sign On Settings

>Applies To: Windows Server Technical Preview

This article describes the default AD FS behavior for how often users have to provide credentials before being prompted again, as well as the configuration settings that allow you to customize this behavior.  
  
## Registered devices  
After providing credentials for the first time, by default users with registered devices get single sign on for a maximum period of 90 days, provided they use the device to access AD FS resources at least once every 14 days.  If they wait 15 days after providing credentials, users will be prompted for credentials again.    
  
The device usage window (14 days by default) is governed by the AD FS property DeviceUsageWindowInDays (Set-AdfsProperties -DeviceUsageWindowInDays).    
The maximum single sign on period (90 days by default) is governed by the AD FS property PersistentSsoLifetimeMins (Set-AdfsProperties -PersistentSsoLifetimeMins).    
## Non-registered devices  
For non-registered devices, the single sign on period is determined by the Keep Me Signed In (KMSI) feature settings.  KMSI is disabled by default and can be enabled by setting the AD FS property KmsiEnabled to True (Set-AdfsProperties -EnableKmsi $true).   
  
With KMSI disabled, the default single sign on period is 8 hours.  This can be configured using the property SsoLifetime.  The property is measured in minutes, so its default value is 480.  
  
With KMSI enabled, the default single sign on period is 24 hours.  This can be configured using the property KmsiLifetimeMins.  The property is measured in minutes, so its default value is 1440.  The maximum configurable value of this property is 7 days.  (If a higher value is configured, 7 days will be enforced).  
  
## Enforcing multi factor authentication  
It�s important to note that, while providing relatively long periods of single sign on, AD FS will prompt for additional authentication (multi factor authentication) when a previous sign on was based on primary credentials and not MFA, but the current sign on requires MFA.  This is regardless of SSO configuration. AD FS, when it receives an authentication request, first determines whether or not there is an SSO context (such as a cookie) and then, if MFA is required (such as if the request is coming in from outside) it will assess whether or not the SSO context contains MFA.  If not, MFA is prompted.  
  
  
  
    


