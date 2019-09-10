---
title: Get started with the Windows Desktop client
description: Basic set up steps for the Remote Desktop client for Windows Desktop.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 09/10/2019
ms.localizationpriority: medium
---
# Get started with the Windows Desktop client

>Applies to: Windows 10 and Windows 7

You can use the Remote Desktop client for Windows Desktop to access Windows apps and desktops remotely from a different Windows device.

> [!NOTE]
> - This client currently only supports accessing remote apps and desktops from [Windows Virtual Desktop](https://aka.ms/wvd).
> - Curious about the new releases for the Windows Desktop client? Check out [What's new in the Windows Desktop client](windowsdesktop-whatsnew.md)

## Install the client

You can install the client from the following locations:
[Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2068602)
Windows 32-bit (Coming soon)
Windows on ARM (Coming soon)

The client can be installed for the current user which does not require administrative right or can be installed by an admin so all users on the device can access it.

Once installed, the client can be launched from the Start menu by searching for **Remote Desktop**.

## Feeds

Get the list of managed resources (apps and desktops) available to you by subscribing to the feed provided by your admin. Subscribing makes the resources available on your local PC. The Windows Desktop client currently supports resources published from **Windows Virtual Desktop**. You should normally receive some information from your admin before getting started.

### Subscribe to a feed

1. From the main page of the client (Connection Center), tap **Subscribe**.
2. Sign in with your user account when prompted.
3. The resources will appear in the Connection Center grouped by Workspace.

Once added, you can launch resources by one of two methods.

- From the Connection Center, double-click a resource to launch it.
- Launch a resource as you normally would other apps from the Start Menu. They can be found in a folder with the Workspace name.
  - You can also search for the apps in the search bar.

### Workspace details

After subscribing, you can view additional information about a Workspace by accessing the details panel.

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Select **Details** from the dropdown menu.
3. The Details panel shows up on the right side of the client.

The Details panel contains useful information about the feed:

- The name of the Workspace
- The URL and username used to subscribe
- The number of apps and desktops
- The date/time of the last update
- The status of the last update

Once subscribed, the content of the Workspace is updated automatically on a regular basis. Resources may be added, changed, or removed based on changes made by your admin.

You can also manually look for updates to the resources when needed by selecting **Update now** from the Details panel.

### Unsubscribe from a feed

This section will teach you how to unsubscribe from a feed. You can unsubscribe to either subscribe again with a different account or remove your resources from the system.

1. From the Connection Center, tap the overflow menu (**...**) next to the Workspace.
2. Select **Unsubscribe** from the dropdown menu.
3. Review and select **Continue** from the dialog.

## Update the client

Unless disabled by an admin, you'll be notified when a new version of the client is available. This notification may be shown directly in the Connection Center or in the Windows Action Center. Select the notification to start the update process.

You may also manually look for new updates to the client:

1. From the Connection Center, tap the overflow menu (**...**) in the top right of the client.
2. Select **About** from the dropdown menu.
3. Tap **Check for updates**.
4. If an update is available, tap **Install update** to begin the progress.

> [!TIP]
> Questions and comments are always welcome. However, please do NOT post a request for troubleshooting help by using the comment feature at the end of this article. Have a feature suggestion or want to report an issue? Tell us using the [Feedback Hub](feedback-hub://?tabid=2&contextid=883).
