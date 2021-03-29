---
title: What's new in the iOS client
description: Learn about recent changes to the Remote Desktop client for iOS
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 03/29/2021
ms.localizationpriority: medium
---
# What's new in the iOS client

We regularly update the [Remote Desktop client for iOS](remote-desktop-ios.md), adding new features and fixing issues. You'll find the latest updates on this page.

## How to report issues

We're committed to making the Remote Desktop client for iOS the best it can be, so we value your feedback. You can report any issues at **Help** > **Report an Issue**.

## Updates for version 10.2.5

*Date published: 03/29/2021*

It's time for a small update to address some reported bugs. In this version, we made the following updates:

- Fixed NETBIOS name resolution on iOS 14.
- Updated the app to proactively request local network access to enable connections to PCs around you.
- Fixed an issue where an RD Gateway connection would fail with a 0x3000064 error code.
- Fixed a bug where workspace discovery and download would fail if the port number was included in HTTP GET requests.
- Added examples of PC host names to the PC Name page in the Add/Edit PC UX.
- Addressed some VoiceOver accessibility issues.

## Updates for version 10.2.4

*Date published: 02/01/2021*

In this release, we've made the following changes to the connection bar and in-session user experience:

- You can now collapse the connection bar by moving it into one of the four corners of the screen.
- On iPads and large iPhones you can dock the connection bar to the left or right edge of the screen.
- You can now see the zoom slider panel by pressing and holding the connection bar magnification button. The new zoom slider controls the magnification level of the session in both touch and mouse pointer mode.

We also addressed some accessibility bugs and the following two issues:

- The client now validates the PC name in the Add/Edit PC UI to make sure the name doesn't contain illegal characters.
- Addressed an issue where the UI would stop resolving a workspace name during subscription.

## Updates for version 10.2.3

*Date published: 12/15/2020*

In this release, we've fixed issues that caused crashes and interfered with the "Display Zoom View" setting. We've also tweaked the "Use Full Display" setting to only appear on applicable iPads and adjusted the available resolutions for iPhones and iPads.

## Updates for version 10.2.2

*Date published: 11/23/2020*

In this release, we've addressed some bugs affecting users running iOS 14 and iPadOS 14.

## Updates for version 10.2.1

*Date published: 11/11/2020*

It's time for a quick update. In this version, we made the following fixes:

- Added support for newly released iPhone and iPad devices.
- Addressed an issue where the client would return a 0x30000066 error when connecting using an RD Gateway server.

## Updates for version 10.2.0

*Date published: 11/06/2020*

In this version, we addressed some compatibility issues with iOS and iPadOS 14. In addition, we made the following fixes and feature updates:

- Addressed crashes on iOS and iPadOS 14 that happened when entering input on keyboard.
- Added the Cmd+S and Cmd+N shortcuts to access the "Add Workspace" and "Add PC" processes, respectively.
- Added the Cmd+F shortcut to invoke Search UI in the Connection Center.
- Added the "Expand All" and "Collapse All" commands to the Workspaces tab.
- Resolved a bug that caused a 0xD06 protocol error to happen while running Outlook as a remote app.
- The on-screen keyboard will now disappear when you scroll through search results in the Connection Center.
- Updated the animation used when hovering over workspace icons with a mouse or trackpad pointer on iPadOS 14.

## Updates for version 10.1.4

*Date published: 11/06/2020*

We've put together some bug fixes and small feature updates for this 10.1.4 release. Here's what's new:

- Addressed an issue where the client would report a 0x5000007 error message when trying to connect to an RD Gateway server.
- User account passwords updated in the credential UI are now saved after successfully signing in.
- Addressed an issue where range and multi-select with the mouse or trackpad (Shift+click and Ctrl+click) didn't work consistently.
- Addressed a bug where apps displayed in the in-session switcher UI were out of sync with the remote session.
- Made some cosmetic changes to the layout of Connection Center workspace headers.
- Improved visibility of the on-screen keyboard buttons for dark backdrops.
- Fixed a localization bug in the disconnect dialog.

## Updates for version 10.1.3

*Date published: 11/06/2020*

We've put together some bug fixes and feature updates for the 10.1.3 release. Here's what's new:

