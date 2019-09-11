---
title: Additional information on the Windows Desktop client
description: Additional information mostly for admins on the Windows Desktop client.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 09/15/2019
ms.localizationpriority: medium
---
# Additional information on the Windows Desktop client

>Applies to: Windows 10 and Windows 7

This page contains additional information for the Windows Desktop client. This may be specifically useful to admins managing the client. For basic usage of the client, refer to [Getting started with the Windows Desktop client](windowsdesktop.md).

## Installation options

While users can install the client directly after downloading it, you may want to deploy the client to a lot of device through other means like group policies or Microsoft Intune. This generally means running the client silently using a command line. Use the following commands to deploy the client per-device or per-user.

**Per-device installation**
msiexec.exe /i `<path to the MSI>` /qn ALLUSERS=1

**Per-user installation**
msiexec.exe /i `<path to the MSI>` /qn ALLUSERS=2 MSIINSTALLPERUSER=1

## Configuration options

This section describes the new configuration options for this client.

### Configuring the update notifications

By default, the client shows a notification when there is a new update available. If you are managing client updates for a group of users or simply do not want to see the notifications, you can turn them off by setting the following registry information:
**Key:** HKLM\Software\Microsoft\MSRDC\Policies
**Type:** REG_DWORD
**Name:** ReleaseRing
**Data:** insider

### Configuring the release ring of the client

You can set the client in one of two release rings which determines when the client receives updates.

#### Insider ring

This ring is for early validation and is primarily targeted for admins and their selected users to detect any issues that might impact their specific configuration before the client is released to the Public ring.

> [!NOTE]
> It is recommended that each customer have some users on the Insider ring to minimize risk and catch issues early.

In general, on the second Tuesday of each month, a new version of the client is released to the Insider ring for early validation before moving to the Public ring two weeks later. Users who enabled the Insider ring will receive an update notification automatically when it is available. The changes to the client will be available for review soon after it's released at [What's new with the Windows Desktop client](windowsdesktop-whatsnew.md).

To configure the client for the Insider ring, set the following registry information:
**Key:** HKLM\Software\Microsoft\MSRDC\Policies
**Type:** REG_SZ
**Name:** ReleaseRing
**Data:** insider

#### Public ring

This ring is for all external users to use for their daily usage and is the most stable version. No special configuration is needed.

In general, on the fourth Tuesday of each month, the latest Insider version is promoted to the Public ring. This version is then available to all users who will receive an update notification if enabled.
