---
title: What's new in the Windows Desktop client
description: Learn about recent changes to the Remote Desktop client for Windows Desktop
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 07/15/2021
ms.localizationpriority: medium
---
# What's new in the Windows Desktop client

You can find more detailed information about the Windows Desktop client at [Get started with the Windows Desktop client](windowsdesktop.md). You'll find the latest updates to client in this article.

## Supported client versions

The client can be configured for different [user groups](windowsdesktop-admin.md#configure-user-groups). The following table lists the current versions available for each user group:

|User group |Latest version  |Minimum supported version |
|-----------|----------------|--------------------------|
|Public     |1.2.2130        |1.2.1446                  |
|Insider    |1.2.2220        |1.2.1446                  |

## Updates for version 1.2.2220 (Insider)

*Date published: 07/14/2021*

Download: [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2139233), [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2139144), [Windows ARM64](https://go.microsoft.com/fwlink/?linkid=2139368)

- The client now updates in the background when the auto-update feature is enabled, no remote connection is active, and MSRDCW.exe isn't running.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Fixed an ICE inversion parameter issue that prevented some Teams calls from connecting.

## Updates for version 1.2.2130

*Date published: 06/22/2021*

Download: [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2139369), [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2139456), [Windows ARM64](https://go.microsoft.com/fwlink/?linkid=2139370)

- Azure Virtual Desktop has been renamed to Azure Virtual Desktop. Learn more about the name change at [our announcement on our blog](https://azure.microsoft.com/blog/azure-virtual-desktop-the-desktop-and-app-virtualization-platform-for-the-hybrid-workplace/).
- Fixed an issue where the client would ask for authentication after the user ended their session and closed the window.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Fixed an issue with Logitech C270 cameras where Teams only showed a black screen in the camera settings and while sharing images during calls.

## Updates for version 1.2.2061

*Date published: 05/25/2021*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWErE3), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWDZmj), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RWDU5d)

- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams on Azure Virtual Desktop, including the following:
  - Resolved a black screen video issue that also fixed a mismatch in video resolutions with Teams Server.
  - Teams on Azure Virtual Desktop now changes resolution and bitrate in accordance with what Teams Server expects.

## Updates for version 1.2.1954

*Date published: 05/06/2021*

- Fixed an issue that caused the client to crash when users selected "Disconnect all sessions" in the system tray.
- Fixed an issue where the client wouldn't switch to full screen on a single monitor with a docking station.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams on Azure Virtual Desktop, including the following:
  - Added hardware acceleration for video processing outgoing video streams for Windows 10-based clients.
  - When joining a meeting with both a front-facing and rear-facing or external camera, the front-facing camera will be selected by default.
  - Fixed an issue that made Teams on Azure Virtual Desktop crash while loading on x86-based machines.
  - Fixed an issue that caused striations during screen sharing.
  - Fixed an issue that prevented some people in meetings from seeing incoming video or screen sharing.

## Updates for version 1.2.1844

*Date published: 03/23/2021*

- Updated background installation functionality to perform silently for the client auto-update feature.
- Fixed an issue where the client forwarded multiple attempts to launch a desktop to the same session. Depending on your group policy configuration, the session host can now allow the creation of multiple sessions for the same user on the same session host or disconnect the previous connection by default. This behavior wasn't consistent before version 1.2.1755.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates for Teams on Azure Virtual Desktop, including the following:
  - We've offloaded video processing (XVP) to reduce CPU utilization by 5-10% (depending on CPU generation). Combined with the hardware decode feature from February's update, we've now reduced the total CPU utilization by 10-20% (depending on CPU generation).
  - We've added XVP and hardware decode, which allows older machines to display more incoming video streams smoothly in 2x2 mode.
  - We've also updated the WebRTC stack from version M74 to M88. M88 has better reliability, AV sync performance, and fewer transient issues.
  - We've replaced our software H264 encoder with OpenH264. OpenH264 is an open-source codec that increases video quality of the outgoing camera stream.
  - The client now has simultaneous shipping with 2x2 mode. 2x2 mode shows up to four incoming video streams simultaneously.

## Updates for version 1.2.1755

*Date published: 02/23/2021*

- Added the Experience Monitor access point to the system tray icon.
- Fixed an issue where entering an email address into the "Subscribe to a Workplace" tab caused the application to stop responding.
- Fixed an issue where the client sometimes didn't send EventHub and Diagnostics events.
- Updates to Teams on Azure Virtual Desktop, including:
  - Improved audio and video sync performance and added hardware accelerated decode that decreases CPU utilization on the client.
  - Addressed the most prevalent causes of black screen issues when a user joins a call or meeting with their video turned on, when a user performs screen sharing, and when a user toggles their camera on and off.
  - Improved quality of active speaker switching in single video view by reducing the time it takes for the video to appear and reducing intermittent black screens when switching video streams to another user.
  - Fixed an issue where hardware devices with special characters would sometimes not be available in Teams.

## Updates for version 1.2.1672

*Date published: 01/26/2021*

- Added support for the screen capture protection feature for Windows 10 endpoints. To learn more, see [Session host security best practices](/azure/virtual-desktop/security-guide#session-host-security-best-practices).
- Added support for proxies that require authentication for feed subscription.
- The client now shows a notification with an option to retry if an update didn't successfully download.
- Addressed some accessibility issues with keyboard focus and high-contrast mode.

## Updates for version 1.2.1525

*Date published: 12/01/2020*

- Added List view for remote resources so that longer app names are readable.
- Added a notification icon that appears when an update for the client is available.

## Updates for version 1.2.1446

*Date published: 10/27/2020*

- Added the auto-update feature, which allows the client to install the latest updates automatically.
- The client now distinguishes between different feeds in the Connection Center.
- Fixed an issue where the subscription account doesn't match the account the user signed in with.
- Fixed an issue where some users couldn't access remote apps through a downloaded file.
- Fixed an issue with Smartcard redirection.

## Updates for version 1.2.1364

*Date published: 09/22/2020*

- Fixed an issue where single sign-on (SSO) didn't work on Windows 7.
- Fixed the connection failure that happened when calling or joining a Teams call while another app has an audio stream opened in exclusive mode and when media optimization for Teams is enabled.
- Fixed a failure to enumerate audio or video devices in Teams when media optimization for Teams is enabled.
- Added a "Need help with settings?" link to the desktop settings page.
- Fixed an issue with the "Subscribe" button that happened when using high-contrast dark themes.

## Updates for version 1.2.1275

*Date published: 08/25/2020*

- Added functionality to auto-detect sovereign clouds from the user’s identity.
- Added functionality to enable custom URL subscriptions for all users.
- Fixed an issue with app pinning on the feed taskbar.
- Fixed a crash when subscribing with URL.
- Improved experience when dragging remote app windows with touch or pen.
- Fixed an issue with localization.

## Updates for version 1.2.1186

*Date published: 07/28/2020*

- You can now be subscribed to Workspaces with multiple user accounts, using the overflow menu (**...**) option on the command bar at the top of the client. To differentiate Workspaces, the Workspace titles now include the username, as do all app shortcuts titles.
- Added additional information to subscription error messages to improve troubleshooting.
- The collapsed/expanded state of Workspaces is now preserved during a refresh.
- Added a **Send Diagnostics and Close** button to the **Connection information** dialog.
- Fixed an issue with the CTRL + SHIFT keys in remote sessions.

## Updates for version 1.2.1104

*Date published: 06/23/2020*

- Updated the automatic discovery logic for the **Subscribe** option to support the Azure Resource Manager-integrated version of Azure Virtual Desktop. Customers with only Azure Virtual Desktop resources should no longer need to provide consent for Azure Virtual Desktop (classic).
- Improved support for high-DPI devices with scale factor up to 400%.
- Fixed an issue where the disconnect dialog didn't appear.
- Fixed an issue where command bar tooltips would remain visible longer than expected.
- Fixed a crash when you tried to subscribe immediately after a refresh.
- Fixed a crash from incorrect parsing of date and time in some languages.

## Updates for version 1.2.1026

*Date published: 05/27/2020*

- When subscribing, you can now choose your account instead of typing your email address.
- Added a new **Subscribe with URL** option that allows you to specify the URL of the Workspace you are subscribing to or leverage [email discovery](../rds-email-discovery.md) when available in cases where we can't automatically find your resources. This is similar to the subscription process in the other Remote Desktop clients. This can be used to subscribe directly to Azure Virtual Desktop workspaces.
- Added support to subscribe to a Workspace using a new [URI scheme](remote-desktop-uri.md) that can be sent in an email to users or added to a support website.
- Added a new **Connection information** dialog that provides client, network, and server details for desktop and app sessions. You can access the dialog from the connection bar in full screen mode or from the System menu when windowed.
- Desktop sessions launched in windowed mode now always maximize instead of going full screen when maximizing the window. Use the **Full screen** option from the system menu to enter full screen.
- The Unsubscribe prompt now displays a warning icon and shows the workspace names as a bulleted list.
- Added the details section to additional error dialogs to help diagnose issues.
- Added a timestamp to the details section of error dialogs.
- Fixed an issue where the RDP file setting **desktop size ID** didn't work properly.
- Fixed an issue where the **Update the resolution on resize** display setting didn't apply after launching the session.
- Fixed localization issues in the desktop settings panel.
- Fixed the size of the focus box when tabbing through controls on the desktop settings panel.
- Fixed an issue causing the resource names to be difficult to read in high contrast mode.
- Fixed an issue causing the update notification in the action center to be shown more than once a day.

## Updates for version 1.2.945

*Date published: 04/28/2020*

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

- Connections to Azure Virtual Desktop are now blocked if the RDP file is missing the signature or one of the signscope properties has been modified.
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
