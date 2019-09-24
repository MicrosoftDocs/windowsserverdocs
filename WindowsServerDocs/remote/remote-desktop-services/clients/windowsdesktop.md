---
title: Get started with the Windows Desktop client
description: Basic information about the Windows Desktop client.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: heidilohr
manager: daveba
ms.author: helohr
ms.date: 09/13/2019
ms.localizationpriority: medium
---
# Get started with the Windows Desktop client

>Applies to: Windows 10 and Windows 7

You can use the Remote Desktop client for Windows Desktop to access Windows apps and desktops remotely from a different Windows device.

> [!NOTE]
> - This documentation is not for the Remote Desktop Connection (MSTSC) client that ships with Windows. It's for the new Remote Desktop (MSRDC) client.
> - This client currently only supports accessing remote apps and desktops from [Windows Virtual Desktop](https://aka.ms/wvd).
> - Curious about the new releases for the Windows Desktop client? Check out [What's new in the Windows Desktop client](windowsdesktop-whatsnew.md)

## Install the client

You can currently download the client for Windows 64-bit. We'll update this list as the client becomes available for more versions of Windows.

- [Windows 64-bit client](https://go.microsoft.com/fwlink/?linkid=2068602)

You can install the client for the current user, which doesn't require admin rights, or your admin can install and configure the client so that all users on the device can access it.

Once installed, the client can be launched from the Start menu by searching for **Remote Desktop**.

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

## Update the client

Unless disabled by an admin, you'll be notified when a new version of the client is available. This notification may be shown either directly in the Connection Center or in the Windows Action Center. Select the notification to start the update process.

You can also manually search for new updates for the client:

1. From the Connection Center, tap the overflow menu (**...**) on the command bar at the top of the client.
2. Select **About** from the drop-down menu.
3. Tap **Check for updates**.
4. If there's an update available, tap **Install update** to update the client.

## Providing feedback

Have a feature suggestion or want to report an issue? Tell us using the [Feedback Hub](feedback-hub://?tabid=2&contextid=883) which can also be accessed from the client:

1. From the Connection Center, tap the overflow menu (**...**) on the command bar at the top of the client.
2. Select **Feedback** from the drop-down menu to open the Feedback Hub.