- The input mode (Mouse Pointer or Touch mode) is now global across all active PC and remote app connections.
- Fixed an issue that prevented microphone redirection from working consistently.
- Fixed a bug that caused audio output to play from the iPhone earpiece instead of the internal speaker.
- The client now supports automatically switching audio output between the iPhone or iPad internal speakers, bluetooth speakers, and Airpods.
- Audio now continues to play in the background when switching away from the client or locking the device.
- The input mode automatically switches to Touch mode when using a SwiftPoint mouse on iPhones or iPads (not running iPadOS, version 13.4 or later).
- Addressed graphics output issues that occurred when the server was configured to use AVC444 full screen mode.
- Fixed some VoiceOver bugs.
- Panning around a zoomed in session works when using an external mouse or trackpad now works differently. To pan in a zoomed-in session with an external mouse or trackpad, select the pan knob, then drag your mouse cursor away while still holding the mouse button. To pan around in Touch mode, press on the pan knob, then move your finger. The session will stick to your finger and follow it around. In Mouse Pointer mode, push the virtual mouse cursor against the sides of the screen.

## Updates for version 10.1.2

*Date published 8/17/2020*

In this update, we've addressed issues that were reported in the version 10.1.1 update.

- Fixed a crash that occurred for some users when subscribing to a Windows Virtual Desktop feed using non-brokered authentication.
- Fixed the layout of workspace icons on the iPhone X, iPhone XS, and iPhone 11 Pro.

## Updates for version 10.1.1

*Date published: 11/06/2020*

Here’s what we've included in this release:

- Fixed a bug that prevented typing in Korean.
- Added support for F1 through F12, Home, End, PgUp and PgDn keys on hardware keyboards.
- Resolved a bug that made it difficult to move the mouse cursor to the top of the screen in letterboxed mode on iPadOS devices.
- Addressed an issue where pressing backspace after space deleted two characters.
- Fixed a bug that caused the iPadOS mouse cursor to appear on top of the Remote Desktop client mouse cursor in "Tap to Click" mode.
- Resolved an issue that prevented connections to some RD Gateway servers (error code 0x30000064).
- Fixed a bug that caused the mouse cursor to be shown in the in-session switcher UI on iOS devices when using a SwiftPoint mouse.
- Resized the RD client mouse cursor to be consistent with the current client scale factor.
- The client now checks for network connectivity before launching a workspace resource or PC connection.
- Hitting the remapped Escape button or Cmd+. now cancels out of any credential prompt.
- We've added some animations and polish that appear when you move the mouse cursor around on iPads running iPadOS 13.4 or later.

## Updates for version 10.1.0

*Date published: 11/06/2020*

Here's what's new for this version:

- If you're using iPadOS 13.4 or later, can now control the remote session with a mouse or trackpad.
- The client now supports the following Apple Magic Mouse 2 and Apple Magic Trackpad 2 gestures: left-click, left-drag, right-click, right-drag, horizontal and vertical scrolling, and local zooming.
- For external mice, the client now supports left-click, left-drag, right-click, right-drag, middle-click, and vertical scrolling.
- The client now supports keyboard shortcuts that use Ctrl, Alt, or Shift keys with the mouse or trackpad, including multi-select and range-select.
- The client now supports the "Tap-to-Click" feature for the trackpad.
- We've updated the Mouse Pointer mode's right-click gesture to press-and-hold (not press-and-hold-and-release). On the iPhone client we've thrown in some taptic feedback when we detect the right-click gesture.
- Added an option to disable NLA enforcement under **iOS Settings** > **RD Client**.
- Mapped Control+Shift+Escape to Ctrl+Shift+Esc, where Escape is generated using a remapped key on iPadOS or Command+.
- Mapped Command+F to Ctrl+F.
- Fixed an issue where the SwiftPoint middle mouse button didn't work in iPadOS version 13.3.1 or earlier and iOS.
- Fixed some bugs that prevented the client from recognizing the "rdp:" URI.
- Addressed an issue where the in-session Immersive Switcher UI showed outdated app entries if a disconnect was server-initiated.
- The client now supports the Azure Resource Manager-integrated version of Windows Virtual Desktop.

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
