---
title: What's new in the Windows Desktop client
description: Learn about recent changes to the Remote Desktop client for Windows Desktop
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
ms.date: 01/14/2020
ms.localizationpriority: medium
---
# What's new in the Windows Desktop client

You can find more detailed information about the Windows Desktop client at [Get started with the Windows Desktop client](windowsdesktop.md). You'll find the latest updates to client below.

## Latest client versions

The client can be configured for different [user groups](windowsdesktop-admin.md#configure-user-groups). The following table lists the current versions available for each user group:

|User group |Version  |
|-----------|---------|
|Public     |1.2.535  |
|Insider    |1.2.594  |

## Updates for version 1.2.594

*Date published: 01/14/2020*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4o4cC), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4o4cI), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4oh9C)

- You can now select which displays to use for desktop connections. To change this setting, right-click the icon of the desktop connection and select **Settings**.
- Fixed an issue where the connection settings didn’t display the correct available scale factors.
- Fixed an issue where Narrator couldn’t read the dialogue shown while the connection initiated.
- Fixed an issue where the wrong user name displayed when the Azure Active Directory and Active Directory names didn’t match.
- Fixed an issue that made the client stop responding when initiating a connection while not connected to a network.
- Fixed an issue that caused the client to stop responding when attaching a headset.

## Updates for version 1.2.535

*Date published: 12/04/2019*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4k7jH), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4k7jL), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4k27O)

- You can now access information about updates directly from the more options button on the command bar at the top of the client.
- You can now report feedback from the command bar of the client.
- The Feedback option is now only shown if the Feedback Hub is available.
- Ensured the update notification is not shown when notifications are disabled through policy.
- Fixed an issue that prevented some RDP files from launching.
- Fixed a crash on startup of the client caused by corruption of some persistent settings.

## Updates for version 1.2.431

*Date published: 11/12/2019*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE48kow), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE48koA), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE48zYj)

- The 32-bit and ARM64 versions of the client are now available!
- The client now saves any changes you make to the connection bar (such as its position, size, and pinned state) and applies those changes across sessions.
- Updated gateway information and connection status dialogs.
- Addressed an issue that caused two credentials to prompt at the same time while trying to connect after the Azure Active Directory token expired.
- On Windows 7, users are now properly prompted for credentials if they had saved credentials when the server disallows it.
- The Azure Active Directory prompt now appears in front of the connection window when reconnecting.
- Items pinned to the taskbar are now updated during a feed refresh.
- Improved scrolling on the Connection Center when using touch.
- Removed the empty line from the resolution drop-down menu.
- Removed unnecessary entries in Windows Credential Manager.
- Desktop sessions are now properly sized when exiting full screen.
- The RemoteApp disconnection dialog now appears in the foreground when you resume your session after entering sleep mode.
- Addressed accessibility issues like keyboard navigation.

## Updates for version 1.2.247

*Date published: 09/17/2019*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE3LkSa)

- Improved the fallback languages for localized version. (For example, FR-CA will properly display in French instead of English.)
- When removing a subscription, the client now properly removes the saved credentials from Credential Manager.
- The client update process is now unattended once started and the client will relaunch once completed.
- The client can now be used on Windows 10 in S mode.
- Fixed an issue that caused the update process to fail for users with a space in their username.
- Fixed a crash that happened when authenticating during a connection.
- Fixed a crash that happened when closing the client.
