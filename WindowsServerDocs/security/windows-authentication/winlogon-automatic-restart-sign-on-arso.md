---
description: Learn more about Winlogon Automatic Restart Sign-On (ARSO)
title: Winlogon Automatic Restart Sign-On (ARSO)
ms.topic: article
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---
# Winlogon Automatic Restart Sign-On (ARSO)

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

## Overview

Microsoft introduced lock screen apps in Windows 8. Lock screen apps are applications that run and display notifications while the user's session is locked (calendar appointments, email and messages, and so on). Devices that are restarted due to the Windows Update process fail to display these lock screen notifications upon restart. Some users depend on these lock screen applications.

## What's changed

When a user signs in on a Windows 8.1 device, LSA will save the user credentials in encrypted memory accessible only by lsass.exe. When Windows Update initiates an automatic reboot without user presence, these credentials are used to configure Autologon for the user. Windows Update running as system with TCB privilege will initiate the RPC call to do this.

On rebooting, the user will automatically be signed in via the Autologon mechanism and then additionally locked to protect the user's session. The locking will be initiated via Winlogon whereas the credential management is done by LSA.  By automatically signing on and locking the user on the console, the user's lock screen applications will be restarted and available.

> [!NOTE]
> After a Windows Update induced reboot, the last interactive user is automatically signed on and the session is locked so the user's lock screen apps can run.

![Screenshot showing the lock screen](../media/winlogon-automatic-restart-sign-on-arso/GTR_ADDS_LockScreenApp.gif)

![Screenshot showing the lock screen apps](../media/winlogon-automatic-restart-sign-on-arso/GTR_ADDS_LockScreen.gif)

## Quick Overview

- Windows Update requires restart

- Is computer able to restart (no apps running that would lose data)?

  - Restart

  - Log back in

  - Lock machine

- Enabled or disabled by Group Policy

  - Disabled by default in server SKUs

- Why?

  - Some updates can't finish until the user logs back in.

  - Better user experience; user doesn't have to wait 15 minutes for updates to finish installing

- How? AutoLogon

  - Stores password and uses this credential to log you in.

  - Saves credential as an LSA secret in paged memory.

  - Can only be enabled if BitLocker is enabled.

## Group Policy: Sign-in last interactive user automatically after a system-initiated restart

In Windows 8.1 / Windows Server 2012 R2, autologon of the lock screen user after a Windows Update restart is opt in for Server SKUs and opt out for Client SKUs.

**Policy location:** Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Logon Option

**Policy Name:** Sign-in last interactive user automatically after a system-initiated restart

**Supported on:** At least Windows Server 2012 R2, Windows 8.1 or Windows RT 8.1

**Description/Help:**

This policy setting controls whether a device will automatically sign-in the last interactive user after Windows Update restarts the system.

If you enable or don't configure this policy setting, the device securely saves the user's credentials (including the user name, domain, and encrypted password) to configure automatic sign-in after a Windows Update restart. After the Windows Update restart, the user is automatically signed-in and the session is automatically locked with all the lock screen apps configured for that user.

If you disable this policy setting, the device does not store the user's credentials for automatic sign-in after a Windows Update restart. The users' lock screen apps are not restarted after the system restarts.

### Registry Editor

|Value Name|Type|Data|
|-------|----|----|
|DisableAutomaticRestartSignOn|DWORD|0<p>**Example:**<p>0 (Enabled)<p>1 (Disabled)|

**Policy Registry Location:** HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System

**Type:** DWORD

**Registry Name:** DisableAutomaticRestartSignOn

Value: 0 or 1

0 = Enabled

1 = Disabled

![Screenshot showing policy setting controls UI where you can specify whether a device will automatically sign-in the last interactive user after Windows Update restarts the system](../media/winlogon-automatic-restart-sign-on-arso/GTR_ADDS_SignInPolicy.gif)

## Troubleshooting

When WinLogon automatically locks, the WinLogon state trace is stored in the WinLogon event log.

The status of an Autologon configuration attempt is logged

- If it is successful.

  - Records it as such.

- If it is a failure.

  - Records what the failure was.

- When BitLocker's state changes.

  - The removal of credentials is logged.

        - Credential removal is stored in the LSA Operational log.

### Reasons why Autologon can fail

There are several cases in which a user automatic logon cannot be achieved. This section is intended to capture the known scenarios in which this can occur.

#### User must change password at next logon

User logon can enter a blocked state when password change at next logon is required. This can be detected prior to restart in most cases, but not all (for example, password expiry can be reached between shutdown and next login.)

#### User account disabled

An existing user session can be maintained even if disabled. Restart for an account that's disabled can be detected locally in most cases in advance; depending on gp it may not be for domain accounts (some domain cached login scenarios work even if account is disabled on DC.)

#### Logon hours and Parental Controls

Logon Hours and Parental Controls can prohibit a new user session from being created. If a restart were to occur during this window, the user is prevented from login. There's additional policy that causes lock or logout as a compliance action. This could be problematic for many child user cases where account lockdown can occur between bedtime and morning, particularly if the maintenance window is commonly set during this time.

## Autologon

Autologon is a feature in Windows that offers tools such as Autologon for Windows v3.01. Autologon enables a single user of the device to sign in automatically without entering credentials. Credentials are configured and stored in registry as an encrypted LSA secret.See [http:/technet.microsoft.com/sysinternals/bb963905.aspx] for more information.