---
title: Winlogon Automatic Restart Sign-On (ARSO)
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.service: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 15cddcfa-8a8e-45e4-bb76-b8e1a14ceac0
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Winlogon Automatic Restart Sign-On (ARSO)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

**Author**: Justin Turner, Senior Support Escalation Engineer with the Windows group  
  
> [!NOTE]  
> This content is written by a Microsoft customer support engineer, and is intended for experienced administrators and systems architects who are looking for deeper technical explanations of features and solutions in Windows Server 2012 R2 than topics on TechNet usually provide. However, it has not undergone the same editing passes, so some of the language may seem less polished than what is typically found on TechNet.  
  
## Overview  
Windows 8 introduced lock screen apps.  These are the applications that run and display notifications while the user's session is locked (calendar appointments, email and messages, etc.).  Devices that are restarted due to the Windows Update process fail to display these lock screen notifications upon restart.  Some users depend on these lock screen applications.  
  
## What's changed?  
When a user signs in on a Windows 8.1 device, LSA will save the user credentials in encrypted memory accessible only by lsass.exe. When Windows Update initiates an automatic reboot without user presence, these credentials will be used to configure Autologon for the user. Windows Update running as system with TCB privilege will initiate the RPC call to do this.  
  
On rebooting, the user will automatically be signed in via the Autologon mechanism and then additionally locked to protect the user's session. The locking will be initiated via Winlogon whereas the credential management is done by LSA.  By automatically signing on and locking the user on the console, the user's lock screen applications will be restarted and available.  
  
> [!NOTE]  
> After a Windows Update induced reboot, the last interactive user is automatically signed on and the session is locked so the user's lock screen apps can run.  
  
![Screenshot showing the lock screen](../media/winlogon-automatic-restart-sign-on-arso/GTR_ADDS_LockScreenApp.gif)  
  
![Screenshot showing the lock screen apps](../media/winlogon-automatic-restart-sign-on-arso/GTR_ADDS_LockScreen.gif)  
  
**Quick Overview**  
  
-   Windows Update requires restart  
  
-   Is computer able to restart (*no apps running that would lose data*)?  
  
    -   Restart for you  
  
    -   Log back in  
  
    -   Lock machine  
  
-   Enabled or disabled by Group Policy  
  
    -   Disabled by default in server SKUs  
  
-   Why?  
  
    -   Some updates cannot finish until the user logs back in.  
  
    -   Better user experience: don't have to wait 15 minutes for updates to finish installing  
  
-   How? AutoLogon  
  
    -   stores password, uses that credential to log you in  
  
    -   saves credential as an LSA secret in paged memory  
  
    -   Can only be enabled if BitLocker is enabled  
  
## Group Policy: Sign-in last interactive user automatically after a system-initiated restart  
In Windows 8.1 / Windows Server 2012 R2, autologon of the lock screen user after a Windows Update restart is opt in for Server SKUs and opt out for Client SKUs.  
  
**Policy location:** Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Logon Option  
  
**Policy Name:** Sign-in last interactive user automatically after a system-initiated restart  
  
**Supported on:** At least Windows Server 2012 R2, Windows 8.1 or Windows RT 8.1  
  
**Description/Help:**  
  
This policy setting controls whether a device will automatically sign-in the last interactive user after Windows Update restarts the system.  
  
If you enable or do not configure this policy setting, the device securely saves the user's credentials (including the user name, domain, and encrypted password) to configure automatic sign-in after a Windows Update restart. After the Windows Update restart, the user is automatically signed-in and the session is automatically locked with all the lock screen apps configured for that user.  
  
If you disable this policy setting, the device does not store the user's credentials for automatic sign-in after a Windows Update restart. The users' lock screen apps are not restarted after the system restarts.  
  
**Registry Editor**  
  
|Value Name|Type|Data|  
|-------|----|----|  
|DisableAutomaticRestartSignOn|DWORD|0<br /><br />**Example:**<br /><br />0 (Enabled)<br /><br />1 (Disabled)|  
  
**Policy Registry Location:** HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System  
  
**Type:** DWORD  
  
**Registry Name:** DisableAutomaticRestartSignOn  
  
Value: 0 or 1  
  
0 = Enabled  
  
1 = Disabled  
  
![Screenshot showing policy setting controls UI where you can specify whether a device will automatically sign-in the last interactive user after Windows Update restarts the system](../media/winlogon-automatic-restart-sign-on-arso/GTR_ADDS_SignInPolicy.gif)  
  
## Troubleshooting  
When WinLogon automatically locks, WinLogon's state trace will be stored in the WinLogon event log.  
  
The status of an Autologon configuration attempt is logged  
  
-   If it is successful  
  
    -   records it as such  
  
-   If it is a failure:  
  
    -   records what the failure was  
  
-   When BitLocker's state changes:  
  
    -   the removal of credentials will be logged  
  
        -   These will be stored in the LSA Operational log.  
  
### Reasons why autologon might fail  
There are several cases in which a user automatic login cannot be achieved.  This section is intended to capture the known scenarios in which this can occur.  
  
### User Must Change Password at Next Login  
User login can enter a blocked state when password change at next login is required.  This can be detected prior to restart in most cases, but not all (for example, password expiry can be reached between shutdown and next login.  
  
### User Account Disabled  
An existing user session can be maintained even if disabled.  Restart for an account that is disabled can be detected locally in most cases in advance, depending on gp it may not be for domain accounts (some domain cached login scenarios work even if account is disabled on DC).  
  
### Logon Hours and Parental Controls  
The Logon Hours and parental controls can prohibit a new user session from being created.  If a restart were to occur during this window, the user would not be permitted to login.  There is additional policy that causes lock or logout as a compliance action.  This could be problematic for many child cases where account lockdown may occur between bed time and wake-up, particularly if the maintenance window is commonly during this time.  
  
## Additional Resources  
**Table  SEQ Table \\\* ARABIC 3: ARSO Glossary**  
  
|Term|Definition|  
|----|-------|  
|Autologon|Autologon is a feature that has been present in Windows for several releases.  It is a documented feature of Windows that even has tools such as Autologon for Windows v3.01 *[http:/technet.microsoft.com/sysinternals/bb963905.aspx](https://technet.microsoft.com/sysinternals/bb963905.aspx)*<br /><br />It allows a single user of the device to sign in automatically without entering credentials. The credentials are configured and stored in registry as an encrypted LSA secret.|  
  

