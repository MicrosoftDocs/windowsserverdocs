---
title: AD FS 2016 Single Sign On Settings
description: "Learn more about: AD FS single sign-on Settings"
ms.topic: article
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
---
# AD FS single sign-on settings

Applies to: Windows Server (All supported versions)

Single sign-on (SSO) allows users to authenticate once and access multiple resources without being prompted for more credentials. This article describes the default AD FS behavior for SSO and the configuration settings that let you customize this behavior.

## Supported types of single sign-on

AD FS supports several types of single sign-on experiences:

- **Session SSO**

     Session SSO eliminates extra prompts when the user switches applications during a particular session. If a particular session ends, the user will be prompted for their credentials again. Session SSO cookies are written for the authenticated user.

     AD FS will set session SSO cookies by default if users' devices aren't registered. If the browser session has ended and is restarted, this session cookie is deleted and isn't valid anymore.

- **Persistent SSO**

     Persistent SSO eliminates extra prompts when the user switches applications for as long as the persistent SSO cookie is valid. Persistent SSO cookies are written for the authenticated user. The difference between persistent SSO and session SSO is that persistent SSO can be maintained across different sessions.

     AD FS will set persistent SSO cookies if the device is registered. AD FS will also set a persistent SSO cookie if a user selects the “Keep me signed in” option. If the persistent SSO cookie is no longer valid, it's rejected and deleted.

- **Application specific SSO**

     In the OAuth scenario, a refresh token is used to maintain the SSO state of the user within the scope of a particular application.

     AD FS will set the expiration time of a refresh token based on the persistent SSO cookie's lifetime for a registered device. By default, the cookie lifetime is seven days for AD FS on Windows Server 2012 R2. The default cookie lifetime for AD FS on Windows Server 2016 is up to a maximum of 90 days if the device is used to access AD FS resources within a 14-day window.

If the device isn't registered but a user selects the “Keep me signed in” option, the expiration time of the refresh token will equal the persistent SSO cookie's lifetime for "Keep me signed in". The persistent SSO cookie lifetime is one day by default with maximum of seven days. Otherwise, refresh token lifetime equals session SSO cookie lifetime (8 hours by default).

Users on registered devices will always get a persistent SSO unless the persistent SSO is disabled. For unregistered devices, persistent SSO can be achieved by enabling the “keep me signed in” (KMSI) feature.

