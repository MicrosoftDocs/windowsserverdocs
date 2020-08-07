---
title: What's new in the Windows Desktop client
description: Learn about recent changes to the Remote Desktop client for Windows Desktop
ms.topic: article
author: heidilohr
manager: lizross
ms.author: helohr
ms.date: 07/28/2020
ms.localizationpriority: medium
---
# What's new in the Windows Desktop client

You can find more detailed information about the Windows Desktop client at [Get started with the Windows Desktop client](windowsdesktop.md). You'll find the latest updates to client below.

## Latest client versions

The client can be configured for different [user groups](windowsdesktop-admin.md#configure-user-groups). The following table lists the current versions available for each user group:

|User group |Version  |
|-----------|---------|
|Public     |1.2.1186 |
|Insider    |1.2.1186 |

## Updates for version 1.2.1186

*Date published: 07/28/2020*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4C7Qy), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4Ciex), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4C7Qx)

- You can now be subscribed to Workspaces with multiple user accounts, using the overflow menu (**...**) option on the command bar at the top of the client. To differentiate Workspaces, the Workspace titles now include the username, as do all app shortcuts titles.
- Added additional information to subscription error messages to improve troubleshooting.
- The collapsed/expanded state of Workspaces is now preserved during a refresh.
- Added a **Send Diagnostics and Close** button to the **Connection information** dialog.
- Fixed an issue with the CTRL + SHIFT keys in remote sessions.

## Updates for version 1.2.1104

*Date published: 06/23/2020*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4zeHS), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4zrAd), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4zeHR)

- Updated the automatic discovery logic for the **Subscribe** option to support the Windows Virtual Desktop Spring 2020 update. Customers with only Spring Update resources should no longer need to provide consent for the Fall 2019 release.
- Improved support for high-DPI devices with scale factor up to 400%.
- Fixed an issue where the disconnect dialog didn't appear.
- Fixed an issue where command bar tooltips would remain visible longer than expected.
- Fixed a crash when you tried to subscribe immediately after a refresh.
- Fixed a crash from incorrect parsing of date and time in some languages.

## Updates for version 1.2.1026

*Date published: 05/27/2020*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4xsGB), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4xd8P), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4xq7m)

- When subscribing, you can now choose your account instead of typing your email address.
- Added a new **Subscribe with URL** option that allows you to specify the URL of the Workspace you are subscribing to or leverage [email discovery](../rds-email-discovery.md) when available in cases where we can't automatically find your resources. This is similar to the subscription process in the other Remote Desktop clients. This can be used to subscribe directly to WVD Spring 2020 Update Workspaces.
- Added support to subscribe to a Workspace using a new [URI scheme](remote-desktop-uri.md) that can be sent in an email to users or added to a support website.
- Added a new **Connection information** dialog that provides client, network, and server details for desktop and app sessions. You can access the dialog from the connection bar in full screen mode or from the System menu when windowed.
- Desktop sessions launched in windowed mode now always maximize instead of going full screen when maximizing the window. Use the **Full screen** option from the system menu to enter full screen.
- The Unsubscribe prompt now displays a warning icon and shows the workspace names as a bulleted list.
- Added the details section to additional error dialogs to help diagnose issues.
- Added a timestamp to the details section of error dialogs.
- Fixed an issue where the RDP file setting **desktop size id** didn't work properly.
- Fixed an issue where the **Update the resolution on resize** display setting didn't apply after launching the session.
- Fixed localization issues in the desktop settings panel.
- Fixed the size of the focus box when tabbing through controls on the desktop settings panel.
- Fixed an issue causing the resource names to be difficult to read in high contrast mode.
- Fixed an issue causing the update notification in the action center to be shown more than once a day.

## Updates for version 1.2.945

*Date published: 04/28/2020*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4vhNM), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4vhNO), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4vuSV)

