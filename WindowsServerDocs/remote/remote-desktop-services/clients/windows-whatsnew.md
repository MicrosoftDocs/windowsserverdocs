---
title: What's new in the Microsoft Store client
description: Learn about recent changes to the Microsoft Store client.
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 03/29/2021
ms.localizationpriority: medium
---
# What's new in the Microsoft Store client

We regularly update the [Microsoft Store client](windows.md), adding new features and fixing issues. Here's where you'll find the latest updates.

## Updates for version 10.2.1810

*Date published: 03/29/2021*

- Fixed an issue that caused crashes during clipboard scenarios.
- Fixed an issue that happened when using the client with HoloLens.
- Fixed an issue where the lock screen wasn't appearing in the remote session.
- Fixed issues that happened when the client tried to connect to devices with the “Always prompt for password upon connection” group policy set.
- Added several stability improvements to the client.

## Updates for version 10.2.1534

*Date published: 08/26/2020*

- Rewrote the client to use the same underlying RDP core engine as the iOS, macOS, and Android clients.
- Added support for the Azure Resource Manager-integrated version of Windows Virtual Desktop.
- Added support for x64 and ARM64.
- Updated the side panel design to full screen.
- Added support for light and dark modes.
- Added functionality to subscribe and connect to sovereign cloud deployments.
- Added functionality to enable backup and restore of workspaces (bookmarks) in release to manufacturing (RTM).
- Updated functionality to use existing Azure Active Directory (Azure AD) tokens during the subscription process to reduce the number of times users must sign in.
- Updated subscription can now detect whether you're using Windows Virtual Desktop or Windows Virtual Desktop (classic).
- Fixed issue with copying files to remote PCs.
- Fixed commonly reported accessibility issues with buttons.
- A limit of up to 20 credentials per app is allowed.

## Updates for version 10.1.1215

*Date published: 04/20/2020*

- Updated the user agent string for Windows Virtual Desktop.

## Updates for version 10.1.1195

*Date published: 03/06/2020*

- Audio from the session now continues to play even when the app is minimized or in the background.
- Fixed an issue where the toggle keys (caps lock, num lock, and so on) went out of sync between the local and remote PCs.
- Performance improvements on 64-bit devices.
- Fixed a crash that occurred whenever the app was suspended.

## Updates for version 10.1.1107

*Date published: 09/04/2019*

- You can now copy files between local and remote PCs.
- You can now use your email address to access remote resources (if enabled by your admin).
- You can now change user account assignments for remote resource feeds.
- The app now shows the proper icon for .rdp files assigned to this app in File Explorer instead of a blank default icon.

## Updates for version 10.1.1098

*Date published: 03/15/2019*

- You can now set a display name for user accounts so you can save the same username with different passwords.
- It's now possible to select an existing user account when adding Remote Resources.
- Fixed an issue where the client wasn't terminating correctly.
- The client now properly handles being suspended when secondary windows are open.
- Additional bug fixes.

## Updates for version 10.1.1088

*Date published: 11/06/2018*

- Connection display name is now more discoverable.
- Fixed a crash when closing the client window while a connection is still active.
- Fix a hang when reconnecting after the client is minimized.
- Allow desktops to be dragged anywhere in a group.
- Ensure launching a connection from the jump list results in a separate window when needed.
- Additional bug fixes.

## Updates for version 10.1.1060

*Date published: 09/14/2018*

- Addressed an issue where double-clicking a desktop connection caused two sessions to be launched.
- Fixed a crash when switching between virtual desktops locally.
- Moving a session to a different monitor now also updates the session scale factor.
- Handle additional system keys like AltGr.
- Additional bug fixes.

## Updates for version 10.1.1046

*Date published: 06/20/2018*

- Bug fixes.

## Updates for version 10.1.1042

*Date published: 04/02/2018*

- Updates to address CredSSP encryption oracle remediation described in CVE-2018-0886.
- Additional bug fixes.
