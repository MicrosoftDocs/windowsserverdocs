---
title: What's new in the iOS client
description: Learn about recent changes to the Remote Desktop client for iOS
ms.prod: windows-server
ms.technology: remote-desktop-services
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 05/06/2020
ms.localizationpriority: medium
---
# What's new in the iOS client

We regularly update the [Remote Desktop client for iOS](remote-desktop-ios.md), adding new features and fixing issues. You'll find the latest updates on this page.

## How to report issues

We're committed to making the Remote Desktop client for iOS the best it can be, so we value your feedback. You can report any issues at **Help** > **Report an Issue**.

## Updates for version 10.0.7

*Date published: 4/29/2020*

In this update we've added the ability to sort the PC list view (available on iPhone) by name or time last connected.

## Updates for version 10.0.6

*Date published: 3/31/2020*

It's time for a quick update with some bug fixes. Here’s what's new for this release:

- Fixed a number of VoiceOver accessibility issues.
- Fixed an issue where users couldn't connect with Turkish credentials.
- Sessions displayed in the switcher UI are now ordered by when they were launched.
- Selecting the Back button in the Connection Center now takes you back to the last active session.
- Swiftpoint mice are now released when switching away from the client to another app.
- Improved interoperability with the Windows Virtual Desktop service.
- Fixed crashes that were showing up in error reporting.

We appreciate all the comments sent to us through the App Store, in-app feedback, and email. In addition, special thanks to everyone who worked with us to diagnose issues.

## Updates for version 10.0.5

*Date published: 03/09/20*

We've put together some bug fixes and feature updates for this 10.0.5 release. Here's what's new:

- Launched RDP files are now automatically imported (look for the toggle in General settings).
- You can now launch iCloud-based RDP files that haven't been downloaded in the Files app yet.
- The remote session can now extend underneath the Home indicator on iPhones (look for the toggle in Display settings).
- Added support for typing composite characters with multiple keystrokes, such as é.
- Added support for the iPad on-screen floating keyboard.
- Added support for adjusting properties of redirected cameras from a remote session.
- Fixed a bug in the gesture recognizer that caused the client to become unresponsive when connected to a remote session.
- You can now enter App Switching mode with a single swipe up (except when you're in Touch mode with the session extended into the Home indicator area).
- The Home indicator will now automatically hide when connected to a remote session, and will reappear when you tap the screen.
- Added a keyboard shortcut to get to app settings in the Connection Center (**Command + ,**).
- Added a keyboard shortcut to refresh all workspaces in the Connection Center (**Command + R**).
- Hooked up the system keyboard shortcut for Escape when connected to a remote session (**Command + .**).
- Fixed scenarios where the Windows on-screen keyboard in the remote session was too small.
- Implemented auto-keyboard focus throughout the Connection Center to make data entry more seamless.
- Pressing **Enter** at a credential prompt now results in the prompt being dismissed and the current flow resuming.
- Fixed a scenario where the client would crash when pressing Shift + Option + Left, Up, or Down arrow key.
- Fixed a crash that occurred when removing a SwiftPoint device.
- Fixed other crashes reported to us by users since the last release.

We'd like to thank everyone who reported bugs and worked with us to diagnose issues.

## Updates for version 10.0.4

*Date published: 02/03/20*

It's time for another update! We want to thank everyone who reported bugs and worked with us to diagnose issues. Here's what's new in this version:

- Confirmation UI is now shown when deleting user accounts and gateways.
- The search UI in the Connection Center has been slightly reworked.
- The username hint, if it exists, is now shown in the credential prompt UI when launching from an RDP file or URI.
- Fixed an issue where the extended on-screen keyboard would extend underneath the iPhone notch.
- Fixed a bug where external keyboards would stop working after being disconnected and reconnected.
- Added support for the Esc key on external keyboards.
- Fixed a bug where English characters appeared when entering Chinese characters.
- Fixed a bug where some Chinese input would remain in the remote session after deletion.
- Fixed other crashes reported to us by users since the last release.

We appreciate all your comments sent to us through the App Store, in-app feedback, and email. We'll continue focusing on making this app better with each release.

## Updates for version 10.0.3

*Date published: 01/16/20*

It's 2020 and time for our first release of the year, which means new features and bug fixes. Here's what is included in this update:

- Support for launching connections from RDP files and RDP URIs.
- Workspace headers are now collapsible.
- Zooming and panning at the same time is now supported in Mouse Pointer mode.
- A press-and-hold gesture in Mouse Pointer mode will now trigger a right-click in the remote session.
- Removed force-touch gesture for right-click in Mouse Pointer mode.
- The in-session switcher screen now supports disconnecting, even if no apps are connected.
- Light dismiss is now supported in the in-session switcher screen.
- PCs and apps are no longer automatically reordered in the in-session switcher screen.
- Enlarged the hit test area for the PC thumbnail view ellipses menu.
- The Input Devices settings page now contains a link to supported devices.
- Fixed a bug that caused the Bluetooth permissions UI to repeatedly appear at launch for some users.
- Fixed other crashes reported to us by users since the last release.

## Updates for version 10.0.2

*Date published: 12/20/19*

We've been working hard to fix bugs and add useful features. Here's what's new in this release:

- Support for Japanese and Chinese input on hardware keyboards.
- The PC list view now shows the friendly name of the associated user account, if one exists.
- The permissions UI in the first-run experience is now rendered correctly in Light mode.
- Fixed a crash that happened whenever someone pressed the Option and Up or Down arrow keys at the same time on a hardware keyboard.
- Updated the on-screen keyboard layout used in the password prompt UI to make finding the Backslash key easier.
- Fixed other crashes reported to us by users since the last release.

## Updates for version 10.0.1

*Date published: 12/15/19*

Here's what new in this release:

- Support for the Windows Virtual Desktop service.
- Updated Connection Center UI.
- Updated in-session UI.

## Updates for version 10.0.0

*Date published: 12/13/19*

It's been well over a year since we last updated the Remote Desktop Client for iOS. However, we're back with an exciting new update, and there will be many more updates to come on a regular basis from here on out. Here's what's new in version 10.0.0:

- Support for the Windows Virtual Desktop service.
- A new Connection Center UI.
- A new in-session UI that can switch between connected PCs and apps.
- New layout for the auxiliary on-screen keyboard.
- Improved external keyboard support.
- SwiftPoint Bluetooth mouse support.
- Microphone redirection support.
- Local storage redirection support.
- Camera redirection support (only available for Windows 10, version 1809 or later).
- Support for new iPhone and iPad devices.
- Dark and light theme support.
- Control whether your phone can lock when connected to a remote PC or app.
- You can now collapse the in-session connection bar by pressing and holding the Remote Desktop logo button.

## Updates for version 8.1.42

*Date published: 06/20/2018*

- Bug fixes and performance improvements.

## Updates for version 8.1.41

*Date published: 03/28/2018*

- Updates to address CredSSP encryption oracle remediation described in CVE-2018-0886.

## How to report issues

We're committed to making this app the best it can be and value your feedback. You can report issues to us by navigating to **Settings** > **Report an Issue** in the client.
