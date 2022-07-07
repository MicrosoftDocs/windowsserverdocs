---
title: What's new in the Windows Desktop client
description: Learn about recent changes to the Remote Desktop client for Windows Desktop
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 07/06/2022
---
# What's new in the Windows Desktop client

You can find more detailed information about the Windows Desktop client at [Get started with the Windows Desktop client](windowsdesktop.md). You'll find the latest updates for the available clients in this article.

## Supported client versions

The client can be configured for different [user groups](windowsdesktop-admin.md#configure-user-groups). The following table lists the current versions available for each user group:

|User group |Latest version  |Minimum supported version |
|-----------|----------------|--------------------------|
|Public     |1.2.3316        |1.2.1672                  |
|Insider    |1.2.3316        |1.2.1672                  |

## Updates for version 1.2.3316

*Date published: 7/06/2022*

Download: [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2139369), [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2139456), [Windows ARM64](https://go.microsoft.com/fwlink/?linkid=2139370)

- Fixed an issue where the service couldn't render RemoteApp windows while RemoteFX Advanced Graphics were disabled.
- Fixed an issue that happened when a user tried to connect to an Azure Virtual Desktop endpoint while using the Remote Desktop Services Transport Layer Security protocol (RDSTLS) with CredSSP disabled, which caused the Windows Desktop client to not prompt the user for credentials. Because the client couldn't authenticate, it would get stuck in an infinite loop of failed connection attempts.
- Fixed an issue that happened when users tried to connect to an Azure Active Directory (Azure AD)-joined Azure Virtual Desktop endpoint from a client machine joined to the same Azure AD tenant while the Credential Security Support Provider protocol (CredSSP) was disabled.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams for Azure Virtual Desktop, including the following:
  - Better noise suppression during calls.
  - A diagnostic overlay now appears when you press **Shift+Ctrl+Semicolon (;)** during calls. The diagnostic overlay only works with version 1.17.2205.23001 or later of the Remote Desktop WebRTC Redirector Service. You can download the latest version of the service [here](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4YM8L).

## Updates for version 1.2.3213

*Date published: 6/02/2022*

Download: [Windows 64-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4YfFO), [Windows 32-bit](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4YfFP), [Windows ARM64](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4YfFN)

- Reduced flicker when application is restored to full-screen mode from minimized state in single-monitor configuration.
- The client now shows an error message when the user tries to open a connection from the UI, but the connection doesn't launch.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams for Azure Virtual Desktop, including the following:
  - The new hardware encoding feature increases the video quality (resolution and framerate) of the outgoing camera during Teams calls. Because this feature uses the underlying hardware on the PC and not just software, we're being extra careful to ensure broad compatibility before turning the feature on by default for all users. Therefore, this feature is currently off by default. To get an early preview of the feature, you can enable it on your local machine by creating a registry key at **Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Terminal Server Client\Default\AddIns\WebRTC Redirector\\(DWORD)UseHardwareEncoding** and setting it to **1**. To disable the feature, set the key to **0**.

## Updates for version 1.2.3130

*Date published: 05/10/2022*

- Fixed the vulnerability known as [CVE-2022-22017](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-22017).
- Fixed the vulnerability known as [CVE-2022-26940](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-26940).
- Fixed the vulnerability known as [CVE-2022-22015](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-22015).
- Fixed an issue where the [Class Identifier (CLSID)-based registration of the dynamic virtual channel (DVC) plug-in](/windows/win32/termserv/dvc-plug-in-registration) wasn't working.

## Updates for version 1.2.3128

*Date published: 5/03/2022*

- Improved Narrator application experience.
- Accessibility improvements.
- Fixed a regression that prevented subsequent connections after reconnecting to an existing session with the group policy object (GPO) "User Configuration\Administrative Templates\System\Ctrl+Alt+Del Options\Remove Lock Computer" enabled.
- Added an error message for when a user selects a credential type for smart card or Windows Hello for Business but the required smart card redirection is disabled in the RDP file.
- Improved diagnostic for User Data Protocol (UDP)-based Remote Desktop Protocol (RDP) transport protocols.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams for Azure Virtual Desktop, including updating the WebRTC stack from version M88 to M98. M98 provides better reliability and performances when making audio and video calls.

## Updates for version 1.2.3004

*Date published: 3/29/2022*

- Fixed an issue where Narrator didn't announce grid or list views correctly.
- Fixed an issue where the msrdc.exe process might take a long time to exit after closing the last Azure Virtual Desktop connection if customers have set a very short token expiration policy.
- Updated the error message that appears when users are unable to subscribe to their feed.
- Updated the disconnect dialog boxes that appear when the user locks their remote session or puts their local computer in sleep mode to be only informational.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- [Multimedia redirection for Azure Virtual Desktop (preview)](/azure/virtual-desktop/multimedia-redirection) now has an update that gives it more site and media control compatibility.
- Improved connection reliability for Teams on Azure Virtual Desktop.

## Updates for version 1.2.2927

*Date published: 3/15/2022*

Fixed an issue where the number pad didn't work on initial focus.

## Updates for version 1.2.2925

*Date published: 03/08/2022*

- Fixed the vulnerability known as [CVE-2022-21990](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-21990).
- Fixed the vulnerability known as [CVE-2022-24503](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-24503).
- Fixed an issue where background updates could close active remote connections.

## Updates for version 1.2.2924

*Date published: 02/23/2022*

- The Desktop client now supports Ctrl+Alt+arrow key keyboard shortcuts during desktop sessions.
- Improved graphics performance with certain mouse types.
- Fixed an issue that caused the client to randomly crash when something ends a RemoteApp connection.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams for Azure Virtual Desktop, including the following:
  - The background blur feature is rolling out this week for Windows endpoints.
  - Fixed an issue that caused the screen to turn black during Teams video calls.

## Updates for version 1.2.2860

*Date published: 02/15/2022*

- Improved stability of Azure Active Directory authentication.
- Fixed an issue that was preventing users from opening multiple .RDP files from different host pools.

## Updates for version 1.2.2851

*Date published: 01/25/2022*

- Fixed an issue that caused a redirected camera to give incorrect error codes when camera access was restricted in the Privacy settings on the client device. This update should give accurate error messages in apps using the redirected camera.
- Fixed an issue where the Azure Active Directory credential prompt appeared in the wrong monitor.
- Fixed an issue where the background refresh and update tasks were repeatedly registered with the task scheduler, which caused the background and update task times to change without user input.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams for Azure Virtual Desktop, including the following:
    - In September 2021 we released a preview of our GPU render path optimizations but defaulted them off. After extensive testing, we've now enabled them by default. These GPU render path optimizations reduce endpoint-to-endpoint latency and solve some performance issues. You can manually disable these optimizations by setting the registry key **HKEY_CURRENT_USER \SOFTWARE\Microsoft\Terminal Server Client\IsSwapChainRenderingEnabled** to **00000000**.

## Updates for version 1.2.2691

*Date published: 01/12/2022*

- Fixed the vulnerability known as [CVE-2019-0887](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2019-0887).
- Fixed the vulnerability known as [CVE-2022-21850](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-21850).
- Fixed the vulnerability known as [CVE-2022-21851](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2022-21851).
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.

## Updates for version 1.2.2688

*Date published: 12/09/2021*

- Fixed an issue where some users were unable to subscribe using the "subscribe with URL" option after updating to version 1.2.2687.0.

## Updates for version 1.2.2687

*Date published: 12/02/2021*

- Improved manual refresh functionality to acquire new user tokens, which ensures the service can accurately update user access to resources.
- Fixed an issue where the service sometimes pasted empty frames when a user tried to copy an image from a remotely running Internet Explorer browser to a locally running Word document.
- Fixed the vulnerability known as [CVE-2021-38665](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38665).
- Fixed the vulnerability known as [CVE-2021-38666](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38666).
- Fixed the vulnerability known as [CVE-2021-1669](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-1669).
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Fixed a usability issue where the Windows Desktop client would sometimes prompt for a password (Azure Active Directory prompt) after the device went into sleep mode.
- Fixed an issue where the client didn't automatically expand and display interactive sign-in messages set by admins when a user signs in to their virtual machine.
- Fixed a reliability issue that appeared in version 1.2.2686 where the client stopped responding when users tried to launch new connections.
- Updates to Teams for Azure Virtual Desktop, including the following:
   - The notification volume level on the client device is now the same as the host device.
   - Fixed an issue where the device volume was low in Azure Virtual Desktop sessions
   - Fixed a multi-monitor screen sharing issue where screen sharing didn't appear correctly when moving from one monitor to the other.
   - Resolved a black screen issue that caused screen sharing to incorrectly show a black screen sometimes.
   - Increased the reliability of the camera stack when resizing the Teams app or turning the camera on or off.
   - Fixed a memory leak that caused issues like high memory usage or video freezing when reconnecting with Azure Virtual Desktop.
   - Fixed an issue that caused Remote Desktop connections to stop responding.

## Updates for version 1.2.2606

*Date published: 11/9/2021*

- Fixed the vulnerability known as [CVE-2021-38665](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38665).
- Fixed the vulnerability known as [CVE-2021-38666](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-38666).
- Fixed an issue where the service sometimes pasted empty frames when a user tried to copy an image from a remotely running Internet Explorer browser to a locally running Word document.

## Updates for version 1.2.2600

*Date published: 10/26/2021*

- Updates to Teams for Azure Virtual Desktop, including improvements to camera performance during video calls.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.

## Updates for version 1.2.2459

*Date published: 09/28/2021*

- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Fixed an issue that caused the client to prompt for credentials a second time after closing a credential prompt window while subscribing.
- Updates to Teams for Azure Virtual Desktop, including the following:
  - Fixed an issue in that made the video screen turn black and crash during calls in the Chrome browser.
  - Reduced E2E latency and some performance issues by optimizing the GPU render path in the Windows Desktop client. To enable the new render path, add the registry key **HKEY_CURRENT_USER \SOFTWARE\Microsoft\Terminal Server Client\IsSwapChainRenderingEnabled** and set its value to **00000001**. To disable the new render path and revert to the original path, either set the key's value to **00000000** or delete the key.

## Updates for version 1.2.2322

*Date published: 08/24/2021*

- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Added updates to Teams on Azure Virtual Desktop, including:
  - Fixed an issue that caused the screen to turn black when Direct X wasn't available for hardware decoding.
  - Fixed a software decoding and camera preview issue that happened when falling back to software decode.
- [Multimedia redirection for Azure Virtual Desktop](/azure/virtual-desktop/multimedia-redirection) is now in public preview.

## Updates for version 1.2.2223

*Date published: 08/10/2021*

- Fixed the security vulnerability known as [CVE-2021-34535](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-34535).

## Updates for version 1.2.2222

*Date published: 07/27/2021*

- The client also updates in the background when the auto-update feature is enabled, no remote connection is active, and MSRDCW.exe isn't running.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Fixed an ICE inversion parameter issue that prevented some Teams calls from connecting.

## Updates for version 1.2.2130

*Date published: 06/22/2021*

- Windows Virtual Desktop has been renamed to Azure Virtual Desktop. Learn more about the name change at [our announcement on our blog](https://azure.microsoft.com/blog/azure-virtual-desktop-the-desktop-and-app-virtualization-platform-for-the-hybrid-workplace/).
- Fixed an issue where the client would ask for authentication after the user ended their session and closed the window.
- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Fixed an issue with Logitech C270 cameras where Teams only showed a black screen in the camera settings and while sharing images during calls.

## Updates for version 1.2.2061

*Date published: 05/25/2021*

- Improved client logging, diagnostics, and error classification to help admins troubleshoot connection and feed issues.
- Updates to Teams on Azure Virtual Desktop, including the following:
  - Resolved a black screen video issue that also fixed a mismatch in video resolutions with Teams Server.
  - Teams on Azure Virtual Desktop now changes resolution and bitrate in accordance with what Teams Server expects.

## Updates for version 1.2.1954

*Date published: 05/13/2021*

- Fixed the vulnerability known as [CVE-2021-31186](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-31186).

## Updates for version 1.2.1953

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
- Fixed an issue where the client sometimes didn't send Event Hubs and Diagnostics events.
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