For Windows Server 2012 R2, to enable PSSO for the “Keep me signed in” scenario, you need to install this [hotfix](https://support.microsoft.com/kb/2958298/), which is also part of the [August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/kb/2975719).

Task | PowerShell | Description
------------ | ------------- | -------------
Enable/disable persistent SSO | ```` Set-AdfsProperties –EnablePersistentSso <Boolean> ````| Persistent SSO is enabled by default. If it's disabled, no PSSO cookie is created.
"Enable/disable “keep me signed in" | ```` Set-AdfsProperties –EnableKmsi <Boolean> ```` | "Keep me signed in" feature is disabled by default. If it's enabled, the user will see a “Keep me signed in” choice on AD FS sign-in page

## AD FS 2016 - single sign-on and authenticated devices

AD FS 2016 changes the PSSO when requestor is authenticating from a registered device increasing to max 90 Days but requiring an authentication within a 14 days period (device usage window).
After providing credentials for the first time, by default users with registered devices get single sign-on for a maximum period of 90 days, provided they use the device to access AD FS resources at least once every 14 days. After 15 days, users will be prompted for credentials again.

Persistent SSO is enabled by default. If it's disabled, no PSSO cookie is created.|

``` powershell
Set-AdfsProperties –EnablePersistentSso <Boolean\>
```

The device usage window (14 days by default) is governed by the AD FS property **DeviceUsageWindowInDays**.

``` powershell
Set-AdfsProperties -DeviceUsageWindowInDays
```
The maximum single sign-on  period (90 days by default) is governed by the AD FS property **PersistentSsoLifetimeMins**.

``` powershell
Set-AdfsProperties -PersistentSsoLifetimeMins
```

## Keep Me Signed in for unauthenticated devices

For non-registered devices, the single sign-on  period is determined by the **Keep Me Signed In (KMSI)** feature settings. KMSI is disabled by default and can be enabled by setting the AD FS property KmsiEnabled to True.

``` powershell
Set-AdfsProperties -EnableKmsi $true
```

With KMSI disabled, the default single sign-on period is 8 hours. The single sign-on period can be configured using the property SsoLifetime. The property is measured in minutes, so its default value is 480.

``` powershell
Set-AdfsProperties –SsoLifetime <Int32\>
```

With KMSI enabled, the default single sign-on period is 24 hours. The single sign-on period with KMSI enabled can be configured using the property KmsiLifetimeMins. The property is measured in minutes, so its default value is 1440.

``` powershell
Set-AdfsProperties –KmsiLifetimeMins <Int32\>
```

## Multi-factor authentication (MFA) behavior

AD FS provides relatively long periods of single sign-on. It's important to note AD FS will prompt for more authentication (multi factor authentication) when a previous sign-on is based on primary credentials (not MFA) but the current sign-on requires MFA. This behavior is regardless of SSO configuration. When AD FS receives an authentication request, it first determines whether or not there's an SSO context (such as a cookie), and then whether MFA is required. For example, MFA is required when the authentication request is from outside. In such a case, AD FS assesses whether or not the SSO context contains MFA. If not, MFA is prompted.

## PSSO revocation

 To protect security, AD FS rejects any persistent SSO cookie previously issued when the following conditions are met:

- User changes password

- Persistent SSO setting is disabled in AD FS

- Device is disabled by the administrator in lost or stolen case

- AD FS receives a persistent SSO cookie, which is issued for a registered user but the user or the device isn't registered anymore

- AD FS receives a persistent SSO cookie for a registered user but the user re-registered

- AD FS receives a persistent SSO cookie, which is issued as a result of “keep me signed in” but “keep me signed in” setting is disabled in AD FS

- AD FS receives a persistent SSO cookie, which is issued for a registered user but device certificate is missing or altered during authentication

- AD FS administrator has set a cutoff time for persistent SSO. With a cutoff time configured, AD FS will reject any persistent SSO cookie issued before this time

Rejection of a persistent SSO cookie requires the user to provide their credentials in order to authenticate with AD FS again.

  To set the cutoff time, run the following PowerShell cmdlet:

``` powershell
Set-AdfsProperties -PersistentSsoCutoffTime <DateTime>
```

## Enable PSSO for Office 365 users to access SharePoint Online

After PSSO is enabled and configured, AD FS creates a persistent cookie immediately after user authentication. PSSO avoids the need to reauthenticate in subsequent sessions, as long as the cookie is still valid.

Users can also avoid extra authentication prompts for Office 365 and SharePoint Online. Configure the following two claims rules in AD FS to trigger persistence at Microsoft Entra ID and SharePoint Online. To enable PSSO for Office 365 users to access SharePoint online, install this [hotfix](https://support.microsoft.com/kb/2958298/). It's part of the [August 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2](https://support.microsoft.com/kb/2975719).

 An Issuance Transform rule to pass through the InsideCorporateNetwork claim

```
@RuleTemplate = "PassThroughClaims"
@RuleName = "Pass through claim - InsideCorporateNetwork"
c:[Type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork"]
=> issue(claim = c);
A custom Issuance Transform rule to pass through the persistent SSO claim
@RuleName = "Pass Through Claim - Psso"
c:[Type == "https://schemas.microsoft.com/2014/03/psso"]
=> issue(claim = c);

```

To Summarize:

| Single sign-on experience | ADFS 2012 R2 <br> Is device registered? | ADFS 2016 <br> Is device registered? |
| ------------ | ------------- | ------------- |
|  | No    No but KMSI    Yes | No    No but KMSI    Yes |
| SSO=>set Refresh Token=> | 8 hrs    n/a    n/a | 8 hrs    n/a    n/a |
| PSSO=>set Refresh Token=> | n/a    24 hrs    7 days | n/a    24 hrs    Max 90 days with 14-days window |
| Token lifetime | 1 hr    1 hr    1 hr | 1 hr    1 hr    1 hr |

**Registered Device?** You get PSSO / Persistent SSO.

**Not Registered Device?** You get SSO.

**Not Registered Device but KMSI?** You get PSSO/ Persistent SSO.

IF:
 - [x] Admin has enabled the KMSI feature [AND]
 - [x] User selects the KMSI check box on the forms sign in page

  
AD FS issues a new refresh token only if the validity of the newer refresh token is longer than the previous token. The maximum lifetime of a token is 84 days, but AD FS keeps the token valid on a 14-day sliding window. If the refresh token is valid for 8 hours, which is the regular SSO time, a new refresh token isn't issued.

**Good to Know:**

Federated users who don't have the **LastPasswordChangeTimestamp** attribute synced are issued session cookies and refresh tokens that have a **Max Age value of 12 hours**.

Max Age value session cookies and refresh tokens are issued because Microsoft Entra ID can't determine when to revoke tokens that are related to an old credential. This behavior could be caused by a password that has been changed, for example. Microsoft Entra ID must check more frequently to make sure that user and associated tokens are still valid.
