---
title: Windows Desktop client for admins
description: Information on the Windows Desktop client primarily useful to admins.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 09/16/2019
ms.localizationpriority: medium
---
# Windows Desktop client for admins

>Applies to: Windows 10 and Windows 7

This topic has additional information about the Windows Desktop client that admins will find useful. For basic usage information, see [Get started with the Windows Desktop client](windowsdesktop.md).

## Installation options

Although your users can install the client directly after downloading it, if you're deploying to multiple devices, you may want to also deploy the client to them through other means. Deploying using group policies or the Microsoft Endpoint Configuration Manager lets you run the installer silently using a command line. Run the following commands to deploy the client per-device or per-user.

### Per-device installation

```
msiexec.exe /I <path to the MSI> /qn ALLUSERS=1
```

### Per-user installation

```
msiexec.exe /i `<path to the MSI>` /qn ALLUSERS=2 MSIINSTALLPERUSER=1
```

## Configuration options

This section describes the new configuration options for this client.

### Configure update notifications

By default, the client notifies you whenever there's an update. To turn notifications off, set the following registry information:

- **Key:** HKLM\Software\Microsoft\MSRDC\Policies
- **Type:** REG_DWORD
- **Name:** AutomaticUpdates
- **Data:** 0 = Disable notifications. 1 = Show notifications.

### Configure user groups

You can configure the client for one of the following types of user groups, which determines when the client receives updates.

#### Insider group

The Insider group is for early validation, and consists of admins and their selected users. The Insider group serves as a test run to detect any issues in the update that can impact performance before it's released to the Public group.

> [!NOTE]
> We recommend each organization have some users in the Insider group to test updates and catch issues early.

In the Insider group, a new version of the client is released to the users on the second Tuesday of each month for early validation. If the update doesn't have issues, it gets released to the Public group two weeks later. Users in the Insider group will receive update notifications automatically whenever updates are ready. You can find more detailed information about changes to the client at [What's new with the Windows Desktop client](windowsdesktop-whatsnew.md).

To configure the client for the Insider group, set the following registry information:

- **Key:** HKLM\Software\Microsoft\MSRDC\Policies
- **Type:** REG_SZ
- **Name:** ReleaseRing
- **Data:** insider

#### Public group

This group is for all users and is the most stable version. You don't need to do anything to configure this group.

The Public group receives the version of the client that was tested by the Insider group every fourth Tuesday of each month. All users in the Public group will receive an update notification if that setting is enabled.
