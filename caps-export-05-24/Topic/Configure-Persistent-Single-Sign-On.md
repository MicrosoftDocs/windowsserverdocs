---
title: Configure Persistent Single Sign-On
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51cb61ba-55f1-450e-a322-63192211a7e7
author: billmath
---
# Configure Persistent Single Sign-On
AD FS supports several types of Single Sign\-On \(SSO\) experiences in Windows Server 2012 R2:  
  
-   **Session SSO**  
  
    Session SSO cookies are written for the authenticated user which eliminates further prompts when the user switches applications during a particular session. However, if a particular session ends, the user will be prompted for their credentials again.  
  
    AD FS will set session SSO cookies by default if users’ devices are not registered. If the browser session has ended and is restarted, this session cookie is deleted and is not valid any more.  
  
-   **Persistent SSO**  
  
    Persistent SSO cookies are written for the authenticated user which eliminates further prompts when the user switches applications for as long as the persistent SSO cookie is valid. The difference between persistent SSO and session SSO is that persistent SSO can be maintained across different sessions.  
  
    AD FS will set persistent SSO cookies if the device is registered. AD FS will also set persistent SSO cookie if a user selects the “keep me signed in” option. If the persistent SSO cookie is not valid any more, it will be rejected and deleted.  
  
-   **Application specific SSO**  
  
    In the OAuth scenario, a refresh token is used to maintain the SSO state of the user within the scope of a particular application.  
  
    If a device is registered, AD FS will set the expiration time of a refresh token based on the persistent SSO cookies lifetime for a registered device which is 7 days by default. If a user selects the “keep me signed in” option, the expiration time of the refresh token will equal the persistent SSO cookies lifetime for “keep me signed in” which is 1 day by default with maximum of 7 day. Otherwise, refresh token lifetime equals session SSO cookie lifetime which is 8 hours by default  
  
As mentioned above, users on registered devices will always get a persistent SSO unless the persistent SSO is disabled. For un\-registered devices, persistent SSO can be achieved by enabling the “keep me signed in” \(KMSI\) feature. To enable PSSO for the “Keep me signed in” scenario, you need to install this [hotfix](https://support.microsoft.com/en-us/kb/2958298/) which is also part of the of [August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/en-us/kb/2975719).   The following settings control PSSO setting and lifetime.  
  
|Task|PowerShell|Description|  
|--------|--------------|---------------|  
|Enable\/disable persistent SSO|Set\-AdfsProperties –EnablePersistentSso <Boolean>|Persistent SSO is enabled by default. If it is disabled, no PSSO cookie will be written.|  
|Enable\/disable “keep me signed in”|Set\-AdfsProperties –EnableKmsi <Boolean>|“Keep me signed in” feature is disabled by default. If it is enabled, end user will see a “keep me signed in” choice on AD FS sign\-in page.|  
|Persistent SSO lifetime for registered device|Set\-AdfsProperties \-PersistentSsoLifetimeMins <Int32>|This setting controls the lifetime of persistent SSO cookie written for registered device. The lifetime is 7 days by default. Persistent SSO cookie written as a result of “keep me signed in” has a different lifetime setting as shown below.|  
|Persistent SSO lifetime for KMSI|Set\-AdfsProperties –KmsiLifetimeMins <Int32>|The default value is 1440 mins.|  
  
## PSSO revocation  
To protect security, AD FS will reject any persistent SSO cookie issued before when the following conditions are met and user will need to provide credential in order to authenticate with AD FS again:  
  
-   User changes password  
  
-   Persistent SSO setting is disabled in AD FS  
  
-   Device is disabled by the administrator in lost or stolen case  
  
-   AD FS receives a persistent SSO cookie which is issued for a registered user but the user or the device is not registered anymore  
  
-   AD FS receives a persistent SSO cookie for a registered user but the user re\-registered  
  
-   AD FS receives a persistent SSO cookie which is issued as a result of “keep me signed in” but “keep me signed in” setting is disabled in AD FS  
  
-   AD FS receives a persistent SSO cookie which is issued for a registered user but device certificate is missing or altered during authentication  
  
-   AD FS administrator has set a cutoff time for persistent SSO. When this is configured, AD FS will reject any persistent SSO cookie issued before this time  
  
To set the cutoff time, run the following PowerShell cmdlet:  
  
```  
Set-AdfsProperties -PersistentSsoCutoffTime <DateTime>  
```  
  
## Enable PSSO for Office 365 users to access SharePoint Online  
Once PSSO is enabled and configured as shown above in AD FS, AD FS will write a persistent cookie after a user has authenticated and next time when the user comes in, if a persistent cookie is still valid, a user does not need to provide credentials to authenticate again. You can also avoid the additional authentication prompt for Office 365 and SharePoint Online users by configuring the following two claims rules in AD FS to trigger persistence at Microsoft Azure AD and SharePoint Online.  To enable PSSO for Office 365 users to access SharePoint online, you need to install this [hotfix](https://support.microsoft.com/en-us/kb/2958298/) which is also part of the of [August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/en-us/kb/2975719).  
  
An Issuance Transform rule to pass through the InsideCorporateNetwork claim  
  
```  
@RuleTemplate = "PassThroughClaims"  
@RuleName = "Pass through claim - InsideCorporateNetwork"  
c:[Type == "http://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork"]  
=> issue(claim = c);   
A custom Issuance Transform rule to pass through the persistent SSO claim  
@RuleName = "Pass Through Claim - Psso"  
c:[Type == "http://schemas.microsoft.com/2014/03/psso"]  
=> issue(claim = c);  
  
```  
  
