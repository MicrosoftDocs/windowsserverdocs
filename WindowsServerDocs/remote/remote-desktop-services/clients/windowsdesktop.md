---
title: Get started with the Windows Desktop client
description: Basic information about the Windows Desktop client.
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
ms.date: 03/04/2020
ms.localizationpriority: medium
---
# Get started with the Windows Desktop client

>Applies to: Windows 10, Windows 10 IoT Enterprise, and Windows 7

You can use the Remote Desktop client for Windows Desktop to access Windows apps and desktops remotely from a different Windows device.

> [!NOTE]
> - This documentation is not for the Remote Desktop Connection (MSTSC) client that ships with Windows. It's for the new Remote Desktop (MSRDC) client.
> - This client currently only supports accessing remote apps and desktops from [Windows Virtual Desktop](https://aka.ms/wvd).
> - Curious about the new releases for the Windows Desktop client? Check out [What's new in the Windows Desktop client](windowsdesktop-whatsnew.md)

## Install the client

Choose the client that matches the version of Windows. The new Remote Desktop client (MSRDC) supports Windows 10, Windows 10 IoT Enterprise, and Windows 7 client devices.

- [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2068602)
- [Windows 32-bit](https://go.microsoft.com/fwlink/?linkid=2098960)
- [Windows ARM64](https://go.microsoft.com/fwlink/?linkid=2098961)

You can install the client for the current user, which doesn't require admin rights, or your admin can install and configure the client so that all users on the device can access it.

Once you've installed the client, you can launch it from the Start menu by searching for **Remote Desktop**.

## Update the client

You'll be notified whenever a new version of the client is available as long as your admin hasn't disabled notifications. The notification will appear in either the Connection Center or the Windows Action Center. To update your client, just select the notification.

You can also manually search for new updates for the client:

1. From the Connection Center, tap the overflow menu (**...**) on the command bar at the top of the client.
2. Select **About** from the drop-down menu.
3. Tap **Check for updates**.
4. If there's an update available, tap **Install update** to update the client.

## Feeds

Get the list of managed resources you can access, such as apps and desktops, by subscribing to the feed your admin provided you. When you subscribe, the resources become available on your local PC. The Windows Desktop client currently supports resources published from Windows Virtual Desktop.

### Subscribe to a feed

1. From the main page of the client, also known as the Connection Center, tap **Subscribe**.
2. Sign in with your user account when prompted.
3. The resources will appear in the Connection Center grouped by Workspace.

You can launch resources with one of the following methods:

- Go to the Connection Center and double-click a resource to launch it.
- You can also go to the Start menu and look for a folder with the Workspace name or enter the resource name in the search bar.

### Workspace details

After subscribing, you can view additional information about a Workspace on the Details panel:

- The name of the Workspace
- The URL and username used to subscribe
- The number of apps and desktops
- The date/time of the last update
- The status of the last update

Accessing the Details panel:

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Select **Details** from the drop-down menu.
3. The Details panel appears on the right side of the client.

After you've subscribed, the Workspace will update automatically on a regular basis. Resources may be added, changed, or removed based on changes made by your admin.

You can also manually look for updates to the resources when needed by selecting **Update now** from the Details panel.

### Unsubscribe from a feed

This section will teach you how to unsubscribe from a feed. You can unsubscribe to either subscribe again with a different account or remove your resources from the system.

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Select **Unsubscribe** from the drop-down menu.
3. Review the dialog box and select **Continue**.

## Managed desktops

Workspaces can contain multiple managed resources, including desktops. When accessing a managed desktop, you have access to all the apps installed by your admin.

### Desktop settings

You can configure some of the settings for desktop resources to ensure the experience meets your needs. To access the list of available settings right-click on the desktop resource and select **Settings**.

The client will use the settings configured by your admin unless you turn off the **Use default settings** option. Doing so allows you to configure the following options:

- **Use multiple displays** switches the desktop session between using a single or multiple displays.
- **Select the displays to use for the session** specifies which local displays to use for the session. All selected displays must be adjacent to each other. This setting is automatically disabled when you use a single display.
- **Start in full screen** determines whether the session will launch in full-screen or windowed mode. This setting is automatically enabled when you use multiple displays.
- **Update the resolution on resize** makes the Remote Desktop resolution automatically update when you resize the session in windowed mode. When disabled, the session always remains at whichever resolution you specify in **Resolution**. This setting is automatically enabled when you use multiple displays.
- **Resolution** lets you specify the resolution of the remote desktop. The session will retain this resolution for its entire duration. This setting is automatically disabled if the resolution is set to update on resize.
- **Change the size of the text and apps** specifies the size of the content of the session. This setting only applies when connecting to Windows 8.1 and later or Windows Server 2012 R2 and later. This setting is automatically disabled if the resolution is set to update on resize.
- **Fit session to window** determines how the session is displayed when the resolution of the remote desktop differs from the size of the local window. When enabled, the session content will be resized to fit inside the window while preserving the aspect ratio of the session. When disabled, scrollbars or black areas will be shown when the resolution and window size don't match.

## Provide feedback

Have a feature suggestion or want to report a problem? Tell us using the [Feedback Hub](feedback-hub://?tabid=2&contextid=883). You can also access the Feedback Hub through the client:

1. From the Connection Center, tap the **Send feedback** option on the command bar at the top of the client to open the Feedback Hub app.
2. Enter the required information in the **Summary** and **Details** fields. When you're done, tap **Next**.
3. Select whether it's a **Problem** or **Suggestion**.
4. Check to see if the category is in **Apps** > **Remote Desktop**. If it is, tap **Next**.
5. Review the existing feedback topics to see if someone else has reported the same problem. If not, select **Make a new bug**, then tap **Next**.
6. On the next page, you can give us more information so we can help you solve the problem. You can write more detailed information, submit screenshots, and even create a recording of the problem to show us what happened. To make a recording, select **Start recording**, then do what you did up to the point where the problem happened. When you're done, return to the Feedback Hub and select **Stop recording**.
7. When you're satisfied with the information, tap **Submit**.
8. On the "Thank you for your feedback!" page, tap **Share my feedback** to generate a link to your feedback that you can share with others as needed.

### Access client logs

You might need the client logs when investigating a problem.

To retrieve the client logs:

1. Ensure no sessions are active and the client process isn't running in the background by right-clicking on the **Remote Desktop** icon in the system tray and selecting **Disconnect all sessions**.
2. Open **File Explorer**.
3. Navigate to the **%temp%\DiagOutputDir\RdClientAutoTrace** folder.
