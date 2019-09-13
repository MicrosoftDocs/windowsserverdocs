---
title: Additional information on the Windows Desktop client
description: Information on the Windows Desktop client primarily useful to admins.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: heidilohr
manager: daveba
ms.author: helohr
ms.date: 09/15/2019
ms.localizationpriority: medium
---
# Additional information on the Windows Desktop client

>Applies to: Windows 10 and Windows 7

This page contains additional information for the Windows Desktop client. This may be primarily useful to admins managing the client. For basic usage of the client, refer to [Get started with the Windows Desktop client](windowsdesktop.md).

## Installation options

While users can install the client directly after downloading it, you may want to deploy the client to multiple devices through other means like group policies or System Center Configuration Manager. This generally means running the installer silently using a command line. Use the following commands to deploy the client per-device or per-user.

**Per-device installation**
msiexec.exe /i `<path to the MSI>` /qn ALLUSERS=1

**Per-user installation**
msiexec.exe /i `<path to the MSI>` /qn ALLUSERS=2 MSIINSTALLPERUSER=1

## Configuration options

This section describes the new configuration options for this client.

### Configuring the update notifications

By default, the client shows a notification when there is a new update available. If you are managing client updates for a group of users or simply do not want to see the notifications, you can turn them off by setting the following registry information:<br>
**Key:** HKLM\Software\Microsoft\MSRDC\Policies<br>
**Type:** REG_DWORD<br>
**Name:** AutomaticUpdates<br>
**Data:** 0 = Disable notifications. 1 = Show notifications.

### Configuring the user group

You can configure the client for one of two user groups which determines when the client receives updates.

#### Insider group

This group is for early validation and is primarily targeted for admins and their selected users to detect any issues that might impact their specific configuration before the client is released to the Public group.

> [!NOTE]
> It is recommended that each customer have some users in the Insider group to minimize risk and catch issues early.

In general, on the second Tuesday of each month, a new version of the client is released to the Insider group for early validation before moving to the Public group two weeks later. Users who joined the Insider group will receive an update notification automatically when it is available. The changes to the client will be available for review soon after it's released at [What's new with the Windows Desktop client](windowsdesktop-whatsnew.md).

To configure the client for the Insider group, set the following registry information:<br>
**Key:** HKLM\Software\Microsoft\MSRDC\Policies<br>
**Type:** REG_SZ<br>
**Name:** ReleaseRing<br>
**Data:** insider

#### Public group

This group is for all users to use for their daily usage and is the most stable version. No special configuration is needed.

In general, on the fourth Tuesday of each month, the latest Insider version is promoted to the Public group. This version is then available to all users who will receive an update notification if enabled.
