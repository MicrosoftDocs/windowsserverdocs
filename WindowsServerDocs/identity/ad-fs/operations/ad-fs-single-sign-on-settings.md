---
ms.assetid: 1a443181-7ded-4912-8e40-5aa447faf00c
title: AD FS 2016 Single Sign On Settings
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 08/17/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---
# AD FS Single Sign-On Settings

Single Sign-On (SSO) allows users to authenticate once and access multiple resources without being prompted for additional credentials.  This article describes the default AD FS behavior for SSO, as well as the configuration settings that allow you to customize this behavior.  

## Supported types of Single Sign-On

AD FS supports several types of Single Sign-On experiences:  
  
-   **Session SSO**  
  
     Session SSO cookies are written for the authenticated user which eliminates further prompts when the user switches applications during a particular session. However, if a particular session ends, the user will be prompted for their credentials again.  
  
     AD FS will set session SSO cookies by default if users’ devices are not registered. If the browser session has ended and is restarted, this session cookie is deleted and is not valid any more.  
  
-   **Persistent SSO**  
  
     Persistent SSO cookies are written for the authenticated user which eliminates further prompts when the user switches applications for as long as the persistent SSO cookie is valid. The difference between persistent SSO and session SSO is that persistent SSO can be maintained across different sessions.  
  
     AD FS will set persistent SSO cookies if the device is registered. AD FS will also set a persistent SSO cookie if a user selects the “keep me signed in” option. If the persistent SSO cookie is not valid any more, it will be rejected and deleted.  
  
-   **Application specific SSO**  
  
     In the OAuth scenario, a refresh token is used to maintain the SSO state of the user within the scope of a particular application.  
  
     If a device is registered, AD FS will set the expiration time of a refresh token based on the persistent SSO cookies lifetime for a registered device which is 7 days by default for AD FS 2012R2 and up to a maximum of 90 days with AD FS 2016 if they use their device to access AD FS resources within a 14 day window. 