- Added new display settings options for desktop connections available when right-clicking a desktop icon on the Connection Center.
  - There are now three display configuration options: **All displays**, **Single display** and **Select displays**.
  - We now only show available settings when a display configuration is selected.
  - In Select display mode, a new **Maximize to current displays** option allows you to dynamically change the displays used for the session without reconnecting. When enabled, maximizing the session causes it to go full screen on all displays touched by the session window.
  - We've added a new **Single display when windowed** option for all displays and select displays modes. This option switches your session automatically to a single display when you exit full screen mode, and automatically returns to multiple displays when you maximize the window.
- We've added a new **Display settings** group to the system menu that appears when you right-click the title bar of a windowed desktop session. This will let you change some settings dynamically during a session. For example, you can change the new **Single display mode when windowed** and **Maximize to current displays** settings.
- When you exit full screen, the session window will return to its original location when you first entered full screen.
- The background refresh for Workspaces has been changed to every four hours instead of every hour. A refresh now happens automatically when launching the client.
- Resetting your user data from the About page now redirects to the Connection Center when completed instead of closing the client.
- The items in the system menu for desktop connections were reordered and the Help topic now points to the client documentation.
- Addressed some accessibility issues with tab navigation and screen readers.
- Fixed an issue where the Azure Active Directory authentication dialog appeared behind the session window.
- Fixed a flickering and shrinking issue when dragging a desktop session window between displays of different scale factors.
- Fixed an error that occurred when redirecting cameras.
- Fixed multiple crashes to improve reliability.

## Updates for version 1.2.790

*Date published: 03/24/2020*

- Renamed the "Update" action for Workspaces to "Refresh" for consistency with other Remote Desktop clients.
- You can now refresh a Workspace directly from its context menu.
- Manually refreshing a Workspace now ensures all local content is updated.
- You can now reset the client's user data from the About page without needing to uninstall the app.
- You can also reset the client's user data using msrdcw.exe /reset with an optional /f parameter to skip the prompt.
- We now automatically look for a client update when navigating to the About page.
- Updated the color of the buttons for consistency.

## Updates for version 1.2.675

*Date published: 02/25/2020*

- Connections to Windows Virtual Desktop are now blocked if the RDP file is missing the signature or one of the signscope properties has been modified.
- When a Workspace is empty or has been removed, the Connection Center no longer appears to be empty.
- Added the activity ID and error code on disconnect messages to improve troubleshooting. You can copy the dialog message with **Ctrl+C**.
- Fixed an issue that caused the desktop connection settings to not detect displays.
- Client updates no longer automatically restart the PC.
- Windowless icons should no longer appear on the taskbar.

## Updates for version 1.2.605

*Date published: 01/29/2020*

- You can now select which displays to use for desktop connections. To change this setting, right-click the icon of the desktop connection and select **Settings**.
- Fixed an issue where the connection settings didn't display the correct available scale factors.
- Fixed an issue where Narrator couldn't read the dialogue shown while the connection initiated.
- Fixed an issue where the wrong user name displayed when the Azure Active Directory and Active Directory names didn't match.
- Fixed an issue that made the client stop responding when initiating a connection while not connected to a network.
- Fixed an issue that caused the client to stop responding when attaching a headset.

## Updates for version 1.2.535

*Date published: 12/04/2019*

- You can now access information about updates directly from the more options button on the command bar at the top of the client.
- You can now report feedback from the command bar of the client.
- The Feedback option is now only shown if the Feedback Hub is available.
- Ensured the update notification is not shown when notifications are disabled through policy.
- Fixed an issue that prevented some RDP files from launching.
- Fixed a crash on startup of the client caused by corruption of some persistent settings.

## Updates for version 1.2.431

*Date published: 11/12/2019*

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

- Improved the fallback languages for localized version. (For example, FR-CA will properly display in French instead of English.)
- When removing a subscription, the client now properly removes the saved credentials from Credential Manager.
- The client update process is now unattended once started and the client will relaunch once completed.
- The client can now be used on Windows 10 in S mode.
- Fixed an issue that caused the update process to fail for users with a space in their username.
- Fixed a crash that happened when authenticating during a connection.
- Fixed a crash that happened when closing the client.
