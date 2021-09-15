---
title: Windows Desktop client for admins
description: Information on the Windows Desktop client primarily useful to admins.
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 08/03/2021
ms.localizationpriority: medium
---
# Windows Desktop client for admins

>Applies to: Windows Server 2022, Windows Server 2019, Windows 10 and Windows 7

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

### Configure update behavior

Microsoft releases new versions of the client on a regular basis. You should always use the latest supported version of the client, so it's important that you configure your update policies to tell you when updates are ready. This section will show you how to configure your policies to enable or disable update notifications.

The update behavior of the client depends on two factors:

- Whether the app is installed for only the current user or for all users on the machine
- The value of the following registry key:

  - **Key:** HKLM\\Software\\Microsoft\\MSRDC\\Policies
  - **Type:** REG_DWORD
  - **Name:** AutomaticUpdates

The Windows Desktop client offers three ways to update:

- Notification-based updates, where a the client shows the user a notification in the client UI or a pop-up message in the taskbar. The user can choose to update the client by selecting the notification.
- Silent on-close updates, where the client automatically updates after the user has closed the UI of the Microsoft Remote Desktop Connection Center.
- Silent background updates, where a background process checks for updates a few times a day and will update the client if a new update is available.

To avoid interrupting your work, silent updates won't happen while you have the client open, have a remote connection active, or if you've disabled the feature. If the client is running while a silent background update occurs, the client will show a notification to let you know an update is available.

You can set your update policy to one of the following values:

| AutomaticUpdates registry key | Update behavior (per user installation) | Update behavior (per machine installation) |
|-------|------|-------|
| 0  | Disable notifications and turn off auto-update. | Disable notifications and turn off auto-update. |
| 1 | Notification-based updates. | Notification-based updates. |
| 2 (default) | Notification-based updates when the app is running. Otherwise, silent on-close and background updates. | Notification-based updates. No support for silent update mechanisms, as users may not have administrator access rights on the client device.  |

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