If the device is not registered but a user selects the “keep me signed in” option, the expiration time of the refresh token will equal the persistent SSO cookies lifetime for "keep me signed in" which is 1 day by default with maximum of 7 day. Otherwise, refresh token lifetime equals session SSO cookie lifetime which is 8 hours by default  
  
 As mentioned above, users on registered devices will always get a persistent SSO unless the persistent SSO is disabled. For un-registered devices, persistent SSO can be achieved by enabling the “keep me signed in” (KMSI) feature. 
 
 For Windows Server 2012 R2, to enable PSSO for the “Keep me signed in” scenario, you need to install this [hotfix](https://support.microsoft.com/en-us/kb/2958298/) which is also part of the of [August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/en-us/kb/2975719).   

Task | PowerShell | Description
------------ | ------------- | -------------
Enable/disable persistent SSO | ```` Set-AdfsProperties –EnablePersistentSso <Boolean> ````| Persistent SSO is enabled by default. If it is disabled, no PSSO cookie will be written.
"Enable/disable “keep me signed in" | ```` Set-AdfsProperties –EnableKmsi <Boolean> ```` | "Keep me signed in" feature is disabled by default. If it is enabled, end user will see a “keep me signed in” choice on AD FS sign-in page



## AD FS 2016 - Single Sign-On and authenticated devices
AD FS 2016 changes the PSSO when requestor is authenticating from a registered device increasing to max 90 Days but requiring an authentication within a 14 days period (device usage window).
After providing credentials for the first time, by default users with registered devices get single Sign-On for a maximum period of 90 days, provided they use the device to access AD FS resources at least once every 14 days.  If they wait 15 days after providing credentials, users will be prompted for credentials again.  

Persistent SSO is enabled by default. If it is disabled, no PSSO cookie will be written.|  

``` powershell
Set-AdfsProperties –EnablePersistentSso <Boolean\>
```     
  
The device usage window (14 days by default) is governed by the AD FS property **DeviceUsageWindowInDays**.

``` powershell
Set-AdfsProperties -DeviceUsageWindowInDays
```   
The maximum single Sign-On  period (90 days by default) is governed by the AD FS property **PersistentSsoLifetimeMins**.

``` powershell
Set-AdfsProperties -PersistentSsoLifetimeMins
```    

## Keep Me Signed in for unauthenticated devices 
For non-registered devices, the single sign-on  period is determined by the **Keep Me Signed In (KMSI)** feature settings.  KMSI is disabled by default and can be enabled by setting the AD FS property KmsiEnabled to True.

``` powershell
Set-AdfsProperties -EnableKmsi $true  
```    

With KMSI disabled, the default single sign-on period is 8 hours.  This can be configured using the property SsoLifetime.  The property is measured in minutes, so its default value is 480.  

``` powershell
Set-AdfsProperties –SsoLifetime <Int32\> 
```   

With KMSI enabled, the default single sign-on period is 24 hours.  This can be configured using the property KmsiLifetimeMins.  The property is measured in minutes, so its default value is 1440.

``` powershell
Set-AdfsProperties –KmsiLifetimeMins <Int32\> 
```   

## Multi-factor authentication (MFA) behavior  
It's important to note that, while providing relatively long periods of single sign on, AD FS will prompt for additional authentication (multi factor authentication) when a previous sign on was based on primary credentials and not MFA, but the current sign on requires MFA.  This is regardless of SSO configuration. AD FS, when it receives an authentication request, first determines whether or not there is an SSO context (such as a cookie) and then, if MFA is required (such as if the request is coming in from outside) it will assess whether or not the SSO context contains MFA.  If not, MFA is prompted.  


  
## PSSO revocation  
 To protect security, AD FS will reject any persistent SSO cookie previously issued when the following conditions are met. This will require the user to provide their credentials in order to authenticate with AD FS again. 
  
- User changes password  
  
- Persistent SSO setting is disabled in AD FS  
  
- Device is disabled by the administrator in lost or stolen case  
  
- AD FS receives a persistent SSO cookie which is issued for a registered user but the user or the device is not registered anymore  
  
- AD FS receives a persistent SSO cookie for a registered user but the user re-registered  
  
- AD FS receives a persistent SSO cookie which is issued as a result of “keep me signed in” but “keep me signed in” setting is disabled in AD FS  
  
- AD FS receives a persistent SSO cookie which is issued for a registered user but device certificate is missing or altered during authentication  
  
- AD FS administrator has set a cutoff time for persistent SSO. When this is configured, AD FS will reject any persistent SSO cookie issued before this time  
  
  To set the cutoff time, run the following PowerShell cmdlet:  
  

``` powershell
Set-AdfsProperties -PersistentSsoCutoffTime <DateTime>
```
  
## Enable PSSO for Office 365 users to access SharePoint Online  
 Once PSSO is enabled and configured in AD FS, AD FS will write a persistent cookie after a user has authenticated. The next time the user comes in, if a persistent cookie is still valid, a user does not need to provide credentials to authenticate again. You can also avoid the additional authentication prompt for Office 365 and SharePoint Online users by configuring the following two claims rules in AD FS to trigger persistence at Microsoft Azure AD and SharePoint Online.  To enable PSSO for Office 365 users to access SharePoint online, you need to install this [hotfix](https://support.microsoft.com/en-us/kb/2958298/) which is also part of the of [August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/en-us/kb/2975719).  
  
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
  
To Summarize:
<table>
  <tr>
    <th colspan="1">Single SignOn experience</th>
    <th colspan="3">ADFS 2012 R2 <br> Is Device Registered?</th>
        <th colspan="1"></th>
    <th colspan="3">ADFS 2016 <br> Is Device Registered?</th>
  </tr>

  <tr align="center">
    <th></th>
    <th>NO</th>
    <th>NO But KMSI</th>
    <th>YES</th>
    <th></th>
    <th>NO</th>
    <th>NO But KMSI</th>
    <th>YES</th>
  </tr>
 <tr align="center">
    <td>SSO=&gt;set Refresh Token=&gt;</td>
    <td>8 Hrs</td>
    <td>N/A</td>
    <td>N/A</td>
    <th></th>
    <td>8 Hrs</td>
    <td>N/A</td>
    <td>N/A</td>
  </tr>

 <tr align="center">
    <td>PSSO=&gt;set Refresh Token=&gt;</td>
    <td>N/A</td>
    <td>24 Hrs</td>
    <td>7 Days</td>
    <th></th>
    <td>N/A</td>
    <td>24 Hrs</td>
    <td>Max 90 Days with 14 Days Window</td>
  </tr>

 <tr align="center">
    <td>Token Lifetime</td>
    <td>1 Hrs</td>
    <td>1 Hrs</td>
    <td>1 Hrs</td>
    <th></th>
    <td>1 Hrs</td>
    <td>1 Hrs</td>
    <td>1 Hrs</td>
  </tr>
</table>

**Registered Device?** You get a PSSO / Persistent SSO <br>
**Not Registered Device?** You get a SSO <br>
**Not Registered Device but KMSI?** You get a PSSO/ Persistent SSO <p>
IF:
 - [x] Admin has enabled the KMSI feature [AND]
 - [x] User clicks the KMSI check box on the forms login page
 
**Good to Know:** <br>
Federated users who do not have the **LastPasswordChangeTimestamp** attribute synced are issued session cookies and refresh tokens that have a **Max Age value of 12 hours**.<br>
This occurs because Azure AD cannot determine when to revoke tokens that are related to an old credential (such as a password that has been changed). Therefore, Azure AD must check more frequently to make sure that the user and associated tokens are still in good standing.
